--SHOWING COVID VACCINATIONS TABLE 
SELECT *
FROM PortfolioProject..CovidVaccinations

--JOINING COVID DEATHS AND COVID VACCINATIONS TABLES
SELECT *
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.date=vac.date

--POPULATION VS VACCINATION
SELECT dea.continent, dea.location,dea.date, dea.population,vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.date=vac.date
WHERE dea.continent is not null
ORDER BY 2,3

SELECT dea.continent, dea.location,dea.date, dea.population,vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (partition by dea.location ) as RollingPeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.date=vac.date
WHERE dea.continent is not null
ORDER BY 2,3

--USING CTE to find percentage of people vaccinated
with popvsvac (continent,location,date,population,new_vaccinations,RollingPeoplevaccinated)
as
(SELECT dea.continent, dea.location,dea.date, dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location,dea.date) as RollingPeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent is not null
)
SELECT * ,(RollingPeoplevaccinated/population) *100 
FROM popvsvac


--TEMP TABLE
--DROP table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar (255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeoplevaccinated numeric
)

insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location,dea.date, dea.population,vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as int)) --OVER (partition by dea.location order by dea.location,dea.date) as RollingPeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent is not null


SELECT * ,(RollingPeoplevaccinated/population) *100 
FROM #PercentPopulationVaccinated


--CREATING VIEW TO STORE DATA FOR LATE VISUALISATIONS
CREATE VIEW PercentPopulationVaccinated AS 
SELECT dea.continent, dea.location,dea.date, dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location,dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent is not null

SELECT * 
FROM PercentPopulationVaccinated
