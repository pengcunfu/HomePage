<template>
  <section id="home" class="hero-section relative min-h-screen flex items-center overflow-hidden">
    <!-- 背景装饰 -->
    <div class="absolute inset-0 bg-blue-50"></div>
    
    <!-- 装饰性形状 -->
    <div class="absolute top-20 left-10 w-72 h-72 bg-primary-100 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob"></div>
    <div class="absolute top-40 right-10 w-72 h-72 bg-secondary-100 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob animation-delay-2000"></div>
    <div class="absolute -bottom-8 left-20 w-72 h-72 bg-pink-100 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob animation-delay-4000"></div>
    
    <div class="container-custom relative z-10">
      <div class="max-w-4xl mx-auto text-center lg:text-left">
        <!-- 主要内容 -->
        <div class="space-y-8" data-aos="fade-up" data-aos-duration="1000">
          <!-- 问候语 -->
          <div class="inline-flex items-center px-2 py-1.5 xs:px-3 xs:py-2 sm:px-4 sm:py-2 bg-primary-50 rounded-full text-primary-700 font-medium text-xs xs:text-sm sm:text-base max-w-fit">
            <span class="w-1.5 h-1.5 xs:w-2 xs:h-2 bg-primary-500 rounded-full mr-1.5 xs:mr-2 animate-pulse flex-shrink-0"></span>
            <span class="whitespace-nowrap">你好，这里是</span>
          </div>
          
          <!-- 主标题 -->
          <div class="space-y-4">
            <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold font-heading">
              <span class="block text-dark-900">我是</span>
              <span class="block text-gradient" ref="typedElement">黎明怀羽</span>
            </h1>
            
            <!-- 职业描述 -->
            <div class="text-xl md:text-2xl text-dark-600 font-medium">
              <span ref="jobTitleElement">全栈开发工程师</span>
            </div>
          </div>
          
          <!-- 技能标签 -->
          <div class="flex flex-wrap gap-3">
            <span
              v-for="(skill, index) in skills"
              :key="skill"
              :data-aos="'fade-up'"
              :data-aos-delay="index * 100"
              class="px-4 py-2 bg-white/70 backdrop-blur-sm rounded-full text-dark-700 font-medium shadow-sm hover:shadow-md transition-all duration-300 hover:scale-105"
            >
              {{ skill }}
            </span>
          </div>
          
          <!-- 描述文本 -->
          <p class="text-lg text-dark-600 leading-relaxed max-w-lg" data-aos="fade-up" data-aos-delay="400">
            专注于现代Web技术栈开发，拥有丰富的全栈开发经验。热爱编程，追求代码质量与用户体验的完美结合。
          </p>
          
          <!-- 行动按钮 -->
          <div class="flex flex-col sm:flex-row gap-4" data-aos="fade-up" data-aos-delay="600">
            <a
              href="#projects"
              class="btn btn-primary group"
              @click="scrollToSection('projects')"
            >
              查看我的作品
              <ArrowRight :size="20" class="ml-2 group-hover:translate-x-1 transition-transform duration-300" />
            </a>
            
            <a
              href="#contact"
              class="btn btn-secondary group"
              @click="scrollToSection('contact')"
            >
              联系我
              <Mail :size="20" class="ml-2" />
            </a>
          </div>
          
          <!-- 社交链接 -->
          <div class="flex justify-center lg:justify-start items-center space-x-6" data-aos="fade-up" data-aos-delay="800">
            <span class="text-dark-500 font-medium">关注我：</span>
            <div class="flex space-x-4">
              <a
                v-for="social in socialLinks"
                :key="social.name"
                :href="social.url"
                :aria-label="social.name"
                class="p-2 hover:scale-110 transform transition-all duration-300"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img :src="social.icon" :alt="social.name" class="w-6 h-6 opacity-70 hover:opacity-100 transition-opacity" />
              </a>
            </div>
          </div>

          <!-- 统计卡片区域 -->
          <div class="flex flex-col sm:flex-row gap-6 justify-center lg:justify-start mt-8" data-aos="fade-up" data-aos-delay="1000">
            <div class="bg-white rounded-lg shadow-lg p-6 transform hover:scale-105 transition-all duration-300">
              <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                  <Code :size="24" class="text-primary-600" />
                </div>
                <div>
                  <div class="font-semibold text-dark-900 text-lg">5+</div>
                  <div class="text-sm text-dark-500">年开发经验</div>
                </div>
              </div>
            </div>

            <div class="bg-white rounded-lg shadow-lg p-6 transform hover:scale-105 transition-all duration-300">
              <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-secondary-100 rounded-lg flex items-center justify-center">
                  <Award :size="24" class="text-secondary-600" />
                </div>
                <div>
                  <div class="font-semibold text-dark-900 text-lg">100+</div>
                  <div class="text-sm text-dark-500">项目完成</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 滚动指示器 -->
      <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
        <button
          @click="scrollToNext"
          class="p-2 text-dark-400 hover:text-primary-600 transition-colors duration-300"
          aria-label="向下滚动"
        >
          <ChevronDown :size="24" />
        </button>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ArrowRight, Mail, ChevronDown, Code, Award } from 'lucide-vue-next'
