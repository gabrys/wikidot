{$page->setLayout("Raw")}

{if $redir}

	document.location = '{$redir}&url=' + encodeURIComponent(document.location.toString());
	
{/if}

{if $redirIE}

	{* only in IE try to redirect to set the short cookie *}
 		
	if (navigator.appName.indexOf('Internet Explorer') != -1) {
		if (parseFloat(navigator.appVersion.split('MSIE')[1] >= 7.0)) {
			document.location = '{$redir}&url=' + encodeURIComponent(document.location.toString());
		}
	}
	
{/if}