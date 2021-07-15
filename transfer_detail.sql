SELECT 
	transfer_records.uuid,
    call_record_history.caller_number,
    call_record_history.company_name,
	agent_record_history.user_id,
    agent_record_history.user_name,
    agent_record_history.role_id,
    agent_record_history.role_name,
    transfer_records.destination,
    transfer_records.start_stamp
FROM transfer_records
LEFT JOIN call_record_history on transfer_records.uuid = call_record_history.uuid
LEFT JOIN agent_record_history on call_record_history.uuid = agent_record_history.uuid
LEFT JOIN voice_records on agent_record_history.uuid = voice_records.uuid
WHERE
	transfer_records.start_stamp between $P{start_date_time} and $P{end_date_time} 
    and $X{IN,call_record_history.company_id,company_id} 
    and $X{IN, agent_record_history.role_id,role_id}
    and $X{IN,agent_record_history.user_id,user_id} 
ORDER BY transfer_records.start_stamp