<template>
  <Modal
    v-model="visible"
    :title="title"
    mask-closabl
    @on-ok="handleOk"
    @on-cancel="handleCancel">
    <label>
      选择角色：
      <Select v-model="selectRoles" multiple style="width:260px">
        <Option v-for="item in roles" :value="item.id" :key="item.id">{{ item.roleName }}</Option>
      </Select>
    </label>
  </Modal>
</template>

<script>
import { getRoles } from '@/api/role'
import { setUerRoles } from '@/api/user'

export default {
  name: 'set-role-modal',
  data() {
    return {
      visible: false,
      userId: '',
      roles: [],
      selectRoles: [],
      title: '',
      isUpdate: false
    }
  },
  methods: {
    async showModal(data) {
      this.visible = true
      const res = await getRoles()
      this.roles = res.data
      if (data) {
        this.userId = data.id
        this.title = `为用户：${data.realName} 设置角色`
      }
      if (data.roles && data.roles.length > 0) {
        const ur = data.roles
        this.selectRoles = ur.map(r => r.id)
      }
    },
    handleOk() {
      if (this.userId) {
        const data = {
          userId: this.userId,
          roleIds: this.selectRoles
        }
        setUerRoles(data).then(res => {
          this.$Message.success(res.message)
          this.$emit('success-submit')
          this.handleCancel()
        }).catch(() => {
          this.$Message.error('设置用户角色失败')
        })
      }
    },
    handleCancel() {
      this.roles = []
      this.selectRoles = []
      this.title = ''
      this.userId = ''
    }
  }
}
</script>

<style scoped>

</style>
