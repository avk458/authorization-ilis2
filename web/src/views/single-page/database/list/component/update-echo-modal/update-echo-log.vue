<template>
  <Modal v-model="logVisible" title="数据库升级" width="60%">
    <div v-if="!updated">
      <p>数据库：{{ unitDb.databaseName }}当前数据版本为：v.{{ unitDb.dataVersion || 0 }}</p>
      <p>您确定要升级至最新版吗？</p>
    </div>
    <div v-else>
      <Table ref="logTable" :data="logs" :columns="columns" :stripe="true" :max-height="400" size="small" no-data-text="暂无更新版本"/>
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
        { title: '版本号', key: 'scriptVersion', width: 80, align: 'center' },
        { title: '所属单位', key: 'unitName', width: 150 },
        {
          title: '执行结果',
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
          align: 'center',
          width: 100
        },
        { title: '脚本', key: 'sqlScript', tooltip: true },
        { title: '错误日志', key: 'msg', tooltip: true }
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
          this.handleBtn()
          this.$emit('success-update')
        })
        .catch(err => {
          this.handleBtn(err)
        })
    },
    handleBtn(err) {
      if (err) {
        this.btn = '关闭'
        this.btnType = 'error'
        this.btnLoading = false
      } else {
        this.btn = this.executeFailed ? '升级出错啦，要扣绩效噢' : '升级成功，关闭'
        this.btnType = this.executeFailed ? 'error' : 'success'
        this.btnLoading = false
      }
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
