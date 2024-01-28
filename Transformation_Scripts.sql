create table IF NOT EXISTS patient_details
(
case_id bigint primary key not null,
age_years_old varchar(3), 
color_ethnicity char(3),
prepregnant_weight text,
prepregnant_bmi text,
bmi_according_who text,
current_maternal_weight_1st_tri text,							 
current_maternal_weight_2nd_tri	text	,
current_maternal_weight_3rd_tri	text	,					 
hight_at_inclusion text ,
current_bmi_according_who text,
current_bmi text,
tobacco_use	smallint,						 
tobacco_use_in_months	text,						 
tobacco_quantity_by_day	text,						 
alcohol_use	smallint,					
alcohol_quantity_milliliters text,
alcohol_preference text,
drugs_preference text,
drugs_during_pregnancy text,
drugs_years_use text,
past_pregnancies_number smallint,
miscarriage	smallint,
maternal_weight_at_inclusion text,
prepartum_maternal_weight text,
prepartum_maternal_heigh text,
number_prenatal_appointments numeric
);
	
	
insert into patient_details
select case_id,
age_years_old, 
color_ethnicity ,
prepregnant_weight ,
prepregnant_bmi ,
bmi_according_who ,
current_maternal_weight_1st_tri ,							 
current_maternal_weight_2nd_tri	,
current_maternal_weight_3rd_tri	,					 
hight_at_inclusion  ,
current_bmi_according_who ,
current_bmi ,
tobacco_use	,						 
tobacco_use_in_months	,						 
tobacco_quantity_by_day	,						 
alcohol_use	,					
alcohol_quantity_milliliters ,	
alcohol_preference,
drugs_preference ,
drugs_during_pregnancy ,
drugs_years_use , 
past_pregnancies_number ,
miscarriage,
maternal_weight_at_inclusion,
prepartum_maternal_weight,
prepartum_maternal_heigh,
number_prenatal_appointments
from public.maternal_patient_data;


create table hypertension (
case_id int,
hypertension_past_reported text,
hypertension_past_treatment	text,
right_systolic_blood_pressure text,	
right_diastolic_blood_pressure	text,
left_systolic_blood_pressure text,
left_diastolic_blood_pressure text,
hospital_systolic_blood_pressure text,	
hospital_diastolic_blood_pressure text,
hospital_hypertension int
);

insert into hypertension
select case_id,
hypertension_past_reported ,
hypertension_past_treatment	,
right_systolic_blood_pressure ,	
right_diastolic_blood_pressure	,
left_systolic_blood_pressure ,
left_diastolic_blood_pressure ,
hospital_systolic_blood_pressure ,	
hospital_diastolic_blood_pressure ,
hospital_hypertension 
from public.maternal_patient_data;







select*from patient_details;
----------------------
create table nutrition(
case_id bigint,
breakfast_meal numeric,
morning_snack	numeric,
lunch_meal	numeric,
afternoon_snack	numeric,
meal_dinner	numeric,
supper_meal	numeric,
bean	numeric,
fruits	numeric,
vegetables	numeric,
embedded_food	numeric,
pasta	numeric,
cookies numeric
);
	
insert into nutrition
 select case_id,
breakfast_meal	,	
morning_snack	,
lunch_meal	,
afternoon_snack	,
meal_dinner	,
supper_meal	,
bean	,
fruits	,
vegetables	,
embedded_food	,
pasta,	
cookies	
from public.maternal_patient_data;

select * from nutrition;

----------------------

create table previous_pregancy (
case_id bigint,
past_newborn_1_weight text,
gestational_age_past_newborn_1 text,
past_newborn_2_weight text,
gestational_age_past_newborn_2 text,
past_newborn_3_weight	text,
gestational_age_past_newborn_3	text,
past_newborn_4_weight	text,
gestational_age_past_4_newborn	text
);


insert into previous_pregancy
select case_id,
past_newborn_1_weight,
gestational_age_past_newborn_1,
past_newborn_2_weight,
gestational_age_past_newborn_2,
past_newborn_3_weight	,
gestational_age_past_newborn_3,	
past_newborn_4_weight	,
gestational_age_past_4_newborn
from public.maternal_patient_data;

select * from previous_pregancy;
-------------------------------------------------------
create table new_born(
case_id bigint,
newborn_height text,
newborn_weight text,
newborn_head_circumference	text,
thoracic_perimeter_newborn	text,
meconium_labor	text,
apgar_1st_min	text,
apgar_5th_min	text,
pediatric_resuscitation_maneuvers text,	
newborn_intubation	text,
newborn_airway_aspiration	text,
gestational_age_at_birth	text

);	
	
insert into new_born
select case_id,
newborn_height text,
newborn_weight text,
newborn_head_circumference	text,
thoracic_perimeter_newborn	text,
meconium_labor	text,
apgar_1st_min	text,
apgar_5th_min	text,
pediatric_resuscitation_maneuvers text,	
newborn_intubation	text,
newborn_airway_aspiration	text,
gestational_age_at_birth
from public.maternal_patient_data;
	
	
select * from new_born	;

