# Week 3：NLP 与 SPARQL / NLP and SPARQL

两个课堂作业集中在本目录，代码注释、操作说明和输出标签均有中英对照。
This folder contains both classroom assignments, with bilingual comments, instructions and output labels.

| 文件 / File | 内容 / Contents |
|---|---|
| `NLP_Text_Preprocessing.ipynb` | NLP 预处理：规范化、分词、词干、词形还原、停用词 / NLP preprocessing: normalization, tokenization, stemming, lemmatization and stop words |
| `SPARQL_Fuseki_Library.ipynb` | Python 连接 Fuseki，19 个示例和 12 道作业 / Python connects to Fuseki for 19 examples and 12 homework tasks |
| `library.ttl` | 老师提供的原始图书数据 / Original library data provided for the tutorial |
| `data/nltk_data` | 随附必需的英文语料，可离线运行 / Required English language resources for offline execution |
| `environment.yml` | 独立复制本目录时使用的 Python 环境清单 / Python environment definition for a standalone copy |
| `start-fuseki.bat`、`fuseki-library.ttl` | 启动本作业的持久化图书库 / Start this assignment's persistent library dataset |

## 一键安装 / One-click installation

在新 Windows x64 电脑上复制完整仓库，双击仓库中的 **`environment/install-environment.bat`**。首次安装保持联网，等到显示“环境检查及安装完成”。
Copy the complete repository to the new Windows x64 computer and double-click **`environment/install-environment.bat`**. Stay online for the first installation and wait for the completion message.

安装器会自动寻找 Miniconda，包括 `D:\miniconda3`；准备 Java 21、Fuseki 6.2.0、Protégé 5.6.9；创建或更新 `ARU` 环境，安装 NLTK、Matplotlib 和其他课程依赖，并注册 `Python (ARU)` 内核。已有环境不会被删除，更新前请保存并关闭 Notebook。
The installer detects Miniconda, including `D:\miniconda3`; prepares Java 21, Fuseki 6.2.0 and Protégé 5.6.9; creates or updates `ARU`; installs NLTK, Matplotlib and the other course dependencies; and registers the `Python (ARU)` kernel. Existing environments are kept. Save and close notebooks before updating.

软件位于仓库的 `environment/tools`，作业只保存代码、数据和配置，不需要重复携带软件安装包。
Software is stored under the repository's `environment/tools`. This assignment contains code, data and configuration, without duplicate software installations.

## 运行顺序 / Run the assignments

1. 做图书库作业时，先双击本目录的 **`start-fuseki.bat`**，保持窗口开启。NLP 作业不需要 Fuseki。
   For the library assignment, double-click **`start-fuseki.bat`** in this folder and keep it open. The NLP assignment does not require Fuseki.
2. 双击仓库的 **`environment/start-jupyterlab.bat`**，打开 `assignments/Week3_NLP_SPARQL`。
   Double-click **`environment/start-jupyterlab.bat`** and open `assignments/Week3_NLP_SPARQL`.
3. 打开对应 Notebook，选择 **`Python (ARU)`**，执行“重启内核并运行所有单元格”。结果保存在 Notebook 输出中。
   Open a notebook, select **`Python (ARU)`**, and choose “Restart Kernel and Run All Cells”. Results are retained in the notebook outputs.

图书库查询地址为 <http://127.0.0.1:3030/library/query>，修改地址为 <http://127.0.0.1:3030/library/update>。Python 通过 HTTP 请求 Fuseki 执行查询，不会用本地图查询代替。
The query endpoint is <http://127.0.0.1:3030/library/query> and the update endpoint is <http://127.0.0.1:3030/library/update>. Python sends HTTP requests to Fuseki to execute queries.

若 3030 已被其他服务占用，请先在对应窗口正常停止服务。也可用 `start-fuseki.bat 3032`，并将 Notebook 的 `DATASET` 改为 `http://127.0.0.1:3032/library`。不要同时启动两份服务访问同一个数据库。
If another service uses port 3030, stop it normally in its own window first. Alternatively, run `start-fuseki.bat 3032` and change the notebook's `DATASET` to `http://127.0.0.1:3032/library`. Do not open the same database with two servers.

## 数据与提交 / Data and submission

`library.ttl` 和 NLP 语料随目录提供。图书库仅在空库时导入 42 条原始三元组；第 12 题在最后清理临时书，重复运行不会增加练习数据。
The folder includes `library.ttl` and the required NLP resources. The library imports its 42 source triples only into an empty dataset. Task 12 removes its temporary book at the end, allowing repeated runs without accumulating practice data.

运行后的数据库保存在 **本目录的 `data/fuseki/library`**，服务缓存位于 `.runtime/fuseki`。它们不提交 Git；新电脑可由 `library.ttl` 自动重建课堂数据。要保留自行修改的数据库，先按 Ctrl+C 正常停止 Fuseki，再连同本目录一起复制。
The persistent database is stored **inside this folder at `data/fuseki/library`**, with server runtime files at `.runtime/fuseki`. These are ignored by Git. A new computer rebuilds the course data from `library.ttl`. To preserve your own database changes, stop Fuseki normally with Ctrl+C before copying the complete folder.

提交时可只打包本作业目录，保留两个 Notebook、`library.ttl`、`data/nltk_data`、来源与许可、环境清单、说明和启动配置；可排除 `.runtime`、`data/fuseki` 和 `.ipynb_checkpoints`。NLTK 数据来源和许可见 [data/README.md](data/README.md)。
For submission, package this assignment folder with both notebooks, `library.ttl`, `data/nltk_data`, source and licence notices, environment definition, instructions and launch configuration. Exclude `.runtime`, `data/fuseki` and `.ipynb_checkpoints` if desired. See [data/README.md](data/README.md) for NLP data sources and licences.

## 单独文件夹运行 / Run a standalone copy

代码和数据不依赖固定盘符。已配置 Python 和 Fuseki 的电脑只需复制本目录；在目录内启动 Jupyter，选择有相应依赖的内核。
Code and data do not depend on a drive letter. On a computer with Python and Fuseki already configured, copy this folder, start Jupyter inside it and select a kernel with the required dependencies.

脱离仓库时，`start-fuseki.bat` 使用标准的 `JAVA_HOME` 和 `FUSEKI_HOME` 环境变量寻找 Java 21 与 Fuseki 6.2.0。首次安装全部工具推荐使用完整仓库的一键安装入口；本目录的 `environment.yml` 也可供已有 Conda 的使用者创建或更新 Python 环境。
Outside the repository, `start-fuseki.bat` uses the standard `JAVA_HOME` and `FUSEKI_HOME` variables to locate Java 21 and Fuseki 6.2.0. For a first installation of all tools, use the complete repository's one-click installer. The included `environment.yml` also lets existing Conda users create or update the Python environment.

## 检查范围 / Validation scope

NLP 包含预处理结果自检；图书库包含 19 个示例、12 道作业、具体结果值及临时数据清理检查。图书库的检查以老师的原始 42 条三元组为准，自行修改数据后需要同步调整预期结果。
NLP includes preprocessing assertions. The library checks 19 examples, 12 homework tasks, concrete result values and temporary-data cleanup. Library expectations refer to the original 42 course triples and must be updated if you change the data.

这份课堂材料尚未实现任意自然语言自动转换为 SPARQL。
These practicals do not implement unrestricted natural-language-to-SPARQL translation.
