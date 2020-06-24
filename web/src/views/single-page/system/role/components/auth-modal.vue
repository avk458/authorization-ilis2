<template>
  <Modal
    v-model="visible"
    :mask-closable="false"
    @on-ok="handleOk"
    @on-cancel="handleCancel"
    title="关联权限">
    <Tree
      :data="tree"
      :render="contentRender"
      show-checkbox
      @on-check-change="handleChecked"></Tree>
  </Modal>
</template>

<script>
import { getMenuPermissions } from '@/api/menu'
import { addRolePermissions } from '@/api/role'

export default {
  name: 'auth-modal',
  data() {
    return {
      visible: false,
      tree: [],
      selectData: [],
      roleId: ''
    }
  },
  methods: {
    async fetchData() {
      const res = await getMenuPermissions()
      this.tree = res.data
    },
    async showModal(data) {
      this.roleId = data.id
      this.visible = true
      await this.fetchData()
      const perms = data.permissions
      if (perms && perms.length > 0) {
        this.tree = this.tree.map(t => {
          for (const perm of perms) {
            if (t.children && t.children.length > 0) {
              for (const c of t.children) {
                if (c.id === perm.id) {
                  t.expand = true
                  c.checked = true
                }
              }
            }
          }
          return t
        })
      }
    },
    handleChecked(val) {
      this.selectData = val
    },
    contentRender(h, { root, node, data }) {
      const id = data.id
      return h('span', [
        h('Icon', {
          props: {
            type: id ? 'ios-paper-outline' : 'ios-folder-outline'
          },
          style: {
            marginRight: '8px'
          }
        }),
        h(id ? 'Tag' : 'span', {
          props: {
            border: true
          },
          style: {
            marginRight: '8px'
          }
        }, data.title),
        h('span', data.description)
      ])
    },
    handleOk() {
      if (this.selectData.length > 0) {
        const ids = this.selectData.filter(p => p.id).map(p => p.id)
        const data = {
          roleId: this.roleId,
          permissionIds: ids
        }
        addRolePermissions(data).then(res => {
          this.$Message.success(res.message)
          this.handleCancel()
          this.$emit('success-submit')
        }).catch(() => {
          this.$Message.error('保存角色权限失败')
        })
      }
    },
    handleCancel() {
      this.tree = []
      this.selectData = []
      this.roleId = ''
    }
  }
}
</script>

<style scoped>

</style>
