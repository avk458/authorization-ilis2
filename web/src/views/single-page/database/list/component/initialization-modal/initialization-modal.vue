<template>
  <div class="test">
    <Modal v-model="visible" :title="modalTitle" @on-visible-change="handleVisible"
           :styles="{top: '-200px'}"
           :mask-closable="false"
           :closable="!initializing"
           class-name="vertical-center-modal">
      <div id="time-line" v-if="items.length > 2">
        <Timeline pending>
          <TimelineItem v-for="item in items" :color="item.color" :key="item.value">{{ item.value }}</TimelineItem>
        </Timeline>
      </div>
      <div style="text-align:center" v-else>
        <p>在初始化数据库的过程中不能暂停，除非遇到系统错误</p>
        <p>您确定要执行吗？</p>
      </div>
      <div slot="footer">
        <Button v-if="confirm" :type="btnType" long  @click="handelInitialize">{{ btnLabel }}</Button>
        <Button v-else long :type="btnType" :loading="initializing"  @click="handleCancel">{{ btnLabel }}</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
import { initUnitDatabase } from '@/api/unit-database'
import { mapGetters } from 'vuex'
import config from '@/config'

export default {
  data() {
    return {
      websocket: null,
      visible: false,
      items: [
        { color: 'green', value: '连接成功' }
      ],
      infoId: '',
      initializing: false,
      btnType: 'warning',
      btnLabel: '确定',
      modalTitle: '警告',
      confirm: true
    }
  },
  computed: {
    ...mapGetters([
      'currentUserId'
    ]),
    webSocketUrl() {
      const baseUrl = process.env.NODE_ENV === 'development' ? config.baseUrl.dev : config.baseUrl.pro
      return baseUrl.replace('http', 'ws')
    }
  },
  watch: {
    items() {
      this.$nextTick(() => {
        const div = document.getElementById('time-line')
        if (div) {
          div.scrollTo({
            top: div.scrollHeight,
            behavior: 'smooth'
          })
        }
      })
    }
  },
  methods: {
    async initWebSocket() {
      const broker = `${this.webSocketUrl}/messenger?token=${this.currentUserId}`
      this.websocket = new WebSocket(broker)
      this.websocket.onmessage = this.onMessage
      this.websocket.onopen = this.onOpen
      this.websocket.onerror = this.onError
      this.websocket.onclose = this.onClose
    },
    onOpen() {
      this.$emit('websocket-init')
    },
    onError() {
      this.initWebSocket()
    },
    onMessage(e) {
      const item = JSON.parse(e.data)
      this.items.push(item)
    },
    sendData(Data) {
      this.websocket.send(Data)
    },
    onClose() {
      this.websocket.close()
    },
    async showModal(val) {
      await this.initWebSocket()
      this.visible = true
      this.infoId = val
    },
    async handelInitialize() {
      this.initializing = true
      this.confirm = false
      this.btnType = 'info'
      this.btnLabel = 'processing'
      this.modalTitle = '正在初始化'
      if (this.infoId) {
        initUnitDatabase(this.infoId).then(res => {
          this.initializing = false
          if (res.code === 20000) {
            this.btnType = 'success'
            this.btnLabel = '初始化成功'
            this.modalTitle = '完成'
            this.$emit('success-init')
          } else {
            this.btnType = 'error'
            this.btnLabel = '初始化失败'
            this.modalTitle = '失败'
          }
        }).catch(err => {
          this.initializing = false
          if (err) {
            this.btnType = 'error'
            this.btnLabel = '初始化失败'
            this.modalTitle = '失败'
          }
        })
      }
    },
    handleCancel() {
      this.visible = false
      this.websocket.close()
      this.items = []
      this.infoId = ''
      this.initializing = false
      this.btnType = 'warning'
      this.btnLabel = '确定'
      this.modalTitle = '警告'
      this.confirm = true
    },
    handleVisible(val) {
      if (!val) {
        this.handleCancel()
      }
    }
  }
}
</script>
<style lang='less'>
  .vertical-center-modal{
    display: flex;
    align-items: center;
    justify-content: center;

    .ivu-modal-body{
      padding: 0;
    }

    #time-line {
      padding: 16px;
      max-height: 300px;
      overflow: auto;
    }
  }
</style>
