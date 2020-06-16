<template>
  <div>
    <Card dis-hover>
      <Button type="primary" @click="showMainModal">新增主数据源</Button>
      <Divider/>
      <Table border :columns="mainColumns" :data="mainProfiles" :loading="mainLoading">
        <template slot-scope="{ row }" slot="action">
          <Button type="primary" size="small" style="margin-right: 5px" @click="mainProfileEdit(row)">编辑</Button>
          <Button type="error" size="small" @click="mainProfileRemove(row)">删除</Button>
        </template>
      </Table>
      <Divider dashed/>
      <Button type="primary" @click="showTargetModal">新增目标数据源</Button>
      <Divider/>
      <Table border :columns="targetColumns" :data="targetProfiles" :loading="targetLoading" style="height: 30%">
        <template slot-scope="{ row }" slot="action">
          <Button type="primary" size="small" style="margin-right: 5px" @click="targetProfileEdit(row)">编辑</Button>
          <Button type="error" size="small" @click="targetProfileRemove(row)">删除</Button>
        </template>
      </Table>
    </Card>
    <MainSourceModal ref="mainModal" @update-validate="handleUpdate"/>
    <TargetSourceModal ref="targetModal" @on-form-validate="handelTargetProfileSubmit"/>
  </div>
</template>

<script>
import { getMainProfiles, manipulateTheConfig, deleteMainProfile, updateMainProfile, getTargetProfiles, saveTargetProfile, updateTargetProfile, deleteTargetProfile, validateTargetConnection } from '@/api/config'
import MainSourceModal from './compoents/main-source-modal'
import TargetSourceModal from './compoents/target-source-modal'

export default {
  name: 'InitConfigManage',
  components: {
    MainSourceModal,
    TargetSourceModal
  },
  data() {
    return {
      mainColumns: [
        { title: '配置名称', key: 'profileName', width: 120 },
        { title: 'Host', key: 'host', width: 160 },
        { title: '端口', key: 'port', width: 80 },
        { title: '用户名', key: 'username', width: 100 },
        { title: '文件存放位置', key: 'path', ellipsis: true },
        { title: 'Source Schema', key: 'sourceSchema', width: 150 },
        { title: 'Standard Schema', key: 'standardSchema', width: 160 },
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
        { title: '操作', slot: 'action', align: 'center', width: 170 }
      ],
      mainProfiles: [],
      targetProfiles: [],
      mainLoading: false,
      targetLoading: false,
      targetColumns: [
        { title: '配置名称', key: 'profileName' },
        { title: 'Host', key: 'host' },
        { title: '端口', key: 'port' },
        { title: '用户名', key: 'username' },
        {
          title: '是否可用',
          key: 'available',
          render: (h, p) => {
            const available = p.row.available
            return h('div', [
              h('Icon', {
                props: {
                  type: available ? 'md-checkmark' : 'md-close',
                  color: available ? 'green' : 'red',
                  size: 16
                }
              }),
              h('Divider', {
                props: {
                  type: 'vertical'
                }
              }),
              h('Button', {
                props: {
                  type: 'success',
                  size: 'small',
                  disabled: available
                },
                on: {
                  click: () => {
                    this.handleValidateConnections(p.row)
                  }
                }
              }, '验证')
            ])
          }
        },
        { title: '操作', slot: 'action', align: 'center' }
      ]
    }
  },
  methods: {
    fetchData() {
      this.mainLoading = true
      this.targetLoading = true
      getMainProfiles().then(res => {
        this.mainProfiles = res.data
        this.mainLoading = false
      })
      getTargetProfiles().then(res => {
        this.targetProfiles = res.data
        this.targetLoading = false
      })
    },
    handleActive(id) {
      manipulateTheConfig(id).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
      })
    },
    async mainProfileRemove(val) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除名为：${val.profileName}主数据吗？`,
        onOk: () => {
          deleteMainProfile(val.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    mainProfileEdit(row) {
      const data = {}
      Object.assign(data, row)
      this.$refs.mainModal.showModal(data)
    },
    handleUpdate(data) {
      updateMainProfile(data).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
        this.$refs.mainModal.handleClose()
      })
    },
    showMainModal() {
      this.$refs.mainModal.showModal()
    },
    showTargetModal() {
      this.$refs.targetModal.showModal()
    },
    targetProfileEdit(row) {
      const data = { ...row }
      this.$refs.targetModal.showModal(data)
    },
    targetProfileRemove(row) {
      this.$Modal.confirm({
        title: '警告',
        content: `您确定要删除名为：${row.profileName}的目标数据源吗？`,
        onOk: () => {
          deleteTargetProfile(row.id).then(res => {
            this.$Message.success(res.message)
            this.fetchData()
          })
        }
      })
    },
    handelTargetProfileSubmit(data) {
      if (data.id) {
        updateTargetProfile(data).then(res => {
          this.$Message.success(res.message)
          this.fetchData()
          this.$refs.targetModal.handleClose()
        })
      } else {
        if (!data.available) {
          this.$Modal.confirm({
            title: '请确认',
            content: '您提供的目标数据源信息似乎目前不能连接，您确定仍要保存吗？',
            onOk: () => {
              this.saveTargetProfile(data)
            }
          })
        } else {
          this.saveTargetProfile(data)
        }
      }
    },
    saveTargetProfile(data) {
      saveTargetProfile(data).then(res => {
        this.$Message.success(res.message)
        this.fetchData()
        this.$refs.targetModal.handleClose()
      })
    },
    handleValidateConnections(row) {
      validateTargetConnection(row).then(res => {
        if (res.data) {
          row.available = res.data
          updateTargetProfile(row)
        } else {
          this.$Message.warning('验证失败，无法获取目标数据源连接')
        }
        this.fetchData()
      })
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>

<style scoped>

</style>
