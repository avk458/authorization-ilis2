<template>
  <Card dis-hover>
    <Alert show-icon>
      Tips
      <Icon type="ios-bulb-outline" slot="icon"></Icon>
      <span slot="desc">
      <Icon type="md-document" color="green" size="18"/>
      文件存在
      <Icon type="md-close" color="red" size="18"/>
      文件不存在
      </span>
    </Alert>
    <Table border :data="data" :columns="columns"></Table>
    <div class="pagination" v-if="total > 10">
      <Page
        :total="total"
        :current.sync="params.current"
        :page-size.sync="params.size"
        show-sizer
        @on-page-size-change="handleSizeChange"
        @on-change="handlePageChange"
      />
    </div>
  </Card>
</template>

<script>
import { getInitFileList } from '@/api/init-file'

export default {
  name: 'InitFileManage',
  data() {
    return {
      data: [],
      columns: [
        { key: 'configName', title: '配置名称' },
        {
          key: 'sqlFilePath',
          title: '数据文件路径',
          width: 400,
          tooltip: true,
          render: (h, p) => {
            const path = p.row.sqlFilePath
            const exist = p.row.sqlFileExist
            return h('div', [
              h('Icon', {
                props: {
                  type: exist ? 'md-document' : 'md-close',
                  color: exist ? 'green' : 'red',
                  size: 18
                }
              }),
              h('span', path)
            ])
          }
        },
        {
          key: 'processLogPath',
          title: '日志文件路径',
          width: 400,
          tooltip: true,
          render: (h, p) => {
            const path = p.row.processLogPath
            const exist = p.row.logFileExist
            return h('div', [
              h('Icon', {
                props: {
                  type: exist ? 'md-document' : 'md-close',
                  color: exist ? 'green' : 'red',
                  size: 18
                }
              }),
              h('span', path)
            ])
          }
        },
        { key: 'unitDatabaseName', title: '使用数据库' }
      ],
      total: 0,
      params: {
        current: 1,
        size: 10
      }
    }
  },
  methods: {
    fetchData() {
      getInitFileList(this.params).then(res => {
        this.data = res.records
        this.total = res.total
      })
    },
    handleSizeChange(size) {
      this.params.size = size
      this.fetchData()
    },
    handlePageChange(current) {
      this.params.current = current
      this.fetchData()
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>
.pagination{
  margin-top: 20px;
  text-align: right;
}
</style>
