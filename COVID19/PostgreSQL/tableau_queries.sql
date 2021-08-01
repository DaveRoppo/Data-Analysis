-- 1. COVID-19 World Mortality Rate 

Select 
	SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_percentage
From 
	public.covid_deaths
WHERE
	continent is NOT NULL 
ORDER BY
	1,2;

-- 2. 

SELECT
  location, SUM(cast(new_deaths as int)) as total_death_count
FROM
  public.covid_deaths
Where 
  continent is NULL and location not in ('World', 'European Union', 'International')
GROUP BY
  location
ORDER BY
  total_death_count desc;


-- 3.

SELECT
  location, population, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_population_infected
FROM
  public.covid_deaths
GROUP BY
  location, population
ORDER BY
  percent_population_infected desc;


-- 4.

SELECT
  location, population, date, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_population_infected
FROM
  public.covid_deaths
GROUP BY
  location, population, date
ORDER BY
  percent_population_infected desc;

