<cfinclude template="/includes/_header.cfm">

<cfoutput>


<cffile action="read" file="/usr/local/httpd/htdocs/wwwarctos/log/querylog.txt">

<cfdump var=#cffile#>


	
</cfoutput>
