<template>
  <Modal :title="title" v-model="visible" width="70%">
    <Table :data="data" :columns="columns" border :loading="loading"/>
    <div class="pagination" v-if="total > 10">
      <Page
        :total="total"
        :current.sync="params.current"
        :page-size.sync="params.size"
        show-sizer
        @on-page-size-change="handleSizeChange"
        @on-change="handlePageChange"
      />
    </div>
  </Modal>
</template>

<script>
import { getAccountLoginLogs, getOnlineSessions } from '@/api/unit'

export default {
  name: 'login-log-modal',
  data() {
    const OPERATION_TYPE = {
      100: '登录',
      110: '登出',
      120: '被下线',
      130: '会话到期'
    }
    return {
      visible: false,
      data: [],
      columns: [
        { title: '用户名', key: 'username', width: 120 },
        { title: '用户', key: 'realName', width: 120 },
        { title: 'SessionId', key: 'sessionId' },
        { title: 'IP', key: 'loginIp', width: 120 },
        { title: 'IP地址', key: 'loginRegion' },
        { title: '操作系统', key: 'os' },
        { title: '浏览器', key: 'browser' },
        { title: '操作时间', key: 'operationTime', width: 170 },
        {
          title: '类型',
          key: 'operationType',
          width: 100,
          render: (h, p) => {
            return h('span', OPERATION_TYPE[p.row.operationType])
          }
        }
      ],
      loading: false,
      params: {
        current: 1,
        size: 10
      },
      total: 0,
      unitCode: '',
      userId: '',
      title: '',
      sessionIds: ''
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      switch (this.type) {
      case 'logs':
        getAccountLoginLogs(this.unitCode, this.userId, this.params).then(res => {
          this.data = res.data.records
          this.total = res.data.total
          this.loading = false
        })
        break
      case 'sessions':
        this.params.sessionIds = this.sessionIds
        getOnlineSessions(this.unitCode, this.userId, this.params).then(res => {
          this.data = res.data.records
          this.total = res.data.total
          this.loading = false
          this.title = '在线会话'
        })
        break
      }
    },
    showModal(row, unitCode, type) {
      this.type = type
      this.visible = true
      this.unitCode = unitCode
      this.userId = row.userId
      this.sessionIds = Object.keys(row.sessions).join(',')
      this.fetchData()
    },
    handleSizeChange(size) {
      this.params.size = size
      this.fetchData()
    },
    handlePageChange(current) {
      this.params.current = current
      this.fetchData()
    }
  }
}
</script>

<style scoped>
.pagination{
  margin-top: 20px;
  text-align: right;
}
</style>
