<template>
  <Modal
    v-model="visible"
    title="修改密码"
    mask-closabl
    @on-ok="handleOk"
    @on-cancel="handleCancel">
    <Form ref="pwdForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="100">
      <FormItem label="原密码" prop="orgPwd">
        <Input  v-model="formData.orgPwd" type="password" password placeholder="请输入用户名"></Input>
      </FormItem>
      <FormItem label="新密码" prop="password">
        <Input v-model="formData.password" type="password" password placeholder="请输入密码"></Input>
      </FormItem>
      <FormItem label="确认新密码" prop="password1">
        <Input v-model="formData.password1" type="password" password placeholder="请再次输入密码"></Input>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { updateUserPwd } from '@/api/user'

export default {
  name: 'pwd-modal',
  props: {
    username: {
      type: String,
      required: true
    }
  },
  data() {
    const pwdValidator = (rule, value, callback) => {
      if (value !== this.formData.password) {
        callback(new Error('两次密码不同'))
      } else {
        callback()
      }
    }
    return {
      visible: false,
      formData: {
        orgPwd: '',
        password: '',
        password1: ''
      },
      ruleValidate: {
        orgPwd: [{ required: true, message: '原密码不能为空', trigger: 'blur' }],
        password: [{ required: true, min: 6, message: '密码不能少于6位', trigger: 'blur' }],
        password1: [{ required: true, validator: pwdValidator, trigger: 'blur' }]
      }
    }
  },
  methods: {
    showModal() {
      this.visible = true
    },
    handleOk() {
      this.$refs.pwdForm.validate(valid => {
        if (valid) {
          const data = {
            username: this.username,
            newPwd: this.formData.password,
            orgPwd: this.formData.orgPwd
          }
          updateUserPwd(data)
            .then(res => {
              this.$Notice.success({
                title: res.message,
                desc: '修改密码后需要重新登录',
                duration: 10
              })
              this.$emit('logout')
            })
        }
      })
    },
    handleCancel() {
      this.$refs.pwdForm.resetFields()
    }
  }
}
</script>

<style scoped>

</style>
