select 
 agent_status_logs.id,
 agent_status_logs.user_id as user_id,
 concat(agent_status_logs.first_name, " ", agent_status_logs.last_name) as user_name,
    agent_status_logs.status as user_status,
    agent_status_logs.reason as user_reason,
    agent_status_logs.status_id as status_id,
    agent_status_logs.start_time as start_stamp,
    agent_status_logs.end_time as end_stamp,
    date(agent_status_logs.start_time) as date_stamp,
    time(agent_status_logs.start_time) as start_time,
    time(agent_status_logs.end_time) as end_time,
    ifnull(timestampdiff(second, agent_status_logs.start_time, agent_status_logs.end_time),0) as duration,
    agent_status_team_logs.role_id as role_id,
    agent_status_team_logs.name as role_name,
    agent_status_team_logs.company_id as company_id,
    agent_status_team_logs.company_name as company_name,
    agent_call_logs.cid_number

from 
 agent_status_logs
 left join (
 SELECT *
 FROM agent_status_team_logs astl
 GROUP BY astl.agent_status_log_id
 ) agent_status_team_logs ON agent_status_logs.id = agent_status_team_logs.agent_status_log_id
 left join agent_call_logs on agent_call_logs.user_id = agent_status_logs.user_id 

where 
 time(agent_status_logs.end_time) is not null 
and agent_status_logs.start_time between $P{start_date_time} and $P{end_date_time} 
and $X{IN,agent_status_team_logs.company_id,company_id}
and $X{IN,agent_status_team_logs.role_id,role_id}
and $X{IN,agent_status_logs.user_id,user_id}
and $X{IN,agent_status_logs.status_id,status_id}
and $X{IN,agent_status_logs.reason,reason}
group by 
 agent_status_logs.user_id, 
 date(agent_call_logs.start_time),
 agent_status_logs.id

order by 
 agent_status_team_logs.company_name, 
 agent_status_team_logs.name, 
 agent_status_logs.first_name, 
 agent_status_logs.start_time, 
 agent_status_logs.end_time,
 agent_status_logs.id