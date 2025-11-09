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

      <!-- 联系信息网格 -->
      <div class="max-w-5xl mx-auto">
        <div data-aos="fade-up" data-aos-duration="1000">
          <!-- 主要联系方式 -->
          <div class="grid md:grid-cols-3 gap-8 mb-12">
            <!-- 联系方式卡片 -->
            <div 
              v-for="contact in contactInfo"
              :key="contact.id"
              class="contact-card group"
            >
              <div class="text-center">
                <!-- 图标 -->
                <div class="w-16 h-16 bg-primary-500 rounded-xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                  <component :is="contact.icon" :size="28" class="text-white" />
                </div>
                
                <!-- 内容 -->
                <div>
                  <h3 class="text-xl font-bold text-gray-900 mb-2">{{ contact.title }}</h3>
                  <p class="text-gray-600 text-sm mb-4">{{ contact.description }}</p>
                  <div class="space-y-2">
                    <a 
                      v-for="item in contact.items"
                      :key="item.text"
                      :href="item.link"
                      class="block text-primary-600 hover:text-primary-700 font-semibold text-lg transition-colors duration-300"
                      :target="item.link.startsWith('http') ? '_blank' : '_self'"
                      :rel="item.link.startsWith('http') ? 'noopener noreferrer' : ''"
                    >
                      {{ item.text }}
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 次要信息 -->
          <div class="grid md:grid-cols-2 gap-8">
            <!-- 社交媒体 -->
            <div class="contact-card" data-aos="fade-up" data-aos-delay="200">
              <h3 class="text-xl font-bold text-gray-900 mb-6 text-center">关注我的社交媒体</h3>
              <div class="flex justify-center space-x-4">
                <a
                  v-for="social in socialLinks"
                  :key="social.name"
                  :href="social.url"
                  :aria-label="social.name"
                  class="w-14 h-14 bg-primary-500 rounded-xl flex items-center justify-center text-white hover:scale-110 transform transition-all duration-300 hover:shadow-lg"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <component :is="social.icon" :size="24" />
                </a>
              </div>
            </div>

            <!-- 工作时间 -->
            <div class="contact-card" data-aos="fade-up" data-aos-delay="300">
              <h3 class="text-xl font-bold text-gray-900 mb-6 text-center">工作时间</h3>
              <div class="space-y-3 text-gray-600">
                <div class="flex justify-between items-center">
                  <span class="font-medium">周一 - 周五</span>
                  <span class="text-primary-600 font-semibold">09:00 - 18:00</span>
                </div>
                <div class="flex justify-between items-center">
                  <span class="font-medium">周六 - 周日</span>
                  <span class="text-primary-600 font-semibold">10:00 - 16:00</span>
                </div>
                <div class="mt-4 p-4 bg-green-50 rounded-lg">
                  <div class="flex items-center justify-center">
                    <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
                    <span class="text-green-700 font-semibold">当前状态：可接新项目</span>
                  </div>
                </div>
              </div>
            </div>
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
import { ref } from 'vue'
import { 
  Mail, 
  Phone, 
  MapPin,
  Github,
  Code,
  BookOpen
} from 'lucide-vue-next'

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
</script>

<style scoped>
/* 联系卡片样式 */
.contact-card {
  @apply bg-white rounded-xl p-8 shadow-lg hover:shadow-xl transition-all duration-300;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .contact-card {
    padding: 1.5rem;
  }
}
</style>
