# Hopfield 体育本体操作指南

本目录是 MOD004979 体育本体作业的交付包。OWL 文件符合 OWL 2 DL，随附查询结果是针对当前交付数据生成并复核过的结果。

- [打开英文 HTML 操作指南](Hopfield_Operation_Guide.en.html)
- [打开中文 HTML 操作指南](Hopfield_Operation_Guide.zh-CN.html)

## 在 Protégé 中打开本体

1. 启动 Protégé 5.6.9，打开 `Hopfield_Sports_Ontology.owl`。
2. 做实验前先另存工作副本。复现已复核结果时使用交付文件本身。
3. 英文交付版保持插件开关 `Help → 简体中文界面 (Chinese UI)` 不勾选。首次使用时默认关闭，插件会记住选择；勾选后显示中文界面，取消勾选后恢复英文。OWL 本体本身只含英文标签，该开关只改变插件显示层。已收录的实体名称、英文标签、注释正文和作业描述也会随开关显示中文；IRI、数字、日期及查询变量保持原样。安装可选中文插件后才会出现这个开关；英文 OWL 不需要中文插件。
4. `doc/screenshots/` 中保留了本体加载、HermiT 一致性和英文查询结果截图。

## 启动 HermiT 并检查推理

1. 在 Protégé 中打开 `Reasoner` 菜单，选择 `HermiT`，再选择 `Start reasoner`。
2. 等待分类完成后，再查看推断出的类型和逆属性。
3. 对照 `validation/hermit-check.json` 检查：本体一致、没有不可满足类，`Football` 被分类为运动项目，`LusailStadium` 被分类为场馆，并且可以得到 `hasAthlete` / `memberOf` 的逆向关系。
4. 该文件中的负例是独立验证夹具：运动员与场馆同时分类、同一场比赛有两个不同主队比分、场馆容量为负数，三种情况都应导致不一致。不要把这些负例加入生产本体。
5. `validation/owl2dl-violations.txt` 对当前交付文件为空。

## 运行 SPARQL 查询

每个 `.rq` 文件都是完整的 SPARQL 1.1 查询，需要时会包含 `sports`、`rdf`、`rdfs`、`owl`、`xsd` 前缀。

1. 打开已安装的 Protégé SPARQL Query 插件提供的查询页，或者把某个 `.rq` 文件的完整内容粘贴到查询编辑器。
2. 对当前本体运行查询。要区分显式断言和推断结果：HermiT 可以提供逆属性和类别推断，而 QA13 特意按原始断言图做数据质量检查。
3. 如需重新运行，可保存或复制结果。已复核的结果文件在 `results/` 目录。
4. 不要为了让空查询出现结果而修改本体。当前教学数据下，空结果可能就是正确答案。

## 五个有区分度的查询演示

报告或演示统一使用下面五个查询，它们使用了不同的 SPARQL 特性：

1. `queries/Q02.rq`：对世界杯 `TeamMembership` 记录做 `COUNT(DISTINCT ...)`，预期人数为 26。
2. `queries/Q06.rq`：使用必需比赛关系和 `OPTIONAL` 点球比分；决赛为阿根廷 3:3 法国，点球 4:2。
3. `queries/Q16.rq`：用 `BIND(IF(...))` 选出获胜方主客场比分，再用数值 `FILTER` 筛选大于 3 的进球数。
4. `queries/Q21.rq`：使用 `xsd:dateTime` 成员时间区间、可选结束日期和 2024-07-01 快照条件。
5. `queries/Q22.rq`：用 `MAX` 子查询找出世界杯冠军数最多的球队。

这五题分别展示聚合、可选模式、条件绑定、时间过滤、数值过滤和子查询，不重复同一种查询模式。

## 文件结构

- `Hopfield_Sports_Ontology.owl`：在 Protégé 中打开的生产本体。
- `queries/Q01.rq`–`Q22.rq`：22 个概念与需求问题。
- `queries/QA01.rq`–`QA15.rq`：15 个具体问题。
- `results/Q01.csv`–`QA15.csv`：37 个查询的复核 CSV 结果，CSV 使用带 BOM 的 UTF-8，便于表格软件打开。
- `results/query_results.json`：包含列名和行数的完整结果。
- `validation/hermit-check.json`：HermiT 一致性与推理检查。
- `validation/owl2dl-violations.txt`：OWL 2 DL 配置检查。
- `doc/screenshots/`：保留的 Protégé 截图。

## 数据范围和解释口径

本体包含 46 个命名类、45 个对象属性、18 个数据属性和 222 个命名个体，分别建模运动项目、运动员、球队、联赛、赛事、比赛、场馆、装备、奖杯、名单记录和执教记录。`TeamMembership` 与 `CoachingAssignment` 带有 `validFrom` 和 `validTo`；日期和运动员年龄快照使用 `xsd:dateTime`，参考日期为 2024-07-01。

当前记录中的 2022 世界杯阿根廷名单有 26 名运动员，2024 巴黎男子足球项目有 16 支奥运代表队。世界杯决赛记录为加时后阿根廷 3:3 法国，点球 4:2。其余内容是教学用选取数据，不代表完整赛季、完整世界杯或完整奥运会数据。

`Q15`、`QA13` 和 `QA15` 有意返回空结果：当前数据没有同时执教足球队和篮球队的教练，没有悬空球队引用，也没有生产本体中的矛盾断言。OWL 采用开放世界假设，查不到一行不等于事实为假。QA13 使用 `FILTER NOT EXISTS` 做闭世界数据质量检查，QA15 检查选定的矛盾模式；完整逻辑一致性由 HermiT 单独验证。

## 交付注意事项

试验查询或公理前先另存副本。复现随附 CSV/JSON 结果时使用 `Hopfield_Sports_Ontology.owl` 交付文件。
