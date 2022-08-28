import Gateway from 'gkoudai-front-gateway-lib'

// 网关请求
export const gateway = new Gateway({
  // production/development
  mode: process.env.VUE_APP_URL,
})
