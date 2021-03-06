<cfcomponent>
<cfset This.name = "Arctos">
<cfset This.SessionManagement=true>
<cfset This.ClientManagement=false>
<cffunction name="onError">
	<cfargument name="Exception" required=true/>
	<cfargument type="String" name="EventName" required=true/>
	<cfset showErr=1>
    <cfif isdefined("exception.type") and exception.type eq "coldfusion.runtime.AbortException">
        <cfset showErr=0>
		<cfreturn/>
	</cfif>
	<cfif StructKeyExists(form,"C0-METHODNAME")>
		<cfset showErr=0>
		<cfreturn/>
	</cfif>
	<cfif isdefined("session.username") and session.username is "dlm">
		<cfdump var=#exception#>
	</cfif>
		
	
	<cfif showErr is 1>
		<cfset subject="">
		<!--- it's a real error --->
		<!--- get rid of hack attempts etc first ---->
		<cfif isdefined("exception.Sql") and exception.sql contains "@@version">
			<cflocation url="/errors/autoblacklist.cfm">
			<cfreturn/>
		</cfif>
		<cfif isdefined("exception.errorCode") and exception.errorCode is "403">
			<cfif cgi.HTTP_USER_AGENT contains "slurp">
				<!--- friggin yahoo ignoring robots.txt - buh-bye, biatchez.... --->
				<cfinclude template="/errors/autoblacklist.cfm">
				<cfabort>
			</cfif>
			<cfif cgi.REQUEST_METHOD is "OPTIONS">
				<!--- MS crazy hundreds of requests thing.... --->
				<cfinclude template="/errors/autoblacklist.cfm">
				<cfabort>
			</cfif>
			
			
			<cfset subject="403">
		<cfelse>
			<cfif isdefined("exception.detail")>
				<cfif exception.detail contains "[Macromedia][Oracle JDBC Driver][Oracle]ORA-00600">
					<cfset subject="ORA-00600">
				<cfelse>
					<cfset subject="#exception.detail#">
				</cfif>
			</cfif>
		</cfif>
		<cfset subject=replace(subject,'[Macromedia][Oracle JDBC Driver][Oracle]','','all')>
		
		<cfif subject is "ORA-00933: SQL command not properly ended">
			<!--- see if it's the viagra ad asshats again ---->
			<cfif isdefined("exception.sql") and exception.sql contains 'href="http://'>
				<cfinclude template="/errors/autoblacklist.cfm">
				<cfabort>
			</cfif>
		</cfif>
		
		<cfif subject is "ORA-00907: missing right parenthesis">
			<!--- see if it's the sql injection asshats ---->
			<cfif isdefined("exception.sql") and exception.sql contains '1%'>
				<cfinclude template="/errors/autoblacklist.cfm">
				<cfabort>
			</cfif>
		</cfif>
		<cfif isdefined("cgi.HTTP_ACCEPT_ENCODING") and cgi.HTTP_ACCEPT_ENCODING is "identity">
			<cfinclude template="/errors/autoblacklist.cfm">
			<cfabort>
		</cfif>
		<cfif right(request.rdurl,5) is "-1%27">
			<cfinclude template="/errors/autoblacklist.cfm">
			<cfabort>
		</cfif>
		<cfif left(request.rdurl,6) is "/��#chr(166)#m&">
			<cfinclude template="/errors/autoblacklist.cfm">
			<cfabort>
		</cfif>
		 
	
		<cf_logError subject="#subject#" attributeCollection=#exception#>
		<table cellpadding="10">
			<tr>
				<td valign="top">
					<img src="/images/blowup.gif">
				</td>
				<td>
    				<font color="##FF0000" size="+1"><strong>An error occurred while processing this page!</strong></font>
					<cfif isdefined("exception.message")>
						<br><i><cfoutput>#exception.message#
						<cfif isdefined("exception.detail")>
							<br>#exception.detail#
						</cfif>
						</cfoutput></i>
					</cfif>
					<p>This message has been logged. Please <a href="/contact.cfm">contact us</a>
					with any information that might help us to resolve this problem.</p>
				</td>
			</tr>
		</table>
		<cfinclude template="/includes/_footer.cfm">
		<cfif isdefined("exception.errorCode")>
			<cfif exception.errorCode is "403">
				<cfheader statuscode="403" statustext="Forbidden">
				<cfabort>
			</cfif>
		</cfif>
	</cfif>
	<cfreturn/>
