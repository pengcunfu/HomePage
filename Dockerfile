# 多阶段构建 Dockerfile for Vue.js 项目

# 第一阶段：构建阶段
FROM node:18-alpine AS build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 设置npm国内镜像源
RUN npm config set registry https://registry.npmmirror.com

# 安装所有依赖（包括开发依赖，构建时需要）
RUN npm ci --silent

# 复制项目文件
COPY . .

# 构建生产版本
RUN npm run build

# 第二阶段：生产阶段
FROM nginx:alpine AS production-stage

# 复制自定义 nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 从构建阶段复制构建结果到 nginx 服务目录
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
