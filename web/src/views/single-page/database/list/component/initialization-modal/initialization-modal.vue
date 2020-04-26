<template>
  <div class="test">
    <Modal v-model="visible" title="数据库初始化" @on-visible-change="handleVisible"
           :styles="{top: '20px'}"
           class-name="vertical-center-modal">
      <div id="time-line">
        <Timeline pending>
          <TimelineItem v-for="item in items" :color="item.color" :key="item.value">{{ item.value }}</TimelineItem>
        </Timeline>
      </div>
    </Modal>
  </div>
</template>

<script>
import { initUnitDatabase } from '@/api/unit-database'

export default {
  name: 'test',
  data() {
    return {
      websocket: null,
      stompClient: null,
      visible: false,
      items: [
        { color: 'green', value: '连接成功' }
      ]
    }
  },
  watch: {
    items() {
      this.$nextTick(() => {
        const div = document.getElementById('time-line')
        div.scrollTo({ top: div.scrollHeight, behavior: 'smooth' })
      })
    }
  },
  methods: {
    async initWebSocket() {
      const broker = 'ws://127.0.0.1:10010/messenger?token=1234456'
      this.websocket = new WebSocket(broker)
      this.websocket.onmessage = this.onMessage
      this.websocket.onopen = this.onOpen
      this.websocket.onerror = this.onError
      this.websocket.onclose = this.onClose
    },
    onOpen() {
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
      this.visible = true
      await this.initWebSocket()
      if (val) {
        initUnitDatabase(val)
      }
    },
    handleCancel() {
      this.modalVisible = false
      this.websocket.close()
      this.items = []
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
