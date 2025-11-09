<template>
  <footer class="bg-dark-900 text-white">
    <!-- 主要内容区域 -->
    <div class="py-16 lg:py-20">
      <div class="container-custom">
        <div class="grid lg:grid-cols-4 gap-8">
          <!-- 品牌信息 -->
          <div class="lg:col-span-2">
            <div class="flex items-center space-x-3 mb-6">
              <span class="text-2xl font-bold text-primary-600">彭存福</span>
            </div>
            <p class="text-gray-300 mb-6 leading-relaxed max-w-md">
              专注于现代Web技术栈的全栈开发工程师，致力于为客户提供高质量的技术解决方案。
              让我们一起将创意转化为优秀的数字产品。
            </p>
            
            <!-- 社交媒体 -->
            <div class="flex space-x-4 mb-6">
              <a
                v-for="social in socialLinks"
                :key="social.name"
                :href="social.url"
                :aria-label="social.name"
                class="w-10 h-10 bg-gray-800 rounded-lg flex items-center justify-center hover:bg-primary-600 transition-all duration-300 transform hover:scale-110"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img :src="social.icon" :alt="social.name" class="w-5 h-5 opacity-70 hover:opacity-100 transition-opacity" />
              </a>
            </div>

            <!-- 联系信息 -->
            <div class="space-y-2">
              <a 
                href="mailto:3173484026@qq.com"
                class="flex items-center text-gray-300 hover:text-white transition-colors duration-300"
              >
                <Mail :size="16" class="mr-2" />
                3173484026@qq.com
              </a>
              <a 
                href="tel:+8613800000000"
                class="flex items-center text-gray-300 hover:text-white transition-colors duration-300"
              >
                <Phone :size="16" class="mr-2" />
                +86 155-7636-4885
              </a>
            </div>
          </div>

          <!-- 快速链接 -->
          <div>
            <h3 class="text-lg font-semibold mb-6">快速链接</h3>
            <ul class="space-y-3">
              <li v-for="link in quickLinks" :key="link.name">
                <a 
                  :href="link.href"
                  class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center group"
                  @click="scrollToSection(link.section)"
                >
                  <ChevronRight :size="14" class="mr-1 group-hover:translate-x-1 transition-transform duration-300" />
                  {{ link.name }}
                </a>
              </li>
            </ul>
          </div>

          <!-- 服务项目 -->
          <div>
            <h3 class="text-lg font-semibold mb-6">服务项目</h3>
            <ul class="space-y-3">
              <li v-for="service in services" :key="service">
                <div class="text-gray-300 flex items-center">
                  <CheckCircle :size="14" class="mr-2 text-primary-500" />
                  {{ service }}
                </div>
              </li>
            </ul>
          </div>
        </div>

        <!-- 分隔线 -->
        <div class="border-t border-gray-800 mt-12 pt-8">
          <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
            <!-- 版权信息 -->
            <div class="flex flex-col md:flex-row items-center space-y-2 md:space-y-0 md:space-x-6">
              <p class="text-gray-400 text-sm">
                © {{ currentYear }} 彭存福. 保留所有权利.
              </p>
              <div class="flex space-x-4">
                <a href="#" class="text-gray-400 hover:text-white text-sm transition-colors duration-300">
                  隐私政策
                </a>
                <a href="#" class="text-gray-400 hover:text-white text-sm transition-colors duration-300">
                  服务条款
                </a>
              </div>
            </div>

            <!-- 建站信息 -->
            <div class="flex items-center space-x-2 text-sm text-gray-400">
              <Heart :size="14" class="text-red-500" />
              <span>Made with</span>
              <span class="font-medium text-primary-400">Vue.js</span>
              <span>&</span>
              <span class="font-medium text-secondary-400">TailwindCSS</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 回到顶部按钮区域 -->
    <div class="bg-dark-800 py-4">
      <div class="container-custom">
        <div class="flex justify-between items-center">
          <!-- 网站状态 -->
          <div class="flex items-center space-x-4 text-sm text-gray-400">
            <div class="flex items-center">
              <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
              <span>网站运行正常</span>
            </div>
            <div class="hidden md:flex items-center">
              <Globe :size="14" class="mr-1" />
              <span>在线服务</span>
            </div>
          </div>

          <!-- 语言和主题切换 -->
          <div class="flex items-center space-x-4">
            <!-- 最后更新时间 -->
            <span class="text-xs text-gray-500 hidden md:block">
              最后更新: {{ lastUpdated }}
            </span>
            
            <!-- 回到顶部 -->
            <button
              @click="scrollToTop"
              class="flex items-center space-x-2 text-gray-400 hover:text-white transition-colors duration-300 group"
            >
              <ArrowUp :size="16" class="group-hover:-translate-y-1 transition-transform duration-300" />
              <span class="text-sm">回到顶部</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- 浮动技能标签 -->
    <div class="absolute top-0 left-0 w-full h-full pointer-events-none overflow-hidden">
      <div 
        v-for="(skill, index) in floatingSkills"
        :key="skill"
        :class="[
          'absolute text-xs text-gray-600 opacity-20 font-mono',
          `animate-float-${index % 3}`
        ]"
        :style="{
          left: Math.random() * 80 + 10 + '%',
          top: Math.random() * 60 + 20 + '%',
          animationDelay: Math.random() * 5 + 's'
        }"
      >
        {{ skill }}
      </div>
    </div>
  </footer>
