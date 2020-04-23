<template>
  <div>
    <Modal
      v-model="visible"
      title="设置"
      :footer-hide="true">
      <Form v-model="formData" label-position="left" :label-width="100">
        <FormItem label="配置名称">
          <template v-if="!formData.profileName">
            <Input v-model="formData.profileName" placeholder="请输入配置名称"></Input>
          </template>
          <template v-else>
            <Select v-model="formData.profileName">
              <Option></Option>
            </Select>
          </template>
        </FormItem>
        <FormItem label="连接地址">
          <Input v-model="formData.host" placeholder="请输入数据库连接地址"/>
        </FormItem>
      </Form>
    </Modal>
  </div>
</template>
<script>
export default {
  name: 'SettingModal',
  data () {
    return {
      visible: false,
      formData: {
        profileName: undefined
      }
    }
  },
  methods: {
    showModal() {
      this.visible = true
    },
    handleClick(val) {
      this.btnType = 'success'
    }
  }
}
</script>
