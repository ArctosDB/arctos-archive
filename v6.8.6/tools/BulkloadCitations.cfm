<!----


drop table cf_temp_citation;

create table cf_temp_citation (
	KEY number not null,
	FULL_CITATION VARCHAR2(4000),
 	PUBLICATION_ID NUMBER,
 	GUID_PREFIX VARCHAR2(20) not null,
	OTHER_ID_TYPE VARCHAR2(60) not null,
 	OTHER_ID_NUMBER VARCHAR2(60) not null,
 	COLLECTION_OBJECT_ID NUMBER,
 	TYPE_STATUS  VARCHAR2(60) not null,
 	OCCURS_PAGE_NUMBER NUMBER,
 	CITATION_REMARKS VARCHAR2(255),
	use_existing_accepted_id number(1) not null,
	SCIENTIFIC_NAME  VARCHAR2(60),
	taxonid1 number,
	taxonid2 number,
 	ACCEPTED_ID_FG NUMBER,
 	NATURE_OF_ID  VARCHAR2(60),
 	MADE_DATE  VARCHAR2(60),
 	IDENTIFICATION_REMARKS VARCHAR2(255),
 	IDENTIFIER_1 VARCHAR2(255),
 	agentid1 NUMBER,
 	IDENTIFIER_2 VARCHAR2(255),
 	agentid2 NUMBER,
 	IDENTIFIER_3 VARCHAR2(255),
 	agentid3 NUMBER,
	STATUS VARCHAR2(255),
	taxa_formula VARCHAR2(60),
	use_pub_authors number(1),
	  CONSTRAINT ck_use_existing_accepted10 CHECK (use_existing_accepted_id in (0,1)),
	  CONSTRAINT pk_cf_temp_citation PRIMARY KEY (KEY)
);


CREATE OR REPLACE TRIGGER CF_TEMP_CITATION_KEY
before insert ON cf_temp_citation
for each row
begin
    if :NEW.key is null then
        select somerandomsequence.nextval
        into :new.key from dual;
    end if;
end;
/

create or replace public synonym CF_TEMP_CITATION for CF_TEMP_CITATION;

grant all ON CF_TEMP_CITATION to COLDFUSION_USER;

---->

<cfinclude template="/includes/_header.cfm">
<cfset title="Bulkload Citations">

<cfif action is "makeTemplate">
	<cfset header="FULL_CITATION,PUBLICATION_ID,GUID,GUID_PREFIX,OTHER_ID_TYPE,OTHER_ID_NUMBER,TYPE_STATUS,OCCURS_PAGE_NUMBER,USE_EXISTING_ACCEPTED_ID,CITATION_REMARKS,SCIENTIFIC_NAME,ACCEPTED_ID_FG,NATURE_OF_ID,MADE_DATE,USE_PUB_AUTHORS,IDENTIFIER_1,IDENTIFIER_2,IDENTIFIER_3,IDENTIFICATION_REMARKS">
	<cffile action = "write"
    file = "#Application.webDirectory#/download/BulkCitationsTemplate.csv"
    output = "#header#"
    addNewLine = "no">
	<cflocation url="/download.cfm?file=BulkCitationsTemplate.csv" addtoken="false">
</cfif>


