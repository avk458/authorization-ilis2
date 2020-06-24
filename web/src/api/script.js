import axios from '@/libs/api.request'

export const postScript = data => {
  return axios.request({
    url: '/script',
    method: 'post',
    data: data
  })
}

export const getLastId = () => {
  return axios.request({
    url: '/script/last/version',
    method: 'get'
  })
}

export const updateScript = data => {
  return axios.request({
    url: '/script',
    method: 'put',
    data: data
  })
}

export const deleteScript = id => {
  return axios.request({
    url: `/script/${id}`,
    method: 'delete'
  })
}

export const getScripts = params => {
  return axios.request({
    url: '/script/list',
    method: 'get',
    params: params
  })
}
