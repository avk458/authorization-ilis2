<template>
  <Modal v-model="modalVisible" :title="modalTitle" :footer-hide="true" width="45"
         @on-visible-change="handleVisible">
    <Form ref="unitForm" :model="formData" :rules="ruleValidate" :label-width="140"
          label-position="left">
      <FormItem label="单位名称" prop="name">
        <Input v-model="formData.name" placeholder="请输入单位名称" @on-blur="handleNameInput"></Input>
      </FormItem>
      <FormItem label="唯一标识码" prop="uniqCode">
        <Input v-model="formData.uniqCode" placeholder="请输入4-6位英文单位唯一标识"></Input>
      </FormItem>
      <FormItem label="过期时间" prop="expireDate">
        <DatePicker type="date" format="yyyy-MM-dd" placeholder="选择日期" v-model="formData.expireDate"></DatePicker>
      </FormItem>
      <FormItem label="最大用户数" prop="maxAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxAccount"></InputNumber>
      </FormItem>
      <FormItem label="最大在线用户数" prop="maxOnlineAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxOnlineAccount"></InputNumber>
      </FormItem>
      <FormItem label="单位联系人" prop="contactName">
        <Input v-model="formData.contactName" placeholder="请输入联系人姓名"></Input>
      </FormItem>
      <FormItem label="单位联系人电话" prop="contactPhone">
        <Input v-model="formData.contactPhone" placeholder="请输入联系人电话"></Input>
      </FormItem>
      <FormItem style="text-align: right">
        <Button type="primary" @click="handleSubmit('unitForm')">提交</Button>
        <Button @click="handleCancel" style="margin-left: 8px">取消</Button>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { validateUniqCode } from '@/api/unit'
import { getFirstCharAtSpell } from '@/libs/tools'

export default {
  name: 'InfoModal',
  data() {
    const unitCodeValidator = async (rule, value, callback) => {
      const pattern = /^[a-z0-9]{3,10}$/
      if (!pattern.test(value)) {
        callback(new Error('非法唯一识别码'))
      } else if (await this.validateCode(value)) {
        callback(new Error('检测到重复识别码，请重新输入'))
      } else {
        callback()
      }
    }
    return {
      modalVisible: false,
      formData: {
        id: '',
        name: '',
        uniqCode: '',
        expireDate: '',
        maxAccount: 0,
        maxOnlineAccount: 0,
        contactName: '',
        contactPhone: ''
      },
      modalTitle: '新增单位信息',
      ruleValidate: {
        name: [
          { required: true, min: 3, max: 10, message: '单位名称需要3-10个字', trigger: 'blur' }
        ],
        uniqCode: [
          { required: true, validator: unitCodeValidator, trigger: 'blur' }
        ],
        expireDate: [
          { required: true, type: 'date', message: '请设置过期时间', trigger: 'change' }
        ],
        maxAccount: [
          { required: true, type: 'number', message: '非法最大用户数', trigger: 'change' }
        ],
        maxOnlineAccount: [
          { required: true, type: 'number', message: '非法最大在线用户数', trigger: 'change' }
        ],
        contactName: [
          { required: true, type: 'string', message: '单位联系人的能为空', trigger: 'change' }
        ],
        contactPhone: [
          { required: true, type: 'string', message: '联系人电话不能为空', trigger: 'change', pattern: /^1[3|4|5|7|8][0-9]{9}$/ }
        ]
      }
    }
  },
  methods: {
    showModal(data) {
      if (data) {
        this.formData = data
        this.modalTitle = '编辑单位信息'
      } else {
        this.modalTitle = '新增单位信息'
      }
      this.modalVisible = true
    },
    handleSubmit() {
      this.$refs.unitForm.validate((valid) => {
        if (valid) {
          if (this.formData.maxOnlineAccount > this.formData.maxAccount) {
            this.$Message.error('最大在线用户不能大于最大用户数')
            return
          }
          const payload = {}
          Object.assign(payload, this.formData)
          this.$emit('on-success-valid', payload)
          this.handleCancel()
        }
      })
    },
    handleCancel() {
      this.formData.id = ''
      this.$refs.unitForm.resetFields()
      this.modalVisible = false
    },
    async validateCode(val) {
      const res = await validateUniqCode(val)
      return res.data
    },
    handleVisible(val) {
      if (!val) {
        this.handleCancel()
      }
    },
    handleNameInput() {
      this.formData.uniqCode = getFirstCharAtSpell(this.formData.name)
    }
  }
}
</script>

<style scoped>

</style>
