<template>
 <Card dis-hover>
   <Button type="primary" @click="handleAdd">添加菜单</Button>
   <Divider/>
   <Table row-key="id" :data="data" :columns="columns" border :loading="loading">
     <template slot-scope="{ row }" slot="action">
       <Button size="small" style="margin-right: 5px" @click="viewPermissions(row)">查看权限</Button>
       <Button type="success" size="small" style="margin-right: 5px" @click="handleAdd(row)">添加子级</Button>
       <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
       <Button type="error" size="small" @click="handleDelete(row)">删除</Button>
     </template>
   </Table>
   <menu-modal ref="menuModal" @success-valid="submit"/>
 </Card>
</template>

<script>
import MenuModal from '@/views/single-page/system/menus/components/menu-modal'
import { getMenuTree, addMenu, updateMenu, deleteMenu } from '@/api/menu'

export default {
  name: 'MenuManage',
  components: { MenuModal },
  data() {
    return {
      data: [],
      columns: [
        { title: '菜单名称', key: 'title', tree: true },
        { title: '路由名称', key: 'name' },
        { title: '路由地址', key: 'path' },
        { title: '操作', slot: 'action', align: 'center', width: 290 }
      ],
      loading: false
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getMenuTree().then(res => {
        this.data = res.data
        this.loading = false
      }).catch(() => {
        this.$Message.error('获取菜单列表失败')
        this.loading = false
      })
    },
    handleAdd(row) {
      this.$refs.menuModal.showModal(null, row.id, row.title)
    },
    submit(data) {
      if (data.id) {
        updateMenu(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.menuModal.handleClose()
        })
      } else {
        addMenu(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.menuModal.handleClose()
        })
      }
    },
    edit(row) {
      const data = { ...row }
      this.$refs.menuModal.showModal(data)
    },
    handleDelete(row) {
      this.$Modal.confirm({
        title: '删除菜单确认',
        content: `您确定要将名为：${row.title} 的菜单删除吗？如果有角色关联了该菜单或子菜单下的权限，则不允许删除`,
        onOk: () => {
          deleteMenu(row.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    viewPermissions(row) {
      const perms = row.permissions
      if (perms && perms.length > 0) {
        this.$Modal.info({
          title: `${row.title} 权限`,
          render: (h) => {
            const nodes = []
            for (const p of perms) {
              nodes.push(h('ListItem', [
                h('ListItemMeta', {
                  props: {
                    title: p.authority,
                    description: p.description
                  }
                })
              ]))
            }
            return h('List', nodes)
          }
        })
      } else {
        this.$Message.info('该菜单下暂无权限')
      }
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>

</style>
