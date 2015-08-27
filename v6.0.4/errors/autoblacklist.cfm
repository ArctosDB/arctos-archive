	<cftry>
		<cfquery name="d" datasource="uam_god">
			insert into uam.blacklist (ip) values ('#trim(request.ipaddress)#')
		</cfquery>
		<cfset application.blacklist=listappend(application.blacklist,trim(request.ipaddress))>
	
		inserted and added to app BL.....
		
		<cf_logError subject="autoblacklist">
		<cfinclude template="/errors/gtfo.cfm">
		<script>
			try{document.getElementById('loading').style.display='none';}catch(e){}
		</script>
		<cfabort>
		<cfcatch>
			<cfif cfcatch.message is not "[Macromedia][Oracle JDBC Driver][Oracle]ORA-00001: unique constraint (UAM.IU_BLACKLIST_IP) violated">
				<cfmail subject="Autoblacklist Fail" to="#Application.PageProblemEmail#" from="blfail@#application.fromEmail#" type="html">
					Auto-blacklisting failed.
					<br>			
					A user found a dead link! The referring site was #cgi.HTTP_REFERER#.
					<cfif isdefined("CGI.script_name")>
						<br>The missing page is #Replace(CGI.script_name, "/", "")#
					</cfif>
					<cfif isdefined("cgi.REDIRECT_URL")>
						<br>cgi.REDIRECT_URL: #cgi.REDIRECT_URL#
					</cfif>
					<cfif isdefined("session.username")>
						<br>The username is #session.username#
					</cfif>
					<br>The IP requesting the dead link was <a href="http://network-tools.com/default.asp?prog=network&host=#request.ipaddress#">#request.ipaddress#</a>
					 - <a href="http://arctos.database.museum/Admin/blacklist.cfm?action=ins&ip=#request.ipaddress#">blacklist</a>
					<br>This message was generated by #cgi.CF_TEMPLATE_PATH#.
					<hr><cfdump var="#cgi#">
					<hr>catch dump
					<cfdump var=#cfcatch#>
				</cfmail>
			</cfif>
		</cfcatch>
	</cftry>
		