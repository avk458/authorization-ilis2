<template>
  <Modal v-model="modalVisible" :title="modalTitle" :footer-hide="true" width="45"
         @on-visible-change="handleVisible">
    <Form ref="databaseForm" :model="formData" :rules="databaseRules" :label-width="100"
          label-position="right">
      <FormItem label="所属单位" prop="unitId">
        <Select v-model="formData.unitId" :label-in-value="true" :disabled="true" @on-change="handleUnitSelect">
          <Option v-for="u in unitList" :value="u.id" :key="u.id">{{ u.name }}</Option>
        </Select>
      </FormItem>
      <FormItem label="数据库名" prop="databaseName">
        <Input v-model="formData.databaseName" placeholder="请输入数据库名" :disabled="true"></Input>
      </FormItem>
      <FormItem label="数据库地址" prop="host">
        <Input v-model="formData.host" placeholder="请输入数据库地址" :disabled="true"></Input>
      </FormItem>
      <FormItem label="数据库端口" prop="port">
        <InputNumber :min="20" :max="65535" v-model="formData.port" placeholder="请输入数据库端口" :disabled="true" style="width: 100%"></InputNumber>
      </FormItem>
      <FormItem label="连接参数" prop="params">
        <CheckboxGroup v-model="checkParams" @on-change="handleParamChecked">
          <Tooltip content="使用UTF-8编码" placement="top">
            <Checkbox label="characterEncoding=utf8">
              <span>CharacterEncoding</span>
            </Checkbox>
          </Tooltip>
          <Tooltip content="mysql version > 8 需要设置时区" placement="top">
            <Checkbox label="serverTimezone=Asia/Shanghai">
              <span>ServerTimezone</span>
            </Checkbox>
          </Tooltip>
          <RadioGroup v-model="radio" @on-change="handleRadio">
            <Tooltip content="mysql 5.7 以上" placement="top">
              <Radio label="true">使用SSL连接</Radio>
              <Radio label="false">不使用SSL连接</Radio>
            </Tooltip>
          </RadioGroup>
        </CheckboxGroup>
      </FormItem>
      <FormItem label="用户名" prop="databaseUsername">
        <Input v-model="formData.databaseUsername" :placeholder="usernameHolder"></Input>
      </FormItem>
      <FormItem label="密码" prop="databasePwd">
        <Input v-model="formData.databasePwd" :placeholder="pwdHolder" type="password" :password="true"></Input>
      </FormItem>
      <FormItem label="数据库版本" prop="databaseVersion">
        <Input v-model="formData.databaseVersion" placeholder="请输入数据库数据库版本"></Input>
      </FormItem>
      <FormItem label="数据库类型" prop="databaseType">
        <Select v-model="formData.databaseType">
          <Option :value="211">MySQL</Option>
          <Option :value="222" disabled>Postgre SQL</Option>
          <Option :value="233" disabled>Microsoft SQL Server</Option>
        </Select>
      </FormItem>
      <FormItem style="text-align: right">
        <Button type="primary" @click="handleSubmit('databaseForm')">提交</Button>
        <Button @click="handleCancel" style="margin-left: 8px">取消</Button>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { getUnitList } from '@/api/unit'
import { isUnitHasActiveDatabase } from '@/api/unit-database'
import { getFirstCharAtSpell } from '@/libs/tools'

