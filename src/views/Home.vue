<template>
  <div class="home">
    <!-- 导航栏 -->
    <AppHeader />
    
    <!-- 主页横幅 -->
    <HeroSection />
    
    <!-- 关于我 -->
    <AboutSection />
    
    <!-- 技能 -->
    <SkillsSection />
    
    <!-- 项目展示 -->
    <ProjectsSection />
    
    <!-- 工作经验 -->
    <ExperienceSection />
    
    <!-- 统计数据 -->
    <StatsSection />
    
    <!-- 联系我 -->
    <ContactSection />
    
    <!-- 页脚 -->
    <AppFooter />
  </div>
</template>

<script setup>
import AppHeader from '@/components/AppHeader.vue'
import HeroSection from '@/components/HeroSection.vue'
import AboutSection from '@/components/AboutSection.vue'
import SkillsSection from '@/components/SkillsSection.vue'
import ProjectsSection from '@/components/ProjectsSection.vue'
import ExperienceSection from '@/components/ExperienceSection.vue'
import StatsSection from '@/components/StatsSection.vue'
import ContactSection from '@/components/ContactSection.vue'
import AppFooter from '@/components/AppFooter.vue'
</script>

<style scoped>
.home {
  @apply relative;
}
</style>
