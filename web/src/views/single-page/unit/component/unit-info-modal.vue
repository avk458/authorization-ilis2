<template>
  <Modal v-model="modalVisible" :title="modalTitle" :footer-hide="true"
         @on-visible-change="handleVisible">
    <Form ref="unitForm" :model="formData" :rules="ruleValidate" :label-width="130"
          label-position="right">
      <FormItem label="单位名称" prop="name">
        <Input v-model="formData.name" placeholder="请输入单位名称"></Input>
      </FormItem>
      <FormItem label="单位简称" prop="unitShortName">
        <Input v-model="formData.unitShortName" placeholder="请输入单位简称" @on-blur="handleNameInput"/>
      </FormItem>
      <FormItem label="唯一标识码" prop="uniqCode">
        <Input v-model="formData.uniqCode" placeholder="请输入4-6位英文单位唯一标识"></Input>
      </FormItem>
      <FormItem label="最大用户数" prop="maxAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxAccount" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="最大在线用户数" prop="maxOnlineAccount">
        <InputNumber :max="1000" :min="1" v-model="formData.maxOnlineAccount" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="过期时间" prop="expireDate">
        <DatePicker type="date" format="yyyy-MM-dd" placeholder="选择日期" :value="formData.expireDate" @on-change="handleDateChange"></DatePicker>
      </FormItem>
      <FormItem label="选择目标数据源" prop="targetSource">
        <Select
          v-model="formData.targetSourceId"
          style="width: 100%"
          :label-in-value="true"
          @on-change="handleSourceChange"
        >
          <Option v-for="item in targetSources" :value="item.id" :key="item.id" :label="item.profileName">{{ item.profileName }}</Option>
        </Select>
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
import { getTargetProfiles } from '@/api/config'

export default {
  name: 'InfoModal',
  data() {
    const CODE_PATTERN = /^[a-zA-Z0-9]{3,10}$/
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
        targetSourceId: '',
        targetSource: '',
        unitShortName: ''
      },
      modalTitle: '新增单位信息',
      ruleValidate: {
        name: [
          { required: true, min: 3, max: 20, message: '单位名称不能少于3个或者大于20个字', trigger: 'blur' }
        ],
        unitShortName: [
          { required: true, min: 3, max: 6, message: '单位简称最好是3-6个字', trigger: 'blur' }
        ],
        uniqCode: [
          { required: true, validator: unitCodeValidator, trigger: 'blur' }
        ],
        expireDate: [
          { required: true, message: '请设置过期时间', trigger: 'blur' }
        ],
        maxAccount: [
          { required: true, type: 'number', message: '非法最大用户数', trigger: 'change' }
        ],
        maxOnlineAccount: [
          { required: true, type: 'number', message: '非法最大在线用户数', trigger: 'change' }
        ]
      },
      uniqCodeCache: undefined,
      targetSources: []
    }
  },
  computed: {
    defaultDate() {
      const date = new Date()
      date.setMonth(date.getMonth() + 1)
      const nextMonth = date.toLocaleString('en-us', { month: '2-digit', day: '2-digit' })
        .replace('/', '-')
      return date.getFullYear() + '-' + nextMonth
    }
  },
  methods: {
    showModal(data) {
      this.fetchData()
      if (data) {
        this.formData = data
        this.modalTitle = '编辑单位信息'
        this.uniqCodeCache = data.uniqCode
      } else {
        this.modalTitle = '新增单位信息'
        this.formData.expireDate = this.defaultDate
      }
      this.modalVisible = true
    },
    fetchData() {
      getTargetProfiles().then(res => {
        this.targetSources = res.data
      })
    },
    handleSubmit() {
      this.$refs.unitForm.validate((valid) => {
        if (valid) {
          if (this.formData.maxOnlineAccount > this.formData.maxAccount) {
            this.$Message.error('最大在线用户不能大于最大用户数')
            return
          }
          const payload = { ...this.formData }
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
    },
    handleDateChange(formatDate) {
      this.formData.expireDate = formatDate
    },
    handleSourceChange(val) {
      if (val) {
        this.formData.targetSource = val.label
      }
    }
  }
}
</script>

<style scoped>

</style>
