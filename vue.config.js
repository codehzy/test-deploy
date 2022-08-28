const { defineConfig } = require('@vue/cli-service')
const path = require('path')

module.exports = defineConfig({
  publicPath: process.env.VUE_APP_PUBLISH_PATH,
  transpileDependencies: [/@vue\/*/, 'gkoudai-front-gateway-lib'],
  productionSourceMap: false,
  parallel: false,
  lintOnSave: false,
  configureWebpack: {
    resolve: {
      alias: {
        '@': path.join(__dirname, './src'),
      },
    },
  },
  chainWebpack: config => {
    config.plugin('vconsole').use(require('vconsole-webpack-plugin'), [
      {
        enable: process.env.VUE_APP_IS_VCONSOLE === 'yes',
      },
    ])
  },
  css: {
    loaderOptions: {
      css: {
        modules: {
          localIdentName: '[local]_[hash:base64:5]',
          auto: /\.module\.\w+$/i,
        },
      },
    },
  },
})
