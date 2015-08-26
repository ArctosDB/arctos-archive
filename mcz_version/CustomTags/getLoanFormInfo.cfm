<cfoutput>
<cfset transaction_id=caller.transaction_id>
<cfquery name="caller.getLoan" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
    SELECT
	trans_date,
    concattransagent(trans.transaction_id, 'authorized by') authAgentName,
    concattransagent(trans.transaction_id, 'received by')   recAgentName,
    outside_contact.agent_name outside_contact_name,
    inside_contact.agent_name inside_contact_name,
	outside_addr.job_title  outside_contact_title,
	inside_addr.job_title  inside_contact_title,
	get_address(inside_trans_agent.agent_id) inside_address,
	get_address(outside_trans_agent.agent_id) outside_address,
	inside_email.address inside_email_address,
	outside_email.address outside_email_address,
	return_due_date,
	nature_of_material,
	trans_remarks,
	loan_instructions,
	loan_description,
	loan_type,
	loan_number,
	loan_status,
	shipped_date,
	case when  concattransagent(trans.transaction_id, 'received by') !=  outside_contact.agent_name then
		'Attn: ' || outside_contact.agent_name || '<br>' || ship_to_addr.formatted_addr
	else
		ship_to_addr.formatted_addr
	end  shipped_to_address,
	ship_from_addr.formatted_addr  shipped_from_address  ,
	processed_by.agent_name processed_by_name,
	sponsor_name.agent_name project_sponsor_name,
	acknowledgement   
        FROM
                loan,
				trans,
				trans_agent inside_trans_agent,
				trans_agent outside_trans_agent,
				preferred_agent_name outside_contact,
				preferred_agent_name inside_contact,								
				(select * from electronic_address where address_type ='e-mail') inside_email,
				(select * from electronic_address where address_type ='e-mail') outside_email,
				(select * from addr where addr_type='Correspondence') outside_addr,
				(select * from addr where addr_type='Correspondence') inside_addr,
				shipment,
				addr ship_to_addr,
				addr ship_from_addr,
				preferred_agent_name processed_by,
				project_trans,
				project_sponsor,
				agent_name sponsor_name
        WHERE
                loan.transaction_id = trans.transaction_id and
				trans.transaction_id = inside_trans_agent.transaction_id and				
				inside_trans_agent.agent_id = inside_contact.agent_id and
				inside_trans_agent.trans_agent_role='in-house contact' and
				inside_trans_agent.agent_id = inside_email.agent_id (+) and
				inside_trans_agent.agent_id = inside_addr.agent_id (+) and	
				trans.transaction_id = outside_trans_agent.transaction_id and				
				outside_trans_agent.agent_id = outside_contact.agent_id (+) and
				outside_trans_agent.trans_agent_role='outside contact' and
				outside_trans_agent.agent_id = outside_email.agent_id (+) and
				outside_trans_agent.agent_id = outside_addr.agent_id (+) and
				loan.transaction_id = shipment.transaction_id (+) and
				shipment.SHIPPED_TO_ADDR_ID	= ship_to_addr.addr_id (+) and
				shipment.SHIPPED_FROM_ADDR_ID	= ship_from_addr.addr_id (+) and
				shipment.PACKED_BY_AGENT_ID = 	processed_by.agent_id (+) and
				trans.transaction_id = 	project_trans.transaction_id (+) and
				project_trans.project_id =	project_sponsor.project_id (+) and
				project_sponsor.agent_name_id = sponsor_name.agent_name_id (+) and				
				loan.transaction_id=#transaction_id#
		group by
			 	trans_date,
			    concattransagent(trans.transaction_id, 'authorized by'),
			    concattransagent(trans.transaction_id, 'received by')  ,
			    outside_contact.agent_name,
			    inside_contact.agent_name ,
				outside_addr.job_title  ,
				inside_addr.job_title  ,
				get_address(inside_trans_agent.agent_id),
				get_address(outside_trans_agent.agent_id),
				inside_email.address ,
				outside_email.address ,
               return_due_date,
                nature_of_material,
                trans_remarks,
                loan_instructions,
                loan_description,
                loan_type,
                loan_number,
                loan_status,
				shipped_date,
				ship_to_addr.formatted_addr     ,
				ship_from_addr.formatted_addr ,
				processed_by.agent_name ,
				sponsor_name.agent_name,
				acknowledgement            
</cfquery>

