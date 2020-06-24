<template>
  <Modal v-model="visible" title="菜单"  :footer-hide="true" :mask-closable="false" width="60">
    <Form ref="menuForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="90">
      <FormItem label="父级菜单">
        <Cascader
          v-if="!selectDisable && !isEdit"
          :data="menus"
          :value="formData.parentTitle"
          :load-data="loadData"
          :render-format="format"
          change-on-select
          @on-change="handleMenuChange"
          placeholder="不选择则为顶级"></Cascader>
        <Input v-else v-model="formData.parentTitle" disabled>
          <template slot="append" v-if="!selectDisable">
            <Poptip trigger="hover" content="如需修改父级菜单，请点击">
              <Button icon="ios-backspace" style="color: #f13030" @click="() => this.isEdit = false"></Button>
            </Poptip>
          </template>
        </Input>
      </FormItem>
      <FormItem label="菜单名称" prop="title">
        <Input  v-model="formData.title" placeholder="请输入菜单名称"></Input>
      </FormItem>
      <FormItem label="菜单标识" prop="name">
        <Input v-model="formData.name" placeholder="请输入菜单标识"></Input>
      </FormItem>
      <FormItem label="路由地址" prop="path">
        <Input v-model="formData.path" placeholder="请输入路由地址"></Input>
      </FormItem>
      <FormItem label="菜单图标" >
        <Input v-model="formData.icon" placeholder="请输入菜单图片名称"></Input>
      </FormItem>
      <FormItem label="执行权限">
        <i-switch v-model="hasPermit" @on-change = "handleSwitch">
          <span slot="open">有</span>
          <span slot="close">无</span>
        </i-switch>
      </FormItem>
      <div v-if="hasPermit">
        <div v-for="(item, index) in formData.permissions" :key="index">
          <FormItem
            v-if="item.status"
            :label="'权限 ' + item.index"
            :prop="'permissions.' + index + '.authority'"
            :rules="{required: true, message: '权限编码不能为空', trigger: 'blur'}">
            <Row :gutter="16">
              <Col span="6">
                <Input type="text" v-model="item.authority" placeholder="权限编码"></Input>
              </Col>
              <Col span="12">
                <Input type="text" v-model="item.description" placeholder="权限说明"></Input>
              </Col>
              <Col span="4">
                <Button @click="handleRemove(index)">删除</Button>
              </Col>
            </Row>
          </FormItem>
        </div>
        <FormItem>
          <Row>
            <Col span="8">
              <Button type="dashed" long @click="handleAdd" icon="md-add">增加</Button>
            </Col>
          </Row>
        </FormItem>
      </div>
      <FormItem style="text-align: right">
        <Button type="primary" @click="handleSubmit('userForm')">保存</Button>
        <Button @click="handleClose" style="margin-left: 8px">取消</Button>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { getMenus } from '@/api/menu'

export default {
  name: 'menu-modal',
  data() {
    return {
      visible: false,
      index: 1,
      menus: [],
      formData: {
        title: '',
        name: '',
        path: '',
        parentId: '',
        parentTitle: '',
        icon: '',
        permissions: []
      },
      hasPermit: false,
      ruleValidate: {
        title: [{ required: true, message: '菜单名称不能为空', trigger: 'blur' }],
        name: [{ required: true, message: '菜单标识不能为空', trigger: 'blur' }],
        path: [{ required: true, message: '路由路径不能为空', trigger: 'blur' }]
      },
      selectDisable: false,
      isEdit: false
    }
  },
  methods: {
    showModal(data, id, title) {
      getMenus().then(res => {
        this.menus = res.data
      })
      if (id) {
        this.formData.parentId = id
        this.formData.parentTitle = title
        this.selectDisable = true
      }
      if (data) {
        this.formData = data
        this.isEdit = true
        const perms = data.permissions
        if (perms && perms.length > 0) {
          let index = 1
          perms.map(p => {
            p.status = true
            p.index = index
            index++
          })
          data.permissions = perms
          this.hasPermit = true
        } else {
          this.formData.permissions = []
        }
      }
      this.visible = true
    },
    handleSubmit() {
      this.$refs.menuForm.validate(valid => {
        if (valid) {
          const data = { ...this.formData }
          this.$emit('success-valid', data)
        }
      })
    },
    handleClose() {
      this.$refs.menuForm.resetFields()
      this.isEdit = false
      this.visible = false
      this.index = 1
      this.selectDisable = false
      this.formData.icon = ''
      this.formData.permissions = []
      this.hasPermit = false
      this.formData.parentId = ''
      this.formData.parentTitle = ''
      this.formData.id = null
    },
    handleAdd() {
      const index = this.index++
      this.formData.permissions.push({
        authority: '',
        description: '',
        index: index,
        status: true
      })
    },
    handleRemove(index) {
      this.formData.permissions.splice(index, 1)
    },
    loadData(item, callback) {
      item.loading = true
      getMenus(item.value).then(res => {
        item.loading = false
        if (res.data && res.data.length > 0) {
          item.children = res.data
          callback()
        } else {
          delete item.loading
          delete item.children
        }
      })
    },
    handleMenuChange(value, selectedData) {
      if (value && value.length > 0) {
        this.formData.parentId = value[value.length - 1]
      }
      if (selectedData && selectedData.length > 0) {
        this.formData.parentTitle = selectedData[selectedData.length - 1].label
      }
    },
    format(values) {
      return values.length > 0 ? values[values.length - 1] : ''
    },
    handleSwitch(val) {
      if (val) {
        this.handleAdd()
      } else {
        this.formData.permissions = []
      }
    }
  }
}
</script>

<style scoped>

</style>
