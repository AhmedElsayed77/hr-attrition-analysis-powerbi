"""
Task (8): 
Classify employees into experience levels based on
TotalWorkingYears, then display a summary table of ExperienceLevel
and EmployeeCount.

Classification rule:
    Junior  -> TotalWorkingYears < 5
    Mid     -> 5 <= TotalWorkingYears <= 9
    Senior  -> TotalWorkingYears >= 10
"""

import pandas as pd

# ── Step 1: Load the dataset ────────────────────────────────────────────
df = pd.read_excel('HR_Employee_Attrition_Dataset.xlsx')   # change path if needed


# ── Step 2: Classification function ─────────────────────────────────────
def classify_experience(years):
    """Map TotalWorkingYears to an experience level bucket."""
    if years < 5:
        return 'Junior'
    elif years <= 9:
        return 'Mid'
    else:
        return 'Senior'


# ── Step 3: Apply classification to every employee ─────────────────────
df['ExperienceLevel'] = df['TotalWorkingYears'].apply(classify_experience)


# ── Step 4: Build the summary table (ExperienceLevel, EmployeeCount) ───
summary = (
    df.groupby('ExperienceLevel')
      .size()
      .reset_index(name='EmployeeCount')
)

# Keep a logical order (Junior -> Mid -> Senior) instead of alphabetical
order = ['Junior', 'Mid', 'Senior']
summary['ExperienceLevel'] = pd.Categorical(
    summary['ExperienceLevel'], categories=order, ordered=True
)
summary = summary.sort_values('ExperienceLevel').reset_index(drop=True)


# ── Step 5: Display the result ──────────────────────────────────────────
print(summary.to_string(index=False))
