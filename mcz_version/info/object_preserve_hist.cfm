<cfinclude template="/includes/_pickHeader.cfm">
<cfoutput>
<!---- see what we're getting a condition of ---->
<cfquery name="itemDetails" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select
		'cataloged item' part_name,
		cat_num,
		collection.collection,
		scientific_name
	FROM
		cataloged_item,
		collection,
		identification
	WHERE
		cataloged_item.collection_object_id = identification.collection_object_id AND
		accepted_id_fg=1 AND
		cataloged_item.collection_id = collection.collection_id AND
		cataloged_item.collection_object_id = #collection_object_id#
	UNION
	select
			part_name,
			cat_num,
			collection.collection,
			scientific_name
		FROM
			cataloged_item,
			collection,
			identification,
			specimen_part
		WHERE
			cataloged_item.collection_object_id = identification.collection_object_id AND
			accepted_id_fg=1 AND
			cataloged_item.collection_id = collection.collection_id AND
			cataloged_item.collection_object_id = specimen_part.derived_from_cat_item AND
			specimen_part.collection_object_id = #collection_object_id#
</cfquery>

<strong>Preservation History of #itemDetails.collection# #itemDetails.cat_num#
(<i>#itemDetails.scientific_name#</i>) #itemDetails.part_name#</strong>
<cfquery name="pres" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select
		SPECIMEN_PART_PRES_HIST_ID,
		CHANGED_AGENT_ID,
		agent_name,
		CHANGED_DATE,
		preserve_method,
		part_name,
		coll_object_remarks,
		is_current_fg
	from SPECIMEN_PART_PRES_HIST,preferred_agent_name
		where CHANGED_AGENT_ID = agent_id(+) and
		collection_object_id = #collection_object_id#
		group by
		SPECIMEN_PART_PRES_HIST_ID,
		CHANGED_AGENT_ID,
		agent_name,
		 CHANGED_DATE,
		 preserve_method,
		 part_name,
		 coll_object_remarks,
		 is_current_fg
		order by CHANGED_DATE DESC
</cfquery>




<table border>
	<tr>
		<td><strong>Changed By</strong></td>
		<td><strong>Date</strong></td>
		<td><strong>Part Name</strong></td>
		<td><strong>Preserve Method</strong></td>
		<td><strong>Remarks</strong></td>
	</tr>

	<cfloop query="pres">
		<tr>
			<td>
				#agent_name#
			</td>
			<td>
				<cfset thisDate = #dateformat(CHANGED_DATE,"yyyy-mm-dd")#>
				#thisDate#
			</td>
			<td>
				#part_name#
			</td>
			<td>
				#preserve_method#
			</td>
			<td>
				#coll_object_remarks#
			</td>
		</tr>
	</cfloop>
</table>
</cfoutput>
<cfinclude template="/includes/_pickFooter.cfm">