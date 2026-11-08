# Hopfield 体育本体：小组最终版

本目录以小组 `20261029 v3.0` 本体和 25 题查询手册为准，包含问题表、报告、查询、结果及徐康成的个人展示。数据是教学样本，不代表完整赛事数据。

## 先打开什么

- [最终本体 OWL](Hopfield_Sports_Ontology.owl)：用 Protégé 打开；做修改前建议另存副本。
- [10 个一般问题](materials/Sports%20Ontology一般问题.xlsx)、[15 个具体问题](materials/Sports_Ontology_15_Specific_QA.xlsx)：包含中英文问题、答案和小组分工。
- [25 题 SPARQL 查询手册](materials/体育本体25题SPARQL查询手册.xlsx)：完整查询、示例与说明。
- [个人英文四页 PPT](presentation/徐康成_体育本体_四页精简_英文版.pptx)、[中文四页 PPT](presentation/徐康成_体育本体_四页精简_中文版.pptx)、[讲解稿与答辩准备](presentation/讲解稿与答辩准备_三句版.md)。
- [个人 Jupyter Notebook](notebooks/Sports_Ontology_Xu_2623912.ipynb)：G01、G03、S03、S11、S12，以及固定模板的 NLP 示例和三张图。
- [小组展示 PPT](presentation/Sports_Ontology_Assessment_Presentation.pptx)、[小组报告](materials/Sports_Ontology_Final_Report.docx)、[参考报告 PDF](materials/Semantic_Data_Example_Report.pdf)。

小组 PPT 的分工表仍有占位姓名及问题重复，使用前请与组长确认；两份问题表中的五题归属为徐康成。

## 在另一台 Windows 电脑使用

1. 复制完整仓库。安装 Miniconda，在 `environment` 文件夹双击 `install-environment.bat`，首次安装需要联网。已有 ARU 环境时请按照仓库环境说明处理，不使用 base。
2. 双击 `environment/start-jupyterlab.bat`，打开本目录的 `notebooks/Sports_Ontology_Xu_2623912.ipynb`；选择 **Python (ARU)**，依次运行单元格。
3. 用 `environment/start-protege.bat` 启动 Protégé，打开本目录的 `Hopfield_Sports_Ontology.owl`。

如果只复制本作业目录，可用该目录中的 `environment.yml` 在已安装 Miniconda 的电脑上创建 `ARU` 环境（已有同名环境时不要重复创建），再安装 Jupyter 内核并从本目录启动 JupyterLab：

```powershell
conda env create -f environment.yml
conda activate ARU
python -m ipykernel install --user --name aru --display-name "Python (ARU)"
python -m jupyterlab
```

Notebook 从作业目录查找 OWL 和 `data/nltk_data`，不依赖原电脑盘符或外部 NLTK 资源。Python 依赖安装需要联网；运行 Notebook 本身不需要联网。

## 查询与结果

`queries/G01.rq`–`G10.rq`、`queries/S01.rq`–`S15.rq` 直接取自小组查询手册，可复制到 SPARQL 编辑器。`results/` 存放使用 RDFLib 运行查询生成的 CSV 和行数记录；这是本机生成的文件，不通过 Git 上传。徐康成五题的行数依次为 **7、3、26、1、135**；数字只反映本体中已有的数据。

在 ARU 环境中进入本作业目录，运行 `python run_queries.py` 可重新生成 25 个 CSV 和行数记录。

查询基于显式数据，不能把这些 CSV 当成 HermiT 或 SHACL 验证报告。查不到关系也不等于现实中不存在该关系。NLP 接口支持五种问句模式，并从本体识别受支持的球队和运动员名称；不支持或有歧义的输入会被拒绝。

`doc/screenshots/` 中 20261025 截图属于旧版本及中文界面资料，不能作为 v3.0 验证结果；20261101 截图用于个人展示。
