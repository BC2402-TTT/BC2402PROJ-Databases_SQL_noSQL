SELECT COLUMN_NAME, DATA_TYPE from INFORMATION_SCHEMA.COLUMNS
WHERE table_name = "covid19data";
# the datatype for all the columns are of "text" data_type.
# this is incorrect, e.g. total_cases should be int, date should be datetime etc.
# therefore, we need to change the datatypes

#DROP TABLE covid19data_cleaned;

# 1. Create a new table called "covid19data_cleaned"
# 2. Set all empty strings to NULL
CREATE TABLE covid19data_cleaned AS SELECT 
	NULLIF(iso_code,							'') as iso_code,
    NULLIF(continent, 							'') as continent,
	NULLIF(location, 							'') as location,
    NULLIF(date, 								'') as date,
	NULLIF(total_cases, 						'') as total_cases,
    NULLIF(new_cases,							'') as new_cases,
    NULLIF(new_cases_smoothed,					'') as new_cases_smoothed,
    NULLIF(total_deaths,						'') as total_deaths,
    NULLIF(new_deaths, 							'') as new_deaths,
	NULLIF(new_deaths_smoothed,					'') as new_deaths_smoothed,
    NULLIF(total_cases_per_million, 			'') as total_cases_per_million,
	NULLIF(new_cases_per_million, 				'') as new_cases_per_million,
    NULLIF(new_cases_smoothed_per_million,		'') as new_cases_smoothed_per_million,
    NULLIF(total_deaths_per_million,			'') as total_deaths_per_million,
    NULLIF(new_deaths_per_million,				'') as new_deaths_per_million,
    NULLIF(new_deaths_smoothed_per_million, 	'') as new_deaths_smoothed_per_million,
	NULLIF(reproduction_rate, 					'') as reproduction_rate,
    NULLIF(icu_patients, 						'') as icu_patients,
	NULLIF(icu_patients_per_million, 			'') as icu_patients_per_million,
    NULLIF(hosp_patients,						'') as hosp_patients,
    NULLIF(hosp_patients_per_million,			'') as hosp_patients_per_million,
    NULLIF(weekly_icu_admissions,				'') as weekly_icu_admissions,
    NULLIF(weekly_icu_admissions_per_million,	'') as weekly_icu_admissions_per_million,
	NULLIF(weekly_hosp_admissions,				'') as weekly_hosp_admissions,
    NULLIF(weekly_hosp_admissions_per_million, 	'') as weekly_hosp_admissions_per_million,
	NULLIF(new_tests, 							'') as new_tests,
    NULLIF(total_tests,							'') as total_tests,
    NULLIF(total_tests_per_thousand,			'') as total_tests_per_thousand,
    NULLIF(new_tests_per_thousand, 				'') as new_tests_per_thousand,
    NULLIF(new_tests_smoothed,					'') as new_tests_smoothed,
    NULLIF(new_tests_smoothed_per_thousand,		'') as new_tests_smoothed_per_thousand,
	NULLIF(positive_rate, 						'') as positive_rate,
    NULLIF(tests_per_case,						'') as tests_per_case,
    NULLIF(tests_units,							'') as tests_units,
    NULLIF(total_vaccinations, 					'') as total_vaccinations,
    NULLIF(people_vaccinated,					'') as people_vaccinated,
    NULLIF(people_fully_vaccinated,				'') as people_fully_vaccinated,
	NULLIF(new_vaccinations,					'') as new_vaccinations,
    NULLIF(new_vaccinations_smoothed, 			'') as new_vaccinations_smoothed,
    NULLIF(total_vaccinations_per_hundred,		'') as total_vaccinations_per_hundred,
    NULLIF(people_vaccinated_per_hundred,		'') as people_vaccinated_per_hundred,
	NULLIF(people_fully_vaccinated_per_hundred,	'') as people_fully_vaccinated_per_hundred,
   NULLIF(new_vaccinations_smoothed_per_million,'') as new_vaccinations_smoothed_per_million,
    NULLIF(stringency_index, 					'') as stringency_index,
    NULLIF(population,							'') as population,
    NULLIF(population_density,					'') as population_density,
	NULLIF(median_age, 							'') as median_age,
    NULLIF(aged_65_older,						'') as aged_65_older,
    NULLIF(aged_70_older,						'') as aged_70_older,
	NULLIF(gdp_per_capita, 						'') as gdp_per_capita,
    NULLIF(extreme_poverty,						'') as extreme_poverty,
    NULLIF(cardiovasc_death_rate,				'') as cardiovasc_death_rate,
	NULLIF(diabetes_prevalence, 				'') as diabetes_prevalence,
    NULLIF(female_smokers,						'') as female_smokers,
    NULLIF(male_smokers,						'') as male_smokers,
	NULLIF(handwashing_facilities, 				'') as handwashing_facilities,
    NULLIF(hospital_beds_per_thousand,			'') as hospital_beds_per_thousand,
    NULLIF(life_expectancy,						'') as life_expectancy,
	NULLIF(human_development_index, 			'') as human_development_index,
    NULLIF(excess_mortality,					'') as excess_mortality
