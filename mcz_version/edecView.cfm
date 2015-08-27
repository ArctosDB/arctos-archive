<cfcontent type="text/plain; charset=utf-8"><cfif len(session.roles) gt 0 and session.roles is not "public"><cfobject type="Java" class="edu.harvard.mcz.edec.mczbase.EDecBuilder" name="builder"><cfquery name="loanAgents" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
                select
                        agent_name,
                        trans_agent_role
                from
                        trans_agent left join
                        preferred_agent_name on trans_agent.agent_id = preferred_agent_name.agent_id
                where
                        trans_agent_role = 'received by' and
                        trans_agent.transaction_id=#transaction_id#
                order by
                        trans_agent_role,
                        agent_name
</cfquery><cfquery name="loanSpecies" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
     select
		 scientific_name,
		 country,
		 sum(lot_count)
	 from 
		loan_item, 
		loan,
		specimen_part, 
		coll_object,
		cataloged_item,
		identification,
		collecting_event,
		locality,
		geog_auth_rec
	WHERE
		loan_item.collection_object_id = specimen_part.collection_object_id AND
		loan.transaction_id = loan_item.transaction_id AND
		specimen_part.derived_from_cat_item = cataloged_item.collection_object_id AND
		specimen_part.collection_object_id = coll_object.collection_object_id AND
		cataloged_item.collection_object_id = identification.collection_object_id AND
		identification.accepted_id_fg = 1 AND
		cataloged_item.collecting_event_id = collecting_event.collecting_event_id AND
		collecting_event.locality_id = locality.locality_id AND
		locality.geog_auth_rec_id = geog_auth_rec.geog_auth_rec_id AND
	  	loan_item.transaction_id = #transaction_id#
	group by scientific_name, country
	ORDER BY scientific_name, country
</cfquery><cfset res = builder.init(#loanAgents#,#loanSpecies#)><cfset returnVal = builder.getEDecFile()><cfoutput>#returnVal#</cfoutput></cfif>
