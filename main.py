
# Nutrition Analysis

## Approach 1: Basic Nutrition

Taking patients having basic nutrition
WITH cte AS (
    SELECT
        case_id,
        breakfast_meal,
        lunch_meal,
        meal_dinner,
        vegetables,
        bean,
        fruits,
        prepartum_maternal_weight,
        CASE
            WHEN breakfast_meal + lunch_meal + meal_dinner + vegetables + bean + fruits >= 3 THEN 1
            ELSE 0
        END AS basic_nutrition
    FROM public.maternal_patient_data
)
SELECT
    case_id,
    prepartum_maternal_weight
FROM cte
WHERE basic_nutrition = 0
ORDER BY case_id;
As per this logic, 72 patients didn't meet basic nutrition. Further comparison with different columns, weights, and glucose might be needed. If needed, we can drop.

Approach 2: High-Calorie Intake
 Added cookies and pasta for high-intake calories
WITH cte AS (
    SELECT
        case_id,
        pasta,
        cookies,
        newborn_weight,
        prepartum_maternal_weight,
        preeclampsia_record_pregnancy,
        CASE
            WHEN pasta + cookies >= 2 THEN 1
            ELSE 0
        END AS regular_high_calorie_intake
    FROM public.maternal_patient_data
)
SELECT prepartum_maternal_weight
FROM cte
WHERE regular_high_calorie_intake = 1;
Here, 64 patients both used cookies and pasta regularly. Considering prepartum weight (17 patients' weight is 80 and above) might be helpful in further analysis.

Sub-Approaches:
2(a): Patients with 0 in basic nutrition and 1 in high intake calories, 16 patients (6) are above weight.
2(b): Using 'or', patients above 80 weight, 30.
This is the initial research on nutrition. Suggestions are needed. Will it be helpful in our analysis? Do we need to think differently? If we go by this approach, we will have basic_nutrition_column and high_calorie_column for nutrition, and we can drop the remaining.

Hypertension
Columns:

right_systolic_blood_pressure
left_systolic_blood_pressure
Mean_systolic_bp
left_diastolic_blood_pressure
right_diastolic_blood_pressure
mean_diastolic_bp
Drop Records
Drop records in 'hypertension_past_treatment' column where the value is 'yes' and details or clarity are not available for these 3 patients. These patients are already included in another column, 'hypertension_past_reported,' where their entries exist.

Labor Admission Day / Newborn
Set the delivery mode based on numeric values ranging from 0 to 12 in the c-section column. To simplify interpretation, categorize them into 0, 1, or 2. This approach helps avoid further confusion. The Delivery_mode column is coded as follows:

0: Vaginal
1: Caesarian
2: Others (includes any reason, missed follow-up, not included in the study)
For example, in the case of case_id 146, there is data for newborn weight, but related columns, including Delivery_mode, have no values. It is noted that the individual did follow-up later, and they might not be included in the study for various reasons.

Mothers Hospital Stay
The mothers_hospital_stay column has been updated for null values, specifically 'same_day_discharge' and 'missed_follow_up.' This update is based on consideration of values such as newborn weight, Apgar scores at 1 hour, and Apgar scores at 5 hours.

Type conversion needs to be done for all columns in this table.
Previous Pregnancy
Consider deleting all columns related to past_newborn_weight_1 through past_newborn_weight_4.

Findings:

In the "Past Pregnancy" column, there are 9 null values. However, the related "Weight" column has values. To address this, replace the null values in the "Past Pregnancies Number" column by adding to a respective column indicating the availability of data.
Next Steps:

For those who had exactly 1 past pregnancy, there are 99 columns. Unfortunately, we have data for only a few columns, less than 10. Considering the lack of data, there is a suggestion to drop the "Weight" columns and use the "Past Pregnancy" column to understand the patient's previous history by either replacing null values or keeping them as they are.
Gestational Age for Past Newborns:
The column "Gestational Age Past Newborn" classifies gestational age into two categories:

0: Preterm
1: Full term
Considerations for Preterm Babies:

It's noteworthy that the weight of all preterm babies is not constant. Considering the current newborn weight, it is observed to be different. Specifically, the current newborn weight is not low; it varies.
Decision to Drop the Column:

In light of the differences observed in the weights of preterm babies and the consideration of current newborn weight, it is suggested that we can drop the "Gestational Age Past Newborn" column.
Disease
In the cleaning steps, update the values in the columns chronic_diseases, disease_diagnose_during_pregnancy, and treatment_disease_pregnancy as follows:

Change 'null' to '0'.
Change 'not_applicable' to '0'.
Change 'no_answer' to '0'.
Additionally, during the cleaning process, anomalies were observed in row 4 (case_id 120) where numeric values