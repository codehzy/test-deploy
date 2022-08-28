module.exports = {
  plugins: {
    autoprefixer: {},
    'postcss-px-to-viewport': {
      viewportWidth: 375,
      selectorBlackList: ['px-to-vw-ignore'],
      unitPrecision: 5,
    },
  },
}
