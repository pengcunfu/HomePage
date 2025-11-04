<template>
  <section id="contact" class="py-20 lg:py-32 bg-gray-50">
    <div class="container-custom">
      <!-- 标题部分 -->
      <div class="text-center mb-16" data-aos="fade-up">
        <h5 class="text-primary-600 font-semibold mb-2 uppercase tracking-wider">联系我</h5>
        <h2 class="section-title mb-4">让我们开始合作</h2>
        <div class="w-16 h-1 bg-primary-500 rounded-full mx-auto mb-6"></div>
        <p class="section-subtitle max-w-2xl mx-auto">
          有项目想法或者技术问题？随时联系我，让我们一起把想法变成现实。
        </p>
      </div>

      <div class="grid lg:grid-cols-2 gap-16">
        <!-- 左侧：联系信息 -->
        <div data-aos="fade-right" data-aos-duration="1000">
          <div class="space-y-8">
            <!-- 联系方式卡片 -->
            <div 
              v-for="contact in contactInfo"
              :key="contact.id"
              class="contact-card group"
            >
              <div class="flex items-start space-x-4">
                <!-- 图标 -->
                <div class="w-14 h-14 bg-primary-500 rounded-xl flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform duration-300">
                  <component :is="contact.icon" :size="24" class="text-white" />
                </div>
                
                <!-- 内容 -->
                <div class="flex-1">
                  <h3 class="text-lg font-semibold text-gray-900 mb-2">{{ contact.title }}</h3>
                  <p class="text-gray-600 mb-3">{{ contact.description }}</p>
                  <div class="space-y-1">
                    <a 
                      v-for="item in contact.items"
                      :key="item.text"
                      :href="item.link"
                      :class="[
                        'block text-primary-600 hover:text-primary-700 font-medium transition-colors duration-300',
                        item.link.startsWith('http') ? '' : ''
                      ]"
                      :target="item.link.startsWith('http') ? '_blank' : '_self'"
                      :rel="item.link.startsWith('http') ? 'noopener noreferrer' : ''"
                    >
                      {{ item.text }}
                    </a>
                  </div>
                </div>
              </div>
            </div>

            <!-- 社交媒体 -->
            <div class="contact-card">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">关注我的社交媒体</h3>
              <div class="flex space-x-4">
                <a
                  v-for="social in socialLinks"
                  :key="social.name"
                  :href="social.url"
                  :aria-label="social.name"
                  class="w-12 h-12 bg-primary-500 rounded-lg flex items-center justify-center text-white hover:scale-110 transform transition-all duration-300 hover:shadow-lg"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <component :is="social.icon" :size="20" />
                </a>
              </div>
            </div>

            <!-- 可用时间 -->
            <div class="contact-card">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">工作时间</h3>
              <div class="space-y-2 text-gray-600">
                <div class="flex justify-between">
                  <span>周一 - 周五</span>
                  <span class="font-medium">09:00 - 18:00</span>
                </div>
                <div class="flex justify-between">
                  <span>周六 - 周日</span>
                  <span class="font-medium">10:00 - 16:00</span>
                </div>
                <div class="mt-4 p-3 bg-green-50 rounded-lg">
                  <div class="flex items-center">
                    <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
                    <span class="text-green-700 font-medium">当前状态：可接新项目</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 右侧：联系表单 -->
        <div data-aos="fade-left" data-aos-duration="1000">
          <div class="contact-card">
            <h3 class="text-2xl font-bold text-gray-900 mb-6">发送消息</h3>
            
            <form @submit.prevent="submitForm" class="space-y-6">
              <!-- 姓名和邮箱 -->
              <div class="grid md:grid-cols-2 gap-6">
                <div>
                  <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                    姓名 *
                  </label>
                  <input
                    id="name"
                    v-model="form.name"
                    type="text"
                    required
                    class="form-input"
                    placeholder="请输入您的姓名"
                  />
                </div>
                <div>
                  <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                    邮箱 *
                  </label>
                  <input
                    id="email"
                    v-model="form.email"
                    type="email"
                    required
                    class="form-input"
                    placeholder="your@email.com"
                  />
                </div>
              </div>

              <!-- 电话和项目类型 -->
              <div class="grid md:grid-cols-2 gap-6">
                <div>
                  <label for="phone" class="block text-sm font-medium text-gray-700 mb-2">
                    电话
                  </label>
                  <input
                    id="phone"
                    v-model="form.phone"
                    type="tel"
                    class="form-input"
                    placeholder="请输入您的电话"
                  />
                </div>
                <div>
                  <label for="project-type" class="block text-sm font-medium text-gray-700 mb-2">
                    项目类型
                  </label>
                  <select
                    id="project-type"
                    v-model="form.projectType"
                    class="form-input"
                  >
                    <option value="">请选择项目类型</option>
                    <option value="web-development">Web开发</option>
                    <option value="mobile-app">移动应用</option>
                    <option value="consulting">技术咨询</option>
                    <option value="maintenance">系统维护</option>
                    <option value="other">其他</option>
                  </select>
                </div>
              </div>

              <!-- 预算范围 -->
              <div>
                <label for="budget" class="block text-sm font-medium text-gray-700 mb-2">
                  预算范围
                </label>
                <select
                  id="budget"
                  v-model="form.budget"
                  class="form-input"
                >
                  <option value="">请选择预算范围</option>
                  <option value="under-10k">1万以下</option>
                  <option value="10k-50k">1-5万</option>
                  <option value="50k-100k">5-10万</option>
                  <option value="over-100k">10万以上</option>
                  <option value="discuss">面议</option>
                </select>
              </div>

              <!-- 项目描述 -->
              <div>
                <label for="message" class="block text-sm font-medium text-gray-700 mb-2">
                  项目描述 *
                </label>
                <textarea
                  id="message"
                  v-model="form.message"
                  rows="6"
                  required
                  class="form-input resize-none"
                  placeholder="请详细描述您的项目需求..."
                ></textarea>
              </div>

              <!-- 时间线 -->
              <div>
                <label for="timeline" class="block text-sm font-medium text-gray-700 mb-2">
                  期望完成时间
                </label>
                <select
                  id="timeline"
                  v-model="form.timeline"
                  class="form-input"
                >
                  <option value="">请选择时间范围</option>
                  <option value="urgent">紧急（1周内）</option>
                  <option value="1month">1个月内</option>
                  <option value="3months">3个月内</option>
                  <option value="6months">6个月内</option>
                  <option value="flexible">时间灵活</option>
                </select>
              </div>

              <!-- 提交按钮 -->
              <div class="flex items-center space-x-4">
                <button
                  type="submit"
                  :disabled="isSubmitting"
                  :class="[
                    'btn btn-primary flex-1 relative overflow-hidden',
                    isSubmitting ? 'opacity-75 cursor-not-allowed' : ''
                  ]"
                >
                  <span v-if="!isSubmitting" class="flex items-center justify-center">
                    发送消息
                    <Send :size="20" class="ml-2" />
                  </span>
                  <span v-else class="flex items-center justify-center">
                    <div class="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin mr-2"></div>
                    发送中...
                  </span>
                </button>
                
                <button
                  type="button"
                  @click="clearForm"
                  class="btn btn-ghost"
                >
                  重置
                </button>
              </div>
            </form>

            <!-- 提交状态提示 -->
            <Transition name="fade">
              <div 
                v-if="submitStatus"
                :class="[
                  'mt-6 p-4 rounded-lg flex items-center',
                  submitStatus.type === 'success' ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'
                ]"
              >
                <CheckCircle v-if="submitStatus.type === 'success'" :size="20" class="mr-2" />
                <AlertCircle v-else :size="20" class="mr-2" />
                <span>{{ submitStatus.message }}</span>
              </div>
            </Transition>
          </div>
        </div>
      </div>

      <!-- CTA 部分 -->
      <div class="mt-20 text-center" data-aos="fade-up">
        <div class="bg-primary-600 rounded-2xl p-8 lg:p-12 text-white">
          <h3 class="text-2xl lg:text-3xl font-bold mb-4">准备开始您的项目了吗？</h3>
          <p class="text-xl text-white/90 mb-8 max-w-2xl mx-auto">
            让我们一起讨论您的想法，并将其转化为出色的数字解决方案。
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="tel:+8613800000000" class="btn bg-white text-primary-600 hover:bg-gray-100">
              <Phone :size="20" class="mr-2" />
              立即通话
            </a>
            <a href="mailto:3173484026@qq.com" class="btn bg-white/10 text-white border-2 border-white hover:bg-white hover:text-primary-600">
              <Mail :size="20" class="mr-2" />
              发送邮件
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { 
  Mail, 
  Phone, 
  MapPin, 
  Clock, 
  Github, 
  Linkedin, 
  Twitter,
  Send,
  CheckCircle,
  AlertCircle,
  Code,
  BookOpen
} from 'lucide-vue-next'

