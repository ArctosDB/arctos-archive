<cfinclude template="/includes/_header.cfm">

create table temp_ala_bcg (
	alacc varchar2(20),
	g1 varchar2(20),
	g2 varchar2(20),
	g3 varchar2(20),
	g4 varchar2(20),
	b1  varchar2(20),
	b2  varchar2(20),
	b3  varchar2(20),
	b4  varchar2(20)
	);
<cfquery name="s" datasource="uam_god">
	select ALAACC from temp_ala group by ALAACC
</cfquery>

<cfoutput>
	<cfloop query="s">
		<cfquery name="d" datasource="uam_god">
			select
			  guid,
			  c.barcode
			from
			  coll_obj_other_id_num,
			  flat,
			  specimen_part,
			  coll_obj_cont_hist,
			  container pc,
			  container c
			where
			  coll_obj_other_id_num.display_value ='#ALAACC#' and
			  coll_obj_other_id_num.other_id_type='ALAAC' and
			  coll_obj_other_id_num.collection_object_id=flat.collection_object_id and
			  flat.collection_object_id=specimen_part.derived_from_cat_item and
			  specimen_part.collection_object_id=COLL_OBJ_CONT_HIST.collection_object_id and
			  COLL_OBJ_CONT_HIST.container_id=pc.container_id and
			  pc.parent_container_id=c.container_id
		</cfquery>
				<cfquery name="u" datasource="uam_god">

		insert into temp_ala_bcg (alacc,g1,g2,g3,g4,b1,b2,b3,b4) values (
			'#ALAACC#',
			'#d.guid[1]#',
			'#d.guid[2]#',
			'#d.guid[3]#',
			'#d.guid[4]#',
			'#d.barcode[1]#',
			'#d.barcode[2]#',
			'#d.barcode[3]#',
			'#d.barcode[4]#')
			</cfquery>
			<p></p>
			
					
		<!----
		
		<cfif d.recordcount gt 2>
		<cfloop from="1" to="4" index="i">
			<cfset x = d.guid[i]>
			
			<cfdump var=#x#>
		</cfloop>
		

			<cfdump var=#d#>
			
			
			#d.recordcount#
		</cfif>
		---->

	</cfloop>
</cfoutput>

	





<cfinclude template="/includes/_footer.cfm">

