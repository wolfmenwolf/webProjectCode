var path = require('path')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var CleanWebpackPlugin = require('clean-webpack-plugin')
module.exports = {
  entry: './app/js/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'index.min.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: [
          {loader: 'style-loader'},
          {loader: 'css-loader'}
        ]
      }, {
        test: /\.(png|jpg|gif)$/i,
        use: [
          {
            loader: 'url-loader',
            options: {
              limit: 8192
            }
          }
        ]
      }
    ]
  },
  devServer: {
    contentBase: './dist',
    proxy: {
      '/get': 'http://localhost:3000'
    }
  },
  plugins: [
    new CleanWebpackPlugin(['dist']),
    new HtmlWebpackPlugin({
      template: './app/index.html'
    })
  ],
  mode: 'production'
}
