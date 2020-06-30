<template>
  <div>
    <Card dis-hover>
      <Button type="primary" @click="handleModal">新增单位</Button>
      <Divider />
      <Table border :columns="columns" :data="data" :loading="loading">
        <template slot-scope="{ row }" slot="name">
          <strong>{{ row.name }}</strong>
        </template>
        <template slot-scope="{ row }" slot="action">
          <Button size="small" type="success" style="margin-right: 4px" @click="applyForAuthorization(row)" :disabled="row.isAuthorized">申请授权</Button>
          <Button size="small" type="primary" style="margin-right: 4px" @click="edit(row)" :disabled="row.isAuthorized">编辑</Button>
          <Button size="small" type="error" @click="remove(row)" :disabled="row.isAuthorized">删除</Button>
        </template>
      </Table>
    </Card>
    <info-modal ref="infoModal" @on-success-valid="submit"></info-modal>
  </div>
</template>

<script>
import { getUnitList, saveUnitInfo, updateUnitInfo, deleteUnitInfo, updateUnitLoginPolicy } from '@/api/unit'
import InfoModal from './component/unit-info-modal'
import mixin from '@/views/single-page/database/list/component/initialization-modal/mixin'

export default {
  name: 'unit-info',
  components: { InfoModal },
  mixins: [mixin],
  data() {
    return {
      columns: [
        { title: '名称', key: 'name', sortable: true, width: 150 },
        { title: '简称', key: 'unitShortName' },
        { title: '唯一码', key: 'uniqCode' },
        { title: '过期时间', key: 'expireDate' },
        { title: '最大用户数', key: 'maxAccount' },
        { title: '最大在线用户数', key: 'maxOnlineAccount' },
        {
          title: '单点登录',
          render: (h, p) => {
            return h('i-switch', {
              props: {
                size: 'small',
                value: p.row.singleLogin
              },
              on: {
                'on-change': () => {
                  this.handleActive(p.row.id)
                }
              }
            })
          }
        },
        { title: '目标数据源', key: 'targetSource' },
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
          },
          width: 200
        },
        { title: '操作', slot: 'action', align: 'center', width: 230 }
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
          this.$refs.infoModal.handleCancel()
          this.fetchData()
        })
      } else {
        saveUnitInfo(data).then(res => {
          this.$Message.success(res.message)
          this.$refs.infoModal.handleCancel()
          this.initDatabase({ id: res.data, unitName: data.name })
        })
      }
    },
    applyForAuthorization(row) {
      console.log(row)
    },
    handleActive(id) {
      updateUnitLoginPolicy(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
