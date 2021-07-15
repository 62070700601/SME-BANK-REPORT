select 
	agent_record_fifteen_minutes.id,
	date(start_stamp) as date_stamp, 
    time(start_stamp) as time_stamp, 
    time_cur, 
    time(start_stamp - interval 15 minute) as time_cur_diff,
    hour_fifteen_minute, 
    start_stamp, 
    user_id, 
    user_name, 
    role_id, 
    role_name, 
    company_id, 
    company_name, 
    time(start_stamp), 
    date(start_stamp) as date_stamp,
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
from agent_record_fifteen_minutes 
	left join fifteen_minutes on binary fifteen_minutes.time_cur = binary time(agent_record_fifteen_minutes.start_stamp)
where start_stamp between $P{start_date_time}  and $P{end_date_time} 
    and $X{IN,company_id,company_id}
    and $X{IN,role_id,role_id}
    and $X{IN,user_id,user_id}
group by 
	company_id,
	role_id,
	user_id,
	start_stamp
order by
	role_id,
	date(start_stamp),
	time_cur,
	company_name