<h1>Clone the Site</h1>

<div id="sm-clone-block">
<p>
	Clone the whole site.
</p>

<h2>What to clone?</h2>

<h2>Override</h2>

<div class="error-block" id="clone-site-form-errors" style="display: none"></div>

<form id="clone-site-form">
	<table class="form">
		<tr>
			<td>
				{t}Site name{/t}:
			</td>
			<td>
				<input class="text" type="text" id="new-site-name" name="name" size="30" value="{$site->getName()|escape}" />
				<div class="sub">
					{t}Appears on the top-left corner of your Wikidot site.{/t}
				</div>
			</td>
		</tr>
		<tr>
			<td>
				{t}Tagline{/t}:
			</td>
			<td>
				<input class="text" type="text" name="subtitle" size="30" value="{$site->getSubtitle()|escape}"/>
				<div class="sub">
					{t}Appears beneath the name.{/t}
				</div>
			</td>
		</tr>
		<tr>
			<td>
				{t}Web address{/t}:
			</td>
			<td>
				<input class="text" type="text" id="new-site-unixname" name="unixname" size="20" style="text-align: right" value=""/>.{$URL_DOMAIN}
				<div class="sub">
					{t}Only alphanumeric [a-z0-9] and "-" (dash) characters allowed.{/t}
				</div>
			</td>
		</tr>
		<tr>
			<td>
				{t}Description{/t}:
			</td>
			<td>
				<textarea class="textarea" name="description" cols="40" rows="5">{$site->getDescription()|escape}</textarea>
			</td>
		</tr>
		<tr>
			<td>
				{t}Private site?{/t}
			</td>
			<td>
				<input type="checkbox" name="private" class="checkbox" {if $site->getPrivate()}checked="checked"{/if}>
				<div class="sub">
					{t}If you check this, the site is visible only to its members.{/t}
				</div>
			</td>		
		</tr>
	</table>
	<div class="buttons">
		<input type="button" value="{t}Cancel{/t}" onclick="WIKIDOT.modules.ManageSiteCloneModule.listeners.cancel(event)"/>
		<input type="button" value="{t}Clone this Site{/t}" onclick="WIKIDOT.modules.ManageSiteCloneModule.listeners.cloneSite(event)"/>
	</div>
</form>

</div>