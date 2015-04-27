<cfparam name="attributes.tapdocs" type="boolean" default="false">
<cfif attributes.tapdocs>
	<cfparam name="attributes.xml" type="boolean" default="false">

	<cf_doc>
			<spec>
				<library name="core">
					<tag name="<cfoutput>#getfilefrompath(getcurrenttemplatepath())#</cfoutput>" xref="">
						<usage>
							adds arbitrary javascript to a Tiny MCE callack method 
							- this tag will only work in the _htmlhead stage of the request 
						</usage>
						<example>&lt;cf_mcecallback event=&quot;cleanup&quot;&gt;alert(&quot;hello world&quot;)&lt;/cf_mcecallback&gt;</example>
						<attributes>
							<attribute name="event" type="string" required="true" default="n/a">indicates the callback event to which the script is attached</attribute>
						</attributes>
					</tag>
				</library>
			</spec>
	</cf_doc>
<cfelse>
	<cfswitch expression="#thistag.executionmode#">
		<cfcase value="start">
			<cfsavecontent variable="variables.allowoutput">true</cfsavecontent>
			<cfsetting enablecfoutputonly="false">
		</cfcase>
		
		<cfcase value="end">
			<cfparam name="attributes.event" type="string">
			<cfset getLib().mceCallback(attributes.event,thistag.generatedcontent)>
			<cfset thistag.generatedcontent = "">
			<cfsetting enablecfoutputonly="#yesnoformat(variables.allowoutput)#">
		</cfcase>
	</cfswitch>
</cfif>
