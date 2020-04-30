import axios from '@/libs/api.request'

export const loadSystemPath = parent => {
  return axios.request({
    url: '/init/config/file/path',
    method: 'get',
    params: { path: parent }
  })
}

export const getTableListViaDatabase = form => {
  return axios.request({
    url: '/init/config/table/list',
    method: 'get',
    params: form
  })
}

export const saveInitConfigInfo = data => {
  return axios.request({
    url: '/init/config/info',
    method: 'post',
    data: data
  })
}

export const getInitConfigList = () => {
  return axios.request({
    url: '/init/config/list',
    method: 'get'
  })
}

export const manipulateTheConfig = id => {
  return axios.request({
    url: `/init/config/active/${id}`,
    method: 'put'
  })
}

export const deleteConfigInfo = id => {
  return axios.request({
    url: `/init/config/${id}`,
    method: 'delete'
  })
}

export const updateConfigInfo = data => {
  return axios.request({
    url: '/init/config/info',
    method: 'put',
    data: data
  })
}
