import axios from '@/libs/api.request'

export const getRoles = () => {
  return axios.request({
    url: '/role/list',
    method: 'get'
  })
}

export const addRole = data => {
  return axios.request({
    url: '/role',
    method: 'post',
    data: data
  })
}

export const updateRole = data => {
  return axios.request({
    url: '/role',
    method: 'put',
    data: data
  })
}

export const deleteRole = roleId => {
  return axios.request({
    url: `/role/${roleId}`,
    method: 'delete'
  })
}

export const updateRoleActiveState = roleId => {
  return axios.request({
    url: '/role/actions/update-active-state',
    method: 'post',
    params: {
      roleId: roleId
    }
  })
}

export const addRolePermissions = data => {
  return axios.request({
    url: '/role/permissions',
    method: 'post',
    data: data
  })
}
