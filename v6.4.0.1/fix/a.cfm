<cfinclude template="/includes/_header.cfm">
<cfoutput>
<cfif action is "nothing">
<cfquery name="d" datasource="uam_god">
	select * from eh_place where shouldbe is null order by place
</cfquery>

<cfset rnum=1>
<cfloop query="d">
<cfset qp=replace(place,';',',','all')>
<cfset qp=replace(qp,'?',' ','all')>
<cfset qp=replace(qp,'/',' ','all')>
<cfset qp=replace(qp,'  ',' ','all')>
<cfset qp=trim(qp)>
<cfquery name="sp" datasource="uam_god">
	select higher_geog from geog_auth_rec where 
		upper(country) like '#ucase(trim(qp))#' and state_prov is null and quad is null and feature is null and sea is null and island is null and island_group is null and county is null
		OR
		upper(state_prov) like '#ucase(trim(qp))#' and quad is null and feature is null and sea is null and island is null and island_group is null and county is null
		<cfif listlen(place,",") gt 0>
		<cfloop list="#qp#" index="x">
			or upper(country) like '#ucase(trim(x))#' and state_prov is null and quad is null and feature is null and sea is null and island is null and island_group is null and county is null
			OR
			upper(state_prov) like '#ucase(trim(x))#' and quad is null and feature is null and sea is null and island is null and island_group is null and county is null
			</cfloop>
		</cfif>
		
</cfquery>



	<hr>
	<a href="https://www.google.com/search?q=#place#">#place#</a>
	
	<cfloop query="sp">
		<br><a href="a.cfm?action=u&sb=#sp.higher_geog#&p=#d.place#">#sp.higher_geog#</a>
	</cfloop>
	<br><a href="a.cfm?action=u&sb=North America, United States, Alaska&p=#d.place#">North America, United States, Alaska</a>
	<br><a href="a.cfm?action=u&sb=North America, United States&p=#d.place#">North America, United States</a>
	<br><a href="a.cfm?action=u&sb=North America, Canada&p=#d.place#">North America, Canada</a>
	<br><a href="a.cfm?action=u&sb=Eurasia, Russia&p=#d.place#">Eurasia, Russia</a>
	<br><a href="a.cfm?action=u&sb=North America&p=#d.place#">North America</a>
	<br><a href="a.cfm?action=u&sb=no higher geography recorded&p=#d.place#">no higher geography recorded</a>
	
	
	
	<form name="f#rnum#" method="post" action="a.cfm" target="_blank">
	<input type="hidden" name="action" value="u">
	<input type="hidden" name="nothing" id="nothing">
	<input type="hidden" name="p" value="#d.place#">
		<input type="text" name="sb" class="reqdClr" id="sb" size="80"
												onchange="getGeog('nothing',this.id,'f#rnum#',this.value)">
												<input type="submit">
	</form>
	
	
	
	<cfset rnum=rnum+1>

	
</cfloop>
</cfif>

<cfif action is "u">

update eh_place set shouldbe='#sb#' where place='#p#'

<cfquery name="gotone" datasource="uam_god">
	update eh_place set shouldbe='#sb#' where place='#p#'
</cfquery>
<!---
<cflocation url="a.cfm" addtoken="false">
---->
</cfif>
</cfoutput>