<cfinclude template="/includes/_header.cfm">

<cfsetting 
    requestTimeOut = "120000" >



<cfoutput>
	<!----
	
		create table temp_log_webquery (
			qdate varchar2(255),
			username varchar2(255),
			ip varchar2(255),
			term varchar2(255),
			cols varchar2(4000),
			hits number,
			uuid varchar2(255)
		);
		
		
		
<cfset sql="insert all ">
	---->
	<cffile action="read" variable="f" file="/usr/local/httpd/htdocs/wwwarctos/log/querylog.txt">
	
	
	
	
	
	
	<cfloop list="#f#" delimiters="#chr(10)#" index="line">
		<!----	<br>line: #line# 	---->
		<cfset rline=replace(line,"||||","||NULL||","all")>
		<!---- <br>rline: #line# ---->
	
		<cfset qs=listgetat(rline,4,"||")>
		<!---- <br>qs: #qs# ---->
		
		<cfloop list="#qs#" delimiters="?&" index="pair">
			<cfset term=listgetat(pair,1,"=")>
			<br>
			insert into temp_log_webquery (
					qdate,
					username,
					ip,
					term,
					cols,
					hits,
					uuid
				) values (
					'#listgetat(rline,1,"||")#',
					'#listgetat(rline,2,"||")#',
					'#listgetat(rline,3,"||")#',
					'#term#',
					'#listgetat(rline,5,"||")#',
					'#listgetat(rline,6,"||")#',
					'#listgetat(rline,7,"||")#'
				)
				
				<cftry>
				<cfquery name="d" datasource="uam_god">
				 insert into temp_log_webquery (
					qdate,
					username,
					ip,
					term,
					cols,
					hits,
					uuid
				) values (
					'#listgetat(rline,1,"||")#',
					'#listgetat(rline,2,"||")#',
					'#listgetat(rline,3,"||")#',
					'#term#',
					'#listgetat(rline,5,"||")#',
					'#listgetat(rline,6,"||")#',
					'#listgetat(rline,7,"||")#'
				)
				</cfquery>
				<cfcatch>
					^^^^ that failed ^^^^
				</cfcatch>
				</cftry>

	
			<!----<br>term: #term#
			
			
			<br>    insert into temp_qt2 (term) values ('#term#') ;
			
			<cfset sql=sql & " into temp_qt2 (term) values ('#term#') ">
			---->
			
			
			
			
		</cfloop>
	</cfloop>
		
		
	

	 
	 
	<!----
	<cfset sql=sql & " select 1 from dual">
	
		<br>
	
	 select 1 from dual
	<cfquery name="d" datasource="uam_god">
		#preserveSingleQuotes(sql)#
	</cfquery>
	
	
	
	#sql#
	
	
	select term, count(*) from temp_log_webquery group by term order by count(*);
	
	
	
	temp_log_webquery
	
	
	
	<cfquery name="d" datasource="uam_god">
		#preserveSingleQuotes(sql)#
	</cfquery>
	
	---->
	

</cfoutput>




<!----
drop table temp_mp;

create table temp_mp as select media_id,media_uri,PREVIEW_URI from media where PREVIEW_URI is not null;

alter table temp_mp add checkeddate date;
alter table temp_mp add previewfilesize number;
alter table temp_mp add previewstatus varchar2(200);
alter table temp_mp add mediastatus varchar2(200);


create unique index ix_temp_mid on temp_mp(media_id) tablespace uam_idx_1;






	<cfquery name="d" datasource="uam_god">
		select * from temp_mp where previewfilesize is null and rownum<500
	</cfquery>
	<cfloop query="d">
		<cfhttp method="head" timeout="2" url="#PREVIEW_URI#"></cfhttp>
		<cfset pfs=cfhttp.Responseheader["Content-Length"]>
		<cfset ps=cfhttp.Responseheader.Status_Code>
		<cfif media_uri contains 'http://web.corral.tacc.utexas.edu'>
			<cfset ms='on_tacc_nocheck'>
		<cfelse>
			<cfhttp method="head" timeout="2" url="#media_uri#"></cfhttp>
			<cfset ms=cfhttp.Responseheader["Status_Code"]>
		</cfif>
		<cfquery name="u" datasource="uam_god">
			update 
				temp_mp 
			set 
				checkeddate=sysdate,
				previewfilesize=#pfs#,
				previewstatus='#ps#',
				mediastatus='#ms#'
			where 
				media_id=#media_id#
		</cfquery>
	</cfloop>
</cfoutput>


---->