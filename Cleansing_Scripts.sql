select * from patient_details order by case_id;

--------------------Update the 'weight' column in the table, changing 'not_applicable' values to NULLl---------------------
update public.patient_details
set current_maternal_weight_1st_tri = Null
where current_maternal_weight_1st_tri = 'not_applicable' or current_maternal_weight_1st_tri = ' ';


update public.patient_details
set current_maternal_weight_2nd_tri = NULL
where current_maternal_weight_2nd_tri = 'not_applicable';


update public.patient_details
set current_maternal_weight_3rd_tri = null
where current_maternal_weight_3rd_tri = 'not_applicable';


update public.patient_details
set prepregnant_weight =Null
where prepregnant_weight = ' '  or prepregnant_weight = 'no_answer';


update public.patient_details
set prepartum_maternal_weight = null
where prepartum_maternal_weight = 'not_applicable';

update public.patient_details
set prepregnant_bmi = null
where prepregnant_bmi = 'not_applicable';

update public.patient_details
set  bmi_according_who = null
where bmi_according_who = 'not_applicable';



----------------Change the data type of the 'weight' column in the table------------------

alter table public.patient_details
alter column prepregnant_weight type numeric using (prepregnant_weight)::numeric,
alter column maternal_weight_at_inclusion type numeric using (maternal_weight_at_inclusion)::numeric,
alter column current_maternal_weight_1st_tri type numeric using (current_maternal_weight_1st_tri )  :: numeric,
alter column hight_at_inclusion type numeric using (hight_at_inclusion )  :: numeric,
alter column prepartum_maternal_weight type numeric using (prepartum_maternal_weight ) :: numeric,
alter column current_maternal_weight_3rd_tri type numeric using (current_maternal_weight_3rd_tri ) :: numeric,
alter column prepregnant_weight  type numeric using (prepregnant_weight ) :: numeric,
alter column bmi_according_who type numeric using (bmi_according_who ) :: numeric,
alter column current_maternal_weight_2nd_tri type numeric using (current_maternal_weight_2nd_tri ) :: numeric;



