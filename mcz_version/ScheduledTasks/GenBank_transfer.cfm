<!--- 
	builds reciprocal links from GenBank
	Run daily
	Run after adding GenBank other IDs
	Requires: 
		Application.genBankPrid
		Application.genBankPwd (encrypted)
		Application.genBankUsername
---->
<cfoutput>

<cfftp action="open" 
	timeout="6000" 
	username="#Application.genBankUsername#" 
	password="#decrypt(Application.genBankPwd,'genbank')#" 
	server="ftp-private.ncbi.nih.gov" 
	connection="genbank" 
	passive="yes">
<cfftp connection="genbank" action="changedir"  directory="holdings" passive="true">
	<cfftp connection="genbank" action="putfile" timeout="6000"	localfile="#Application.webDirectory#/temp/nucleotide.ft" remotefile="nucleotide.ft" name="Put_nucleotide" passive="true">
	<cfftp connection="genbank" action="putfile" passive="true" localfile="#Application.webDirectory#/temp/taxonomy.ft" remotefile="taxonomy.ft" name="Put_taxonomy">
	<cfftp connection="genbank" action="putfile" passive="true" localfile="#Application.webDirectory#/temp/names.ft" remotefile="names.ft" name="Put_names">
	<cfftp connection="genbank" action="close">
<!----

	

<cfftp 
    connection = "myConnection"
    action = "putFile" 
    name = "uploadFile" 
    transferMode = "binary" 
    localFile = "C:\files\upload\somewhere.jpg" 
    remoteFile = "somewhere_put.jpg">




	
---->
</cfoutput>