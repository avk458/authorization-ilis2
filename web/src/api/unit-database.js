import axios from '@/libs/api.request'

export const getDatabaseList = (params) => {
  return axios.request({
    url: '/database/list',
    method: 'get',
    params: params
  })
}

export const saveDatabaseInfo = database => {
  return axios.request({
    url: '/database',
    method: 'post',
    data: database
  })
}

export const updateDatabaseInfo = database => {
  return axios.request({
    url: '/database',
    method: 'put',
    data: database
  })
}

export const deleteDatabaseInfo = id => {
  return axios.request({
    url: `/database/${id}`,
    method: 'delete'
  })
}

export const isUnitHasActiveDatabase = id => {
  return axios.request({
    url: `/database/initialization/status/${id}`,
    method: 'get'
  })
}

export const isDatabaseNameIllegal = name => {
  return axios.request({
    url: '/database/actions/validate-schema-name',
    method: 'post',
    params: { name: name }
  })
}

export const initUnitDatabase = id => {
  return axios.request({
    url: `/database/init/${id}`,
    method: 'post'
  })
}

export const updateDatabase = (id, chosenUpdate) => {
  return axios.request({
    url: `/database/actions/update/${id}/${chosenUpdate}`,
    method: 'post'
  })
}

export const batchUpdateDatabase = () => {
  return axios.request({
    url: '/database/actions/batch-update',
    method: 'post'
  })
}
