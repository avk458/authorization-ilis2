<template>
  <Card dis-hover>
    <Button type="primary" @click="handleAddRole">新增角色</Button>
    <Divider/>
    <Table :data="data" :columns="columns" border :loading="loading">
      <template slot-scope="{ row }" slot="action">
        <Button type="success" size="small" style="margin-right: 5px" @click="handleAuth(row)">设置权限</Button>
        <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
        <Button type="error" size="small" @click="handleDelete(row)">删除</Button>
      </template>
    </Table>
    <role-modal ref="roleModal" @success-valid="submit"/>
    <auth-modal ref="authModal" @success-submit="fetchData"/>
  </Card>
</template>

<script>
import { getRoles, addRole, updateRole, deleteRole, updateRoleActiveState } from '@/api/role'
import RoleModal from './components/role-modal'
import AuthModal from '@/views/single-page/system/role/components/auth-modal'

export default {
  name: 'RoleManage',
  components: { AuthModal, RoleModal },
  data() {
    return {
      data: [],
      columns: [
        { title: '角色名称', key: 'roleName' },
        { title: '角色标识', key: 'role' },
        { title: '角色描述', key: 'description' },
        {
          title: '是否启用',
          key: 'active',
          render: (h, p) => {
            return h('i-switch', {
              props: {
                size: 'small',
                value: p.row.active
              },
              on: {
                'on-change': () => {
                  this.handleActive(p.row.id)
                }
              }
            })
          }
        },
        { title: '创建', key: 'createName' },
        {
          title: '创建/修改时间',
          key: 'createTime',
          render: (h, p) => {
            const val = p.row.updateTime ? p.row.updateTime : p.row.createTime
            return h('span', val)
          }
        },
        { title: '操作', slot: 'action', align: 'center', width: 220 }
      ],
      loading: false
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getRoles().then(res => {
        this.loading = false
        this.data = res.data
      }).catch(() => {
        this.loading = false
        this.$Message.error('获取角色列表失败')
      })
    },
    handleAddRole() {
      this.$refs.roleModal.showModal()
    },
    submit(data) {
      if (!data.id) {
        addRole(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.roleModal.handleClose()
        })
      } else {
        updateRole(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.roleModal.handleClose()
        })
      }
    },
    edit(row) {
      const data = { ...row }
      this.$refs.roleModal.showModal(data)
    },
    handleDelete(row) {
      this.$Modal.confirm({
        title: '角色删除确认',
        content: `您确定要删除：${row.roleName} 的角色吗？如果当前角色含有关联的用户则无法被删除。`,
        onOk: () => {
          deleteRole(row.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    handleActive(id) {
      updateRoleActiveState(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    handleAuth(row) {
      this.$refs.authModal.showModal(row)
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>

</style>
