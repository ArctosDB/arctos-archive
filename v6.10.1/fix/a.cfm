<cfinclude template="/includes/functionLib.cfm">



<cfoutput>


	<cfquery name="x"  datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select label_value d  from media_labels where MEDIA_LABEL='description' and media_id=10451971
	</cfquery>

	<cfset str=x.d>
<p>

#str#

</p>
	<cfloop from="1" to ="#len(str)#" index="i">
		<hr>
		<cfset c=mid(str,i,1)>
		<br>#c#

		<br>#asc(c)#
		<hr>
	</cfloop>
</cfoutput>


