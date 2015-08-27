<cfinclude template="/includes/_header.cfm">
<cfsetting requestTimeOut = "1200" >

<!----
create table temp_eh_truncs (cn varchar2(255),cdn varchar2(4000),rmk varchar2(4000),dsc varchar2(4000));





---->


<form enctype="multipart/form-data" method="post" action="a.cfm">
		<input type="hidden" name="action" value="getFile">
		<label for="FiletoUpload">Upload crappy 4d "xml"</label>
		<input type="file" name="FiletoUpload" size="45" >
		<input type="submit" value="Upload this file" class="insBtn">
	</form>
	
	<a href="a.cfm?action=unxml">unxml</a>
<cfif isdefined("FiletoUpload")>
	<cffile action="READ" file="#FiletoUpload#" variable="fileContent">
	<cfset fc=rereplace(filecontent,'[^[:print:]]',' ','all')>
	<cfset fc=rereplace(fc,'  ',' ','all')>
	<cfset fc=replace(fc,"'","''",'all')>
	<cfset fc=replace(fc,"&apos;","''",'all')>
	<cfset fc=replace(fc,"&quot;",'"','all')>
	<cfset fc=replace(fc,'"','""','all')>
	<cfset fc=replace(fc,"<Catalog Number>","<CatalogNumber>",'all')>
	<cfset fc=replace(fc,"</Catalog Number>","</CatalogNumber>",'all')>
	
	<!--- put the header back in ---->
	<cfset fc=replace(fc,'<?xml version=""1.0"" encoding=""ISO-8859-1""?>','<?xml version="1.0" encoding="ISO-8859-1"?>','all')>
	
	


<!----
	<cfdump var=#fc#>
	-------->
	
	<cffile action="write" file="#Application.webDirectory#/download/temp.xml" nameConflict="overwrite" output="#fc#" charset="ISO-8859-1">
	
	<cflocation url="/download.cfm?file=temp.xml">
	
</cfif>

<cfif action is "unxml1">

	
	
	<cfset fis = createObject("java", "java.io.FileInputStream").init("#Application.webDirectory#/temp/temp.xml")>
	<cfset bis = createObject("java", "java.io.BufferedInputStream").init(fis)>
	<cfset XMLInputFactory = createObject("java", "javax.xml.stream.XMLInputFactory").newInstance()>
	<cfset reader = XMLInputFactory.createXMLStreamReader(bis)>
	
	<cfoutput>
	    <cfset cn=''>
		<cfset remk=''>
	<cfset lastcn="">
	<cfset csv="cn,remark" & chr(10)>
	<cfloop condition="#reader.hasNext()#">
	    <cfset event = reader.next()>
	
	    <cfif event EQ reader.START_ELEMENT>
	        <cfswitch expression="#reader.getLocalName()#">
	            <cfcase value="CatalogNumber">
	                <!--- root node, do nothing --->
					<cfset cn = reader.getElementText()>
	            </cfcase>
	            <cfcase value="Remarks">
					<cfset remk = reader.getElementText()>
	                <!--- set values used later on for inserts, selects, updates --->
	            </cfcase>
	        </cfswitch>
	    </cfif>
	    <!----
	    <cfset arrayAppend(s,[#cn#,#remk#]) />
	    
	    
				
	
	
	
			

	------>
		<cfif cn is not lastcn and len(remk) gt 0>
			<cfset csv=csv & '"#cn#","#remk#"' & chr(10)>
			<!----
			<p>
				#cn#=#remk#
			</p>
			---->
			<cfset lastcn=cn> 
		</cfif>
		
	</cfloop>
	
	<!----

	<cfquery name="i" datasource="uam_god">
		#preservesinglequotes(sql)#
	</cfquery>
	
		<cfdump var=#s#>
	
	<hr>#s[1][1]#
	
	
	
	
	<cfset sql=replace(sql,"'","''",'all')>
	<cfset sql=replace(sql,"#chr(7)#","'",'all')>
	
	
<cfset sql=sql & " SELECT * FROM dual">


	
	<cfquery name="i" datasource="uam_god">
		#preservesinglequotes(sql)#
	</cfquery>
	
	
	------->
	
	
			<cffile action="write" file="#Application.webDirectory#/download/temp.csv" nameConflict="overwrite" output="#csv#" charset="ISO-8859-1">

	

	
	
	</cfoutput>
	<cfset reader.close()>



	
	
	<!----
	
	
	
	<cffile action="READ" file="#FiletoUpload#" variable="fileContent">
	--------->
	<!---
	<cfdump var=#fc#>
	
	
	
	
	
	<cfset x=xmlparse(fc)>
	<cfdump var=#x#>
	
	
	
	--->
	
	
	
</cfif>	


<cfif action is "unxml">
	<cffile action="READ" file="#Application.webDirectory#/temp/temp.xml" variable="rawfile">
	read<cfflush>
	<cfset x=xmlparse(rawfile)>
	parsed<cfflush>
	<cfset csv="cn,remark" & chr(10)>

	<cfoutput>
		<cfloop index="recordIndex" from="1" to="#arrayLen( x.Ethnocatalog.Ethnocatalog )#" step="1">
	 		<cfset recordNode = x.Ethnocatalog.Ethnocatalog[ recordIndex ] />
 			<cfset cn = recordNode.CatalogNumber.xmlText />
			<cfset remk = recordNode.Remarks.xmlText />
			<cfset csv=csv & '"#cn#","#remk#"' & chr(10)>
		</cfloop>
		<cffile action="write" file="#Application.webDirectory#/download/temp.csv" nameConflict="overwrite" output="#csv#" charset="ISO-8859-1">
	</cfoutput>
</cfif>