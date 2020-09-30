import axios from '@/libs/api.request'

export const getUnitList = (params) => {
  return axios.request({
    url: '/unit/list',
    method: 'get',
    params: params
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

export const getOnlineSessions = (unitCode, userId, params) => {
  return axios.request({
    url: `/unit/${unitCode}/${userId}/sessions`,
    method: 'get',
    params: params
  })
}

export const getUnitTotalAccounts = (unitCode, params) => {
  return axios.request({
    url: `/unit/${unitCode}/accounts`,
    method: 'get',
    params: params
  })
}

export const getAccountLoginLogs = (unitCode, userId, params) => {
  return axios.request({
    url: `/unit/${unitCode}/${userId}/log`,
    method: 'get',
    params: params
  })
}
