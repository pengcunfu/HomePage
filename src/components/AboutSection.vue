<template>
  <section id="about" class="py-20 lg:py-32 bg-gray-50">
    <div class="container-custom">
      <div class="grid lg:grid-cols-2 gap-16 items-center">
        <!-- 左侧图片 -->
        <div class="order-2 lg:order-1" data-aos="fade-right" data-aos-duration="1000">
          <div class="relative">
            <!-- 主图片 -->
            <div class="relative z-10">
              <img
                src="@/assets/images/about_hero.png"
                alt="关于彭存福"
                class="w-full max-w-md mx-auto rounded-2xl shadow-2xl"
              />
            </div>
            
            <!-- 背景装饰 -->
            <div class="absolute inset-0 bg-primary-400 rounded-2xl transform rotate-6 scale-105 opacity-20"></div>
            
            <!-- 技能徽章 -->
            <div 
              class="absolute -top-6 -right-6 bg-white rounded-full p-4 shadow-lg"
              data-aos="zoom-in"
              data-aos-delay="500"
            >
              <div class="text-center">
                <div class="text-2xl font-bold text-primary-600">5+</div>
                <div class="text-xs text-gray-600">年经验</div>
              </div>
            </div>
            
            <div 
              class="absolute -bottom-6 -left-6 bg-white rounded-full p-4 shadow-lg"
              data-aos="zoom-in"
              data-aos-delay="700"
            >
              <div class="text-center">
                <div class="text-2xl font-bold text-secondary-600">100+</div>
                <div class="text-xs text-gray-600">项目</div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 右侧内容 -->
        <div class="order-1 lg:order-2" data-aos="fade-left" data-aos-duration="1000">
          <!-- 标题部分 -->
          <div class="mb-8">
            <h5 class="text-primary-600 font-semibold mb-2 uppercase tracking-wider">关于我</h5>
            <h2 class="section-title mb-4">
              为什么选择我？
            </h2>
            <div class="w-16 h-1 bg-primary-500 rounded-full"></div>
          </div>
          
          <!-- 个人介绍 -->
          <div class="space-y-6 mb-8">
            <p class="text-lg text-gray-600 leading-relaxed">
              我是一名充满激情的全栈开发工程师，拥有5年以上的开发经验。专注于使用现代技术栈构建高质量的Web应用程序。
            </p>
            
            <p class="text-gray-600 leading-relaxed">
              毕业于计算机科学专业，在前端和后端开发方面都有深厚的技术积累。擅长Vue.js、React、Node.js、Python、Java等技术栈，
              同时对云计算、微服务架构和DevOps也有丰富的实践经验。
            </p>
            
            <div class="grid md:grid-cols-2 gap-6 mt-8">
              <div class="space-y-4">
                <h4 class="font-semibold text-gray-900 mb-3">个人信息</h4>
                <div class="space-y-2 text-sm text-gray-600">
                  <div class="flex items-center">
                    <Mail :size="16" class="mr-2 text-primary-500" />
                    <span>3173484026@qq.com</span>
                  </div>
                  <div class="flex items-center">
                    <MapPin :size="16" class="mr-2 text-primary-500" />
                    <span>中国</span>
                  </div>
                  <div class="flex items-center">
                    <Calendar :size="16" class="mr-2 text-primary-500" />
                    <span>可随时开始</span>
                  </div>
                </div>
              </div>
              
              <div class="space-y-4">
                <h4 class="font-semibold text-gray-900 mb-3">专业领域</h4>
                <div class="space-y-2 text-sm text-gray-600">
                  <div class="flex items-center">
                    <CheckCircle :size="16" class="mr-2 text-green-500" />
                    <span>全栈Web开发</span>
                  </div>
                  <div class="flex items-center">
                    <CheckCircle :size="16" class="mr-2 text-green-500" />
                    <span>移动应用开发</span>
                  </div>
                  <div class="flex items-center">
                    <CheckCircle :size="16" class="mr-2 text-green-500" />
                    <span>云架构设计</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 技能进度条 -->
          <div class="space-y-6 mb-8">
            <h4 class="font-semibold text-gray-900 mb-4">核心技能</h4>
            <div 
              v-for="skill in skills"
              :key="skill.name"
              class="skill-item"
              data-aos="fade-up"
              :data-aos-delay="skill.delay"
            >
              <div class="flex justify-between items-center mb-2">
                <span class="font-medium text-gray-700">{{ skill.name }}</span>
                <span class="text-sm font-semibold text-primary-600">{{ skill.level }}%</span>
              </div>
              <div class="skill-bar">
                <div 
                  class="skill-progress"
                  :style="{ width: skillInView ? skill.level + '%' : '0%' }"
                ></div>
              </div>
            </div>
          </div>
          
          <!-- 行动按钮 -->
          <div class="flex flex-col sm:flex-row gap-4">
            <a
              href="#projects"
              class="btn btn-primary"
              @click="scrollToSection('projects')"
            >
              查看我的作品
            </a>
            <button
              @click="downloadResume"
              class="btn btn-secondary group"
            >
              下载简历
              <Download :size="20" class="ml-2 group-hover:translate-y-1 transition-transform duration-300" />
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Mail, MapPin, Calendar, CheckCircle, Download } from 'lucide-vue-next'

// 响应式数据
const skillInView = ref(false)

// 技能数据
const skills = ref([
  { name: '前端开发 (Vue/React)', level: 90, delay: 100 },
  { name: '后端开发 (Node.js/Python)', level: 85, delay: 200 },
  { name: '数据库设计', level: 80, delay: 300 },
  { name: '云服务部署', level: 75, delay: 400 }
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

// 下载简历
const downloadResume = () => {
  // 这里可以实现简历下载功能
  const link = document.createElement('a')
  link.href = '/resume.pdf' // 假设简历文件路径
  link.download = '彭存福_简历.pdf'
  link.click()
}

// 监听滚动，触发技能动画
const handleScroll = () => {
  const aboutSection = document.getElementById('about')
  if (aboutSection) {
    const rect = aboutSection.getBoundingClientRect()
    if (rect.top < window.innerHeight && rect.bottom > 0) {
      skillInView.value = true
    }
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  handleScroll() // 初始检查
})
</script>

<style scoped>
/* 技能进度条动画 */
.skill-progress {
  transition: width 1.5s ease-out;
}

/* 悬停效果 */
.skill-item:hover .skill-progress {
  box-shadow: 0 0 20px rgba(59, 130, 246, 0.5);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .grid {
    gap: 8;
  }
  
  .section-title {
    font-size: 2rem;
  }
}
</style>
