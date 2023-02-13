select*
From Portfolio1..CovidDeaths
order by 3,4

--select*
--From Portfolio1..CovidVaccination
--order by 3,4

select location, date, total_cases, new_cases, total_deaths,population_density
From Portfolio1..CovidDeaths
order by 1,2

select location, date, total_cases, new_cases, total_deaths, population_density
From Portfolio1..CovidDeaths
order by 1,2

--likelihood of dying if get in contact with COVID with in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
From Portfolio1..CovidDeaths
where location like'%Malaysia%'
order by 1,2

--looking at total cases vs population
--show percentage of population got covid
select location, date, total_cases,population_density, (total_cases/population_density)*100 as infected_population
From Portfolio1..CovidDeaths
--where location like'%Malaysia%'
order by 1,2

--looking at countries with highest infection rate compared to population
select location, MAX(total_cases)as highestinfectioncount,population_density, MAX((total_cases)/population_density)*100 as Percentpopulationinfected
From Portfolio1..CovidDeaths
--where location like'%Malaysia%'
Group by location, population_density
order by Percentpopulationinfected desc

--showing the countries with highest death count per population

--sort by continent
select continent, MAX(cast(Total_deaths as int)) as Totaldeathscount
From Portfolio1..CovidDeaths
where continent is not null 
Group by continent
order by Totaldeathscount desc

--showing the continent with the highest deathcount
select continent, MAX(cast(Total_deaths as int)) as Totaldeathscount
From Portfolio1..CovidDeaths
where continent is not null 
Group by continent
order by Totaldeathscount desc


select location, MAX(cast(Total_deaths as int)) as Totaldeathscount
From Portfolio1..CovidDeaths
where continent is not null 
Group by location
order by Totaldeathscount desc

--global numbers
select SUM(new_cases)as totalcases, SUM(cast(new_deaths as int))as totaldeaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
From Portfolio1..CovidDeaths
--where location like'%Malaysia%'
Where continent is not null
--group by date
order by 1,2

--total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea. date)
from portfolio1..CovidDeaths dea
join portfolio1..CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3