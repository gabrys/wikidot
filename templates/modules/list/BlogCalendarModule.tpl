<div class="page-calendar-box">
	<ul>
	{foreach from=$postCount key=yearName item=year}
		<li>
			<a href="{$startUrlBase}{$yearName}">{$yearName} ({$year.count})</a>
			<ul>
				{foreach from=$year.months key=monthName item=month}
					<li>
						<a href="{$startUrlBase}{$yearName}.{$monthName}">{$month.name|escape} ({$month.count})</a>
					</li>
				{/foreach}
			</ul>
		</li>
	{/foreach}
	</ul>
</div>