// 响应式数据
const isSubmitting = ref(false)
const submitStatus = ref(null)

// 表单数据
const form = reactive({
  name: '',
  email: '',
  phone: '',
  projectType: '',
  budget: '',
  message: '',
  timeline: ''
})

// 联系信息
const contactInfo = ref([
  {
    id: 1,
    title: '邮箱地址',
    description: '通过邮件联系我，我会在24小时内回复',
    icon: Mail,
    items: [
      { text: '3173484026@qq.com', link: 'mailto:3173484026@qq.com' }
    ]
  },
  {
    id: 2,
    title: '电话咨询',
    description: '工作时间内可直接电话沟通',
    icon: Phone,
    items: [
      { text: '+86 155-7636-4885', link: 'tel:+8613800000000' }
    ]
  },
  {
    id: 3,
    title: '工作地点',
    description: '远程工作，也可面对面沟通',
    icon: MapPin,
    items: [
      { text: '中国', link: '#' }
    ]
  }
])

// 社交链接
const socialLinks = ref([
  {
    name: 'GitHub',
    url: 'https://github.com/pengcunfu',
    icon: Github
  },
  {
    name: 'Gitee',
    url: 'https://gitee.com/huaqiwill',
    icon: Code
  },
  {
    name: '知乎',
    url: 'https://www.zhihu.com/people/super-10-33-97',
    icon: BookOpen
  }
])

