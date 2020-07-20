<template>
  <Modal v-model="visible" title="角色" :footer-hide="true" :mask-closable="false">
    <Form ref="roleForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="90">
      <FormItem label="角色名称" prop="roleName">
        <Input  v-model="formData.roleName" placeholder="请输入角色名称"></Input>
      </FormItem>
      <FormItem label="角色标识" prop="role">
        <Input v-model="formData.role" placeholder="请输入角色标识"></Input>
      </FormItem>
      <FormItem label="角色描述" prop="description">
        <Input v-model="formData.description" placeholder="请输入角色描述"></Input>
      </FormItem>
      <FormItem label="是否启用" prop="active">
        <i-switch v-model="formData.active"></i-switch>
      </FormItem>
      <FormItem style="text-align: right">
        <Button type="primary" @click="handleSubmit('userForm')">保存</Button>
        <Button @click="handleClose" style="margin-left: 8px">取消</Button>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
export default {
  name: 'role-modal',
  data() {
    const roleCodeValidator = (rule, value, callback) => {
      if (!value || value.length < 5 || value.length > 10) {
        callback(new Error('非法角色标识'))
      } else if (!value.startsWith('ROLE_')) {
        callback(new Error('角色标识必须以ROLE_开头'))
      } else {
        callback()
      }
    }
    return {
      visible: false,
      formData: {
        id: null,
        role: '',
        roleName: '',
        description: '',
        active: true
      },
      ruleValidate: {
        role: [{ required: true, validator: roleCodeValidator }],
        roleName: [{ required: true, min: 3, max: 10, message: '角色名称不能为空', trigger: 'blur' }]
      }
    }
  },
  methods: {
    showModal(data) {
      if (data) {
        this.formData = data
        this.isEdit = true
      }
      this.visible = true
    },
    handleSubmit() {
      this.$refs.roleForm.validate(valid => {
        if (valid) {
          if (this.formData.description && this.formData.description.length > 50) {
            this.$Message.warning('角色描述长度超限')
            return
          }
          const data = { ...this.formData }
          this.$emit('success-valid', data)
        }
      })
    },
    handleClose() {
      this.$refs.roleForm.resetFields()
      this.isEdit = false
      this.visible = false
      this.formData.id = null
    }
  }
}
</script>

<style scoped>

</style>
