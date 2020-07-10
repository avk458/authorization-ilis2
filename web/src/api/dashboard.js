import axios from '@/libs/api.request'

export const getInfoCardsData = () => {
  return axios.request({
    url: '/dashboard/info-cards',
    method: 'get'
  })
}

export const getUnitUserPie = () => {
  return axios.request({
    url: '/dashboard/pie-data',
    method: 'get'
  })
}

export const getWeekOnlineStatisticData = () => {
  return axios.request({
    url: '/dashboard/week-online',
    method: 'get'
  })
}

export const getCurrentOnlineUserData = () => {
  return axios.request({
    url: '/dashboard/current-online',
    method: 'get'
  })
}
