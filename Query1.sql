SELECT 
  location, date, total_cases, new_cases, total_cases, population
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
ORDER BY 1,2;

-- Looking at Total Cases v/s Total Deaths

SELECT 
  location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE location = 'India'
ORDER BY 1,2;

-- Looking at Total Cases v/s Population

SELECT 
  location, date, total_cases, new_cases, population, (total_cases/population)*100 AS Infection_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE location = 'India' 
ORDER BY 1,2;

-- Looking at countries with highest infection rate as of 2021-07-22

SELECT 
  date, location, total_cases, population, (total_cases/population)*100 AS Infection_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE 
  date = "2021-07-22" AND 
  population IS NOT NULL AND 
  total_cases IS NOT NULL AND 
  continent IS NOT NULL
  -- AND location = "India"
ORDER BY Infection_Percentage DESC;

-- Showing countries with highest death count per population as of 2021-07-22

SELECT 
  location, total_deaths, population, (total_deaths/population)*100 AS Death_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE 
  date = "2021-07-22" AND 
  population IS NOT NULL AND 
  total_deaths IS NOT NULL AND 
  continent IS NOT NULL
  -- AND location = "India"
ORDER BY total_deaths DESC;

-- Continents' death count

SELECT 
  location as Continents, total_deaths, population, (total_deaths/population)*100 AS Death_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE 
  date = "2021-07-22" AND 
  population IS NOT NULL AND 
  total_deaths IS NOT NULL AND 
  continent IS NULL AND 
  location NOT IN ("World", "European Union")
  -- AND location = "India"
ORDER BY total_deaths DESC;

-- Total population v/s vaccinations

SELECT 
  dea.date, dea.location, dea.total_cases, vac.new_vaccinations, 
  SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY CAST(dea.location AS STRING), dea.date) AS Cumulative_Vaccinations
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths` dea
JOIN 
  `portfolio-project-320720.Covid.Covid_Vaccinations` vac
ON
  dea.location = vac.location AND
  dea.date = vac.date
WHERE 
  dea.continent IS NOT NULL;

-- Total deaths, cases and death percentage worldwide as of 2021-07-22

SELECT 
  total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM 
  `portfolio-project-320720.Covid.Covid_Deaths`
WHERE location = 'World' AND 
  date = '2021-07-22';



