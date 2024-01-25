
-----cleaning query maternal_phase1

---&& UPADTE STATEMENT TO CHANGE NOT_APPICABLE TO NULL FOR WEIGHT COLUMNS--------------

update public.maternal_patient_data
set current_maternal_weight_1st_tri = Null
where current_maternal_weight_1st_tri = 'not_applicable' or current_maternal_weight_1st_tri = ' '

update public.maternal_patient_data
set current_maternal_weight_2nd_tri = NULL
where current_maternal_weight_2nd_tri = 'not_applicable'


update maternal_patient_data
set current_maternal_weight_3rd_tri = null
where current_maternal_weight_3rd_tri = 'not_applicable'




update public.maternal_patient_data
set prepregnant_weight =Null
where prepregnant_weight = ' '  or prepregnant_weight = 'no_answer'


update public.maternal_patient_data
set prepartum_maternal_weight = null
where prepartum_maternal_weight = 'not_applicable'


--------------------------UPDATE FOR WEIGHT COLUMN COMBINED WITH MATERNAL_WEIGHT_AT_INCLUSION--
--update public.maternal_patient_data
set current_maternal_weight_1st_tri = 
case when gestational_age_at_inclusion >= 0 and gestational_age_at_inclusion <= 13 and 
(maternal_weight_at_inclusion > current_maternal_weight_1st_tri or current_maternal_weight_1st_tri is NULL) 
then maternal_weight_at_inclusion
else current_maternal_weight_1st_tri
end,
current_maternal_weight_2nd_tri = 
case when  gestational_age_at_inclusion >= 13 and gestational_age_at_inclusion <= 27 and 
(maternal_weight_at_inclusion > current_maternal_weight_2nd_tri or current_maternal_weight_2nd_tri is NULL) 
then maternal_weight_at_inclusion
else current_maternal_weight_2nd_tri
end,
current_maternal_weight_3rd_tri = 
case when gestational_age_at_inclusion >= 27 and gestational_age_at_inclusion <= 40 and 
(maternal_weight_at_inclusion > current_maternal_weight_3rd_tri or current_maternal_weight_3rd_tri is NULL) 
 then maternal_weight_at_inclusion else current_maternal_weight_3rd_tri
end;




