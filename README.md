# MCP Prompt Server

## 不知道你有没有类似痛点

积累了一大堆 Prompt，但经常想不起来用。

每次用都需要复制粘贴，非常繁琐。

有人会放在 AI 编程工具的 Rules 中，可以解决一部分问题。

但我想，是否可以把常用的 Prompt 也做成 MCP。

里面的一个个 Prompt 模版设计成 tools，这样就能用自然语言对话就能调用各种 Prompt。

上网搜了下，果然已经有类似的 MCP，原版地址

https://github.com/gdli6177/mcp-prompt-server

Fork 了一份，把自己的常用 Prompt 改造一番，发现异常好用。

## 这个 MCP 的神奇效果

再也不需要复制粘贴大量提示词了。

完全用自然语言对话，自动调用 Prompt 生成可视化网页，设计 PRD，生成标题等等

AI 自动会找到合适的 Prompt 处理。

可以安装在 Raycast、Cursor、Windsurf、Cherrystudio 等任意支持 MCP 的工具中。

**Raycast 为例，演示效果**

@prompt 让写设计个产品原型并写 PRD

![](https://img.t5t6.com/1747729312139-9472ed65-469e-46a6-b620-1187b089a0e3.png)

甚至还能组个多个 MCP 工具，实现复杂工作流。

我让 AI 基于我正在浏览的内容，生成微信公众号标题。
![](https://img.t5t6.com/1747729449379-4a37c8ec-a1b6-4baa-b446-5782bdf4f82f.png)

---

## 主要功能

- 📦 **丰富的 Prompt 模板**：内置多种高质量 Prompt，涵盖代码、写作、产品、知识卡片、网页生成、结构化总结等场景。
- 🛠️ **即插即用的 MCP 工具**：所有 Prompt 自动注册为 MCP 工具，支持参数化调用，适配主流编辑器。
- 🔄 **热加载与管理**：支持一键 reload，无需重启即可加载新 Prompt。
- 🧩 **极易扩展**：只需添加 YAML/JSON 文件即可扩展新功能，无需改动主程序。
- 🏷️ **支持多语言与多领域**：适合中英文内容、产品、教育、媒体、AI 等多种应用。

---

## 目录结构

```
mcp-prompt-server/
├── package.json
├── src/
│   ├── index.js                # 服务器主入口
│   └── prompts/                # 所有Prompt模板目录
│       ├── gen_summarize.yaml
│       ├── gen_title.yaml
│       ├── gen_html_web_page.yaml
│       ├── gen_3d_webpage_html.yaml
│       ├── gen_bento_grid_html.yaml
│       ├── gen_knowledge_card_html.yaml
│       ├── gen_magazine_card_html.yaml
│       ├── gen_prd_prototype_html.yaml
│       ├── ...                # 更多Prompt模板
│   └── prompt_more / # 可选扩展Prompt
└── README.md
```

---

## 快速开始

1. **安装依赖**

   ```bash
   npm install
   ```

2. **启动服务器**

   ```bash
   npm start
   ```

   启动后，MCP Prompt Server 会自动加载`src/prompts/`目录下所有 Prompt 模板，并以 MCP 工具形式对外提供服务。

---

## 如何使用

### 工具集成

#### Raycast

1. 在 Raycast 搜索 `install server（MCP）`

   ![](https://img.t5t6.com/1747728547294-26c78178-6e42-4e02-a7f3-c9bd9cdbc1fe.png)

2. 给 MCP 输入一个名字，建议简单点，方便以后@使用，比如叫 `prompt`
3. Command 填写 `node`
4. Argument 填写你的 `index.js` 路径地址

   ![](https://img.t5t6.com/1747728622599-82551d14-937b-4e7c-9429-68d72b7036ce.png)

5. 保存即可，Raycast 会自动集成 MCP Prompt Server。

##### 注意事项

- 未来新增 Prompt，可以复制已有模版让 AI 参考生成 YAML 文件。
- **模版中的 `arguments: []` 要么为空，要么参数设置为非必填（false），否则 Raycast 会报错。**
- 如果报错，可以在 Raycast 中搜"manage server（MCP）"卸载后重装。
- 每次新增 Prompt，都需要卸载重装 MCP，暂时没找到更优解。

---

#### Cursor

- 编辑 `~/.cursor/mcp_config.json`，添加如下内容（请将路径替换为你实际的项目路径）：

  ```json
  {
    "servers": [
      {
        "name": "Prompt Server",
        "command": "node",
        "args": ["/你的文件实际路径/mcp-prompt-server/src/index.js"],
        "transport": "stdio"
      }
    ]
  }
  ```

- 保存后重启 Cursor，即可在工具面板中看到所有 Prompt 工具。

#### Windsurf

- 编辑 `~/.codeium/windsurf/mcp_config.json`，添加：

  ```json
  {
    "mcpServers": {
      "prompt-server": {
        "command": "node",
        "args": ["/path/to/mcp-prompt-server/src/index.js"],
        "transport": "stdio"
      }
    }
  }
  ```

- 刷新 Windsurf 设置，Prompt Server 即刻生效。

#### Trae

- 编辑配置文件，添加：

  ```json
  {
    "mcpServers": {
      "Prompt Server": {
        "command": "node",
        "args": ["/你的文件实际路径/mcp-prompt-server/src/index.js"]
      }
    }
  }
  ```

- 保存配置后重启 Trae 即可使用。

---

## 部署到 Smithery.ai

Smithery.ai 是一个 MCP 服务器托管平台，可以让你的 MCP 服务无需本地安装即可在线使用。以下是部署步骤：

### 1. 准备项目

确保你的项目根目录已包含以下文件：

- `Dockerfile` - 定义如何构建服务器容器
- `smithery.yaml` - 定义如何启动 MCP 服务器

### 2. 创建 Smithery 账号

1. 访问 [Smithery.ai](https://smithery.ai) 并注册账号
2. 使用 GitHub 账号登录更方便，因为可以直接集成仓库

### 3. 将项目推送到 GitHub

确保你的项目代码已推送到 GitHub 仓库：

```bash
# 初始化Git仓库（如果尚未初始化）
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "准备部署到Smithery"

# 添加远程仓库（替换为你的GitHub仓库URL）
git remote add origin https://github.com/你的用户名/mcp-prompt-server.git

# 推送到GitHub
git push -u origin main
```

### 4. 在 Smithery 部署

1. 登录 Smithery.ai
2. 点击"Deploy Server"按钮
3. 选择你的 GitHub 仓库
4. 如果你的 MCP 服务器不在仓库根目录，需要在设置中指定基础目录
5. 点击"Deploy"按钮开始部署

### 5. 部署完成

部署成功后，你会获得一个托管 URL，格式类似：

```
https://server.smithery.ai/你的用户名/mcp-prompt-server/...
```

### 6. 使用托管服务

在支持 MCP 的客户端（如 Claude Desktop、Raycast、Cursor 等）中，添加托管服务：

1. 选择"Add MCP Server"
2. 选择"Smithery Server"
3. 搜索并选择你的服务器名称
4. 完成设置

现在，你可以通过网络使用你的 MCP Prompt Server，无需本地安装和运行！

## 如何扩展 Prompt

1. **新建 YAML 或 JSON 文件**，放入`src/prompts/`目录。
2. **模板格式示例**：

   ```yaml
   name: your_prompt_name
   description: 这个Prompt的用途说明
   arguments: []
   messages:
     - role: user
       content:
         type: text
         text: |
           你的Prompt内容，支持参数占位符{{param}}
   ```

3. **热加载 Prompt**
   - 在编辑器中调用`reload_prompts`工具，或重启服务器即可。

---

## 管理与调试

- `reload_prompts`：热加载所有 Prompt 模板
- `get_prompt_names`：获取当前所有可用 Prompt 名称

---

## 高级用法与扩展

- 支持多轮对话 Prompt、复杂参数、跨语言内容、数据可视化等高级场景
- 可将`src/prompts/更多Prompt，需要时拿出来/`目录下的模板随时复制到主目录启用

---

## 常见问题

- **Prompt 未生效？**  
  检查 YAML 格式、name 字段唯一性，并 reload 或重启服务。
- **参数不生效？**  
  确认 arguments 字段正确，调用时传递参数名和值。

---

## 贡献与反馈

- 欢迎提交新 Prompt、优化建议或 Bug 反馈！
- 联系作者：向阳乔木

---

## License

MIT

---

如需进一步定制、批量生成 Prompt 或企业级集成，欢迎联系作者或提交 Issue！
