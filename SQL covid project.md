
```sql
-- SELECT * 
-- FROM `covid-project-339320.Covid.covidDeath`

-- SELECT * 
-- FROM `covid-project-339320.Covid.covidVaccination`

-- Looking at Total Cases vs Total Deaths
-- shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM `covid-project-339320.Covid.covidDeath`
WHERE location LIKE "%States%"
ORDER BY 5 DESC

-- looking at total cases vs population
SELECT location, date,  population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM `covid-project-339320.Covid.covidDeath`
-- WHERE location LIKE "%States%"
ORDER BY 1,2

-- Looking at Countries with Highest Infection Rate compared to population

-- SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected,
FROM `covid-project-339320.Covid.covidDeath`
-- WHERE location LIKE "%States%"
GROUP BY location, population 
ORDER BY 4 DESC

-- Showing countries with Highest Death count per Population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM `covid-project-339320.Covid.covidDeath`
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Let's break things down by continent
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM `covid-project-339320.Covid.covidDeath`
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC


-- Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM `covid-project-339320.Covid.covidDeath`
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage--, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM `covid-project-339320.Covid.covidDeath`
WHERE continent is NOT NULL
-- GROUP BY date
ORDER BY 1,2

-- Looking at total population vs vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM `covid-project-339320.Covid.covidDeath` as dea
JOIN `covid-project-339320.Covid.covidVaccination` as vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3 

--
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date) as RollingPeopleVaccinated--, (RollingPeopleVaccinated/population)*100
FROM `covid-project-339320.Covid.covidDeath` as dea
JOIN `covid-project-339320.Covid.covidVaccination` as vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent is not null 
ORDER BY 2,3


-- USE CTE
-- with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
-- as 
-- (
-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
-- SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location,
-- dea.date) as RollingPeopleVaccinated --, (RollingPeopleVaccinated/population)*100
-- FROM `covid-project-339320.Covid.covidDeath` as dea
-- JOIN `covid-project-339320.Covid.covidVaccination` as vac
--     ON dea.location = vac.location
--     AND dea.date = vac.date
-- WHERE dea.continent is not null 
-- ORDER BY 2,3
-- )

-- SELECT *, (RollingPeopleVaccinated/Population)*100
-- FROM PopvsVac

-- TEMP TABLE
Create Table #PercentPopulationVaccinated
(continent nvarchar(255),
    location nvarchar(255),
    date datetime,
    population numeric,
    new_vaccinations numeric,
    RollingPeopleVaccinated numeric)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM `covid-project-339320.Covid.covidDeath`
JOIN `covid-project-339320.Covid.covidVaccination`
    ON dea.location
)




