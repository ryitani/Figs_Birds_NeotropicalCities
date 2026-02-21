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

Bird surveys were conducted across multiple fruiting phenological phases: 
- Immature phase
- Mature phase
- Few figs phase

## Methods

Bird community responses were evaluated using generalized linear mixed models (GLMMs).

### Response variables

- Bird abundance (number of individuals)
- Bird species richness (number of species per survey)

### Fixed effects

- Fruiting phenological phase
- Landscape variables
- Foliage density
- Migratory season
- Fruit availability

## Landscape variables

Landscape composition was quantified using circular buffers centered on each focal tree at four spatial scales:

- 50 m
- 100 m
- 200 m
- 500 m

Within each buffer, landscape elements were manually digitized using high-resolution satellite imagery in Google Earth Pro.

Landscape elements were classified into three categories:

- Green elements: trees and shrubs
- Gray elements: buildings, roads, and infrastructure
- Blue elements: rivers, ponds, and other water bodies

The proportion of each element was calculated as percentage of buffer area.

Final models included the spatial scale that best represented ecological responses based on model performance and collinearity diagnostics.

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

## Repository structure

data/
├── Base_Abu_Tuerckheimii2025.csv
└── Base_Abu_Elastica2025.csv

scripts/
├── FicusElastica_BirdAbundance.R
├── FicusElastica_BirdRichness.R
├── FicusTuerckheimii_BirdAbundance.R
└── FicusTuerckheimii_BirdRichness.R

## Requirements

Analysis conducted in R.

##Required packages:

lme4  
glmmTMB  
emmeans  
performance  
DHARMa  
MuMIn  
ggplot2  

##Install using:

install.packages(c(
  "lme4",
  "glmmTMB",
  "emmeans",
  "performance",
  "DHARMa",
  "MuMIn",
  "ggplot2"
))
