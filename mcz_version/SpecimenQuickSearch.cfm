<cfinclude template="/includes/_header.cfm">
<cfhtmlhead text='<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;sensor=false&amp;key=#application.gmap_api_key#" type="text/javascript"></script>'>
<script src="/includes/jquery/jquery-autocomplete/jquery.autocomplete.pack.js" language="javascript" type="text/javascript"></script>
<cfset title="Specimen Search">
<cfset metaDesc="Search for museum specimens and observations by taxonomy, identifications, specimen attributes, and usage history.">
<cfoutput>
<cfquery name="getCount" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select count(collection_object_id) as cnt from cataloged_item
</cfquery>
<cfquery name="ctmedia_type" datasource="cf_dbuser" cachedwithin="#createtimespan(0,0,60,0)#">
	select media_type from ctmedia_type order by media_type
</cfquery>
<cfquery name="hasCanned" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select SEARCH_NAME,URL
	from cf_canned_search,cf_users
	where cf_users.user_id=cf_canned_search.user_id
	and username='#session.username#'
	and URL like '%SpecimenResults.cfm%'
	order by search_name
</cfquery>



<table cellpadding="0" cellspacing="0">
	<tr>
		<td>
			Access to #getCount.cnt#
			<cfif len(#session.exclusive_collection_id#) gt 0>
				<cfquery name="coll" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
					select collection
					from collection where
					collection_id=#session.exclusive_collection_id#
				</cfquery>
				<strong>#coll.collection#</strong>
			records. <a href="searchAll.cfm">Search all collections</a>.
			<cfelse>
			records.
			</cfif>
		</td>
		<td style="padding-left:2em;padding-right:2em;">
			<span class="infoLink" onClick="getHelp('CollStats');">
				Holdings Details
			</span>
		</td>
		<cfif #hasCanned.recordcount# gt 0>
			<td style="padding-left:2em;padding-right:2em;">
				Saved Searches: <select name="goCanned" id="goCanned" size="1" onchange="document.location=this.value;">
					<option value=""></option>
					<option value="saveSearch.cfm?action=manage">[ Manage ]</option>
					<cfloop query="hasCanned">
						<option value="#url#">#SEARCH_NAME#</option><br />
					</cfloop>
				</select>
			</td>
		</cfif>
		<td style="padding-left:2em;padding-right:2em;">
			<span style="color:red;">
				<cfif #action# is "dispCollObj">
					<p>You are searching for items to add to a loan.</p>
				<cfelseif #action# is "encumber">
					<p>You are searching for items to encumber.</p>
				<cfelseif #action# is "collEvent">
					<p>You are searching for items to change collecting event.</p>
				<cfelseif #action# is "identification">
					<p>You are searching for items to reidentify.</p>
				<cfelseif #action# is "addAccn">
					<p>You are searching for items to reaccession.</p>
				</cfif>
			</span>
		</td>
	</tr>
</table>	
<form method="post" action="SpecimenResults.cfm" name="SpecData" id="SpecData" onSubmit="getFormValues()">
<table>
	<tr>
		<td valign="top">
			<input type="submit" value="Search" class="schBtn" 
			    onmouseover="this.className='schBtn btnhov'" onmouseout="this.className='schBtn'">	
		</td>
		<td valign="top">
			<input type="reset" name="Reset" value="Clear Form" class="clrBtn" 
			    onmouseover="this.className='clrBtn btnhov'" onmouseout="this.className='clrBtn'">
		</td>
		<td valign="top">
			<input type="button" name="Previous" value="Use Last Values" class="lnkBtn"	onclick="setPrevSearch()">
		</td>
		<td align="right" valign="top">
			<b>See&nbsp;results&nbsp;as:</b>
		</td>
		<td valign="top">
		 	<select name="tgtForm1" id="tgtForm1" size="1"  onChange="changeTarget(this.id,this.value);">
				<option value="">Specimen Records</option>
				<option value="SpecimenResultsHTML.cfm">HTML Specimen Records</option>
				<option  value="/bnhmMaps/bnhmMapData.cfm">BerkeleyMapper Map</option>
				<option  value="/bnhmMaps/kml.cfm?action=newReq">KML</option>
				<option value="SpecimenResultsSummary.cfm">Specimen Summary</option>
				<option  value="SpecimenGraph.cfm">Graph</option>
			</select>
		</td>
		<td align="left">
			<div id="groupByDiv1" style="display:none;border:1px solid green;padding:.5em;">
				<font size="-1"><em><strong>Group by:</strong></em></font><br>
				<select name="groupBy1" id="groupBy1" multiple size="4" onchange="changeGrp(this.id)">
					<option value="">Scientific Name</option>
					<option value="continent_ocean">Continent</option>
					<option value="country">Country</option>
					<option value="state_prov">State</option>
					<option value="county">County</option>
					<option value="quad">Map Name</option>
					<option value="feature">Feature</option>
					<option value="island">Island</option>
					<option value="island_group">Island Group</option>
					<option value="sea">Sea</option>
					<option value="spec_locality">Specific Locality</option>
					<option value="yr">Year</option>
				</select>
			</div>
			<div id="kmlDiv1" style="display:none;border:1px solid green;padding:.5em;">
				<font size="-1"><em><strong>KML Options:</strong></em></font><br>
				<label for="next1">Color By</label>
				<select name="next1" id="next1" onchange="kmlSync(this.id,this.value)">
					<option value="colorByCollection">Collection</option>
					<option value="colorBySpecies">Species</option>
				</select>
				<label for="method1">Method</label>
				<select name="method1"  id="method1" onchange="kmlSync(this.id,this.value)">
					<option value="download">Download</option>
					<option value="link">Download Linkfile</option>
					<option value="gmap">Google Maps</option>
				</select>
				<label for="includeTimeSpan1">include Time?</label>
				<select name="includeTimeSpan1"  id="includeTimeSpan1" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="showUnaccepted1">Show unaccepted determinations?</label>
				<select name="showUnaccepted1"  id="showUnaccepted1" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="mapByLocality1">All specimens from localities?</label>
				<select  name="mapByLocality1" id="mapByLocality1" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="showErrors1">Show error radii?</label>
				<select  name="showErrors1" id="showErrors1" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
			</div>
		</td>
		
	</tr>
</table>
<div>
	<span class="helpLink" id="observations">Include&nbsp;Observations?</span><input type="checkbox" name="showObservations" id="showObservations" value="1" onchange="changeshowObservations(this.checked);"<cfif session.showObservations eq 1> checked="checked"</cfif>>
	&nbsp;&nbsp;&nbsp;<span class="helpLink" id="_is_tissue">Require&nbsp;Tissues?</span><input type="checkbox" name="is_tissue" id="is_tissue" value="1">
	&nbsp;&nbsp;&nbsp;<span class="helpLink" id="_media_type">Require&nbsp;Media</span>:<select name="media_type" id="media_type" size="1">
				<option value=""></option>
                <option value="any">Any</option>
				<cfloop query="ctmedia_type">
					<option value="#ctmedia_type.media_type#">#ctmedia_type.media_type#</option>
				</cfloop>
			</select>
</div>
<input type="hidden" name="Action" value="#Action#">



	<div class="secDiv">
		<table class="ssrch">
			<tr>
				<td colspan="2" class="secHead">
						<span class="secLabel">Quick Search</span>
				</td>
			</tr>
			<tr>
				<td class="lbl">
					<span class="helpLink" id="containssearch">Free Text Search Terms:</span> 
					<span class="infoLink" onClick="getHelp('containssearch');">
						Search hints
					</span>
				</td>
				<td class="srch">
					<input type="text" name="containssearch" id="containssearch" size="50">
				</td>
			</tr>
		</table>
	</div>


<table>
	<tr>
		<td valign="top">
			<input type="submit" value="Search" class="schBtn"
			onmouseover="this.className='schBtn btnhov'" onmouseout="this.className='schBtn'">
		</td>
		<td valign="top">
			<input type="reset" name="Reset" value="Clear Form" class="clrBtn" 
			
		</td>
		<td valign="top">
			<input type="button" name="Previous" value="Use Last Values" class="lnkBtn"	onclick="setPrevSearch()">
		</td>
		<td valign="top" align="right">
			<b>See results as:</b>
		</td>
		<td align="left" colspan="2" valign="top">
			<select name="tgtForm" id="tgtForm" size="1" onChange="changeTarget(this.id,this.value);">
				<option value="">Specimen Records</option>
				<option value="SpecimenResultsHTML.cfm">HTML Specimen Records</option>
				<option  value="/bnhmMaps/bnhmMapData.cfm">BerkeleyMapper Map</option>
				<option  value="/bnhmMaps/kml.cfm?action=newReq">KML</option>
				<option value="SpecimenResultsSummary.cfm">Specimen Summary</option>
				<option  value="SpecimenGraph.cfm">Graph</option>
				<cfif isdefined("session.username") AND (#session.username# is "link" OR #session.username# is "dusty")>
				<option  value="/CustomPages/Link.cfm">Link's Form</option>
				</cfif>
				<cfif isdefined("session.username") AND (#session.username# is "cindy" OR #session.username# is "dusty")>
				<option  value="/CustomPages/CindyBats.cfm">Cindy's Form</option>
				</cfif>
			</select>
		</td>
		<td align="left">
			<div id="groupByDiv" style="display:none;border:1px solid green;padding:.5em;">
			<font size="-1"><em><strong>Group by:</strong></em></font><br>
			<select name="groupBy" id="groupBy" multiple size="4" onchange="changeGrp(this.id)">
				<option value="">Scientific Name</option>
				<option value="continent_ocean">Continent</option>
				<option value="country">Country</option>
				<option value="state_prov">State</option>
				<option value="county">County</option>
				<option value="quad">Map Name</option>
				<option value="feature">Feature</option>
				<option value="island">Island</option>
				<option value="island_group">Island Group</option>
				<option value="sea">Sea</option>
				<option value="spec_locality">Specific Locality</option>
				<option value="yr">Year</option>
			</select>
			</div>
			<div id="kmlDiv" style="display:none;border:1px solid green;padding:.5em;">
				<font size="-1"><em><strong>KML Options:</strong></em></font><br>
				<label for="next">Color By</label>
				<select name="next" id="next" onchange="kmlSync(this.id,this.value)">
					<option value="colorByCollection">Collection</option>
					<option value="colorBySpecies">Species</option>
				</select>
				<label for="method">Method</label>
				<select name="method" id="method" onchange="kmlSync(this.id,this.value)">
					<option value="download">Download</option>
					<option value="link">Download Linkfile</option>
					<option value="gmap">Google Maps</option>
				</select>
				<label for="includeTimeSpan">include Time?</label>
				<select name="includeTimeSpan" id="includeTimeSpan" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="showUnaccepted">Show unaccepted determinations?</label>
				<select name="showUnaccepted" id="showUnaccepted" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="mapByLocality">All specimens from localities?</label>
				<select name="mapByLocality" id="mapByLocality" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
				<label for="showErrors">Show error radii?</label>
				<select name="showErrors" id="showErrors" onchange="kmlSync(this.id,this.value)">
					<option value="0">no</option>
					<option value="1">yes</option>
				</select>
			</div>
		</td>
	</tr>
</table> 
<cfif isdefined("transaction_id") and len(transaction_id) gt 0>
	<input type="hidden" name="transaction_id" value="#transaction_id#">
</cfif>
<input type="hidden" name="newQuery" value="1"><!--- pass this to the next form so we clear the cache and run the proper queries--->
</form>
</cfoutput>
<script type='text/javascript' language='javascript'>
	jQuery(document).ready(function() {
	  	var tval = document.getElementById('tgtForm').value;
		changeTarget('tgtForm',tval);
		changeGrp('groupBy');
		jQuery.getJSON("/component/functions.cfc",
			{
				method : "getSpecSrchPref",
				returnformat : "json",
				queryformat : 'column'
			},
			function (getResult) {
				if (getResult == "cookie") {
					var cookie = readCookie("specsrchprefs");
					if (cookie != null) {
						r_getSpecSrchPref(cookie);
					}
				}
				else
					r_getSpecSrchPref(getResult);
			}
		);
		
			jQuery.get("/form/browse.cfm", function(data){
				 jQuery('body').append(data);
			})
			
	});
	jQuery("#partname").autocomplete("/ajax/part_name.cfm", {
		width: 320,
		max: 50,
		autofill: false,
		multiple: false,
		scroll: true,
		scrollHeight: 300,
		matchContains: true,
		minChars: 1,
		selectFirst:false
	});	
	function r_getSpecSrchPref (result){
		var j=result.split(',');
		for (var i = 0; i < j.length; i++) {
			if (j[i].length>0){
				showHide(j[i],1);
			}
		}
	}
	function kmlSync(tid,tval) {
		var rMostChar=tid.substr(tid.length -1,1);
		if (rMostChar=='1'){
			theOtherField=tid.substr(0,tid.length -1);
		} else {
			theOtherField=tid + '1';
		}
		document.getElementById(theOtherField).value=tval;
	}
	function changeGrp(tid) {
		if (tid == 'groupBy') {
			var oid = 'groupBy1';
		} else {
			var oid = 'groupBy';
		}
		var mList = document.getElementById(tid);
		var sList = document.getElementById(oid);
		var len = mList.length;
		for (i = 0; i < len; i++) {
			sList.options[i].selected = false;
		}
		for (i = 0; i < len; i++) {
			if (mList.options[i].selected) {
				sList.options[i].selected = true;
			}
		}
	}
	function changeTarget(id,tvalue) {
		if(tvalue.length == 0) {
			tvalue='SpecimenResults.cfm';
		}
		if (id =='tgtForm1') {
			var otherForm = document.getElementById('tgtForm');
		} else {
			var otherForm = document.getElementById('tgtForm1');
		}
		otherForm.value=tvalue;
		document.getElementById('groupByDiv').style.display='none';
		document.getElementById('groupByDiv1').style.display='none';
		document.getElementById('kmlDiv').style.display='none';
		document.getElementById('kmlDiv1').style.display='none';
		if (tvalue == 'SpecimenResultsSummary.cfm') {
			document.getElementById('groupByDiv').style.display='';
			document.getElementById('groupByDiv1').style.display='';
		} else if (tvalue=='/bnhmMaps/kml.cfm?action=newReq') {
			document.getElementById('kmlDiv').style.display='';
			document.getElementById('kmlDiv1').style.display='';
		}
		document.SpecData.action = tvalue;
	}
	function setPrevSearch(){
		var schParam=get_cookie ('schParams');
		var pAry=schParam.split("|");
	 	for (var i=0; i<pAry.length; i++) {
	 		var eAry=pAry[i].split("::");
	 		var eName=eAry[0];
	 		var eVl=eAry[1];
	 		if (document.getElementById(eName)){
				document.getElementById(eName).value=eVl;
				if (eName=='tgtForm' && (eVl=='/bnhmMaps/kml.cfm?action=newReq' || eVl=='SpecimenResultsSummary.cfm')) {
					changeTarget(eName,eVl);
				}
			}
	 	}
	}
</script>
<cfinclude template = "includes/_footer.cfm">
