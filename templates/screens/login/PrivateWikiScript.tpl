{$page->setLayout("Raw")}

{if $usePrivateWikiScript}
	
	document.location = '{$redir}/' + encodeURIComponent(document.location.toString());

{/if}