<cfquery name="caller.getLoanItems" datasource="user_login"  username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
select 
		cat_num, 
		/*catalog_number_prefix,
		catalog_number,*/
		cataloged_item.collection_object_id,
		collection.collection,
		concatSingleOtherId(cataloged_item.collection_object_id,'#session.CustomOtherIdentifier#') AS CustomID,
		concatattributevalue(cataloged_item.collection_object_id,'sex') as sex,
		decode (sampled_from_obj_id,
			null,part_name,
			part_name || ' sample') part_name,
		 part_modifier,
		 preserve_method,
		 lot_count,
		condition,
		 item_instructions,
		 loan_item_remarks,
		 coll_obj_disposition,
		 scientific_name,
		 Encumbrance,
		 agent_name,
		 loan_number,
		 spec_locality,
		 higher_geog,
		 orig_lat_long_units,
		 lat_deg, 
		 lat_min,
		 lat_sec,
		 long_deg,
		 long_min,
		 long_sec,
		 dec_lat_min,
		 dec_long_min,
		 lat_dir,
		 long_dir,
		 dec_lat,
		 dec_long,
		 max_error_distance,
		 max_error_units,
		 decode(orig_lat_long_units,
				'decimal degrees',to_char(dec_lat) || '&deg; ',
				'deg. min. sec.', to_char(lat_deg) || '&deg; ' || to_char(lat_min) || '&acute; ' || to_char(lat_sec) || '&acute;&acute; ' || lat_dir,
				'degrees dec. minutes', to_char(lat_deg) || '&deg; ' || to_char(dec_lat_min) || '&acute; ' || lat_dir
			)  VerbatimLatitude,
			decode(orig_lat_long_units,
				'decimal degrees',to_char(dec_long) || '&deg;',
				'deg. min. sec.', to_char(long_deg) || '&deg; ' || to_char(long_min) || '&acute; ' || to_char(long_sec) || '&acute;&acute; ' || long_dir,
				'degrees dec. minutes', to_char(long_deg) || '&deg; ' || to_char(dec_long_min) || '&acute; ' || long_dir
			)  VerbatimLongitude
	 from 
		loan_item, 
		loan,
		specimen_part, 
		coll_object,
		cataloged_item,
		coll_object_encumbrance,
		encumbrance,
		agent_name,
		identification,
		collecting_event,
		locality,
		geog_auth_rec,
		accepted_lat_long,
		collection
	WHERE
		loan_item.collection_object_id = specimen_part.collection_object_id AND
		loan.transaction_id = loan_item.transaction_id AND
		specimen_part.derived_from_cat_item = cataloged_item.collection_object_id AND
		specimen_part.collection_object_id = coll_object.collection_object_id AND
		coll_object.collection_object_id = coll_object_encumbrance.collection_object_id (+) and
		coll_object_encumbrance.encumbrance_id = encumbrance.encumbrance_id (+) AND
		encumbrance.encumbering_agent_id = agent_name.agent_id (+) AND
		cataloged_item.collection_object_id = identification.collection_object_id AND
		identification.accepted_id_fg = 1 AND
		cataloged_item.collecting_event_id = collecting_event.collecting_event_id AND
		collecting_event.locality_id = locality.locality_id AND
		locality.geog_auth_rec_id = geog_auth_rec.geog_auth_rec_id AND
		locality.locality_id = accepted_lat_long.locality_id (+) AND
		cataloged_item.collection_id = collection.collection_id AND
	  loan_item.transaction_id = #transaction_id#
	  /*ORDER BY catalog_number_prefix, catalog_number*/
</cfquery>

