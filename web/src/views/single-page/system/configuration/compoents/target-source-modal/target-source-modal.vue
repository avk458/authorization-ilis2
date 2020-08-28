<template>
  <Modal
    v-model="visible"
    :title="modalTitle"
    :footer-hide="true"
    @on-visible-change="handleVisible">
    <Form ref="targetForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="100">
      <FormItem label="配置名称" prop="profileName">
        <Input v-model="formData.profileName" placeholder="请输入配置名称"></Input>
      </FormItem>
      <FormItem label="数据库地址" prop="host">
        <Input v-model="formData.host" placeholder="请输入数据库连接地址"/>
      </FormItem>
      <FormItem label="部署地址" prop="deploy">
        <Input v-model="formData.deploy" placeholder="请输入目标数据源部署地址"/>
      </FormItem>
      <FormItem label="数据库端口" prop="port">
        <InputNumber :min="1024" :max="65535" v-model="formData.port" placeholder="请输入数据库端口" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="用户名" prop="username">
        <Input v-model="formData.username" :placeholder="usernameHolder"></Input>
      </FormItem>
      <FormItem label="密码" prop="password">
        <Input v-model="formData.password" :placeholder="passwordHolder" type="password" :password="true"  @on-blur="handleConnection"></Input>
      </FormItem>
      <FormItem label="连接检测" prop="available">
        <i-switch v-model="formData.available" :loading="detect" size="large" disabled true-color="#13ce66" false-color="#ff4949"/>
      </FormItem>
      <FormItem style="text-align: right">
        <Button type="primary" @click="handleSubmit('targetForm')">保存</Button>
        <Button @click="handleClose" style="margin-left: 8px">取消</Button>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { validateTargetConnection } from '@/api/config'

export default {
  name: 'target-source-modal',
  data() {
    const commonValidator = (rule, value, callback) => {
      if (this.isEdit && !value) {
        callback()
      } else {
        if (rule.field === 'password') {
          if (!value || value.length < 6) {
            callback(new Error())
          } else {
            callback()
          }
        } else {
          if (!value || value.length < 4) {
            callback(new Error())
          } else {
            callback()
          }
        }
      }
    }
    return {
      visible: false,
      ruleValidate: {
        profileName: [{ required: true, message: '配置名称不能为空', trigger: 'blur' }],
        host: [{ required: true, message: 'host不能为空', trigger: 'blur' }],
        port: [{ required: true, type: 'number', message: '端口范围不合法', trigger: 'blur' }],
        username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
        password: [{ required: true, validator: commonValidator, message: '密码不合规', trigger: 'blur' }]
      },
      formData: {
        id: '',
        profileName: '',
        host: '',
        port: 3306,
        username: '',
        password: '',
        available: false,
        deploy: ''
      },
      modalTitle: '新增目标数据源配置信息',
      usernameHolder: '请输入数据库用户名',
      passwordHolder: '请输入数据库密码',
      detect: false
    }
  },
  methods: {
    handleVisible(visible) {
      if (!visible) {
        this.handleClose()
      }
    },
    handleClose() {
      this.visible = false
      this.modalTitle = '新增目标数据源配置信息'
      this.isEdit = false
      this.$refs.targetForm.resetFields()
    },
    showModal(data) {
      this.visible = true
      if (data) {
        this.isEdit = true
        this.formData = data
        this.modalTitle = `编辑${data.profileName}信息`
        this.usernameHolder = '如需修改，请输入数据库用户名。留空则不修改用户名'
        this.passwordHolder = '如需修改，请输入数据库密码。留空则不修改密码'
      }
    },
    handleSubmit() {
      this.$refs.targetForm.validate(valid => {
        if (valid) {
          const data = { ...this.formData }
          this.$emit('on-form-validate', data)
        }
      })
    },
    handleConnection() {
      this.$refs.targetForm.validate(valid => {
        this.detect = true
        if (valid) {
          validateTargetConnection(this.formData).then(res => {
            this.formData.available = res.data
            this.detect = false
          })
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
