# Exotic and native fruiting Ficus trees sustain avifauna in neotropical cities

## Overview
This study investigates bird abundance and richness associated with native (F. tuerckheimii) and exotic (F. elastica) Ficus trees in urban environments, focusing on their fruiting characteristics and how they influence avian populations.

## Objectives
1. Evaluate the effects of fruiting phenology on bird abundance and richness.
2. Assess the impact of different landscape elements (green, grey, and blue) on avian presence.
3. Compare the responses of native and exotic Ficus species regarding their avifauna support.
4. Quantify ecological predictors that influence bird populations in these settings.

## Methods
We utilized Generalized Linear Mixed Models (GLMM) to analyze bird abundance and richness as response variables. Fixed effects included fruiting phases, green cover, foliage density, migratory season, while tree identity was treated as a random effect. Model validation approaches were employed to ensure the robustness of our findings.

## Key Points
- Our research encompassed 30 urban Ficus trees (15 exotic F. elastica and 15 native F. tuerckheimii), with 59 bird species recorded during each fruiting phase in Veracruz, Mexico.
- Findings indicate significant differences in bird responses between native and exotic species, with abundance varying among different fruiting phases in exotic species.
- For native species, both abundance and richness were higher during the mature fruiting phase.

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