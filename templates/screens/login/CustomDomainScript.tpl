{$page->setLayout("Raw")}

{if $user}

	url = document.location.toString();
	document.location = '{$redir}&url=' + encodeURIComponent(url);

{/if}