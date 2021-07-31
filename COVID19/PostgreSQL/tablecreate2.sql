-- CREATE COVID VACCINATIONS TABLE
CREATE TABLE IF NOT EXISTS public.covid_vaccinations
(
    iso_code character varying(10) NOT NULL,
    continent character varying(20),
    location character varying(25) NOT NULL,
    date date NOT NULL,
    new_tests numeric(10),
    total_tests numeric(10),
    total_tests_per_thousand numeric(10),
    new_tests_per_thousand numeric(10),
    new_tests_smoothed numeric(10),
    new_tests_smoothed_per_thousand numeric(10),
    positive_rate numeric(10),
    tests_per_case numeric(10),
    tests_units numeric(10),
    total_vaccinations numeric(10),
    people_vaccinated numeric(10),
    people_fully_vaccinated numeric(10),
    new_vaccinations numeric(10),
    new_vaccinations_smoothed numeric(10),
    total_vaccinations_per_hundred numeric(10),
    people_vaccinated_per_hundred numeric(10),
    people_fully_vaccinated_per_hundred numeric(10),
    new_vaccinations_smoothed_per_million numeric(10),
    stringency_index numeric(5),
    population_density numeric(10),
    median_age numeric(10),
    aged_65_older numeric(10),
    aged_70_older numeric(10),
    gdp_per_capita numeric(10),
    extreme_poverty numeric(10),
    cardiovasc_death_rate numeric(10),
    diabetes_prevalence numeric(10),
    female_smokers numeric(10),
    male_smokers numeric(10),
    handwashing_facilities numeric(10),
    hospital_beds_per_thousand numeric(10),
    life_expectancy numeric(10),
    human_development_index numeric(10),
    excess_mortality numeric(10)
)

TABLESPACE pg_default;

ALTER TABLE public.covid_vaccinations
    OWNER to postgres;
