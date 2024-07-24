with joined as(
select n.meal_option,
    n.calories__kcal_,
    case 
        when type = 'Veggie' then 'Vegetarian'
        when type = 'Meat-based' then 'Meat based'
        else type
    end as type,
    m.price
from pd2023_wk20_meal_nutritional_info as n
inner join pd2023_wk20_meal_prices as m
    on n.meal_option=m.meal_option
),


tp as (
select sum(price) as total_price,
count(type) as no_of_meals

from joined
),



nearly as(
select 
    j.type,
    avg(j.price) as avg_price,
    total_price as tp,
    sum(j.price) as pricey,
    count(j.type) as county,
    no_of_meals
from
joined j
cross join
tp
group by all
)

select
    type,
    avg_price,
    Round((county/no_of_meals)*100) as meal_type_percentage
    
from nearly
group by all;
