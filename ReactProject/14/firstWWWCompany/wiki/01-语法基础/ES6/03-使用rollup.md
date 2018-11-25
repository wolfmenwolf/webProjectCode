# 使用 rollup 打包

高级教程就要讲一点不一样的东西，面试也需要个人特色才能脱颖而出，不能别人会了自己也会。

## 安装

新建一个文件夹，运行`npm init`，然后安装`npm i rollup rollup-plugin-node-resolve rollup-plugin-babel babel-plugin-external-helpers babel-preset-latest  --save-dev --registry=https://registry.npm.taobao.org`

- babel-plugin-external-helpers 将一些公共的函数提取成一个文件 ？？？

在 src 目录下创建`.babelrc`

```
{
  "presets": [
    ["latest", {
      "es2015": {
        "modules": false
      }
    }]
  ],
  "plugins": ["external-helpers"]
}
```

新建 rollup.config.js

```js
import babel from 'rollup-plugin-babel'
import resolve from 'rollup-plugin-node-resolve'

export default {
    entry: 'src/index.js',
    format: 'umd',
    plugins: [
        resolve(),
        babel({
            exclude: 'node_modules/**' // only transpile our source code
        })
    ],
    dest: 'build/bundle.js'
}
```

## 打包

将之前 webpack 示例中的`src`的所有 JS 文件拷贝过来

修改 package.json 的 srcipts ， `"start": "rollup -c rollup.config.js"`，运行`npm start`

看一下打包出来的文件，再对比一下此前 webpack 打包出来的文件：第一，文件简介了；第二，用不到的`fn3`消失了

## 说明

rollup 只是一个模块化的工具，要想用于前端自动化，还需要其他自动化工具的支持，如 gulp 。

> 这里阐述一下一个系统设计、开发的观点：参考《Linux/Unix设计思想》一书，系统设计应该是各个小工具拼接而成的过程，使用大而全富尔美的框架，违背了这种设计思想。


