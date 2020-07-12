<template>
  <Modal title="数据库脚本" v-model="scriptVisible" :closable="false" :mask-closable="false" width="60">
    <Alert slot="header" type="warning" show-icon :closable="false">
      注意
      <template slot="desc">
        1. 每条执行语句请以半角分号结尾；<br>
        2. DDL一次性只能提交一条，DML可提交多条；<br>
        3. 请不要混合提交DML和DDL；<br>
        4. 请不要提交DCL语句。
      </template>
    </Alert>
    <label>
      SQL Script
      <Input
        type="textarea"
        v-model="sql"
        :autosize="{ minRows: 5, maxRows: 20 }"
        placeholder="请输入要提交的脚本"
        style="font-family: Consolas, Menlo, Courier, monospace"/>
    </label>
    <Divider/>
    <label>
      Remark
      <Input
        type="textarea"
        v-model="remark"
        :autosize="{ minRows: 2, maxRows: 3 }"
        placeholder="备注"/>
    </label>
    <div slot="footer" style="margin-left: 4px">
      <Button type="primary" @click="handelSubmit">提交</Button>
      <Button type="info" @click="handelGoOn">提交并继续</Button>
      <Button @click="handelClose">取消</Button>
    </div>
  </Modal>
</template>

<script>
import { postScript, updateScript } from '@/api/script'

export default {
  name: 'standard-database',
  data() {
    return {
      scriptVisible: false,
      sql: '',
      remark: '',
      id: ''
    }
  },
  methods: {
    async fetchData() {
    },
    showModal(data) {
      if (data) {
        this.remark = data.remark
        this.sql = data.script
        this.id = data.id
      }
      this.scriptVisible = true
    },
    async handelSubmit() {
      const data = this.handelPostData()
      if (data) {
        await this.submit(data)
        this.handelClose()
      }
    },
    handelGoOn() {
      const data = this.handelPostData()
      if (data) {
        this.submit(data)
        this.sql = ''
      }
    },
    async submit(data) {
      if (data.id) {
        updateScript(data).then(res => {
          this.$Message.success(res.message)
          this.$emit('success-submit')
        })
      } else {
        const res = await postScript(data)
        this.$Message.success(res.message)
        this.$emit('success-submit')
      }
    },
    handelClose() {
      this.scriptVisible = false
      this.sql = ''
      this.remark = ''
      this.id = ''
    },
    handelPostData() {
      if (!this.sql) {
        this.$Message.warning('请输入要提交的语句')
        return
      }
      if (!this.sql.endsWith(';')) {
        this.$Message.warning('语句必须以半角分号结尾')
        return
      }
      const ddlKeyWords = ['CREATE', 'ALTER', 'DROP', 'TRUNCATE', 'COMMENT', 'RENAME']
      const dmlKeyWords = ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'MERGE', 'CALL', 'EXPLAIN PLAN', 'LOCK TABLE']
      const dclKeyWords = ['GRANT', 'REVOKE']
      if (dclKeyWords.includes(this.firstWord)) {
        this.$Message.warning('请不要提交DCL语句')
        return
      }
      let type
      if (ddlKeyWords.includes(this.firstWord)) {
        type = 'DDL'
      }
      if (!type) {
        if (dmlKeyWords.includes(this.firstWord)) {
          type = 'DML'
        }
      }
      if (!type) {
        this.$Message.warning('请提交有效的语句')
        return
      }
      let remarkCache
      if (this.remark) {
        remarkCache = this.remark
        this.remark = ''
      }
      return {
        id: this.id,
        script: this.sql,
        type: type,
        remark: remarkCache || null
      }
    }
  },
  computed: {
    firstWord() {
      return this.sql.substring(0, this.sql.indexOf(' ')).trim().toUpperCase()
    }
  }
}
</script>

<style scoped>

</style>
