const plugins = [
  '@vue/babel-plugin-jsx',
  [
    'import',
    {
      libraryName: 'vant',
      libraryDirectory: 'es',
      style: true,
    },
    'vant',
  ],
]

if (process.env.IS_CONSOLE === 'no') {
  // 如果是生产环境，则自动清理掉打印的日志，但保留error 与 warn
  plugins.push([
    'transform-remove-console',
    {
      // 保留 console.error 与 console.warn
      exclude: ['error', 'warn'],
    },
  ])
}

module.exports = {
  presets: [
    [
      '@vue/cli-plugin-babel/preset',
      {
        useBuiltIns: 'entry',
      },
    ],
  ],
  plugins,
}
