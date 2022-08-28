import 'core-js/stable'
import 'regenerator-runtime/runtime'

import { createApp } from 'vue'
import App from './App.vue'
import 'normalize.css'
import './assets/css/common.css'
import router from './router'
import { createPinia } from 'pinia'
const store = createPinia()

createApp(App).use(router).use(store).mount('#app')
