import { initUnitDatabase } from '@/api/unit-database'
import config from '@/config'
import { getToken } from '@/libs/util'
import { getLastId } from '@/api/script'

export default {
  methods: {
    initDatabase(val, callback) {
      this.$Notice.info({
        title: '提示',
        desc: `正在初始化${val.unitName}数据库，请稍候`
      })
      initUnitDatabase(val.id).then(res => {
        this.$Notice.success({
          title: '初始化数据库',
          desc: '成功！'
        })
        if (callback) {
          callback()
        }
      }).catch(() => {
        this.$Notice.error({
          title: '失败',
          desc: '初始化数据库失败'
        })
      })
    },
    async handleExportDataScript() {
      const baseUrl = !this.prod ? config.baseUrl.dev : config.baseUrl.pro
      this.$axios.get(baseUrl + 'script/actions/export', {
        headers: {
          Authorization: 'Bearer ' + getToken()
        }
      })
        .then(res => {
          const fileName = res.headers['content-disposition']
          const url = window.URL.createObjectURL(new Blob([res.data]))
          const link = document.createElement('a')
          link.href = url
          link.setAttribute('download', fileName)
          document.body.appendChild(link)
          link.click()
        })
        .catch(() => {
          this.$Message.error('导出失败')
        })
    },
    handleUpload (file) {
      this.upload(file)
      return false
    },
    async upload(file) {
      const reg = /\d{3}\.sql$/
      const name = file.name
      let msg
      if (reg.test(name)) {
        const uploadVersion = this.getUploadVersion(name)
        const currentVersion = await this.getCurrentVersion()
        msg = `当前数据版本为：${currentVersion}， 你确定要将数据脚本升级至：${uploadVersion}吗？`
      } else {
        msg = '好像您导入的文件不是默认的导出文件，你确定要继续这个操作吗？'
      }
      this.$Modal.confirm({
        title: '确认',
        content: msg,
        onOk: () => {
          this.$refs.upload.post(file)
        }
      })
    },
    getUploadVersion(name) {
      return 'v.' + name.substring(0, name.indexOf('.'))
    },
    async getCurrentVersion() {
      const res = await getLastId()
      return 'v.' + res.data
    }
  }
}
