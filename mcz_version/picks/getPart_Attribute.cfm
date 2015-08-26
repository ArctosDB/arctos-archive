<cfinclude template="/includes/alwaysInclude.cfm">
<link rel="stylesheet" type="text/css" href="/includes/_DEstyle.css">
<div id="divpopup_part_att">
  <h1 class="popup_part_att">Combinations of Part Attributes and Values</h1>
<!---
  <dl class="popup_part_att">
    <dt class="popup_part_att">caste</dt>
    <dd class="popup_part_att"> #k#</dd>

  </dl>--->

<cfif action is "nothing">
  <cfoutput>
    <cfquery name="ctAttribute_type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select distinct(attribute_type) from ctspecpart_attribute_type
		</cfquery>
    <cfquery name="thisRec" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			Select * from ctspec_part_att_att
			order by attribute_type
		</cfquery>
    <cfquery name="age_classCT" datasource="uam_god">
			select age_class from mczbase.ctage_class
		</cfquery>
    <cfquery name="casteCT" datasource="uam_god">
			select caste from mczbase.ctcaste
		</cfquery>
    <cfquery name="partassocCT" datasource="uam_god">
			select partassociation from mczbase.ctpartassociation
	</cfquery>
   
    <table class="newRec" border>
      <form>
        <tr>
          <th>Attribute</th>
          <th>Value</th>
        </tr>
        <tr>
          <td>caste</td>
          <td><cfset thisValueTable = #casteCT.caste#>
            <select name="value_code_table" size="1">
              <option value="">select</option>
              <cfloop query="casteCT">
                <option 
					value="#casteCT.caste#">#casteCT.caste#</option>
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>age class</td>
          <td><cfset thisValueTable = #age_classCT.age_class#>
            <select name="value_code_table" size="1">
              <option value="">select</option>
              <cfloop query="age_classCT">
                <option 
							value="#age_classCT.age_class#">#age_classCT.age_class#</option>
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>part association</td>
          <td><cfset thisValueTable = #partassocCT.partassociation#>
            <select name="value_code_table" size="1">
              <option value="">select</option>
              <cfloop query="partassocCT">
                <option 
							value="#partassocCT.partassociation#">#partassocCT.partassociation#</option>
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>chromosome number</td>
          <td>fill in number</td>
        <tr>
          <td>remaining volume</td>
          <td>fill in number and units</td>
        </tr>
        <tr>
          <td>NCBI BioProject number</td>
          <td>fill in number</td>
        </tr>
        <tr>
          <td>NCBI BioSample number</td>
          <td>fill in number</td>
        </tr>
        <tr>
          <td>NCBI GenBank ID</td>
          <td>fill in number</td>
        </tr>
        <tr>
          <td>scientific name</td>
          <td>pick list to come</td>
        </tr>
        <tr>
          <td>section plane</td>
          <td>transverse, longitudinal, horizontal, saggital</td>
        </tr>
        <tr>
          <td>section stain</td>
          <td> pick list to come</td>
        </tr>
        <tr>
          <td>sex</td>
          <td> pick list to come</td>
        </tr>
        <tr>
          <td>section depth</td>
          <td>fill in number and units</td>
        </tr>
        <tr>
          <td>section length</td>
          <td>fill in number and units</td>
        </tr>
        <tr>
          <td>section fixation</td>
          <td>pick list to come</td>
        </tr>
        <tr>
          <td>material sample</td>
          <td>fill in number</td>
        </tr>
          </tr>
        
      </form>
    </table>
    </div>
  </cfoutput>
</cfif>
