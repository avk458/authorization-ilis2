<template>
  <div>
    <DatabaseCard :cards="cards"/>
  </div>
</template>
<script>
import DatabaseCard from './components/database-card'
export default {
  components: { DatabaseCard },
  data () {
    return {
      cards: [
        { name: 'hitek1' },
        { name: 'hitek2' },
        { name: 'hitek3' },
        { name: 'hitek4' },
        { name: 'hitek5' },
        { name: 'hitek6' },
        { name: 'hitek7' },
        { name: 'hitek8' }
      ]
    }
  },
  methods: {
    fetchData() {
    }
  }
}
</script>
