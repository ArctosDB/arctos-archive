<cfinclude template="/includes/_header.cfm">
<script src="/includes/sorttable.js"></script>
<cfset title="MCZbase Holdings">
<cfset metaDesc="Links to individual collections web pages and loan policy.">
<cfquery name="colls" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select 
		collection.collection,
		collection.collection_id,
		descr,
		web_link,
		web_link_text,
		loan_policy_url,
		count(cat_num) as cnt
	from 
		collection,
		cataloged_item
	where
		collection.collection_id = cataloged_item.collection_id
	group by
		collection.collection,
		collection.collection_id,
		descr,
		web_link,
		web_link_text,
		loan_policy_url
	order by collection.collection
</cfquery>

	<h2>MCZbase Holdings</h2>

<br />You may pick a default collection using the Customize link on SpecimenSearch. 

<table border id="t" class="sortable">
<tr>
	<th>
		<strong>Collection</strong>
	</th>
	<th>
		<strong>Description</strong>
	</th>
	<th>
		<strong>Website</strong>
	</th>
	<th>
		<strong>Loan Policy</strong>
	</th>
	<th>
		<strong>Specimens</strong>
	</th>
</tr>
<cfoutput query="colls">
	<tr>
		<td>
			<cfif #COLLECTION# EQ "Invertebrate Zoology">Invertebrate Zoology (incl. Marine Invertebrates)
			<CFELSE>#COLLECTION#
			</cfif>
		</td>
		<td>
			<cfif #DESCR# EQ "MCZ Invertebrate Zoology Collection">MCZ Invertebrate Zoology Collection (incl. Marine Invertebrates)
			<CFELSE>#DESCR#
			</cfif>
		</td>
		<td>
			<cfif #COLLECTION# EQ "Invertebrate Zoology">
				<table>
					<tr>
						<td>
						<cfif len(#WEB_LINK#) gt 0 and len(#WEB_LINK_TEXT#) gt 0>
						<a href="#WEB_LINK#" target="_blank">#WEB_LINK_TEXT#</a>
						<cfelse>
							None
						</cfif>
						</td>
					</tr>
					<tr>
						<td>
						<a href="http://www.mcz.harvard.edu/Departments/MarineInverts/">MCZ Marine Invertebrates</a>
						</td>
					</tr>
				</table>
			<cfelse>
				<cfif len(#WEB_LINK#) gt 0 and len(#WEB_LINK_TEXT#) gt 0>
					<a href="#WEB_LINK#" target="_blank">#WEB_LINK_TEXT#</a>
				<cfelse>
					None
				</cfif>
			</cfif>
		</td>
		<td>
			<cfif #COLLECTION# EQ "Invertebrate Zoology">
				<table>
					<tr>
						<td>
						<cfif len(#loan_policy_url#) gt 0 and len(#loan_policy_url#) gt 0>
							<a href="#loan_policy_url#" target="_blank">IZ Loan Policy</a>
						<cfelse>
							None
						</cfif>
						</td>
					</tr>
					<tr>
						<td>
						<a href="http://www.mcz.harvard.edu/Departments/MarineInverts/policies.html" target="_blank">MI Loan Policy</a>
						</td>
					</tr>
				</table>
			<cfelse>
				<cfif len(#loan_policy_url#) gt 0 and len(#loan_policy_url#) gt 0>
					<a href="#loan_policy_url#" target="_blank">Loan Policy</a>
				<cfelse>
					None
				</cfif>
			</cfif>
		</td>
		<td><a href="/SpecimenSearch.cfm?collection_id=#collection_id#">#cnt#</a></td>
	</tr>
</cfoutput>
</table>
<cfinclude template="/includes/_footer.cfm">