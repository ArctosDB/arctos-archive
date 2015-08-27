<cfinclude template="/includes/_header.cfm">


<style>
#cboxdiv {
   	width: 30em;
	height: 3em;
	border: 1px solid;
	resize: vertical;
	overflow: auto;
    min-height:2em;
    max-height:20em;
}


.cboxdiv_allnone {
	text-align:center;
}
.cboxdiv_allnone span {
	padding-left:2em;
	padding-right:2em;
}
.cboxdiv_option {
	border:1px light gray;
}
</style>
<cfoutput>
<cfif action is "ftest">
	<cfdump var=#form#>
</cfif>

	<cfquery name="ctInst" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		SELECT institution_acronym, collection, collection_id FROM collection order by collection
	</cfquery>
	
	<form method="post">
	<input name="action" value="ftest">
<select name="collection_id" id="collection_id" size="3" multiple="multiple">
								<cfloop query="ctInst">
									<option value="#ctInst.collection_id#">#ctInst.collection#</option>
								</cfloop>
							</select>
							<input type="submit">
							
							
							<div id="cboxdiv">
								<div class="cboxdiv_allnone">
									<span class="likeLink" onclick="$('input[name^=cid]').prop('checked',true);">[ all ]</span>									
									<span class="likeLink" onclick="$('input[name^=cid]').prop('checked',false);">[ none ]</span>
								</div>
							<cfloop query="ctinst">
								<div class="cboxdiv_option">
									<input type="checkbox" name="cid" value=#collection_id#> #collection#
								</div>
							</cfloop>
							</div>
			</form>				
							
<!--------------------------------------------------------------------------------------->

<cfif action is "agenttest">
<cffunction name="splitAgentName" access="remote" returnformat="json">
   	<cfargument name="name" required="true" type="string">
	<cfquery name="CTPREFIX" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#" cachedwithin="#createtimespan(0,0,60,0)#">
		select prefix from CTPREFIX
	</cfquery>
	<cfquery name="CTsuffix" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#" cachedwithin="#createtimespan(0,0,60,0)#">
		select suffix from CTsuffix
	</cfquery>
	<cfset temp=name>
	
	<cfset removedPrefix="">
	<cfset removedSuffix="">
	
	<cfloop query="CTPREFIX">
		<cfif temp contains prefix>
			<cfset removedPrefix=prefix>
			<br>removed #prefix#
			<cfset temp=replace(temp,prefix,'','all')>
		</cfif>
	</cfloop>
	<cfloop query="CTsuffix">
		<cfif temp contains suffix>
			<cfset removedSuffix=suffix>
			<cfset temp=replace(temp,suffix,'','all')>
		</cfif>
		<cfset temp=replace(temp,suffix,'','all')>
	</cfloop>
	
	<cfset temp=replace(temp,'  ',' ','all')>
	<cfset temp=trim(temp)>
		
	<!--- see if we can guess at "standard" last name prefixes --->
	<cfset snp="Von,Van,La,Do,Del,De,St.">
	<cfloop list="#snp#" index="x">
		<cfset temp=replace(temp, "#x# ","#x#|","all")>
	</cfloop>
	
	<br>tempaftersnp: #temp#
	<cfset nametype=''>
		
	<cfset first="">
	<cfset middle="">
	<cfset last="">
		
	<br>temp: #temp#
	<br>removedSuffix: #removedSuffix#
	
	<br>removedPrefix: #removedPrefix#
	
	
	<!--- the order of these is IMPORTANT!! --->
	<cfif REFind("^[^, ]+ [^, ]+$",temp)>
		<!---- xxxxx xxxxxx ---->
		<cfset nametype="first_last">
		<cfset first=listgetat(temp,1," ")>
		<cfset last=listlast(temp," ")>
	<cfelseif REFind("^[^,]+ [^,]+ .+$",temp)>
		<!---- 
			xxxxx xxxxxx xxxxxx 
			xxx x x xxxx	
		---->
		<cfset nametype="first_middle_last">
		<cfset first=listgetat(temp,1," ")>
		<cfset last=listlast(temp," ")>		
		<cfset middle=replace(replace(temp,first,"","all"),last,"","all")>	
	<cfelseif REFind("^.+, .+ .+$",temp)>
		<!---- xxxxx, xxxxxx xxxxxx ---->
		<cfset nametype="last_comma_first_middle">		
		<cfset last=listfirst(temp," ")>
		<cfset first=listgetat(temp,2," ")>
		<cfset middle=replace(replace(temp,first,"","all"),last,"","all")>		
	<cfelseif REFind("^.+, .+$",temp)>
		<cfset nametype="last_comma_first">
		<!---- xxxxx, xxxxxx ---->
		<cfset last=listgetat(temp,1," ")>
		<cfset first=listgetat(temp,2," ")>	
	<cfelse>
		<cfset nametype="nonstandard">
	</cfif>
	
	
	
	
	
	
	
	<!--- un-do guess at "standard" last name prefixes --->
	<cfloop list="#snp#" index="x">
		<cfset last=replace(last, "#x#|","#x# ","all")>
	</cfloop>
	
	<!--- strip commas --->
	<cfset first=trim(replace(first, ',','','all'))>
	<cfset middle=trim(replace(middle, ',','','all'))>
	<cfset last=trim(replace(last, ',','','all'))>
	<cfset formatted_name=trim(replace(removedPrefix & ' ' & 	first & ' ' & middle & ' ' & last & ' ' & removedSuffix, ',','','all'))>
	<cfif nametype is "nonstandard">
		<cfset formatted_name="">
	</cfif>
	
	<cfset d = querynew("name,nametype,first,middle,last, formatted_name")>
	<cfset temp = queryaddrow(d,1)>
	<cfset temp = QuerySetCell(d, "name", name, 1)>
	<cfset temp = QuerySetCell(d, "nametype", nametype, 1)>
	<cfset temp = QuerySetCell(d, "first", trim(first), 1)>
	<cfset temp = QuerySetCell(d, "middle", trim(middle), 1)>
	<cfset temp = QuerySetCell(d, "last", trim(last), 1)>
	<cfset temp = QuerySetCell(d, "formatted_name", trim(formatted_name), 1)>
	<cfdump var=#d#>
	
	<cfreturn d>
