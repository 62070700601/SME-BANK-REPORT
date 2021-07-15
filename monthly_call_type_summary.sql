select 
	month(start_stamp) as month_stamp, 
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
from call_record_monthly
where 
	month(start_stamp) between $P{start_month} and $P{end_month} 
	and year(start_stamp) = $P{start_year} 
	and $X{IN,dnis_group_id,dnis_group_id} 
    and $X{IN,company_id,company_id}
group by 
	company_id,
	dnis_group_id, 
    month(start_stamp),
    year(start_stamp)
order by 
	company_name,
    dnis_group_name,
    month(start_stamp),
    year(start_stamp)