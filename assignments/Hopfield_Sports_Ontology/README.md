# Hopfield Sports Ontology Operation Guide

This folder is the English submission package for the MOD004979 sports ontology exercise. The ontology is an OWL 2 DL file, and the supplied query results are reproducible checks against the submitted data.

- [Open the HTML operation guide](Hopfield_Operation_Guide.en.html)
- [Open the Chinese HTML operation guide](Hopfield_Operation_Guide.zh-CN.html)

## Open the ontology in Protégé

1. Start Protégé 5.6.9 and open `Hopfield_Sports_Ontology.owl`.
2. Before experimenting, save a working copy. Use the submitted file unchanged when reproducing the checked results.
3. For the English submission, leave the plugin switch `Help → 简体中文界面 (Chinese UI)` unchecked. It is off on first use, and the plugin remembers the choice. Turning it on selects Chinese UI labels; turning it off restores English. The OWL contains English labels only; this switch changes the plugin display layer. Entity labels, recorded comments and the ontology description also switch for study; IRIs, numbers, dates and query variables stay intact. The switch is available only after installing the optional Chinese UI plugin; the English OWL works without it.
4. The screenshot set in `doc/screenshots/` records the loaded ontology, HermiT consistency, and an English query result view.

## Start HermiT and check inference

1. In Protégé, open the `Reasoner` menu, choose `HermiT`, and choose `Start reasoner`.
2. Wait for classification to finish before inspecting inferred types or inverse properties.
3. Confirm the basic checks shown in `validation/hermit-check.json`: the ontology is consistent, no unsatisfiable classes are reported, `Football` is classified as a sport, `LusailStadium` as a venue, and `hasAthlete` / `memberOf` inverse facts are available.
4. The negative cases in that file are separate validation fixtures: an athlete and venue dual type, two different functional home scores, and a negative venue capacity are each expected to be inconsistent. Do not add those fixtures to the production ontology.
5. `validation/owl2dl-violations.txt` is empty for the submitted file.

## Run a query

The `.rq` files are plain SPARQL 1.1 queries with the `sports`, `rdf`, `rdfs`, `owl`, and `xsd` prefixes included when needed.

1. Open the SPARQL Query tab supplied by the installed Protégé query plugin, or paste the complete contents of one `.rq` file into that editor.
2. Run the query against the active ontology. Keep asserted data and inferred data conceptually separate: HermiT can expose inverse and class inferences, while QA13 is intentionally written as an asserted-graph data-quality check.
3. Save or copy the result if a new run is required. The checked result files already supplied here are under `results/`.
4. Do not change the ontology to make an empty query return a row. Empty results can be the correct answer for the current teaching data.

## Five different query demonstrations

Use five queries with different SPARQL features in a report or demonstration:

1. `queries/Q02.rq` — `COUNT(DISTINCT ...)` over World Cup `TeamMembership` records; expected count: 26.
2. `queries/Q06.rq` — required match links plus `OPTIONAL` penalty scores; the final is Argentina 3:3 France and penalties 4:2.
3. `queries/Q16.rq` — `BIND(IF(...))` selects the winning side's score, followed by a numeric `FILTER` greater than 3.
4. `queries/Q21.rq` — `xsd:dateTime` membership interval filters with an optional end date and the 2024-07-01 snapshot.
5. `queries/Q22.rq` — a `MAX` subquery returns the team or teams with the most FIFA World Cup titles.

These five examples demonstrate aggregation, optional patterns, conditional binding, temporal filtering, numeric filtering, and subqueries without repeating one query pattern.

## Package layout

- `Hopfield_Sports_Ontology.owl` — the production ontology to open in Protégé.
- `queries/Q01.rq`–`Q22.rq` — the 22 concept and requirement questions.
- `queries/QA01.rq`–`QA15.rq` — the 15 specific questions.
- `results/Q01.csv`–`QA15.csv` — checked CSV output for all 37 queries; CSV files use UTF-8 with BOM for spreadsheet opening.
- `results/query_results.json` — the same checked outputs with column names and row counts.
- `validation/hermit-check.json` — HermiT consistency and inference checks.
- `validation/owl2dl-violations.txt` — OWL 2 DL profile check.
- `doc/screenshots/` — retained Protégé screenshots.

## Scope and interpretation

The ontology contains 46 named classes, 45 object properties, 18 datatype properties, and 222 named individuals. It separates sports, athletes, teams, leagues, competitions, matches, venues, equipment, trophies, roster records, and coaching assignments. `TeamMembership` and `CoachingAssignment` carry `validFrom` and `validTo`; dates and the athlete-age snapshot use `xsd:dateTime` with the reference date 2024-07-01.

The recorded Argentina 2022 World Cup roster has 26 athletes. The Paris 2024 men's football event has 16 recorded Olympic teams. The World Cup final is recorded as Argentina 3:3 France after extra time, with a 4:2 penalty shoot-out. The remaining records are selected teaching data and are not a complete season, World Cup, or Olympic Games dataset.

`Q15`, `QA13`, and `QA15` intentionally return no rows. The selected data has no coach recorded for both football and basketball, no unresolved team reference, and no contradictory production assertion. OWL uses the open-world assumption: an absent row does not prove that a fact is false. QA13 uses `FILTER NOT EXISTS` as a closed-world data-quality check, and QA15 checks selected contradiction patterns; full logical consistency is checked separately with HermiT.

## Safety rule for the submission

Save a copy before experimenting with queries or axioms. Use `Hopfield_Sports_Ontology.owl` when reproducing the supplied CSV/JSON results.
