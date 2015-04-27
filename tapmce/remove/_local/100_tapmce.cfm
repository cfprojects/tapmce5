<cftry>
	<cfset plugin.remove() />
	<cfinclude template="/inc/pluginmanager/gohome.cfm" />
	
	<cfcatch>
		<cfinclude template="/inc/pluginmanager/error.cfm" />
	</cfcatch>
</cftry>
