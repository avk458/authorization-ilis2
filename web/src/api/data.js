import axios from '@/libs/api.request'

export const getTableData = () => {
  return axios.request({
    url: '/data-manage/database/list',
    method: 'get'
  })
}

export const syncSchemaColumns = data => {
  const { mainProfileId, targetProfileId, sourceSchema, targetSchemas } = data
  return axios.request({
    url: '/data-manage/actions/sync-columns',
    method: 'post',
    params: {
      mainProfileId: mainProfileId,
      targetProfileId: targetProfileId,
      sourceSchema: sourceSchema,
      targetSchemas: targetSchemas
    }
  })
}

export const getStandardSchemaViaConfigId = configId => {
  return axios.request({
    url: 'data-manage/config/standard-database',
    method: 'get',
    params: {
      configId: configId
    }
  })
}
