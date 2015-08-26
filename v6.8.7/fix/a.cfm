<cfoutput>
            <cfquery name="d" datasource="uam_god">
select distinct OTHERCOLLECTORS from temp_ala_othercolls
			</cfquery>


<cfloop query="d">
	<p>
		#OTHERCOLLECTORS#

		<cfset tname=replace(OTHERCOLLECTORS,' and ',', ','all')>

        <cfset tname=replace(tname,', Jr.',' Jr.','all')>




		<br>tname: #tname#
		<cfset p=2>

		<cfloop list="#tname#" index="i" delimiters=",&">
			<cfquery name="dup" datasource="uam_god">
			update temp_ala_othercolls set collector_agent_#p#='#trim(i)#' where OTHERCOLLECTORS='#OTHERCOLLECTORS#'
			</cfquery>
			<cfset p=p+1>
		  <br>---#i#
		</cfloop>
	</p>
</cfloop>
</cfoutput>