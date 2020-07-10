<template>
    <div ref="dom"></div>
</template>

<script>
import echarts from 'echarts'
import { on, off } from '@/libs/tools'
import { getCurrentOnlineUserData } from '@/api/dashboard'

export default {
  name: 'serviceRequests',
  data () {
    return {
      dom: null,
      data: []
    }
  },
  methods: {
    resize () {
      this.dom.resize()
    },
    async charts() {
      const res = await getCurrentOnlineUserData()
      const keys = Object.keys(res.data)
      const data = []
      keys.forEach(key => {
        const unitData = {
          name: key,
          data: res.data[key],
          type: 'line',
          stack: '在线用户数',
          areaStyle: {
            normal: {
              color: '#2d8cf0'
            }
          }
        }
        data.push(unitData)
      })
      const option = {
        title: {
          text: '当日在线用户统计',
          subtext: new Date().toLocaleString('zh')
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            label: {
              backgroundColor: '#6a7985'
            }
          }
        },
        grid: {
          top: '20%',
          left: '1.2%',
          right: '1%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [
          {
            type: 'category',
            boundaryGap: false,
            data: [
              '1:00',
              '2:00',
              '3:00',
              '4:00',
              '5:00',
              '6:00',
              '7:00',
              '8:00',
              '9:00',
              '10:00',
              '11:00',
              '12:00',
              '13:00',
              '14:00',
              '15:00',
              '16:00',
              '17:00',
              '18:00',
              '19:00',
              '20:00',
              '21:00',
              '22:00',
              '23:00',
              '00:00'
            ]
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: data
      }
      this.$nextTick(() => {
        this.dom = echarts.init(this.$refs.dom)
        this.dom.setOption(option)
        on(window, 'resize', this.resize)
      })
    }
  },
  mounted () {
    this.charts()
  },
  beforeDestroy () {
    off(window, 'resize', this.resize)
  }
}
</script>
