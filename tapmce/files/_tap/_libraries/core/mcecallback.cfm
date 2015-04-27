<cfif attributes.tapdocs>
	<cf_doc>
			<spec>
				<library name="core">
					<function name="mceCallback" xref="">
						<usage>adds javascript code to a TinyMCE callback method for the current page</usage>
						<example>&lt;cfset getLib().mceCallback(&quot;onchange_callback&quot;,&quot;tinyMCE.triggerSave();&quot;)&gt;</example>
						<arguments>
							<arg name="event" required="true" type="string" default="n/a">the name of the TinyMCE callback to which the javascirpt code should be married</arg>
							<arg name="js" required="true" type="string" default="n/a">javascript code to execute when the callback fires</arg>
						</arguments>
					</function>
				</library>
			</spec>
	</cf_doc>
<cfelse>
	<cfscript>
		if (attributes.require) { attributes.include = tReq(attributes.include,"core/param"); } 
		
		function mceCallback(myevent,js) { 
			getLib().param("getTap().mce.callbacks." & myevent,ArrayNew(1)); 
			ArrayAppend(getTap().mce.callbacks[myevent],js); 
		} tStor("mceCallback"); 
	</cfscript>
</cfif>