</cffunction>


	
	
	
	
	
	
	
	
	
	
	<cfset regexStripJunk='[ .,-]'>
	<cfset problems="">
	<!--- list of terms that PROBABLY should not appear in agent names ---->
	<cfset disallowPersons="Animal,al,alaska,and,Anonymous">
	<cfset disallowPersons=disallowPersons & ",biol,biology">
	<cfset disallowPersons=disallowPersons & ",Class,california,company,co.,Club">
	<cfset disallowPersons=disallowPersons & ",Ecology,et,estate">
	<cfset disallowPersons=disallowPersons & ",field">
	<cfset disallowPersons=disallowPersons & ",Group,Growth">
	<cfset disallowPersons=disallowPersons & ",Hospital,hunter">
	<cfset disallowPersons=disallowPersons & ",illegible,inc">
	<cfset disallowPersons=disallowPersons & ",Lab">
	<cfset disallowPersons=disallowPersons & ",Management,Museum">
	<cfset disallowPersons=disallowPersons & ",National,native">
	<cfset disallowPersons=disallowPersons & ",Old,other">
	<cfset disallowPersons=disallowPersons & ",Rangers,Ranger,research">
	<cfset disallowPersons=disallowPersons & ",Predatory,Project,Puffin">
	<cfset disallowPersons=disallowPersons & ",Sanctuary,Science,Seabird,Society,Study,student,students,station,summer,shop,service,store,system">
	<cfset disallowPersons=disallowPersons & ",University,uaf">
	<cfset disallowPersons=disallowPersons & ",various">
	<cfset disallowPersons=disallowPersons & ",Zoological,zoo">
	
	
	


			
	<!---- 
		random lists of things may be indicitave of garbage. 
			disallowWords are " me AND you" but not "ANDy"
			disallowCharacters are just that "me/you" and me /  you" and ....	
		Expect some false positives - sorray! 
	---->
	<cfset disallowWords="and,or,cat">
	<cfset disallowCharacters="/,\,&">
	
	<cfset strippedUpperFML=ucase(rereplace(first_name & middle_name & last_name,regexStripJunk,"","all"))>
	<cfset strippedUpperFL=ucase(rereplace(first_name & last_name,regexStripJunk,"","all"))>
	<cfset strippedUpperLF=ucase(rereplace(last_name & first_name,regexStripJunk,"","all"))>
	<cfset strippedUpperLFM=ucase(rereplace(last_name & first_name & middle_name,regexStripJunk,"","all"))>
	<cfset strippedP=ucase(rereplace(preferred_name,regexStripJunk,"","all"))>
	
	<cfset strippedNamePermutations=strippedP>
	<cfset strippedNamePermutations=listappend(strippedNamePermutations,strippedUpperFML)>
	<cfset strippedNamePermutations=listappend(strippedNamePermutations,strippedUpperFL)>
	<cfset strippedNamePermutations=listappend(strippedNamePermutations,strippedUpperLF)>
	<cfset strippedNamePermutations=listappend(strippedNamePermutations,strippedUpperLFM)>
	<cfset strippedNamePermutations=listappend(strippedNamePermutations,strippedP)>
		
	<cfif len(strippedNamePermutations) is 0>
		<cfset problems=listappend(problems,'Check apostrophy/single-quote. "O&apos;Neil" is fine. "Jim&apos;s Cat" should be entered as "unknown".',';')>
	</cfif>
			
	<cfloop list="#disallowCharacters#" index="i">
		<cfif preferred_name contains i>
			<cfset problems=listappend(problems,'Check name for #i#. do not create unnecessary variations of "unknown."',';')>
		</cfif>
	</cfloop>
			
	<cfloop list="#disallowWords#" index="i">
		<cfif listfindnocase(preferred_name,i," ;,.")>
			<cfset problems=listappend(problems,'Check name for #i#; do not create unnecessary variations of "unknown."',';')>
		</cfif>
	</cfloop>
	<cfif agent_type is "person">
		<cfloop list="#disallowPersons#" index="i">
			<cfif listfindnocase(preferred_name,i,"() ;,.")>
				<cfset problems=listappend(problems,'Check name for #i#. do not create non-person agents as persons."',';')>
			</cfif>
		</cfloop>
	</cfif>
	<!--- try to avoid unnecessary acronyms --->
	<cfif refind('[A-Z]{3,}',preferred_name) gt 0>
		<cfset problems=listappend(problems,'Check for abbreviations and acronyms. do not create unnecessary variations of "unknown."',';')>
	</cfif>

	<cfif Compare(ucase(preferred_name), preferred_name) is 0 or Compare(lcase(preferred_name), preferred_name) is 0>
		<cfset problems=listappend(problems,'Check for abbreviations and acronyms. Do not create unnecessary variations of "unknown."',';')>
	</cfif>

	<cfif preferred_name does not contain " ">
		<cfset problems=listappend(problems,'Check for abbreviations and acronyms. Do not create unnecessary variations of "unknown."',';')>
	</cfif>
	
	<cfif preferred_name contains ".">
		<cfset problems=listappend(problems,'Check for abbreviations and acronyms. Do not create unnecessary variations of "unknown."',';')>
	</cfif>
		
		<br>strippedNamePermutations: #strippedNamePermutations#
	<cfset strippedNamePermutations=trim(escapeQuotes(strippedNamePermutations))>	
	<cfset strippedNamePermutations=ListQualify(strippedNamePermutations,"'")>	
	<!--- if we did not get a first or last name passed in, try to guess from the preferred name string ---->
	
	
	
	
	
	
	<cfset srchFirstName=first_name>
	<cfset srchMiddleName=middle_name>
	<cfset srchLastName=last_name>
	
	<cfif len(first_name) is 0 or len(last_name) is 0 or len(middle_name) is 0>
		<cfset x=splitAgentName(preferred_name)>
		<cfif len(first_name) is 0 and len(x.first) gt 0>
			<cfset srchFirstName=x.first>
		</cfif>
		<cfif len(middle_name) is 0 and len(x.middle) gt 0>
			<cfset srchMiddleName=x.middle>
		</cfif>
		<cfif len(last_name) is 0 and len(x.last) gt 0>
			<cfset srchLastName=x.last>
		</cfif>
	</cfif>
		
	<cfset srchFirstName=trim(escapeQuotes(srchFirstName))>
	<cfset srchMiddleName=trim(escapeQuotes(srchMiddleName))>
	<cfset srchLastName=trim(escapeQuotes(srchLastName))>
	<cfset srchPrefName=trim(escapeQuotes(preferred_name))>
	
	
		<br>srchFirstName: #srchFirstName#
		<br>srchMiddleName: #srchMiddleName#
		<br>srchLastName: #srchLastName#
		<br>strippedNamePermutations: #strippedNamePermutations#
						
	<!--- nocase preferred name match ---->	
	<cfset sql="select 
					'nocase preferred name match' reason,
			        agent.agent_id, 
			        agent.preferred_agent_name
				from 
			        agent
				where 
			        trim(upper(agent.preferred_agent_name))=trim(upper('#srchPrefName#'))">

	<cfset sql=sql & "
		    union 
			  select
			        'nodots-nospaces match on first last' reason,
			        agent.agent_id, 
			        agent.preferred_agent_name
				from
					agent,
					(select agent_id,agent_name from agent_name where agent_name_type='first name') first_name,
					(select agent_id,agent_name from agent_name where agent_name_type='last name') last_name
				where
					agent.agent_id=first_name.agent_id and
					agent.agent_id=last_name.agent_id and
					trim(upper(first_name.agent_name)) = trim(upper('#srchFirstName#')) and
					trim(upper(last_name.agent_name)) = trim(upper('#srchLastName#')) and
					  upper(regexp_replace(first_name.agent_name || last_name.agent_name ,'#regexStripJunk#', '')) in (
						#preserveSingleQuotes(strippedNamePermutations)#
				     )">
	<cfset sql=sql & "
		 union select
			'nodots-nospaces match on agent name' reason,
			 agent.agent_id, 
			 agent.preferred_agent_name
		from 
			agent,
			agent_name
		where 
		       agent.agent_id=agent_name.agent_id and
			        upper(regexp_replace(agent_name.agent_name,'#regexStripJunk#', '')) in (
			        	#preserveSingleQuotes(strippedNamePermutations)#
			        )">	     
					     
	<cfif len(srchFirstName) gt 0 and len(srchLastName) gt 0>
		<!--- first and last names match ---->
		<cfset sql=sql & "
			        union
				    select
				    	'nocase first and last name match' reason,
				        agent.agent_id, 
				        agent.preferred_agent_name
					from
						agent,
						(select agent_id,agent_name from agent_name where agent_name_type='first name') first_name,
						(select agent_id,agent_name from agent_name where agent_name_type='last name') last_name
					where
						agent.agent_id=first_name.agent_id and
						agent.agent_id=last_name.agent_id and
						trim(upper(first_name.agent_name)) = trim(upper('#srchFirstName#')) and
						trim(upper(last_name.agent_name)) = trim(upper('#srchLastName#'))">
	
		
		
	
	</cfif>		        	
	<cfif len(srchFirstName) gt 0 and len(srchMiddleName) gt 0 and len(srchLastName) gt 0>
		<cfset sql=sql & "
					 union
				    select
				        'nodots-nospaces-nocase match on first middle last' reason,
				        agent.agent_id, 
				        agent.preferred_agent_name
					from
						agent,
						(select agent_id,agent_name from agent_name where agent_name_type='first name') first_name,
						(select agent_id,agent_name from agent_name where agent_name_type='middle name') middle_name,
						(select agent_id,agent_name from agent_name where agent_name_type='last name') last_name
					where
						agent.agent_id=first_name.agent_id and
						agent.agent_id=middle_name.agent_id and
						agent.agent_id=last_name.agent_id and
						upper(regexp_replace(first_name.agent_name || middle_name.agent_name || last_name.agent_name ,'#regexStripJunk#', '')) in (
							#preserveSingleQuotes(strippedNamePermutations)#
					     )
					     ">
	</cfif>
	<cfif len(srchLastName) gt 0>
		<cfset sql=sql & "
					 union
					   select
			    		'last name match' reason,
				        agent.agent_id, 
				        agent.preferred_agent_name
					from
						agent,
						(select agent_id,agent_name from agent_name where agent_name_type='last name') last_name
					where
						agent.agent_id=last_name.agent_id and
						trim(upper(last_name.agent_name)) = trim(upper('#srchLastName#'))
					     ">
		<!--- 
			and try to extract first and last from data without 
			
			upper(SUBSTR(agent_name, INSTR(agent_name,' ', -1, 1)+1)) returns "last name" (thing after last space in string)
		---->
		<cfset sql=sql & "
			 union
			   select
	    		'extracted last name match' reason,
		        agent.agent_id, 
		        agent.preferred_agent_name
			from
				agent,
				agent_name
			where
				agent.agent_id=agent_name.agent_id and
				upper(SUBSTR(agent_name.agent_name, INSTR(agent_name.agent_name,' ', -1, 1)+1)) = trim(upper('#srchLastName#'))
			">
	</cfif>
	<cfquery name="isdup" datasource="uam_god">
		select 
			reason,
			agent_id,
			preferred_agent_name
		from (
			#preservesinglequotes(sql)#
		)  group by
	    	reason,
	    	agent_id, 
	        preferred_agent_name
	    order by
	    	reason,
	    	preferred_agent_name
	</cfquery>
	
	<cfdump var=#isdup#>
		<cfif isdup.recordcount is 0>
		<!--- try last-name match --->
	</cfif>
	<cfloop query="isdup">
		<cfset thisProb='<a href="/agents.cfm?agent_id=#agent_id#" target="_blank">#reason# [#preferred_agent_name#]</a>'>
		<cfset problems=listappend(problems,thisProb,';')>
	</cfloop>
	<cfdump var=#problems#>
	
	
	
	</cfif>
</cfoutput>