const path = require('path')

const resolve = dir => {
  return path.join(__dirname, dir)
}

const BASE_URL = process.env.NODE_ENV === 'production'
  ? '/'
  : '/'

module.exports = {
  outputDir: '../server/src/main/resources/static',
  publicPath: BASE_URL,
  lintOnSave: true,
  chainWebpack: config => {
    config.resolve.alias
      .set('@', resolve('src'))
      .set('@@', resolve('src/components'))
  },
  productionSourceMap: false,
  devServer: {
    compress: true,
    disableHostCheck: true,
    port: 8081
  }
}
