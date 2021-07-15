select 
	call_record_history.uuid, 
	call_record_history.caller_name, 
    call_record_history.caller_number, 
    call_record_history.dnis_group_id, 
    call_record_history.dnis_group_name, 
    call_record_history.company_id, 
    call_record_history.company_name, 
	call_record_history.start_stamp, 
    call_record_history.answer_stamp, 
    call_record_history.end_stamp, 
    -- agent_record_history.agent_id, agent_record_history.agent_name, agent_record_history.team_id, agent_record_history.team_name,
	-- agent_record_history.start_stamp as ar_start_stamp, agent_record_history.answer_stamp as ar_answer_stamp, agent_record_history.end_stamp as ar_end_stamp, 
	date(call_record_history.start_stamp) as date_stamp, 
    concat(user_role_views.first_name, " ", user_role_views.last_name) as user_name, 
    call_record_history.user_id, 
	call_record_history.types, 
    ifnull(timestampdiff(second,call_record_history.start_stamp,call_record_history.end_stamp),0) as duration, 
    ifnull(timestampdiff(second,call_record_history.start_stamp,call_record_history.answer_stamp),0) as waitting,
    count(if( call_record_history.types = 0 ,1,NULL)) 'sumanswer',
    count(uuid) as sumincoming
from 
	call_record_history -- left join agent_record_history on call_record_history.uuid = agent_record_history.uuid
	left join user_role_views on call_record_history.user_id = user_role_views.id
where 
	call_record_history.start_stamp between $P{start_date_time} and $P{end_date_time} 
    and $X{IN,call_record_history.company_id,company_id} 	
    and $X{IN,call_record_history.dnis_group_id,dnis_group_id} 
    and $X{IN,types,answer_abandon}
group by 
	company_id,
	dnis_group_id, 
	date(call_record_history.start_stamp), 
    call_record_history.uuid
order by 
	company_name, 
	call_record_history.start_stamp, 
	call_record_history.answer_stamp