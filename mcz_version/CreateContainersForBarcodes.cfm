<cfinclude template = "includes/_header.cfm">
<!---- this is an internal use page and needs a security wrapper --->
<!--- no security --->

<cfif action is "nothing">
<cfoutput>
<cfquery name="ctContainer_Type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select container_type from ctcontainer_type order by container_type
</cfquery>
<cfquery name="ctinstitution_acronym" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select institution_acronym from collection group by institution_acronym order by institution_acronym
</cfquery>
Containers (things that you can stick barcode to) in Arctos must exist (generally as some type of
 label) before they may be used.
<br>
This form allows creation of series of containers. You should use this form if you:
<ul>
	<li>Have placed, will place, and perhaps have considered placing an order for preprinted-labels.</li>
	<li>Have printed or intend to print your own series of labels.</li>
	<li>Wish to reserve a series of labels for any other reason.</li>
</ul>
This form does nothing to labels that already exist. Don't try.
 <p>The barcode label will be {prefix}{number}{suffix}. For example, prefix=' 
      a', number = 1, suffix=' b' will produce barcode ' a1 b'. Make sure you 
      enter <strong>exactly</strong> what the scanner 
      will read, including all spaces!</p>
<form name="form1" method="post" action="CreateContainersForBarcodes.cfm?action=create">
	<label for="institution_acronym">Institution Acronym</label>
    <select name="institution_acronym" id="institution_acronym" class="reqdClr">
		<cfloop query="ctinstitution_acronym">
			<option value="#institution_acronym#">#institution_acronym#</option>
		</cfloop>
	</select> 
	<input type="checkbox" name="cryoBarcode" value="cryoBarcode">Create "PLACE" barcodes for Cryo Collection</input>
    <label for="beginBarcode">Low number in series</label>
    <input type="text" name="beginBarcode" id="beginBarcode">
    <label for="endBarcode">High number in series</label>
   	<input type="text" name="endBarcode" id="endBarcode">
    <label for="prefix">Barcode Prefix (non-numeric leading bit-include spaces if you want them)</label>
   	<input type="text" name="prefix" id="prefix">
    <label for="suffix">Barcode Suffix (non-numeric trailing bit-include spaces if you want them) </label>
   	<input type="text" name="suffix" id="suffix">
	<label for="label_prefix">Label Prefix (non-numeric leading bit-include spaces if you want them)</label>
    <input type="text" name="label_prefix" id="label_prefix">
    <label for="label_suffix">Label Suffix (non-numeric trailing bit-include spaces if you want them)</label>
    <input type="text" name="label_suffix" id="label_suffix">
    <label for="container_type">Container Type</label>
    <select name="container_type" size="1" id="container_type">
        <cfloop query="ctContainer_Type"> 
          <option value="#ctContainer_Type.Container_Type#">#ctContainer_Type.Container_Type#</option>
        </cfloop> 
     </select>
	<label for="remarks">Remarks</label>
    <input type="text" name="remarks" id="remarks">
	<input type="submit" value="Create Series" class="insBtn">	
    </form>
	</cfoutput>
</cfif>
<!----------------------------------------------------------------------------------->

<!----------------------------------------------------------------------------------->
<cfif action is "create">
<cfset num = #endBarcode# - #beginBarcode#>
<cfset barcode = "#beginBarcode#">
<cfoutput>
<cfset num = #num# + 1>
<cftransaction>
<cfif isdefined("cryoBarcode")>
	<cfloop index="index" from="1" to = "#num#">
	<cfset mczbarcode=left(numberFormat(barcode,00000000),4) & "PLACE" & right(numberFormat(barcode,00000000),4)>
	<cfquery name="AddLabels" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		INSERT INTO container (container_id, parent_container_id, container_type, barcode, label, container_remarks,locked_position,institution_acronym)
			VALUES (sq_container_id.nextval, 0, '#container_type#', '#mczbarcode#', '#mczbarcode#','#remarks#',0,'#institution_acronym#')
	</cfquery>
			<cfset num = #num# + 1>
			<cfset barcode = #barcode# + 1>
	</cfloop>	
<cfelse>
	<cfloop index="index" from="1" to = "#num#">
	<cfif #label_prefix# EQ "" and LEN(#prefix#) GT 0> 
		<cfset label_prefix=prefix>
	</cfif>
	<cfif #label_suffix# EQ "" and LEN(#suffix#) GT 0> 
		<cfset label_suffix=suffix>
	</cfif>
	<cfif left(#beginBarcode#,1) EQ "0" and isNumeric(#beginBarcode#)>
		<cfset numberMask=RepeatString("0",len(#beginBarcode#))>
		<cfset barcode=NumberFormat(barcode, numberMask)>
	</cfif>
	<cfquery name="AddLabels" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		INSERT INTO container (container_id, parent_container_id, container_type, barcode, label, container_remarks,locked_position,institution_acronym)
			VALUES (sq_container_id.nextval, 0, '#container_type#', '#prefix##barcode##suffix#', '#label_prefix##barcode##label_suffix#','#remarks#',0,'#institution_acronym#')
	</cfquery>
			<cfset num = #num# + 1>
			<cfset barcode = #barcode# + 1>
	</cfloop>
</cfif>	
</cftransaction>
	<br> The series of barcodes from #beginBarcode# to #endBarcode# have been uploaded.
	
  
	<br>
    <a href="CreateContainersForBarcodes.cfm?action=set">Load more barcodes</a></cfoutput> 
</cfif>

<cfinclude template = "includes/_footer.cfm">