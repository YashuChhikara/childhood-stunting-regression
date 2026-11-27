# Data

The supplied NFHS-5 district-level dataset contains 707 district observations. Each row contains aggregated survey indicators for a district and its state or union territory.

- [Raw CSV](raw/Sheet1-Table%201.csv) — original input, preserved byte-for-byte so the analysis can be reproduced.
- [Model data](processed/model_data.csv) — parsed outcome, state and candidate predictors used in modelling.
- [Indicator registry](processed/indicator_registry.csv) — indicator names and source definitions.
- [Source flags](processed/source_flags.csv) and [used-field flags](processed/used_source_flags.csv) — preserve the original notation for small samples and suppressed observations.

The response is district childhood stunting prevalence. The primary model gives every district equal weight. The source values, flags and definitions are preserved in the analysis pipeline.
