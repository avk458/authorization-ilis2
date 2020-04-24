<template>
  <div>
    <Card>
      <Button type="primary" @click="handleModal">新增数据库</Button>
      <Divider/>
      <Table border :columns="columns" :data="data" :loading="loading">
        <template slot-scope="{ row }" slot="action">
          <Button type="success" size="small" style="margin-right: 5px" @click="handleInit(row)" :disabled="row.isInitialized">初始化</Button>
          <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)" :disabled="row.isInitialized">编辑</Button>
          <Button type="error" size="small" @click="remove(row)" :disabled="row.isInitialized">删除</Button>
        </template>
      </Table>
    </Card>
    <DatabaseModal ref="databaseModal" @on-success-valid="submit"/>
    <InitializationModal ref="initializationModal"/>
  </div>
</template>
<script>
import { getDatabaseList, deleteDatabaseInfo, updateDatabaseInfo, saveDatabaseInfo } from '@/api/unit-database'
import DatabaseModal from './component/dabase-modal/'
import InitializationModal from './component/initialization-modal/'

export default {
  components: { DatabaseModal, InitializationModal },
  data () {
    return {
      columns: [
        { title: '所属单位', key: 'unitName' },
        { title: '数据库名', key: 'databaseName' },
        { title: 'Host', key: 'host' },
        { title: '端口', key: 'port' },
        { title: '参数', key: 'params', tooltip: true },
        { title: '数据库版本', key: 'databaseVersion' },
        {
          title: '数据库类型',
          key: 'databaseType',
          render: (h, p) => {
            const typeMap = {
              211: 'MySQL',
              222: 'Postgre SQL',
              233: 'Microsoft SQL Server'
            }
            const type = p.row.databaseType
            return h('span', typeMap[type])
          }
        },
        {
          title: '是否初始化',
          key: 'isInitialized',
          render: (h, p) => {
            const isInit = p.row.isInitialized
            return h('div', [
              h('Icon', {
                props: {
                  type: isInit ? 'md-checkmark-circle-outline' : 'md-close-circle',
                  color: isInit ? 'green' : 'red'
                }
              }),
              h('span', ' '),
              h('span', isInit ? '已初始化' : '未初始化')
            ])
          }
        },
        {
          title: '上一次修改人员',
          key: 'createBy',
          render: (h, p) => {
            const row = p.row
            const person = row.updateBy ? row.updateBy : row.createBy
            return h('span', person)
          }
        },
        { title: '操作', slot: 'action', align: 'center', width: 200 }
      ],
      data: [],
      loading: false
    }
  },
  methods: {
    async fetchData() {
      this.loading = true
      getDatabaseList().then(res => {
        this.data = res.data
        this.loading = false
      })
    },
    handleModal() {
      this.$refs.databaseModal.showModal()
    },
    edit(row) {
      const data = {}
      Object.assign(data, row)
      this.$refs.databaseModal.showModal(data)
    },
    async remove(val) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除：${val.databaseName}吗？`,
        onOk: () => {
          deleteDatabaseInfo(val.id).then(res => this.$Message.success(res.message))
          this.fetchData()
        }
      })
    },
    submit(data) {
      if (data.id) {
        updateDatabaseInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
        })
      } else {
        saveDatabaseInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
        })
      }
    },
    handleInit(val) {
      this.$refs.initializationModal.showModal()
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
