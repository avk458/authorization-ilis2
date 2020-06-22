<template>
  <Modal v-model="visible" title="菜单"  :footer-hide="true" :mask-closable="false" width="60">
    <Form ref="menuForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="90">
      <FormItem label="父级菜单">
        <Select v-model="formData.parentId" placeholder="不选择则为顶级">
          <Option v-for="item in menus" :key="item.id" :value="item.id">{{ item.title }}</Option>
        </Select>
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
        <i-switch v-model="hasPermit">
          <span slot="open">开</span>
          <span slot="close">关</span>
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
        icon: '',
        permissions: [
          {
            authority: '',
            description: '',
            index: 1,
            status: true
          }
        ]
      },
      hasPermit: false,
      ruleValidate: {
        title: [{ required: true, message: '菜单名称不能为空', trigger: 'blur' }],
        name: [{ required: true, message: '菜单标识不能为空', trigger: 'blur' }],
        path: [{ required: true, message: '路由路径不能为空', trigger: 'blur' }]
      }
    }
  },
  methods: {
    showModal(data) {
      getMenus().then(res => {
        this.menus = res.data
      })
      if (data) {
        this.formData = data
        this.isEdit = true
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
    },
    handleAdd() {
      this.formData.permissions.push({
        authority: '',
        description: '',
        index: ++this.index,
        status: true
      })
    },
    handleRemove(index) {
      this.formData.permissions[index].status = false
    }
  }
}
</script>

<style scoped>

</style>
