<cfcomponent name="tests.TestListcatnumToBasQual" displayname="tests.TestListcatnumToBasQual" extends="mxunit.framework.TestCase">
	<cfinclude template="../includes/functionLib.cfm">

    <cffunction name="testScriptNumberListToSQLWhere" returntype="void" access="public" hint="Tests ScriptNumberListToSQLWhere()">
		<!---  "( fieldname IN (list))"  or "( fieldname >= num AND fieldname <=num)" or "" --->
        <cfscript>
	     assertEquals(" fieldname IN ( 1 ) ", ScriptNumberListToSQLWhere("1","fieldname"));
	     assertEquals(" fieldname IN ( 1234567890 ) ", ScriptNumberListToSQLWhere("1234567890","fieldname"));
	     assertEquals(" fieldname IN ( 1234567890 ) ", ScriptNumberListToSQLWhere("1234567890a","fieldname"));
	     assertEquals(" fieldname IN ( 1234567890 ) ", ScriptNumberListToSQLWhere("1234567890X","fieldname"));
	     assertEquals(" ( fieldname >= 1 AND fieldname <= 4 ) ", ScriptNumberListToSQLWhere("1-4","fieldname"));
	     assertEquals(" ( fieldname >= 1 AND fieldname <= 4 ) ", ScriptNumberListToSQLWhere("4-1","fieldname"));
	     assertEquals("", ScriptNumberListToSQLWhere("A","fieldname"));
	     assertEquals("", ScriptNumberListToSQLWhere("","fieldname"));
	     assertEquals("", ScriptNumberListToSQLWhere("-","fieldname"));
        </cfscript>
    </cffunction>

    <cffunction name="testScriptPrefixedNumberListToSQLWherePrefix" returntype="void" access="public" hint="Tests ScriptPrefixedNumberListToSQLWherePrefix()">
        <!--- 
	    ScriptPrefixedNumberListToSQLWherePrefix(listOfNumbers, integerFieldname, prefixFieldname, embeddedSeparator) { 
		--->	
		<cfscript>
                // a single number
		assertEquals(" ( intfield IN ( 1000 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("1000","intfield","prefield",true));
		assertEquals(" ( intfield IN ( 1 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("1","intfield","prefield",true));
                // a single number with a prefix
		assertEquals(" ( ( prefield = 'A-' AND ( intfield IN ( 1 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'S-' AND ( intfield IN ( 800 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("S-800","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'S-' AND ( intfield IN ( 800 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("S800","intfield","prefield",true));
                // a range of numbers with a prefix 
		assertEquals(" ( ( prefield = 'A-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1-5","intfield","prefield",true));
                // a range of numbers without a prefix 
		assertEquals(" ( ( intfield >= 1 AND intfield <= 5 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("1-5","intfield","prefield",true));

                // turn off separator in the prefix field
		assertEquals(" ( ( prefield = 'Z' AND ( intfield IN ( 1 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("Z-1","intfield","prefield",0));
		assertEquals(" ( ( prefield = 'S' AND ( intfield IN ( 800 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("S-800","intfield","prefield",0));
		assertEquals(" ( ( prefield = 'S' AND ( intfield IN ( 800 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("S800","intfield","prefield",0));
		assertEquals(" ( ( prefield = 'A' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1-5","intfield","prefield",0));

                // a comma delimited list of two numbers
		assertEquals(replace(" ( intfield IN ( 1 ) OR intfield in ( 2 ) ) "," ",".","All"),
                             replace(ScriptPrefixedNumberListToSQLWherePrefix("1,2","intfield","prefield",true)," ",".","All")
                             );
                // a comma delimited list of three numbers
		assertEquals(" ( intfield IN ( 1 ) OR intfield in ( 2 ) OR intfield in ( 1000 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("1,2,1000","intfield","prefield",true));
                // a comma delimited list of two numbers with the same prefix
		assertEquals(" ( ( prefield = 'A-' AND ( intfield IN ( 1 ) ) ) OR ( prefield = 'A-' AND ( intfield IN ( 2 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1,A-2","intfield","prefield",true));
                // a comma delimited list of two numbers with different prefixes 
		assertEquals(" ( ( prefield = 'A-' AND ( intfield IN ( 1 ) ) ) OR ( prefield = 'R-' AND ( intfield IN ( 2 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1,R-2","intfield","prefield",true));
                // a bare dash separator adds no term
		assertEquals("",ScriptPrefixedNumberListToSQLWherePrefix("-","intfield","prefield",true));
                // a comma separated list of dashes adds no term
		assertEquals("",ScriptPrefixedNumberListToSQLWherePrefix("-,-","intfield","prefield",true));
		assertEquals("",ScriptPrefixedNumberListToSQLWherePrefix("-,--","intfield","prefield",true));
		assertEquals("",ScriptPrefixedNumberListToSQLWherePrefix("-,-,-,-","intfield","prefield",true));
                // just a prefix with o number 
		assertEquals(replace(" ( ( prefield = 'PRE-' ) ) "," ",".","All"),
		             replace(ScriptPrefixedNumberListToSQLWherePrefix("PRE","intfield","prefield",true)," ",".","All")
		             );
                // a comma delimited list of prefixes 
		assertEquals(replace(" ( ( prefield = 'PRE-' ) OR ( prefield = 'OTHER-' ) ) "," ",".","All"),
		             replace(ScriptPrefixedNumberListToSQLWherePrefix("PRE,OTHER","intfield","prefield",true)," ",".","All")
		             );
                // a prefix and a suffix without a number 
                // TODO: this will fail if suffix support is added.
		assertEquals(replace(" ( ( prefield = 'PRE-' ) ) "," ",".","All"),
		             replace(ScriptPrefixedNumberListToSQLWherePrefix("PRE-suff","intfield","prefield",true)," ",".","All")
		             );
                // a coma delimited list of two numbers with different prefixes, with and extra comma
		assertEquals(replace(" ( ( prefield = 'B-' AND ( intfield IN ( 1 ) ) ) OR ( prefield = 'A-' AND ( intfield IN ( 2 ) ) ) ) "," ",".","All"),
                             replace(ScriptPrefixedNumberListToSQLWherePrefix("B-1,,A-2,","intfield","prefield",true)," ",".","All")
                             );
                // a comma delimited list with an extra dash as the last element
		assertEquals(" ( ( prefield = 'C-' AND ( intfield IN ( 1 ) ) ) OR ( prefield = 'A-' AND ( intfield IN ( 2 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("C-1,A-2,-","intfield","prefield",true));
		</cfscript>
	</cffunction>

	<cffunction name="testScriptPrefixedNumberListToSQLWherePrefixLists" returntype="void" access="public" hint="Tests ScriptPrefixedNumberListToSQLWherePrefix() for lists">
		<cfscript>
		assertEquals(" ( ( prefield = 'A-' AND ( ( intfield >= 1000 AND intfield <= 1500 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1000-1500","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'R-' AND ( ( intfield >= 1200 AND intfield <= 1210 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("R-1200-1210","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'Apre-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) OR ( prefield = 'Bpre-' ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("Apre-1-5,Bpre","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'Apre-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) OR intfield IN ( 2000 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("Apre-1-5,2000","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'Apre-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) OR ( prefield = 'Bpre-' ) OR intfield IN ( 5000 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("Apre-1-5,Bpre,5000","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'A-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) OR ( prefield = 'A-' AND ( intfield IN ( 5000 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1-5,A-5000","intfield","prefield",true));
		assertEquals(" ( ( prefield = 'A-' AND ( ( intfield >= 1 AND intfield <= 5 ) ) ) OR ( prefield = 'A-' AND ( intfield IN ( 5000 ) ) ) OR intfield IN ( 900 ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A-1-5,A-5000,900","intfield","prefield",true));
                // A139902,A139908-139920
		assertEquals(" ( ( prefield = 'A-' AND ( intfield in ( 139902 ) ) ) OR ( prefield = 'A-' AND ( ( intfield >= 139908 AND intfield <= 139920 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("A139902,A139908-139920","intfield","prefield",true));

		assertEquals(" ( ( prefield = 'R-' AND ( ( intfield >= 1200 AND intfield <= 1210 ) ) ) OR ( prefield = 'S-' ) OR ( prefield = 'BOM-' AND ( ( intfield >= 0 AND intfield <= 100 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("R-1200-1210,S,BOM-0-100","intfield","prefield",true));
                // list without dashes separating prefixes from numbers
		assertEquals(" ( ( prefield = 'R-' AND ( ( intfield >= 1200 AND intfield <= 1210 ) ) ) OR ( prefield = 'S-' ) OR ( prefield = 'BOM-' AND ( ( intfield >= 0 AND intfield <= 100 ) ) ) ) ",ScriptPrefixedNumberListToSQLWherePrefix("R1200-1210,S,BOM0-100","intfield","prefield",true));
		</cfscript>
    	</cffunction>


        <!---  Tests for the coldfusion wrapper for the supporting functions.  These will fail if an a parameter in the wrapper is changed  ---> 
	<cffunction name="testOldListcatnumToBasQual" returntype="void" access="public" hint="Tests listcatnumToBasQual">
		<!--- Basic tests for expected output ---->
		<!--- Test individual numbers, lists of individual numbers, and ranges --->
		<cfscript>
		assertEquals(" ( t.cat_num_integer IN ( 1 ) ) ", listcatnumToBasQualTable("1","t"));
		assertEquals(" ( t.cat_num_integer IN ( 54321 ) ) ", listcatnumToBasQualTable("54321","t"));
		assertEquals(" ( t.cat_num_integer IN ( 1 ) OR t.cat_num_integer IN ( 2 ) ) ", listcatnumToBasQualTable("1,2","t"));
		assertEquals(" ( t.cat_num_integer IN ( 1 ) OR t.cat_num_integer IN ( 2 ) ) ", listcatnumToBasQualTable("1, 2","t"));
		assertEquals(" ( t.cat_num_integer IN ( 1 ) OR t.cat_num_integer IN ( 2 ) OR t.cat_num_integer IN ( 3 ) ) ", listcatnumToBasQualTable("1,2,3","t"));
		assertEquals(" ( ( t.cat_num_integer >= 1 AND t.cat_num_integer <= 2 ) ) ", listcatnumToBasQualTable("1-2","t"));
		// Make sure that ranges in the form larger-smaller are handled correctly 
		assertEquals(" ( ( t.cat_num_integer >= 1 AND t.cat_num_integer <= 2 ) ) ", listcatnumToBasQualTable("2-1","t"));
		assertEquals(" ( ( t.cat_num_integer >= 1 AND t.cat_num_integer <= 3 ) ) ", listcatnumToBasQualTable("1-3","t"));
		// Test lists of both indivdual numbers and ranges of numbers 
		assertEquals(" ( t.cat_num_integer IN ( 1 ) OR ( t.cat_num_integer >= 4 AND t.cat_num_integer <= 6 ) ) ", listcatnumToBasQualTable("1,4-6","t"));
		assertEquals(" ( t.cat_num_integer IN ( 25 ) OR ( t.cat_num_integer >= 4 AND t.cat_num_integer <= 6 ) ) ", listcatnumToBasQualTable("25,4-6","t"));
		assertEquals(" ( t.cat_num_integer IN ( 25 ) OR ( t.cat_num_integer >= 4 AND t.cat_num_integer <= 6 ) OR t.cat_num_integer IN ( 50 ) ) ", listcatnumToBasQualTable("25,4-6,50","t"));
		</cfscript>
	</cffunction>
	
    <cffunction name="testListcatnumToBasQualPatholgies" returntype="void" access="public" hint="Tests listcatnumToBasQual">
        <!--- Tests for handling of expected problem cases ---->
        <cfscript>
        assertEquals(" ( t.cat_num_integer IN ( 1 ) OR t.cat_num_integer IN ( 2 ) ) ", listcatnumToBasQualTable("1,,2","t"));
        assertEquals(" ( t.cat_num_integer IN ( 1 ) OR t.cat_num_integer IN ( 2 ) ) ", listcatnumToBasQualTable("1, ,2","t"));
        assertEquals(" ( t.cat_num_integer IN ( 5 ) OR t.cat_num_integer IN ( 2 ) OR t.cat_num_integer IN ( 3 ) ) ", listcatnumToBasQualTable("5,2,-3","t"));
        assertEquals(" ( t.cat_num_integer IN ( 6 ) OR t.cat_num_integer IN ( 2 ) OR t.cat_num_integer IN ( 3 ) ) ", listcatnumToBasQualTable("6,2,3,-","t"));
        assertEquals(" ( t.cat_num_integer IN ( 1 ) OR ( t.cat_num_prefix = 'A-' ) ) ", listcatnumToBasQualTable("1,A","t"));
        assertEquals(" ( t.cat_num_integer IN ( 1 ) OR ( t.cat_num_prefix = 'A-' AND ( t.cat_num_integer IN ( 2 ) ) ) ) ", listcatnumToBasQualTable("1,A-2","t"));
	</cfscript>
    </cffunction>	
	<cffunction name="testListcatnumToBasQualFuzz" returntype="void" access="public" hint="Tests listcatnumToBasQual">
        <!--- Fuzz the list ---->
        <cfscript>
        assertEquals("", listcatnumToBasQualTable(",,,,,,,,","t"));
        assertEquals("", listcatnumToBasQualTable("-----------","t"));
        // length of bigint is 20, try a 21 digit number 
        assertEquals(" ( t.cat_num_integer IN ( 123456789012345678901 ) ) ", listcatnumToBasQualTable("123456789012345678901","t"));
        // now a valid case of just prefixes
        // assertEquals("", listcatnumToBasQualTable("AAAAA,BBBB,CCCC,DDDD-EEEE","t"));
        // sql injection 
        assertEquals(" ( ( t.cat_num_prefix = 'drop-' ) or ( t.cat_num_prefix = 'table-' ) or ( t.cat_num_prefix = 'dropThisTable-' ) ) ", listcatnumToBasQualTable("'; drop table dropThisTable","t"));
        assertEquals(" ( t.cat_num_integer IN ( 11 ) ) ", listcatnumToBasQualTable("1=1","t"));
        assertEquals(" ( t.cat_num_integer IN ( 11 ) ) ", listcatnumToBasQualTable(" 1=1 ","t"));
        assertEquals(" ( ( t.cat_num_prefix = 'OR-' ) OR t.cat_num_integer IN ( 11 ) ) ", listcatnumToBasQualTable(" OR 1=1 ","t"));
        </cfscript>
    </cffunction>  


</cfcomponent>
