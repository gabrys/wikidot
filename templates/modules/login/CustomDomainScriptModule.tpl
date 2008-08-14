{if $useCustomDomainScript}
	<iframe src="http{if $useCustomDomainScriptSecure}s{/if}://{$URL_HOST}/default--flow/login__CustomDomainScript?site_id={$site->getSiteId()}"></iframe>
{/if}