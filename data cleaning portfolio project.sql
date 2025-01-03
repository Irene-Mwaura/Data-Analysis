SELECT * 
FROM NashvilleHousingProject.dbo.Nashville

--STANDARDIZE DATE FORMAT
SELECT SaleDate
FROM NashvilleHousingProject.dbo.Nashville
--Datetime format has been used and we want to convert it to time format

SELECT SaleDate, Convert(Date,SaleDate)
FROM NashvilleHousingProject.dbo.Nashville

ALTER TABLE Nashville
Add SaleDateConverted Date;

UPDATE Nashville
SET SaleDateConverted =CONVERT(Date,SaleDate)

SELECT SaleDateConverted
FROM NashvilleHousingProject.dbo.Nashville

--POPULATE POPERTY ADDRESS DATA
SELECT PropertyAddress
FROM NashvilleHousingProject.dbo.Nashville
--Noted that there are property addresses with no values 

SELECT * 
FROM NashvilleHousingProject.dbo.Nashville
WHERE PropertyAddress is null

SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL (a.PropertyAddress,b.PropertyAddress) 
FROM NashvilleHousingProject.dbo.Nashville a
JOIN NashvilleHousingProject.dbo.Nashville b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress=ISNULL (a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousingProject.dbo.Nashville a
JOIN NashvilleHousingProject.dbo.Nashville b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is null


--BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS,CITY,STATE)
SELECT PropertyAddress
FROM NashvilleHousingProject.dbo.Nashville

SELECT 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(propertyAddress)) AS Address
FROM NashvilleHousingProject.dbo.Nashville

ALTER TABLE dbo.Nashville
Add PropertySplitAddress nvarchar(255);

UPDATE Nashville
SET PropertySplitAddress =SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 

ALTER TABLE Nashville
Add PropertySplitAddress nvarchar(255);

UPDATE Nashville
SET PropertySplitCity =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(propertyAddress)) 