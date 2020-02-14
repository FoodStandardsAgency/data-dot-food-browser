module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-color-function'),
    require('postcss-custom-media'),
    require('postcss-custom-properties'),
    require('postcss-custom-selectors'),
    require('postcss-mixins'),
    require('postcss-nested'),
    require('postcss-url'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
