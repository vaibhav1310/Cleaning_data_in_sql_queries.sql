
#  Cleaning data in sql queries

select *
from housing ;

-- deleting rows that contain column with null values

delete from housing where propertyaddress is null;

--  Breaking out Address into Individual Columns (Address, City, State)

select substring_index(propertyaddress,',',-1) as Property_City from housing;

select substring_index(propertyaddress,',',1) as Property_Address from housing;

ALTER TABLE housing
Add Property_Address Nvarchar(255);

ALTER TABLE housing
Add Property_City Nvarchar(255);

Update housing
SET Property_Address = substring_index(propertyaddress,',',1);

Update housing
SET Property_City = substring_index(propertyaddress,',',-1);

select * from housing;

select owneraddress from housing;

select substring_index(owneraddress,',',1) as Owner_address from housing;

select substring_index(owneraddress,',',-1) as owner_state from housing;

select substring_index(substring_index(owneraddress,',',-2),',',1) as owner_city from housing;

ALTER TABLE housing
Add Owner_address Nvarchar(255);

ALTER TABLE housing
Add Owner_city Nvarchar(255);

ALTER TABLE housing
Add Owner_state Nvarchar(255);

Update housing
set Owner_address = substring_index(owneraddress,',',1) ;

Update housing
set owner_city = substring_index(substring_index(owneraddress,',',-2),',',1);

update housing
set owner_state = substring_index(owneraddress,',',-1);
select * from housing;

-- change Y and N to Yes or No in sold as vacant field

SELECT soldasvacant,
case when soldasvacant = 'Y' then 'Yes'
when soldasvacant = 'N' then 'No'
else soldasvacant
end
from housing;
 
 update housing
 set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
when soldasvacant = 'N' then 'No'
else soldasvacant
end;
select * from family;
-- Remove Duplicates

delete t1
from housing t1 inner join housing t2
on t2.propertyaddress = t1.propertyaddress 
and t2.SaleDate = t1.SaleDate and t2.parcelid = t2.parcelid and t2.uniqueid < t1.uniqueid;

-- delete unused columns
select * from housing;

alter table housing
drop column propertyaddress,
drop column owneraddress,
drop column saledate,
drop column taxdistrict;