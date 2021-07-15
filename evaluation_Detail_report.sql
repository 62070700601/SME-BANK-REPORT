select 
	agent_record_history.uuid,
    agent_record_history.caller_number,
    agent_record_history.dnis_group_id,
    agent_record_history.dnis_group_name,
    score.score,
    score.start_stamp,
    agent_record_history.user_id,
    agent_record_history.user_name,
    agent_record_history.role_id,
    agent_record_history.role_name,
    agent_record_history.company_id,
    agent_record_history.company_name,
    st.name_eng,
    st.name_thai
from agent_record_history 
    left join score on agent_record_history.uuid = score.uuid
    left join score_types as st on score.score = st.id
where
	score.uuid is not null
		and score.start_stamp between $P{start_date_time} and $P{end_date_time} 
		and $X{IN,agent_record_history.user_id,user_id}
		and $X{IN,agent_record_history.role_id,role_id}
		and $X{IN,agent_record_history.company_id,company_id}
order by
	agent_record_history.company_name,
    agent_record_history.role_id,
    agent_record_history.user_name,
    score.start_stamp