{if $useCustomDomainScript}
	<iframe src="http{if $useCustomDomainScriptSecure}s{/if}://{$URL_HOST}/domainauth.js.php?site_id={$site->getSiteId()}"></iframe>
{/if}