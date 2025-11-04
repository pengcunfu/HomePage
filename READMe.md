# 个人主页

基于Vue开发的个人主页项目，使用Vite构建工具，支持Docker容器化部署。

## 🚀 快速开始

### 本地开发

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build
```

## 🐳 Docker 部署

### 方式一：使用 Docker Compose（推荐）

```bash
# 构建并启动容器
docker-compose up -d

# 查看运行状态
docker-compose ps

# 停止服务
docker-compose down
```

访问地址：http://localhost

### 方式二：直接使用 Docker

```bash
# 构建镜像
docker build -t vue-homepage .

# 运行容器
docker run -d -p 80:80 --name vue-homepage vue-homepage

# 查看容器状态
docker ps

# 停止容器
docker stop vue-homepage
docker rm vue-homepage
```

### 生产环境部署

如果要在生产环境中部署，建议：

1. 修改 `docker-compose.yml` 中的端口映射
2. 配置域名和SSL证书
3. 使用反向代理（如 Nginx）
4. 设置环境变量

```bash
# 生产环境启动
docker-compose -f docker-compose.yml up -d
```

## 📁 项目结构

```
├── src/
│   ├── components/     # Vue组件
│   ├── assets/        # 静态资源
│   ├── router/        # 路由配置
│   └── views/         # 页面视图
├── Dockerfile         # Docker构建文件
├── docker-compose.yml # Docker编排文件
├── nginx.conf        # Nginx配置
└── .dockerignore     # Docker忽略文件
```

## 🛠 技术栈

- **前端框架**: Vue 3
- **构建工具**: Vite
- **样式**: Tailwind CSS
- **动画**: GSAP, AOS
- **部署**: Docker + Nginx / GitHub Pages

## 📦 GitHub Pages 部署

### 自动部署（推荐）

项目已配置 GitHub Actions 自动部署工作流。当你推送代码到 `master` 分支时，会自动构建并部署到 GitHub Pages。

**部署步骤：**

1. **设置仓库 Pages 配置**
   - 进入你的 GitHub 仓库
   - 点击 `Settings` → `Pages`
   - 在 `Build and deployment` 下，选择 `Source` 为 `GitHub Actions`

2. **推送代码**
   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin master
   ```

3. **查看部署状态**
   - 在仓库的 `Actions` 标签页查看工作流运行状态
   - 部署成功后，网站将在 `https://<你的用户名>.github.io/HomePage/` 访问

### 手动部署

如果需要手动部署到 GitHub Pages：

```bash
# 构建项目
npm run build

# 进入构建输出目录
cd dist

# 初始化 git 仓库并推送到 gh-pages 分支
git init
git add -A
git commit -m 'deploy'
git push -f git@github.com:<你的用户名>/HomePage.git master:gh-pages

cd -
```

### 自定义域名（可选）

如果你有自定义域名：

1. 在 `public` 目录创建 `CNAME` 文件，内容为你的域名
2. 在域名提供商处配置 DNS 记录指向 GitHub Pages
3. 在仓库 Settings → Pages 中设置自定义域名

### 注意事项

- 确保 `vite.config.js` 中的 `base` 路径设置正确（当前设置为 `/HomePage/`）
- 如果你的仓库名不是 `HomePage`，需要修改 `vite.config.js` 中的 base 路径
- GitHub Pages 可能需要几分钟才能更新内容

