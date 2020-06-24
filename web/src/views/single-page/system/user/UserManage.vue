<template>
  <Card dis-hover>
    <Button type="primary" @click="handleAddUser">新增用户</Button>
    <Divider/>
    <Table border :data="data" :loading="loading" :columns="columns">
      <template slot-scope="{ row }" slot="action">
        <Button type="success" size="small" style="margin-right: 5px" @click="handleRelateRole(row)">关联角色</Button>
        <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
        <Button type="error" size="small" @click="handleDelete(row)">删除</Button>
      </template>
    </Table>
    <form-modal ref="formModal" @success-valid="submit"/>
    <set-role-modal ref="setRoleModal" @success-submit="fetchData"/>
  </Card>
</template>

<script>
import FormModal from './components/form-modal'
import { addUser, updateUser, deleteUser, getUsers, updateStatus } from '@/api/user'
import SetRoleModal from '@/views/single-page/system/user/components/set-role-modal'

export default {
  name: 'UserManage',
  components: { SetRoleModal, FormModal },
  data() {
    return {
      data: [],
      columns: [
        {
          title: '头像',
          key: 'avatar',
          render: (h, p) => {
            const src = p.row.avatar
            return h('Avatar', {
              props: {
                size: 'large',
                src: !src ? 'https://i.loli.net/2017/08/21/599a521472424.jpg' : src
              }
            })
          },
          width: 80
        },
        { title: '用户名', key: 'username' },
        { title: '姓名/昵称', key: 'realName' },
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
        { title: '创建人', key: 'createName' },
        {
          title: '创建时间/修改时间',
          render: (h, p) => {
            const date = p.row.updateTime ? p.row.updateTime : p.row.createTime
            return h('span', date)
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
      getUsers().then(res => {
        this.loading = false
        this.data = res.data
      }).catch(() => {
        this.$Message.error('获取用户列表失败')
        this.loading = false
      })
    },
    handleAddUser() {
      this.$refs.formModal.showModal()
    },
    submit(data) {
      if (data.id) {
        updateUser(data).then(res => {
          this.$Message.success(res.message)
          this.$refs.formModal.handleClose()
          this.fetchData()
        })
      } else {
        addUser(data).then(res => {
          this.$Message.success(res.message)
          this.$refs.formModal.handleClose()
          this.fetchData()
        })
      }
    },
    edit(row) {
      const data = { ...row }
      this.$refs.formModal.showModal(data)
    },
    handleDelete(row) {
      this.$Modal.confirm({
        title: '删除确认',
        content: `您确定要把用户：${row.realName}，删除吗？`,
        onOk: () => {
          deleteUser(row.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    handleActive(id) {
      updateStatus(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    handleRelateRole(row) {
      this.$refs.setRoleModal.showModal(row)
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>

</style>
