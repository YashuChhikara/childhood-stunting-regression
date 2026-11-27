# Childhood stunting across Indian districts

**M.Stat Regression Techniques project** · Indian Statistical Institute, Delhi · October 2026  
Yashu Chhikara | Course instructor: Prof. Deepayan Sarkar

[Project report (PDF)](report/PROJECT_REPORT.pdf) · [Presentation (PDF)](presentation/CHILDHOOD_STUNTING_PROJECT.pdf) · [Data and variables](data/README.md) · [Numerical results](results/parsimonious/)

## Research question

How does childhood stunting prevalence vary with socioeconomic conditions, household services and women's health across Indian districts? The analysis uses NFHS-5 district-level data for **707 districts across 36 states and union territories**, with stunting prevalence among children under five as the response and 12 candidate explanatory indicators.

State intercepts account for differences in baseline stunting across states. The coefficients describe associations between districts within a state, conditional on the other included indicators.

![Distribution of childhood stunting across 707 districts](report/figures/project_outcome_distribution.png)

## Statistical methodology

- Exploratory data analysis, state-level variation, LOWESS smoothers and within-state variance inflation factors (VIF).
- Ordinary least squares with state fixed effects and exhaustive comparison of all 4,096 subsets of 12 candidate indicators using AIC and BIC.
- Residual and spread plots, studentized residual Q–Q plots, leverage, Cook's distance, component-plus-residual plots, quadratic-term tests and Box–Cox profiling.
- HC3 heteroskedasticity-robust and state-clustered (CR1) covariance estimates, Huber M-estimation, district/state deletion refits and sensitivity to source flags.
- State-stratified five-fold cross-validation comparing state-only, full and selected OLS models with ridge and LASSO. Subset selection, predictor scaling and penalty tuning are performed inside training data.

## Results

BIC selected four indicators, explaining **30.9% of the variation remaining after accounting for state means** (overall R² = 0.587).

| Indicator | Estimated change in district stunting per 10-percentage-point increase |
| --- | ---: |
| Women's literacy | −2.31 pp |
| Improved sanitation | −0.86 pp |
| Women's low BMI | +2.26 pp |
| Institutional births | −1.30 pp |
parsimonious_associations.png

### Internal prediction assessment

| Procedure | Held-out RMSE (percentage points) |
| --- | ---: |
| State-only baseline | 6.92 |
| BIC subset selection | 5.93 |
| Full 12-indicator OLS | 5.83 |
| Ridge (minimum-error penalty) | 5.84 |
| LASSO (minimum-error penalty) | 5.82 |

The BIC procedure reduced RMSE by **14.4%** relative to the state-only baseline while retaining a compact set of indicators. The common evaluation set contains 705 districts in states represented in training.

![Held-out prediction comparison](report/figures/project_prediction.png)

### State-varying slope extension

An additional exploratory model permits state-specific random slope deviations with partial pooling. Its held-out RMSE was 5.94 percentage points. Details, plots and results are available in [results/state_varying_slopes](results/state_varying_slopes/README.md).

## Reproduce the analysis

The analysis uses R with the packages MASS, nlme and sandwich. MASS and nlme ship with standard R installations. Install sandwich from an R session if needed (`install.packages("sandwich")`).

From the repository root:

```sh
Rscript REPRODUCE_CURRENT.R
Rscript scripts/11_state_varying_slopes.R  # optional extension
```

The first command runs the complete analysis pipeline, publishes the selected model and regenerates the numerical evidence and figures. Generated RDS model objects and supporting outputs are recreated by running the pipeline.

| Path | Contents |
| --- | --- |
| [data/](data/) | Original district-level CSV, parsed inputs and indicator definitions |
| [scripts/](scripts/) | Analysis, model selection, diagnostics, inference and validation in R |
| [results/parsimonious/](results/parsimonious/) | Selected model coefficients, metrics, diagnostics and sensitivity checks |
| [results/validation/](results/validation/) | Exhaustive subset comparison and cross-validation evidence |
| [report/](report/) | Final report, Markdown narrative and figures |
| [presentation/](presentation/) | Final presentation in PDF and editable PowerPoint formats |

The project is exploratory and the intervals condition on the selected model. District-level associations do not identify intervention effects or individual-child relationships. The held-out results assess prediction within represented states.
