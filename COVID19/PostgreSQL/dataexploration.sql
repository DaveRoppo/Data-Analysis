-- COVID19 DATA EXPLORATION WITH POSTGRESQL
-- 
SELECT 
	location, date, total_cases, new_cases, total_deaths, population
FROM
	public.covid_deaths
ORDER BY
	1,2;
	
-- Total Cases vs Total Deaths per Country 

SELECT 
	location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM
	public.covid_deaths
ORDER BY
	1,2;
	
-- Likelihood of dying if you contract COVID in the U.S.

SELECT 
	location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM
	public.covid_deaths
WHERE
	location LIKE '%States'
ORDER BY
	1,2;
	
-- Total Cases vs Population
-- Shows what percentage of population contracted COVID

SELECT 
	location, date, total_cases, population, (total_cases/population)*100 as cases_percentage
FROM
	public.covid_deaths
WHERE
	location LIKE '%States'
ORDER BY
	1,2;
	
-- Countries with highest infection rate compared to population

SELECT 
	location, MAX(total_cases) as highest_infection_count, population, MAX((total_cases/population))*100 pop_infected_percentage
FROM
	public.covid_deaths
GROUP BY
	location, population
ORDER BY
	pop_infected_percentage desc;
	
-- Countries with highest death count vs population

SELECT 
	location, MAX(total_deaths) as total_death_count
FROM
	public.covid_deaths
WHERE 
	total_deaths is NOT NULL and continent is NOT NULL
GROUP BY
	location
ORDER BY
	total_death_count desc;
	
-- Contitnents with highest death count vs population

SELECT 
	location, MAX(total_deaths) as total_death_count
FROM
	public.covid_deaths
WHERE 
	total_deaths is NOT NULL and continent is NULL
GROUP BY
	location
ORDER BY
	total_death_count desc;
	
-- GLOBAL NUMBERS


SELECT 
	date, SUM(new_cases) as total_cases, SUM(total_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
FROM
	public.covid_deaths
WHERE
	continent is NOT NULL
GROUP BY 
		date
ORDER BY
	1,2;

-- Total COVID World Death Percentage

SELECT 
	SUM(new_cases) as total_cases, SUM(total_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
FROM
	public.covid_deaths
WHERE
	continent is NOT NULL
ORDER BY
	1,2;
	
-- Join 
-- Total Population vs Vaccinations 
-- Rolling Count of Total People Vaccinated By Country

SELECT 
	covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
	SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date)
	as rolling_count_vaccinated
FROM
	public.covid_deaths
JOIN
	public.covid_vaccinations
ON
	public.covid_deaths.location = public.covid_vaccinations.location
AND
	public.covid_deaths.date = public.covid_vaccinations.date
WHERE
	covid_deaths.continent is NOT NULL
ORDER BY
	2,3;
	
-- CTE

WITH 
	pop_vs_vacc (continent, location, date, population, new_vaccinations, rolling_count_vaccinated)
AS
(SELECT 
	covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
	SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date)
	as rolling_count_vaccinated
FROM
	public.covid_deaths
JOIN
	public.covid_vaccinations
ON
	public.covid_deaths.location = public.covid_vaccinations.location
AND
	public.covid_deaths.date = public.covid_vaccinations.date
WHERE
	covid_deaths.continent is NOT NULL
ORDER BY
	2,3)
	
SELECT 
	*, (rolling_count_vaccinated/population)*100
FROM pop_vs_vacc;

-- Temp Table

/*CREATE TEMP TABLE
	percent_pop_vaccinated (
	continent nvarchar(255),
	location nvarchar(255),
	date date,
	population numeric(50),
	new_vaccinations numeric(50),
	rolling_count_vaccinated numeric(50))
INSERT INTO
	percent_pop_vaccinated
SELECT 
	covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
	SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date)
	as rolling_count_vaccinated
FROM
	public.covid_deaths
JOIN
	public.covid_vaccinations
ON
	public.covid_deaths.location = public.covid_vaccinations.location
AND
	public.covid_deaths.date = public.covid_vaccinations.date
WHERE
	covid_deaths.continent is NOT NULL
ORDER BY
	2,3
	
SELECT 
	*, (rolling_count_vaccinated/population)*100
FROM
	percent_pop_vaccinated;
	*/
	
-- View To Store Data For Visualization

CREATE VIEW
	percent_pop_vaccianted 
AS
SELECT 
	covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
	SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date)
	as rolling_count_vaccinated
FROM
	public.covid_deaths
JOIN
	public.covid_vaccinations
ON
	public.covid_deaths.location = public.covid_vaccinations.location
AND
	public.covid_deaths.date = public.covid_vaccinations.date
WHERE
	covid_deaths.continent is NOT NULL
ORDER BY
	2,3;

