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
          <Poptip :transfer="true" :word-wrap="true" :width="150" trigger="hover" title="提示" content="将本单位信息注册到数据中心， 如果修改单位信息后需要重新注册">
            <Button size="small" type="info" style="margin-right: 4px" @click="handleRegister(row)" :disabled="row.isRegistered">注册</Button>
          </Poptip>
          <Button size="small" type="primary" style="margin-right: 4px" @click="edit(row)" :disabled="row.isAuthorized">编辑</Button>
          <Button size="small" type="error" @click="remove(row)" :disabled="row.isAuthorized">删除</Button>
        </template>
      </Table>
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
    <info-modal ref="infoModal" @on-success-valid="submit"></info-modal>
  </div>
</template>

<script>
import { deleteUnitInfo, getUnitList, saveUnitInfo, updateUnitInfo, updateUnitLoginPolicy } from '@/api/unit'
import InfoModal from './component/unit-info-modal'
import mixin from '@/mixins/mixin'
import config from '@/config'

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
        { title: '目标数据源', key: 'targetProfile' },
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
        { title: '操作', slot: 'action', align: 'center', width: 260 }
      ],
      data: [],
      loading: false,
      total: 0,
      params: {
        current: 1,
        size: 10
      }
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
      getUnitList(this.params).then(res => {
        this.loading = false
        this.data = res.records
        this.total = res.total
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
    async submit(data) {
      if (data.id) {
        this.updateUnit(this, data)
      } else {
        const that = this
        const registerSuccess = await this.registerUnitInfo(that, data)
        if (registerSuccess) {
          saveUnitInfo(data).then(async res => {
            this.$Message.success(res.message)
            this.$refs.infoModal.handleCancel()
            if (data.available) {
              this.initDatabase({ id: res.data, unitName: data.name })
            }
            this.fetchData()
          })
        }
      }
    },
    async registerUnitInfo(context, info) {
      const centerUnitId = info.centerUnitId
      let api, formData
      if (centerUnitId) {
        api = this.centerBaseUrl + 'TestUnit/Update'
        formData = {
          id: centerUnitId,
          name: info.name,
          unitJM: info.uniqCode
        }
      } else {
        api = this.centerBaseUrl + 'TestUnit/Register'
        formData = {
          name: info.name,
          unitJM: info.uniqCode
        }
      }
      const { data } = await this.$axios.post(api, formData)
      if (data.success) {
        info.centerUnitId = centerUnitId || data.data.id
        info.isRegistered = true
        if (info.id) {
          this.updateUnit(context, info)
        }
      } else {
        this.$Message.warning(data.msg || '单位信息注册失败，请联系管理员或者稍候再试')
      }
      return data.success
    },
    handleRegister(row) {
      this.registerUnitInfo(this, row)
    },
    updateUnit(context, unitInfo) {
      updateUnitInfo(unitInfo).then(res => {
        context.$Message.success(res.message)
        context.$refs.infoModal.handleCancel()
        context.fetchData()
      })
    },
    applyForAuthorization(row) {
      console.log(row)
    },
    handleActive(id) {
      updateUnitLoginPolicy(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
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
  },
  computed: {
    centerBaseUrl() {
      return process.env.NODE_ENV === 'development' ? config.centerBaseUrl.dev : config.centerBaseUrl.pro
    }
  }
}
</script>

<style scoped>
.pagination{
  margin-top: 20px;
  text-align: right;
}
</style>
