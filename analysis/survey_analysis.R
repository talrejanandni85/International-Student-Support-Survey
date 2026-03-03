# ─────────────────────────────────────────────────────────────────────────────
# DACSS 602 — International Student Survey Experiment
# Survey Framing Effects Analysis
# Authors: Aodan, Nandni, Sagnik  |  UMass Amherst  |  Fall 2023
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(scales)

# ── 1. Load Data ──────────────────────────────────────────────────────────────
df <- read_csv("data/survey_results.csv")

# Recode condition for readable labels
df <- df %>%
  mutate(
    condition = factor(condition,
                       levels = c("control", "economic", "moral"),
                       labels = c("Control", "Economic", "Moral")),
    
    # Collapse policy_support into binary: Favorable vs Not
    favorable = case_when(
      policy_support %in% c("Somewhat in favor", "Strongly in favor") ~ 1,
      TRUE ~ 0
    ),
    
    # Ordered factor for policy support
    policy_support = factor(policy_support,
      levels = c("Strongly in opposition", "Somewhat in opposition",
                 "Neutral", "Somewhat in favor", "Strongly in favor"))
  )

# ── 2. Summary: Favorable Support by Condition ────────────────────────────────
support_summary <- df %>%
  group_by(condition) %>%
  summarise(
    n = n(),
    favorable_pct = mean(favorable) * 100,
    .groups = "drop"
  )

print(support_summary)

# ── 3. Response Distribution by Condition ─────────────────────────────────────
response_dist <- df %>%
  count(condition, policy_support) %>%
  group_by(condition) %>%
  mutate(pct = n / sum(n) * 100) %>%
  ungroup()

# ── 4. Plot: Favorable Support by Condition ───────────────────────────────────
p1 <- ggplot(support_summary, aes(x = condition, y = favorable_pct, fill = condition)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(round(favorable_pct, 1), "%")),
            vjust = -0.5, size = 4.5, fontface = "bold") +
  scale_fill_manual(values = c("Control" = "#E05A5A", "Economic" = "#4CAF7D", "Moral" = "#4C7ABF")) +
  scale_y_continuous(limits = c(0, 55), labels = label_percent(scale = 1)) +
  labs(
    title = "Favorable Policy Support by Framing Condition",
    subtitle = "% of respondents who are 'Somewhat' or 'Strongly' in favor of the 15% quota policy",
    x = "Experimental Condition",
    y = "% Favorable",
    caption = "DACSS 602 | UMass Amherst | Fall 2023"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(color = "grey40"))

print(p1)
ggsave("analysis/fig1_favorable_by_condition.png", p1, width = 7, height = 5, dpi = 150)

# ── 5. Plot: Full Response Distribution ───────────────────────────────────────
p2 <- ggplot(response_dist, aes(x = policy_support, y = pct, fill = condition)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_manual(values = c("Control" = "#E05A5A", "Economic" = "#4CAF7D", "Moral" = "#4C7ABF"),
                    name = "Condition") +
  scale_y_continuous(labels = label_percent(scale = 1)) +
  labs(
    title = "Distribution of Policy Support by Framing Condition",
    x = NULL, y = "% of Respondents",
    caption = "DACSS 602 | UMass Amherst | Fall 2023"
  ) +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 20, hjust = 1),
        plot.title = element_text(face = "bold"),
        legend.position = "top")

print(p2)
ggsave("analysis/fig2_response_distribution.png", p2, width = 9, height = 5.5, dpi = 150)

# ── 6. Chi-Square Test: Is condition associated with policy support? ──────────
chi_test <- chisq.test(table(df$condition, df$policy_support))
print(chi_test)

# ── 7. Pairwise comparisons: Moral vs Economic favorable rates ────────────────
moral_vs_econ <- df %>%
  filter(condition %in% c("Moral", "Economic")) %>%
  mutate(condition = droplevels(condition))

prop_test <- prop.test(
  x = c(sum(moral_vs_econ$favorable[moral_vs_econ$condition == "Moral"]),
         sum(moral_vs_econ$favorable[moral_vs_econ$condition == "Economic"])),
  n = c(sum(moral_vs_econ$condition == "Moral"),
         sum(moral_vs_econ$condition == "Economic"))
)
print(prop_test)

# ── 8. Apathy Reduction: Gap between Neutral and Somewhat in Favor ────────────
apathy_df <- response_dist %>%
  filter(policy_support %in% c("Neutral", "Somewhat in favor")) %>%
  select(condition, policy_support, pct) %>%
  pivot_wider(names_from = policy_support, values_from = pct) %>%
  mutate(gap = Neutral - `Somewhat in favor`)

print(apathy_df)

# ── 9. Convincingness by Condition ───────────────────────────────────────────
conv_summary <- df %>%
  mutate(convincing = case_when(
    article_convincing %in% c("Somewhat convincing", "Strongly convincing") ~ 1,
    TRUE ~ 0
  )) %>%
  group_by(condition) %>%
  summarise(pct_convincing = mean(convincing) * 100, n = n(), .groups = "drop")

print(conv_summary)

# ── 10. Demographic breakdown of support ─────────────────────────────────────
demo_support <- df %>%
  group_by(condition, party_affiliation) %>%
  summarise(favorable_pct = mean(favorable) * 100, n = n(), .groups = "drop") %>%
  filter(n >= 5)

p3 <- ggplot(demo_support, aes(x = party_affiliation, y = favorable_pct, fill = condition)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_manual(values = c("Control" = "#E05A5A", "Economic" = "#4CAF7D", "Moral" = "#4C7ABF"),
                    name = "Condition") +
  scale_y_continuous(labels = label_percent(scale = 1), limits = c(0, 80)) +
  labs(
    title = "Favorable Support by Party Affiliation and Condition",
    x = "Party Affiliation", y = "% Favorable",
    caption = "DACSS 602 | UMass Amherst | Fall 2023"
  ) +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 15, hjust = 1),
        plot.title = element_text(face = "bold"),
        legend.position = "top")

print(p3)
ggsave("analysis/fig3_support_by_party.png", p3, width = 9, height = 5.5, dpi = 150)

cat("\nAnalysis complete. Figures saved to analysis/\n")
