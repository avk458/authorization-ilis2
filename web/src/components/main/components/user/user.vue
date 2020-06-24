<template>
  <div class="user-avatar-dropdown">
    <Dropdown @on-click="handleClick">
      <Badge :dot="!!messageUnreadCount">
        <Avatar :src="userAvatar"/>
      </Badge>
      <Icon :size="18" type="md-arrow-dropdown"></Icon>
      <DropdownMenu slot="list">
        <DropdownItem name="message">
          消息中心<Badge style="margin-left: 10px" :count="messageUnreadCount"></Badge>
        </DropdownItem>
        <DropdownItem name="changePwd">修改密码</DropdownItem>
        <DropdownItem name="logout">退出登录</DropdownItem>
      </DropdownMenu>
    </Dropdown>
    <pwd-modal ref="pwdModal" :username="username" @logout="logout"/>
  </div>
</template>

<script>
import './user.less'
import { mapActions, mapGetters } from 'vuex'
import PwdModal from '../change-pwd-modal/pwd-modal'
export default {
  name: 'User',
  components: { PwdModal },
  props: {
    userAvatar: {
      type: String,
      default: ''
    },
    messageUnreadCount: {
      type: Number,
      default: 0
    }
  },
  computed: {
    ...mapGetters(['username'])
  },
  methods: {
    ...mapActions([
      'handleLogOut'
    ]),
    logout () {
      this.handleLogOut().then(() => {
        this.$router.push({
          name: 'login'
        })
      })
    },
    message () {
      this.$router.push({
        name: 'message_page'
      })
    },
    changePassword() {
      this.$refs.pwdModal.showModal()
    },
    handleClick (name) {
      switch (name) {
      case 'logout': this.logout()
        break
      case 'message': this.message()
        break
      case 'changePwd': this.changePassword()
        break
      }
    }
  }
}
</script>
