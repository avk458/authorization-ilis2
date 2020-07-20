<template>
  <div ref="dom" class="charts chart-pie"></div>
</template>

<script>
import echarts from 'echarts'
import tdTheme from './theme.json'
import { off, on } from '@/libs/tools'

echarts.registerTheme('tdTheme', tdTheme)
const option = {
  title: {
    text: '',
    subtext: '',
    x: 'center'
  },
  tooltip: {
    trigger: 'item',
    formatter: '{b} : {c} ({d}%)'
  },
  legend: {
    orient: 'vertical',
    left: 'left',
    data: ''
  },
  series: [
    {
      type: 'pie',
      radius: '55%',
      center: ['70%', '60%'],
      data: [],
      itemStyle: {
        emphasis: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      }
    }
  ]
}
export default {
  name: 'ChartPie',
  props: {
    value: Array,
    text: String,
    subtext: String
  },
  data () {
    return {
      dom: null
    }
  },
  methods: {
    resize () {
      this.dom.resize()
    }
  },
  watch: {
    value(val) {
      option.legend.data = val.map(_ => _.name)
      option.series[0].data = val
      this.dom.setOption(option)
    }
  },
  mounted () {
    this.$nextTick(() => {
      option.legend.data = this.value.map(_ => _.name)
      option.series[0].data = this.text
      option.title.text = this.text
      this.dom = echarts.init(this.$refs.dom, 'tdTheme')
      // this.dom.setOption(option)
      on(window, 'resize', this.resize)
    })
  },
  beforeDestroy () {
    off(window, 'resize', this.resize)
  }
}
</script>
