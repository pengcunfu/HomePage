<template>
  <section class="py-20 bg-primary-600 text-white relative overflow-hidden">
    <!-- 背景装饰 -->
    <div class="absolute inset-0 bg-black/20"></div>
    <div class="absolute top-0 left-0 w-full h-full">
      <div class="absolute top-20 left-10 w-64 h-64 bg-white/10 rounded-full blur-3xl"></div>
      <div class="absolute bottom-20 right-10 w-96 h-96 bg-white/5 rounded-full blur-3xl"></div>
    </div>

    <div class="container-custom relative z-10">
      <!-- 标题 -->
      <div class="text-center mb-16" data-aos="fade-up">
        <h2 class="text-3xl lg:text-4xl font-bold mb-4">数据说话</h2>
        <p class="text-xl text-white/90 max-w-2xl mx-auto">
          用数字见证我的专业能力和项目经验
        </p>
      </div>

      <!-- 统计数据网格 -->
      <div class="grid grid-cols-2 lg:grid-cols-4 gap-8">
        <div
          v-for="(stat, index) in stats"
          :key="stat.id"
          class="text-center group"
          data-aos="fade-up"
          :data-aos-delay="index * 100"
        >
          <!-- 图标容器 -->
          <div class="relative mb-6">
            <div class="w-20 h-20 mx-auto bg-white/10 backdrop-blur-md rounded-full flex items-center justify-center group-hover:bg-white/20 transition-all duration-300 group-hover:scale-110">
              <component :is="stat.icon" :size="32" class="text-white" />
            </div>
            <!-- 装饰环 -->
            <div class="absolute inset-0 w-24 h-24 mx-auto border-2 border-white/20 rounded-full animate-spin-slow"></div>
          </div>

          <!-- 数字计数器 -->
          <div class="mb-2">
            <span 
              ref="numberRefs"
              :data-target="stat.number"
              class="text-4xl lg:text-5xl font-bold block"
            >
              0
            </span>
            <span class="text-2xl font-bold">{{ stat.suffix }}</span>
          </div>

          <!-- 标签 -->
          <h3 class="text-lg font-semibold text-white/90 mb-2">{{ stat.label }}</h3>
          
          <!-- 描述 -->
          <p class="text-sm text-white/70 leading-relaxed">{{ stat.description }}</p>

          <!-- 进度条（如果有的话） -->
          <div v-if="stat.showProgress" class="mt-4">
            <div class="w-full bg-white/20 rounded-full h-2">
              <div 
                class="bg-white rounded-full h-2 transition-all duration-1000 ease-out"
                :style="{ width: countersStarted ? stat.percentage + '%' : '0%' }"
              ></div>
            </div>
            <span class="text-xs text-white/60 mt-1 block">{{ stat.percentage }}% 完成度</span>
          </div>
        </div>
      </div>

      <!-- 技能进度环 -->
      <div class="mt-20">
        <h3 class="text-2xl font-bold text-center mb-12" data-aos="fade-up">核心技能熟练度</h3>
        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div
            v-for="(skill, index) in skillCircles"
            :key="skill.name"
            class="text-center"
            data-aos="fade-up"
            :data-aos-delay="index * 150"
          >
            <!-- 环形进度条 -->
            <div class="relative w-32 h-32 mx-auto mb-4">
              <svg class="w-32 h-32 transform -rotate-90" viewBox="0 0 120 120">
                <!-- 背景圆环 -->
                <circle
                  cx="60"
                  cy="60"
                  r="50"
                  stroke="rgba(255,255,255,0.2)"
                  stroke-width="8"
                  fill="transparent"
                />
                <!-- 进度圆环 -->
                <circle
                  cx="60"
                  cy="60"
                  r="50"
                  stroke="white"
                  stroke-width="8"
                  fill="transparent"
                  stroke-linecap="round"
                  :stroke-dasharray="circumference"
                  :stroke-dashoffset="countersStarted ? circumference - (skill.percentage / 100) * circumference : circumference"
                  class="transition-all duration-2000 ease-out"
                />
              </svg>
              <!-- 百分比文字 -->
              <div class="absolute inset-0 flex items-center justify-center">
                <span class="text-2xl font-bold">{{ skill.percentage }}%</span>
              </div>
            </div>
            
            <h4 class="font-semibold text-white/90">{{ skill.name }}</h4>
            <p class="text-sm text-white/70">{{ skill.description }}</p>
          </div>
        </div>
      </div>

      <!-- 成就时间线 -->
      <div class="mt-20" data-aos="fade-up">
        <h3 class="text-2xl font-bold text-center mb-12">近期成就</h3>
        <div class="max-w-6xl mx-auto">
          <div class="grid md:grid-cols-2 gap-6">
            <div
              v-for="(achievement, index) in achievements"
              :key="achievement.id"
              class="flex items-center space-x-6 p-6 bg-white/10 backdrop-blur-md rounded-xl hover:bg-white/20 transition-all duration-300"
              data-aos="fade-up"
              :data-aos-delay="index * 100"
            >
              <!-- 图标 -->
              <div class="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
                <component :is="achievement.icon" :size="24" class="text-white" />
              </div>
              
              <!-- 内容 -->
              <div class="flex-1">
                <h4 class="text-lg font-semibold mb-1">{{ achievement.title }}</h4>
                <p class="text-white/80 text-sm mb-2">{{ achievement.description }}</p>
                <span class="text-xs text-white/60">{{ achievement.date }}</span>
              </div>
              
              <!-- 数值 -->
              <div class="text-right">
                <div class="text-2xl font-bold">{{ achievement.value }}</div>
                <div class="text-xs text-white/60">{{ achievement.metric }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { 
  Code, 
  Users, 
  Award, 
  Clock, 
  Star, 
  TrendingUp, 
  Coffee, 
  Target,
  Zap,
  Trophy,
  Rocket
} from 'lucide-vue-next'

// 响应式数据
const numberRefs = ref([])
const countersStarted = ref(false)
const circumference = 2 * Math.PI * 50 // 圆的周长

// 统计数据
const stats = ref([
  {
    id: 1,
    number: 5,
    suffix: '+',
    label: '年开发经验',
    description: '从初级到高级的技术成长历程',
    icon: Clock,
    showProgress: true,
    percentage: 85
  },
  {
    id: 2,
    number: 100,
    suffix: '+',
    label: '完成项目',
    description: '涵盖前端、后端、全栈等各类项目',
    icon: Code,
    showProgress: true,
    percentage: 92
  },
  {
    id: 3,
    number: 50,
    suffix: '+',
    label: '满意客户',
    description: '提供高质量的技术解决方案',
    icon: Users,
    showProgress: true,
    percentage: 95
  },
  {
    id: 4,
    number: 1000,
    suffix: '+',
    label: '代码提交',
    description: '持续不断的代码贡献和优化',
    icon: Award,
    showProgress: true,
    percentage: 88
  }
])

// 技能环形图
const skillCircles = ref([
  {
    name: '前端开发',
    percentage: 90,
    description: 'Vue/React/TypeScript'
  },
  {
    name: '后端开发',
    percentage: 85,
    description: 'Node.js/Python/Java'
  },
  {
    name: '数据库',
    percentage: 80,
    description: 'MySQL/MongoDB/Redis'
  },
  {
    name: '云服务',
    percentage: 75,
    description: 'AWS/Docker/K8s'
  }
])

// 成就数据
const achievements = ref([
  {
    id: 1,
    title: '项目成功交付',
    description: '按时高质量交付大型SaaS平台项目',
    date: '2025年8月',
    value: '100%',
    metric: '按时交付率',
    icon: Trophy
  },
  {
    id: 2,
    title: '性能优化成果',
    description: '系统响应时间优化至毫秒级别',
    date: '2025年6月',
    value: '50%',
    metric: '性能提升',
    icon: Zap
  },
  {
    id: 3,
    title: '团队技能提升',
    description: '指导团队成员掌握新技术栈',
    date: '2025年4月',
    value: '5',
    metric: '团队成员',
    icon: Target
  },
  {
    id: 4,
    title: '技术创新',
    description: '引入微服务架构提升系统扩展性',
    date: '2025年2月',
    value: '300%',
    metric: '扩展性提升',
    icon: Rocket
  }
])

// 数字动画
const animateNumber = (element, start, end, duration) => {
  let startTime = null
  
  const animate = (currentTime) => {
    if (startTime === null) startTime = currentTime
    const timeElapsed = currentTime - startTime
    const progress = Math.min(timeElapsed / duration, 1)
    
    // 使用缓动函数
    const easeOutQuart = 1 - Math.pow(1 - progress, 4)
    const current = Math.floor(start + (end - start) * easeOutQuart)
    
    element.textContent = current
    
    if (progress < 1) {
      requestAnimationFrame(animate)
    } else {
      element.textContent = end
    }
  }
  
  requestAnimationFrame(animate)
}

// 启动计数器动画
const startCounters = () => {
  countersStarted.value = true
  
  nextTick(() => {
    const elements = document.querySelectorAll('[data-target]')
    elements.forEach((element, index) => {
      const target = parseInt(element.getAttribute('data-target'))
      setTimeout(() => {
        animateNumber(element, 0, target, 2000)
      }, index * 200)
    })
  })
}

// 滚动监听
const handleScroll = () => {
  const section = document.querySelector('.py-20.bg-primary-600')
  if (section) {
    const rect = section.getBoundingClientRect()
    if (rect.top < window.innerHeight && rect.bottom > 0 && !countersStarted.value) {
      startCounters()
    }
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  handleScroll() // 初始检查
})
</script>

<style scoped>
/* 自定义动画 */
@keyframes spin-slow {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.animate-spin-slow {
  animation: spin-slow 8s linear infinite;
}

/* 悬停效果 */
.group:hover .absolute {
  animation-duration: 4s;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .grid.grid-cols-2 {
    gap: 1.5rem;
  }
  
  .text-4xl {
    font-size: 2rem;
  }
  
  .w-32.h-32 {
    width: 6rem;
    height: 6rem;
  }
}
</style>
