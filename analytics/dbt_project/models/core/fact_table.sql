{{
    config(
        materialized='table'
    )
}}

with green_trip as
(
    select * from {{ ref('stg_green_taxi') }}
),

yellow_trip as
(
    select * from {{ ref('stg_green_taxi') }}
),

dim_zones as 
(
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
),

trip_data as
(
    select * from green_trip
    union all
    select * from yellow_trip
),

select 
    trip_data.tripid,
    trip_data.uid,
    trip_data.filename,
    trip_data.vendorid,
    trip_data.ratecodeid,
    trip_data.pulocationid,
    trip_data.dolocationid,
    trip_data.pickup_datetime,
    trip_data.dropoff_datetime,
    trip_data.store_and_fwd_flag,
    trip_data.passenger_count,
    trip_data.trip_distance,
    trip_data.fare_amount,
    trip_data.extra,
    trip_data.mta_tax,
    trip_data.tip_amount,
    trip_data.tolls_amount,
    trip_data.ehail_fee,
    trip_data.improvement_surcharge,
    trip_data.total_amount,
    trip_data.payment_type,
    trip_data.payment_description,
    trip_data.trip_type,
    trip_data.congestion_surcharge,
    pickup_zone.borough as pickup_borough,
    pickup_zone.zone as pickup_zone,
    pickup_zone.locationid as pickup_zone_loc,
    dropoff_zone.locationid as dropoff_borough_loc,
    dropoff_zone.borough as dropoff_borough,
    dropoff_zone.zone as dropoff_zone

from trip_data

inner join dim_zones as pickup_zone on pickup_zone.locationid = trip_data.pulocationid
inner join dim_zones as dropoff_zone on pickup_zone.locationid = trip_data.dolocationid




