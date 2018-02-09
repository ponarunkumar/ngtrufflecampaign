const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: "./app/js/app.js",
    output: {
        path: __dirname + "/build/app",
        filename: "js/app.js"
    },
    plugins: [
        new CopyWebpackPlugin([
            // Copy our app's index.html to the build folder.
            { from: './app/index.html', to: "index.html" },
        ]),
    ],
    module: {
        loaders: []
    }
};
