# 构建阶段
FROM node:18-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 运行阶段，使用Nginx
FROM nginx:alpine

# 从构建阶段复制构建的静态文件到Nginx的服务目录下
COPY --from=builder /app/build /usr/share/nginx/html

# 将自定义的Nginx配置文件复制到容器中
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 3000

# 使用默认的Nginx配置启动服务
CMD ["nginx", "-g", "daemon off;"]
