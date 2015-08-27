<cfinclude template="/includes/_header.cfm">
<cfset title="Agent Merge">
<cfif #action# is "nothing">

<!--- first, make VERY SURE this is doing what we want it to - make users read the list before pushing the button! ---->

<cfquery name="bads" datasource="uam_god">
	select 
		agent_relations.agent_id,
		badname.agent_name bad_name,
		related_agent_id,
		goodname.agent_name good_name,
		to_char(date_to_merge, 'YYYY-MM-DD') merge_date,
		DECODE(on_hold, 1, 'X', '') on_hold, 
		held_by held_by
	from
		agent_relations,
		preferred_agent_name badname,
		preferred_agent_name goodname		
	where 
		agent_relationship = 'bad duplicate of'
		AND agent_relations.agent_id = badname.agent_id and
		agent_relations.related_agent_id = goodname.agent_id
	order by date_to_merge desc
</cfquery>
<form name="go" method="post" action="agentMergeReview.cfm">
<table border>
	<tr>
		<td>Bad Name</td>
		<td>Good Name</td>
		<td>Hold</td>
		<td>Date to be Merged</td>
		<td>On Hold</td>
        <td>Held By</td>
	</tr>
	<cfoutput>
		<cfloop query="bads">
			<tr>
				<td>
					<a href="/agents.cfm?agent_id=#bads.agent_id#" target="_blank">#bad_name#</a>
				</td>
				<td>
					<a href="/agents.cfm?agent_id=#bads.related_agent_id#" target="_blank">#good_name#</a>
				</td>
				<td>
					<input type=checkbox name=holdMerge value=#agent_id#_#related_agent_id#></input>
				</td>
				<td>
					#merge_date#
				</td>
				<td align=center>
					<strong>#on_hold#</strong>
				</td>
                <td>#held_by#</td>
			</tr>
		</cfloop>
	</cfoutput>
	<input type="hidden" name="action" value="doIt">
	<input type="submit" 
					 	value="Put on Hold" 
						class="savBtn"
   						onmouseover="this.className='savBtn btnhov'" 
						onmouseout="this.className='savBtn'">
</table>
</form>
<!--->Before you even THINK about pushing this button, read through the list above, look at the individual 
agent records for anything that's even a little bit ambiguous, then do it again. You will be changing 
agent IDs in a big pile-O-tables; make sure you really want to first!
<form name="go" method="post" action="killBadAgentDups.cfm">
	<input type="hidden" name="action" value="doIt">
	<input type="submit" 
					 	value="Make the Changes" 
						class="savBtn"
   						onmouseover="this.className='savBtn btnhov'" 
						onmouseout="this.className='savBtn'">
</form--->
</cfif>

<!-------------------------hold agents on submit--->

<cfif #action# is "doIt">
	<cfparam name="form.holdMerge" default="" />
	<cfloop list="#form.holdMerge#" index="i">
		<cftransaction>
			<cfquery name="upOnHold" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				update agent_relations set on_hold = 1, held_by = '#session.dbuser#' where
				agent_id = #ListGetAt(i, 1, '_')# and
				related_agent_id = #ListGetAt(i, 2, '_')# and
				agent_relationship = 'bad duplicate of'
			</cfquery>
		</cftransaction>
	</cfloop>
	<cflocation url="agentMergeReview.cfm">
</cfif>


<cfinclude template = "/includes/_footer.cfm">