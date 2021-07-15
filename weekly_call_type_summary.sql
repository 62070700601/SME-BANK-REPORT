select 
	start_stamp,
	week(start_stamp) as week_stamp, 
	year(start_stamp) as year_stamp, 
	dnis_group_id, 
    dnis_group_name, 
	company_id, 
	company_name, 
	sum(handled) as handled, 
	sum(abandon) as abandon, 
	sum(abandon_ring) as abandon_ring, 
	sum(totaltalk) as totaltalk, 
	sum(totalhold) as totalhold, 
	avg(avgtalk) as avgtalk, 
    avg(avghold) as avghold, 
	avg(avgqueue) as avgqueue, 
	max(longestq) as longestq, 
	sum(hold) as hold, 
	sla, 
	totalqueue
from call_record_daily
where 
	week(start_stamp) between week($P{start_date}) and week($P{end_date}) 
	and year(start_stamp) between year($P{start_date}) and year($P{end_date}) 
	and $X{IN,dnis_group_id,dnis_group_id} 
    and $X{IN,company_id,company_id}
group by 
	company_id,
	dnis_group_id, 
    week(start_stamp),
    year(start_stamp)
order by 
	company_name,
    dnis_group_name,
    week(start_stamp),
    year(start_stamp)