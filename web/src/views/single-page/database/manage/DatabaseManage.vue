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
          accept=".sql"
          :headers="header"
          :show-upload-list="false"
          :before-upload="handleUpload"
          :on-success="handleSuccess"
          :action="action">
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
import { getDatabases } from '@/api/data'
import ColumnSyncModal from './components/sync-column-modal'
import ScriptModal from '../script/components/script/script-modal'
import mixin from '@/mixins/mixin'
import config from '@/config'
import { getToken } from '@/libs/util'

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
  mixins: [mixin],
  methods: {
    fetchData() {
      getDatabases().then(res => {
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
    },
    action() {
      const baseUrl = process.env.NODE_ENV === 'development' ? config.baseUrl.dev : config.baseUrl.pro
      return baseUrl + 'script/file'
    },
    header() {
      return {
        Authorization: 'Bearer ' + getToken()
      }
    }
  },
  mounted() {
    this.fetchData()
  }
}
</script>
