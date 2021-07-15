select
	agent_record_history.user_id as a_user_id,
    agent_record_history.user_name as a_user_name,
    agent_record_history.caller_name as a_caller_name,
    agent_record_history.caller_number as a_caller_number,
    agent_record_history.start_stamp as a_start_stamp,
    agent_record_history.types as types,
	agent_record_history.uuid as uuid,
	agent_record_history.company_id as company_id,
    agent_record_history.company_name as company_name,
    agent_record_history.dnis_group_id as dnis_group_id,
    agent_record_history.dnis_group_name as dnis_group_name,
	agent_record_history.role_id as role_id,
    agent_record_history.role_name as role_name
from agent_record_history
where agent_record_history.types = 1
	 and $X{IN,agent_record_history.company_id,company_id} 
 	and $X{IN,agent_record_history.role_id,role_id} 
 	and $X{IN,agent_record_history.user_id,user_id} 
 	and $X{IN,agent_record_history.dnis_group_id,dnis_group_id} 
 	and agent_record_history.start_stamp between $P{start_date_time} and $P{end_date_time} 
group by agent_record_history.company_id, agent_record_history.role_id, agent_record_history.dnis_group_id, agent_record_history.user_id, agent_record_history.id
order by agent_record_history.company_name, agent_record_history.role_name, agent_record_history.start_stamp