<template>
  <div>
    <Card dis-hover>
      <Button type="primary" @click="handleModal" disabled>新增数据库</Button>
      <Divider type="vertical" />
      <Button type="success" @click="handleScriptModal">提交脚本</Button>
      <Divider type="vertical"/>
      <Button type="warning" @click="handleBatchUpdate">批量升级</Button>
      <Divider/>
      <Table border :columns="columns" :data="data" :loading="loading">
        <template slot-scope="{ row }" slot="action">
          <Button type="info" size="small" style="margin-right: 5px" @click="update(row)" :disabled="!row.manageAble">升级</Button>
          <Button type="success" size="small" style="margin-right: 5px" @click="handleInit(row)" :disabled="row.isInitialized || !row.manageAble">初始化</Button>
          <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
          <Button type="error" size="small" @click="remove(row)" :disabled="row.isInitialized">删除</Button>
        </template>
      </Table>
    </Card>
    <DatabaseModal ref="databaseModal" @on-success-valid="submit"/>
<!--    <InitializationModal ref="initializationModal" @success-init="fetchData"/>-->
    <update-echo-log ref="updateEchoLog" :unit-db="unitDb" @success-update="fetchData"/>
    <script-modal ref="scriptModal"/>
  </div>
</template>
<script>
import {
  getDatabaseList,
  deleteDatabaseInfo,
  updateDatabaseInfo,
  saveDatabaseInfo,
  batchUpdateDatabase
} from '@/api/unit-database'
import DatabaseModal from './component/database-modal/'
import UpdateEchoLog from './component/update-echo-modal'
import ScriptModal from '@/views/single-page/database/script/components/script'
import InitMixin from '@/mixins/mixin'

export default {
  components: { DatabaseModal, UpdateEchoLog, ScriptModal },
  mixins: [InitMixin],
  data () {
    return {
      columns: [
        { title: '所属单位', key: 'unitName', width: 150 },
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
          title: '数据版本',
          key: 'dataVersion',
          render: (h, p) => {
            const ver = p.row.dataVersion || 0
            return h('Tag', {
              props: {
                color: 'blue'
              }
            }, 'v.' + ver)
          }
        },
        {
          title: '可否管理',
          render: (h, p) => {
            const m = p.row.manageAble
            return h('Icon', {
              props: {
                type: m ? 'md-checkmark-circle' : 'md-close-circle',
                color: m ? 'green' : 'red'
              }
            })
          },
          align: 'center',
          width: 95
        },
        {
          title: '上一次修改人员',
          key: 'createBy',
          render: (h, p) => {
            const row = p.row
            const person = row.updateBy ? row.updateBy : row.createBy
            return h('span', person)
          },
          width: 150
        },
        { title: '操作', slot: 'action', align: 'center', width: 250 }
      ],
      data: [],
      loading: false,
      unitDb: {}
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
      const data = { ...row }
      this.$refs.databaseModal.showModal(data)
    },
    async remove(val) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除：${val.databaseName}吗？`,
        onOk: () => {
          deleteDatabaseInfo(val.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    submit(data) {
      if (data.id) {
        updateDatabaseInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.databaseModal.handleCancel()
        })
      } else {
        saveDatabaseInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.databaseModal.handleCancel()
        })
      }
    },
    handleInit(val) {
      this.initDatabase(val, this.fetchData)
    },
    update(row) {
      this.$refs.updateEchoLog.showModal()
      this.unitDb = row
    },
    handleScriptModal() {
      this.$refs.scriptModal.showModal()
    },
    handleBatchUpdate() {
      this.$Modal.confirm({
        title: '批量升级确认',
        content: '您确定要将所有能管理的单位数据库都升级到最新版本吗？',
        onOk: () => {
          batchUpdateDatabase().then(res => {
            this.$Message.success('完成批量更新数据库')
            this.fetchData()
            this.$refs.updateEchoLog.updated = true
            this.$refs.updateEchoLog.logs = res.data
            this.$refs.updateEchoLog.handleBtn()
            this.$refs.updateEchoLog.showModal()
          })
        }
      })
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
