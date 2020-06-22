import Main from '@/components/main'

/**
 * meta: {
 *  title: { String|Number|Function } display on sidebar, breadcrumb, tagview or callback function
 *  hideInBread: (false)
 *  hideInMenu: (false)
 *  notCache: (false) need component unique name
 *  access: (null) must be an array, contains user roles, like 'ROLE_ADMIN'
 *  icon: (-) need `_` prefix
 * }
 */

export default [
  {
    path: '/login',
    name: 'login',
    meta: {
      title: 'Login - 登录',
      hideInMenu: true
    },
    component: () => import('@/views/login/login.vue')
  },
  {
    path: '/',
    name: '_home',
    redirect: '/home',
    component: Main,
    meta: {
      hideInMenu: true,
      notCache: true
    },
    children: [
      {
        path: '/home',
        name: 'home',
        meta: {
          hideInMenu: true,
          title: '首页',
          notCache: true,
          icon: 'md-home'
        },
        component: () => import('@/views/single-page/home')
      }
    ]
  },
  {
    path: '/message',
    name: 'message',
    component: Main,
    meta: {
      hideInBread: true,
      hideInMenu: true
    },
    children: [
      {
        path: '/page',
        name: 'message_page',
        meta: {
          icon: 'md-notifications',
          title: '消息中心'
        },
        component: () => import('@/views/single-page/system/message/index.vue')
      }
    ]
  },
  {
    path: '/unit',
    name: 'unit',
    component: Main,
    meta: {
      hideInBread: true
    },
    children: [
      {
        path: '/unit/list',
        name: 'unit_list',
        meta: {
          icon: 'logo-buffer',
          title: '单位信息管理',
          access: ['ROLE_ADMIN']
        },
        component: () => import('@/views/single-page/unit/UnitList.vue')
      }
    ]
  },
  {
    path: '/customer',
    name: 'customer',
    component: Main,
    meta: {
      icon: 'md-people',
      title: '单位用户',
      hideInBread: true
    },
    children: [
      {
        path: '/customer/list',
        name: 'customer_list',
        meta: {
          icon: 'md-people',
          access: ['ROLE_ADMIN'],
          title: '用户管理'
        },
        component: () => import('@/views/single-page/customer/Customer.vue')
      },
      {
        path: '/customer/list2',
        name: 'customer_list2',
        meta: {
          icon: 'md-people',
          // access: ['ROLE_ADMIN'],
          title: '用户管理2'
        },
        component: () => import('@/views/single-page/customer/Customer.vue')
      }
    ]
  },
  {
    path: '/database',
    name: 'database',
    component: Main,
    meta: {
      hideInBread: true,
      title: '数据库',
      icon: 'md-analytics'
    },
    children: [
      {
        path: '/database/list',
        name: 'database_list',
        meta: {
          icon: 'md-cube',
          access: ['ROLE_ADMIN'],
          title: '单位数据库信息'
        },
        component: () => import('@/views/single-page/database/list/Database.vue')
      },
      {
        path: '/database/manage',
        name: 'database_manage',
        meta: {
          icon: 'ios-pulse',
          access: ['ROLE_ADMIN'],
          title: '单位数据管理'
        },
        component: () => import('@/views/single-page/database/manage/DatabaseManage.vue')
      },
      {
        path: '/database/script',
        name: 'database_script',
        meta: {
          icon: 'md-document',
          access: ['ROLE_ADMIN'],
          title: '数据脚本管理'
        },
        component: () => import('@/views/single-page/database/script/ScriptManage.vue')
      }
    ]
  },
  {
    path: '/system',
    name: 'system',
    component: Main,
    meta: {
      hideInBread: true,
      title: '系统设置',
      icon: 'md-cog'
    },
    children: [
      {
        path: '/source/config',
        name: 'source_config',
        meta: {
          icon: 'ios-cloud',
          access: ['ROLE_ADMIN'],
          title: '数据源配置管理'
        },
        component: () => import('@/views/single-page/system/configuration/ProfilesManage.vue')
      },
      {
        path: '/init-file',
        name: 'init_file',
        meta: {
          icon: 'md-albums',
          access: ['ROLE_ADMIN'],
          title: '初始化文件管理'
        },
        component: () => import('@/views/single-page/system/init-file/InitFileManage.vue')
      },
      {
        path: '/user-manage',
        name: 'user_manage',
        meta: {
          icon: 'md-body',
          access: ['ROLE_ADMIN'],
          title: '系统用户'
        },
        component: () => import('@/views/single-page/system/user/UserManage.vue')
      },
      {
        path: '/role-manage',
        name: 'role_manage',
        meta: {
          icon: 'md-person-add',
          access: ['ROLE_ADMIN'],
          title: '角色管理'
        },
        component: () => import('@/views/single-page/system/role/RoleManage.vue')
      },
      {
        path: '/menu-manage',
        name: 'menu_manage',
        meta: {
          icon: 'md-apps',
          access: ['ROLE_ADMIN'],
          title: '菜单管理'
        },
        component: () => import('@/views/single-page/system/menus/MenuManage.vue')
      }
    ]
  },
  {
    path: '/401',
    name: 'error_401',
    meta: {
      hideInMenu: true
    },
    component: () => import('@/views/error-page/401.vue')
  },
  {
    path: '/500',
    name: 'error_500',
    meta: {
      hideInMenu: true
    },
    component: () => import('@/views/error-page/500.vue')
  },
  {
    path: '*',
    name: 'error_404',
    meta: {
      hideInMenu: true
    },
    component: () => import('@/views/error-page/404.vue')
  }
]
