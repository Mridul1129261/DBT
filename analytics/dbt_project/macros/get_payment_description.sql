{% macro get_payment_description(payment_type) -%}

case cast ({{payment_type}} as integer)

    when 0 then 'credit card'
    when 1 then 'debit card'
    when 2 then 'UPI'
    when 3 then 'cash'
    when 4 then 'settlement'
    when 5 then 'sponsored'
    else 'others'
end

{%- endmacro %}