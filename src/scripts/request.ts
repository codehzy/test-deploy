import axios from 'axios'
import { Toast } from 'vant'

/**
 * request拦截器
 */
const service = axios.create({
  baseURL: process.env.VUE_APP_URL === 'production' ? '' : '',
  timeout: 20000, // 请求超时时间
})

// request 拦截器
service.interceptors.request.use(
  config => config,
  error => {
    Toast('网络请求错误，请刷新或稍后再试！')
    Promise.reject(error)
  }
)

// response 拦截器
service.interceptors.response.use(
  response => response.data,
  error => {
    Toast('网络响应错误，请刷新或稍后再试！')
    return Promise.reject(error)
  }
)

export default service
