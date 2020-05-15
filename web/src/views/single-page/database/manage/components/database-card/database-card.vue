
<script>
export default {
  name: 'database-card',
  props: {
    cards: {
      type: Array,
      required: true
    }
  },
  data() {
    return {}
  },
  render(h) {
    const vNode = []
    for (const card of this.cards) {
      vNode.push(h('Col', {
        props: {
          span: 4
        }
      }, [
        h('Card', card.name)
      ]))
    }
    return h('Row', {
      props: {
        gutter: 16
      }
    }, vNode)
  }
}
</script>

<style scoped>

</style>
