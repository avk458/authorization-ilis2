import axios from 'axios'
import store from '@/store'
import { getToken } from '@/libs/util'
import { Message } from 'view-design'

const addErrorLog = errorInfo => {
  const { statusText, status, request: { responseURL } } = errorInfo
  const info = {
    type: 'ajax',
    code: status,
    mes: statusText,
    url: responseURL
  }
  if (!responseURL.includes('save_error_logger')) store.dispatch('addErrorLog', info)
}

const resCode = {
  20000: '请求成功',
  20020: '无操作权限',
  20010: '请求失败',
  20100: '新增成功',
  20200: '修改成功',
  20300: '删除成功'
}

class HttpRequest {
  // eslint-disable-next-line no-undef
  constructor (baseUrl = baseURL) {
    this.baseUrl = baseUrl
    this.queue = {}
  }

  getInsideConfig () {
    const token = getToken()
    const config = {
      baseURL: this.baseUrl
    }
    if (token) {
      config.headers = {
        Authorization: 'Bearer ' + token
      }
    }
    return config
  }

  destroy (url) {
    delete this.queue[url]
    if (!Object.keys(this.queue).length) {
      // Spin.hide()
    }
  }

  interceptors (instance, url) {
    // 请求拦截
    instance.interceptors.request.use(config => {
      // 添加全局的loading...
      if (!Object.keys(this.queue).length) {
        // Spin.show() // 不建议开启，因为界面不友好
      }
      this.queue[url] = true
      return config
    }, error => {
      return Promise.reject(error)
    })
    // 响应拦截
    instance.interceptors.response.use(res => {
      this.destroy(url)
      const { data, data: { code, message } } = res
      if (code === 20010 || code === 20020) {
        Message.error({
          content: message,
          duration: 3
        })
        return Promise.reject(res)
      } else {
        data.message = resCode[code]
        return data
      }
    }, error => {
      this.destroy(url)
      let errorInfo = error.response
      if (!errorInfo) {
        const { request: { statusText, status }, config } = JSON.parse(JSON.stringify(error))
        errorInfo = {
          statusText,
          status,
          request: { responseURL: config.url }
        }
      }
      addErrorLog(errorInfo)
      return Promise.reject(error)
    })
  }

  request (options) {
    const instance = axios.create()
    options = Object.assign(this.getInsideConfig(), options)
    this.interceptors(instance, options.url)
    return instance(options)
  }
}
export default HttpRequest
