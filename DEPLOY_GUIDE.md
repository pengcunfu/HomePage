# GitHub Pages 部署指南

这是一份详细的 GitHub Pages 部署指南，帮助你将项目成功发布到 GitHub Pages。

## 📋 前置准备

1. **GitHub 账号**：确保你有一个 GitHub 账号
2. **Git 已安装**：本地已安装并配置好 Git
3. **Node.js 环境**：已安装 Node.js (推荐 v18 或更高版本)
4. **项目已推送到 GitHub**：确保项目代码已经推送到 GitHub 仓库

## 🚀 快速部署（推荐）

### 步骤 1: 配置 GitHub Pages

1. 打开你的 GitHub 仓库页面
2. 点击顶部的 **Settings** (设置)
3. 在左侧菜单找到 **Pages**
4. 在 **Build and deployment** 部分：
   - **Source**: 选择 **GitHub Actions**
   - 不要选择 "Deploy from a branch"

### 步骤 2: 推送代码触发自动部署

```bash
# 添加所有修改的文件
git add .

# 提交更改
git commit -m "Configure GitHub Pages deployment"

# 推送到 master 分支
git push origin master
```

### 步骤 3: 查看部署状态

1. 在 GitHub 仓库页面，点击顶部的 **Actions** 标签
2. 你会看到一个名为 "Deploy to GitHub Pages" 的工作流正在运行
3. 等待工作流完成（通常需要 1-3 分钟）
4. 部署成功后，会显示绿色的对勾 ✓

### 步骤 4: 访问你的网站

部署成功后，你的网站将在以下地址可访问：

```
https://<你的GitHub用户名>.github.io/HomePage/
```

例如，如果你的用户名是 `zhangsan`，网站地址就是：
```
https://zhangsan.github.io/HomePage/
```

## 🔧 高级配置

### 自定义仓库名

如果你的仓库名不是 `HomePage`，需要修改 `vite.config.js` 文件：

```javascript
export default defineConfig({
  base: process.env.NODE_ENV === 'production' ? '/你的仓库名/' : '/',
  // ... 其他配置
})
```

**重要**：base 路径必须以 `/` 开头和结尾，例如 `/my-website/`

### 使用自定义域名

如果你有自己的域名，可以这样配置：

1. **在项目中配置域名**
   
   在 `public` 目录创建 `CNAME` 文件，内容为你的域名：
   ```
   www.yourdomain.com
   ```

2. **配置 DNS 记录**
   
   在你的域名提供商处添加以下记录：
   
   - 类型: `CNAME`
   - 名称: `www` (或 `@` 如果使用根域名)
   - 值: `<你的用户名>.github.io`

3. **在 GitHub 设置自定义域名**
   
   - 进入仓库 Settings → Pages
   - 在 Custom domain 输入你的域名
   - 勾选 "Enforce HTTPS"

4. **修改 vite.config.js**
   
   如果使用自定义域名，需要修改 base 路径：
   ```javascript
   export default defineConfig({
     base: '/', // 自定义域名使用根路径
     // ... 其他配置
   })
   ```

### 手动触发部署

除了推送代码自动触发，你也可以手动触发部署：

1. 进入 GitHub 仓库的 **Actions** 标签
2. 在左侧选择 "Deploy to GitHub Pages"
3. 点击右侧的 **Run workflow** 按钮
4. 选择 `master` 分支
5. 点击 **Run workflow**

## 🛠 本地测试

在推送到 GitHub 之前，建议先本地测试构建：

```bash
# 安装依赖
npm install

# 本地开发
npm run dev

# 构建生产版本
npm run build

# 预览构建结果
npm run preview
```

## 📝 手动部署（备用方案）

如果自动部署遇到问题，可以使用手动部署：

```bash
# 1. 构建项目
npm run build

# 2. 进入构建输出目录
cd dist

# 3. 初始化 Git 仓库
git init
git add -A
git commit -m 'deploy'

# 4. 推送到 gh-pages 分支
git push -f git@github.com:<你的用户名>/HomePage.git master:gh-pages

# 5. 返回项目根目录
cd ..
```

然后在 GitHub Settings → Pages 中，将 Source 改为 "Deploy from a branch"，选择 `gh-pages` 分支。

## ❓ 常见问题

### 1. 页面显示 404

**可能原因**：
- base 路径配置错误
- GitHub Pages 还未完成部署

**解决方案**：
- 检查 `vite.config.js` 中的 base 路径是否与仓库名一致
- 等待几分钟让 GitHub Pages 完成部署
- 检查 Actions 工作流是否成功运行

### 2. 资源文件（图片、CSS）加载失败

**可能原因**：
- base 路径配置错误
- 资源路径使用了绝对路径

**解决方案**：
- 确保 base 路径正确配置
- 使用相对路径引用资源文件
- 将静态资源放在 `public` 目录

### 3. 刷新页面后 404（路由问题）

**可能原因**：
- GitHub Pages 不支持 SPA 的 HTML5 History 模式

**解决方案**：
- 使用 Hash 模式路由
- 或者添加 404.html 重定向方案

### 4. Actions 工作流失败

**可能原因**：
- 依赖安装失败
- 构建过程出错
- 权限不足

**解决方案**：
- 查看 Actions 日志找出具体错误
- 确保 package.json 中的依赖版本正确
- 检查 Settings → Pages 的 Source 是否设置为 GitHub Actions

### 5. 更新代码后网站没变化

**可能原因**：
- 浏览器缓存
- GitHub Pages CDN 缓存

**解决方案**：
- 强制刷新浏览器 (Ctrl+F5 或 Cmd+Shift+R)
- 等待几分钟让 CDN 更新
- 清除浏览器缓存

## 📊 工作流说明

项目使用的 GitHub Actions 工作流包含两个主要任务：

1. **Build（构建）**
   - 检出代码
   - 设置 Node.js 环境
   - 安装依赖
   - 构建项目
   - 上传构建产物

2. **Deploy（部署）**
   - 等待构建完成
   - 将构建产物部署到 GitHub Pages

工作流文件位置：`.github/workflows/deploy.yml`

## 🔒 权限说明

工作流需要以下权限：
- `contents: read` - 读取仓库内容
- `pages: write` - 写入 Pages
- `id-token: write` - 写入 ID token

这些权限已在 `deploy.yml` 中配置。

## 📚 相关链接

- [GitHub Pages 官方文档](https://docs.github.com/pages)
- [Vite 部署文档](https://vitejs.dev/guide/static-deploy.html)
- [GitHub Actions 文档](https://docs.github.com/actions)

## 💡 提示

- 每次推送到 master 分支都会触发自动部署
- 部署过程通常需要 1-3 分钟
- GitHub Pages 有流量限制（每月 100GB，每小时 10 次构建）
- 建议使用自定义域名以获得更好的 SEO 和品牌形象
- 定期检查 Actions 工作流运行状态

---

如有其他问题，请查看 GitHub Actions 的运行日志或提交 Issue。

