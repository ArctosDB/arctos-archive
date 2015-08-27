<cfinclude template="/includes/_header.cfm">


<cfoutput>
<cfquery name="d" datasource="uam_god">
 select part_name_1,cat_num,storage from cumv_fish_parts2 where storage is not null and storagerepat is null and rownum<20000 group by part_name_1,cat_num,storage
</cfquery>
<cfloop query="d">
	<hr>#cat_num# - #part_name_1# - ==#storage#
	
	<!---- part_name_2 is null for all fish
	<cfif len(part_name_2) is 0>
		<br>one part no problem
	<cfelse>
		<br>guelley...
	</cfif>
	---->
	<cfquery name="theSpecPart" datasource="uam_god">
		select 
			part_name,
			specimen_part.collection_object_id
		from 
			specimen_part,cataloged_item 
		where
			specimen_part.DERIVED_FROM_cat_item=cataloged_item.collection_object_id and
			collection_id=83 and
			cat_num=trim(#cat_num#) and part_name=trim('#part_name_1#')
	</cfquery>
	<cfif theSpecPart.recordcount is 1>
		<br>yay one part
		<cfset thepart=theSpecPart.collection_object_id>
	<cfelseif theSpecPart.recordcount is 0>
		<br>dammit no match
		<cfset thepart=''>

	<cfelse>
		<br>multiple match can just pick one
		<cfquery name="sds" dbtype="query">
			select min(collection_object_id) as collection_object_id from theSpecPart
		</cfquery>
		<cfset thepart=sds.collection_object_id>
	</cfif>
	<cfif len(thepart) gt 0>
		<cftransaction>
			<cfquery name="ispa" datasource="uam_god">
				insert into specimen_part_attribute (
					PART_ATTRIBUTE_ID,
					COLLECTION_OBJECT_ID,
					ATTRIBUTE_TYPE,
					ATTRIBUTE_VALUE
				) values (
					sq_PART_ATTRIBUTE_ID.nextval,
					#thepart#,
					'location',
					'#storage#'
				)
			</cfquery>
			<cfquery name="donedee" datasource="uam_god">
				update cumv_fish_parts2 set storagerepat=1 where
				part_name_1='#part_name_1#' and cat_num='#cat_num#' and storage='#storage#'
			</cfquery>
		</cftransaction>
	</cfif>
</cfloop>
</cfoutput>
