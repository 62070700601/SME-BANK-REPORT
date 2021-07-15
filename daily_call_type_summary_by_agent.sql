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
from agent_record_daily
where 
	start_stamp between $P{start_date_time} and $P{end_date_time} 
    and $X{IN,user_id,user_id}
    and $X{IN,dnis_group_id,dnis_group_id} 
    and $X{IN,role_id,role_id}
	and $X{IN,company_id,company_id}
group by
   -- แบบแยกชื่อ
	user_id, role_id ,company_id, date(start_stamp)
  -- แบบไม่แยกชื่อ
	-- dnis_group_name,user_name,date(start_stamp)
  -- user_name,dnis_group_name,dnis_group_id,date(start_stamp)
	/*user_id,
	role_id,
	company_id,
	id*/
order by
   -- company_name, dnis_group_name, role_name,user_name, date(start_stamp)
	-- user_name, dnis_group_name, role_name, date(start_stamp)
   -- dnis_group_name,user_name,date(start_stamp)
   user_name,dnis_group_name,role_name,company_name,date(start_stamp)
	/*user_name,
	dnis_group_name,
	role_name,
	company_name,
	start_stamp*/