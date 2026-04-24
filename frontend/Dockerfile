# 多阶段构建：构建阶段
FROM node:22-alpine AS builder

# 设置工作目录
WORKDIR /app

# 安装 yarn
RUN corepack enable && corepack prepare yarn@stable --activate

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN yarn config set registry https://registry.npmmirror.com/ && \
    yarn install --frozen-lockfile

# 复制源代码
COPY . .

# 构建参数（可通过 docker build --build-arg 传递）
ARG NODE_OPTIONS=--openssl-legacy-provider
ENV NODE_OPTIONS=${NODE_OPTIONS}

# 构建生产版本
RUN yarn build

# 生产阶段：使用 nginx 提供静态文件
FROM nginx:alpine

# 从构建阶段复制构建产物
COPY --from=builder /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]