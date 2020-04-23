import axios from '@/libs/api.request'

export const getDatabaseList = () => {
  return axios.request({
    url: '/database/list',
    method: 'get'
  })
}

export const saveDatabaseInfo = database => {
  return axios.request({
    url: '/database/info',
    method: 'post',
    data: database
  })
}

export const updateDatabaseInfo = database => {
  return axios.request({
    url: '/database/info',
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
    url: `/database/initialized/${id}`,
    method: 'get'
  })
}

export const isDatabaseNameIllegal = name => {
  return axios.request({
    url: '/database/name-illegally',
    method: 'get',
    params: { name: name }
  })
}
