-- CREATE COVID_DEATHS TABLE 
CREATE TABLE IF NOT EXISTS public.covid_deaths
(
    iso_code character varying(50) NOT NULL,
    continent character varying(50) NOT NULL,
    location character varying(50) NOT NULL,
    date date NOT NULL,
    population integer,
    total_cases integer,
    new_cases integer,
    new_cases_smoothed integer,
    total_deaths integer,
    new_deaths integer,
    new_deaths_smoothed integer,
    total_cases_per_million integer,
    new_cases_per_million integer,
    new_cases_smoothed_per_million integer,
    total_deaths_per_million integer,
    new_deaths_per_million integer,
    new_deaths_smoothed_per_million integer,
    reproduction_rate integer,
    icu_patients integer,
    icu_patients_per_million integer,
    hosp_patients integer,
    hosp_patients_per_million integer,
    weekly_icu_admissions integer,
    weekly_icu_admissions_per_million integer,
    weekly_hosp_admissions integer,
    weekly_hosp_admissions_per_million integer,
    PRIMARY KEY (iso_code)
)

TABLESPACE pg_default;

ALTER TABLE public.covid_deaths
    OWNER to postgres;
