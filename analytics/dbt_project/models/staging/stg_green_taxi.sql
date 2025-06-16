{{
    config(
        materialized='table'
    )
}}

with 

source as (

    select * from {{ source('green_trip_data', 'kestra_ny_taxi_green_gcp_new') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['vendorid', 'lpep_pickup_datetime','lpep_dropoff_datetime']) }} as trip_id,
        uid,
        filename,
        vendorid,
        lpep_pickup_datetime as pickup_datetime,
        lpep_dropoff_datetime as dropoff_datetime,
        store_and_fwd_flag,
        ratecodeid,
        pulocationid,
        dolocationid,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,
        {{get_payment_description("payment_type")}} as payment_description,
        trip_type,
        congestion_surcharge

    from source

)

select * from renamed

{% if var ('is_test_run', default=True) %}

limit 1000

{% endif %}