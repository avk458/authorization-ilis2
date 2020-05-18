import axios from '@/libs/api.request'

export const getTableData = () => {
  return axios.request({
    url: '/data-manage/database/list',
    method: 'get'
  })
}
