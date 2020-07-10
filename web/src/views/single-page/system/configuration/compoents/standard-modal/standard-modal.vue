<template>
  <Modal v-model="visible" title="新增标准库">
    <Alert type="warning" show-icon :closable="false">
      注意
      <template slot="desc">
        1. 每条执行语句请以半角分号结尾；<br>
        2. DDL一次性只能提交一条，DML可提交多条；<br>
        3. 请不要混合提交DML和DDL；<br>
        4. 请不要提交DCL语句。
      </template>
    </Alert>
    <Form ref="standardForm" :model="formData" :rules="ruleValidate" label-position="right" :label-width="150">
      <FormItem label="选择主数据源">
        <Select
          v-model="formData.sourceProfile"
          style="width: 100%"
        >
          <Option v-for="item in profiles" :value="item.id" :key="item.id">{{ item.profileName }}</Option>
        </Select>
      </FormItem>
      <FormItem label="选择或新增Schema">
        <Select v-model="formData.schema" filterable allow-create @on-create="handleCreate">
          <Option v-for="item in schemas" :value="item.value" :key="item.value">{{ item.label }}</Option>
        </Select>
      </FormItem>
    </Form>
  </Modal>
</template>

<script>
import { getDatabases } from '@/api/config'

export default {
  name: 'standard-modal',
  props: {
    profiles: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      visible: false,
      formData: {
        id: '',
        sourceProfile: ''
      },
      ruleValidate: {},
      schemas: []
    }
  },
  watch: {
    'formData.sourceProfile'(val) {
      getDatabases({ id: val }).then(res => {
        this.schemas = res.data
      })
    }
  },
  methods: {
    showModal() {
      this.visible = true
    },
    handleCreate() {
    }
  }
}
</script>

<style scoped>

</style>
