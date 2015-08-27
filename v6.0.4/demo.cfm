<cfinclude template="/includes/_header.cfm">

<cfform action="demo.cfm?action=newScans" method="post" enctype="multipart/form-data">
		<input type="file" name="FiletoUpload" size="45">
		<input type="submit" value="Upload this file" class="savBtn">
	</cfform>
	
	<cfif action is "newScans">
	
	<hr>got a file - here's the dump
			<cffile action="READ" file="#FiletoUpload#" variable="fileContent">
			<cfdump var=#fileContent#>
	</cfif>