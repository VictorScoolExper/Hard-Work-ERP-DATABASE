const path = require('path');

module.exports = {
  entry: {
    accounting: './modules/accounting/src/index.js',
    general_dashboard: './modules/general-dashboard/src/index.js',
    crm: './modules/crm/src/index.js',
    crew: './modules/crew/src/index.js',
    job: './modules/job/src/index.js',
    fleet:'./modules/fleet/src/index.js',
    project: './modules/project/src/index.js',
    inventory: './modules/inventory/src/index.js'
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js',
    // add so react router function
    publicPath: '/',
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react'],
          },
        },
      }
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devServer: {
    contentBase: './dist',
    historyApiFallback: true,
  },
};