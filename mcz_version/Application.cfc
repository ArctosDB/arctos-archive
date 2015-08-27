<cfcomponent>

	<cfset This.name = "Arctos" />
	<cfset This.SessionManagement="True" />
	<cfset This.ClientManagement="true" />
	<cfset This.ClientStorage="Cookie" />

	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true" />
		<!---
			<cfscript>
			getPageContext().forward("/errors/404.cfm");
			</cfscript
			--->
		<cfinclude template="/errors/404.cfm">
		<cfabort />
	</cffunction>

	<cffunction name="onError">
		<cfargument name="exception" required="true" />
		<cfargument name="EventName" type="String" required="true" />
		<cfset showErr=1 />
		<cfif isdefined("exception.type") and exception.type eq "coldfusion.runtime.AbortException">
                         <cfif  Application.serverRootUrl contains "-test">
                                <cfset showErr=1 />
                        <cfelse>
                                <cfset showErr=0 />
                        </cfif>

			<cfreturn />
		</cfif>
		<cfif StructKeyExists(form,"C0-METHODNAME")>
			<!--- cfajax calling cfabort --->
                         <cfif  Application.serverRootUrl contains "-test">
                                <cfset showErr=1 />
                        <cfelse>
                                <cfset showErr=0 />
                        </cfif>

			<cfreturn />
		</cfif>
		<cfif showErr is 1>
			<cfsavecontent variable="errortext">
				<CFIF isdefined("CGI.HTTP_X_Forwarded_For") and len(CGI.HTTP_X_Forwarded_For) gt 0>
					<CFSET ipaddress=CGI.HTTP_X_Forwarded_For />
				<CFELSEif  isdefined("CGI.Remote_Addr") and len(CGI.Remote_Addr) gt 0>
					<CFSET ipaddress=CGI.Remote_Addr />
				<cfelse>
					<cfset ipaddress='unknown' />
				</CFIF>
				<cfoutput>
					<p>
						ipaddress:
						<a href="http://network-tools.com/default.asp?prog=network&host=#ipaddress#">#ipaddress#</a>
					</p>
					(
					<a href="http://arctos.database.museum/Admin/blacklist.cfm?action=ins&ip=#ipaddress#">blacklist</a>
					)
					<cfif isdefined("session.username")>
						<br>
						Username: #session.username#
					</cfif>
					<cfif isdefined("exception.Sql")>
						<p>Sql: #exception.Sql#</p>
					</cfif>
				</cfoutput>
				<hr>
				Exceptions:
				<hr>
				<cfdump var="#exception#" label="exception" />
				<hr>
				<cfif isdefined("session")>
					Session Dump:
					<hr>
					<cfdump var="#session#" label="session" />
				</cfif>
				Client Dump:
				<hr>
				<cfdump var="#client#" label="client" />
				<hr>
				Form Dump:
				<hr>
				<cfdump var="#form#" label="form" />
				<hr>
				URL Dump:
				<hr>
				<cfdump var="#url#" label="url" />
				CGI Dump:
				<hr>
				<cfdump var="#CGI#" label="CGI" />
			</cfsavecontent>

			<cfif  Application.serverRootUrl contains "arctos.database.museum">
				<cfif isdefined("session.username") and
				(
				#session.username# is "fselm10" or
				#session.username# is "brandy" or
				#session.username# is "dlm" or
				#session.username# is "sumy" or
				#session.username# is "Rhiannon" or
				#session.username# is "dusty"
				)>
				<cfoutput>#errortext#</cfoutput>
				</cfif>
			<cfelseif  Application.serverRootUrl contains "harvard.edu">
				<cfif isdefined("session.username") and
				(
				#session.username# is "mkennedy" or
				#session.username# is "mole" or
				#session.username# is "heliumcell"
				)>
				<cfoutput>#errortext#</cfoutput>
				</cfif>
			</cfif>
			<!---cfoutput>#errortext#</cfoutput--->
			<cfif isdefined("exception.errorCode") and exception.errorCode is "403">
				<cfset subject="locked form" />
			<cfelse>
				<cfif isdefined("exception.detail")>
					<cfif exception.detail contains "[Macromedia][Oracle JDBC Driver][Oracle]ORA-00600">
						<cfset subject="[Macromedia][Oracle JDBC Driver][Oracle]ORA-00600" />
					<cfelse>
						<cfset subject="#exception.detail#" />
					</cfif>
				<cfelse>
					<cfset subject="Unknown Error" />
				</cfif>
			</cfif>
			<!---cfmail subject="Error" to="#Application.PageProblemEmail#" from="SomethingBroke@#Application.fromEmail#" type="html">
				#subject# #errortext#
			</cfmail--->
			<table cellpadding="10">
				<tr>
					<td valign="top"><img src="/images/blowup.gif"></td>
					<td>
						<font color="##FF0000" size="+1">
							<strong>An error occurred while processing this page!</strong>
						</font>
						<cfif isdefined("exception.message")>
							<br>
							<i>
								<cfoutput>
									#exception.message#
									<cfif isdefined("exception.detail")>
										<br>
										#exception.detail#
									</cfif>
								</cfoutput>
							</i>
						</cfif>
						<p>
							This message has been logged. Please select
							<a href="/info/bugs.cfm">“Feedback/Report Errors”</a>
							below to submit a bug report and include the error message above and any other info that might help us to resolve this problem.
						</p>
					</td>
				</tr>
			</table>
			<cfinclude template="/includes/_footer.cfm">
		</cfif>
		<cfreturn />
	</cffunction>

	<!-------------------------->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
			serverName = CreateObject("java", "java.net.InetAddress").getLocalHost().getHostName();
		</cfscript>
		<cfif serverName is "web.arctos.database.museum">
			<cfset serverName="arctos.database.museum" />
		</cfif>
		<cfset Application.session_timeout=90 />
		<cfset Application.serverRootUrl = "http://#serverName#" />
		<cfset Application.user_login="user_login" />
		<cfset Application.max_pw_age = 90 />
		<cfset Application.fromEmail = "#serverName#" />
		<!--- Default header/style apperance --->
		<cfset Application.header_color = "##E7E7E7" />
		<cfset Application.header_image = "/images/genericHeaderIcon.gif" />
		<cfset Application.collection_url = "/" />
		<cfset Application.collection_link_text = "Arctos" />
		<cfset Application.institution_url = "/" />
		<cfset Application.stylesheet = "" />
		<cfset Application.institution_link_text = "Multi-Institution, Multi-Collection Museum Database" />
		<cfset Application.meta_description = "Arctos is a biological specimen database." />
		<cfset Application.meta_keywords = "museum, collection, management, system" />
		<cfset Application.gmap_api_key = "not set" />
		<cfset Application.Google_uacct = "not set" />
		<cfset Application.domain = replace(Application.serverRootUrl,"http://",".") />
		<cfquery name="d" datasource="uam_god">
			select ip from blacklist
		</cfquery>
		<cfset Application.blacklist=valuelist(d.ip) />
		<cfif serverName is "arctos.database.museum">
			<cfset application.gmap_api_key="ABQIAAAAO1U4FM_13uDJoVwN--7J3xRmuGmxQ-gdo7TWENOfdvPP48uvgxS1Mi5095Z-7DsupXP1SWQjdYKK_w" />
			<cfset Application.svn = "/usr/local/bin/svn" />
			<cfset Application.webDirectory = "/usr/local/apache2/htdocs" />
			<cfset Application.DownloadPath = Application.webDirectory & "/download/" />
			<cfset Application.bugReportEmail = "arctos.database@gmail.com,gordon.jarrell@gmail.com" />
			<cfset Application.technicalEmail = "arctos.database@gmail.com,gordon.jarrell@gmail.com" />
			<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif" />
			<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html" />
			<cfset Application.genBankPrid = "3849" />
			<cfset Application.genBankUsername="uam" />
			<cfset Application.convertPath = "/usr/local/bin/convert" />
			<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank") />
			<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml" />
			<cfset Application.Google_uacct = "UA-315170-1" />
			<cfset Application.InstitutionBlurb = "" />
			<cfset Application.DataProblemReportEmail = "arctos.database@gmail.com" />
			<cfset Application.PageProblemEmail = "arctos.database@gmail.com" />
		<cfelseif serverName is "arctos-test.arctos.database.museum">
			<cfset application.gmap_api_key="ABQIAAAAO1U4FM_13uDJoVwN--7J3xRt-ckefprmtgR9Zt3ibJoGF3oycxTHoy83TEZbPAjL1PURjC9X2BvFYg" />
			<cfset Application.svn = "/usr/local/bin/svn" />
			<cfset Application.webDirectory = "/usr/local/apache2/htdocs" />
			<cfset Application.DownloadPath = "#Application.webDirectory#/download/" />
			<cfset Application.bugReportEmail = "arctos.database@gmail.com" />
			<cfset Application.technicalEmail = "arctos.database@gmail.com" />
			<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif" />
			<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html" />
			<cfset Application.genBankPrid = "3849" />
			<cfset Application.genBankUsername="uam" />
			<cfset Application.convertPath = "/usr/local/bin/convert" />
			<cfset Application.genBankPwd=encrypt("bU7$f%Nu","genbank") />
			<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml" />
			<cfset Application.Google_uacct = "UA-315170-1" />
			<cfset Application.InstitutionBlurb = "" />
			<cfset Application.DataProblemReportEmail = "arctos.database@gmail.com" />
			<cfset Application.PageProblemEmail = "arctos.database@gmail.com" />
		<cfelseif serverName contains "harvard.edu">
		    <cfif serverName contains "-test">
			    <cfset Application.header_color = "##E1E815" />
			    <cfset Application.collection_link_text = "MCZ</span><span class=""headerCollectionTextSmall"">BASE-TEST</span><span class=""headerCollectionText"">:The Database of the Zoological Collections" />
			    <cfset Application.header_image = "/images/mcz_krono_logo.png" />
			 <cfelse>
			    <cfset Application.header_color = "##DD3300" />
			    <cfset Application.collection_link_text = "MCZ</span><span class=""headerCollectionTextSmall"">BASE</span><span class=""headerCollectionText"">:The Database of the Zoological Collections" />
			    <cfset Application.header_image = "/images/krono.gif" />
			</cfif>
			<cfset Application.collection_url = "http://www.mcz.harvard.edu" />
			<cfset Application.institution_url = "http://www.mcz.harvard.edu" />
			<cfset Application.institution_link_text = "Museum of Comparative Zoology - Harvard University" />
			<cfset Application.svn = "/usr/bin/svn" />
			<cfset Application.webDirectory = "/var/www/html/arctos" />
			<cfset Application.SpecimenDownloadPath = "/var/www/html/arctos/download/" />
			<cfset Application.DownloadPath = "/var/www/html/arctos/download/" />
			<cfset Application.bugzillaToEmail = "bugzilla@software.rc.fas.harvard.edu" />
			<cfset Application.bugzillaFromEmail = "bugreport@software.rc.fas.harvard.edu" />
			<cfset Application.bugReportEmail = "bhaley@oeb.harvard.edu" />
			<cfset Application.technicalEmail = "bhaley@oeb.harvard.edu" />
			<cfset Application.mapHeaderUrl = "#Application.serverRootUrl#/images/nada.gif" />
			<cfset Application.mapFooterUrl = "#Application.serverRootUrl#/bnhmMaps/BerkMapFooter.html" />
			<cfset Application.genBankPrid = "" />
			<cfset Application.genBankUsername="" />
			<cfset Application.convertPath = "/usr/bin/convert" />
			<cfset Application.genBankPwd=encrypt("Uln1OAzy","genbank") />
			<cfset Application.BerkeleyMapperConfigFile = "/bnhmMaps/UamConfig.xml" />

			<cfset application.gmap_api_key="ABQIAAAAHisocVs5fMekC3rHMYIDKBTD_7kRmvD2VFEz2q7Rf-1F9aZhDRR0G1NEMbSCz8uzq65R3GoapoMRKg">
			<cfset Application.Google_uacct = "UA-11397952-1" />
			<cfset Application.InstitutionBlurb = "Collections Database, Museum of Comparative Zoology, Harvard University" />
			<cfset Application.DataProblemReportEmail = "bhaley@oeb.harvard.edu" />
			<cfset Application.PageProblemEmail = "bhaley@oeb.harvard.edu" />
			<cfset Application.stylesheet = "mcz_style.css" />
		</cfif>
		<cfreturn true />
	</cffunction>

	<!-------------------------------------------------------------->

	<cffunction name="onSessionStart" output="false"><cfinclude template="/includes/functionLib.cfm">
		<cfset initSession() /></cffunction>
	<!-------------------------------------------------------------->

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<!--- uncomment for a break from googlebot ---->
		<!----
			<cfif cgi.HTTP_USER_AGENT contains "bot" or cgi.HTTP_USER_AGENT contains "slurp" or cgi.HTTP_USER_AGENT contains "spider">
			<cfheader statuscode="503" statustext="Service Temporarily Unavailable"/>
			<cfheader name="retry-after" value="3600"/>
			Down for maintenance
			<cfreturn false>
			<cfabort>
			</cfif>
			---->
		<cfif not isdefined("application.blacklist")>
			<cfset application.blacklist="" />
		</cfif>
		<cfif listfindnocase(application.blacklist,cgi.REMOTE_ADDR)>
			<cfif cgi.script_name is not "/errors/gtfo.cfm">
				<cfscript>getPageContext().forward("/errors/gtfo.cfm");</cfscript>
				<cfabort />
			</cfif>
		</cfif>
		<cfparam name="request.fixAmp" type="boolean" default="false">
		<cfif (NOT request.fixAmp) AND (findNoCase("&amp;", cgi.query_string ) gt 0)>
			<cfscript>
				request.fixAmp = true;
				queryString = replace(cgi.query_string, "&amp;", "&", "all");
				getPageContext().forward(cgi.script_Name & "?" & queryString);
			</cfscript>
			<cfabort />
		<cfelse>
			<cfscript>StructDelete(request, "fixAmp");</cfscript>
		</cfif>
		<cfif not isdefined("session.roles")>
			<cfinclude template="/includes/functionLib.cfm">
			<cfset initSession() />
		</cfif>
		<cfset currentPath=GetDirectoryFromPath(GetTemplatePath()) />
		<cfif currentPath contains "/CustomTags/" OR
			currentPath contains "/binary_stuff/" OR
			currentPath contains "/log/">
			<cfset r=replace(currentPath,application.webDirectory,"") />
			<cflocation url="/errors/forbidden.cfm?ref=#r#" addtoken="false">
		</cfif>
		<!--- protect "us" directories --->
		<cfif (CGI.Remote_Addr is not "127.0.0.1") and
			(not isdefined("session.roles") or session.roles is "public" or len(session.roles) is 0) and
			(currentPath contains "/Admin/" or
			currentPath contains "/ALA_Imaging/" or
			currentPath contains "/Bulkloader/" or
			currentPath contains "/fix/" or
			currentPath contains "/picks/" or
			currentPath contains "/tools/" or
			currentPath contains "/ScheduledTasks/")>
			<cfset r=replace(#currentPath#,#application.webDirectory#,"") />
			<cfscript>getPageContext().forward("/errors/forbidden.cfm");</cfscript>
			<cfabort />
		</cfif>
		<cfif cgi.HTTP_HOST is "arctos-test.arctos.database.museum" and
			#GetTemplatePath()# does not contain "/errors/dev_login.cfm" and
			#GetTemplatePath()# does not contain "/login.cfm" and
			#GetTemplatePath()# does not contain "/ChangePassword.cfm" and
			#GetTemplatePath()# does not contain "/contact.cfm" and
			len(session.username) is 0>
			<cflocation url="/errors/dev_login.cfm">
		<cfelseif cgi.HTTP_HOST is "mvzarctos.berkeley.edu">
			<cfset rurl="http://arctos.database.museum" />
			<cfif isdefined("cgi.redirect_url") and len(cgi.redirect_url) gt 0>
				<cfset rurl=rurl & cgi.redirect_url />
			<cfelseif isdefined("cgi.script_name") and len(cgi.script_name) gt 0>
				<cfif cgi.script_name is "/SpecimenSearch.cfm">
					<cfset rurl=rurl & "/mvz_all" />
				<cfelse>
					<cfset rurl=rurl & cgi.script_name />
				</cfif>
			</cfif>
			<cfif len(cgi.query_string) gt 0>
				<cfset rurl=rurl & "?" & cgi.query_string />
			</cfif>
			<cfheader statuscode="301" statustext="Moved permanently">
			<cfoutput><cfheader name="Location" value="#rurl#"></cfoutput>
		</cfif>
		<cfreturn true />
	</cffunction>

</cfcomponent>