FROM covid19data;

# 3. Change the data types
ALTER TABLE covid19data_cleaned
	#iso_code	-->	TEXT
    #continent	--> TEXT
    #location	--> TEXT	
	MODIFY COLUMN date									DATE,
    MODIFY COLUMN total_cases							INT,
	MODIFY COLUMN new_cases								INT,
    MODIFY COLUMN new_cases_smoothed					DECIMAL(65, 3),
    MODIFY COLUMN total_deaths							INT,
    MODIFY COLUMN new_deaths							INT,
    MODIFY COLUMN new_deaths_smoothed					DECIMAL(65,3),
    MODIFY COLUMN total_cases_per_million				DECIMAL(65,3),
    MODIFY COLUMN new_cases_per_million					DECIMAL(65,3),
    MODIFY COLUMN new_cases_smoothed_per_million		DECIMAL(65,3),
    MODIFY COLUMN total_deaths_per_million				DECIMAL(65,3),
    MODIFY COLUMN new_deaths_per_million				DECIMAL(65,3),
    MODIFY COLUMN new_deaths_smoothed_per_million		DECIMAL(65,3),
	MODIFY COLUMN reproduction_rate						DECIMAL(65,2),
    MODIFY COLUMN icu_patients	 						INT,
	MODIFY COLUMN icu_patients_per_million 				DECIMAL(65,3),
    MODIFY COLUMN hosp_patients							INT,
    MODIFY COLUMN hosp_patients_per_million				DECIMAL(65,3),
    MODIFY COLUMN weekly_icu_admissions					DECIMAL(65,3), ###########################################
    MODIFY COLUMN weekly_icu_admissions_per_million 	DECIMAL(65,3),
	MODIFY COLUMN weekly_hosp_admissions				DECIMAL(65,3),
   MODIFY COLUMN weekly_hosp_admissions_per_million 	DECIMAL(65,3),
	MODIFY COLUMN new_tests								INT,
    MODIFY COLUMN total_tests							INT,
    MODIFY COLUMN total_tests_per_thousand				DECIMAL(65,3),
    MODIFY COLUMN new_tests_per_thousand				DECIMAL(65,3),
    MODIFY COLUMN new_tests_smoothed					INT,
    MODIFY COLUMN new_tests_smoothed_per_thousand		DECIMAL(65,3),
	MODIFY COLUMN positive_rate							DECIMAL(65,3),
    MODIFY COLUMN tests_per_case						DECIMAL(65,1),
    MODIFY COLUMN tests_units							TEXT,
    MODIFY COLUMN total_vaccinations 					BIGINT,
    MODIFY COLUMN people_vaccinated						INT,
    MODIFY COLUMN people_fully_vaccinated				INT,
	MODIFY COLUMN new_vaccinations						INT,
    MODIFY COLUMN new_vaccinations_smoothed				INT,
    MODIFY COLUMN total_vaccinations_per_hundred		DECIMAL(65,2),
    MODIFY COLUMN people_vaccinated_per_hundred			DECIMAL(65,2),
    MODIFY COLUMN people_fully_vaccinated_per_hundred 	DECIMAL(65,2),
    MODIFY COLUMN new_vaccinations_smoothed_per_million	INT,
    MODIFY COLUMN stringency_index						DECIMAL(65,2),
    MODIFY COLUMN population							BIGINT,
    MODIFY COLUMN population_density					DECIMAL(65,3),
	MODIFY COLUMN median_age							DECIMAL(65,1),
    MODIFY COLUMN aged_65_older							DECIMAL(65,3),
    MODIFY COLUMN aged_70_older							DECIMAL(65,3),
	MODIFY COLUMN gdp_per_capita						DECIMAL(65,3),
    MODIFY COLUMN extreme_poverty						DECIMAL(65,1),
    MODIFY COLUMN cardiovasc_death_rate					DECIMAL(65,3),
	MODIFY COLUMN diabetes_prevalence					DECIMAL(65,2),
    MODIFY COLUMN female_smokers						DECIMAL(65,1),
    MODIFY COLUMN male_smokers							DECIMAL(65,1),
	MODIFY COLUMN handwashing_facilities				DECIMAL(65,3),
    MODIFY COLUMN hospital_beds_per_thousand			DECIMAL(65,3),
    MODIFY COLUMN life_expectancy						DECIMAL(65,2),
	MODIFY COLUMN human_development_index				DECIMAL(65,3),
    MODIFY COLUMN excess_mortality						DECIMAL(65,2);
    
# 4. Verify that the datatypes have been changed
SELECT COLUMN_NAME, DATA_TYPE from INFORMATION_SCHEMA.COLUMNS
WHERE table_name = "covid19data_cleaned";

# 5. Verify that the data values remain unchanged
SELECT * FROM covid19data_cleaned;
