-- https://learn.getdbt.com/learn/course/dbt-fundamentals/set-up-dbt-cloud-55min/getting-started?page=4
-- This is Jinja, a Pythonic language
{% for i in range(10) %}
    select {{ i }} as number
    {% if not loop.last %}
        union all
    {% endif %}
{% endfor %}

-- https://learn.getdbt.com/learn/course/dbt-fundamentals/models-45min/building-your-first-model?page=9
select sum(lifetime_value)
from {{ ref("dim_customers") }}
