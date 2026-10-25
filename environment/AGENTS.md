# 软件环境约定

- 所有软件环境相关文件集中在本目录，文件夹和脚本使用英文名称。
- 语义数据技术、机器学习、深度学习共用 Conda 环境 `ARU`，Python 使用 3.12 系列；不要向 `base` 安装课程依赖。
- 新电脑按 `environment.yml` 重建环境，不直接复制 Miniconda 的环境目录；新增依赖同步更新清单。
- Protégé 5.6.9 保留自带 Java 11，Fuseki 6.2.0 使用 `tools` 内的 Java 21，不混用，不修改系统 Java 配置。
- 启动器按自身所在目录定位软件；Jupyter 的课程根目录是本目录的上一级仓库目录。
- Fuseki 数据保存在本目录的 `data/fuseki`，TDB/TDB2 模板使用相对路径；复制数据库前必须正常停止对应服务。
- 不要停止其他目录正在运行的服务；验证新副本时使用空闲端口。
- Git 跟踪安装脚本、版本、校验值、配置和说明；`tools`、`downloads`、活动数据库和日志不提交。
- 文件使用 UTF-8、CRLF；为兼容 Windows PowerShell 5，`.ps1` 使用 UTF-8 BOM，其他新增文件不带 BOM。