<cfif action is "csv">
	<cfquery name="mine" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select * from cf_temp_citation
	</cfquery>
	<cfset header="STATUS,FULL_CITATION,PUBLICATION_ID,GUID,GUID_PREFIX,OTHER_ID_TYPE,OTHER_ID_NUMBER,TYPE_STATUS,OCCURS_PAGE_NUMBER,USE_EXISTING_ACCEPTED_ID,CITATION_REMARKS,SCIENTIFIC_NAME,ACCEPTED_ID_FG,NATURE_OF_ID,MADE_DATE,USE_PUB_AUTHORS,IDENTIFIER_1,IDENTIFIER_2,IDENTIFIER_3,IDENTIFICATION_REMARKS">
	<cfset variables.encoding="UTF-8">
	<cfset variables.fileName="#Application.webDirectory#/download/BulkCitationsDown.csv">
	<cfscript>
		variables.joFileWriter = createObject('Component', '/component.FileWriter').init(variables.fileName, variables.encoding, 32768);
		variables.joFileWriter.writeLine(header);
	</cfscript>
	<cfloop query="mine">
		<cfset d=''>
		<cfloop list="#header#" index="i">
			<cfset t='"' & evaluate("mine." & i) & '"'>
			<cfset d=listappend(d,t,",")>
		</cfloop>
		<cfscript>
			variables.joFileWriter.writeLine(d);
		</cfscript>
	</cfloop>
	<cfscript>
		variables.joFileWriter.close();
	</cfscript>
	<cflocation url="/download.cfm?file=BulkCitationsDown.csv" addtoken="false">
	<a href="/download/BulkCitationsDown.csv">Click here if your file does not automatically download.</a>
</cfif>