</template>

<script setup>
import { ref, computed } from 'vue'
import { 
  Mail, 
  Phone, 
  ChevronRight, 
  CheckCircle, 
  Heart, 
  Globe, 
  ArrowUp
} from 'lucide-vue-next'

// 导入 SVG 图标
import GithubIcon from '@/assets/icons/github.svg'
import CsdnIcon from '@/assets/icons/csdn.svg'
import GiteeIcon from '@/assets/icons/gitee.svg'
import ZhihuIcon from '@/assets/icons/zhihu.svg'

// 当前年份
const currentYear = computed(() => new Date().getFullYear())

// 最后更新时间
const lastUpdated = ref('2025-11-09')

// 社交链接
const socialLinks = ref([
  {
    name: 'GitHub',
    url: 'https://github.com/pengcunfu',
    icon: GithubIcon
  },
  {
    name: 'CSDN',
    url: 'https://blog.csdn.net/HuaQi666',
    icon: CsdnIcon
  },
  {
    name: 'Gitee',
    url: 'https://gitee.com/huaqiwill',
    icon: GiteeIcon
  },
  {
    name: '知乎',
    url: 'https://www.zhihu.com/people/super-10-33-97',
    icon: ZhihuIcon
  }
])

// 快速链接
const quickLinks = ref([
  { name: '首页', href: '#home', section: 'home' },
  { name: '关于我', href: '#about', section: 'about' },
  { name: '技能', href: '#skills', section: 'skills' },
  { name: '项目', href: '#projects', section: 'projects' },
  { name: '经验', href: '#experience', section: 'experience' },
  { name: '联系我', href: '#contact', section: 'contact' }
])

// 服务项目
const services = ref([
  'Web 全栈开发',
  'Android 移动开发',
  '桌面应用开发',
  '系统级编程',
  '大数据处理',
  'DevOps 自动化'
])

// 浮动技能标签
const floatingSkills = ref([
  'C/C++', 'Java', 'Kotlin', 'Python', 'Go', 'Rust', 'Scala', 'C#/.NET',
  'Vue.js', 'React', 'Android', 'Flutter', 'HarmonyOS', 'Electron',
  'Node.js', 'Spring Boot', 'Docker', 'Kubernetes', 'Linux', 'Git',
  'MySQL', 'Redis', 'MongoDB', '微服务', '大数据', '数据分析'
])

// 滚动到指定区域
const scrollToSection = (sectionId) => {
  if (!sectionId) return
  
  const element = document.getElementById(sectionId)
  if (element) {
    const offsetTop = element.offsetTop - 80
    window.scrollTo({
      top: offsetTop,
      behavior: 'smooth'
    })
  }
}

// 回到顶部
const scrollToTop = () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth'
  })
}
</script>

<style scoped>
/* 浮动动画 */
@keyframes float-0 {
  0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.1; }
  25% { transform: translateY(-20px) rotate(5deg); opacity: 0.3; }
  50% { transform: translateY(-10px) rotate(-3deg); opacity: 0.2; }
  75% { transform: translateY(-15px) rotate(2deg); opacity: 0.25; }
}

@keyframes float-1 {
  0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.15; }
  33% { transform: translateY(-25px) rotate(-4deg); opacity: 0.25; }
  66% { transform: translateY(-5px) rotate(6deg); opacity: 0.3; }
}

@keyframes float-2 {
  0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.1; }
  40% { transform: translateY(-18px) rotate(3deg); opacity: 0.35; }
  80% { transform: translateY(-8px) rotate(-5deg); opacity: 0.15; }
}

.animate-float-0 {
  animation: float-0 12s ease-in-out infinite;
}

.animate-float-1 {
  animation: float-1 15s ease-in-out infinite;
}

.animate-float-2 {
  animation: float-2 18s ease-in-out infinite;
}

/* 文字样式 */
.text-gradient {
  color: #3b82f6;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .grid.lg\\:grid-cols-4 {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .lg\\:col-span-2 {
    grid-column: span 1;
  }
  
  .flex.md\\:flex-row {
    flex-direction: column;
    align-items: center;
  }
}
</style>
