# 个人主页

> 一个现代化的个人主页项目，基于 Vue 3 + Vite 构建，部署在 GitHub Pages

## 特性

- 现代化设计，响应式布局
- 基于 Vite 的快速开发体验
- 流畅的动画效果（GSAP + AOS）
- 完美适配移动端
- 自动化部署到 GitHub Pages

## 技术栈

- **前端框架**: Vue 3 (Composition API)
- **构建工具**: Vite
- **样式方案**: Tailwind CSS
- **动画库**: GSAP, AOS
- **路由**: Vue Router
- **部署**: GitHub Pages

## 快速开始

### 环境要求

- Node.js >= 16.0.0
- npm >= 8.0.0

### 安装依赖

```bash
npm install
```

### 本地开发

```bash
npm run dev
```

访问 `http://localhost:5173` 查看效果

### 构建生产版本

```bash
npm run build
```

### 预览构建结果

```bash
npm run preview
```

## 项目结构

```
HomePage/
├── src/
│   ├── components/        # Vue 组件
│   │   ├── HeroSection.vue
│   │   ├── AboutSection.vue
│   │   ├── ProjectsSection.vue
│   │   ├── SkillsSection.vue
│   │   └── ...
│   ├── assets/           # 静态资源
│   │   ├── images/
│   │   └── styles/
│   ├── router/           # 路由配置
│   │   └── index.js
│   ├── views/            # 页面视图
│   ├── App.vue           # 根组件
│   └── main.js           # 入口文件
├── public/               # 公共资源
├── index.html            # HTML 模板
├── vite.config.js        # Vite 配置
├── tailwind.config.js    # Tailwind 配置
└── package.json          # 项目依赖
```

## 部署

项目已配置 GitHub Actions 自动部署。推送代码到 `master` 分支后会自动构建并部署到 GitHub Pages。

### 部署步骤

1. **配置仓库 Pages**
   - 进入 GitHub 仓库设置
   - 导航到 `Settings` → `Pages`
   - 在 `Source` 中选择 `GitHub Actions`

2. **推送代码**
   ```bash
   git add .
   git commit -m "your commit message"
   git push origin master
   ```

3. **查看部署状态**
   - 在仓库的 `Actions` 标签页查看工作流状态
   - 部署成功后访问 `https://<username>.github.io/HomePage/`

### 自定义域名

如需使用自定义域名：

1. 在 `public` 目录创建 `CNAME` 文件，写入你的域名
2. 在域名提供商处配置 DNS 记录指向 GitHub Pages
3. 在仓库 `Settings` → `Pages` 中设置自定义域名

## 配置说明

### 修改基础路径

如果你的仓库名不是 `HomePage`，需要修改 `vite.config.js` 中的 `base` 配置：

```javascript
export default defineConfig({
  base: '/your-repo-name/',
  // ...
})
```

### 自定义内容

主要内容位于 `src/components/` 目录下的各个组件中，可根据需要修改：

- `HeroSection.vue` - 首屏展示
- `AboutSection.vue` - 关于我
- `ProjectsSection.vue` - 项目展示
- `SkillsSection.vue` - 技能展示
- `ExperienceSection.vue` - 工作经历

## 开发建议

- 使用 VS Code + Volar 插件获得最佳开发体验
- 遵循 Vue 3 Composition API 最佳实践
- 保持组件的单一职责原则
- 合理使用 Tailwind CSS 工具类
