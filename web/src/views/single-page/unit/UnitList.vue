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
          <ButtonGroup size="small">
            <Button type="info" @click="showInfo(row)">查看</Button>
            <Button type="primary" @click="edit(row)" :disabled="row.isAuthorized">编辑</Button>
            <Button type="error" @click="remove(row)" :disabled="row.isAuthorized">删除</Button>
          </ButtonGroup>
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
              h('span', isAuth ? '已授权' : '未授权'),
              h('span', ' '),
              !isAuth ? h('Button', {
                props: {
                  type: 'success',
                  icon: 'md-color-wand',
                  size: 'small'
                },
                on: {
                  click: () => {
                    this.applyForAuthorization(p.row)
                  }
                }
              }, '申请授权') : h('')
            ])
          },
          width: 200
        },
        { title: '操作', slot: 'action', align: 'center', width: 170 }
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
          this.fetchData()
        })
      }
    },
    applyForAuthorization(row) {
      console.log(row)
    },
    showInfo(row) {
      this.$Modal.info({
        title: `单位名称：${row.name} `,
        content: `单位简称：${row.unitShortName || ''} 二级名称：${row.unitSubName || ''} </br>
                  申述电子邮箱：${row.complaintMail || ''} 申述电话：${row.complaintPhone || ''} </br>
                  邮编：${row.postCode || ''} 联系电话：${row.contactTel || ''} </br>
                  单位联系人：${row.contactName || ''} 单位联系人电话：${row.contactPhone || ''} </br>
                  联系地址：${row.address || ''} 传真： ${row.fax || ''} </br>
                  银行账户：${row.bankAccount || ''} 银行地址：${row.bankAddress || ''} </br>
                  银行名称：${row.bankName || ''} 开户行名称：${row.bankOfDeposit || ''} </br>
                  查询电话：${row.queryTel || ''} 说明： ${row.description || ''} `
      })
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
