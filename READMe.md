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
- **部署**: Docker + Nginx

