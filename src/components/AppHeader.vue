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
            <img 
              src="@/assets/images/logo.svg" 
              alt="彭存福" 
              class="h-20 w-20 lg:h-24 lg:w-24"
            />
          </router-link>
        </div>
        
        <!-- 桌面端导航菜单 -->
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
        
        <!-- 右侧按钮组 -->
        <div class="hidden md:flex items-center space-x-4">
          <!-- 主题切换 -->
          <button
            @click="toggleTheme"
            class="p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200"
            aria-label="切换主题"
          >
            <Sun v-if="isDark" :size="20" />
            <Moon v-else :size="20" />
          </button>
          
          <!-- 语言切换 -->
          <div class="relative" ref="langDropdown">
            <button
              @click="showLangMenu = !showLangMenu"
              class="flex items-center space-x-1 p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200"
            >
              <Globe :size="20" />
              <span class="text-sm">{{ currentLang.toUpperCase() }}</span>
              <ChevronDown :size="16" />
            </button>
            
            <Transition name="dropdown">
              <div 
                v-if="showLangMenu"
                class="absolute right-0 top-full mt-2 w-32 bg-white rounded-lg shadow-lg border py-1"
              >
                <button
                  v-for="lang in languages"
                  :key="lang.code"
                  @click="changeLang(lang.code)"
                  class="w-full px-4 py-2 text-left hover:bg-gray-100 transition-colors duration-200"
                >
                  {{ lang.name }}
                </button>
              </div>
            </Transition>
          </div>
          
          <!-- 联系按钮 -->
          <a
            href="#contact"
            class="btn btn-primary"
            @click="scrollToSection('contact')"
          >
            联系我
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
            
            <div class="flex items-center justify-center space-x-4 pt-4 border-t">
              <button
                @click="toggleTheme"
                class="p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200"
                aria-label="切换主题"
              >
                <Sun v-if="isDark" :size="20" />
                <Moon v-else :size="20" />
              </button>
              
              <a
                href="#contact"
                class="btn btn-primary"
                @click="handleMobileNavClick('contact')"
              >
                联系我
              </a>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </header>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import { Menu, X, Sun, Moon, Globe, ChevronDown } from 'lucide-vue-next'

// 响应式数据
const isScrolled = ref(false)
const mobileMenuOpen = ref(false)
const showLangMenu = ref(false)
const activeSection = ref('home')
const isDark = ref(false)
const currentLang = ref('zh')

// 导航项目
const navItems = reactive([
  { name: '首页', href: '#home', section: 'home' },
  { name: '关于', href: '#about', section: 'about' },
  { name: '技能', href: '#skills', section: 'skills' },
  { name: '项目', href: '#projects', section: 'projects' },
  { name: '经验', href: '#experience', section: 'experience' },
  { name: '联系', href: '#contact', section: 'contact' }
])

// 语言选项
const languages = reactive([
  { code: 'zh', name: '中文' },
  { code: 'en', name: 'English' }
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

// 主题切换
const toggleTheme = () => {
  isDark.value = !isDark.value
  // 这里可以添加主题切换逻辑
  document.documentElement.classList.toggle('dark', isDark.value)
}

// 语言切换
const changeLang = (langCode) => {
  currentLang.value = langCode
  showLangMenu.value = false
  // 这里可以添加国际化逻辑
}

// 点击外部关闭语言菜单
const handleClickOutside = (event) => {
  if (!event.target.closest('.relative')) {
    showLangMenu.value = false
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  document.addEventListener('click', handleClickOutside)
  
  // 初始化主题
  const savedTheme = localStorage.getItem('theme')
  if (savedTheme) {
    isDark.value = savedTheme === 'dark'
    document.documentElement.classList.toggle('dark', isDark.value)
  }
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.removeEventListener('click', handleClickOutside)
})
</script>

<style scoped>
/* 下拉菜单动画 */
.dropdown-enter-active,
.dropdown-leave-active {
  transition: all 0.2s ease;
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

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
