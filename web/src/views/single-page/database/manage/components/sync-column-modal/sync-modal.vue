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
        <p class="sync-label">Main Profile:</p>
        <Select style="margin-bottom: 20px" v-model="mainProfile" @on-change="handelMainProfileChange">
          <Option v-for="p in mainProfiles" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
        </Select>
        <p class="sync-label">Source Schema:</p>
        <div class="source-box">
          <RadioGroup v-model="sourceSchema" vertical>
            <Radio style="margin-top: 2px" v-for="s in sourceSchemas"
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
        <div style="width: 260px">
          <p class="sync-label">Target Profile:</p>
          <Select style="margin-bottom: 20px" v-model="targetProfile" @on-change="handelTargetProfileChange">
            <Option v-for="p in targetProfiles" :key="p.id" :value="p.id">{{ p.profileName }}</Option>
          </Select>
        </div>
        <p class="sync-label">Target Schema:</p>
        <Transfer
          :titles="['Unit Schema', 'Waiting List']"
          :list-style="listStyle"
          :data="targetSchemas"
          :target-keys="targetKeys"
          :render-format="transferRender"
          :not-found-text="'No data'"
          @on-change="handleTransferChange">
        </Transfer>
      </div>
    </div>
    <div slot="footer">
      <Button :type="btnType" size="large" :loading="btnLoading" long @click="doTheMagic">{{ btn }}</Button>
    </div>
  </Modal>
</template>

<script>
import { getMainProfiles, getTargetProfiles, getMainSourceSchemas, getTargetSourceSchemas } from '@/api/config'
import { syncSchemaColumns } from '@/api/data'

export default {
  name: 'sync-modal',
  data() {
    return {
      visible: false,
      mainProfile: '',
      targetProfile: '',
      mainProfiles: [],
      targetProfiles: [],
      sourceSchema: '',
      sourceSchemas: [],
      targetSchemas: [],
      targetKeys: [],
      listStyle: {
        width: '250px',
        height: '300px'
      },
      btnLoading: false,
      btnType: 'warning',
      btn: 'Run'
    }
  },
  methods: {
    async fetchData() {
      await this.handelConfigRequest()
      this.handelMainSchemasRequest(this.mainProfile)
    },
    async handelConfigRequest() {
      const mains = await getMainProfiles()
      const targets = await getTargetProfiles()
      this.mainProfiles = mains.data
      this.targetProfiles = targets.data
      this.mainProfile = this.mainProfiles.find(p => p.active).id
    },
    handelMainSchemasRequest(mainProfileId) {
      getMainSourceSchemas(mainProfileId).then(res => {
        this.sourceSchemas = res.data
      }).catch(() => {
        this.sourceSchemas = []
      })
    },
    showModal() {
      this.visible = true
      this.fetchData()
    },
    handelCancel(visible) {
      if (!visible) {
        this.visible = visible
        this.btn = 'Run'
        this.btnType = 'warning'
        this.btnLoading = false
      }
    },
    transferRender(item) {
      return item.label
    },
    handleTransferChange(newTargetKeys) {
      this.targetKeys = newTargetKeys
    },
    handelMainProfileChange(val) {
      this.handelMainSchemasRequest(val)
    },
    handelTargetProfileChange(val) {
      getTargetSourceSchemas(val).then(res => {
        this.targetSchemas = res.data
      })
    },
    doTheMagic() {
      if (this.btnType === 'success') {
        this.handelCancel(false)
        return
      }
      if (this.btnType === 'error') {
        this.btnType = 'info'
      }
      const source = this.sourceSchema
      const target = this.targetKeys.join(',')
      if (source === target) {
        this.$Message.warning('您选择了相同的schema')
        return
      }
      this.btnLoading = true
      this.btn = 'Processing'
      const req = {
        mainProfileId: this.mainProfile,
        targetProfileId: this.targetProfile,
        sourceSchema: this.sourceSchema,
        targetSchemas: target
      }
      syncSchemaColumns(req)
        .then(res => {
          this.btnLoading = false
          this.btnType = 'success'
          this.btn = 'Done'
        })
        .catch(err => {
          this.btnLoading = false
          this.btnType = 'error'
          this.btn = 'Retry'
          this.$Notice.error({
            desc: err.data.message,
            duration: 0
          })
        })
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
</style>
