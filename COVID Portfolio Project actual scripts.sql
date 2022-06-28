Select *
 From PortfolioProject..CovidDeaths
 Where continent is not null
 order by 3,4


 --Select *
 --From PortfolioProject..CovidVaccinations
 --order by 3,4

 Select Location, date, total_cases, new_cases, total_deaths, population
 From PortfolioProject..CovidDeaths
 order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contractn covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 From PortfolioProject..CovidDeaths
 Where location like 'United States'
 order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got covid

Select Location, date, total_cases, Population, (total_cases/Population)*100 as PercentPopulationInfected
 From PortfolioProject..CovidDeaths
 Where location like 'United States'
 order by 1,2

 
-- Looking at Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
 From PortfolioProject..CovidDeaths
---Where location like 'United States'
 GROUP BY Location, Population
 order by PercentPopulationInfected desc

 -- Showing Countries with Highest Death Count per Population
 

 Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
 From PortfolioProject..CovidDeaths
---Where location like 'United States'
 Where continent is not null
 GROUP BY Location
 order by TotalDeathCount desc

 -- LET'S BREAK THINGS DOWN BY CONTINENT
  -- Showing continents with the highest death count


 Select location,MAX(cast(Total_deaths as int)) as TotalDeathCount
 From PortfolioProject..CovidDeaths
---Where location like 'United States'
 Where continent is null
 GROUP BY location
 order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths 
--Where location like 'United States'
where continent is not null
--Group by date
order by 1,2


-- Looking at Total Population vs Vaccination

Select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated,
-- RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


-- TEMP TABLE

DROP TABLE if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *
From PercentPopulationVaccinated








