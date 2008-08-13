{$page->setLayout("Raw")}

{$abc}

{if $usePrivateWikiScript}
	
	document.location = '{$redir}/' + encodeURIComponent(document.location.toString());

{/if}