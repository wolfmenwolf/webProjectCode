import Koa from 'koa'
import Serve from 'koa-static'
import bodyparser from 'koa-bodyparser'
import router from './server/router'

const app = new Koa()
const host = process.env.HOST || '127.0.0.1'
const port = process.env.PORT || 3000
app.use(Serve('./app'))
app.use(bodyparser({
  enableTypes: ['json', 'form', 'text']
}))
app.use(router.routes()).use(router.allowedMethods())
app.use(async (ctx, next) => {
  await next()
  ctx.status = 200 // koa defaults to 404 when it sees that status is unset
  return new Promise((resolve, reject) => {
    ctx.res.on('close', resolve)
    ctx.res.on('finish', resolve)
  })
})
global.console.log(`server is ready,please visit http://${host}:${port}/index.html`)
app.listen(port, host)
