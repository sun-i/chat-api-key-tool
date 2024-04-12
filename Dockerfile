# 构建阶段
FROM node:18-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 运行阶段，使用node
FROM node:18

# 安装 serve
RUN npm install -g serve
# 从构建阶段复制构建的静态文件
COPY --from=builder /app/build /app

# 指定工作目录
WORKDIR /app

# 暴露端口
EXPOSE 3000

# 运行 serve 提供服务
CMD ["serve", "-s", ".", "-l", "3000"]
