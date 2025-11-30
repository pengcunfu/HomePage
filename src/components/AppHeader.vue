<template>
  <header 
    :class="[
      'fixed top-0 left-0 right-0 z-50 transition-all duration-300',
      isScrolled ? 'bg-white/90 backdrop-blur-md shadow-lg' : 'bg-transparent'
    ]"
  >
    <nav class="container-custom">
      <div class="flex items-center justify-between h-16 lg:h-20">
        <!-- Logo -->
        <div class="flex items-center">
          <router-link to="/" class="flex items-center">
            <span class="text-2xl font-bold text-primary-600 hover:text-primary-700 transition-colors duration-300">黎明怀羽</span>
          </router-link>
        </div>
        
        <!-- 桌面端导航菜单 - 居右布局 -->
        <div class="hidden md:flex items-center space-x-8">
          <a 
            v-for="item in navItems" 
            :key="item.name"
            :href="item.href"
            :class="[
              'nav-link',
              activeSection === item.section ? 'active' : ''
            ]"
            @click="scrollToSection(item.section)"
          >
            {{ item.name }}
          </a>
        </div>
        
        <!-- 移动端菜单按钮 -->
        <button
          @click="mobileMenuOpen = !mobileMenuOpen"
          class="md:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200"
          aria-label="菜单"
        >
          <Menu v-if="!mobileMenuOpen" :size="24" />
          <X v-else :size="24" />
        </button>
      </div>
    </nav>
    
    <!-- 移动端菜单 -->
    <Transition name="mobile-menu">
      <div 
        v-if="mobileMenuOpen"
        class="md:hidden bg-white/95 backdrop-blur-md border-t"
      >
        <div class="container-custom py-4">
          <div class="flex flex-col space-y-4">
            <a 
              v-for="item in navItems" 
              :key="item.name"
              :href="item.href"
              class="nav-link mobile-center"
              @click="handleMobileNavClick(item.section)"
            >
              {{ item.name }}
            </a>
          </div>
        </div>
      </div>
    </Transition>
  </header>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import { Menu, X } from 'lucide-vue-next'

// 响应式数据
const isScrolled = ref(false)
const mobileMenuOpen = ref(false)
const activeSection = ref('home')

// 导航项目
const navItems = reactive([
  { name: '首页', href: '#home', section: 'home' },
  { name: '关于', href: '#about', section: 'about' },
  { name: '技能', href: '#skills', section: 'skills' },
  { name: '项目', href: '#projects', section: 'projects' },
  { name: '经验', href: '#experience', section: 'experience' },
  { name: '联系', href: '#contact', section: 'contact' }
])

// 滚动监听
const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
  
  // 检测当前活动区域
  const sections = ['home', 'about', 'skills', 'projects', 'experience', 'contact']
  const scrollTop = window.scrollY + 100
  
  for (const section of sections) {
    const element = document.getElementById(section)
    if (element) {
      const { offsetTop, offsetHeight } = element
      if (scrollTop >= offsetTop && scrollTop < offsetTop + offsetHeight) {
        activeSection.value = section
        break
      }
    }
  }
}

// 滚动到指定区域
const scrollToSection = (sectionId) => {
  const element = document.getElementById(sectionId)
  if (element) {
    const offsetTop = element.offsetTop - 80
    window.scrollTo({
      top: offsetTop,
      behavior: 'smooth'
    })
  }
}

// 移动端导航点击处理
const handleMobileNavClick = (sectionId) => {
  scrollToSection(sectionId)
  mobileMenuOpen.value = false
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* 移动端菜单动画 */
.mobile-menu-enter-active,
.mobile-menu-leave-active {
  transition: all 0.3s ease;
}

.mobile-menu-enter-from,
.mobile-menu-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

/* 激活状态的导航链接 */
.nav-link.active {
  @apply text-primary-600;
}

.nav-link.active::after {
  @apply w-full;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .nav-link {
    @apply py-3 text-center;
  }
}
</style>
