<template>
  <div>
    <Card>
      <Button type="primary" @click="handleModal">新增单位</Button>
      <Divider />
      <Table border :columns="columns" :data="data" :loading="loading">
        <template slot-scope="{ row }" slot="name">
          <strong>{{ row.name }}</strong>
        </template>
        <template slot-scope="{ row }" slot="action">
          <Button type="primary" size="small" style="margin-right: 5px" @click="edit(row)" :disabled="row.isAuthorized">编辑</Button>
          <Button type="error" size="small" @click="remove(row)" :disabled="row.isAuthorized">删除</Button>
        </template>
      </Table>
    </Card>
    <info-modal ref="infoModal" @on-success-valid="submit"></info-modal>
  </div>
</template>

<script>
import { getUnitList, saveUnitInfo, updateUnitInfo, deleteUnitInfo } from '@/api/unit'
import InfoModal from '@/views/single-page/unit/component/UnitInfoModal'

export default {
  name: 'unit-info',
  components: { InfoModal },
  data() {
    return {
      columns: [
        { title: '名称', key: 'name', sortable: true },
        { title: '唯一码', key: 'uniqCode' },
        { title: '过期时间', key: 'expireDate' },
        { title: '最大用户数', key: 'maxAccount' },
        { title: '最大在线用户数', key: 'maxOnlineAccount' },
        { title: '联系人', key: 'contactName' },
        { title: '联系人电话', key: 'contactPhone' },
        {
          title: '是否已授权',
          key: 'isAuthorized',
          render: (h, p) => {
            const isAuth = p.row.isAuthorized
            return h('div', [
              h('Icon', {
                props: {
                  type: isAuth ? 'md-checkmark-circle-outline' : 'md-close-circle',
                  color: isAuth ? 'green' : 'red'
                }
              }),
              h('span', ' '),
              h('span', isAuth ? '已授权' : '未授权')
            ])
          }
        },
        { title: '操作', slot: 'action', align: 'center' }
      ],
      data: [],
      loading: false
    }
  },
  methods: {
    remove(val) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除：${val.name}吗？</br>这个操作会将该单位数据库信息一并删除`,
        onOk: () => {
          deleteUnitInfo(val.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    fetchData() {
      this.loading = true
      getUnitList().then(res => {
        this.loading = false
        this.data = res.data
      })
    },
    handleModal() {
      this.$refs.infoModal.showModal()
    },
    edit(row) {
      const val = {}
      Object.assign(val, row)
      this.$refs.infoModal.showModal(val)
    },
    submit(data) {
      if (data.id) {
        updateUnitInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
        })
      } else {
        saveUnitInfo(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
        })
      }
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
