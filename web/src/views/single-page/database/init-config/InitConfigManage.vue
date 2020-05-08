<template>
  <div>
    <Card>
      <Table border :columns="columns" :data="data" :loading="loading">
        <template slot-scope="{ row }" slot="action">
          <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)">编辑</Button>
          <Button type="error" size="small" @click="remove(row)">删除</Button>
        </template>
      </Table>
    </Card>
    <SettingModal ref="settingModal" @update-validate="handleUpdate"/>
  </div>
</template>

<script>
import { getInitConfigList, manipulateTheConfig, deleteConfigInfo, updateConfigInfo } from '@/api/config'
import SettingModal from '@@/main/components/setting-modal/setting-modal'
import TableSetExpand from './compoents/expand'

export default {
  name: 'InitConfigManage',
  components: {
    SettingModal,
    // eslint-disable-next-line vue/no-unused-components
    TableSetExpand
  },
  data() {
    return {
      columns: [
        {
          type: 'expand',
          width: 50,
          render: (h, p) => {
            return h(TableSetExpand, {
              props: { set: p.row.initDataTableSet }
            })
          }
        },
        { title: '配置名称', key: 'profileName', width: 100 },
        { title: 'Host', key: 'host' },
        { title: '端口', key: 'port', width: 80 },
        { title: '用户名', key: 'username', width: 100 },
        { title: '文件存放位置', key: 'path' },
        { title: 'Schema', key: 'schemaName', width: 120 },
        {
          title: '是否启用',
          key: 'active',
          render: (h, p) => {
            return h('i-switch', {
              props: {
                size: 'small',
                value: p.row.active
              },
              on: {
                'on-change': () => {
                  this.handleActive(p.row.id)
                }
              }
            })
          },
          align: 'center',
          width: 100
        },
        {
          title: '是否初始化数据',
          key: 'initWithData',
          render: (h, p) => {
            const is = p.row.initWithData
            return h('Tag', {
              props: {
                color: is ? 'warning' : 'primary'
              }
            }, is ? '表结构+表数据' : '仅表结构')
          },
          width: 140
        },
        { title: '初始化数据表', key: 'carryDataTables', ellipsis: true },
        { title: '操作', slot: 'action', align: 'center', width: 170 }
      ],
      data: [],
      loading: false
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getInitConfigList().then(res => {
        const data = res.data
        data.map(i => {
          if (i.initWithData) {
            i._disableExpand = true
          }
        })
        this.data = data
        this.loading = false
      })
    },
    handleActive(id) {
      manipulateTheConfig(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    async remove(val) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除配置：${val.profileName}吗？`,
        onOk: () => {
          deleteConfigInfo(val.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    edit(row) {
      const data = {}
      Object.assign(data, row)
      this.$refs.settingModal.showModal(data)
    },
    handleUpdate(data) {
      updateConfigInfo(data).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    handleCellClick(a, b, c) {
      console.log(a)
      console.log(b)
      console.log(b)
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>

</style>
