import axios from '@/libs/api.request'

export const getMenus = () => {
  return axios.request({
    url: '/menu/list',
    method: 'get'
  })
}

export const addMenu = data => {
  return axios.request({
    url: '/menu',
    method: 'post',
    data: data
  })
}
