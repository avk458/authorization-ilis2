<template>
  <Modal v-model="modalVisible" :title="modalTitle" :footer-hide="true" width="40"
         @on-visible-change="handleVisible">
    <Form ref="unitForm" :model="formData" :rules="ruleValidate" :label-width="130"
          inline
          label-position="left">
      <FormItem label="单位名称" prop="name">
        <Input v-model="formData.name" placeholder="请输入单位名称"></Input>
      </FormItem>
      <FormItem label="二级名称">
        <Input v-model="formData.unitSubName" placeholder="请输入单位二级名称"/>
      </FormItem>
      <FormItem label="单位简称" prop="unitShortName">
        <Input v-model="formData.unitShortName" placeholder="用于二维码扫描页面展示" @on-blur="handleNameInput"/>
      </FormItem>
      <FormItem label="唯一标识码" prop="uniqCode">
        <Input v-model="formData.uniqCode" placeholder="请输入4-6位英文单位唯一标识"></Input>
      </FormItem>
      <FormItem label="申述电子邮箱">
        <Input v-model="formData.complaintMail" placeholder="请输入申述电子邮箱"/>
      </FormItem>
      <FormItem label="申述电话">
        <Input v-model="formData.complaintPhone" placeholder="请输入申述电话" />
      </FormItem>
      <FormItem label="邮编">
        <Input v-model="formData.postCode" placeholder="请输入邮编" />
      </FormItem>
      <FormItem label="联系电话">
        <Input v-model="formData.contactTel" placeholder="请输入联系电话"/>
      </FormItem>
      <FormItem label="单位联系人">
        <Input v-model="formData.contactName" placeholder="请输入联系人姓名"></Input>
      </FormItem>
      <FormItem label="单位联系人电话">
        <Input v-model="formData.contactPhone" placeholder="请输入联系人电话"></Input>
      </FormItem>
      <FormItem label="联系地址">
        <Input v-model="formData.address" placeholder="请输入联系地址" />
      </FormItem>
      <FormItem label="传真">
        <Input v-model="formData.fax" placeholder="请输入传真号码"/>
      </FormItem>
      <FormItem label="银行账户">
        <Input v-model="formData.bankAccount" placeholder="请输入银行账户" />
      </FormItem>
      <FormItem label="银行地址">
        <Input v-model="formData.bankAddress" placeholder="请输入银行地址" />
      </FormItem>
      <FormItem label="银行名称">
        <Input v-model="formData.bankName" placeholder="请输入银行名称" />
      </FormItem>
      <FormItem label="开户名称">
        <Input v-model="formData.bankOfDeposit" placeholder="请输入开户行" />
      </FormItem>
      <FormItem label="查询电话">
        <Input v-model="formData.queryTel" placeholder="请输入查询电话" />
      </FormItem>
      <FormItem label="说明">
        <Input v-model="formData.description" type="textarea" placeholder="说明..." :autosize="{minSize:1, maxSize:1}"/>
      </FormItem>
      <FormItem label="最大用户数" prop="maxAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxAccount" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="最大在线用户数" prop="maxOnlineAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxOnlineAccount" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="过期时间" prop="expireDate">
        <DatePicker type="date" format="yyyy-MM-dd" placeholder="选择日期" v-model="formData.expireDate"></DatePicker>
      </FormItem>
      <FormItem style="text-align: right;width: 100%">
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
    const CODE_PATTERN = /^[a-z0-9]{3,10}$/
    const unitCodeValidator = async (rule, value, callback) => {
      if (this.uniqCodeCache === value) {
        callback()
      }
      if (!CODE_PATTERN.test(value)) {
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
        contactPhone: '',
        unitShortName: '',
        unitSubName: '',
        complaintMail: '',
        complaintPhone: '',
        postCode: '',
        contactTel: '',
        address: '',
        fax: '',
        bankAccount: '',
        bankAddress: '',
        bankName: '',
        bankOfDeposit: '',
        queryTel: '',
        description: ''
      },
      modalTitle: '新增单位信息',
      ruleValidate: {
        name: [
          { required: true, min: 3, max: 10, message: '单位名称需要3-10个字', trigger: 'blur' }
        ],
        unitShortName: [
          { required: true, min: 3, max: 6, message: '单位简称最好是3-6个字', trigger: 'blur' }
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
      },
      uniqCodeCache: undefined
    }
  },
  methods: {
    showModal(data) {
      if (data) {
        this.formData = data
        this.modalTitle = '编辑单位信息'
        this.uniqCodeCache = data.uniqCode
      } else {
        this.modalTitle = '新增单位信息'
      }
      this.modalVisible = true
    },
    handleSubmit() {
      if (this.uniqCodeCache && this.formData.uniqCode === this.uniqCodeCache) {
      }
      this.$refs.unitForm.validate((valid) => {
        if (valid) {
          if (this.formData.maxOnlineAccount > this.formData.maxAccount) {
            this.$Message.error('最大在线用户不能大于最大用户数')
            return
          }
          const payload = {}
          Object.assign(payload, this.formData)
          this.$emit('on-success-valid', payload)
        }
      })
    },
    handleCancel() {
      this.formData.id = ''
      this.$refs.unitForm.resetFields()
      this.modalVisible = false
      this.uniqCodeCache = undefined
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
      this.formData.uniqCode = getFirstCharAtSpell(this.formData.unitShortName)
    }
  }
}
</script>

<style scoped>

</style>
