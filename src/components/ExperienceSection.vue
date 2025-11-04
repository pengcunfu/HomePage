<template>
  <section id="experience" class="py-20 lg:py-32 bg-white">
    <div class="container-custom">
      <!-- 标题部分 -->
      <div class="text-center mb-16" data-aos="fade-up">
        <h5 class="text-primary-600 font-semibold mb-2 uppercase tracking-wider">工作经历</h5>
        <h2 class="section-title mb-4">职业发展历程</h2>
        <div class="w-16 h-1 bg-primary-500 rounded-full mx-auto mb-6"></div>
        <p class="section-subtitle max-w-2xl mx-auto">
          从初级开发者到全栈工程师，每一段经历都是技术成长和能力提升的重要阶段。
        </p>
      </div>

      <!-- 经验时间线 -->
      <div class="max-w-4xl mx-auto">
        <div class="timeline">
          <div v-for="(experience, index) in experiences" :key="experience.id" class="timeline-item" data-aos="fade-up"
            :data-aos-delay="index * 200">
            <!-- 时间线圆点 -->
            <div class="timeline-dot">
              <component :is="experience.icon" :size="16" class="text-white" />
            </div>

            <!-- 经验卡片 -->
            <div :class="[
              'experience-card',
              index % 2 === 0 ? 'md:ml-12' : 'md:mr-12 md:text-right'
            ]">
              <!-- 时间标签 -->
              <div
                class="inline-flex items-center px-4 py-2 bg-primary-100 text-primary-700 rounded-full text-sm font-medium mb-4">
                <Calendar :size="16" class="mr-2" />
                {{ experience.duration }}
              </div>

              <!-- 职位和公司 -->
              <h3 class="text-xl lg:text-2xl font-bold text-gray-900 mb-2">
                {{ experience.position }}
              </h3>
              <h4 class="text-lg font-semibold text-primary-600 mb-4">
                {{ experience.company }}
              </h4>

              <!-- 工作描述 -->
              <p class="text-gray-600 mb-6 leading-relaxed">
                {{ experience.description }}
              </p>

              <!-- 主要成就 -->
              <div class="mb-6">
                <h5 class="font-semibold text-gray-900 mb-3">主要成就：</h5>
                <ul class="space-y-2">
                  <li v-for="achievement in experience.achievements" :key="achievement" class="flex items-start">
                    <CheckCircle :size="16" class="mr-2 text-green-500 mt-0.5 flex-shrink-0" />
                    <span class="text-gray-600 text-sm">{{ achievement }}</span>
                  </li>
                </ul>
              </div>

              <!-- 技术栈 -->
              <div class="mb-6">
                <h5 class="font-semibold text-gray-900 mb-3">使用技术：</h5>
                <div class="flex flex-wrap gap-2">
                  <span v-for="tech in experience.technologies" :key="tech"
                    class="px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm font-medium hover:bg-primary-100 hover:text-primary-700 transition-colors duration-200">
                    {{ tech }}
                  </span>
                </div>
              </div>

              <!-- 项目亮点 -->
              <div v-if="experience.projects && experience.projects.length > 0" class="bg-gray-50 rounded-lg p-4">
                <h5 class="font-semibold text-gray-900 mb-3">参与项目：</h5>
                <div class="space-y-2">
                  <div v-for="project in experience.projects" :key="project.name"
                    class="flex items-center justify-between">
                    <span class="text-sm font-medium text-gray-700">{{ project.name }}</span>
                    <span class="text-xs text-gray-500">{{ project.role }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 教育背景 -->
      <div class="mt-20" data-aos="fade-up">
        <h3 class="text-2xl lg:text-3xl font-bold text-center text-gray-900 mb-12">教育背景</h3>
        <div class="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
          <div v-for="(education, index) in educations" :key="education.id" class="education-card group"
            data-aos="fade-up" :data-aos-delay="index * 200">
            <div class="flex items-start space-x-4">
              <!-- 学校图标 -->
              <div class="w-12 h-12 bg-primary-500 rounded-xl flex items-center justify-center flex-shrink-0">
                <GraduationCap :size="24" class="text-white" />
              </div>

              <!-- 教育详情 -->
              <div class="flex-1">
                <h4 class="text-lg font-bold text-gray-900 group-hover:text-primary-600 transition-colors duration-300">
                  {{ education.degree }}
                </h4>
                <p class="text-primary-600 font-medium mb-2">{{ education.school }}</p>
                <p class="text-sm text-gray-500 mb-3">{{ education.duration }}</p>
                <p class="text-gray-600 text-sm leading-relaxed">{{ education.description }}</p>

                <!-- 主要课程或成就 -->
                <div v-if="education.highlights" class="mt-3">
                  <div class="flex flex-wrap gap-1">
                    <span v-for="highlight in education.highlights" :key="highlight"
                      class="px-2 py-1 bg-primary-50 text-primary-700 text-xs rounded-full">
                      {{ highlight }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 技能发展路径 -->
      <div class="mt-20" data-aos="fade-up">
        <h3 class="text-2xl lg:text-3xl font-bold text-center text-gray-900 mb-12">技能发展历程</h3>
        <div class="max-w-6xl mx-auto">
          <div class="grid md:grid-cols-3 gap-8">
            <div v-for="(phase, index) in skillPhases" :key="phase.id" class="skill-phase-card" data-aos="fade-up"
              :data-aos-delay="index * 200">
              <!-- 阶段图标 -->
              <div class="text-center mb-6">
                <div class="w-16 h-16 mx-auto bg-primary-500 rounded-full flex items-center justify-center mb-4">
                  <component :is="phase.icon" :size="28" class="text-white" />
                </div>
                <h4 class="text-xl font-bold text-gray-900">{{ phase.title }}</h4>
                <p class="text-sm text-gray-500">{{ phase.period }}</p>
              </div>

              <!-- 技能列表 -->
              <div class="space-y-3">
                <div v-for="skill in phase.skills" :key="skill"
                  class="flex items-center p-2 bg-gray-50 rounded-lg hover:bg-primary-50 transition-colors duration-200">
                  <div class="w-2 h-2 bg-primary-500 rounded-full mr-3"></div>
                  <span class="text-sm text-gray-700">{{ skill }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import {
  CheckCircle,
  Calendar,
  GraduationCap,
  Code,
  Server,
  Cloud,
  Rocket,
  Target,
  Trophy
} from 'lucide-vue-next'

// 工作经验数据
const experiences = ref([
  {
    id: 1,
    position: '高级全栈开发工程师',
    company: '华中启云科技有限责任公司',
    duration: '2022年3月 - 至今',
    description: '负责公司核心产品的全栈开发，主导多个重要项目的技术架构设计和开发实施。带领团队完成了多个大型项目的交付，在技术选型、性能优化和团队协作方面积累了丰富经验。',
    achievements: [
      '主导开发了公司核心SaaS平台，用户量增长300%',
      '优化系统架构，将页面加载速度提升50%',
      '建立了完整的CI/CD流程，提高部署效率80%',
      '指导5名初级开发者，提升团队整体技术水平',
      '推动技术栈升级，引入微服务架构'
    ],
    technologies: ['Vue.js', 'Node.js', 'Python', 'Docker', 'Kubernetes', 'AWS', 'MongoDB', 'Redis'],
    projects: [
      { name: '企业级SaaS平台', role: '技术负责人' },
      { name: '数据分析系统', role: '全栈开发' },
      { name: '移动端App', role: '后端开发' }
    ],
    icon: Trophy
  },
  {
    id: 2,
    position: '全栈开发工程师',
    company: '某科技有限公司',
    duration: '2020年6月 - 2022年2月',
    description: '参与多个Web应用项目的开发，从前端用户界面到后端API服务，负责完整的产品开发周期。在此期间深入学习了现代前端框架和后端技术栈。',
    achievements: [
      '独立完成3个中型Web应用的全栈开发',
      '参与大型电商平台的性能优化，提升并发处理能力',
      '开发了自动化测试框架，提高代码质量',
      '协助建立团队代码规范和开发流程'
    ],
    technologies: ['React', 'Vue.js', 'Java', 'Spring Boot', 'MySQL', 'Elasticsearch', 'Jenkins'],
    projects: [
      { name: '电商管理系统', role: '全栈开发' },
      { name: '内容管理平台', role: '前端负责人' }
    ],
    icon: Code
  },
  {
    id: 3,
    position: '前端开发工程师',
    company: '某互联网公司',
    duration: '2019年3月 - 2020年5月',
    description: '专注于前端开发，负责公司官网和管理后台的界面开发与优化。在此期间掌握了现代前端开发技术栈，对用户体验设计有了深入理解。',
    achievements: [
      '重构公司官网，提升用户体验和SEO效果',
      '开发了可复用的组件库，提高开发效率',
      '实现了响应式设计，支持多终端访问',
      '学习并应用了前端性能优化技术'
    ],
    technologies: ['JavaScript', 'Vue.js', 'CSS3', 'Webpack', 'Git', 'Figma'],
    projects: [
      { name: '企业官网', role: '前端开发' },
      { name: '后台管理系统', role: '前端开发' }
    ],
    icon: Server
  }
])

// 教育背景
const educations = ref([
  {
    id: 1,
    degree: '计算机应用技术 专科',
    school: '武汉交通职业学院',
    duration: '2021年9月 - 2024年6月',
    description: '主修计算机科学与技术专业，系统学习了计算机基础理论、编程语言、数据结构与算法、数据库原理等核心课程。',
    highlights: ['数据结构与算法', '计算机网络', '数据库原理', '软件工程', '操作系统']
  },
  {
    id: 2,
    degree: '软件工程 学士学位',
    school: '湖北工程学院',
    duration: '2024年9月 - 2026年6月',
    description: '主修计算机科学与技术专业，系统学习了计算机基础理论、编程语言、数据结构与算法、数据库原理等核心课程。',
    highlights: ['数据结构与算法', '计算机网络', '数据库原理', '软件工程', '操作系统']
  },
  {
    id: 2,
    degree: '在线课程与认证',
    school: '持续学习',
    duration: '2019年至今',
    description: '通过在线平台持续学习新技术，获得多项技术认证，保持技术栈的更新和扩展。',
    highlights: ['AWS认证', 'Google Cloud', 'Kubernetes', 'Docker', 'Vue.js高级']
  }
])

// 技能发展阶段
const skillPhases = ref([
  {
    id: 1,
    title: '入门阶段',
    period: '2019 - 2020',
    icon: Target,
    skills: [
      'HTML/CSS基础',
      'JavaScript基础',
      'Vue.js入门',
      'Git版本控制',
      'Linux基本操作',
      '数据库基础'
    ]
  },
  {
    id: 2,
    title: '成长阶段',
    period: '2020 - 2022',
    icon: Rocket,
    skills: [
      'React/Vue.js进阶',
      'Node.js后端开发',
      'RESTful API设计',
      'MySQL/MongoDB',
      'Docker容器化',
      '测试驱动开发'
    ]
  },
  {
    id: 3,
    title: '专家阶段',
    period: '2022 - 至今',
    icon: Cloud,
    skills: [
      '微服务架构',
      '云原生技术',
      'Kubernetes编排',
      '性能优化',
      '团队领导',
      '架构设计'
    ]
  }
])
</script>

<style scoped>
/* 经验卡片样式 */
.experience-card {
  @apply bg-white rounded-xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-2;
}

/* 教育背景卡片 */
.education-card {
  @apply bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1;
}

/* 技能阶段卡片 */
.skill-phase-card {
  @apply bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1;
}

/* 时间线增强样式 */
.timeline::before {
  @apply bg-primary-200;
}

.timeline-dot {
  @apply bg-primary-500;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .timeline::before {
    @apply left-6;
  }

  .timeline-item {
    @apply pl-16;
  }

  .timeline-dot {
    @apply left-2;
  }

  .experience-card {
    @apply ml-0 mr-0 text-left;
  }
}
</style>
