import axios from '@/libs/api.request'

export const getTableData = () => {
  return axios.request({
    url: '/data-manage/database/list',
    method: 'get'
  })
}

export const getSchemaList = configId => {
  return axios.request({
    url: '/data-manage/schema/list',
    method: 'get',
    params: {
      configId: configId
    }
  })
}
