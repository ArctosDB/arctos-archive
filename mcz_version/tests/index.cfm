<cfinclude template="TestListcatnumToBasQual.cfc">
<cfscript>
     testsuite = createObject("component","mxunit.framework.TestSuite").TestSuite();
     testsuite.addAll("tests.TestListcatnumToBasQual");
     results = testsuite.run();
     writeOutput(results.getResultsOutput('html'));
</cfscript>