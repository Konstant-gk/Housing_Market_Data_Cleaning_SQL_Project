select
*
from [US_Housemarket_DB].[dbo].[USHousing]

--------------------------------------------------------------------------------------

--Standardize Date Format

select
SaleDateConverted, CONVERT(date,SaleDate)
from [US_Housemarket_DB].[dbo].[USHousing]

Update [US_Housemarket_DB].[dbo].[USHousing]
SET Saledate = CONVERT(date,SaleDate)

ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add SaleDateConverted Date;

Update [US_Housemarket_DB].[dbo].[USHousing]
SET SaleDateConverted = CONVERT(date,SaleDate)


--------------------------------------------------------------------------------------

--Populate Property Address Data


select
*
from [US_Housemarket_DB].[dbo].[USHousing]
--where PropertyAddress is null
order by ParcelID


select
a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from [US_Housemarket_DB].[dbo].[USHousing] a
join [US_Housemarket_DB].[dbo].[USHousing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b. [UniqueID ]
where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [US_Housemarket_DB].[dbo].[USHousing] a
join [US_Housemarket_DB].[dbo].[USHousing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b. [UniqueID ]
where a.PropertyAddress is null


--------------------------------------------------------------------------------------

-- Breaking out Address into individual columns (Address, City, State)

select
PropertyAddress
from [US_Housemarket_DB].[dbo].[USHousing]
--where PropertyAddress is null
--order by ParcelID