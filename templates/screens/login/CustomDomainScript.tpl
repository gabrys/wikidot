{$page->setLayout("Raw")}

{if $redir}

	document.location = '{$redir}&url=' + encodeURIComponent(document.location.toString());
	
{/if}

{if $redirIE}

	{* only in IE try to redirect to set the short cookie *}
 	
 	{literal}
	if (navigator.appName.indexOf('Internet Explorer') != -1) {
	{/literal}
		document.location = '{$redirIE}&url=' + encodeURIComponent(document.location.toString());
	{literal}
	}
	{/literal}
	
{/if}