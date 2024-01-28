## Project Readme

### NUTRITION

#### Solution

For this table, I employed two approaches:

##### Basic Nutrition Assessment:

I categorized patients based on their basic nutrition levels by comparing columns in the query. If the value is greater than or equal to 3, they are labeled as **'yes'** or **'no'**.

According to this logic, 16 patients did not meet basic nutrition criteria. Various columns such as weights and glucose were explored, but insufficient data was encountered. If necessary, we can consider dropping these columns.

##### High-Intake Calories Assessment:

I introduced cookies and pasta, considering patients consuming both as having high-calorie intake. Initial comparison involved glucose and other factors.

- Identified 64 patients regularly consuming both cookies and pasta.
- Examining prepartum weight (17 patients with a weight of 80 and above) might aid further analysis.

Further breakdown:
- 2(a) Patients with 0 in basic nutrition and 1 in high intake calories: 16 patients (6) are above weight.
- 2(b) Using 'or': Patients above 80 weight: 30.

This concludes the preliminary research on nutrition. Suggestions are welcomed for its potential utility in the analysis or consideration of a different approach (by adding or removing certain columns).

### HYPERTENSION

Columns:
- `right_systolic_blood_pressure`
- `left_systolic_blood_pressure`
- `mean_diastolic_bp`
- `mean_systolic_bp`
- `left_diastolic_blood_pressure`
- `right_diastolic_blood_pressure`

#### DROP

It is proposed to drop records in the 'hypertension_past_treatment' column where the value is **'yes'** without available details or clarity for these 3 patients. They are already included in another column, 'hypertension_past_reported,' where their entries exist.

### LABOR_ADMISSION_DAY / NEW_BORN

Set the delivery mode based on numeric values (0 to 12) in the c-section column. For simplicity, categorize them into 0, 1, or 2. This approach aids interpretation and avoids confusion.

#### SOLUTION:

- `0`: Vaginal
- `1`: Caesarian
- `2`: Others (includes any reason, missed follow-up, not included in the study)

For example, in case_id 146, data for newborn weight exists, but related columns like Delivery_mode have no values. This individual followed up later, and they might not be included in the study for various reasons. Change **'not applicable'** to vaginal in the cesarean_section column based on the above analysis.

**Mothers_hospital_stay:**
- Updated null values in this column based on considerations like newborn weight, Apgar scores at 1 hour, and Apgar scores at 5 hours.
- **Type conversion needed for all columns in this table.**

### PREVIOUS_PREGNANCY

Consider deleting columns related to past_newborn_weight_1 through past_newborn_weight_4 due to the following findings:

- 9 null values in **"Past Pregnancy"** column, but related **"Weight"** column has values. Consider replacing null values in **"Past Pregnancies Number"** column.
- Focus on cases with exactly 1 past pregnancy: 99 columns, but data for less than 10. Suggestion to either drop **"Weight"** columns or handle null values in **"Past Pregnancy"** column.

**Gestational Age for Past Newborns:**
- Column **"Gestational Age Past Newborn"** classified into two categories: 0 (Preterm) and 1 (Full term).
- Suggested to drop the **"Gestational Age Past Newborn"** column due to observed differences in weights of preterm babies and current newborn weights.

### DISEASE

Update values in columns chronic_diseases, disease_diagnose_during_pregnancy, and treatment_disease_pregnancy:

1. Change **'null'** to **'0'**.
2. Change **'not_applicable'** to **'0'**.
3. Change **'no_answer'** to **'0'**.

Address anomalies in rows with numeric values in chronic_diseases. Handle cases like **'thb'** in a column where the patient is taking **'ac_valproico'** during pregnancy.

### GESTATIONAL_COLUMN

For case_id 47, gestational_age_birth less than age_inclusion should be addressed during cleaning.

### WEIGHT_COLUMN

Update current_maternal_weight_1st_tri, current_maternal_weight_2nd_tri, and current_maternal_weight_3rd_tri based on gestational_age_at_inclusion and maternal_weight_at_inclusion conditions.

#### DROP

Consider dropping the maternal_weight_at_inclusion column as its values are now incorporated into updated columns.

### COMPARISON COLUMNS (Alcohol Use)

Update alcohol_use, alcohol_preference, alcohol_quantity_milliliters:

- When **alcohol_use is 1**, and the other two columns have **null** or **not applicable**, change them to **'no answer'**.
- When **alcohol_use is 0**, and the other two columns have **null** or **not applicable**, change them to **'not used'**.

### COMPARISON COLUMNS (Tobacco Use)

Update tobacco_use_in_months, tobacco_use, tobacco_quantity_by_day:

- If **tobacco_use is zero** and **tobacco_use_in_months is null** or **not applicable**, change **null** or **not applicable** values in **tobacco_quantity_by_day** to **'not_used'**.
- If **tobacco_use is 1** and **tobacco_use_in_months has a value**, then change **tobacco_quantity_by** to **'no_answer'**.

### DRUGS_PREFERENCE

- Change **'Not applicable'** to **'0'** when **drugs_preference is zero** and **drugs_years_use is 'Not applicable'**.
- Change **null value** to **'No_answer'** when **drugs_preference != 0** and **drugs_years_use is 'Not applicable'**.

Note: [Types of Alcohol](https://nationaltasc.org/types-of-alcohol/) for future reference.

**Additional Changes:
