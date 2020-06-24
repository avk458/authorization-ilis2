import axios from '@/libs/api.request'

export const login = ({ username, password }) => {
  const data = {
    username,
    password
  }
  return axios.request({
    url: '/auth/login',
    data,
    method: 'post'
  })
}

export const getUserInfo = () => {
  return axios.request({
    url: '/user/info',
    method: 'get'
  })
}

export const getRouters = (userId) => {
  return axios.request({
    url: '/user/routers',
    method: 'get',
    params: {
      userId: userId
    }
  })
}

export const logout = (token) => {
  return axios.request({
    url: '/auth/logout',
    method: 'post'
  })
}

export const getUnreadCount = () => {
  return axios.request({
    url: '/user/message/count',
    method: 'get'
  })
}

export const getMessage = () => {
  return axios.request({
    url: '/user/message/list',
    method: 'get'
  })
}

export const getContentByMsgId = msgId => {
  return axios.request({
    url: '/user/message/content',
    method: 'get',
    params: {
      msgId
    }
  })
}

export const hasRead = msgId => {
  return axios.request({
    url: `message/${msgId}`,
    method: 'post'
  })
}

export const removeReaded = msgId => {
  return axios.request({
    url: `message/${msgId}`,
    method: 'delete'
  })
}

export const restoreTrash = msgId => {
  return axios.request({
    url: 'message/restore',
    method: 'post',
    data: {
      msgId
    }
  })
}

export const addUser = data => {
  return axios.request({
    url: '/user',
    method: 'post',
    data: data
  })
}

export const updateUser = data => {
  return axios.request({
    url: '/user',
    method: 'put',
    data: data
  })
}

export const deleteUser = userId => {
  return axios.request({
    url: `/user/${userId}`,
    method: 'delete'
  })
}

export const getUsers = () => {
  return axios.request({
    url: '/user/list',
    method: 'get'
  })
}

export const updateStatus = userId => {
  return axios.request({
    url: '/user/actions/update-active-state',
    method: 'post',
    params: {
      userId: userId
    }
  })
}

export const validateUsername = username => {
  return axios.request({
    url: '/user/actions/validate-username',
    method: 'post',
    params: {
      username: username
    }
  })
}

export const setUerRoles = data => {
  return axios.request({
    url: '/user/roles',
    method: 'post',
    data: data
  })
}

export const updateUserPwd = data => {
  return axios.request({
    url: '/user/password',
    method: 'put',
    data: data
  })
}
