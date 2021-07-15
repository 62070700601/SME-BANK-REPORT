select 
	user_id, 
    user_name, 
    role_id, 
    role_name, 
    company_id, 
    company_name, 
    dnis_group_id, 
    dnis_group_name, 
    start_stamp, 
    week(start_stamp) as week_stamp,
    year(start_stamp) as year_stamp,
	sum(handled) as handled, 
    sum(misscall) as misscall, 
    sum(hold) as hold, 
    sum(totaltalk) as totaltalk, 
    sum(totalhold) as totalhold, 
    sum(totalpretalk) as totalpretalk,
    avg(avgtalk) as avgtalk, 
    avg(avghold) as avghold, 
    avg(avgpretalk) as avgpretalk, 
    sla
from agent_record_weekly
where 
	week(start_stamp) between week($P{start_date}) and week($P{end_date})
	and year(start_stamp) between year($P{start_date}) and year($P{end_date})
    and $X{IN,dnis_group_id,dnis_group_id} 
    and $X{IN,user_id,user_id}
    and $X{IN,role_id,role_id}
	and $X{IN,company_id,company_id}
group by 
	dnis_group_id,
	company_id,
	id
order by
	dnis_group_name,
	role_id,
	week_stamp,
	year_stamp,
	company_name