import Typed from 'typed.js'

// 导入 SVG 图标
import GithubIcon from '@/assets/icons/github.svg'
import CsdnIcon from '@/assets/icons/csdn.svg'
import GiteeIcon from '@/assets/icons/gitee.svg'
import ZhihuIcon from '@/assets/icons/zhihu.svg'

// 响应式数据
const typedElement = ref(null)
const jobTitleElement = ref(null)

// 技能列表
const skills = ref([
  'C/C++', 'Java', 'Python', 'Go', 'Android', 'Flutter', 'Vue.js', 'React', 
  'Node.js', 'Rust', 'Kotlin', 'Docker', 'K8s', 'Linux', '微服务', '大数据'
])

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

// 滚动到下一个区域
const scrollToNext = () => {
  scrollToSection('about')
}

onMounted(() => {
  // 初始化打字机效果
  if (typedElement.value) {
    new Typed(typedElement.value, {
      strings: ['黎明怀羽', '全栈开发者', '编程爱好者'],
      typeSpeed: 100,
      backSpeed: 50,
      backDelay: 2000,
      startDelay: 500,
      loop: true,
      showCursor: true,
      cursorChar: '|'
    })
  }
  
  // 职业描述打字效果
  if (jobTitleElement.value) {
    setTimeout(() => {
      new Typed(jobTitleElement.value, {
        strings: [
          '全栈开发工程师',
          '前端开发专家', 
          '后端架构师',
          '技术顾问'
        ],
        typeSpeed: 80,
        backSpeed: 40,
        backDelay: 3000,
        startDelay: 1000,
        loop: true,
        showCursor: false
      })
    }, 2000)
  }
})
</script>

<style scoped>
/* 自定义动画 */
@keyframes blob {
  0% {
    transform: translate(0px, 0px) scale(1);
  }
  33% {
    transform: translate(30px, -50px) scale(1.1);
  }
  66% {
    transform: translate(-20px, 20px) scale(0.9);
  }
  100% {
    transform: translate(0px, 0px) scale(1);
  }
}

.animate-blob {
  animation: blob 7s infinite;
}

.animation-delay-2000 {
  animation-delay: 2s;
}

.animation-delay-4000 {
  animation-delay: 4s;
}

/* 文字样式 */
.text-gradient {
  color: #3b82f6;
}

/* 浮动动画优化 */
.animate-float {
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-20px);
  }
}

/* 响应式调整 */
@media (max-width: 1024px) {
  .hero-section {
    min-height: 100vh;
    padding-top: 80px;
  }
  
  .grid.lg\\:grid-cols-2 {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
}

@media (max-width: 900px) {
  .hero-section {
    padding-top: 90px;
  }
  
  .text-4xl {
    font-size: 2.75rem;
  }
  
  .text-xl {
    font-size: 1.375rem;
  }
  
  .space-y-8 > * + * {
    margin-top: 1.75rem;
  }
}

@media (max-width: 768px) {
  .hero-section {
    padding-top: 100px;
  }
  
  .text-4xl {
    font-size: 2.5rem;
  }
  
  .text-xl {
    font-size: 1.25rem;
  }
  
  .space-y-8 > * + * {
    margin-top: 1.5rem;
  }
}

@media (max-width: 700px) {
  .hero-section {
    padding-top: 110px;
  }
  
  .text-4xl {
    font-size: 2.25rem;
  }
  
  .text-xl {
    font-size: 1.125rem;
  }
  
  .container-custom {
    padding-left: 1rem;
    padding-right: 1rem;
  }
}

@media (max-width: 480px) {
  .hero-section {
    padding-top: 120px;
  }
  
  .text-4xl {
    font-size: 2rem;
  }
  
  .text-xl {
    font-size: 1rem;
  }
  
  .space-y-8 > * + * {
    margin-top: 1.25rem;
  }
  
  .container-custom {
    padding-left: 0.75rem;
    padding-right: 0.75rem;
  }
}

/* 打字机光标样式 */
.typed-cursor {
  opacity: 1;
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 50% {
    opacity: 1;
  }
  51%, 100% {
    opacity: 0;
  }
}
</style>
