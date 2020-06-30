import { initUnitDatabase } from '@/api/unit-database'

export default {
  methods: {
    initDatabase(val) {
      this.$Notice.info({
        title: '提示',
        desc: `正在初始化${val.unitName}数据库，请稍候`
      })
      initUnitDatabase(val.id).then(res => {
        this.$Notice.success({
          title: '初始化数据库',
          desc: '成功！'
        })
      }).catch(() => {
        this.$Notice.error({
          title: '失败',
          desc: '初始化数据库失败'
        })
      })
    }
  }
}
