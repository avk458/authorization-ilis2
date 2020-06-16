<template>
  <div>
    <Row :gutter="16"  justify="start">
      <Col span="2">
        <Button type="primary" @click="handleColumnSync">数据库字段同步</Button>
      </Col>
      <Col span="2">
        <Button type="success" @click="handleScriptModal">提交脚本</Button>
      </Col>
      <Col span="2">
        <Button v-if="!prod" type="info" @click="handleExportDataScript">导出数据库脚本</Button>
      </Col>
      <Col span="2">
        <Upload
          v-if="prod"
          ref="upload"
          :show-upload-list="false"
          accept=".sql"
          :before-upload="handleUpload"
          :on-success="handleSuccess"
          action="http://192.168.2.129:10010/script/file">
          <Button>导入数据库脚本</Button>
        </Upload>
      </Col>
    </Row>
    <Divider/>
    <Row :gutter="16">
      <Col span="4" v-for="c in cards" :key="c.name">
        <Card style="margin-bottom: 20px;width: 250px">
          <p slot="title">
            <Icon type="md-disc"/>
            {{ c.name }}
          </p>
          <Icon slot="extra" :type="c.online ? 'ios-wifi' : 'ios-wifi-outline'" :color=" c.online ? 'green' : 'gray'" size="20"/>
          <List>
            <ListItem>
              <ListItemMeta title="Tables:"/>
              {{ c.tables }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Database size:"/>
              {{ c.dataSize }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Index size"/>
              {{ c.indexSize }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Max connections"/>
              {{ c.maxConnections }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Thread cached"/>
              {{ c.threadsCached }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Thread connected"/>
              {{ c.threadConnected }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Thread Created"/>
              {{ c.threadCreated }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Thread Running"/>
              {{ c.threadRunning }}
            </ListItem>
            <ListItem>
              <ListItemMeta title="Uptime"/>
              <Time v-if="c.uptime" :time="new Date() - (c.uptime * 1000)"/>
            </ListItem>
          </List>
        </Card>
      </Col>
      <Spin size="large" fix v-if="spinShow"></Spin>
    </Row>
    <column-sync-modal ref="syncModal"/>
    <script-modal ref="scriptModal"/>
  </div>
</template>
<script>
import { getTableData } from '@/api/data'
import { getLastId } from '@/api/script'
import ColumnSyncModal from './components/sync-column-modal'
import ScriptModal from '../script/components/script/script-modal'
import config from '@/config'

export default {
  components: { ScriptModal, ColumnSyncModal },
  data () {
    return {
      spinShow: true,
      cards: [
        { name: 'hitek1', online: true, tables: 388, dataSize: '83493MB', indexSize: '300MB', uptime: 339392 }
      ]
    }
  },
  methods: {
    fetchData() {
      getTableData().then(res => {
        this.cards = res.data
        this.spinShow = false
        // eslint-disable-next-line no-return-assign
      }).catch(() => this.spinShow = false)
    },
    handleColumnSync() {
      this.$refs.syncModal.showModal()
    },
    handleScriptModal() {
      this.$refs.scriptModal.showModal()
    },
    async handleExportDataScript() {
      const baseUrl = !this.prod ? config.baseUrl.dev : config.baseUrl.pro
      this.$axios.get(baseUrl + '/script/actions/export')
        .then(res => {
          const fileName = res.headers['content-disposition']
          const url = window.URL.createObjectURL(new Blob([res.data]))
          const link = document.createElement('a')
          link.href = url
          link.setAttribute('download', fileName)
          document.body.appendChild(link)
          link.click()
        })
        .catch(() => {
          this.$Message.error('导出失败')
        })
    },
    handleUpload (file) {
      this.upload(file)
      return false
    },
    async upload(file) {
      const reg = /\d{3}\.sql$/
      const name = file.name
      let msg
      if (reg.test(name)) {
        const uploadVersion = this.getUploadVersion(name)
        const currentVersion = await this.getCurrentVersion()
        msg = `当前数据版本为：${currentVersion}， 你确定要将数据脚本升级至：${uploadVersion}吗？`
      } else {
        msg = '好像您导入的文件不是默认的导出文件，你确定要继续这个操作吗？'
      }
      this.$Modal.confirm({
        title: '确认',
        content: msg,
        onOk: () => {
          this.$refs.upload.post(file)
        }
      })
    },
    getUploadVersion(name) {
      return 'v' + name.substring(0, name.indexOf('.'))
    },
    async getCurrentVersion() {
      const res = await getLastId()
      return 'v' + res.data
    },
    handleSuccess() {
      this.$Notice.success({
        title: '成功',
        desc: '数据脚本导入成功'
      })
    }
  },
  computed: {
    prod() {
      return process.env.NODE_ENV === 'production'
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
