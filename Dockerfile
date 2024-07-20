# 使用官方的 Python 镜像作为基础镜像
FROM squidfunk/mkdocs-material:9.5.20 AS builder

# 设置工作目录
WORKDIR /app

# 复制 MkDocs 项目文件到工作目录
COPY . .

# 构建 MkDocs 静态文件
RUN mkdocs build

# 使用 Nginx 作为基础镜像
FROM nginx

WORKDIR /app

# 从前一个阶段的构建中复制 MkDocs 静态文件到 Nginx 的默认网站目录
COPY --from=builder /app/site /usr/share/nginx/html

# 暴露 Nginx 默认的 HTTP 端口
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

