<cfinclude template="/includes/_header.cfm">
		<cfquery name="d" datasource="uam_god">
select
	table_name,
	column_name 
from
user_tab_cols
where
(column_name like '%AGENT_ID%' or column_name like '%PERSON_ID%')
and table_name not like '%BULK%' 
and table_name not like 'CF_%' 
and table_name not in (
	'AGENT',
	'ADDR',
	'AGENT_NAME',
	'AGENT_NAME_PENDING_DELETE',
	'AGENT_RANK',
	'AGENT_RELATIONS',
	'ATTRIBUTES20131112',
	'ATTRIBUTES_20120808',
	'COLLECTING_EVENT_OLD',
	'EVERYTHING_LOCALITY',
	'LAT_LONG_OLD',
	'LLM',
	'MLZBACK',
	'NULLCATNUM',
	'SIKESAGENT',
	'SIKESLOAN',
	'USER_DATA',
	'USER_TABLE_ACCESS',
	'UW_BULK',
	'UW_SENT_TO_BULK',
	'VERBATIM_COLLECTOR_AGENT',
	'VERBATIM_COLLECTOR_NAME',
	'WTF',
	'PREFERRED_AGENT_NAME',
	'OLD_AGENTS'
)
</cfquery>
 



<cfdump var=#d#>
<cfoutput>
	<cfloop query="d">
	<hr>
	
	#table_name#.#column_name#

	







				<cfquery name="noperson" datasource="uam_god">
				
select 
    preferred_agent_name.agent_name,
    count(*) c
from 
    preferred_agent_name,
	agent,
	#table_name#
where
	preferred_agent_name.agent_id=agent.agent_id and
	agent.agent_type != 'person' and
	agent.agent_id=#table_name#.#column_name#
group by
	agent_name
order by
	agent_name
				</cfquery>
				<cfloop query="noperson">
					<br>#agent_name# @ #c#
				</cfloop>
<!----
		<cfquery name="a" datasource="uam_god">
			select * from person, agent, agent_name
			where agent.agent_id=agent_name.agent_id and 
			agent.agent_id=person.person_id (+) and
			agent.agent_id=#aid#
		</cfquery>
		<cfdump var=#a#>
		<cfquery name="b" datasource="uam_god">
			select * from person, agent, agent_name
			where agent.agent_id=agent_name.agent_id and 
			agent.agent_id=person.person_id (+) and
			agent.agent_id=#bid#
		</cfquery>
		<cfdump var=#b#>
		---->
	</cfloop>
</cfoutput>
<cfinclude template="/includes/_footer.cfm">

