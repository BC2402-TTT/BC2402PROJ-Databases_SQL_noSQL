SET SQL_SAFE_UPDATES = 0;

# 1. Delete rows where all the non-primary keys are are null
DELETE FROM tests
WHERE	total_tests						is null
	AND	new_tests						is null
    AND total_tests_per_thousand	 	is null
    AND new_tests_per_thousand			is null
    AND new_tests_smoothed				is null
    AND new_tests_smoothed_per_thousand	is null
    AND positive_rate					is null
    AND tests_per_case					is null;
SELECT * FROM tests;

DELETE FROM cases
WHERE	total_cases						is null
    AND	new_cases						is null
    AND total_cases_per_million			is null
    AND new_cases_smoothed				is null
    AND new_cases_per_million			is null
    AND new_cases_smoothed_per_million	is null
	AND	reproduction_rate				is null;
SELECT * FROM cases;

DELETE FROM hospitals
WHERE	icu_patients						is null
	AND icu_patients_per_million			is null
	AND	hosp_patients						is null
    AND hosp_patients_per_million		 	is null
    AND weekly_icu_admissions				is null
    AND weekly_icu_admissions_per_million	is null
    AND weekly_hosp_admissions				is null
    AND weekly_hosp_admissions_per_million	is null;
SELECT * FROM hospitals;

DELETE FROM deaths
WHERE	total_deaths 					is null
	AND new_deaths						is null
	AND	new_deaths_smoothed				is null
	AND	total_deaths_per_million		is null
	AND	new_deaths_per_million			is null
	AND	new_deaths_smoothed_per_million	is null
	AND excess_mortality				is null;
SELECT * FROM deaths;

DELETE FROM stringency
WHERE	stringency_index				is null;
SELECT * FROM stringency;

SET SQL_SAFE_UPDATES = 1;

DROP TABLE covid19data;
DROP TABLE covid19data_cleaned;
DROP TABLE country_vaccinations;
DROP TABLE country_vaccinations_cleaned;
DROP TABLE country_vaccinations_by_manufacturer;