</cffunction>
<!-------------------------->
<cffunction name="onApplicationStart" returnType="boolean" output="true">
	<cfscript>
		serverName = CreateObject("java", "java.net.InetAddress").getLocalHost().getHostName();
	</cfscript>
	<cfif serverName is "altai.corral.tacc.utexas.edu">
		<cfset serverName='login.corral.tacc.utexas.edu'>
	<cfelseif serverName is 'meta-1.corral.tacc.utexas.edu'>
		<cfset serverName='arctos.database.museum'>
	<cfelseif serverName is 'arctos-test'>
		<cfset serverName='arctos-test.tacc.utexas.edu'>
	<cfelseif serverName is 'arctos.tacc.utexas.edu'>
		<cfset serverName='arctos.database.museum'>
	</cfif>
	<!---
	<cfmail subject="server startingt" to="arctos.database@gmail.com" from="serverStart@arctos.database.museum" type="html">
		<cfoutput>#serverName# is starting</cfoutput>
	</cfmail>
	---->
	<cfset Application.session_timeout=90>
	<cfset Application.serverRootUrl = "http://#serverName#">
	<cfset Application.user_login="user_login">
	<cfset Application.max_pw_age = 180>
	<cfset Application.fromEmail = "#serverName#">
	<cfset Application.domain = replace(Application.serverRootUrl,"http://",".")>
	<cfset Application.StartupServerName=serverName>
	<cfif serverName is "arctos.database.museum">
		<cfset application.gmap_api_key="AIzaSyCcu8ZKOhPYjFVfi7M1B9XQuQni_dzesTw">
		<cfset Application.webDirectory = "/usr/local/httpd/htdocs/wwwarctos">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "arctos.database@gmail.com">
		<cfset Application.technicalEmail = "arctos.database@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "arctos.database@gmail.com">
		<cfset Application.PageProblemEmail = "arctos.database@gmail.com">
		<cfset Application.AppVersion= "prod">



		<!----
		<cfset Application.serverRootUrl="http://arctos.database.museum">
		<cfset Application.fromEmail="arctos.database.museum">
		<cfset application.gmap_api_key="AIzaSyA7u0Kb5JlhHlkdgsTmG0zYtg1LXxpn8HY">
		<cfset Application.webDirectory = "/corral/tg/uaf/arctos_prod">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "arctos.database@gmail.com,gordon.jarrell@gmail.com">
		<cfset Application.technicalEmail = "arctos.database@gmail.com,gordon.jarrell@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "arctos.database@gmail.com">
		<cfset Application.PageProblemEmail = "arctos.database@gmail.com">

		---->
    <cfelseif serverName contains "harvard.edu">
		<cfset Application.svn = "/usr/bin/svn">
		<cfset Application.webDirectory = "/var/www/html/arctosv.2.2.2">
		<cfset Application.SpecimenDownloadPath = "/var/www/html/arctosv.2.2.2/download/">
		<cfset Application.bugReportEmail = "bhaley@oeb.harvard.edu">
		<cfset Application.technicalEmail = "bhaley@oeb.harvard.edu">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "">
		<cfset Application.genBankUsername="">
		<cfset Application.convertPath = "/usr/bin/convert">
		<cfset Application.genBankPwd=encrypt("Uln1OAzy","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "">
		<cfset Application.InstitutionBlurb = "Collections Database, Museum of Comparative Zoology, Harvard University">
		<cfset Application.DataProblemReportEmail = "bhaley@oeb.harvard.edu">
		<cfset Application.PageProblemEmail = "bhaley@oeb.harvard.edu">
    <cfelseif serverName is "login.corral.tacc.utexas.edu">
		<cfset application.gmap_api_key="AIzaSyCcu8ZKOhPYjFVfi7M1B9XQuQni_dzesTw">
		<cfset Application.webDirectory = "/corral/tg/uaf/wwwarctos">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "dustymc@gmail.com">
		<cfset Application.technicalEmail = "dustymc@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "dustymc@gmail.com">
		<cfset Application.PageProblemEmail = "dustymc@gmail.com">
	<cfelseif serverName is  "arctos-test.tacc.utexas.edu">
		<cfset application.gmap_api_key="AIzaSyCcu8ZKOhPYjFVfi7M1B9XQuQni_dzesTw">
		<cfset Application.webDirectory = "/usr/local/httpd/htdocs/wwwarctos">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "dustymc@gmail.com">
		<cfset Application.technicalEmail = "dustymc@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "dustymc@gmail.com">
		<cfset Application.PageProblemEmail = "dustymc@gmail.com">
		<cfset Application.AppVersion= "thisone">
	<cfelseif serverName is  "arctos.tacc.utexas.edu">
		<cfset application.gmap_api_key="AIzaSyCcu8ZKOhPYjFVfi7M1B9XQuQni_dzesTw">
		<cfset Application.webDirectory = "/usr/local/httpd/htdocs/wwwarctos">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "dustymc@gmail.com">
		<cfset Application.technicalEmail = "dustymc@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "dustymc@gmail.com">
		<cfset Application.PageProblemEmail = "dustymc@gmail.com">
		<cfset Application.AppVersion= "preprod">
	<cfelse>
		<cfset application.gmap_api_key="AIzaSyCcu8ZKOhPYjFVfi7M1B9XQuQni_dzesTw">
		<cfset Application.webDirectory = "/corral/tg/uaf/wwwarctos">
		<cfset Application.DownloadPath = "#Application.webDirectory#/download/">
		<cfset Application.bugReportEmail = "dustymc@gmail.com">
		<cfset Application.technicalEmail = "dustymc@gmail.com">
		<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif">
		<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html">
		<cfset Application.genBankPrid = "3849">
		<cfset Application.genBankUsername="uam">
		<cfset Application.convertPath = "/usr/local/bin/convert">
		<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank")>
		<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml">
		<cfset Application.Google_uacct = "UA-315170-1">
		<cfset Application.InstitutionBlurb = "">
		<cfset Application.DataProblemReportEmail = "dustymc@gmail.com">
		<cfset Application.PageProblemEmail = "dustymc@gmail.com">


		<cfmail subject="bad app start" to="arctos.database@gmail.com" from="badAppStart@#application.fromEmail#" type="html">
			Idon't know who I am
			serverName=<cfdump var="#serverName#">
			<cfdump var=#cgi# label="cgi">
		</cfmail>
	</cfif>
	
	
	<cftry>
		<cfquery name="d" datasource="uam_god">
			select ip from uam.blacklist
		</cfquery>
		<cfset Application.blacklist=valuelist(d.ip)>
		<cfquery name="sn" datasource="uam_god">
			select subnet from uam.blacklist_subnet
		</cfquery>
		<cfset application.subnet_blacklist=valuelist(sn.subnet)>
	<cfcatch>
		<cfset Application.blacklist="">
		<cfset Application.subnet_blacklist="">
		<cfmail subject="bad app start" to="#Application.PageProblemEmail#" from="badAppStart@#application.fromEmail#" type="html">
			caught DB connect exception
			<cfdump var=#servername#>
			<cfdump var=#cfcatch#>
			<cfdump var="#variables#" label="variables">
			<cfdump var=#application# label="application">
			<cfdump var=#cgi# label="cgi">
		</cfmail>
	</cfcatch>
	</cftry>
	<!---
		sandbox is a 700-mode directory (necessary for CF to write) used for user-uploaded files.
		onRequestStart prevents CF executing contents
	--->
	<cfset Application.sandbox = "#Application.webDirectory#/sandbox">
	<cfif not directoryExists(Application.sandbox)>
		<cfdirectory action="create" directory="#Application.sandbox#" mode="700">
	</cfif>
	<!--- just some disk swap space --->
	<cfif not directoryExists("#Application.webDirectory#/temp")>
		<cfdirectory action="create" directory="#Application.webDirectory#/temp" mode="744">
	</cfif>
	<!--- longer-lived temp, primarily for KML file cache --->
	<cfif not directoryExists("#Application.webDirectory#/cache")>
		<cfdirectory action="create" directory="#Application.webDirectory#/cache" mode="744">
	</cfif>
	<!--- user-demand downloads go here --->
	<cfif not directoryExists("#Application.webDirectory#/download")>
		<cfdirectory action="create" directory="#Application.webDirectory#/download" mode="744">
	</cfif>
	
	<cfif not FileExists("#Application.webDirectory#/log/log.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/log.txt" output=""> 
	</cfif>
	<cfif not FileExists("#Application.webDirectory#/log/404log.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/404log.txt" output=""> 
	</cfif>
	<cfif not FileExists("#Application.webDirectory#/log/missingGUIDlog.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/missingGUIDlog.txt" output=""> 
	</cfif>
	
	<cfif not FileExists("#Application.webDirectory#/log/blacklistlog.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/blacklistlog.txt" output=""> 
	</cfif>
	<cfif not FileExists("#Application.webDirectory#/log/emaillog.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/emaillog.txt" output=""> 
	</cfif>
	
	<cfif not FileExists("#Application.webDirectory#/log/request.txt")> 
	    <cffile action="write" file="#Application.webDirectory#/log/request.txt" output=""> 
	</cfif>
	
	
	<cfreturn true>
</cffunction>
<!-------------------------------------------------------------->
<cffunction name="onSessionStart" output="true">
	<cfinclude template="/includes/functionLib.cfm">
	<cfset initSession()>
</cffunction>
<!-------------------------------------------------------------->
<cffunction name="onRequestStart" returnType="boolean" output="true">
	<cfif cgi.HTTP_HOST contains "altai.corral.tacc.utexas.edu">
		<cfheader statuscode="301" statustext="Moved permanently">
		<cfheader name="Location" value="http://login.corral.tacc.utexas.edu/">
		<cfabort>
	<cfelseif cgi.HTTP_HOST contains "meta-1.corral.tacc.utexas.edu">
		<cfheader statuscode="301" statustext="Moved permanently">
		<cfheader name="Location" value="http://arctos.database.museum/">
		<cfabort>
	<cfelseif cgi.HTTP_HOST contains "web.arctos.database.museum">
		<cfheader statuscode="301" statustext="Moved permanently">
		<cfheader name="Location" value="http://arctos.database.museum/">
		<cfabort>
	<cfelseif cgi.HTTP_HOST contains "arctos.tacc.utexas.edu">
		<cfheader statuscode="301" statustext="Moved permanently">
		<cfheader name="Location" value="http://arctos.database.museum/">
	</cfif>
	<cfset request.rdurl=replacenocase(cgi.query_string,"path=","","all")>
	<cfif cgi.script_name is not "/errors/missing.cfm">
		<cfset request.rdurl=cgi.script_name & "?" & request.rdurl>
	</cfif>
	<cfset request.rdurl=replace("/" & request.rdurl,"//","/","all")>
	<cfif right(request.rdurl,1) is "?">
		<cfset request.rdurl=left(request.rdurl,len(request.rdurl)-1)>
	</cfif>
	<cfif request.rdurl contains chr(195) & chr(151)>
		<cfset request.rdurl=replace(request.rdurl,chr(195) & chr(151),chr(215))>
	</cfif>
	
	<!--- a unique identifier to tie "short" log entries to the raw dump file ---->
	
	<cfset request.uuid=CreateUUID()>
	
	<!--- uncomment for a break from googlebot

	<cfif cgi.HTTP_USER_AGENT contains "bot" or cgi.HTTP_USER_AGENT contains "slurp" or cgi.HTTP_USER_AGENT contains "spider">
		<cfheader statuscode="503" statustext="Service Temporarily Unavailable"/>
		<cfheader name="retry-after" value="3600"/>
		Down for maintenance
		<cfreturn false>
		<cfabort>
	</cfif>

	---->
	<cfif not isdefined("application.blacklist")>
		<cfset application.blacklist="">
	</cfif>
	<cfif not isdefined("application.subnet_blacklist")>
		<cfset application.subnet_blacklist="">
	</cfif>
	<CFIF isdefined("CGI.HTTP_X_Forwarded_For") and len(CGI.HTTP_X_Forwarded_For) gt 0>
		<CFSET request.ipaddress=CGI.HTTP_X_Forwarded_For>
	<CFELSEif  isdefined("CGI.Remote_Addr") and len(CGI.Remote_Addr) gt 0>
		<CFSET request.ipaddress=CGI.Remote_Addr>
	<cfelse>
		<cfset request.ipaddress=''>
	</CFIF>
	<cfif request.ipaddress contains ",">
		<cfset ip1=listgetat(request.ipaddress,1,",")>
		<cfif ip1 contains "172." or ip1 contains "192." or ip1 contains "10." or ip1 is "127.0.0.1">
			<cfset request.ipaddress=listgetat(request.ipaddress,2,",")>
		<cfelse>
			<cfset request.ipaddress=listgetat(request.ipaddress,1,",")>
		</cfif>
	</cfif>
	
	<!----
		
		The blacklist list is out of control, so this adds the ability to block entire subnets at the CF level.
		
		This also serves as a backup of firewall blocking.
		
	---->
	<cfif listlen(request.ipaddress,".") is 4>
		<cfset requestingSubnet=listgetat(request.ipaddress,1,".") & "." & listgetat(request.ipaddress,2,".")>
	<cfelse>
		<cfset requestingSubnet="0.0.0.0">
	</cfif>
	<cfif listfind(application.subnet_blacklist,requestingSubnet)>
		<cfif replace(cgi.script_name,'//','/','all') is not "/errors/gtfo.cfm">
			<cfscript>
				getPageContext().forward("/errors/gtfo.cfm");
			</cfscript>
			<cfabort>
		</cfif>
	</cfif>
	
	<cfif listfind(application.blacklist,request.ipaddress)>
		<cfif replace(cgi.script_name,'//','/','all') is not "/errors/gtfo.cfm">
			<cfscript>
				getPageContext().forward("/errors/gtfo.cfm");
			</cfscript>
			<cfabort>
		</cfif>
	</cfif>
	<cfset nono="passwd,proc">
	<cfloop list="#cgi.query_string#" delimiters="./," index="i">
		<cfif listfindnocase(nono,i)>
			<cfinclude template="/errors/autoblacklist.cfm">
			<cfabort>
		</cfif>
	</cfloop>
	<cfparam name="request.fixAmp" type="boolean" default="false">
	<cfif (NOT request.fixAmp) AND (findNoCase("&amp;", cgi.query_string ) gt 0)>
		<cfscript>
			request.fixAmp = true;
			queryString = replace(cgi.query_string, "&amp;", "&", "all");
			getPageContext().forward(cgi.script_Name & "?" & queryString);
		</cfscript>
		<cfabort>
	<cfelse>
		<cfscript>
			StructDelete(request, "fixAmp");
		</cfscript>
	</cfif>
	<cfif not isdefined("session.roles")>
		<cfinclude template="/includes/functionLib.cfm">
		<cfset initSession()>
	</cfif>
	<cfset currentPath=GetDirectoryFromPath(GetTemplatePath())>
	<!--- no reason for anyone to be in these, ever --->
	<cfif currentPath contains "/CustomTags/">
		<cfset r=replace(currentPath,application.webDirectory,"")>
		<cfscript>
			getPageContext().forward("/errors/forbidden.cfm?ref=#r#");
		</cfscript>
		<cfabort>
	</cfif>
	<!--- protect "us" directories	 --->
	<cfif (CGI.Remote_Addr is not "127.0.0.1") and
		(not isdefined("session.roles") or session.roles is "public" or len(session.roles) is 0) and
		(currentPath contains "/Admin/" or
		currentPath contains "/ALA_Imaging/" or
		currentPath contains "/Bulkloader/" or
		currentPath contains "/fix/" or
		currentPath contains "/picks/" or
		currentPath contains "/tools/" or
		currentPath contains "/ScheduledTasks/")>
			<cfset r=replace(currentPath,application.webDirectory,"")>
			<cfscript>
				getPageContext().forward("/errors/forbidden.cfm?ref=#r#");
			</cfscript>
			<cfabort>
	</cfif>
	<!--- disallow CF execution --->
	<cfif currentPath contains "/images/" or
		 currentPath contains "/download/" or
		 currentPath contains "/cache/" or
		 currentPath contains "/temp/" or
		 currentPath contains "/sandbox/">
		<cfset r=replace(currentPath,application.webDirectory,"")>
		<cfscript>
			getPageContext().forward("/errors/forbidden.cfm?ref=#r#");
		</cfscript>
		<cfabort>
	</cfif>
	<!--- keep people/bots from browsing a dev server
		--->
	<cfif cgi.HTTP_HOST is "login.corral.tacc.utexas.edu" or cgi.HTTP_HOST is "arctos-test.tacc.utexas.edu">
		<cfset cPath=GetTemplatePath()>
		<cfif
			cPath does not contain "/errors/dev_login.cfm" and
			cPath does not contain "/login.cfm" and
			cPath does not contain "/ChangePassword.cfm" and
			cPath does not contain "/contact.cfm" and
			cPath does not contain "/dumpAll.cfm" and
			cPath does not contain "/get_short_doc.cfm" and
			len(session.username) is 0>
			<cflocation url="/errors/dev_login.cfm">
		</cfif>
	</cfif>
	<!--- people still have this thing bookmarked --->
	<cfif cgi.HTTP_HOST is "mvzarctos.berkeley.edu">
		<cfset rurl="http://arctos.database.museum">
		<cfif isdefined("cgi.redirect_url") and len(cgi.redirect_url) gt 0>
			<cfset rurl=rurl & cgi.redirect_url>
		<cfelseif isdefined("cgi.script_name") and len(cgi.script_name) gt 0>
			<cfif cgi.script_name is "/SpecimenSearch.cfm">
				<cfset rurl=rurl & "/mvz_all">
			<cfelse>
				<cfset rurl=rurl & cgi.script_name>
			</cfif>
		</cfif>
		<cfif len(cgi.query_string) gt 0>
			<cfset rurl=rurl & "?" & cgi.query_string>
		</cfif>
		<cfheader statuscode="301" statustext="Moved permanently">
		<cfoutput><cfheader name="Location" value="#rurl#"></cfoutput>
	</cfif>
	<cfif listlast(cgi.script_name,".") is "cfm">
		<cfset loginfo="#dateformat(now(),'yyyy-mm-dd')#T#TimeFormat(now(), 'HH:mm:ss')#||#session.username#||#request.ipaddress#||#request.rdurl#||#request.uuid#">
		<cffile action="append" file="#Application.webDirectory#/log/request.txt" output="#loginfo#">
	</cfif>
	<cfreturn true>
</cffunction>
</cfcomponent>