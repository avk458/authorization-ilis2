<template>
  <div>
    <Tag color="green" v-for="item in set" :key="item">{{ item }}</Tag>
  </div>
</template>

<script>
export default {
  props: {
    set: Array
  }
}
</script>

<style scoped>

</style>