<cfif action is "nothing">
	Step 1: Upload a comma-delimited text file (csv).
	Include CSV column headings.

	<ul>
		<li><a href="BulkloadCitations.cfm?action=makeTemplate">Get a template</a></li>
		<li><a target="_blank" class="external" href="http://arctosdb.org/documentation/publications/specimen-citations/">Citations documentation</a></li>
	</ul>
	Citations are a combination of a Publication and an Identification.

	<p>
		Either full_citation or publication_id will find a publication. full_citation is an exact-string match - HTML markup and trailing spaces and all other
		characters matter.
	</p>
	<p>
		The combination of guid OR guid_prefix, other_id_type (including "catalog number"), and other_id_number must define exactly one specimen.
		<ul>
			<li>UAM:Mamm + catalog number + 1 will assuredly work.</li>
			<li>UAM:Mamm + collector number + 1 will work ONLY if exactly one UAM:Mammal has a collector number of "1".</li>
		</ul>
		There are several options to select an Identification:
		<ul>
			<li>Enter "1" under USE_EXISTING_ACCEPTED_ID to link the citation to the current accepted identification. Use this option cautiously - it
			severely limits	the utility of citations.</li>
			<li>
				Enter "0" under USE_EXISTING_ACCEPTED_ID to create a new Identification/Citation pair.
				 New Citations created using this application will automatically be "sensu" the publication used in the citation. This option created dedicated
				 citations and is strongly preferred, even when a publication does not explicitly add Identification information. There are two options for specifying
				 Identifying Agents:
				 <ul>
				 	<li>
				 		Set use_pub_authors to "1" to use the authors of the publication as the identifiers. This is usually the correct approach IF (and only if) the
				 		publication explicitly has Agents attached. Not all publications do.
				 	</li>
				 	<li>
				 		Set use_pub_authors to "0" and specify identifying agents under identifier_<em>n</em>. This is appropriate if the publication does not have
				 		agents attached.
				 	</li>
				 </ul>
			</li>
		</ul>
	</p>

	<table border>
		<tr>
			<th>ColumnName</th>
			<th>Required</th>
			<th>Explanation</th>
			<th>Documentation</th>
		</tr>
		<tr>
			<td>guid</td>
			<td>conditionally - use guid OR guid_prefix+other_id_type+other_id_number</td>
			<td>"UAM:Mamm:12"</td>
			<td><a  target="_blank" class="external" href="http://arctosdb.org/documentation/catalog/#guid">docs</a></td>
		</tr>
		<tr>
			<td>guid_prefix</td>
			<td>conditionally - use guid OR guid_prefix+other_id_type+other_id_number</td>
			<td>find under Manage Collections or under the <a href="/home.cfm">Portals</a> tab - it's things like "UAM:Mamm"</td>
			<td><a  target="_blank" class="external" href="http://arctosdb.org/documentation/catalog/#guid">docs</a></td>
		</tr>
		<tr>
			<td>other_id_type</td>
			<td>conditionally - use guid OR guid_prefix+other_id_type+other_id_number</td>
			<td>"catalog number" is valid but not in the code table</td>
			<td><a target="_blank" href="/info/ctDocumentation.cfm?table=CTCOLL_OTHER_ID_TYPE">CTCOLL_OTHER_ID_TYPE</a></td>
		</tr>
		<tr>
			<td>other_id_number</td>
			<td>conditionally - use guid OR guid_prefix+other_id_type+other_id_number</td>
			<td>the value of the identifier/catalog number</td>
			<td></td>
		</tr>
		<tr>
			<td>full_citation</td>
			<td>conditionally</td>
			<td>exact string match, includes markup, etc. - use either this or publication_id, not both</td>
			<td></td>
		</tr>
		<tr>
			<td>publication_id</td>
			<td>conditionally</td>
			<td>find in URLs - eg, http://arctos.database.museum/publication/<strong>1</strong> - use either this or full_citation, not both</td>
			<td></td>
		</tr>
		<tr>
			<td>type_status</td>
			<td>yes</td>
			<td></td>
			<td><a target="_blank" href="/info/ctDocumentation.cfm?table=CTCITATION_TYPE_STATUS">CTCITATION_TYPE_STATUS</a></td>
		</tr>
		<tr>
			<td>occurs_page_number</td>
			<td>no</td>
			<td>numeric page number value on which the citation occurs</td>
			<td></td>
		</tr>
		<tr>
			<td>citation_remarks</td>
			<td>no</td>
			<td>remarks concerning the citation, or linkage between the specimen and publication</td>
			<td></td>
		</tr>

		<tr>
			<td>USE_EXISTING_ACCEPTED_ID</td>
			<td>YES</td>
			<td>0 or 1</td>
			<td>0==require enough information to create a new Identification; 1==use the existing accepted ID and ignore anything about new Identifications</td>
		</tr>

		<tr>
			<td>scientific_name</td>
			<td>if USE_EXISTING_ACCEPTED_ID is 0</td>
			<td>Identification.scientific_name to apply to the specimen</td>
			<td><a  target="_blank" class="external" href="http://arctosdb.org/documentation/identification/#scientific_name">identification.scientific_name</a></td>
		</tr>
		<tr>
			<td>accepted_id_fg</td>
			<td>if USE_EXISTING_ACCEPTED_ID is 0</td>
			<td>Should the citation-identification become the specimen's accepted ID?</td>
			<td>0 or 1</td>
		</tr>
		<tr>
			<td>nature_of_id</td>
			<td>if USE_EXISTING_ACCEPTED_ID is 0</td>
			<td></td>
			<td><a target="_blank" href="/info/ctDocumentation.cfm?table=ctnature_of_id">ctnature_of_id</a></td>
		</tr>
		<tr>
			<td>made_date</td>
			<td>no</td>
			<td>ISO8601 data on which the ID was made (usually publication year)</td>
			<td></td>
		</tr>
		<tr>
			<td>use_pub_authors</td>
			<td>conditionally</td>
			<td>
				1==>Ignore anything that might be in the author fields and use the publication author-agents as determiners.
				<br>0==>require and use the information provided in the identifier_x fields for identifier. Required if
				identifier_1 is not given.
			</td>
			<td>0 or 1 - <a target="_blank" class="external"  href="http://arctosdb.org/documentation/publications/#author">authors</a></td>
		</tr>
		<tr>
			<td>identifier_1</td>
			<td>conditionally</td>
			<td>First agent responsible for the identification.
				Required if use_pub_authors is not given; ignored if use_pub_authors is given.
			</td>
			<td></td>
		</tr>
		<tr>
			<td>identifier_2</td>
			<td>no</td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>identifier_3</td>
			<td>no</td>
			<td>edit the specimen after loading Citations if >3 identifiers are deemed important</td>
			<td></td>
		</tr>
		<tr>
			<td>identification_remarks</td>
			<td>no</td>
			<td>remarks concerning the application of the taxon name(s) to the specimen</td>
			<td></td>
		</tr>
	</table>
	<p></p>
	<cfform name="oids" method="post" enctype="multipart/form-data">
		<input type="hidden" name="Action" value="getFile">
		<label for="FiletoUpload">Upload CSV</label>
		<input type="file" name="FiletoUpload" size="45" onchange="checkCSV(this);">
		<input type="submit" value="Upload this file" class="insBtn">
	</cfform>
