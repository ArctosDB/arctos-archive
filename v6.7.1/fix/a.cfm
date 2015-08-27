<cfinclude template="/includes/_header.cfm">
<cfoutput>	
	<cfquery name="o" datasource="uam_god">
		select * from temp_eh_u_ids order by upper(scientific_name)
	</cfquery>
</cfoutput>


