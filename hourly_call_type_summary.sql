select 
	date(start_stamp) as date_stamp, 
	hour(start_stamp) as hour_stamp, 
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
from call_record_hourly
where 
	start_stamp between $P{start_date_time} and $P{end_date_time} 
	and $X{IN,dnis_group_id,dnis_group_id} 
    and $X{IN,company_id,company_id}
group by 
	company_id,
	dnis_group_id, 
    date(start_stamp),
    hour(start_stamp)
order by 
	company_name,
    dnis_group_name,
    date(start_stamp),
    hour(start_stamp)