import axios from '@/libs/api.request'

export const getDatabases = () => {
  return axios.request({
    url: '/data-manage/databases',
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
