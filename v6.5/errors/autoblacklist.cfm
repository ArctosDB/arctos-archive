	<cftry>
		<cfif trim(request.ipaddress) is "127.0.0.1">
			<cfthrow message = "Local IP cannot be blacklisted" errorCode = "127001">
			<cfabort>
		</cfif>
		
		<cfoutput>
		<cfquery name="exists" datasource="uam_god">
			select ip from uam.blacklist where ip='#trim(request.ipaddress)#'
		</cfquery>
		<cfif len(exists.ip) gt 0>
			<cfquery name="d" datasource="uam_god">
				update uam.blacklist set LISTDATE=sysdate where ip='#trim(request.ipaddress)#'
			</cfquery>
			
			update uam.blacklist set LISTDATE=sysdate where ip='#trim(request.ipaddress)#'
		<cfelse>
			<cfquery name="d" datasource="uam_god">
				insert into uam.blacklist (ip) values ('#trim(request.ipaddress)#')
			</cfquery>
			
			
				insert into uam.blacklist (ip) values ('#trim(request.ipaddress)#')
		</cfif>
		
		<cfset application.blacklist=listappend(application.blacklist,trim(request.ipaddress))>
	
		inserted and added to app BL.....
		
		
		
		</cfoutput>
		
		
		
		<cf_logError subject="autoblacklist">
		<cfinclude template="/errors/gtfo.cfm">
		<script>
			try{document.getElementById('loading').style.display='none';}catch(e){}
		</script>
		<cfabort>
		<cfcatch>
		
		
			<cfdump var=#cfcatch#>
			
			
			<cfif cfcatch.message is not "[Macromedia][Oracle JDBC Driver][Oracle]ORA-00001: unique constraint (UAM.IU_BLACKLIST_IP) violated">
				<cfmail subject="Autoblacklist Fail" to="#Application.bugReportEmail#" from="blfail@#application.fromEmail#" type="html">
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
		