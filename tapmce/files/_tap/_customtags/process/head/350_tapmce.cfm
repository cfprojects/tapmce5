<cftry>
	<cfset tinyMCE = getTap().MCE />
	<cfparam name="tinyMCE.path" type="string" default="" />
	<cfparam name="tinyMCE.mode" type="string" default="specific_textareas" />
	<cfset tinyMCE.mode = lcase(trim(tinyMCE.mode)) />
	<cfcatch>
		<cfset tinyMCE.path = "" />
	</cfcatch>
</cftry>

<cfif len(trim(tinyMCE.path)) and len(trim(tinyMCE.mode))>
	<cfparam name="tinyMCE.language" type="string" default="" />
	<cfparam name="tinyMCE.config" type="struct" default="#structnew()#" />
	
	<cfif not len(trim(tinyMCE.language))>
		<cfset tinyMCE.language = replace(getTap().getLocal().language,"-","_","ALL")>
		
		<cfloop condition="len(trim(tinyMCE.language))">
			<cfif fileExists(getFS().getPath(tinyMCE.path & "/langs/#tinyMCE.language#.js","T"))><cfbreak></cfif>
			<cfset tinyMCE.language = rereplacenocase(tinyMCE.language,"_?[[:alpha:]]+$","")>
		</cfloop>
		
		<cfif not len(trim(tinyMCE.path))>
			<cfset tinyMCE.language = listfirst(getTap().getLocal().defaultlanguage,"-_")>
			<cfif not fileExists(getFS().getPath(tinyMCE.path & "/langs/#tinyMCE.language#.js","T"))>
				<cfset tinyMCE.language = "en">
			</cfif>
		</cfif>
	</cfif>
	
	<cfoutput>
		<cfloop item="mcecb" collection="#tinyMCE.callbacks#">
			<cfset mcecbname = "mce_cb_" & mcecb>
			<cfset tinyMCE.config[mcecb] = mcecbname>
			#getLib().jsout(getLib().js.function(mcecbname,ArrayToList(tinyMCE.callbacks[mcecb],getTap().newline())))#
		</cfloop>
		
		<cfsavecontent variable="init_mce">
			tinyMCE.init({ 
				mode : "#jsstringformat(tinyMCE.mode)#", 
				language : "#jsstringformat(lcase(replace(tinyMCE.language,'-','_')))#" 
				<cfloop item="cfg" collection="#tinyMCE.config#">,<cfset temp = tinyMCE.config[cfg]>
				#lcase(cfg)# : <cfif isBoolean(temp) and not isnumeric(temp)>#iif(temp,true,false)#<cfelse>"#jsstringformat(temp)#"</cfif></cfloop>
			}) 
		</cfsavecontent>
		
		#getLib().jslib(tinyMCE.path & "/tiny_mce.js","T")#
		#getLib().jsOut(init_mce)#
	</cfoutput>
</cfif>
