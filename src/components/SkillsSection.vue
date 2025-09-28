<template>
  <section id="skills" class="py-20 lg:py-32 bg-white">
    <div class="container-custom">
      <!-- 标题部分 -->
      <div class="text-center mb-16" data-aos="fade-up">
        <h5 class="text-primary-600 font-semibold mb-2 uppercase tracking-wider">我的技能</h5>
        <h2 class="section-title mb-4">技术栈与专业技能</h2>
        <div class="w-16 h-1 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-full mx-auto mb-6"></div>
        <p class="section-subtitle max-w-2xl mx-auto">
          多年的开发经验让我掌握了全栈开发所需的各种技术，从前端框架到后端服务，从数据库到云部署。
        </p>
      </div>

      <!-- 技能分类 -->
      <div class="grid lg:grid-cols-3 gap-8 mb-16">
        <div 
          v-for="(category, index) in skillCategories"
          :key="category.title"
          class="skill-category card p-8 text-center group"
          data-aos="fade-up"
          :data-aos-delay="index * 200"
        >
          <div class="mb-6">
            <div class="w-16 h-16 mx-auto bg-gradient-to-br from-primary-500 to-secondary-500 rounded-xl flex items-center justify-center text-white text-2xl group-hover:scale-110 transition-transform duration-300">
              <component :is="category.icon" :size="32" />
            </div>
          </div>
          <h3 class="text-xl font-bold text-gray-900 mb-4">{{ category.title }}</h3>
          <p class="text-gray-600 mb-6">{{ category.description }}</p>
          <div class="flex flex-wrap gap-2 justify-center">
            <span
              v-for="skill in category.skills"
              :key="skill"
              class="px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm font-medium hover:bg-primary-100 hover:text-primary-700 transition-colors duration-200"
            >
              {{ skill }}
            </span>
          </div>
        </div>
      </div>

      <!-- 详细技能展示 -->
      <div class="grid md:grid-cols-2 gap-12">
        <!-- 技术技能 -->
        <div data-aos="fade-right">
          <h3 class="text-2xl font-bold text-gray-900 mb-8">技术能力</h3>
          <div class="space-y-6">
            <div 
              v-for="skill in technicalSkills"
              :key="skill.name"
              class="skill-item"
            >
              <div class="flex justify-between items-center mb-3">
                <div class="flex items-center">
                  <div class="w-8 h-8 mr-3 rounded-lg bg-gradient-to-br from-primary-500 to-secondary-500 flex items-center justify-center">
                    <component :is="skill.icon" :size="16" class="text-white" />
                  </div>
                  <span class="font-medium text-gray-800">{{ skill.name }}</span>
                </div>
                <span class="text-sm font-semibold text-primary-600">{{ skill.level }}%</span>
              </div>
              <div class="skill-bar">
                <div 
                  class="skill-progress relative overflow-hidden"
                  :style="{ width: skillsInView ? skill.level + '%' : '0%' }"
                >
                  <div class="absolute inset-0 bg-gradient-to-r from-primary-500 to-secondary-500"></div>
                  <div class="absolute inset-0 bg-white opacity-20 animate-pulse"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 软技能和认证 -->
        <div data-aos="fade-left">
          <h3 class="text-2xl font-bold text-gray-900 mb-8">软技能 & 认证</h3>
          
          <!-- 软技能 -->
          <div class="mb-8">
            <h4 class="text-lg font-semibold text-gray-800 mb-4">核心素养</h4>
            <div class="grid grid-cols-2 gap-4">
              <div 
                v-for="softSkill in softSkills"
                :key="softSkill.name"
                class="flex items-center p-3 bg-gray-50 rounded-lg hover:bg-primary-50 transition-colors duration-200"
              >
                <div class="w-8 h-8 mr-3 rounded-lg bg-gradient-to-br from-green-400 to-blue-500 flex items-center justify-center">
                  <component :is="softSkill.icon" :size="16" class="text-white" />
                </div>
                <span class="text-sm font-medium text-gray-700">{{ softSkill.name }}</span>
              </div>
            </div>
          </div>

          <!-- 认证和成就 -->
          <div>
            <h4 class="text-lg font-semibold text-gray-800 mb-4">认证 & 成就</h4>
            <div class="space-y-3">
              <div 
                v-for="cert in certifications"
                :key="cert.name"
                class="flex items-center p-4 bg-gradient-to-r from-white to-gray-50 rounded-lg border border-gray-200 hover:border-primary-200 hover:shadow-md transition-all duration-200"
              >
                <div class="w-10 h-10 mr-4 rounded-lg bg-gradient-to-br from-yellow-400 to-orange-500 flex items-center justify-center">
                  <Award :size="20" class="text-white" />
                </div>
                <div>
                  <div class="font-medium text-gray-800">{{ cert.name }}</div>
                  <div class="text-sm text-gray-600">{{ cert.issuer }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 技能标签云 -->
      <div class="mt-16" data-aos="fade-up">
        <h3 class="text-2xl font-bold text-gray-900 text-center mb-8">技术关键词</h3>
        <div class="flex flex-wrap justify-center gap-3">
          <span
            v-for="(tag, index) in skillTags"
            :key="tag"
            :class="[
              'px-4 py-2 rounded-full font-medium transition-all duration-300 hover:scale-105 cursor-default',
              getTagStyle(index)
            ]"
            :data-aos="'zoom-in'"
            :data-aos-delay="index * 50"
          >
            {{ tag }}
          </span>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { 
  Code, 
  Database, 
  Cloud, 
  Users, 
  MessageSquare, 
  Target, 
  Clock, 
  Award,
  Lightbulb,
  Heart
} from 'lucide-vue-next'

