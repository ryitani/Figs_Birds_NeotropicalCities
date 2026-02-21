# Bird species richness GLMM analysis in native Ficus (Ficus tuerckheimii)
# Analysis date: December 26, 2025
# Author: Romina M. Yitani-Medina

# Load dataset
data <- read.csv(
  "Base_Abu_Tuerckheimii2025.csv",
  header = TRUE
)

# Rename variables to English for clarity

# Response variable
data$bird_richness <- data$riqueza

# Predictor variables (landscape, phenology, ecological covariates)
data$green_cover_50m <- data$VE50_RIQ
data$gray_cover_50m  <- data$GR50_RIQ
data$blue_cover_100m <- data$AZ100_RIQ
data$fruiting_phase  <- data$fase
data$foliage_density <- data$densidad_follaje
data$migratory_season <- data$temporada_migratoria
data$fruit_availability <- data$disponibilidad_frutos

# Random effect variable
data$tree_id <- data$arbol


# Load required packages
library(lme4)
library(glmmTMB)
library(emmeans)
library(performance)
library(DHARMa)
library(MuMIn)
library(ggplot2)


# Standardize continuous predictors to improve model stability
data$green_cover_50m_z <- scale(data$green_cover_50m, center = TRUE, scale = TRUE)
data$gray_cover_50m_z  <- scale(data$gray_cover_50m,  center = TRUE, scale = TRUE)
data$blue_cover_100m_z <- scale(data$blue_cover_100m, center = TRUE, scale = TRUE)


# Fit initial Poisson GLMM (including all landscape covariates)
# Note: if collinearity is high, consider removing one or more landscape predictors.
model_richness_pois_full <- glmer(
  bird_richness ~
    green_cover_50m_z +
    gray_cover_50m_z +
    blue_cover_100m_z +
    fruiting_phase +
    foliage_density +
    migratory_season +
    fruit_availability +
    (1 | tree_id),
  family = poisson(link = "log"),
  data = data
)

# Refit Poisson GLMM using a robust optimizer if convergence warnings occur
model_richness_pois <- glmer(
  bird_richness ~
    green_cover_50m_z +
    fruiting_phase +
    foliage_density +
    migratory_season +
    fruit_availability +
    (1 | tree_id),
  family = poisson(link = "log"),
  data = data,
  control = glmerControl(
    optimizer = "bobyqa",
    optCtrl = list(maxfun = 2e5)
  )
)


# Check multicollinearity among predictors
check_collinearity(model_richness_pois)


# Residual diagnostics using DHARMa (Poisson model)
residuals_sim_pois <- simulateResiduals(model_richness_pois)
plot(residuals_sim_pois)

# Dispersion test (Poisson model)
testDispersion(model_richness_pois)


# Fit negative binomial GLMM (preferred if overdispersion is present)
model_richness_nb <- glmmTMB(
  bird_richness ~
    green_cover_50m_z +
    fruiting_phase +
    foliage_density +
    migratory_season +
    fruit_availability +
    (1 | tree_id),
  family = nbinom2(link = "log"),
  data = data
)

# Residual diagnostics using DHARMa (NB model)
residuals_sim_nb <- simulateResiduals(model_richness_nb)
plot(residuals_sim_nb)
testDispersion(residuals_sim_nb)


# Fit null model (negative binomial) for comparison
null_model_nb <- glmmTMB(
  bird_richness ~ 1 + (1 | tree_id),
  family = nbinom2(link = "log"),
  data = data
)

# Likelihood ratio test between null and full NB model
anova(null_model_nb, model_richness_nb, test = "Chi")


# Display model summary
summary(model_richness_nb)


# Calculate marginal and conditional R²
r.squaredGLMM(model_richness_nb)


# Post-hoc comparisons among fruiting phases (response scale)
posthoc_phase <- emmeans(
  model_richness_nb,
  pairwise ~ fruiting_phase,
  type = "response"
)

posthoc_phase


# Extract estimated marginal means for plotting
phase_means <- as.data.frame(
  emmeans(
    model_richness_nb,
    ~ fruiting_phase,
    type = "response"
  )
)

# Relabel factor levels for plotting
phase_means$fruiting_phase <- factor(
  phase_means$fruiting_phase,
  levels = c("Fase Inmadura", "Fase Madura", "Pocos siconos"),
  labels = c("Immature", "Mature", "Few figs")
)


# Basic plot with 95% confidence intervals
ggplot(phase_means, aes(x = fruiting_phase, y = response)) +
  geom_col(fill = "gray70") +
  geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.2) +
  ylab("Bird species richness") +
  xlab("Fruiting phases") +
  theme_classic(base_size = 14)


# Publication-quality plot with significance letters
# If post-hoc tests indicate no significant differences, all phases share the same letter.
phase_means$significance <- c("a", "a", "a")

# Colorblind-friendly palette (Okabe-Ito)
phase_colors <- c(
  "Immature" = "#0072B2",
  "Mature"   = "#009E73",
  "Few figs" = "#E69F00"
)

ggplot(phase_means, aes(x = fruiting_phase, y = response, fill = fruiting_phase)) +
  geom_col(color = "black", width = 0.7) +
  geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.2) +
  geom_text(aes(label = significance, y = asymp.UCL + 0.5), size = 5) +
  scale_fill_manual(values = phase_colors) +
  ylab("Bird species richness") +
  xlab("Fruiting phases") +
  theme_classic(base_size = 14) +
  theme(legend.position = "none")

