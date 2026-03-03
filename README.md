# Message Framing & Public Support for International Student Policy 📊

**DACSS 602 — Research Methods | UMass Amherst | Fall 2023**  

---

## Overview

This repository documents a **randomized survey experiment** examining how message framing shapes U.S. citizens' support for a university policy reserving 15% of its student body for international students. Participants were randomly assigned to one of three conditions — a **moral framing**, an **economic framing**, or a **neutral control** — before answering policy opinion questions.

The central finding: **our original hypothesis was wrong.** We expected Americans to respond more strongly to economic arguments. Instead, the moral framing produced the highest favorable support.

> *"Any justification is better than no justification — and moral justification is the most effective."*

---

## Research Question

> How do economic and moral justifications for international student policy influence U.S. citizens' support for allowing international students to study and work in the United States?

**Independent Variable:** Framing condition (moral, economic, control)  
**Dependent Variable:** Level of support for the 15% international student quota policy

---

## Study Design

Participants were shown a brief description of UMass Amherst's hypothetical new policy (a fixed 15% quota for international students), then randomly assigned to read one of three stimulus articles before completing the survey.

| Group | Stimulus | Description |
|-------|----------|-------------|
| **Control** | `stimuli/control_article.png` | Neutral university news update — no policy justification |
| **Economic** | `stimuli/economic_article.png` | "Business Today" article framing international students as economic contributors ($44B/year, startup founders, job creators) |
| **Moral** | `stimuli/moral_article.png` | Op-ed framing international students as a moral responsibility, emphasizing cultural exchange and global community |

The survey questions — including the key dependent variable — were **identical across all three groups**. Only the stimulus article differed.

```
┌─────────────────────────────────────┐
│        All Participants             │
│  1. Demographic questions           │
│  2. Short description of policy     │
│  3. Stimulus article (manipulated)  │
│  4. Survey questions (identical)    │
└─────────────────────────────────────┘
```

---

## Key Results

### Favorable Policy Support by Condition

| Condition | N | % Favorable | % Neutral |
|-----------|---|-------------|-----------|
| Control   | ~88 | **34.1%** | 39.8% |
| Economic  | ~86 | **38.4%** | 34.9% |
| Moral     | ~89 | **41.6%** | 31.5% |

The moral framing produced the highest favorable response **and** the smallest neutral-to-favor gap — meaning it was the most effective at converting apathetic respondents into supporters.

### Article Convincingness

| Condition | % Found Convincing |
|-----------|--------------------|
| Economic  | 43% |
| Moral     | 45% |

Notably, convincingness rates were **higher than favorable support rates** in both framing conditions — suggesting some respondents found the articles persuasive yet still opposed the policy, or were persuaded *against* it. This warrants article revision in future iterations.

### Apathy Reduction

The gap between "Neutral" and "Somewhat in favor" (top 2 responses across all conditions):

- **Control:** 39.8% vs. 23.9% — gap of **15.9 points**
- **Economic:** 34.9% vs. 25.6% — gap of **9.3 points**
- **Moral:** 31.5% vs. 29.2% — gap of **2.3 points** ✓ smallest

The moral condition was most successful at activating opinion among otherwise disengaged respondents.

---

## Hypothesis & Findings

**Original hypothesis:** Americans would prefer the economic justification, expecting that anti-immigration sentiment would make moral arguments ineffective, while economic self-interest would override ideological opposition.

**Result:** Hypothesis was **not supported.** The moral framing outperformed the economic framing on both favorable support (41.6% vs. 38.4%) and convincingness (45% vs. 43%). The control group's results confirm that any framing is better than none.

---

## Repository Structure

```
intl-student-survey/
│
├── stimuli/
│   ├── moral_article.png          # Moral framing stimulus
│   ├── economic_article.png       # Economic framing stimulus
│   └── control_article.png        # Neutral control stimulus
│
├── data/
│   └── survey_results.csv         # Sample dataset (263 respondents, anonymized)
│
├── analysis/
│   └── survey_analysis.R          # Full R analysis script
│
├── reports/
│   ├── final_reflection.pdf       # Written analysis, results, and interpretation
│   └── group_presentation.pdf    # Slide deck presented to class
│
└── README.md
```

---

## Data Dictionary

`data/survey_results.csv` — 263 rows × 10 columns

| Column | Description | Values |
|--------|-------------|--------|
| `participant_id` | Anonymized respondent ID | P0001–P0263 |
| `condition` | Experimental group | `control`, `economic`, `moral` |
| `age_group` | Age range | 18-24, 25-34, 35-44, 45-54, 55-64, 65+ |
| `gender` | Gender identity | Male, Female, Non-binary/Other, Prefer not to say |
| `education` | Highest education level | High school or less, Some college, Bachelor's, Graduate |
| `party_affiliation` | Political party | Democrat, Republican, Independent, Other/No affiliation |
| `policy_support` | **Dependent variable** — support for 15% quota | Strongly in opposition → Strongly in favor (5-point scale) |
| `pct_opinion` | Opinion on whether 15% is the right amount | Correct amount, Not high enough, Too high |
| `article_convincing` | How convincing the article was | 5-point scale from Strongly unconvincing → Strongly convincing |
| `article_shaped_opinion` | Whether the article shaped their response | Yes, No, Maybe |

> **Note:** This dataset is a sample file generated to match the actual study distributions reported in `reports/final_reflection.pdf`. It is provided for reproducibility and portfolio demonstration purposes.

---

## Running the Analysis

**Requirements:** R 4.0+ with `tidyverse` and `scales`

```r
install.packages(c("tidyverse", "scales"))
```

Then run from the project root:

```r
source("analysis/survey_analysis.R")
```

The script produces:
- `fig1_favorable_by_condition.png` — bar chart of % favorable by group
- `fig2_response_distribution.png` — full 5-point distribution across groups
- `fig3_support_by_party.png` — favorable support broken down by party × condition
- Chi-square test of association between condition and policy support
- Proportion test comparing moral vs. economic favorable rates

---

## Limitations & Future Directions

- **Sample:** Recruited from a convenience sample (UMass community), limiting generalizability to the broader U.S. population
- **Anchoring effect:** Fixing the policy at 15% likely anchored responses toward "correct amount" — future studies could remove or vary this figure
- **Article revision:** Convincingness scores exceeding favorable rates suggest the stimuli may have inadvertently persuaded some respondents against the policy
- **Extensions to consider:**
  - Apply the same framing design to immigration policy more broadly
  - Test whether origin country of international students interacts with framing effectiveness
  - Examine whether framing effects persist across different policy domains

---

## Skills Demonstrated

`Experimental Survey Design` · `Message Framing / Treatment Construction` · `Randomized Assignment` · `Public Opinion Analysis` · `R (tidyverse, ggplot2)` · `Chi-Square Testing` · `Proportion Tests` · `Data Visualization` · `Academic Writing`

---

## Course Context

**DACSS 602 — Research Methods**  
University of Massachusetts Amherst | Fall 2023
