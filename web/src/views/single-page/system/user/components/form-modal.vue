<template>
  <Modal v-model="visible" title="用户" :footer-hide="true" :mask-closable="false">
    <Form ref="userForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="90">
      <FormItem label="用户名" prop="username">
        <Input  v-model="formData.username" placeholder="请输入用户名"></Input>
      </FormItem>
      <FormItem label="密码" prop="password">
        <Input v-model="formData.password" type="password" password placeholder="请输入密码"></Input>
      </FormItem>
      <FormItem label="姓名/昵称" prop="realName">
        <Input v-model="formData.realName" placeholder="请输入用户姓名或者昵称"></Input>
      </FormItem>
      <FormItem label="头像">
        <Upload
          type="drag"
          :headers="authHeader"
          :before-upload="beforeUpload"
          :on-success="handleSuccess"
          :with-credentials="false"
          action="http://images.ac.cn/api/upload">
          <div style="padding: 20px 0">
            <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
            <p>点击或者拖拽照片上传头像</p>
          </div>
        </Upload>
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
import { validateUsername } from '@/api/user'

export default {
  name: 'form-modal',
  data() {
    const pwdValidator = (rule, value, callback) => {
      if (this.isEdit && !value) {
        callback()
      }
      if (!value || value.length < 6) {
        callback(new Error('用户密码不合法'))
      } else {
        callback()
      }
    }
    const usernameValidator = async (rule, value, callback) => {
      if (!value || value.length < 4 || value.length > 10) {
        callback(new Error('用户名不能少于4位或者大于10位'))
      } else if (!this.isEdit && await this.validateUsername(value)) {
        callback(new Error('检测到有重复用户名，请重新输入'))
      } else {
        callback()
      }
    }
    return {
      visible: false,
      formData: {
        id: null,
        username: '',
        password: '',
        realName: '',
        avatar: '',
        active: true
      },
      ruleValidate: {
        username: [{ required: true, trigger: 'blur', validator: usernameValidator }],
        password: [{ required: true, trigger: 'blur', validator: pwdValidator }],
        realName: [{ required: true, message: '请输入用户姓名', trigger: 'blur' }],
        active: [{ required: true, type: 'boolean', message: '请设置是否启用用户', trigger: 'change' }]
      },
      authHeader: {
        Authorization: 'N6eFRqnCxXnAqKqSRU8k0QMGBRYjkKfh'
      },
      isEdit: false
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
      this.$refs.userForm.validate(valid => {
        if (valid) {
          const data = { ...this.formData }
          this.$emit('success-valid', data)
        }
      })
    },
    handleClose() {
      this.$refs.userForm.resetFields()
      this.isEdit = false
      this.visible = false
    },
    async validateUsername(username) {
      const res = await validateUsername(username)
      return res.data
    },
    handleSuccess(res, file, fs) {
      console.log(res)
      console.log(file)
    },
    beforeUpload() {
      this.$axios.post('https://sm.ms/api/v2/token', {
        username: 'ilis2',
        password: 'ilis2Auth01'
      }).then(res => {
        console.log(res)
      })
    }
  }
}
</script>

<style scoped>

</style>