--&&&& UPDATE statement for the 'alcohol_columns' ---------------
update public.patient_details
set alcohol_quantity_milliliters =
case when alcohol_use = 0 and (alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_applicable')and 
(alcohol_preference is null or alcohol_preference = 'not_applicable')
then '0'
else alcohol_quantity_milliliters
end;


update public.patient_details
set  alcohol_preference =
case when alcohol_use = 0 and (alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='0')and (alcohol_preference is null or alcohol_preference = 'not_applicable')
then '0'
else alcohol_preference
end;

update public.patient_details
set alcohol_preference = 
case when alcohol_use = 1 and alcohol_quantity_milliliters is null or alcohol_quantity_milliliters= 'no_answer'
							   and alcohol_preference is null  then 'no_answer'
else alcohol_preference
end ;

update public.patient_details
set alcohol_quantity_milliliters = 
case when alcohol_use = 1 and ((alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_used')
							   or (alcohol_preference is null or alcohol_preference = 'not_used'))
							   then 'no_answer'

else alcohol_quantity_milliliters							   
end;

-----&&&& UPDATE STATEMENTS FOR TOBACCO COLUMNS 



update public.patient_details
set tobacco_use_in_months =
case when tobacco_use = 0 and ((tobacco_use_in_months= 'not_applicable'or tobacco_use_in_months is null)
							   and (tobacco_quantity_by_day='not_applicable' or tobacco_quantity_by_day is null ))
							   then '0'
							   else tobacco_use_in_months
							   end;
update public.patient_details
set tobacco_quantity_by_day =
case when tobacco_use = 0 and ((tobacco_use_in_months= 'not_used'or tobacco_use_in_months is null)
							   and (tobacco_quantity_by_day='not_applicable' or tobacco_quantity_by_day is null ))
							   then '0'
							   else tobacco_quantity_by_day
							   end;
update public.patient_details
set tobacco_quantity_by_day =
case when tobacco_use = 1 and ( tobacco_use_in_months is null or tobacco_quantity_by_day is null )
							   then 'no_answer'
							   else tobacco_quantity_by_day
							   end,
tobacco_use_in_months =						   
case when tobacco_use = 1 and ( tobacco_use_in_months is null or tobacco_quantity_by_day is null )
							   then 'no_answer'
							   else tobacco_use_in_months
							   end;
-----UPDATE statement for the DRugs column.
						
update patient_details
SET drugs_during_pregnancy = 
case  when drugs_preference = '0' and (drugs_years_use is NULL or drugs_years_use ='not_applicable') then '0' 
else drugs_during_pregnancy end ;

update patient_details
set
drugs_years_use = case when drugs_preference = '0' and (drugs_during_pregnancy = '0' or drugs_during_pregnancy is NULL) then '0' 
else drugs_years_use end;

update patient_details
set drugs_preference = 0,drugs_during_pregnancy = 0,drugs_years_use = 0
where drugs_preference = 'not_applicable'or drugs_during_pregnancy = 'not_applicable'or drugs_years_use = 'not_applicable';
                     

----Converting not_applicabl to 0 in hypertension-------------

update  public.hypertension
set 
left_systolic_blood_pressure = case when left_systolic_blood_pressure = 'not_applicable' then '0'
else left_systolic_blood_pressure
end ,
right_systolic_blood_pressure = case when right_systolic_blood_pressure = 'not_applicable'  then '0'
else right_systolic_blood_pressure end ,

left_diastolic_blood_pressure = case when left_diastolic_blood_pressure = 'not_applicable'  then '0'
else left_diastolic_blood_pressure end ,

right_diastolic_blood_pressure =case when right_diastolic_blood_pressure = 'not_applicable'  then '0'
else right_diastolic_blood_pressure end ;

--select * from hypertension
---------------------------------ADDING mean sys/dys column ------------
alter table public.hypertension
add column mean_systolic_bp integer,
add column mean_diastolic_bp integer;
------------------Changing data_type  for BP_column-----------------
ALTER TABLE public.hypertension
alter column right_systolic_blood_pressure type numeric using (right_systolic_blood_pressure):: numeric,
alter column   right_diastolic_blood_pressure  type  numeric using (right_diastolic_blood_pressure):: numeric,
alter column  left_systolic_blood_pressure   type  numeric using (left_systolic_blood_pressure):: numeric,
alter column  left_diastolic_blood_pressure   type  numeric using (left_diastolic_blood_pressure):: numeric;


update public.hypertension
set
mean_systolic_bp = ROUND((left_systolic_blood_pressure + right_systolic_blood_pressure) / 2, 0),
mean_diastolic_bp = ROUND((left_diastolic_blood_pressure + right_diastolic_blood_pressure) / 2, 0);



----------------------------------------DELIVERY_MODE------------------------
select * from public.labor_admission_day;


update public.labor_admission_day
set delivery_mode =
case when cesarean_section_reason = 'not_applicable'  or  delivery_mode in (1,2,7,8,9) then 0 
when cesarean_section_reason is not null or delivery_mode in (5,6,12)  then 1
when cesarean_section_reason is null and delivery_mode is null  then 2
end ;

update public.labor_admission_day
set cesarean_section_reason = case when delivery_mode = 0 and (cesarean_section_reason = 'not_applicable' or cesarean_section_reason ='no_answer' or cesarean_section_reason='8')
then 'vaginal_delivery' else cesarean_section_reason end;
----------------------------converting the expected_weight_for_the_newborn column to NULL and replacing commas.-------------------------------------
UPDATE public.labor_admission_day
set expected_weight_for_the_newborn = NULL
where expected_weight_for_the_newborn  = 'not_applicable';

UPDATE public.labor_admission_day
set expected_weight_for_the_newborn  = replace(expected_weight_for_the_newborn , ',', '');

alter table public.labor_admission_day
alter column expected_weight_for_the_newborn  type numeric using (expected_weight_for_the_newborn ::numeric) ;



----------------------------------------------------------------NUTRITION COLUMN ------------------------
alter table	public.nutrition
add column basic_nutrition  numeric;

update public.nutrition
set basic_nutrition = case when 
breakfast_meal  + lunch_meal + greatest(meal_dinner, supper_meal) + vegetables + bean + fruits >=3 THEN 1 else 0 end ;


alter table public.nutrition
add column regular_high_calorie_intake NUMERIC;

update public.nutrition
set regular_high_calorie_intake = case when pasta+cookies >=2 then 1
else 0 end;
----------------------------hypertension column not_applicable to null and change data_type------------------

select * from hypertension;
UPDATE hypertension
SET hospital_systolic_blood_pressure = NULL
WHERE hospital_systolic_blood_pressure = 'not_applicable';

UPDATE hypertension
SET hospital_diastolic_blood_pressure = NULL
WHERE hospital_diastolic_blood_pressure = 'not_applicable';

alter table hypertension
alter column hospital_diastolic_blood_pressure type numeric using (hospital_diastolic_blood_pressure ) :: numeric,
alter column hospital_systolic_blood_pressure  type numeric using (hospital_systolic_blood_pressure ) :: numeric;

------------------------------------- converting the fetal_weight column to NULL and replacing commas.-----------------------------------------
select * from public.ultrasound;

UPDATE public.ultrasound
set fetal_weight_at_ultrasound = NULL
where fetal_weight_at_ultrasound = 'not_applicable';

UPDATE public.ultrasound
set fetal_weight_at_ultrasound = replace(fetal_weight_at_ultrasound, ',', '');

alter table public.ultrasound
alter column fetal_weight_at_ultrasound type numeric using (fetal_weight_at_ultrasound::numeric) ;

-------------------------------------------------------- converting the new_born to NULL and replacing commas----------------------------------
select * from public.new_born

UPDATE public.new_born
set newborn_weight = NULL
where newborn_weight = 'not_applicable';

UPDATE public.new_born
set newborn_weight = replace(newborn_weight, ',', '');

alter table public.new_born
alter column newborn_weight type numeric using (newborn_weight::numeric) ;


---------------------------------------------DROP_QUERY-----------

alter table patient_details
drop column current_bmi_according_who,
drop column current_bmi,
drop column prepartum_maternal_heigh;

drop table public.previous_pregancy;

alter table public.nutrition
drop column breakfast_meal,
drop column morning_snack,
drop column lunch_meal,
drop column afternoon_snack,
drop column meal_dinner,
drop column supper_meal,
drop column bean,
drop column fruits,
drop column  vegetables,
drop column embedded_food,
drop column pasta,
drop column cookies; 

alter table public.hypertension
drop column hypertension_past_treatment,
drop column right_systolic_blood_pressure,
drop column right_diastolic_blood_pressure,
drop column left_systolic_blood_pressure,
drop column left_diastolic_blood_pressure;














