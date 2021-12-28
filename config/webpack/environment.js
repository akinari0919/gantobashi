const { environment } = require('@rails/webpacker')

// Vue.js フル版（Compiler入り）
environment.config.resolve.alias = { 'vue$': 'vue/dist/vue.esm.js' }

// jQueryとBootstapのJSを使えるように
const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: ['popper.js', 'default']
    })
)

module.exports = environment
