# Protégé 简体中文插件

适用于 **Protégé 5.6.9 + Java 11**。本目录仅保留可安装插件和说明，不包含源码、构建工具或测试文件。英文作业本体无需安装插件即可打开。

## 安装

1. 下载或复制 [chinese-ui-1.0.1.jar](dist/chinese-ui-1.0.1.jar)，完全关闭 Protégé。
2. 如安装过 `chinese-ui-1.0.0.jar` 或 `protege-chinese-ui-1.0.0.jar`，先将旧版移出软件自身的 `plugins` 目录，避免同时加载多个版本。
3. 将 `chinese-ui-1.0.1.jar` 放入 Protégé 安装目录下的 `plugins`，重新启动 `Protege.exe`。
4. 首次默认英文；勾选 `Help → 简体中文界面 (Chinese UI)` 后显示中文，取消勾选即时恢复英文。插件会记住选择。

安装不需要源码、编译器、Python、Maven、网络连接或相同安装盘符。卸载时关闭 Protégé，将对应 JAR 移出 `plugins` 后重启。

## 显示范围

插件包含 703 条通用界面词条、331 个 Hopfield 体育实体译名、24 条注释及正文译文。菜单、标签页、按钮、提示以及已收录实体和注释会随开关显示中文。

插件只改变运行时显示，不修改 Protégé 核心 JAR 或英文 OWL。实体 IRI、输入和查询文本、SPARQL 变量列名、数字、日期及 OWL 语法保持原样；未收录文本和第三方自绘界面仍可能显示英文。

已有实际界面截图见 [作业截图目录](../../assignments/Hopfield_Sports_Ontology/doc/screenshots/)。

## 可选 SPARQL 兼容补丁

[rdf-library-compat-1.0.0.jar](dist/rdf-library-compat-1.0.0.jar) 仅适用于 **RDF Library 3.0.1 + Guava 18.x** 缺少 `com/google/common/base/Optional` 导入、导致 SPARQL 页面打不开的情况。只使用中文界面时无需安装。

需要时关闭 Protégé，将补丁放入软件自身的 `plugins` 后重启。补丁仅附加 OSGi 包导入声明，不改写原 RDF Library，也不包含额外依赖。它是 fragment，不会单独启动；日志可能同时出现 `was not successfully started` 和 `because it is a fragment bundle`。升级 RDF Library 后应移除补丁并重新检查。

中文插件与兼容补丁可以分别卸载。当前适配 Protégé 5.6.9 与 Java 11；其他版本尚未验证。