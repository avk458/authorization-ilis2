import axios from '@/libs/api.request'

export const getUnitList = () => {
  return axios.request({
    url: '/unit/list',
    method: 'get'
  })
}

export const saveUnitInfo = unit => {
  return axios.request({
    url: '/unit',
    method: 'post',
    data: unit
  })
}

export const updateUnitInfo = unit => {
  return axios.request({
    url: '/unit',
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
    url: '/unit/actions/validate-uniq-code',
    method: 'post',
    params: { code: code }
  })
}

export const updateUnitLoginPolicy = id => {
  return axios.request({
    url: '/unit/actions/unit/login-policy',
    method: 'post',
    params: { unitId: id }
  })
}

export const getUnitAccount = () => {
  return axios.request({
    url: '/unit/accounts',
    method: 'get'
  })
}

export const getUnitLoginLog = (unitCode, params) => {
  return axios.request({
    url: `/unit/login/log/${unitCode}`,
    method: 'get',
    params: params
  })
}
