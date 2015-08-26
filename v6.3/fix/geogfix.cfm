<!----
	Try to semi-magic in some obvious fixes

----->
<cfquery name="d" datasource="uam_god">
	select * from geog_auth_rec where state_prov='Puerto Rico' and county like '%Municipio%'
</cfquery>
<cfoutput>

	<cfset tryAgain=",_Puerto_Rico">
	<cfloop query="d">
	
		<cfset urlparam=county>
		<cfset urlparam=replace(urlparam,'Municipio de ','')>
		
		<cfset newcounty=urlparam>
		
		<cfset urlparam=replace(urlparam,' ','_','all')>
		<cfhttp url="http://en.wikipedia.org/wiki/#urlparam#" method="get"></cfhttp>
		
		<cfif left(cfhttp.statuscode,3) is "200">
			<cfif cfhttp.Filecontent contains "may refer to" or cfhttp.Filecontent contains "disambiguation">
				<cfset newurlparam="#urlparam##tryAgain#">
				<cfhttp url="http://en.wikipedia.org/wiki/#newurlparam#" method="get"></cfhttp>
				<cfif  left(cfhttp.statuscode,3) is "200">
					<cfif cfhttp.Filecontent contains "may refer to" or cfhttp.Filecontent contains "disambiguation">
						<hr><a href="http://en.wikipedia.org/wiki/#newurlparam#" target=_"blank">http://en.wikipedia.org/wiki/#newurlparam#</a> is ambiguous
						<br><a href="http://arctos.database.museum/Locality.cfm?Action=editGeog&geog_auth_rec_id=#geog_auth_rec_id#" target="_blank">edit geog</a>
					<cfelse>
						<hr>update geog_auth_rec set county='#newcounty#', source_authority='http://en.wikipedia.org/wiki/#newurlparam#' where geog_auth_rec_id=#geog_auth_rec_id#;
					</cfif>
				</cfif>
			<cfelse>
				<hr>update geog_auth_rec set county='#newcounty#', source_authority='http://en.wikipedia.org/wiki/#urlparam#' where geog_auth_rec_id=#geog_auth_rec_id#;
			</cfif>
		</cfif>
	</cfloop>
</cfoutput>
