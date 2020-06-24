import axios from '@/libs/api.request'

export const getMenuTree = () => {
  return axios.request({
    url: '/menu/tree',
    method: 'get'
  })
}

export const getMenus = id => {
  return axios.request({
    url: '/menu/list',
    method: 'get',
    params: {
      pId: id
    }
  })
}

export const addMenu = data => {
  return axios.request({
    url: '/menu',
    method: 'post',
    data: data
  })
}

export const updateMenu = data => {
  return axios.request({
    url: '/menu',
    method: 'put',
    data: data
  })
}

export const deleteMenu = menuId => {
  return axios.request({
    url: `/menu/${menuId}`,
    method: 'delete'
  })
}

export const getMenuPermissions = () => {
  return axios.request({
    url: '/menu/menu-permissions',
    method: 'get'
  })
}
