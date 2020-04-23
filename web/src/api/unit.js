import axios from '@/libs/api.request'

export const getUnitList = () => {
  return axios.request({
    url: '/unit/list',
    method: 'get'
  })
}

export const saveUnitInfo = unit => {
  return axios.request({
    url: '/unit/info',
    method: 'post',
    data: unit
  })
}

export const updateUnitInfo = unit => {
  return axios.request({
    url: '/unit/info',
    method: 'put',
    data: unit
  })
}

export const deleteUnitInfo = id => {
  return axios.request({
    url: `/unit/${id}`,
    method: 'delete'
  })
}

export const validateUniqCode = code => {
  return axios.request({
    url: '/unit/validate/code',
    method: 'get',
    params: { code: code }
  })
}
