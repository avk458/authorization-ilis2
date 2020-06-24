<template>
  <div>
    <Row :gutter="20">
      <Col :xs="12" :md="8" :lg="4" v-for="(info, i) in inforCardData" :key="`info-${i}`" style="height: 120px;padding-bottom: 10px;">
        <info-card shadow :color="info.color" :icon="info.icon" :icon-size="36">
          <count-to :end="info.count" count-class="count-style"/>
          <p>{{ info.title }}</p>
        </info-card>
      </Col>
    </Row>
    <Row :gutter="20" style="margin-top: 10px;">
      <Col :md="24" :lg="8" style="margin-bottom: 20px;">
        <Card shadow>
          <chart-pie style="height: 300px;" :value="pieData" text="单位用户占比"></chart-pie>
        </Card>
      </Col>
      <Col :md="24" :lg="16" style="margin-bottom: 20px;">
        <Card shadow>
          <chart-bar style="height: 300px;" :value="barData" text="每周用户活跃量"/>
        </Card>
      </Col>
    </Row>
    <Row>
<!--      <Card shadow>-->
<!--        <example style="height: 310px;"/>-->
<!--      </Card>-->
    </Row>
  </div>
</template>

<script>
import InfoCard from '@@/info-card'
import CountTo from '@@/count-to'
import { ChartPie, ChartBar } from '@@/charts'
export default {
  name: 'home',
  components: {
    InfoCard,
    ChartPie,
    ChartBar,
    CountTo
  },
  data () {
    return {
      inforCardData: [
        { title: '当前数据库数据版本', icon: 'md-analytics', count: 32, color: '#2d8cf0' },
        { title: '累计用户数', icon: 'md-people', count: 232, color: '#19be6b' },
        { title: '当前活跃用户', icon: 'md-chatbubbles', count: 142, color: '#ff9900' }
      ],
      pieData: [
        { value: 220, name: '宏信创达' },
        { value: 34, name: '重庆海特' },
        { value: 110, name: '阿里巴巴' },
        { value: 98, name: '腾讯' },
        { value: 118, name: '字节跳动' }
      ],
      barData: {
        周一: 10,
        周二: 30,
        周三: 24,
        周四: 44,
        周五: 90,
        周六: 2,
        周日: 4
      }
    }
  },
  mounted () {
    //
  }
}
</script>

<style lang="less">
.count-style{
  font-size: 50px;
}
</style>
