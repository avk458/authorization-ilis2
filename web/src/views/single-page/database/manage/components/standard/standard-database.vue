<template>
  <Modal title="标准库维护" v-model="standardVisible">
    <div>
      <Row :gutter="15">
        <Col span="10">
          <label>
            配置：
            <Select style="margin-bottom: 20px" v-model="selectedProfile" @on-change="handelConfigChange">
              <Option v-for="p in profileList" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
            </Select>
          </label>
        </Col>
        <Col span="10">
          <label>
            标准库：
            <Select style="margin-bottom: 20px" v-model="selectSchema" @on-change="handelSchemaChange">
              <Option v-for="s in schemaList" :key="s.key" :value="s.key">{{ s.label }}</Option>
            </Select>
          </label>
        </Col>
        <Col span="4">
          <Button type="warning" shape="circle" style="margin-top: 22px" :disabled="applyBtn" @click="handelApplyStandardDatabase">应用</Button>
        </Col>
      </Row>
      <Row :gutter="15">
        <Col span="20">
          <label>
            数据中心模板名称：
            <Select style="margin-bottom: 20px" v-model="selectedProfile" @on-change="handelConfigChange">
              <Option v-for="p in profileList" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
            </Select>
          </label>
        </Col>
        <Col span="4">
          <Button type="info" shape="circle" style="margin-top: 22px" :disabled="applyBtn" @click="handelApplyStandardDatabase">引入</Button>
        </Col>
      </Row>
      <Row :gutter="15">
        <Col span="20">
          <Upload
            multiple
            type="drag"
            action="//jsonplaceholder.typicode.com/posts/">
            <div style="padding: 20px 0">
              <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
              <p>点击或者拖入您要上传的文件</p>
            </div>
          </Upload>
        </Col>
        <Col span="4">
          <Button shape="circle" style="margin-top: 22px" :disabled="applyBtn" @click="handelApplyStandardDatabase">导入</Button>
        </Col>
      </Row>
      <Row :gutter="15">
        <Col span="20">
          <label>
            选择需要初始化数据的表：
            <Select style="margin-bottom: 20px" v-model="selectedProfile" @on-change="handelConfigChange">
              <Option v-for="p in profileList" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
            </Select>
          </label>
        </Col>
        <Col span="4">
          <Button type="primary" shape="circle" style="margin-top: 22px" :disabled="applyBtn" @click="handelApplyStandardDatabase">应用</Button>
        </Col>
      </Row>
      <Row :gutter="15">
        <Col span="20">
          <label>
            Console
            <Input v-model="script" type="textarea" :rows="4" placeholder="如需手动执行某些操作，请输入需要执行的语句，注意去掉schema" />
          </label>
        </Col>
        <Col span="4">
          <Button type="success" shape="circle" style="margin-top: 22px" :disabled="applyBtn" @click="handelApplyStandardDatabase">运行</Button>
        </Col>
      </Row>
    </div>
  </Modal>
</template>

<script>
import { getMainProfiles } from '@/api/config'
import { getStandardSchemaViaConfigId } from '@/api/data'

export default {
  name: 'standard-database',
  data() {
    return {
      standardVisible: false,
      profileList: [],
      selectedProfile: '',
      schemaList: [],
      selectSchema: '',
      standardSchema: null,
      script: ''
    }
  },
  methods: {
    async fetchData() {
      await this.handelConfigRequest()
      this.handleSchemaRequest(this.selectedProfile)
      getStandardSchemaViaConfigId(this.selectedProfile).then(res => {
        this.selectSchema = res.data
      })
    },
    async handelConfigRequest() {
      const res = await getMainProfiles()
      this.profileList = res.data
      this.selectedProfile = this.profileList.find(p => p.active).id
    },
    handleSchemaRequest(val) {
    },
    handelConfigChange(val) {
      this.handleSchemaRequest(val)
    },
    showModal() {
      this.standardVisible = true
      this.fetchData()
    },
    handelApplyStandardDatabase() {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要将：${this.selectSchema} 设置为标准库吗？`,
        onOk: () => {
          this.$Message.success('send request')
        }
      })
    },
    handelSchemaChange(val) {
      this.selectSchema = val
    }
  },
  computed: {
    applyBtn() {
      return this.standardSchema && this.standardSchema !== this.selectSchema
    }
  }
}
</script>

<style scoped>

</style>
