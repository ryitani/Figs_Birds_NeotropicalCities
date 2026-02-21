# Bird abundance GLMM analysis in urban Ficus trees
# Analysis date: December 19, 2025
# Author: Romina M. Yitani-Medina

# Load dataset
data <- read.csv(
  "Base_Abu_Elastica2025.csv",
  header = TRUE
)

# Rename variables to English for clarity

# Response variable
data$bird_abundance <- data$abundancia

# Predictor variables
data$green_cover_50m <- data$VE50_ABU
data$fruiting_phase <- data$fase
data$foliage_density <- data$densidad_follaje
data$migratory_season <- data$temporada_migratoria
data$fruit_availability <- data$disponibilidad_frutos

# Random effect variable
data$tree_id <- data$arbol


# Load required packages
library(lme4)
library(emmeans)
library(performance)
library(DHARMa)
library(MuMIn)
library(ggplot2)


# Standardize continuous predictors to improve model stability
data$green_cover_50m_z <- scale(
  data$green_cover_50m,
  center = TRUE,
  scale = TRUE
)


# Fit Poisson GLMM
# Response: bird_abundance (count data)
# Fixed effects: landscape, phenology, and ecological predictors
# Random effect: tree identity

model_abundance <- glmer(
  bird_abundance ~
    green_cover_50m_z +
    fruiting_phase +
    foliage_density +
    migratory_season +
    fruit_availability +
    (1 | tree_id),
  
  family = poisson(link = "log"),
  data = data
)


# Check multicollinearity among predictors
check_collinearity(model_abundance)


# Evaluate model residuals using DHARMa
residuals_sim <- simulateResiduals(model_abundance)
plot(residuals_sim)

# Test for overdispersion
testDispersion(model_abundance)


# Fit null model for comparison
null_model <- glmer(
  bird_abundance ~ 1 + (1 | tree_id),
  family = poisson(link = "log"),
  data = data
)

# Likelihood ratio test between null and full model
anova(null_model, model_abundance, test = "Chi")


# Display model summary
summary(model_abundance)


# Calculate marginal and conditional R²
r.squaredGLMM(model_abundance)


# Post-hoc comparisons among fruiting phases
posthoc_phase <- emmeans(
  model_abundance,
  pairwise ~ fruiting_phase,
  type = "response"
)

posthoc_phase


# Extract estimated marginal means
phase_means <- as.data.frame(
  emmeans(
    model_abundance,
    ~ fruiting_phase,
    type = "response"
  )
)


# Relabel factor levels for plotting
phase_means$fruiting_phase <- factor(
  phase_means$fruiting_phase,
  levels = c(
    "Fase Inmadura",
    "Fase Madura",
    "Pocos siconos"
  ),
  labels = c(
    "Immature",
    "Mature",
    "Few figs"
  )
)


# Basic plot with confidence intervals
ggplot(
  phase_means,
  aes(
    x = fruiting_phase,
    y = response
  )
) +
  
  geom_col(fill = "gray70") +
  
  geom_errorbar(
    aes(
      ymin = asymp.LCL,
      ymax = asymp.UCL
    ),
    width = 0.2
  ) +
  
  ylab("Bird abundance") +
  xlab("Fruiting phase") +
  
  theme_classic(base_size = 14)


# Add significance letters for publication plot
phase_means$significance <- c("b", "a", "ab")


# Colorblind-friendly palette
phase_colors <- c(
  "Immature" = "#0072B2",
  "Mature"   = "#009E73",
  "Few figs" = "#E69F00"
)


# Publication-quality figure
ggplot(
  phase_means,
  aes(
    x = fruiting_phase,
    y = response,
    fill = fruiting_phase
  )
) +
  
  geom_col(
    color = "black",
    width = 0.7
  ) +
  
  geom_errorbar(
    aes(
      ymin = asymp.LCL,
      ymax = asymp.UCL
    ),
    width = 0.2
  ) +
  
  geom_text(
    aes(
      label = significance,
      y = asymp.UCL + 0.5
    ),
    size = 5
  ) +
  
  scale_fill_manual(
    values = phase_colors
  ) +
  
  ylab("Bird abundance") +
  xlab("Fruiting phase") +
  
  theme_classic(base_size = 14) +
  
  theme(
    legend.position = "none"
  )