<cfquery name="caller.getLoanMCZ" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
      SELECT
				to_char(trans_date, 'dd-Mon-yyyy') as trans_date,
			    concattransagent(trans.transaction_id, 'authorized by') authAgentName,
			    concattransagent(trans.transaction_id, 'received by')   recAgentName,
			    outside_contact.agent_name outside_contact_name,
			    inside_contact.agent_name inside_contact_name,
				outside_addr.job_title  outside_contact_title,
				inside_addr.job_title  inside_contact_title,
				get_address(inside_trans_agent.agent_id) inside_address,
				get_address(outside_trans_agent.agent_id) outside_address,
				inside_email.address inside_email_address,
				outside_email.address outside_email_address,
				inside_phone.address inside_phone_number,
               	return_due_date,
                replace(nature_of_material,'&','&amp;') nature_of_material,
                replace(trans_remarks,'&','&amp;') trans_remarks,
                replace(replace(loan_instructions,'&','&amp;'), chr(32)||chr(28) ,'"') loan_instructions,
                replace(loan_description,'&','&amp;') loan_description,
                loan_type,
                loan_number,
                loan_status,
				shipped_date,
				shipped_carrier_method,
				ship_to_addr.formatted_addr  shipped_to_address   ,
				ship_from_addr.formatted_addr  shipped_from_address  ,
				processed_by.agent_name processed_by_name,
				sponsor_name.agent_name project_sponsor_name,
				acknowledgement,
				Decode(substr(loan_number, instr(loan_number, '-',1, 2)+1),  
				'Herp', 'Herpetology Collection',
				'Mamm', 'Mammalogy Collection',
				'IZ', 'Invertebrate Zoology (incl. Marine Invertebrates) Collection',
				'Mala', 'Malacology Collection',
				'VP','Vertebrate Paleontology Collection',
				'SC','Special Collections',
				'MCZ','MCZ Collections',
				'IP','Invertebrate Paleontology Collection',
				'Ich','Ichthyology Collection',
				'Orn','Ornithology Collection',
				'Cryo','Cryogenic Collection',
				'Ent','Entomology Collection',
				'[Unable to identify collection from loan number]' || substr(loan_number, instr(loan_number, '-',1, 2)+1) 
				) as collection,
				num_specimens, num_lots
        FROM
                loan,
				trans,
				loan_counts,
				trans_agent inside_trans_agent,
				trans_agent outside_trans_agent,
				preferred_agent_name outside_contact,
				preferred_agent_name inside_contact,								
				(select * from electronic_address where address_type ='email') inside_email,
				(select * from electronic_address where address_type ='email') outside_email,
				(select * from electronic_address where address_type ='work phone number') inside_phone,
				(select * from addr where addr_type='Correspondence') outside_addr,
				(select * from addr where addr_type='Correspondence') inside_addr,
				shipment,
				addr ship_to_addr,
				addr ship_from_addr,
				preferred_agent_name processed_by,
				project_trans,
				project_sponsor,
				agent_name sponsor_name
        WHERE
                loan.transaction_id = trans.transaction_id and
				loan.transaction_id = loan_counts.transaction_id (+) and
				trans.transaction_id = inside_trans_agent.transaction_id and				
				inside_trans_agent.agent_id = inside_contact.agent_id and
				inside_trans_agent.trans_agent_role='in-house contact' and
				inside_trans_agent.agent_id = inside_email.agent_id (+) and
				inside_trans_agent.agent_id = inside_addr.agent_id (+) and
				inside_trans_agent.agent_id = inside_phone.agent_id (+) and
				trans.transaction_id = outside_trans_agent.transaction_id and				
				outside_trans_agent.agent_id = outside_contact.agent_id (+) and
				outside_trans_agent.trans_agent_role='outside contact' and
				outside_trans_agent.agent_id = outside_email.agent_id (+) and
				outside_trans_agent.agent_id = outside_addr.agent_id (+) and
				loan.transaction_id = shipment.transaction_id (+) and
				shipment.SHIPPED_TO_ADDR_ID	= ship_to_addr.addr_id (+) and
				shipment.SHIPPED_FROM_ADDR_ID	= ship_from_addr.addr_id (+) and
				shipment.PACKED_BY_AGENT_ID = 	processed_by.agent_id (+) and
				trans.transaction_id = 	project_trans.transaction_id (+) and
				project_trans.project_id =	project_sponsor.project_id (+) and
				project_sponsor.agent_name_id = sponsor_name.agent_name_id (+) and				
				loan.transaction_id=#transaction_id#
		group by
			 	trans_date,
			    concattransagent(trans.transaction_id, 'authorized by'),
			    concattransagent(trans.transaction_id, 'received by')  ,
			    outside_contact.agent_name,
			    inside_contact.agent_name ,
				outside_addr.job_title  ,
				inside_addr.job_title  ,
				get_address(inside_trans_agent.agent_id),
				get_address(outside_trans_agent.agent_id),
				inside_email.address ,
				outside_email.address ,
				inside_phone.address,
                return_due_date,
                nature_of_material,
                trans_remarks,
                loan_instructions,
                loan_description,
                loan_type,
                loan_number,
                loan_status,
				shipped_date,
				shipped_carrier_method,
				ship_to_addr.formatted_addr     ,
				ship_from_addr.formatted_addr ,
				processed_by.agent_name ,
				sponsor_name.agent_name,
				acknowledgement, 
				num_lots, 
				num_specimens            