// 提交表单
const submitForm = async () => {
  isSubmitting.value = true
  submitStatus.value = null

  try {
    // 模拟API调用
    await new Promise(resolve => setTimeout(resolve, 2000))
    
    // 这里应该调用实际的API
    console.log('Form data:', form)
    
    submitStatus.value = {
      type: 'success',
      message: '消息发送成功！我会尽快回复您。'
    }
    
    // 清空表单
    Object.keys(form).forEach(key => {
      form[key] = ''
    })
    
  } catch (error) {
    submitStatus.value = {
      type: 'error',
      message: '发送失败，请稍后重试或直接发送邮件。'
    }
  } finally {
    isSubmitting.value = false
    
    // 5秒后清除状态提示
    setTimeout(() => {
      submitStatus.value = null
    }, 5000)
  }
}

// 清空表单
const clearForm = () => {
  Object.keys(form).forEach(key => {
    form[key] = ''
  })
  submitStatus.value = null
}
</script>

<style scoped>
/* 联系卡片样式 */
.contact-card {
  @apply bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300;
}

/* 表单输入样式 */
.form-input {
  @apply w-full px-4 py-3 border border-gray-200 rounded-lg focus:border-primary-500 focus:ring-2 focus:ring-primary-200 focus:outline-none transition-all duration-200;
}

.form-input:focus {
  @apply shadow-md;
}

/* 渐入动画 */
.fade-enter-active,
.fade-leave-active {
  transition: all 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .grid.lg\\:grid-cols-2 {
    grid-template-columns: 1fr;
  }
  
  .contact-card {
    padding: 1rem;
  }
}
</style>
