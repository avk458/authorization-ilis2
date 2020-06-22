import Vue from 'vue'
import Router from 'vue-router'
import routes from './routers'
import ViewUI from 'view-design'
import store from '@/store'
import { canTurnTo, getToken, setTitle, setToken } from '@/libs/util'
import config from '@/config'

const { homeName } = config

Vue.use(Router)

const router = new Router({
  routes,
  mode: 'history'
})

// const createRouter = () =>
//   new Router({
//     mode: 'history', // require service support
//     scrollBehavior: () => ({ y: 0 }),
//     routes: routes
//   })
//
// const router = createRouter()
//
// export function resetRouter() {
//   const newRouter = createRouter()
//   router.matcher = newRouter.matcher // reset router
// }

const LOGIN_PAGE_NAME = 'login'

const turnTo = async (to, access, next) => {
  // if (!store.state.user.init) {
  //   console.log('get async router')
  //   asyncGetRouters(to, next)
  // }
  // console.log(to)
  if (canTurnTo(to.name, access, routes)) next()
  else next({ replace: true, name: 'error_401' })
}

// const asyncGetRouters = (to, next, userId) => {
//   getRouters(userId)
//     .then(res => {
//       return parseRouters(res.data)
//     })
//     .then(asyncRouters => {
//       console.log('asyncRouters', asyncRouters)
//       const mergedRouters = routes.concat(asyncRouters)
//       router.addRoutes(asyncRouters)
//       console.log('mergedRouters', mergedRouters)
//       store.commit('initUserState', true)
//       store.commit('setUserRouters', mergedRouters)
//       const newRouter = new Router({
//         mode: 'history', // require service support
//         scrollBehavior: () => ({ y: 0 }),
//         routes: mergedRouters
//       })
//       router.matcher = newRouter.matcher
//       router.options.routes = mergedRouters
//       next({ ...to, replace: true })
//     })
// }

router.beforeEach((to, from, next) => {
  ViewUI.LoadingBar.start()
  const token = getToken()
  if (!token && to.name !== LOGIN_PAGE_NAME) {
    next({
      name: LOGIN_PAGE_NAME
    })
  } else if (!token && to.name === LOGIN_PAGE_NAME) {
    next()
  } else if (token && to.name === LOGIN_PAGE_NAME) {
    next({
      name: homeName
    })
  } else {
    if (store.state.user.hasGetInfo) {
      turnTo(to, store.state.user.access, next)
    } else {
      store.dispatch('getUserInfo').then(user => {
        turnTo(to, user.access, next)
      }).catch(() => {
        setToken('')
        next({
          name: 'login'
        })
      })
    }
  }
})

router.afterEach(to => {
  setTitle(to, router.app)
  ViewUI.LoadingBar.finish()
  window.scrollTo(0, 0)
})

export default router