</cfquery>

<cfquery name="caller.getLoanItemsMCZ" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
select 
		cat_num, 
                MCZBASE.GET_TYPESTATUS(cataloged_item.collection_object_id) as type_status,
		cataloged_item.cat_num_prefix,
		/*   catalog_number,*/
                cat_num_integer,
		cataloged_item.collection_object_id,
                decode(
                   collection.collection,
                   'Invertebrate Zoology',
                   'Invertebrate Zoology (incl. Marine Inverts.)',
                   collection.collection)
                AS collection,
		concatSingleOtherId(cataloged_item.collection_object_id,'#session.CustomOtherIdentifier#') AS CustomID,
		concatattributevalue(cataloged_item.collection_object_id,'sex') as sex,
		decode (sampled_from_obj_id,
			null,part_name,
			part_name || ' sample') part_name,
		 part_modifier,
		 preserve_method,
		 lot_count,
		condition,
		 item_instructions,
		 loan_item_remarks,
		 coll_obj_disposition,
		 scientific_name,
		 Encumbrance,
		 agent_name,
		 loan_number,
                 concattransagent(loan.transaction_id, 'received by')  recAgentName,
		 spec_locality,
		 higher_geog,
                 GET_CHRONOSTRATIGRAPHY(locality.locality_id) chronostrat,
                 GET_LITHOSTRATIGRAPHY(locality.locality_id) lithostrat,
		 orig_lat_long_units,
		 lat_deg, 
		 lat_min,
		 lat_sec,
		 long_deg,
		 long_min,
		 long_sec,
		 dec_lat_min,
		 dec_long_min,
		 lat_dir,
		 long_dir,
		 dec_lat,
		 dec_long,
		 max_error_distance,
		 max_error_units,
		 decode(orig_lat_long_units,
				'decimal degrees',to_char(dec_lat) || '&deg; ',
				'deg. min. sec.', to_char(lat_deg) || '&deg; ' || to_char(lat_min) || '&acute; ' || to_char(lat_sec) || '&acute;&acute; ' || lat_dir,
				'degrees dec. minutes', to_char(lat_deg) || '&deg; ' || to_char(dec_lat_min) || '&acute; ' || lat_dir
			)  VerbatimLatitude,
			decode(orig_lat_long_units,
				'decimal degrees',to_char(dec_long) || '&deg;',
				'deg. min. sec.', to_char(long_deg) || '&deg; ' || to_char(long_min) || '&acute; ' || to_char(long_sec) || '&acute;&acute; ' || long_dir,
				'degrees dec. minutes', to_char(long_deg) || '&deg; ' || to_char(dec_long_min) || '&acute; ' || long_dir
			)  VerbatimLongitude,
		concatColl(cataloged_item.collection_object_id) as collectors
	 from 
		loan_item, 
		loan,
		specimen_part, 
		coll_object,
		cataloged_item,
		coll_object_encumbrance,
		encumbrance,
		agent_name,
		identification,
		collecting_event,
		locality,
		geog_auth_rec,
		accepted_lat_long,
		collection
	WHERE
		loan_item.collection_object_id = specimen_part.collection_object_id AND
		loan.transaction_id = loan_item.transaction_id AND
		specimen_part.derived_from_cat_item = cataloged_item.collection_object_id AND
		specimen_part.collection_object_id = coll_object.collection_object_id AND
		coll_object.collection_object_id = coll_object_encumbrance.collection_object_id (+) and
		coll_object_encumbrance.encumbrance_id = encumbrance.encumbrance_id (+) AND
		encumbrance.encumbering_agent_id = agent_name.agent_id (+) AND
		cataloged_item.collection_object_id = identification.collection_object_id AND
		identification.accepted_id_fg = 1 AND
		cataloged_item.collecting_event_id = collecting_event.collecting_event_id AND
		collecting_event.locality_id = locality.locality_id AND
		locality.geog_auth_rec_id = geog_auth_rec.geog_auth_rec_id AND
		locality.locality_id = accepted_lat_long.locality_id (+) AND
		cataloged_item.collection_id = collection.collection_id AND
	  loan_item.transaction_id = #transaction_id#
</cfquery>
	  <!--- /*ORDER BY catalog_number_prefix, catalog_number*/ --->
</cfoutput>