// 响应式数据
const skillsInView = ref(false)

// 技能分类
const skillCategories = ref([
  {
    title: '前端开发',
    description: '现代化的用户界面设计与开发',
    icon: Code,
    skills: ['Vue.js', 'React', 'TypeScript', 'Tailwind CSS', 'Vite']
  },
  {
    title: '后端开发', 
    description: '高性能的服务端应用架构',
    icon: Database,
    skills: ['Node.js', 'Python', 'Java', 'Go', 'Express', 'FastAPI']
  },
  {
    title: '云服务 & DevOps',
    description: '现代化的部署与运维方案',
    icon: Cloud,
    skills: ['Docker', 'Kubernetes', 'AWS', 'CI/CD', 'Nginx']
  }
])

// 技术技能
const technicalSkills = ref([
  { name: 'JavaScript/TypeScript', level: 95, icon: Code },
  { name: 'Vue.js & React', level: 90, icon: Code },
  { name: 'Node.js & Python', level: 85, icon: Database },
  { name: 'Database Design', level: 80, icon: Database },
  { name: 'Cloud Architecture', level: 75, icon: Cloud },
  { name: 'DevOps & CI/CD', level: 70, icon: Cloud }
])

// 软技能
const softSkills = ref([
  { name: '团队协作', icon: Users },
  { name: '沟通能力', icon: MessageSquare },
  { name: '问题解决', icon: Target },
  { name: '时间管理', icon: Clock },
  { name: '创新思维', icon: Lightbulb },
  { name: '持续学习', icon: Heart }
])

// 认证
const certifications = ref([
  { name: 'AWS Certified Solutions Architect', issuer: 'Amazon Web Services' },
  { name: 'Google Cloud Professional', issuer: 'Google Cloud' },
  { name: 'Certified Kubernetes Administrator', issuer: 'Cloud Native Computing Foundation' }
])

// 技能标签
const skillTags = ref([
  'JavaScript', 'TypeScript', 'Vue.js', 'React', 'Node.js', 'Python', 'Java', 'Go',
  'Express', 'FastAPI', 'Spring Boot', 'MongoDB', 'PostgreSQL', 'Redis', 'Docker',
  'Kubernetes', 'AWS', 'GCP', 'CI/CD', 'Git', 'Linux', 'Nginx', 'Webpack', 'Vite',
  'Tailwind CSS', 'SASS', 'REST API', 'GraphQL', 'WebSocket', 'Microservices'
])

// 获取标签样式
const getTagStyle = (index) => {
  const styles = [
    'bg-blue-100 text-blue-800 hover:bg-blue-200',
    'bg-green-100 text-green-800 hover:bg-green-200', 
    'bg-purple-100 text-purple-800 hover:bg-purple-200',
    'bg-pink-100 text-pink-800 hover:bg-pink-200',
    'bg-yellow-100 text-yellow-800 hover:bg-yellow-200',
    'bg-indigo-100 text-indigo-800 hover:bg-indigo-200'
  ]
  return styles[index % styles.length]
}

// 监听滚动
const handleScroll = () => {
  const skillsSection = document.getElementById('skills')
  if (skillsSection) {
    const rect = skillsSection.getBoundingClientRect()
    if (rect.top < window.innerHeight && rect.bottom > 0) {
      skillsInView.value = true
    }
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  handleScroll()
})
</script>

<style scoped>
/* 技能分类卡片悬停效果 */
.skill-category {
  transition: all 0.3s ease;
}

.skill-category:hover {
  transform: translateY(-8px);
}

/* 技能进度条增强动画 */
.skill-progress {
  transition: width 2s ease-out;
  position: relative;
}

.skill-progress::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
  transform: translateX(-100%);
  animation: shimmer 2s ease-out;
}

@keyframes shimmer {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .grid.md\\:grid-cols-2 {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .skill-category {
    padding: 1.5rem;
  }
}
</style>
