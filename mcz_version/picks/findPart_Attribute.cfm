<cfinclude template="../includes/_pickHeader.cfm">
<cfoutput>
<cfif len(attribute_type) gt 0>
	<cfset search=true>
</cfif>
<form name="s" action="findPart_Attribute.cfm" method="post">
	<br>Attribute_type: <input type="text" name="attribute_type" value="#attribute_type#">
	<br><input type="submit" value="Find Matches">
	<input type="hidden" name="search" value="true">
	
	<input type="hidden" name="partFld2" value="#partFld2#">
</form>
<cfif isdefined("search") and search is "true">
	<!--- make sure we're searching for something --->
	<cfif len(attribute_type) is 0>
		<cfabort>
	</cfif>
	<cfquery name="gpa" datasource="uam_god">
    select a.attribute_type
            from
            specimen_part_attribute a,
            CTSPECPART_ATTRIBUTE_TYPE
            where a.attribute_type=CTSPECPART_ATTRIBUTE_TYPE.attribute_type
            group by A.ATTRIBUTE_TYPE
            order by a.attribute_type
		
	</cfquery>
	<cfif gpa.recordcount is 0>Nothing Found</cfif>
	<cfloop query="gpa">
	<br><a href="##" onClick="javascript: opener.document.getElementById('#partFld2#').value='#attribute_type#';self.close();">#attribute_type#</a>	
	</cfloop>
</cfif>
</cfoutput>
<cfinclude template="../includes/_pickFooter.cfm">