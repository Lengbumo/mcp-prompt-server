FROM node:lts-alpine

WORKDIR /app

# 复制依赖配置文件
COPY package*.json ./

# 安装依赖
RUN npm install --production

# 复制应用代码
COPY src ./src

# 容器启动命令将由smithery.yaml提供
CMD ["node", "src/index.js"] 