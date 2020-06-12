<template>
  <Modal v-model="logVisible" title="数据库升级">
    <div v-if="!updated">
      <p>数据库：{{ unitDb.databaseName }}当前数据版本为：v{{ unitDb.dataVersion }}</p>
      <p>您确定要升级至最新版吗？</p>
    </div>
    <div v-else>
      <Table ref="logTable" :data="logs" :columns="columns" :stripe="true" :show-header="false" :max-height="400" size="small" no-data-text="暂无更新版本"/>
    </div>
    <div slot="footer">
      <Button :type="btnType" :loading="btnLoading" :long="logs.length === 0" @click="handleUpdate">{{ btn }}</Button>
      <Button v-if="logs.length > 0" @click="exportLog">导出升级日志</Button>
    </div>
  </Modal>
</template>

<script>
import { updateDatabase } from '@/api/unit-database'

export default {
  name: 'update-echo-log',
  props: {
    unitDb: {
      required: true,
      type: Object
    }
  },
  data() {
    return {
      logVisible: false,
      logs: [],
      btn: '开始升级',
      btnType: 'primary',
      btnLoading: false,
      updated: false,
      columns: [
        { type: 'index', width: 30 },
        {
          key: 'success',
          render: (h, p) => {
            const suc = p.row.success
            return h('Icon', {
              props: {
                type: suc ? 'md-checkmark' : 'md-close',
                color: suc ? 'green' : 'red',
                size: 16
              }
            })
          },
          width: 30
        },
        { key: 'sqlScript', tooltip: true },
        { key: 'msg', tooltip: true }
      ]
    }
  },
  methods: {
    showModal() {
      this.logVisible = true
    },
    handleUpdate() {
      if (this.updated) {
        this.handleClose()
        return
      }
      this.btnLoading = true
      this.updated = true
      updateDatabase(this.unitDb.id)
        .then(res => {
          this.logs = res.data
          this.btn = this.executeFailed ? '升级出错啦，要扣绩效噢' : '升级成功，关闭'
          this.btnType = this.executeFailed ? 'error' : 'success'
          this.btnLoading = false
          this.$emit('success-update')
        })
        .catch(() => {
          this.btn = '关闭'
          this.btnType = 'error'
          this.btnLoading = false
        })
    },
    handleClose() {
      this.updated = false
      this.btn = '开始升级'
      this.btnType = 'primary'
      this.btnLoading = false
      this.logs = []
      this.logVisible = false
    },
    exportLog() {
      this.$refs.logTable.exportCsv({
        filename: 'update-log.csv',
        noHeader: true
      })
    }
  },
  computed: {
    executeFailed() {
      return this.logs.find(l => !l.success)
    }
  }
}
</script>

<style scoped>

</style>
