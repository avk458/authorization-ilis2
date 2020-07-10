<template>
  <Card dis-hover>
    <Table :data="data" :loading="loading" :columns="columns" border>
      <template slot-scope="{ row }" slot="action">
        <Button size="small" type="info" @click="handleLog(row)">登录日志</Button>
      </template>
    </Table>
    <login-log-modal ref="loginLog"/>
  </Card>
</template>
<script>
import LoginLogModal from './components/login-log-modal'
import { getUnitAccount } from '@/api/unit'

export default {
  components: { LoginLogModal },
  data() {
    return {
      data: [],
      columns: [
        { title: '单位名称', key: 'unitName' },
        { title: '可用用户数', key: 'maxAccount' },
        { title: '累计用户数', key: 'totalAccount' },
        { title: '可用在线用户数', key: 'maxOnlineAccount' },
        { title: '当前在线用户数', key: 'onlineAccount' },
        { title: '操作', slot: 'action' }
      ],
      loading: false
    }
  },
  methods: {
    fetchData() {
      getUnitAccount().then(res => {
        this.data = res.data
      })
    },
    handleLog(row) {
      this.$refs.loginLog.showModal(row.unitCode)
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
