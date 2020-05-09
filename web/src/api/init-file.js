import axios from '@/libs/api.request'

export const getInitFileList = (params) => {
  return axios.request({
    url: '/init-file/list',
    method: 'get',
    params: params
  })
}
