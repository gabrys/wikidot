{$page->setLayout("Raw")}

{if $user}

	document.location = '{$redir}&url=' + encodeURIComponent(document.location.toString());

{/if}