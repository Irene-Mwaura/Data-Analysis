--SHOWING ALL ENTRIES IN COVID DEATHS TABLE
SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4

--SHOWING ALL ENTRIES IN COVID VACCINATIONS TABLE
SELECT *
FROM PortfolioProject..CovidVaccinations
ORDER BY 3,4

--LOOKING AT TOTAL CASES VS TOTAL DEATHS GLOBALLY 
SELECT location,date,total_cases,total_deaths,(cast(total_deaths as float)/cast(total_cases as float)) *100 AS DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2 

--LOOKING AT TOTAL CASES VS TOTAL DEATHS IN A COUNTRY WITH THE NAME STATES
SELECT location,date,total_cases,total_deaths,(cast(total_deaths as float)/cast(total_cases as float)) *100 AS DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE location like'%states%'
AND continent is not null
ORDER BY 1,2 

--LOOKING AT TOTAL CASES VS TOTAL DEATHS IN KENYA 
SELECT location,date,total_cases,total_deaths,(cast(total_deaths as float)/cast(total_cases as float)) *100 AS DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE location='kenya'

ORDER BY 1,2 

--LOOKING AT TOTAL CASES VS POPULATION GLOBALLY 
SELECT location,date,total_cases,population,(cast(total_cases as float)/cast(population as float)) *100 AS InfectionRate 
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--LOOKING AT TOTAL CASES VS POPULATION IN KENYA
SELECT location,date,total_cases,population,(cast(total_cases as float)/cast(population as float)) *100 AS InfectionRate 
FROM PortfolioProject..CovidDeaths
WHERE location='kenya'
ORDER BY 1,2 

--LOOKING AT COUNTRIES WITH THE HIGHEST INFECTION RATE COMPARED TO POPULATION 
SELECT location,population,MAX(total_cases) AS HighestInfectionRate,MAX(cast(total_cases as float)/cast(population as float)) *100 AS InfectionRate 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY population,location
ORDER BY InfectionRate desc

--LOOKING AT COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION GLOBALLY 
SELECT location,MAX(cast(total_deaths as float)) as TotalDeathcount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location 
ORDER BY TotalDeathcount desc

--LOOKING AT COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION BY CONTINENT 
SELECT continent,MAX(cast(total_deaths as float)) as TotalDeathcount
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY continent 
ORDER BY TotalDeathcount desc

--GLOBAL NUMBERS 
--SUM OF NEW DASES BY DATE 
SELECT date,SUM(new_cases) AS TotalNewCases
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2 

SELECT location ,SUM(new_cases) AS TotalNewCases, SUM(new_deaths) AS TotalDeaths
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 1,2 
 
-- SELECT location,SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int)) /SUM(new_cases) * 100 as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--GROUP BY location
--ORDER BY 1,2 

--TOTAL DEATHS GLOBALLY
SELECT SUM(new_cases) AS TotalCases, SUM(cast(new_deaths as int)) AS TotalDeaths, SUM(cast
(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2 

