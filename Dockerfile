FROM node:18-alpine

WORKDIR /app

# 复制依赖配置文件
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制应用代码
COPY . .

# 设置权限
RUN chmod +x src/index.js

# 容器启动命令将由smithery.yaml提供
CMD ["node", "src/index.js"] 