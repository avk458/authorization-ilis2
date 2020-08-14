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
import { getUnitLoginLog, getOnlineAccounts } from '@/api/unit'

export default {
  name: 'login-log-modal',
  data() {
    return {
      visible: false,
      data: [],
      columns: [
        { title: '用户名', key: 'username', width: 120 },
        { title: '用户', key: 'realName', width: 120 },
        { title: 'SessionId', key: 'sessionId', width: 310 },
        { title: 'IP', key: 'loginIp' },
        { title: 'IP地址', key: 'loginRegion' },
        {
          render: (h, p) => {
            p.column.title = this.type === 'total' ? '操作时间' : '最近在线时间'
            return h('span', p.row.operationTime)
          }
        },
        { title: '类型', key: 'remark', width: 130 }
      ],
      loading: false,
      params: {
        current: 1,
        size: 10
      },
      total: 0,
      unitCode: '',
      type: '',
      title: ''
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      switch (this.type) {
      case 'total':
        getUnitLoginLog(this.unitCode, this.params).then(res => {
          this.data = res.data.records
          this.total = res.data.total
          this.loading = false
          this.title = '登录日志'
        })
        break
      case 'online':
        getOnlineAccounts(this.unitCode, this.params).then(res => {
          this.data = res.data.records
          this.total = res.data.total
          this.loading = false
          this.title = '在线用户'
        })
        break
      }
    },
    showModal(unitCode, type) {
      this.visible = true
      this.unitCode = unitCode
      this.type = type
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
