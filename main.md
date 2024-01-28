NURTITION 

solution

For this table I did two approaches 
1.	taking patients having basic nutrition (by comparing the columns in the query) : if it's greater than =3, they will come under 'yes' or 'no'.

so, as per this logic, 16 those who didn't meet basic nutrition. I compared with different columns, weights, and glucose but didn't get enough data. If needed, we can drop.
Approach 2: I added cookies and pasta (if patients took both, then they will come under high-intake calories). Initial comparison I did with glucose and a few.
where here I got 64 patients both using cookies and pasta regularly. If we see with prepartum weight (17 patients' weight is 80 and above), might be this will be helpful in further analysis."
2(a)   if we compare patients with 0 in basic nutrition and 1 in high intake calories, I'm getting 16    			patients (6) in above weight.
2(b)    if using 'or' (we're getting patients above 80 weight, 30).
This is my initial research on nutrition. I need your suggestions. Will it be helpful in our analysis? Do we need to think in a different way (by adding and removing certain columns)



HYPERTENSION

`right_systolic_blood_pressure` 
`left_systolic_blood_pressure`	                                                   

###"mean_diastolic_bp""Mean_systolic_bp"

`left_diastolic_blood_pressure`     
`right_diastolic_blood_pressure	`


##DROP  

We can drop the records in the 'hypertension_past_treatment' column where the value is 'yes,' and details or clarity are not available for these 3 patients. These patients are already included in another column, 'hypertension_past_reported,' where their entries exist



##LABOR_ADMISSION_DAY / NEW_BORN   
 
Set the delivery mode based on numeric values ranging from 0 to 12 in the c-section column. To simplify interpretation, we can categorize them into 0, 1, or 2. This approach helps avoid further confusion. Additionally, in cases where the cesarean section column contains numeric values, comparing them with the delivery value provides a clear idea of where they should be placed.
The Delivery_mode column is coded as follows:(which has value from 0 to 12 to to avoid the confusion )
SOLUTION:
•	`0`: Vaginal
•	`1`: Caesarian
•	`2`: Others (includes any reason, missed follow-up, not included in the study)
For example, in the case of case_id 146, there is data for newborn weight, but related columns, including Delivery_mode, have no values. It is noted that the individual did follow-up later, and they might not be included in the study for various reasons.
Ceaserian_section column = changing all not applicable to vaginal based on above analysis

mothers_hospital_stay (The approach taken to replace null values in this column is as follows)


##The mothers_hospital_stay column has been updated for null values, specifically 'same_day_discharge' and 'missed_follow_up.' This update is based on consideration of values such as newborn weight, Apgar scores at 1 hour, and Apgar scores at 5 hours.

•	Type conversion need to done for all columns in this table 


##PREVIOUS_PREGANCY 
We can consider deleting all columns related to past_newborn_weight_1 through past_newborn_weight_4 because
Findings:
In the "Past Pregnancy" column, there are 9 null values. However, the related "Weight" column has values, and currently, we can consider them valid. To address this, we can replace the null values in the "Past Pregnancies Number" column by adding to a respective column indicating the availability of data.
Next Steps:

If we move to the next case, focusing on those who had exactly 1 past pregnancy, we observe that there are 99 columns. Unfortunately, we have data for only a few columns, less than 10. In this scenario, we can make the assumption that:
Yes, they have had one past pregnancy, but they didn't deliver here.
Or, we don't have enough data for the records.
Considering the lack of data, there is a suggestion to drop the "Weight" columns and use the "Past Pregnancy" column to understand the patient's previous history by either replacing null values or keeping them as they are.

Gestational Age for Past Newborns:

The column "Gestational Age Past Newborn" classifies gestational age into two categories:
0: Preterm
1: Full term
Considerations for Preterm Babies:

It's noteworthy that the weight of all preterm babies is not constant, and when we consider the current newborn weight, it is observed to be different. Specifically, the current newborn weight is not low; it varies.
Decision to Drop the Column:

In light of the differences observed in the weights of preterm babies and the consideration of current newborn weight, it is suggested that we can drop the "Gestational Age Past Newborn" column.

##DISEASE

In the cleaning steps, we need to update the values in the columns chronic_diseases, disease_diagnose_during_pregnancy, and treatment_disease_pregnancy as follows:
1.	Change 'null' to '0'.
2.	Change 'not_applicable' to '0'.
3.	Change 'no_answer' to '0'.
Additionally, during the cleaning process, we observed anomalies in row 4 (case_id 120) where numeric values exist in the respective columns. Furthermore, case_id 120 has 'thb' in a column, and we are uncertain about its definition. However, we cannot modify this value as the patient is taking the medicine 'ac_valproico,' which is not advisable during pregnancy.
Moreover, row 244 has a different value that seems to have no meaningful definition.

Gestational_column 

For case_id 47 gestational_age_birth less than age_inclusion (have to change in cleaning ?)

For weight columns all


WEIGHT_COLUMN

We can update the current_maternal_weight_1st_tri, current_maternal_weight_2nd_tri, and current_maternal_weight_3rd_tri columns based on certain conditions related to gestational_age_at_inclusion and maternal_weight_at_inclusion. The updated values are determined as follows:
•	For current_maternal_weight_1st_tri:
•	If gestational_age_at_inclusion is between 0 and 13, and maternal_weight_at_inclusion is greater than the current value or the current value is NULL, set it to maternal_weight_at_inclusion.
•	For current_maternal_weight_2nd_tri:
•	If gestational_age_at_inclusion is between 13 and 27, and maternal_weight_at_inclusion is greater than the current value or the current value is NULL, set it to maternal_weight_at_inclusion.
•	For current_maternal_weight_3rd_tri:
•	If gestational_age_at_inclusion is between 27 and 40, and maternal_weight_at_inclusion is greater than the current value or the current value is NULL, set it to maternal_weight_at_inclusion.

DRop
We can then consider dropping the maternal_weight_at_inclusion column as its values have been incorporated into the updated columns."


##Comparsion columns 
alcohol_use,alcohol_preference,alcohol_quantity_milliliters
When alcohol_use is equal to 1, and the other two columns have null or are not applicable, change them to 'no answer’
When alcohol_use is equal to 0, and the other two columns have null or are not applicable, change them to 'not used.


##Comparsion columns 
tobacco_use_in_months,tobacco_use,tobacco_quantity_by_day
If tobacco_use is zero, and tobacco_use_in_months is null or not_applicable, then null or not_applicable values in tobacco_quantity_by_day are changed to 'not_used.' If tobacco_use is equal to 1 and tobacco_use_in_months has a value, then tobacco_quantity_by is changed to 'no_answer.


##Drugs_prefrence 
'Not applicable' value changed to '0' when drugs_prefernce is Zero and drugs_years_use is 'Not applicable'
Null value changed to 'No_anwer' drugs_prefernce !=0 and drugs_years_use is 'Not applicable' 
https://nationaltasc.org/types-of-alcohol/
future ref

`changing weight column not applicable to null and changing data type to numeric`
`fetal_weight_columns related column replace query to change comma to empty string and alter datatype`