</cfif>
<!------------------------------------------------------->
<cfif action is "getFile">
<cfoutput>
	<!--- put this in a temp table --->
	<cfquery name="killOld" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		delete from cf_temp_citation
	</cfquery>
	<cffile action="READ" file="#FiletoUpload#" variable="fileContent">
	<cfset fileContent=replace(fileContent,"'","''","all")>
	<cfset arrResult = CSVToArray(CSV = fileContent.Trim()) />
	<cfset colNames="">
	<cfloop from="1" to ="#ArrayLen(arrResult)#" index="o">
		<cfset colVals="">
			<cfloop from="1"  to ="#ArrayLen(arrResult[o])#" index="i">
				<cfset thisBit=arrResult[o][i]>
				<cfif #o# is 1>
					<cfset colNames="#colNames#,#thisBit#">
				<cfelse>
					<cfset colVals="#colVals#,'#thisBit#'">
				</cfif>
			</cfloop>
		<cfif #o# is 1>
			<cfset colNames=replace(colNames,",","","first")>
		</cfif>
		<cfif len(#colVals#) gt 1>
			<cfset colVals=replace(colVals,",","","first")>
			<cfquery name="ins" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				insert into cf_temp_citation (#colNames#) values (#preservesinglequotes(colVals)#)
			</cfquery>
		</cfif>
	</cfloop>
	<cflocation url="BulkloadCitations.cfm?action=validate" addtoken="false">
</cfoutput>
</cfif>
<!------------------------------------------------------->
<cfif action is "validate">
<cfoutput>
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='missing data'
		where
		(full_citation is null and publication_id is null)
	</cfquery>
	<cfquery name="nopub_id" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='publication_ID not found'
		where
		publication_id is not null and
		publication_id not in (select publication_id from publication)
	</cfquery>
	<cfquery name="nopub" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='publication not found'
		where
		publication_id is null and
		full_citation not in (select full_citation from publication)
	</cfquery>
	<cfquery name="data2" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='missing data'
		where
		USE_EXISTING_ACCEPTED_ID=0 and (
		SCIENTIFIC_NAME is null or
		TYPE_STATUS is null or
		ACCEPTED_ID_FG is null or
		NATURE_OF_ID is null
		)
	</cfquery>
	<cfquery name="ctcitation_TYPE_STATUS" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='TYPE_STATUS invalid'
		where
		TYPE_STATUS not in (select TYPE_STATUS from ctcitation_TYPE_STATUS)
	</cfquery>
	<cfquery name="NATURE_OF_ID" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='NATURE_OF_ID invalid'
		where
		NATURE_OF_ID not in (select NATURE_OF_ID from ctNATURE_OF_ID)
	</cfquery>

	<cfquery name="guid_prefix" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='guid_prefix invalid (check case, colons)'
		where
		guid_prefix is not null and guid_prefix not in (select guid_prefix from collection)
	</cfquery>

	<cfquery name="require_author" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='at least one author required when use_pub_authors is false'
		where USE_PUB_AUTHORS != 1 and IDENTIFIER_1 is null
	</cfquery>
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select * from cf_temp_citation where status is null
	</cfquery>

	<cfloop query="data">
		<cfset problem="">
		<cfquery name="collObj" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select
				cataloged_item.COLLECTION_OBJECT_ID
			from
				cataloged_item,
				collection,
				coll_obj_other_id_num
			where
				cataloged_item.collection_id=collection.collection_id and
				cataloged_item.collection_object_id = coll_obj_other_id_num.collection_object_id (+) AND
				<cfif len(guid) gt 0>
					upper(collection.guid_prefix || ':' || cataloged_item.cat_num)='#ucase(guid)#'
				<cfelse>
					upper(collection.guid_prefix)='#ucase(guid_prefix)#' and
					<cfif other_id_type is "catalog number">
						cat_num=#trim(other_id_number)#
					<cfelse>
						other_id_type = '#trim(other_id_type)#' and
						display_value = '#trim(other_id_number)#'
					</cfif>
				</cfif>
		</cfquery>
		<cfif len(collObj.COLLECTION_OBJECT_ID) gt 0>
			<cfset thisColObjId=collObj.COLLECTION_OBJECT_ID>
		<cfelse>
			<cfset thisColObjId=-1>
			<cfset problem = listappend(problem,'specimen not found',";")>
		</cfif>

		<cfif len(publication_id) is 0>
			<cfquery name="isPub" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				select publication_id from publication where full_citation = '#full_citation#'
				group by publication_id
			</cfquery>
			<cfset thisPubId=isPub.publication_id>
		<cfelse>
			<cfset thisPubId=publication_id>
		</cfif>

		<cfif USE_EXISTING_ACCEPTED_ID is 0>
			<!--- creating a new ID ---->
			<cfinvoke component="component.functions" method="parseTaxonName" returnvariable="tn">
				<cfinvokeargument name="taxon_name" value="#SCIENTIFIC_NAME#">
			</cfinvoke>
			<cfset thisTNID1=tn.taxon_name_id_1>
			<cfset thisTNID2=tn.taxon_name_id_2>
			<cfset thisTF=tn.taxa_formula>
			<cfset problem = listappend(problem,tn.status,";")>
			<cfinvoke component="component.functions" method="getAgentId" returnvariable="a">
				<cfinvokeargument name="agent_name" value="#IDENTIFIER_1#">
			</cfinvoke>
			<cfset problem = listappend(problem,a.status,";")>
			<cfset aid1=a.agent_id>
			<cfinvoke component="component.functions" method="getAgentId" returnvariable="a">
				<cfinvokeargument name="agent_name" value="#IDENTIFIER_2#">
			</cfinvoke>
			<cfset problem = listappend(problem,a.status,";")>
			<cfset aid2=a.agent_id>
			<cfinvoke component="component.functions" method="getAgentId" returnvariable="a">
				<cfinvokeargument name="agent_name" value="#IDENTIFIER_3#">
			</cfinvoke>
			<cfset problem = listappend(problem,a.status,";")>
			<cfset aid3=a.agent_id>
			<cfquery name="ss" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				UPDATE cf_temp_citation SET
					collection_object_id = #thisColObjId#
					<cfif len(thisPubId) gt 0>
						,publication_id=#thisPubId#
					</cfif>

					<cfif len(aid1) gt 0>
						,agentid1=#aid1#
					</cfif>
					<cfif len(aid2) gt 0>
						,agentid2=#aid2#
					</cfif>
					<cfif len(aid3) gt 0>
						,agentid3=#aid3#
					</cfif>
					<cfif len(thisTNID2) gt 0>
						,taxonid2=#thisTNID2#
					</cfif>
					<cfif len(thisTNID1) gt 0>
						,taxonid1=#thisTNID1#
					</cfif>
					,taxa_formula='#thisTF#'
					,status = '#problem#'
				 where
					key = #key#
			</cfquery>
		<cfelse>
			<!--- using existing identification ---->
			<cfquery name="ss" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				UPDATE cf_temp_citation SET
					collection_object_id = #thisColObjId#
					<cfif len(thisPubId) gt 0>
						,publication_id=#thisPubId#
					</cfif>
					,status = '#problem#'
				 where
					key = #key#
			</cfquery>
		</cfif>


	</cfloop>
	<cfquery name="valData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_temp_citation set status='duplicate' where
			status is null and key in (
			select distinct k from cf_temp_citation a,
			 (select min(key) k, collection_object_id,publication_id
			from cf_temp_citation having count(*) >  1 group by
			collection_object_id,publication_id) b
			where a.collection_object_id = b.collection_object_id and
			a.publication_id = b.publication_id
		)
	</cfquery>
	<cfquery name="valData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select * from cf_temp_citation order by status,
		other_id_type,
		other_id_number,
		full_citation
	</cfquery>
	<cfquery name="isProb" dbtype="query">
		select count(*) c from valData where status is not null
	</cfquery>
	<cfif #isProb.c# is 0 or len(isprob.c) is 0>
		Data validated. Double-check below. If everything looks OK, <a href="BulkloadCitations.cfm?action=loadData">proceed to load</a>
	<cfelse>
		The data you loaded do not validate. <a href="BulkloadCitations.cfm?action=csv">get the CSV</a>
	</cfif>
	<script src="/includes/sorttable.js"></script>
	<cfset header="STATUS,FULL_CITATION,PUBLICATION_ID,GUID_PREFIX,GUID,OTHER_ID_TYPE,OTHER_ID_NUMBER,TYPE_STATUS,OCCURS_PAGE_NUMBER,CITATION_REMARKS,SCIENTIFIC_NAME,ACCEPTED_ID_FG,NATURE_OF_ID,MADE_DATE,USE_PUB_AUTHORS,IDENTIFIER_1,IDENTIFIER_2,IDENTIFIER_3,IDENTIFICATION_REMARKS">
	<table border id="t" class="sortable">
		<tr>
			<cfloop list="#header#" index="i">
				<th>#i#</th>
			</cfloop>
		</tr>
		<cfloop query="valData">
			<tr>
				<cfloop list="#header#" index="i">
					<td>#evaluate("valData." & i)#</td>
				</cfloop>
			</tr>
		</cfloop>
	</table>
</cfoutput>
</cfif>
<!------------------------------------------------------->
<cfif #action# is "loadData">
<cfoutput>
	<cfquery name="getTempData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select * from cf_temp_citation
	</cfquery>
	<cftransaction>
	<cfloop query="getTempData">
	   <br>trying insert for
	   <cfif len(guid) gt 0>
		  <a href="/guid/#guid#">#guid#</a>
		<cfelse>
		  <a href="/SpecimenDetail.cfm?collection_object_id=#collection_object_id#">#collection_object_id#</a>
		</cfif>
		<cfif USE_EXISTING_ACCEPTED_ID is 0>
			<cfif accepted_id_fg is 1>
				<cfquery name="upOldID" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					UPDATE identification SET ACCEPTED_ID_FG=0 where collection_object_id = #collection_object_id#
				</cfquery>
			</cfif>
			<cfquery name="newID" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				INSERT INTO identification (
					IDENTIFICATION_ID,
					COLLECTION_OBJECT_ID,
					MADE_DATE,
					NATURE_OF_ID,
					ACCEPTED_ID_FG,
					IDENTIFICATION_REMARKS,
					taxa_formula,
					scientific_name,
					publication_id
				) VALUES (
					sq_identification_id.nextval,
					#COLLECTION_OBJECT_ID#,
					'#MADE_DATE#',
					'#NATURE_OF_ID#',
					#accepted_id_fg#,
					'#IDENTIFICATION_REMARKS#',
					'#taxa_formula#',
					'#scientific_name#',
					#publication_id#
				)
			</cfquery>
			<cfif USE_PUB_AUTHORS is true>
				<cfquery name="pa" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					select AGENT_ID from publication_agent where publication_id=#publication_id#
				</cfquery>
				<cfset ap=1>
				<cfloop query="pa">
					<cfquery name="newIdAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
						insert into identification_agent (
							identification_id,
							agent_id,
							identifier_order)
						values (
							sq_identification_id.currval,
							#AGENT_ID#,
							#ap#
							)
					</cfquery>
					<cfset ap=ap+1>
				</cfloop>
			<cfelse>
				<cfquery name="newIdAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					insert into identification_agent (
						identification_id,
						agent_id,
						identifier_order)
					values (
						sq_identification_id.currval,
						#agentid1#,
						1
						)
				</cfquery>
				<cfif len(agentid2) gt 0>
					<cfquery name="newIdAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
						insert into identification_agent (
							identification_id,
							agent_id,
							identifier_order)
						values (
							sq_identification_id.currval,
							#agentid2#,
							2
							)
					</cfquery>
				</cfif>
				<cfif len(agentid3) gt 0>
					<cfquery name="newIdAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
						insert into identification_agent (
							identification_id,
							agent_id,
							identifier_order)
						values (
							sq_identification_id.currval,
							#agentid1#,
							3
							)
					</cfquery>
				</cfif>
			</cfif>
			<cfquery name="newId2" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				INSERT INTO identification_taxonomy (
					identification_id,
					taxon_name_id,
					variable)
				VALUES (
					sq_identification_id.currval,
					#taxonid1#,
					'A')
			 </cfquery>
			 <cfif taxa_formula contains "B">
				 <cfquery name="newId3" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					INSERT INTO identification_taxonomy (
						identification_id,
						taxon_name_id,
						variable)
					VALUES (
						sq_identification_id.currval,
						#taxonid2#,
						'B')
				 </cfquery>
			 </cfif>
			<cfquery name="newCite" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				INSERT INTO citation (
					publication_id,
					collection_object_id,
					cit_current_fg,
					identification_id
					<cfif len(occurs_page_number) gt 0>
						,occurs_page_number
					</cfif>
					<cfif len(type_status) gt 0>
						,type_status
					</cfif>
					<cfif len(citation_remarks) gt 0>
						,citation_remarks
					</cfif>
				) VALUES (
					#publication_id#,
					#collection_object_id#,
					1,
					sq_identification_id.currval
					<cfif len(occurs_page_number) gt 0>
						,#occurs_page_number#
					</cfif>
					<cfif len(type_status) gt 0>
						,'#type_status#'
					</cfif>
					<cfif len(citation_remarks) gt 0>
						,'#citation_remarks#'
					</cfif>
				)
			</cfquery>
		<cfelse><!--- use existing accepted ID ---->
			<cfquery name="newCite" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				INSERT INTO citation (
					publication_id,
					collection_object_id,
					cit_current_fg,
					identification_id
					<cfif len(occurs_page_number) gt 0>
						,occurs_page_number
					</cfif>
					<cfif len(type_status) gt 0>
						,type_status
					</cfif>
					<cfif len(citation_remarks) gt 0>
						,citation_remarks
					</cfif>
				) VALUES (
					#publication_id#,
					#collection_object_id#,
					1,
					(select identification_id from identification where accepted_id_fg=1 and collection_object_id=#collection_object_id#)
					<cfif len(occurs_page_number) gt 0>
						,#occurs_page_number#
					</cfif>
					<cfif len(type_status) gt 0>
						,'#type_status#'
					</cfif>
					<cfif len(citation_remarks) gt 0>
						,'#citation_remarks#'
					</cfif>
				)
			</cfquery>
		</cfif>
		<cfquery name="getTempData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			update cf_temp_citation set status='loaded' where key=#key#
		</cfquery>
	</cfloop>
	</cftransaction>
<cflocation url="BulkloadCitations.cfm?action=allDone">
</cfoutput>
</cfif>
<!-------------------------------------------------------------------------->
<cfif action is "allDone">
	<cfoutput>
		<cfquery name="getTempData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select publication_id,full_citation,status from cf_temp_citation group by publication_id,full_citation,status
		</cfquery>

		<cfdump var=#getTempData#>
		<cfif getTempData.recordcount is 0>
			something very strange happened. Contact a sysadmin.
		</cfif>
		<cfloop query="getTempData">
			<cfif status is not "loaded">
				Something bad happened with #full_citation#. Contact your friendly local sysadmin.
			<cfelse>
				Everything seems to have worked! <a href="/Citation.cfm?publication_id=#publication_id#">View citations</a>
			</cfif>
		</cfloop>
	</cfoutput>
</cfif>
<cfinclude template="/includes/_footer.cfm">
