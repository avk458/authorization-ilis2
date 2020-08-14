<template>
  <div>
    <Row :gutter="20">
      <Col :xs="12" :md="8" :lg="4" v-for="(info, i) in infoCardData" :key="`info-${i}`" style="height: 120px;padding-bottom: 10px;">
        <info-card shadow :color="info.color" :icon="info.icon" :icon-size="36">
          <count-to :end="info.count" count-class="count-style"/>
          <p>{{ info.title }}</p>
        </info-card>
      </Col>
    </Row>
    <Row :gutter="20" style="margin-top: 10px;">
      <Col :md="24" :lg="10" style="margin-bottom: 20px;">
        <Card shadow>
          <chart-pie style="height: 300px;" :value="pieData" text="单位用户占比"></chart-pie>
        </Card>
      </Col>
      <Col :md="24" :lg="14" style="margin-bottom: 20px;">
        <Card shadow>
          <chart-bar style="height: 300px;" :value="barData" text="每周用户活跃量"/>
        </Card>
      </Col>
    </Row>
    <Row>
      <Card shadow>
        <statistic style="height: 310px;"/>
      </Card>
    </Row>
  </div>
</template>

<script>
import InfoCard from '@@/info-card'
import CountTo from '@@/count-to'
import { ChartPie, ChartBar } from '@@/charts'
import { getInfoCardsData, getUnitUserPie, getWeekOnlineStatisticData } from '@/api/dashboard'
import statistic from './statistic'

export default {
  name: 'home',
  components: {
    InfoCard,
    ChartPie,
    ChartBar,
    CountTo,
    statistic
  },
  data () {
    return {
      infoCardData: [
        // { title: '当前数据库数据版本', icon: 'md-analytics', count: 0, color: '#2d8cf0' },
        // { title: '累计用户数', icon: 'md-people', count: 232, color: '#19be6b' },
        // { title: '当前活跃用户', icon: 'md-chatbubbles', count: 142, color: '#ff9900' }
      ],
      pieData: [
        // { value: 220, name: '宏信创达' }
        // { value: 34, name: '重庆海特' },
        // { value: 110, name: '阿里巴巴' },
        // { value: 98, name: '腾讯' },
        // { value: 118, name: '字节跳动' }
      ],
      barData: {}
    }
  },
  methods: {
    async initDashboardData() {
      const infoRes = await getInfoCardsData()
      const pieRes = await getUnitUserPie()
      const weekOnlineRes = await getWeekOnlineStatisticData()
      this.infoCardData = infoRes.data
      this.pieData = pieRes.data
      this.barData = weekOnlineRes.data
    }
  },
  async mounted () {
    await this.initDashboardData()
  }
}
</script>

<style lang="less">
.count-style{
  font-size: 50px;
}
</style>
