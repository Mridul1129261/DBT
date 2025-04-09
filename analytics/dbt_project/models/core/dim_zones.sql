with zones as (select * from {{ ref("dim_zones") }})

select 
locationid, 
borough, 
zone, 
replace(service_zone,'Boro', 'Green') as service_zone
from zones
