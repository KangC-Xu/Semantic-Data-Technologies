# Hopfield Sports Ontology: final group version

This folder contains the group's v3.0 OWL file, the 25-question query workbook, group reports and Kangcheng Xu's individual presentation. The ontology contains selected teaching examples, not a complete sports dataset.

## Files

- [Final OWL ontology](Hopfield_Sports_Ontology.owl)
- [General questions](materials/Sports%20Ontology一般问题.xlsx), [specific questions](materials/Sports_Ontology_15_Specific_QA.xlsx), and [25-question SPARQL workbook](materials/体育本体25题SPARQL查询手册.xlsx)
- [English four-slide presentation](presentation/徐康成_体育本体_四页精简_英文版.pptx), [Chinese presentation](presentation/徐康成_体育本体_四页精简_中文版.pptx), and [speaking notes](presentation/讲解稿与答辩准备_三句版.md)
- [Personal Jupyter notebook](notebooks/Sports_Ontology_Xu_2623912.ipynb)
- [Group presentation](presentation/Sports_Ontology_Assessment_Presentation.pptx), [group report](materials/Sports_Ontology_Final_Report.docx), and [example report](materials/Semantic_Data_Example_Report.pdf)

The group presentation still contains placeholder names and overlapping question assignments; check these with the team leader. The question workbooks assign G01, G03, S03, S11 and S12 to Kangcheng Xu.

## Run on another computer

Copy the full repository. On Windows, install Miniconda, then run `environment/install-environment.bat`. Launch `environment/start-jupyterlab.bat`, open the notebook in this folder and select **Python (ARU)**. To inspect the OWL file, launch `environment/start-protege.bat` and open `Hopfield_Sports_Ontology.owl`.

For a standalone copy of this assignment, create the ARU environment using its `environment.yml` if an ARU environment does not already exist, register the kernel and start JupyterLab:

```powershell
conda env create -f environment.yml
conda activate ARU
python -m ipykernel install --user --name aru --display-name "Python (ARU)"
python -m jupyterlab
```

Installing dependencies requires internet access. The notebook uses the included OWL and NLTK data and needs no network access when running.

## Queries and scope

`queries/` contains G01–G10 and S01–S15 extracted from the group workbook. `results/` contains locally generated CSV results and row counts and is excluded from Git. Run `python run_queries.py` in the ARU environment to regenerate them. Xu's five queries return 7, 3, 26, 1 and 135 rows, respectively. Counts describe recorded teaching data.

These are asserted-graph query results, not HermiT or SHACL validation reports. Absence of data does not prove a fact is false. The NLP interface uses five question patterns and resolves supported team and athlete names from the ontology; it rejects unsupported or ambiguous inputs.

Screenshots dated 20261025 relate to the earlier ontology and Chinese UI; they are not validation evidence for v3.0. Screenshots dated 20261101 support the individual presentation.