------------------------------------------------

create table labor_admission_day(
case_id bigint,
delivery_mode int,
preeclampsia_record_pregnancy text,
cesarean_section_reason text,
mothers_hospital_stay int,
expected_weight_for_the_newborn text
);

insert into labor_admission_day
select 
case_id bigit,
delivery_mode,
preeclampsia_record_pregnancy,
cesarean_section_reason,
mothers_hospital_stay,
expected_weight_for_the_newborn
from public.maternal_patient_data ;



select * from labor_admission_day;

----------------------------------------------------

create table laboratory
(
case_id bigint,
first_trimester_hematocrit text,
second_trimester_hematocrit text,
third_trimester_hematocrit text,
firt_trimester_hemoglobin   text,
second_trimester_hemoglobin  text,
third_trimester_hemoglobin	text,
first_tri_fasting_blood_glucose  text ,	
second_tri_fasting_blood_glucose  text,	
third_tri_fasting_blood_glucose text	,
"1st_hour_ogtt75_1st_tri"  text,	
"1st_hour_ogtt75_2tri"	text,
"1st_hour_ogtt75_3tri"	text,
"2nd_hour_ogtt_1tri"	text,
"2nd_hour_ogtt75_2tri"	text,
"2nd_hour_ogtt_3tri"	text,
hiv_1tri	text,
syphilis_1tri  text,	
c_hepatitis_1tri text 
);

insert into laboratory
select 
case_id ,
first_trimester_hematocrit ,
second_trimester_hematocrit ,
third_trimester_hematocrit ,
firt_trimester_hemoglobin,
second_trimester_hemoglobin,
third_trimester_hemoglobin	,
first_tri_fasting_blood_glucose ,	
second_tri_fasting_blood_glucose ,	
third_tri_fasting_blood_glucose	,
"1st_hour_ogtt75_1st_tri" ,	
"1st_hour_ogtt75_2tri"	,
"1st_hour_ogtt75_3tri"	,
"2nd_hour_ogtt_1tri"	,
"2nd_hour_ogtt75_2tri"	,
"2nd_hour_ogtt_3tri"	,
hiv_1tri	,
syphilis_1tri ,	
c_hepatitis_1tri 
from public.maternal_patient_data;


select * from laboratory;

---------------------------------------

insert into ultrasound
select
case_id,
fetal_weight_at_ultrasound,
periumbilical_subcutanous_fat,
weight_fetal_percentile,
periumbilical_visceral_fat,
periumbilical_total_fat,
preperitoneal_subcutaneous_fat,
preperitoneal_visceral_fat,
mean_subscapular_skinfold,	
mean_tricciptal_skinfold	,
mean_supra_iliac_skin_fold	,
maternal_brachial_circumference,	
circumference_maternal_calf	,
maternal_neck_circumference	,
maternal_waist_circumference,	
maternal_hip_circumference	,
ultrasound_gestational_age	,
gestational_age_at_inclusion
from public.maternal_patient_data;

create table ultrasound(
case_id bigint,
fetal_weight_at_ultrasound text,
periumbilical_subcutanous_fat  text,
weight_fetal_percentile text,
periumbilical_visceral_fat  text,
periumbilical_total_fat  smallint,
preperitoneal_subcutaneous_fat smallint,
preperitoneal_visceral_fat  smallint,
mean_subscapular_skinfold	smallint,
mean_tricciptal_skinfold	smallint,
mean_supra_iliac_skin_fold	smallint,
maternal_brachial_circumference  smallint,	
circumference_maternal_calf	 smallint,
maternal_neck_circumference	smallint,
maternal_waist_circumference smallint,	
maternal_hip_circumference	smallint,
ultrasound_gestational_age	smallint,
gestational_age_at_inclusion smallint

);

select * from ultrasound	;
	
	
=====================================	
create table disease
(
case_id	bigint,
treatment_disease_pregnancy	text,
chronic_diseases text,	
disease_diagnose_during_pregnancy text
);
insert into disease
select case_id,	
treatment_disease_pregnancy	,
chronic_diseases,	
disease_diagnose_during_pregnancy
from public.maternal_patient_data;

create table diabetes (
case_id int ,
diabetes_mellitus_dm_reported smallint,
diabetes_mellitus_disease_gap text,
diabetes_mellitus_treatment text,
chronic_diabetes text,
disease_diagnose_during_pregnancy text,
gestational_diabetes_mellitus text
);

	
insert into diabetes 
select 
case_id,
diabetes_mellitus_dm_reported,
diabetes_mellitus_disease_gap,
diabetes_mellitus_treatment,
chronic_diabetes
gestational_diabetes_mellitus,
disease_diagnose_during_pregnancy
from public.maternal_patient_data;
------------------------------------------------------------------------------------


	