--&&&& UPADATE STATEMENT TO FOR ALCHOL_COLUMNS 
update public.maternal_patient_data
set alcohol_quantity_milliliters =
case when alcohol_use = 0 and (alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_applicable')and 
(alcohol_preference is null or alcohol_preference = 'not_applicable')
then 'not_used'
else alcohol_quantity_milliliters
end


update public.maternal_patient_data
set  alcohol_preference =
case when alcohol_use = 0 and (alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_used')and (alcohol_preference is null or alcohol_preference = 'not_applicable')
then 'not_used'
else alcohol_preference
end

update public.maternal_patient_data
set alcohol_preference = 
case when alcohol_use = 1 and (alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_used')
							   and (alcohol_preference is null or alcohol_preference = 'not_used')then 'no_answer'
else alcohol_preference
end 

update public.maternal_patient_data
set alcohol_quantity_milliliters = 
case when alcohol_use = 1 and ((alcohol_quantity_milliliters is null or alcohol_quantity_milliliters ='not_used')
							   or (alcohol_preference is null or alcohol_preference = 'not_used'))
							   then 'no_answer'

else alcohol_quantity_milliliters							   
end


-----&&&& UPDATE STATEMENTS FOR TOBACCO COLUMNS 



update public.maternal_patient_data
set tobacco_use_in_months =
case when tobacco_use = 0 and ((tobacco_use_in_months= 'not_applicable'or tobacco_use_in_months is null)
							   and (tobacco_quantity_by_day='not_applicable' or tobacco_quantity_by_day is null ))
							   then 'not_used'
							   else tobacco_use_in_months
							   end
update public.maternal_patient_data
set tobacco_quantity_by_day =
case when tobacco_use = 0 and ((tobacco_use_in_months= 'not_used'or tobacco_use_in_months is null)
							   and (tobacco_quantity_by_day='not_applicable' or tobacco_quantity_by_day is null ))
							   then 'not_used'
							   else tobacco_quantity_by_day
							   end
update public.maternal_patient_data
set tobacco_quantity_by_day =
case when tobacco_use = 1 and ( tobacco_use_in_months is null or tobacco_quantity_by_day is null )
							   then 'no_answer'
							   else tobacco_quantity_by_day
							   end,
tobacco_use_in_months =						   
case when tobacco_use = 1 and ( tobacco_use_in_months is null or tobacco_quantity_by_day is null )
							   then 'no_answer'
							   else tobacco_use_in_months
							   end

----BP-------------
update  public.maternal_patient_data
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



alter table public.maternal_patient_data
add column mean_systolic_bp integer,
add column mean_diastolic_bp integer


update public.maternal_patient_data
set
mean_systolic_bp = ROUND((left_systolic_blood_pressure + right_systolic_blood_pressure) / 2, 0),
mean_diastolic_bp = ROUND((left_diastolic_blood_pressure + right_diastolic_blood_pressure) / 2, 0);


-----------------------

-----do the same for drugh column -------

----------------------------------------DELIVERY_MODE------------------------
update public.maternal_patient_data
set delivery_mode =
case when cesarean_section_reason = 'not_applicable' then 0  --- or  delivery_mode in (1,2,7,8) then 0 
when cesarean_section_reason is not null then 1 ---or delivery_mode in (5,6,12)  then 1
when cesarean_section_reason is null and delivery_mode is null  then 2
end ;

update public.maternal_patient_data
set delivery_mode = 0 where case_id  in(46,102,107)

select case_id,delivery_mode,cesarean_section_reason from public.maternal_patient_data
--where case_id in (17,18,46,72,102,107,137,150,200)
order by case_id

----------------------MOTHERS_HOSPITAL_STAY------------------------
----update public.maternal_patient_data
set mothers_hospital_stay =
case when newborn_weight is not null and apgar_1st_min is not null and  mothers_hospital_stay is null then 'same day discharge'
when newborn_weight is not null and apgar_5th_min is not null and mothers_hospital_stay is null then'same day discharge'
when apgar_1st_min is not null and  apgar_5th_min is not null and mothers_hospital_stay is null then 'same day discharge'
--when delivery_mode in (0,1) and mothers_hospital_stay is null then 'same day discharge' 
when newborn_weight is null and apgar_1st_min is null and  mothers_hospital_stay is null then 'missed_follow_up'
else mothers_hospital_stay
end;
----------------------------------------------------------------NUTRITION COLUMN ------------------------
alter table	public.maternal_patient_data
add column basic_nurtition  numeric

update public.maternal_patient_data
set basic_nurtition = case when breakfast_meal + lunch_meal + meal_dinner + vegetables + bean + fruits >=3 THEN 1 else 0 end 


alter table public.maternal_patient_data
add column regular_high_calorie_intake NUMERIC;

update public.maternal_patient_data
set regular_high_calorie_intake = case when pasta+cookies >=2 then 1
else 0 end
----&&&& UPDATE FOR LAB---------
UPDATE public.maternal_patient_data
SET
second_trimester_hematocrit = case when second_trimester_hematocrit = 'not_applicable' then 'test_not_taken' else second_trimester_hematocrit end,
third_trimester_hematocrit = case when third_trimester_hematocrit = 'not_applicable' then 'test_not_taken' else third_trimester_hematocrit end,
--firt_trimester_hemoglobin = case when firt_trimester_hemoglobin = 'not_applicable' then 'test_not_taken' else firt_trimester_hemoglobin end,
second_trimester_hemoglobin = case when second_trimester_hemoglobin = 'not_applicable' then 'test_not_taken' else second_trimester_hemoglobin end,
third_trimester_hemoglobin = case when third_trimester_hemoglobin = 'not_applicable' then 'test_not_taken' else third_trimester_hemoglobin end,
--first_tri_fasting_blood_glucose = case when first_tri_fasting_blood_glucose = 'not_applicable' then 'test_not_taken' else first_tri_fasting_blood_glucose end,
second_tri_fasting_blood_glucose = case when second_tri_fasting_blood_glucose = 'not_applicable' then 'test_not_taken' else second_tri_fasting_blood_glucose end,
third_tri_fasting_blood_glucose = case when third_tri_fasting_blood_glucose = 'not_applicable' then 'test_not_taken' else third_tri_fasting_blood_glucose end


---ALTER COMMAND TO CHANGE DATATYPE --------

ALTER TABLE public.maternal_patient_data
---ALTER COLUMN gestational_age_at_inclusion  TYPE double precision USING (gestational_age_at_inclusion )::double precision
alter column right_systolic_blood_pressure type numeric using (right_systolic_blood_pressure):: numeric,
alter column   right_diastolic_blood_pressure  type  numeric using (right_diastolic_blood_pressure):: numeric,
alter column  left_systolic_blood_pressure   type  numeric using (left_systolic_blood_pressure):: numeric,
alter column  left_diastolic_blood_pressure   type  numeric using (left_diastolic_blood_pressure):: numeric
--ALTER COLUMN prepregnant_weight TYPE numeric USING (prepregnant_weight)::numeric,
--ALTER COLUMN maternal_weight_at_inclusion TYPE numeric USING (maternal_weight_at_inclusion)::numeric,
--ALTER COLUMN current_maternal_weight_1st_tri TYPE numeric USING (current_maternal_weight_1st_tri )  :: numeric,
--ALTER COLUMN hight_at_inclusion TYPE numeric USING (hight_at_inclusion )  :: numeric
---ALTER COLUMN prepartum_maternal_weight TYPE numeric USING (prepartum_maternal_weight ) :: numeric
---ALTER COLUMN current_maternal_weight_3rd_tri TYPE numeric USING (current_maternal_weight_3rd_tri ) :: numeric
---ALTER COLUMN prepartum_maternal_heigh TYPE numeric USING (prepartum_maternal_heigh ) :: numeric
---ALTER COLUMN current_bmi TYPE numeric USING ( ) :: numeric
ALTER COLUMN current_maternal_weight_2nd_tri TYPE numeric USING (current_maternal_weight_2nd_tri ) :: numeric
ALTER TABLE public.maternal_patient_data
ALTER COLUMN mothers_hospital_stay TYPE text;

	
