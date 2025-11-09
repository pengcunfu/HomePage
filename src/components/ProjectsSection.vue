<template>
  <section id="projects" class="py-20 lg:py-32 bg-gray-50">
    <div class="container-custom">
      <!-- 标题部分 -->
      <div class="text-center mb-16" data-aos="fade-up">
        <h5 class="text-primary-600 font-semibold mb-2 uppercase tracking-wider">我的作品</h5>
        <h2 class="section-title mb-4">精选项目展示</h2>
        <div class="w-16 h-1 bg-primary-500 rounded-full mx-auto mb-6"></div>
        <p class="section-subtitle max-w-2xl mx-auto">
          以下是我近期完成的一些代表性项目，涵盖了前端开发、后端架构、全栈应用等多个领域。
        </p>
      </div>

      <!-- 项目过滤器 -->
      <div class="flex flex-wrap justify-center gap-4 mb-12" data-aos="fade-up" data-aos-delay="200">
        <button
          v-for="filter in filters"
          :key="filter"
          @click="activeFilter = filter"
          :class="[
            'px-6 py-2 rounded-full font-medium transition-all duration-300',
            activeFilter === filter
              ? 'bg-primary-600 text-white shadow-lg'
              : 'bg-white text-gray-600 hover:bg-primary-50 hover:text-primary-600'
          ]"
        >
          {{ filter }}
        </button>
      </div>

      <!-- 项目网格 -->
      <div class="project-grid">
        <div
          v-for="(project, index) in filteredProjects"
          :key="project.id"
          class="project-card group"
          data-aos="fade-up"
          :data-aos-delay="index * 100"
        >
          <!-- 项目图片 -->
          <div class="project-image-container">
            <img
              :src="project.image"
              :alt="project.title"
              class="project-image"
            />
            <!-- 悬停遮罩 -->
            <div class="project-overlay">
              <div class="flex space-x-4">
                <button
                  @click="openProjectModal(project)"
                  class="p-3 bg-white text-primary-600 rounded-full hover:bg-primary-600 hover:text-white transition-all duration-300 transform hover:scale-110"
                  aria-label="查看详情"
                >
                  <Eye :size="20" />
                </button>
                <a
                  :href="project.liveUrl"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="p-3 bg-white text-primary-600 rounded-full hover:bg-primary-600 hover:text-white transition-all duration-300 transform hover:scale-110"
                  aria-label="访问网站"
                >
                  <ExternalLink :size="20" />
                </a>
                <a
                  :href="project.githubUrl"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="p-3 bg-white text-primary-600 rounded-full hover:bg-primary-600 hover:text-white transition-all duration-300 transform hover:scale-110"
                  aria-label="查看代码"
                >
                  <Github :size="20" />
                </a>
              </div>
            </div>
          </div>

          <!-- 项目内容 -->
          <div class="project-content">
            <!-- 技术标签 -->
            <div class="flex flex-wrap gap-2 mb-3">
              <span
                v-for="tech in project.technologies"
                :key="tech"
                class="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded-full"
              >
                {{ tech }}
              </span>
            </div>

            <!-- 项目标题 -->
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors duration-300">
              {{ project.title }}
            </h3>

            <!-- 项目描述 -->
            <p class="text-gray-600 text-sm mb-4 text-truncate-3">
              {{ project.description }}
            </p>

            <!-- 项目特性 -->
            <div class="space-y-2 mb-4">
              <div
                v-for="feature in project.features.slice(0, 2)"
                :key="feature"
                class="flex items-center text-sm text-gray-600"
              >
                <CheckCircle :size="14" class="mr-2 text-green-500 flex-shrink-0" />
                <span>{{ feature }}</span>
              </div>
            </div>

            <!-- 项目统计 -->
            <div class="flex justify-between items-center pt-4 border-t border-gray-100">
              <div class="flex items-center space-x-4 text-sm text-gray-500">
                <div class="flex items-center">
                  <Star :size="14" class="mr-1 text-yellow-500" />
                  <span>{{ project.stars }}</span>
                </div>
                <div class="flex items-center">
                  <GitBranch :size="14" class="mr-1" />
                  <span>{{ project.forks }}</span>
                </div>
              </div>
              <span class="text-xs text-gray-400">{{ project.year }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 查看更多按钮 -->
      <div class="text-center mt-12" data-aos="fade-up">
        <a
          href="https://github.com/huaqiwill"
          target="_blank"
          rel="noopener noreferrer"
          class="btn btn-secondary group"
        >
          查看更多项目
          <ExternalLink :size="20" class="ml-2 group-hover:translate-x-1 transition-transform duration-300" />
        </a>
      </div>
    </div>

    <!-- 项目详情模态框 -->
    <Teleport to="body">
      <Transition name="modal">
        <div
          v-if="selectedProject"
          class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70 backdrop-blur-sm"
          @click="closeProjectModal"
        >
          <div
            class="bg-white rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto"
            @click.stop
          >
            <!-- 模态框内容 -->
            <div class="relative">
              <!-- 关闭按钮 -->
              <button
                @click="closeProjectModal"
                class="absolute top-4 right-4 z-10 p-2 bg-white/90 rounded-full hover:bg-white transition-colors duration-200"
              >
                <X :size="20" />
              </button>

              <!-- 项目图片 -->
              <div class="aspect-video bg-gray-100 rounded-t-2xl overflow-hidden">
                <img
                  :src="selectedProject.image"
                  :alt="selectedProject.title"
                  class="w-full h-full object-cover"
                />
              </div>

              <!-- 项目详细信息 -->
              <div class="p-8">
                <div class="grid md:grid-cols-3 gap-8">
                  <div class="md:col-span-2">
                    <!-- 标题和描述 -->
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">{{ selectedProject.title }}</h3>
                    <p class="text-gray-600 mb-6 leading-relaxed">{{ selectedProject.fullDescription }}</p>

                    <!-- 项目特性 -->
                    <h4 class="text-lg font-semibold text-gray-900 mb-4">主要特性</h4>
                    <ul class="space-y-2 mb-6">
                      <li
                        v-for="feature in selectedProject.features"
                        :key="feature"
                        class="flex items-start"
                      >
                        <CheckCircle :size="16" class="mr-2 text-green-500 mt-0.5 flex-shrink-0" />
                        <span class="text-gray-600">{{ feature }}</span>
                      </li>
                    </ul>

                    <!-- 技术挑战 -->
                    <h4 class="text-lg font-semibold text-gray-900 mb-4">技术挑战</h4>
                    <p class="text-gray-600 mb-6">{{ selectedProject.challenges }}</p>
                  </div>

                  <div>
                    <!-- 项目信息 -->
                    <div class="bg-gray-50 rounded-xl p-6">
                      <h4 class="text-lg font-semibold text-gray-900 mb-4">项目信息</h4>
                      <div class="space-y-3 text-sm">
                        <div>
                          <span class="font-medium text-gray-700">类型：</span>
                          <span class="text-gray-600">{{ selectedProject.category }}</span>
                        </div>
                        <div>
                          <span class="font-medium text-gray-700">完成时间：</span>
                          <span class="text-gray-600">{{ selectedProject.year }}</span>
                        </div>
                        <div>
                          <span class="font-medium text-gray-700">开发周期：</span>
                          <span class="text-gray-600">{{ selectedProject.duration }}</span>
                        </div>
                      </div>
                    </div>

                    <!-- 技术栈 -->
                    <div class="mt-6">
                      <h4 class="text-lg font-semibold text-gray-900 mb-4">技术栈</h4>
                      <div class="flex flex-wrap gap-2">
                        <span
                          v-for="tech in selectedProject.technologies"
                          :key="tech"
                          class="px-3 py-1 bg-primary-100 text-primary-700 text-sm font-medium rounded-full"
                        >
                          {{ tech }}
                        </span>
                      </div>
                    </div>

                    <!-- 操作按钮 -->
                    <div class="mt-6 space-y-3">
                      <a
                        :href="selectedProject.liveUrl"
                        target="_blank"
                        rel="noopener noreferrer"
                        class="btn btn-primary w-full text-center"
                      >
                        访问网站
                      </a>
                      <a
                        :href="selectedProject.githubUrl"
                        target="_blank"
                        rel="noopener noreferrer"
                        class="btn btn-secondary w-full text-center"
                      >
                        查看代码
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup>
import { ref, computed } from 'vue'
import { 
  Eye, 
  ExternalLink, 
  Github, 
  CheckCircle, 
  Star, 
  GitBranch, 
  X 
} from 'lucide-vue-next'

// 导入图片
import project1Img from '@/assets/images/project-1.jpg'
import project2Img from '@/assets/images/project-2.jpg'
import project3Img from '@/assets/images/project-3.jpg'

// 响应式数据
const activeFilter = ref('全部')
const selectedProject = ref(null)

// 过滤器选项
const filters = ref(['全部', '前端', '后端', '全栈', '移动端', '工具'])

// 项目数据
const projects = ref([
  {
    id: 1,
    title: 'CSDN 博客采集系统',
    description: '基于Python开发的智能博客内容采集与分析系统，支持多平台数据采集。',
    fullDescription: '这是一个功能强大的博客采集系统，支持从CSDN等技术博客平台自动采集文章内容，进行智能分析和分类。系统具备高并发处理能力，支持分布式部署，并提供丰富的数据可视化功能。',
    image: project3Img,
    category: '后端',
    technologies: ['Python', 'Scrapy', 'Redis', 'MongoDB', 'Docker'],
    features: [
      '多平台内容采集',
      '智能去重和分类',
      '高并发处理',
      '分布式架构',
      '数据可视化'
    ],
    challenges: '主要挑战包括反爬虫机制的突破、大规模数据的高效存储和处理、以及系统的可扩展性设计。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 45,
    forks: 12,
    year: '2025',
    duration: '3个月'
  },
  {
    id: 2,
    title: '小红书自动化系统',
    description: '基于Python的小红书内容自动化发布与管理系统，提供内容调度和数据分析功能。',
    fullDescription: '专为内容创作者设计的自动化运营工具，支持内容的定时发布、数据监控、粉丝互动管理等功能。系统采用模块化设计，易于扩展和维护。',
    image: project1Img,
    category: '工具',
    technologies: ['Python', 'Selenium', 'FastAPI', 'Vue.js', 'MySQL'],
    features: [
      '内容自动发布',
      '数据实时监控',
      '粉丝互动管理',
      '智能调度算法',
      'Web管理界面'
    ],
    challenges: '项目的核心挑战在于模拟人工操作行为、处理动态加载内容、以及保证系统的稳定性和可靠性。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 67,
    forks: 23,
    year: '2025',
    duration: '2个月'
  },
  {
    id: 3,
    title: '个人博客平台',
    description: '基于SpringBoot + Vue开发的现代化博客平台，支持Markdown编辑和多媒体内容。',
    fullDescription: '一个功能完整的博客平台，支持文章发布、评论系统、标签分类、用户管理等功能。前端采用Vue.js构建，后端使用SpringBoot，数据库使用MySQL。',
    image: project2Img,
    category: '全栈',
    technologies: ['SpringBoot', 'Vue.js', 'MySQL', 'Redis', 'ElementUI'],
    features: [
      'Markdown编辑器',
      '评论系统',
      '标签分类',
      '用户权限管理',
      '响应式设计'
    ],
    challenges: '项目重点关注用户体验优化、性能调优、以及安全防护，特别是在大量并发访问时的系统稳定性。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 89,
    forks: 34,
    year: '2023',
    duration: '4个月'
  },
  {
    id: 4,
    title: '推荐系统',
    description: '基于机器学习的智能推荐系统，支持多种推荐算法和实时个性化推荐。',
    fullDescription: '采用协同过滤、内容推荐等多种算法的推荐系统，能够根据用户行为数据提供个性化推荐。系统支持A/B测试和效果评估。',
    image: project1Img,
    category: '后端',
    technologies: ['SpringBoot', 'Python', 'TensorFlow', 'Kafka', 'Elasticsearch'],
    features: [
      '多算法融合',
      '实时推荐',
      'A/B测试',
      '效果评估',
      '大数据处理'
    ],
    challenges: '挑战包括算法性能优化、冷启动问题解决、以及推荐效果的持续改进。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 156,
    forks: 67,
    year: '2023',
    duration: '6个月'
  },
  {
    id: 5,
    title: '秒杀系统',
    description: '高并发秒杀系统，采用Redis缓存和消息队列确保系统稳定性。',
    fullDescription: '专为电商场景设计的高并发秒杀系统，能够处理大量用户同时抢购的场景。系统采用多级缓存、消息队列、限流等技术保证稳定性。',
    image: project1Img,
    category: '后端',
    technologies: ['SpringBoot', 'Redis', 'RabbitMQ', 'MySQL', 'Nginx'],
    features: [
      '高并发处理',
      '库存防超卖',
      '限流熔断',
      '消息队列',
      '分布式锁'
    ],
    challenges: '核心挑战是在高并发场景下保证数据一致性、防止超卖、以及系统的可用性。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 234,
    forks: 89,
    year: '2023',
    duration: '3个月'
  },
  {
    id: 6,
    title: '配音系统',
    description: '基于AI的智能配音系统，支持多语言文本转语音和语音合成。',
    fullDescription: '集成了先进的TTS技术的配音系统，支持多种音色和语言。提供API接口和Web界面，适用于视频制作、有声读物等场景。',
    image: project1Img,
    category: '前端',
    technologies: ['Vue.js', 'Python', 'TensorFlow', 'WebRTC', 'FFmpeg'],
    features: [
      '多语言支持',
      '音色自定义',
      '实时预览',
      '批量处理',
      'API接口'
    ],
    challenges: '技术难点在于语音合成质量的提升、实时处理性能优化、以及多语言模型的训练。',
    liveUrl: '#',
    githubUrl: '#',
    stars: 78,
    forks: 25,
    year: '2025',
    duration: '4个月'
  }
])

// 过滤后的项目
const filteredProjects = computed(() => {
  if (activeFilter.value === '全部') {
    return projects.value
  }
  return projects.value.filter(project => project.category === activeFilter.value)
})

// 打开项目模态框
const openProjectModal = (project) => {
  selectedProject.value = project
  document.body.style.overflow = 'hidden'
}

// 关闭项目模态框
const closeProjectModal = () => {
  selectedProject.value = null
  document.body.style.overflow = 'auto'
}
</script>

<style scoped>
/* 项目卡片样式 */
.project-card {
  @apply bg-white rounded-xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-2;
}

.project-image-container {
  @apply relative aspect-video bg-gray-100 overflow-hidden;
}

.project-image {
  @apply w-full h-full object-cover transition-transform duration-300 group-hover:scale-110;
}

.project-overlay {
  @apply absolute inset-0 bg-black/70 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-300;
}

.project-content {
  @apply p-6;
}

/* 模态框动画 */
.modal-enter-active,
.modal-leave-active {
  transition: all 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
  transform: scale(0.9);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .project-grid {
    grid-template-columns: 1fr;
  }
  
  .project-content {
    padding: 1rem;
  }
}
</style>
