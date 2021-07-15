select pc.call_id, arh.caller_number, pc.user_id, arh.user_name, arh.dnis_group_name, pc.start_stamp, pc.stop_stamp, arh.role_name, arh.company_name,
users.first_name, users.last_name
from callcenter.phone_consults as pc
left join agent_record_history as arh on pc.uuid = arh.uuid
left join users on pc.user_id = users.id
where pc.uuid is not null 
	and stop_stamp != '0000-00-00 00:00:00'
	and pc.start_stamp between $P{start_date_time} and $P{end_date_time}
	and $X{IN,pc.user_id,user_con}
	and $X{IN,arh.dnis_group_id,dnis_group_id} 
	and $X{IN,arh.role_id,role_id}
	and $X{IN,arh.company_id,company_id}
group by 
	pc.uuid
order by
	arh.user_name