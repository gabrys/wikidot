<h1>{t}Themes{/t}</h1>

<p>
	Below you can choose a theme for your site. You can select individual theme for each
	of page categories.
</p>	

<div id="sm-appearance-form-div">
	<form id="sm-appearance-form">
		
		<table class="sm-theme-table">
			<tr>
				<td>
					<select name="category" size="15" id="sm-appearance-cats">
						{foreach from=$categories item=category}
							<option value="{$category->getCategoryId()}" style="padding: 0 1em" {if $category->getName()=="_default"}selected="selected"{/if}>{$category->getName()|escape}</option>
						{/foreach}
					</select>
				</td>
				<td>
					<h3>{t}Choose a  theme{/t}:</h3>
					
					<div id="sm-appearance-theme">
						
						<select name="theme" id="sm-appearance-theme-id">
							{foreach from=$themes item=theme}
								<option value="{$theme->getThemeId()}">{$theme->getName()|escape} {if $theme->getCustom()}({t}custom{/t}){/if}</option>
							{/foreach}
						</select>
						<div id="theme-variants-container">
							{if $variantsArray}
								{foreach from=$variantsArray item=variants key=variantId}
									<div id="sm-appearance-variants-{$variantId}" style="display: none">
										<br/><br/>{t}Available theme variants{/t}:
										<br/><br/>
										<select name="variants" id="sm-appearance-variants-select-{$variantId}"
											onclick="WIKIDOT.modules.ManagerSiteAppearanceModule.listeners.variantChange(event)">
											{foreach from=$variants item=variant}
												<option value="{$variantId}">{t}Default{/t}</option>
												<option value="{$variant->getThemeId()}">{$variant->getName()|escape}</option>
											{/foreach}
										</select>
									</div>
								{/foreach}
							{/if}
						</div>
					</div>
					<div id="sm-appearance-noind">
						{t}Inherit from <tt>_default</tt>{/t}: <input class="checkbox" type="checkbox" id="sm-appearance-noin"/>
					</div>
				</td>
			</tr>
		</table>
		
	
		
		<div id="sm-appearance-theme-preview" style="overflow: hidden;">
			<h2>{t}Theme details{/t}:</h2>
			
			{foreach from=$themes item=theme}
				{assign var=preview value=$theme->getThemePreview()}
				{if $preview}
					<div id="sm-theme-preview-{$theme->getThemeId()}">
						{$preview->getBody()}
					</div>
				{/if}
			{/foreach}
		</div>
		<div class="buttons">
			<input type="button" value="{t}cancel{/t}" id="sm-appearance-cancel"/>
			<input type="button" value="{t}save changes{/t}" id="sm-appearance-save"/>
		</div>
	</form>
</div>
