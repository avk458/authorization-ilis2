import { initUnitDatabase } from '@/api/unit-database'
import config from '@/config'
import { getToken } from '@/libs/util'

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
    }
  }
}
