<template>
  <div>
    <Modal
      v-model="visible"
      :title="modalTitle"
      :footer-hide="true"
      @on-visible-change="handelVisible">
      <Form ref="configForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="150">
        <FormItem label="配置名称" prop="profileName">
          <Input v-model="formData.profileName" placeholder="请输入配置名称"></Input>
        </FormItem>
        <FormItem label="数据库地址" prop="host">
          <Input v-model="formData.host" placeholder="请输入数据库连接地址"/>
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
        <FormItem label="Source Schema" prop="sourceSchema">
          <Select
            v-model="formData.sourceSchema"
            style="width: 100%"
          >
            <Option v-for="item in databases" :value="item.label" :key="item.value">{{ item.label }}</Option>
          </Select>
        </FormItem>
        <FormItem label="Standard Schema" prop="standardSchema">
          <Select
            v-model="formData.standardSchema"
            style="width: 100%"
          >
            <Option v-for="item in databases" :value="item.label" :key="item.value">{{ item.label }}</Option>
          </Select>
        </FormItem>
        <FormItem v-if="!isEdit" label="文件存放路径" prop="path">
          <Cascader
            :data="pathData"
            :load-data="asyncLoadSystemPath"
            v-model="formData.path"
            change-on-select
            :render-format="format"></Cascader>
        </FormItem>
        <FormItem v-else label="文件存放路径">
          <Input disabled v-model="formData.path">
            <template slot="append">
              <Poptip trigger="hover" content="如需修改文件存放路径，请点击">
                <Button icon="ios-backspace" style="color: #f13030" @click="() => this.isEdit = false"></Button>
              </Poptip>
            </template>
          </Input>
        </FormItem>
        <FormItem label="是否启用" prop="active">
          <i-switch v-model="formData.active" size="large">
            <span slot="open">启用</span>
            <span slot="close">关闭</span>
          </i-switch>
        </FormItem>
        <FormItem style="text-align: right">
          <Button type="primary" @click="handleSubmit('configForm')">保存</Button>
          <Button @click="handleClose" style="margin-left: 8px">取消</Button>
        </FormItem>
      </Form>
    </Modal>
  </div>
</template>
<script>
import { loadSystemPath, getTableListViaDatabase, saveMainProfile, getDatabases } from '@/api/config'

export default {
  name: 'SettingModal',
  data () {
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
      formData: {
        id: '',
        profileName: '',
        host: '',
        port: 3306,
        username: '',
        password: '',
        path: [],
        sourceSchema: '',
        active: true,
        standardSchema: ''
      },
      pathData: [],
      usernameHolder: '请输入数据库用户名',
      passwordHolder: '请输入数据库密码',
      ruleValidate: {
        profileName: [{ required: true, message: '配置名称不能为空', trigger: 'blur' }],
        host: [{ required: true, message: 'host不能为空', trigger: 'blur' }],
        port: [{ required: true, type: 'number', message: '端口范围不合法', trigger: 'blur' }],
        username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
        password: [{ required: true, validator: commonValidator, message: '密码不合规', trigger: 'blur' }],
        sourceSchema: [{ required: true, message: 'schema不能为空', trigger: 'blur' }],
        standardSchema: [{ required: true, message: 'schema不能为空', trigger: 'blur' }]
      },
      tableList: [],
      modalTitle: '新增主数据源配置信息',
      isEdit: false,
      databases: []
    }
  },
  methods: {
    showModal(data) {
      this.visible = true
      if (data) {
        this.isEdit = true
        this.formData = data
        this.modalTitle = `编辑${data.profileName}信息`
        this.usernameHolder = '如需修改，请输入数据库用户名。留空则不修改用户名'
        this.passwordHolder = '如需修改，请输入数据库密码。留空则不修改密码'
      }
      loadSystemPath().then(res => {
        this.pathData = res.data
      })
    },
    async asyncLoadSystemPath(item, callback) {
      item.loading = true
      const res = await loadSystemPath(item.value)
      item.loading = false
      if (res.data && res.data.length > 0) {
        item.children = res.data
        callback()
      } else {
        delete item.loading
        delete item.children
      }
    },
    format(values) {
      return values.length > 1 ? values[values.length - 1] : ''
    },
    async handleSubmit() {
      if (typeof this.formData.path !== 'string') {
        this.formData.path = this.format(this.formData.path)
      }
      this.$refs.configForm.validate(async valid => {
        if (valid) {
          // update
          if (this.formData.id) {
            const payload = {}
            Object.assign(payload, this.formData)
            this.$emit('update-validate', payload)
            return
          }
          // insert
          const res = await saveMainProfile(this.formData)
          this.$Message.success(res.message)
          this.handleClose()
        }
      })
    },
    handelVisible(visible) {
      if (!visible) {
        this.handleClose()
      }
    },
    handleClose() {
      this.visible = false
      this.modalTitle = '新增主数据源配置信息'
      this.isEdit = false
      this.$refs.configForm.resetFields()
    },
    handleInitDataSwitch(on) {
      if (!on) {
        this.$refs.configForm.validate(valid => {
          if (valid) {
            this.$Notice.info({
              title: '提示',
              desc: '正在尝试连接数据库'
            })
            const queryData = {
              id: this.formData.id,
              host: this.formData.host,
              port: this.formData.port,
              username: this.formData.username,
              password: this.formData.password,
              schemaName: this.formData.schemaName
            }
            getTableListViaDatabase(queryData)
              .then(res => {
                this.tableList = res.data
                this.$Notice.success({
                  title: '成功',
                  desc: '获取数据库表信息成功'
                })
              })
              .catch(err => {
                if (err) {
                  this.$Notice.error({
                    title: '失败',
                    desc: '连接数据库失败，请检测输入信息是否正确'
                  })
                }
              })
          }
        })
      }
    },
    maxTagPlaceholder(num) {
      return `还有${num}个`
    },
    handleConnection() {
      const queryData = {
        id: this.formData.id,
        host: this.formData.host,
        port: this.formData.port,
        username: this.formData.username,
        password: this.formData.password
      }
      getDatabases(queryData).then(res => {
        this.databases = res.data
      })
    }
  }
}
</script>
