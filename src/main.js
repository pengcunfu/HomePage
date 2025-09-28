import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import App from './App.vue'
import './assets/css/main.css'

// 导入动画库
import AOS from 'aos'
import 'aos/dist/aos.css'

// 导入图标库已在组件中按需导入，无需全局注册

const app = createApp(App)

// 使用插件
app.use(createPinia())
app.use(router)

// 初始化AOS动画
app.mount('#app')

// 在DOM挂载后初始化AOS
AOS.init({
  duration: 800,
  easing: 'ease-in-out',
  once: true,
  mirror: false
})