export default {
  name: 'DatabaseModal',
  data() {
    const unitValidator = async (rule, value, callback) => {
      if (this.unitIdCache === value) {
        callback()
      }
      if (!value) {
        callback(new Error('请选择要新增数据库的单位'))
      } else if (await this.unitHasDatabaseAlready(value)) {
        callback(new Error('该单位已有正在使用的数据库，暂不支持多数据库'))
      } else {
        callback()
      }
    }
    const databaseNameValidator = async (rule, value, callback) => {
      if (value.length < 3 || value.length > 10) {
        callback(new Error('数据库名长度不合适'))
      } else {
        callback()
      }
    }
    return {
      modalVisible: false,
      modalTitle: '新增单位数据库信息',
      databaseRules: {
        unitId: [{ required: true, type: 'string', validator: unitValidator, trigger: 'change' }],
        databaseName: [{ required: true, type: 'string', validator: databaseNameValidator, trigger: 'blur' }],
        host: [{ required: true, message: '您输入的地址不合规' }],
        port: [{ required: true, type: 'number' }],
        databaseUsername: [{ required: true, message: '数据库用户名不能为空' }],
        databasePwd: [{ required: true, min: 6, message: '数据库密码长度不合法', trigger: 'blur' }],
        databaseVersion: [{ required: true, message: '数据库版本不能为空' }],
        databaseType: [{ required: true, message: '请选择数据库类型' }]
      },
      formData: {
        id: '',
        unitId: '',
        unitName: '',
        databaseName: '',
        host: '',
        port: 3306,
        params: '',
        databaseUsername: '',
        databasePwd: '',
        databaseVersion: '',
        databaseType: 211
      },
      unitList: [],
      checkParams: [],
      radio: 'false',
      sslParam: '',
      usernameHolder: '请输入数据库用户名',
      pwdHolder: '请输入数据库密码',
      unitIdCache: undefined
    }
  },
  watch: {
    formData(val) {
      const params = val.params
      if (params) {
        this.checkParams = params.substring(1).split('&')
      }
    }
  },
  methods: {
    handleCancel() {
      this.modalVisible = false
      this.$refs.databaseForm.resetFields()
      this.formData.id = ''
      this.formData.unitName = ''
      this.checkParams = []
      this.usernameHolder = '请输入数据库用户名'
      this.pwdHolder = '请输入数据库密码'
    },
    showModal(data) {
      if (data) {
        this.formData = data
        this.modalTitle = '编辑单位数据库信息'
        delete this.databaseRules.databaseUsername
        delete this.databaseRules.databasePwd
        this.usernameHolder = '如需修改，请输入数据库用户名。留空则不修改用户名'
        this.pwdHolder = '如需修改，请输入数据库密码。留空则不修改密码'
        this.unitIdCache = data.unitId
      } else {
        this.modalTitle = '新增单位数据库信息'
      }
      this.modalVisible = true
      this.fetchUnitData()
    },
    async fetchUnitData() {
      const res = await getUnitList()
      this.unitList = res.data
    },
    handleUnitSelect(val) {
      if (val) {
        this.formData.unitName = val.label
        this.formData.databaseName = 'ilis2_' + getFirstCharAtSpell(val.label)
      }
    },
    handleSubmit() {
      this.$refs.databaseForm.validate((valid) => {
        if (valid) {
          const payload = {}
          Object.assign(payload, this.formData)
          if (this.sslParam) {
            payload.params.indexOf('?') === -1
              ? payload.params += '?' + this.sslParam
              : payload.params += '&' + this.sslParam
          }
          this.$emit('on-success-valid', payload)
        }
      })
    },
    handleParamChecked(group) {
      let joinParams
      if (group.length > 0) {
        joinParams = group.reduce((x, y) => x + '&' + y)
      }
      this.formData.params = ''
      if (joinParams) {
        this.formData.params += '?' + joinParams
      }
    },
    handleVisible(val) {
      if (!val) {
        this.handleCancel()
      }
    },
    async unitHasDatabaseAlready(val) {
      const res = await isUnitHasActiveDatabase(val)
      return res.data
    },
    handleRadio(val) {
      let sslParam = 'useSSL='
      if (val === 'true') {
        sslParam += 'true'
      } else {
        sslParam += 'false'
      }
      this.sslParam = sslParam
    }
  },
  computed: {
    isEdit() {
      return this.formData.id !== ''
    }
  }
}
</script>

<style scoped>

</style>
