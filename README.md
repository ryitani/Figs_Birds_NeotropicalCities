# Exotic and native fruiting Ficus trees sustain avifauna in neotropical cities

## Overview

Urban trees provide critical resources for bird communities in highly modified environments. This study evaluates how fruiting phenology, landscape composition, and tree origin influence bird abundance and species richness in native (*Ficus tuerckheimii*) and exotic (*Ficus elastica*) trees in a Neotropical urban environment.

This repository contains the data and R scripts used to analyze bird community responses using generalized linear mixed models (GLMMs).

## Objectives

1. Evaluate how fruiting phenology influences bird abundance and species richness.
2. Examine the influence of landscape elements (green, gray, and blue cover) on bird assemblages.
3. Assess whether tree origin (native vs. exotic *Ficus* species) affects bird abundance and species richness.

## Study area

Fieldwork was conducted in urban green areas in Veracruz, Mexico. A total of 30 *Ficus* trees were surveyed:

- 15 native trees (*Ficus tuerckheimii*)
- 15 exotic trees (*Ficus elastica*)

Bird surveys were conducted across multiple fruiting phenological phases.

## Methods

Bird community responses were evaluated using generalized linear mixed models (GLMMs).

### Response variables

- Bird abundance (number of individuals)
- Bird species richness (number of species per survey)

### Fixed effects

- Fruiting phenological phase
- Green cover within 50 m buffer
- Foliage density
- Migratory season
- Fruit availability

### Random effect

- Tree identity, included to account for repeated observations of the same tree

### Model validation

Model assumptions and performance were evaluated using:

- Residual diagnostics (DHARMa)
- Dispersion tests
- Multicollinearity assessment
- Likelihood ratio tests against null models
- Marginal and conditional R² estimation

Post-hoc comparisons among fruiting phases were conducted using estimated marginal means (emmeans).

## Key findings

- Bird abundance varied significantly across fruiting phenological phases.
- Species richness remained relatively stable across fruiting phases.
- Landscape composition was not significantly associated with bird abundance or species richness.
- Tree origin (native vs. exotic) did not significantly influence bird abundance or species richness.
- Both native and exotic *Ficus* trees provide important foraging resources for urban bird communities.

## Requirements
To replicate our study, please ensure you have the following R packages installed:
- `lme4`
- `emmeans`
- `performance`
- `DHARMa`
- `MuMIn`
- `ggplot2`

### Installation code:
```R
install.packages(c('lme4', 'emmeans', 'performance', 'DHARMa', 'MuMIn', 'ggplot2'))
```
