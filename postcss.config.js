module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-mixins'),
    require('postcss-cssnext')({
      features: {
        customProperties: {
          preserve: false,
          warnings: false
        },
        rem: false,
        nesting: false
      }
    }),
    require('postcss-nested'),
    require('postcss-normalize'),
    require('postcss-url'),
    // Webpacker includes flexbugs-fixes and preset-env as standard
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
