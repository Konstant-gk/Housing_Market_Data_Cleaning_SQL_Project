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


Select
PropertyAddress
from [US_Housemarket_DB].[dbo].[USHousing]
--where PropertyAddress is null
--order by ParcelID


Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address, 
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from [US_Housemarket_DB].[dbo].[USHousing]


ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add PropertySplitAddress Nvarchar(255);


Update [US_Housemarket_DB].[dbo].[USHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add PropertySplitCity Nvarchar(255);


Update [US_Housemarket_DB].[dbo].[USHousing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


select
*
from [US_Housemarket_DB].[dbo].[USHousing]



--------------------------------------------------------------------------------------

-- Breaking out OwnerAddress into individual columns (Address, City, State)


select
OwnerAddress
from [US_Housemarket_DB].[dbo].[USHousing]



select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from [US_Housemarket_DB].[dbo].[USHousing]



ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add OwnerSplitAddress Nvarchar(255);

Update [US_Housemarket_DB].[dbo].[USHousing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)



ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add OwnerSplitCity Nvarchar(255);

Update [US_Housemarket_DB].[dbo].[USHousing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)



ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
Add OwnerSplitState Nvarchar(255);

Update [US_Housemarket_DB].[dbo].[USHousing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


select
*
from [US_Housemarket_DB].[dbo].[USHousing]



--------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


select distinct (SoldAsVacant), COUNT(SoldAsVacant)
from [US_Housemarket_DB].[dbo].[USHousing]
group by SoldAsVacant
order by 2


select SoldAsVacant,CASE 
	when SoldAsVacant = 'Y' THEN 'Yes'
	when SoldAsVacant = 'N' THEN 'No'
	Else SoldAsVacant
	end
from [US_Housemarket_DB].[dbo].[USHousing]


update [US_Housemarket_DB].[dbo].[USHousing]
SET SoldAsVacant = CASE 
	when SoldAsVacant = 'Y' THEN 'Yes'
	when SoldAsVacant = 'N' THEN 'No'
	Else SoldAsVacant
	end


--------------------------------------------------------------------------------------

-- Remove Duplicates


WITH RowNumCTE AS( 
Select
	*, 
	ROW_NUMBER() OVER (
	PARTITION BY	ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID
						) row_num
From [US_Housemarket_DB].[dbo].[USHousing]
)
select
*
from RowNumCTE
where row_num > 1
order by PropertyAddress

--DELETE
--From RowNumCTE
--where row_num > 1



--------------------------------------------------------------------------------------

-- Remove Unused Colummns


select
*
from [US_Housemarket_DB].[dbo].[USHousing]


ALTER TABLE [US_Housemarket_DB].[dbo].[USHousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate