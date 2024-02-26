const path = require("path");
const webpack = require("webpack");
// Extracts CSS into .css file
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
// Removes exported JavaScript files from CSS-only entries
// in this example, entry.custom will create a corresponding empty custom.js file
const RemoveEmptyScriptsPlugin = require("webpack-remove-empty-scripts");

const mode =
  process.env.NODE_ENV === "development" ? "development" : "production";

module.exports = {
  mode,
  entry: {
    // add your css or sass entries
    application: [
      "./app/javascript/application.js",
      "./app/assets/stylesheets/application.css",
    ],
  },
  module: {
    rules: [
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ["babel-loader"],
      },
      // Add CSS/SASS/SCSS rule with loaders
      {
        test: /\.(?:sa|sc|c)ss$/i,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
      },
      {
        test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
        use: "file-loader",
      },
    ],
  },
  resolve: {
    modules: ["app/javascript", "node_modules"],
    // Add additional file types
    extensions: [".js", ".scss", ".css"],
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "..", "..", "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1,
    }),
    new RemoveEmptyScriptsPlugin(),
    new MiniCssExtractPlugin(),
  ],
  optimization: {
    moduleIds: "deterministic",
  },
};
