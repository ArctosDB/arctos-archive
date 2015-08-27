<cfoutput>
<cfif not isdefined("collection_object_id")>
    <cfset collection_object_id="">
</cfif>
<cfif not isdefined("transaction_id")>
    <cfset transaction_id="">
</cfif>
<cfif not isdefined("container_id")>
    <cfset container_id="">
</cfif>
<cfif not isdefined("sort")>
    <cfset sort="">
</cfif>
<cfif not isdefined("show_all")>
    <cfset show_all = "false" >
</cfif>
<cfinclude template="/includes/_header.cfm">
<cfinclude template="/Reports/functions/label_functions.cfm">

<cfif #action# is "nothing">
	<cfif isdefined("report") and len(#report#) gt 0>
		<cfquery name="id" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select report_id from cf_report_sql where upper(report_name)='#ucase(report)#'
		</cfquery>
		<cfif id.recordcount is 1 and id.report_id gt 0>
			<cflocation url='report_printer.cfm?action=print&report_id=#id.report_id#&collection_object_id=#collection_object_id#&container_id=#container_id#&transaction_id=#transaction_id#&sort=#sort#'>
		<cfelse>
			<div class="error">
				You tried to call this page with a report name, but that failed.
			</div>
		</cfif>
	</cfif>
	<a href="reporter.cfm" target="_blank">Manage Reports</a><br/>
	<!-- Obtain the list of reports -->
	<cfquery name="e" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	   select * from cf_report_sql where report_name not like 'mcz_loan_%' order by report_name
	</cfquery>
	<!-- Obtain a list of collection codes that this user has access to in the VPD from the VPD_COLLECTION_CDE table -->
	<cfquery name="usersColls" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	    select collection_cde from VPD_COLLECTION_CDE
	</cfquery>
	<cfset collList = []>
	<cfloop query="usersColls">
		<cfset added = ArrayAppend(collList,"#collection_cde#") >
	</cfloop>

	<form name="print" id="print" method="post" action="report_printer.cfm">
	    <input type="hidden" name="action" value="print">
	    <input type="hidden" name="transaction_id" value="#transaction_id#">
	    <input type="hidden" name="container_id" value="#container_id#">
	    <input type="hidden" name="collection_object_id" value="#collection_object_id#">
	    <label for="report_id">Print....</label>
        <table border='0'>
           <tr>
             <td>
		<select name="report_id" id="report_id" size="36">
		   <cfloop query="e">
			   <cfset show = 0 >
			   <!--
			      Take the part of the report name after the double underscore,
			      then explode the collection codes in it on underscores
			   -->
               <cfset repBit = REMatch('__[a-zA-Z_]+$',#report_name#)>
               <cfif NOT ArrayIsEmpty(repBit)>
			   <cfset repList = listToArray(#repBit[1]#,"_",true)>

			   <!--  If the report name includes a collection code in the user's list, then show it. -->
               <cfloop index="element" array="#repList#">
                  <cfloop index="cel" array="#collList#">
                     <cfif cel EQ element >
                        <cfset show = 1 >
                     </cfif>
                  </cfloop>
               </cfloop>
			   </cfif>
               <!-- Show only reports for user's collections, unless showAll is set -->
			   <cfif (#show# EQ 1) || (#show_all# is "true") >
		          <option value="#report_id#">#report_name#</option>
		       </cfif>
		   </cfloop>
		</select>
		    </td>
            <td style='vertical-align: top;'>
		<input type="submit" value="Print Report">
		    </td>
		  </tr>
		</table>
	</form>
    <cfif NOT show_all is "true">
           Only reports relevant to collections you work with are shown<br/>
        <a href='report_printer.cfm?&show_all=true&collection_object_id=#collection_object_id#&container_id=#container_id#&transaction_id=#transaction_id#&sort=#sort#'>Show all Reports</a>
    <cfelse>
        <a href='report_printer.cfm?&show_all=false&collection_object_id=#collection_object_id#&container_id=#container_id#&transaction_id=#transaction_id#&sort=#sort#'>Show just reports for my collections</a>
    </cfif>
</cfif>
<!------------------------------------------------------>
<cfif #action# is "print">
	<cfquery name="e" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	    select * from cf_report_sql where report_id=#report_id#
	</cfquery>
	<cfif len(e.sql_text) gt 0>
                <!--- The query to obtain the report data is in cf_report_sql.sql_text --->
		<cfset sql=e.sql_text>
                <cfif sql contains "##transaction_id##">
			yeppers
			<cfset sql=replace(sql,"##transaction_id##",#transaction_id#,"all")>
		<cfelse>
			noper
		</cfif>
		<cfif sql contains "##collection_object_id##">
			<cfset sql=replace(sql,"##collection_object_id##",#collection_object_id#,"All")>
		</cfif>
		<cfif sql contains "##container_id##">
			<cfset sql=replace(sql,"##container_id##",#container_id#)>
		</cfif>

		<cfif sql contains "##session.CustomOtherIdentifier##">
			<cfset sql=replace(sql,"##session.CustomOtherIdentifier##",#session.CustomOtherIdentifier#,"all")>
		</cfif>
		<cfif sql contains "##session.SpecSrchTab##">
			<cfset sql=replace(sql,"##session.SpecSrchTab##",#session.SpecSrchTab#,"all")>
		</cfif>
		<cfif sql contains "##session.projectReportTable##">
			<cfset sql=replace(sql,"##session.projectReportTable##",#session.projectReportTable#,"all")>
		</cfif>


		<cfif len(#sort#) gt 0 and #sql# does not contain "order by">
                        <cfif #sort# eq "cat_num_pre_int"> 
  			    <cfset ssql=sql & " order by cat_num_prefix, cat_num_integer ">
                        <cfelse>
  			    <cfset ssql=sql & " order by #sort#">
                        </cfif>
		<cfelse>
			<cfset ssql=sql>
		</cfif>
		<hr>#ssql#<hr>
	 	<cftry>
			<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				#preservesinglequotes(ssql)#
			</cfquery>
		<cfcatch>
			<!--- sort can fail here, or below where d is sorted, if they try to sort by things that aren't in the query --->
			<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				#preservesinglequotes(sql)#
			</cfquery>
		</cfcatch>
		</cftry>
    <cfelse>
        <!--- cf_report_sql.sql_text is null --->
        <!--- need something to pass to the function --->
        <cfset d="">
    </cfif>

    <!---  Can call a custom function here to obtain or transform the query --->
    <cfif len(e.pre_function) gt 0>
        <!---  e.sql may be empty and e.pre_function may point to a query from a CustomTag --->
        <!---  The query for loan invoices comes from a CustomTag --->
        <!---  Other reports may have a query in e.sql and have it modified by e.pre_function --->
        <cfset d=evaluate(e.pre_function & "(d)")>
    </cfif>

    <!---  Add the sort if one isn't present (to add a sort to a query from CustomTags --->
    <!---  Supports sort order on loan invoice --->
    <cfif len(#sort#) gt 0 and #d.getMetaData().getExtendedMetaData().sql# does not contain " order by ">
         <cfif #sort# eq "cat_num_pre_int"> 
            <cfset d.sort(d.findColumn("cat_num_prefix"),TRUE)>
            <cfset d.sort(d.findColumn("cat_num_integer"),TRUE)>
         <cfelse>
            <cfset d.sort(d.findColumn(#sort#),TRUE)>
         </cfif>
    </cfif>

    <cfif e.report_format is "pdf">
		<cfset extension="pdf">
    <cfelseif e.report_format is "RTF">
		<cfset extension="rtf">
    <cfelse>
		<cfset extension="rtf">
    </cfif>
    <cfreport format="#e.report_format#"
    	template="#application.webDirectory#/Reports/templates/#e.report_template#"
        query="d"
        overwrite="true"></cfreport>
</cfif>
</cfoutput>
<cfinclude template="/includes/_footer.cfm">
