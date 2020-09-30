<template>
 <Card dis-hover>
   <Row :gutter="16"  justify="start">
     <Col span="2">
       <Button type="success" @click="handleScriptModal">提交脚本</Button>
     </Col>
     <Col span="2">
       <Button v-if="!prod" type="info" @click="handleExportDataScript">导出数据库脚本</Button>
     </Col>
     <Col span="2">
       <Upload
         v-if="prod"
         ref="upload"
         accept=".sql"
         :headers="header"
         :show-upload-list="false"
         :before-upload="handleUpload"
         :on-success="handleSuccess"
         :action="action">
         <Button>导入数据库脚本</Button>
       </Upload>
     </Col>
   </Row>
   <Divider/>
   <Table border :data="data" :columns="columns" :draggable="true" @on-drag-drop="handleDrag">
     <template slot-scope="{ row }" slot="action">
       <Button size="small" type="primary" style="margin-right: 4px" @click="edit(row)">编辑</Button>
       <Button size="small" type="error" @click="remove(row)">删除</Button>
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
   <script-modal ref="scriptModal" @success-submit="fetchData"/>
 </Card>
</template>

<script>
import { getScripts, deleteScript, changeScript } from '@/api/script'
import ScriptModal from './components/script/'
import mixin from '@/mixins/mixin'
import config from '@/config'
import { getToken } from '@/libs/util'

export default {
  name: 'ScriptManage',
  components: { ScriptModal },
  mixins: [mixin],
  data() {
    return {
      data: [],
      columns: [
        { title: 'ID', key: 'id', width: 60 },
        { title: '创建人', key: 'createName', width: 80 },
        {
          title: '最近修改',
          width: 95,
          render: (h, p) => {
            const value = p.row.updateName || p.row.createName
            return h('span', value)
          }
        },
        {
          title: '最近修改时间',
          width: 168,
          render: (h, p) => {
            const value = p.row.updateTime || p.row.createTime
            return h('span', value)
          }
        },
        { title: '类型', key: 'type', width: 70 },
        { title: 'Script', key: 'script', tooltip: true },
        { title: '备注', key: 'remark', tooltip: true, width: 300 },
        { title: '操作', slot: 'action', align: 'center', width: 140 }
      ],
      total: 0,
      params: {
        current: 1,
        size: 10
      }
    }
  },
  methods: {
    fetchData() {
      getScripts(this.params).then(res => {
        this.data = res.records
        this.total = res.total
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
    handleScriptModal() {
      this.$refs.scriptModal.showModal()
    },
    remove(row) {
      this.$Modal.confirm({
        title: '确定',
        content: `您确定要删除ID为：${row.id}的这条脚本吗？`,
        onOk: () => {
          deleteScript(row.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    edit(row) {
      const data = { ...row }
      this.$refs.scriptModal.showModal(data)
    },
    handleDrag(a, b) {
      const x = this.data[a]
      const y = this.data[b]
      this.data.splice(b, 1, ...this.data.splice(a, 1, y))
      changeScript(x.id, y.id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    handleSuccess() {
      this.$Notice.success({
        title: '成功',
        desc: '数据脚本导入成功'
      })
      this.fetchData()
    }
  },
  computed: {
    prod() {
      return process.env.NODE_ENV === 'production'
    },
    action() {
      const baseUrl = process.env.NODE_ENV === 'development' ? config.baseUrl.dev : config.baseUrl.pro
      return baseUrl + 'script/file'
    },
    header() {
      return {
        Authorization: 'Bearer ' + getToken()
      }
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>
  .pagination{
    margin-top: 20px;
    text-align: right;
  }
</style>
