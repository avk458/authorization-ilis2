<template>
  <Modal v-model="logVisible" title="数据库升级日志" width="60%">
    <div>
      <Table ref="logTable" :data="logs" :columns="columns" :stripe="true" :max-height="400" size="small" no-data-text="暂无升级日志"/>
    </div>
    <div slot="footer">
      <Button :type="btnType" @click="handleClose">{{ btn }}</Button>
      <Button v-if="logs.length > 0" @click="exportLog">导出升级日志</Button>
    </div>
  </Modal>
</template>

<script>

export default {
  name: 'update-echo-log',
  data() {
    return {
      logVisible: false,
      logs: [],
      btn: '',
      btnType: 'primary',
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
    showModal(logs) {
      this.logVisible = true
      this.logs = logs
      this.handleBtn()
    },
    handleBtn() {
      this.btn = this.executeFailed ? '升级过程中遇到错误，请注意检查' : '升级成功，关闭'
      this.btnType = this.executeFailed ? 'warning' : 'success'
    },
    handleClose() {
      this.updated = false
      this.btn = ''
      this.btnType = 'primary'
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
