<template>
 <Card dis-hover>
   <Button type="primary" @click="handleAdd">添加菜单</Button>
   <Divider/>
   <Table :data="data" :columns="columns" border :loading="loading">
     <template slot-scope="{ row }" slot="action">
       <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
       <Button type="error" size="small" @click="handleDelete(row)">删除</Button>
     </template>
   </Table>
   <menu-modal ref="menuModal" @success-valid="submit"/>
 </Card>
</template>

<script>
import MenuModal from '@/views/single-page/system/menus/components/menu-modal'
import { addMenu } from '@/api/menu'

export default {
  name: 'MenuManage',
  components: { MenuModal },
  data() {
    return {
      data: [],
      columns: [],
      loading: false
    }
  },
  methods: {
    handleAdd() {
      this.$refs.menuModal.showModal()
    },
    submit(data) {
      addMenu(data).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
        this.$refs.menuModal.handleClose()
      })
    }
  }
}
</script>

<style scoped>

</style>
