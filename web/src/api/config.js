import axios from '@/libs/api.request'

export const loadSystemPath = parent => {
  return axios.request({
    url: '/config/file/path',
    method: 'get',
    params: { path: parent }
  })
}

export const getTableListViaDatabase = form => {
  return axios.request({
    url: '/config/tables',
    method: 'get',
    params: form
  })
}

export const saveMainProfile = data => {
  return axios.request({
    url: '/config/main/profile',
    method: 'post',
    data: data
  })
}

export const getMainProfiles = () => {
  return axios.request({
    url: '/config/main/profiles',
    method: 'get'
  })
}

export const getTargetProfiles = () => {
  return axios.request({
    url: '/config/target/profiles',
    method: 'get'
  })
}

export const manipulateTheConfig = id => {
  return axios.request({
    url: `/config/actions/active/${id}`,
    method: 'put'
  })
}

export const deleteMainProfile = id => {
  return axios.request({
    url: `/config/main/${id}`,
    method: 'delete'
  })
}

export const updateMainProfile = data => {
  return axios.request({
    url: '/config/main/profile',
    method: 'put',
    data: data
  })
}

export const getDatabases = data => {
  return axios.request({
    url: '/config/connection/databases',
    method: 'get',
    params: data
  })
}

export const saveTargetProfile = data => {
  return axios.request({
    url: '/config/target/profile',
    method: 'post',
    data: data
  })
}

export const updateTargetProfile = data => {
  return axios.request({
    url: '/config/target/profile',
    method: 'put',
    data: data
  })
}

export const deleteTargetProfile = id => {
  return axios.request({
    url: `/config/target/${id}`,
    method: 'delete'
  })
}

export const validateTargetConnection = data => {
  return axios.request({
    url: '/config/target/actions/valid-connection',
    method: 'post',
    data: data
  })
}

export const getMainSourceSchemas = main => {
  return axios.request({
    url: '/config/main-source/schemas',
    method: 'get',
    params: {
      mainProfileId: main
    }
  })
}

export const getTargetSourceSchemas = target => {
  return axios.request({
    url: '/config/target-source/schemas',
    method: 'get',
    params: {
      targetProfileId: target
    }
  })
}
