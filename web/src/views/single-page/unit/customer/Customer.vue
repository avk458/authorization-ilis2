<template>
  <Card dis-hover>
    <Table :data="data" :loading="loading" :columns="columns" border>
      <template slot-scope="{ row }" slot="action">
<!--        <Button size="small" type="info" @click="handleLog(row, 'total')">登录日志</Button>-->
<!--        <Divider type="vertical"/>-->
<!--        <Button size="small" type="success" @click="handleLog(row, 'online')">在线用户</Button>-->
        <Button size="small" type="info" @click="handleUnitAccounts(row)">查看用户</Button>
      </template>
    </Table>
    <unit-accounts ref="unitAccounts"/>
  </Card>
</template>
<script>

import { getUnitAccount } from '@/api/unit'
import UnitAccounts from '@/views/single-page/unit/customer/components/unit-accounts'

export default {
  components: { UnitAccounts },
  data() {
    return {
      data: [],
      columns: [
        { title: '单位名称', key: 'unitName' },
        { title: '可用用户数', key: 'maxAccount' },
        { title: '累计用户数', key: 'totalAccount' },
        { title: '可用在线会话数', key: 'maxOnlineAccount' },
        { title: '当前在线会话数', key: 'onlineAccount' },
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
    handleLog(row, type) {
      this.$refs.loginLog.showModal(row.unitCode, type)
    },
    handleUnitAccounts(row) {
      this.$refs.unitAccounts.showModal(row)
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
