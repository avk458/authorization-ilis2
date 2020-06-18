<template>
 <Card dis-hover>
   <Button type="success" @click="handleScriptModal">提交脚本</Button>
   <Divider/>
   <Table border :data="data" :columns="columns">
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
import { getScripts, deleteScript } from '@/api/script'
import ScriptModal from './components/script/'

export default {
  name: 'ScriptManage',
  components: { ScriptModal },
  data() {
    return {
      data: [],
      columns: [
        { title: 'ID', key: 'id', width: 60 },
        { title: '创建', key: 'createName', width: 80 },
        { title: '更新', key: 'updateName', width: 80 },
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
