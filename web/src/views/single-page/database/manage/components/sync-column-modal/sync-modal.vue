<template>
  <Modal title="Synchronizer" v-model="visible" @on-visible-change="handelCancel" width="860">
    <Alert type="warning" show-icon closable>
      Warning
      <template slot="desc">
        Although this operation will back up the database, it is still recommended not to use this feature during peak user periods.
      </template>
    </Alert>
    <div class="sync-box">
      <div class="left-panel">
        <p class="sync-label">Profile:</p>
        <Select style="margin-bottom: 20px" v-model="selectedProfile" @on-change="handelConfigChange">
          <Option v-for="p in profileList" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
        </Select>
        <p class="sync-label">Source Schema:</p>
        <div class="source-box">
          <RadioGroup v-model="sourceSchema" vertical>
            <Radio style="margin-top: 2px" v-for="s in sourceSchemaList"
                   :key="s.key"
                   :value="s.label"
                   :label="s.label"
                   :disabled="s.disabled"
                   border>
            </Radio>
          </RadioGroup>
        </div>
      </div>
      <div class="right-panel">
        <p class="sync-label">Target Schema:</p>
        <Transfer
          :titles="['Unit Schema', 'Waiting List']"
          :list-style="listStyle"
          :data="targetList"
          :target-keys="targetKeys"
          :render-format="transferRender"
          :not-found-text="'No data'"
          @on-change="handleTransferChange">
        </Transfer>
      </div>
    </div>
    <div slot="footer">
      <Button type="warning" size="large" long @click="doTheMagic">Run</Button>
    </div>
  </Modal>
</template>

<script>
import { getInitConfigList } from '@/api/config'
import { getSchemaList } from '@/api/data'

export default {
  name: 'sync-modal',
  data() {
    return {
      visible: false,
      selectedProfile: '',
      profileList: [],
      sourceSchema: '',
      sourceSchemaList: [],
      targetList: [],
      targetKeys: [],
      listStyle: {
        width: '250px',
        height: '370px'
      }
    }
  },
  methods: {
    async fetchData() {
      await this.handelConfigRequest()
      this.handleSchemaRequest(this.selectedProfile)
    },
    async handelConfigRequest() {
      const res = await getInitConfigList()
      this.profileList = res.data
      this.selectedProfile = this.profileList.find(p => p.active).id
    },
    handleSchemaRequest(val) {
      getSchemaList(val).then(res => {
        this.sourceSchemaList = res.data.find(s => s.schemaType === 'source').schemaList
        this.targetList = res.data.find(s => s.schemaType === 'target').schemaList
      }).catch(() => {
        this.sourceSchemaList = []
        this.targetList = []
        this.targetKeys = []
      })
    },
    showModal() {
      this.visible = true
      this.fetchData()
    },
    handelCancel(visible) {
      if (!visible) {
        this.visible = visible
      }
    },
    transferRender(item) {
      return item.label
    },
    handleTransferChange(newTargetKeys) {
      this.targetKeys = newTargetKeys
    },
    handelConfigChange(val) {
      this.handleSchemaRequest(val)
    },
    doTheMagic() {
      const source = this.sourceSchema
      const target = this.targetKeys.join(',')
      if (source === target) {
        this.$Message.warning('您选择了相同的schema')
        return
      }

    }
  }
}
</script>

<style scoped>
.sync-box{
  height: 400px;
  position: relative;
}
.left-panel{
  width: 260px;
  height: 400px;
  float: left;
  padding-right: 10px;
}
.right-panel{
  overflow: hidden;
  height: 400px;
}
.source-box{
  padding: 0 0 0 5px;
  overflow: auto;
  height: 300px;
}
.source-box::-webkit-scrollbar {
  width: 8px;
  background-color: #eee;
}
.source-box::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color: #eee;
}

.source-box::-webkit-scrollbar-thumb {
  background: #3d3838;
  border-radius: 10px;
}
.sync-label{
  font-size: 16px;
  font-weight: bold;
}
.ivu-transfer::-webkit-scrollbar {
  width: 8px!important;
  background-color: #eee!important;
}
.ivu-transfer::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color: #eee;
}

.ivu-transfer::-webkit-scrollbar-thumb {
  background: #3d3838;
  border-radius: 10px;
}
</style>
