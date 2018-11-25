# Async Await

promise 的写法，还是要把函数包括在 then 里面，而 async/await 的写法，完全就是同步代码的写法，更加简洁更加容易理解

提前`npm install --save-dev babel-polyfill`

```js
import 'babel-polyfill'

function loadImg(src) {
    const promise = new Promise(function (resolve, reject) {
        var img = document.createElement('img')
        img.onload = function () {
            resolve(img)
        }
        img.onerror = function () {
            reject()
        }
        img.src = src
    })
    return promise
}

const src1 = 'http://www.imooc.com/static/img/index/logo_new.png'
const src2 = 'https://avatars3.githubusercontent.com/u/9583120'

const load = async function () {
    const result1 = await loadImg(src1)
    console.log(result1)
    const result2 = await loadImg(src2)
    console.log(result2)
}
load()
```

注意，async/await 并不是取代了 promise ，而是利用 promise 之后的另外一种写法，取代了 then 函数，写起来更加像同步代码
