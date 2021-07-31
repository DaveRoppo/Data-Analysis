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
