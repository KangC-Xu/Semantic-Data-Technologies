# Semantic-Data-Technologies

Coursework and practical materials for Semantic Data Technologies (MOD004979).

## Hopfield sports ontology

The [assignment folder](assignments/Hopfield_Sports_Ontology/) contains the English OWL ontology, 37 SPARQL queries, checked results, validation records and bilingual operation guides.

| Resource | English | Simplified Chinese |
| --- | --- | --- |
| Quick operation guide | [README](assignments/Hopfield_Sports_Ontology/README.md) | [中文说明](assignments/Hopfield_Sports_Ontology/README.zh-CN.md) |
| Illustrated demonstration and Q&A | [HTML guide](assignments/Hopfield_Sports_Ontology/Hopfield_Operation_Guide.en.html) | [中文图文指南](assignments/Hopfield_Sports_Ontology/Hopfield_Operation_Guide.zh-CN.html) |

1. Open [Hopfield_Sports_Ontology.owl](assignments/Hopfield_Sports_Ontology/Hopfield_Sports_Ontology.owl) in Protégé 5.6.9.
2. Start HermiT to inspect consistency and inferred types.
3. Run a complete `.rq` file from `queries/` in the SPARQL Query tab and compare the output with `results/`.
4. Open either HTML guide locally in a browser for screenshots, model diagrams, five query demonstrations and assessment Q&A.

GitHub displays HTML source. To view the illustrated guide, clone or download the repository and open the HTML file locally, keeping its assignment folder together. No web server or CDN is required.

## Contents and validation

- 46 named classes, 45 object properties, 18 data properties and 222 named individuals.
- 37 complete queries: Q01–Q22 and QA01–QA15, with CSV and JSON outputs.
- HermiT consistency, inference and isolated negative-case records; zero OWL 2 DL profile violations.
- Seven retained Protégé screenshots, including English/Chinese annotations and query results.

The copied ontology, queries and result data are byte-identical to the checked assignment package. The validation record retains those checks; its ontology path is relative to the validation file for portability.

The English OWL and queries are the coursework artifacts. Chinese guides and the optional local Chinese UI plugin support study. The plugin is not included or required to open the ontology; its display switch does not change the English OWL, entity IRIs, query text or result column names.

Data includes the final 26-player Argentina 2022 World Cup squad and the 16 teams in the Paris 2024 men's football competition. Other records are selected teaching examples; they do not form a complete sports database. See the guides for sources, date scope and explanations of empty query results.

## License

See [LICENSE](LICENSE). External reference sources remain subject to their respective terms.
