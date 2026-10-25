# Windows 学习环境

本目录集中存放课程软件、启动器、Python 依赖清单和迁移安装脚本，适用于 Windows x64。

**第一次在另一台电脑安装，先看 [新电脑安装环境：五步操作](快速开始.md)**。这份中文速查包含顺序流程图、操作表和成功标志。

## 软件清单

| 软件 | 版本 | 用途 |
|---|---|---|
| Protégé | 5.6.9，自带 Java 11 | 编辑本体、HermiT 推理、SPARQL 查询，包含仓库现有中文插件和兼容补丁 |
| Temurin Java | 21.0.12.1 JRE | 运行 Fuseki，无需另配系统 Java |
| Apache Jena Fuseki | 6.2.0 | 本地知识库与 SPARQL 服务 |
| Conda 环境 | ARU，Python 3.12 | 语义数据技术、机器学习、深度学习共用环境 |
| JupyterLab | 4.6.4 | 笔记本界面，包含简体中文包 |

Python 清单还包含 RDFLib、SPARQLWrapper 和 ipykernel。PyTorch、TensorFlow 和 GPU 环境尚未配置，后续按课程需要添加。

## 本机启动

- `start-protege.bat`：打开本目录内的 Protégé。首次使用中文界面时，在 Help 菜单勾选简体中文开关。
- `start-fuseki.bat`：启动本地服务，看到 `Start Fuseki` 后打开 <http://127.0.0.1:3030/>。运行时保留窗口，关闭窗口或按 `Ctrl+C` 会停止服务。
- `start-jupyterlab.bat`：激活 ARU，浏览器自动打开中文 JupyterLab；文件浏览范围是整个项目，可以访问 `assignments`。
- `install-environment.bat`：在新电脑恢复软件和 Python 环境；也可用于检查现有安装是否齐全。

如果旧位置的 Fuseki 正占用 3030 端口，先在旧服务窗口正常停止，再启动这里的新副本。复制软件本身不需要停止旧服务；复制正在使用的数据库则必须先停止。

## 在另一台电脑使用

### 直接复制整个项目

1. 保存笔记本，正常停止要迁移的 Fuseki，再复制整个项目，包含本目录的 `tools`、`data` 和 `config`。
2. Java、Fuseki 和 Protégé 可直接使用相应启动器，盘符和项目位置可以变化。
3. 新电脑安装 Miniconda 后，双击 `install-environment.bat`，根据 `environment.yml` 创建 ARU 并注册 `Python (ARU)` 内核。已有 ARU 环境会保留，不会删除或覆盖。
4. 桌面快捷方式需要在新电脑重新创建，指向新位置中的启动文件。

### 通过 Git 同步项目

Git 只保存脚本、配置和版本清单。数百 MB 的软件运行库、下载缓存和活动数据库已忽略。

1. 在新电脑克隆完整项目，并安装 Miniconda。下载地址：[Miniconda 官方安装说明](https://www.anaconda.com/docs/getting-started/miniconda/install)。
2. 双击 `install-environment.bat`。脚本从官方地址下载固定版本，核对校验值后解压，并从上一级仓库的 `plugins/chinese-ui-plugin/dist` 安装两个现有插件。
3. 首次恢复需要联网。`downloads` 中已有匹配校验值的压缩包时会复用。
4. 运行上述三个启动器。Python 依赖下载源来自 `environment.yml`，不会向 Conda base 安装课程包。

如果 Miniconda 不在常见位置，可先打开 Miniconda Prompt，再运行安装或启动脚本。

## 文件布局

```text
environment/
  install-environment.bat
  start-protege.bat
  start-fuseki.bat
  start-jupyterlab.bat
  environment.yml
  software-manifest.json
  scripts/
  config/jupyter/
  data/fuseki/templates/
  tools/                      软件运行目录，不提交 Git
  downloads/                  已校验的安装包缓存，不提交 Git
```

Fuseki 的持久化库放在 `data/fuseki/databases`，新建库请选择 TDB2。此副本不复制原课程目录中正在使用的数据库；原有服务和数据保留在原处。需要迁移数据时，可停服后复制完整的 `data/fuseki`，或将保存的 OWL/RDF 文件重新导入。

已在本机验证两个 Java 版本、软件和下载包完整性、Python 依赖、内核路径及 Jupyter 的课程目录和中文配置；新位置的 Fuseki 在独立测试端口成功查询到体育本体的 2799 条三元组，与仓库 OWL 一致。尚未在另一台实体电脑上验证。
