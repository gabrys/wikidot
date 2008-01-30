{$page->setLayout("Raw")}

{if $user}

	{literal}
	function setCookie( name, value, expires, path, domain, secure) {
		var today = new Date();
		today.setTime( today.getTime() );
		if ( expires ) {
			expires = expires * 1000 * 60 * 60 * 24;
		}
	
		var expires_date = new Date( today.getTime() + (expires) );
		
		var ck = name+'='+escape( value ) +
		
		( ( expires ) ? ';expires='+expires_date.toGMTString() : '' ) + //expires.toGMTString()
		( ( path ) ? ';path=' + path : '' ) +
		( ( domain ) ? ';domain=' + domain : '' ) +
		( ( secure ) ? ';secure' : '' );
		//alert(ck);
		document.cookie = ck;
	}
	
	{/literal}
	
	setCookie("{$cookieName}", "{$sessionId}", 60, '/', '.'+window.location.hostname);
    setCookie("fromCustomDomain", "true", 60, '/', '.'+window.location.hostname);
	// reload the page!
	window.location.reload();
//	setTimeout('window.location.reload()', 50);

{/if}