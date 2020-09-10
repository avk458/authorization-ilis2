<template>
  <Modal :title="title" v-model="visible" width="70%">
    <Table :data="data" :columns="columns" border :loading="loading">
      <template slot-scope="{ row }" slot="action">
        <Button size="small" type="success" @click="handleLog(row, 'sessions')" :disabled="!row.online">查看在线会话</Button>
        <Divider type="vertical"/>
        <Button size="small" @click="handleLog(row, 'logs')">登录日志</Button>
      </template>
    </Table>
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
    <login-log-modal ref="loginLog"/>
  </Modal>
</template>

<script>
import LoginLogModal from './login-log-modal'
import { getUnitTotalAccounts } from '@/api/unit'

export default {
  name: 'unit-accounts',
  components: { LoginLogModal },
  data() {
    return {
      visible: false,
      title: '',
      data: [],
      columns: [
        {
          title: 'ID',
          key: 'userId',
          width: 120,
          render: (h, p) => {
            return h('Tag', {
              props: {
                color: 'default'
              }
            }, '# ' + this.hash(p.row.userId))
          }
        },
        { title: '用户名', key: 'username', width: 120 },
        { title: '用户', key: 'realName', width: 120 },
        { title: '最近在线时间', key: 'lastOperations' },
        {
          title: '当前是否在线',
          render: (h, p) => {
            const online = p.row.online
            const color = online ? 'success' : 'default'
            const text = online ? '在线' : '离线'
            return h('Tag', {
              props: {
                type: 'dot',
                color: color
              }
            }, text)
          }
        },
        {
          title: '在线会话数量',
          key: 'sessions',
          render: (h, p) => {
            const sessions = p.row.sessions
            const count = Object.keys(sessions).length
            return h('Poptip', {
              props: {
                trigger: 'hover',
                title: '在线会话明细',
                placement: 'bottom',
                transfer: true
              }
            }, [
              h('Tag', { props: { color: 'green' } }, count),
              h('div', {
                slot: 'content'
              },
              [
                h('table', {
                  class: 'tip-table'
                }, [
                  h('thead', [h('tr', [h('th', 'SessionId'), h('th', '最近活跃时间')])]),
                  h('tbody', Object.keys(sessions).map(key => {
                    return h('tr', [h('td', key), h('td', sessions[key])])
                  }))
                ])
              ])
            ])
          }
        },
        {
          title: '登录次数',
          key: 'loginTimes',
          render: (h, p) => {
            return h('Tag', {
              props: {
                color: 'primary'
              }
            }, p.row.loginTimes)
          }
        },
        { title: '操作', slot: 'action', width: 240 }
      ],
      loading: false,
      params: {
        current: 1,
        size: 10
      },
      total: 0,
      unitCode: ''
    }
  },
  methods: {
    showModal(row) {
      this.visible = true
      this.title = row.unitName + '用户明细'
      this.unitCode = row.unitCode
      this.fetchData()
    },
    handleLog(row, type) {
      this.$refs.loginLog.showModal(row, this.unitCode, type)
    },
    fetchData() {
      this.loading = true
      getUnitTotalAccounts(this.unitCode, this.params).then(res => {
        this.data = res.data.records
        this.total = res.data.total
        this.loading = false
      })
    },
    handleSizeChange(size) {
      this.params.size = size
      this.fetchData()
    },
    handlePageChange(current) {
      this.params.current = current
      this.fetchData()
    },
    hash(text) {
      let hash = 5381
      let index = text.length

      while (index) {
        hash = (hash * 33) ^ text.charCodeAt(--index)
      }

      return hash >>> 0
    }
  }
}
</script>

<style>
.tip-table
{
  font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
  font-size: 12px;
  background: #fff;
  width: 480px;
  border-collapse: collapse;
  text-align: left;
  margin-bottom: 10px;
  border-top: solid 1px #e2e2e2;
  border-left: solid 1px #e2e2e2;
  color: #5c6b77;
}
.tip-table th
{
  font-size: 14px;
  padding: 8px 16px;
  border-bottom: 1px solid #e2e2e2;
  border-right: 1px solid #e2e2e2;
  background: #f7f7f7;
  font-weight: bold;
}
.tip-table td
{
  border-bottom: 1px solid #e2e2e2;
  padding: 8px 16px;
  border-right: solid 1px #e2e2e2;
}
</style>

<style scoped>
.pagination{
  margin-top: 20px;
  text-align: right;
}
</style>
