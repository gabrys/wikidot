<?php

$patterns = array(
	// del.icio.us
	'del_feed' => ';^<script type="text/javascript" src="http://del\.icio\.us/feeds/js/[^"]*"></script>(\s?' .
	'<noscript><a href="http://del\.icio\.us/[^"]*">[^<>]*</a></noscript>)?$;s',
	// del.icio.us "Save This Page"
	'del_save' => ';^<a href="http://del\.icio\.us/post" onclick="window\.open\(\'http://del.icio.us/post[^"]*">[^<>]+</a>$;s',
	// digg
	'digg' => ';^<script language="JavaScript" src="http://digg.com/diggjs/[^"]*" type="text/javascript"></script>$;s',
	// digg this
	'digg_this' => ';^<script>\s*digg_url\s*=\s*[\'"][^\'"]+[\'"]\;\s*</script>\s*<script src="http://digg.com/api/diggthis.js">\s*</script>\s*$;s',
	
	//'statcounter' => ';^(<!\-\- Start of StatCounter Code \-\->\s*)?<script type="text/javascript" language="javascript">\s*<!\-\-\s*[^<]+</script>\s*<script type="text/javascript" language="javascript"\s*src="https://secure.statcounter.com/counter/counter.js"></script><noscript><a\s*href="http://www.statcounter.com/" target="_blank"><img[^>]*</a>\s*</noscript>\s*(<!\-\- End of StatCounter Code \-\->)?$;si'
	'statcounter' => ';^(<!\-\- Start of StatCounter Code \-\->\s*)?<script type="text/javascript"( language="javascript")?>\s*(<!\-\-)?\s*(\s*var sc_[a-z0-9_ =",]+ *\;)*\s*(//\-\->)?\s*</script>\s*<script type="text/javascript"( language="javascript")?\s*src="https?://(secure|www)\.statcounter\.com/[^"]+"></script>\s*<noscript>(<div class="statcounter">)?(<a\s+(class="statcounter")?\s*href="http://www\.statcounter\.com/"( target="_blank")?>)?<img[^>]*>(</a>)?\s*(</div>)?\s*</noscript>\s*(<!\-\- End of StatCounter Code \-\->)?(\s*<br/?>\s*<a href="http://[a-z0-9]+\.statcounter\.com/project/standard/stats\.php[^"]+">[^<]*</a>)?$;si'
	,'statcounter_html' => ';^(<!\-\- Start of StatCounter Code \-\->\s*)?\s*(<a\s+href="http://www\.statcounter\.com/" target="_blank">)?<img[^>]*>(</a>)?\s*(<!\-\- End of StatCounter Code \-\->)?(\s*<br/?>\s*<a href="http://[a-z0-9]+\.statcounter\.com/project/standard/stats\.php[^"]+">[^<]*</a>)?$;si',
	
	//feedblitz - subscribe
	'fb' => ';^<form Method="POST" action="http://www\.feedblitz\.com/f/[^"]*">\s*[^<]*(<br/?>)?<input name="EMAIL" maxlength="255" type="text" size="30" value="">(<br/?>)?\s*<input name="FEEDID"[^>]*>\s*<input type="submit" value="[^"]*">\s*(<br>(<a href="http://www\.feedblitz\.com/f\?preview[^"]+">Preview</a> \| )?Powered by <a href="http://www\.feedblitz\.com">FeedBlitz</a>)?</form>$;s',
	
	'fb2' => ';^<a href="http://www\.feedblitz\.com/f/[^"]*">\s*<img title="[^"]*" border="0" src="http://www.feedblitz.com/i[^"]*"></a>$;',
	
	//'fb3' => ';^<form Method="POST" action="http://www\.feedblitz\.com/f/[^"]+">[^<]*(<br/)?<input name="EMAIL" maxlength="255" type="text" size="30" value=""><br><input name="FEEDID" type="hidden" value="95900"><input type="submit" value="Subscribe me!"><br><a href="http://www.feedblitz.com/f?previewfeed=95900">Preview</a> | Powered by <a href="http://www.feedblitz.com">FeedBlitz</a></form>$;si',
	//wikimapia
	'wikimapia' => ';^<iframe src="?http://wikimapia\.org/s/[^>]+></iframe>$;s',
	
	//quimble poll
	'quimble' => ';^<script type=[\'"]text/javascript[\'"] src=[\'"]http://quimble\.com/inpage/index/[0-9]+[\'"]></script>$;s',
	
	//'babelfish' => ';^<script\s+type="text/javascript"\s+(language="JavaScript1\.2"\s+)?src="http://www\.altavista\.com/help/free/inc_translate"></script>\s*<noscript><a href="http://www\.altavista\.com/babelfish/tr"></noscript>$;s',
	
	//'babelfish2' => ';^<script language="JavaScript1.2" src="http://www.altavista.com/static/scripts/translate_[^"]+.js"></script>$;',
	
	'ybabelfish' => ';^<script\s+type="text/javascript"\s+charset="UTF\-8"\s+(language="JavaScript1\.2"\s+)?src="http://[^\.]+\.babelfish\.yahoo\.com/free_trans_service/babelfish2\.js\?from_lang=([^"&]*?)&region=us"></script>$;s',
	
	'ybabelfish2' => ';^<script\s+type="text/javascript"\s+charset="UTF\-8"\s+(language="JavaScript1\.2"\s+)?src="http://babelfish\.yahoo\.com/free_trans_service/babelfish1\.js"></script>\s*<noscript><a href="http://babelfish\.yahoo\.com">[^<]+</a></noscript>$;s',
	
	'quickmaps' => ';^<iframe\s+src="http://quikmaps\.com/[^"]+"\s+[^>]*></iframe>$;s',
	
	'googlecalendar' => ';^<iframe src="http://www\.google\.com/calendar/embed[^"]+"\s+style="[^"]*"[^>]*>\s*</iframe>$;s',
	
	'zohosheet' => ';^<iframe src=(\'|")http://(www\.zohosheet|sheet\.zoho)\.com/[^\'"]+(\'|") frameborder=(\'|")[0-9]+(\'|") style=(\'|")height:[0-9]+px\;\s*width:[0-9]+px(\'|") scrolling=(\'|")?no(\'|")?>\s*</iframe>$;s',
	'zohosheer-range' => ';^<iframe src=(\'|")http://(www\.zohosheet|sheet\.zoho)\.com/[^\'"]+(\'|") frameborder=(\'|")[0-9]+(\'|") style=(\'|")height:[0-9]+px\;\s*width:[0-9]+px(\'|") marginwidth=(\'|")0(\'|") marginheight=(\'|")0(\'|") scrolling=(\'|")auto(\'|")>\s*</iframe>$;s',
	'zohowriter' => ';^<script src="http://(www\.zohowriter|writer\.zoho)\.com/public/[^"]+"></script>$;si',
	'zohoshow' => ';<iframe src="http://(www\.zohoshow|show\.zoho)\.com/[^"]+" height=(\'|")[0-9]+(\'|") width=(\'|")[0-9]+(\'|") name="[^"]+" scrolling=(\'|")?no(\'|")? frameBorder=(\'|")0(\'|")\s*></iframe>;si',
	'zohopolls' =>';<iframe\s+(frameborder=(\'|")0(\'|")\s*)?\s*src=(\'|")http://zohopolls\.com/[^\'"]+(\'|") width=(\'|")[0-9]+(\'|") height=(\'|")[0-9]+(\'|")></iframe>$;si',
	'zoho-generic' =>';<iframe\s+(frameborder=(\'|")0(\'|")\s*)?\s*src=(\'|")http://[a-z0-9]+\.zoho\.com/[^\'"]+(\'|") width=(\'|")[0-9]+(\'|") height=(\'|")[0-9]+(\'|")></iframe>$;si',
	'editgrid' => ';^<div style="[^"]+">\s*<a style="[^"]+" href="http://www\.editgrid\.com/[^"]+" target="_blank">EditGrid Spreadsheet</a> by <a style="[^"]+" href="http://www\.editgrid\.com/[^"]*" target="_blank">[^<>]*</a>\.?</div>\s*((<iframe frameborder="0" src="http://www.editgrid.com/publish/[^"]+" style="[^"]*">(&nbsp\;)?</iframe>)|(<script type="text/javascript" src="http://www\.editgrid\.com/[^"]*">(&nbsp\;)?</script>))$;s',
	'photobucketwidget' => ';<embed type="application/x-shockwave-flash" wmode="transparent" src="http://[a-z0-9]+.photobucket.com/pbwidget.swf\?[^"]+" height="[0-9]+" width="[0-9]+"></embed>$;',
	
	'picassa' => ';^<div\s+style="[^"]+"><div style="[^"]*"><a href="http://picasaweb\.google\.com/[^"]+"><img src="http://[a-z0-9]+\.google\.com/[^"]*" width="[0-9]+" height="[0-9]+" style="[^"]+"></a></div><a href="http://picasaweb\.google\.com/[^"]*"><div style="[^"]+">[^<]+</div></a><div style="[^"]*"></div></div>$;si',
	'meebowidget' => ';^(<!\-\-[^\-]+\-\->)?\s*<embed src="http://widget\.meebo\.com/mm.swf?[^"]+" type="application/x-shockwave-flash" wmode="transparent" width="[0-9]+" height="[0-9]+"></embed>$;si',
	'gabbly-chat' => ';^<iframe src=(\'|")http://cw\.gabbly\.com/gabbly/[^\'"]+(\'|") scrolling=(\'|")no(\'|") style=(\'|")[^\'"]*(\'|") frameborder=(\'|")0(\'|")></iframe>$;si',
	'labpixies' => ';^<script\s+type="text/javascript"\s+src="http://www\.labpixies\.com/lib/lp_gadget_syndication.php[^"]+">\s*</script>$;s',
	'instacalc' => ';^<script>\s*instacalc_embed_url = (\'|")http://instacalc\.com/[^"]+(\'|")\;\s+instacalc_embed_height = [0-9]+\;\s*</script>\s*<script src="http://instacalc\.com/javascripts/embed\.js">\s*</script>$;s',
	'googlegadgets' => ';^<script src="http://(www\.)?gmodules\.com/ig/ifr\?[^"]*">\s*</script>$;s',
	
	'feedburnercount' => ';^<a\s*href="http://feeds\.feedburner\.com/[^"]+">\s*<img\s*src="http://feeds.feedburner.com/[^"]+[^>]+/>\s*</a>$;s',
	'feedburneremail' => '!^<form\s+style="[^"]+"\s+action="http://www\.feedburner\.com/fb/a/emailverify"\s+method="post"\s+target="popupwindow"\s+onsubmit="window.open\(\'http://www\.feedburner\.com\'[^\)]+\);return true"><p>[^<]+</p><p><input type="text" style="width:140px" name="email"/></p><input type="hidden" value="http://feeds\.feedburner\.com/[^"]+" name="url"/><input type="hidden" value="[^"]+" name="title"/><input type="submit" value="[^"]+"\s*/>(<p>Delivered by <a href="http://www.feedburner.com/" target="_blank">FeedBurner</a></p>)?\s*</form>$!s',
	'snap' =>  ';^<script\s+defer\s+id="snap_preview_anywhere"\s+type="text/javascript"\s+src="http://spa\.snap\.com/snap_preview_anywhere\.js[^"]+">\s*</script>$;si',
	'snap2' => ';^<script\s+type="text/javascript"\s+src="http://shots\.snap\.com/snap_shots\.js\?[^"]+">\s*</script>$;si',
	'everytrail' => ';^<iframe\s+src="http://www\.everytrail.com/[^"]+"[^>]+>\s*</iframe>$;si',
	'motionbased' => ';^<iframe\s+src="http://trail\.motionbased\.com/[^"]+"[^>]*>\s*</iframe>$;si',
	'widgetbox-panel' => ';^<script type="text/javascript" src="http://widgetserver\.com/syndication/[^"]+">\s*</script>(<noscript>([^<>]*|<a href="http://www\.widgetbox\.com/[^>"]*">[^<>]*</a>|<a href="http://www\.widgetbox\.com">[^<>]*</a>)*</noscript>)?$;si',
	'polldaddy' => ';^<script\s*language="javascript"\s*src="http://www\.polldaddy\.com/p/[^"]+">\s*</script>\s*<noscript>\s*<a href ="http://www\.polldaddy\.com/[^"]+"\s*>[^<]*</a>\s*</noscript>$;si',
	'anyiframe' => ';^<iframe(\s+[a-z0-9_]+\s*=\s*"[^"]*")+>\s*</iframe>$;si',
	'mybloglog' => ';^<script\s+type=(\'|")text/javascript(\'|") src=(\'|")http://[a-z0-9]+\.mybloglog\.com/[^\'"]+(\'|")>\s*</script>$;si',
	'revver' => ';^<script\s+src="http://[a-z]+\.revver\.com/player/[^"]+"\s+type="text/javascript">\s*</script>$;si',
	'youtube' => ';^<embed[^>]*?src="http://video\.google\.com/googleplayer\.swf[^"]+"[^>]*>\s*</embed>$;is',
	'googlevideo' => '/^<object\s+width="[0-9]+"\s+height="[0-9]+">\s*<param\s+name="movie"\s+value="http:\/\/www\.youtube\.com\/.+?">\s*' .
		'<\/param>(\s*<param[^>]*>\s*<\/param>\s*)?\s*<embed\s+src="http:\/\/www\.youtube\.com\/.+?"\s+type="application\/x\-shockwave\-flash"[^>]*>\s*<\/embed>\s*<\/object>$/si',
	'aweber-form' => ';^<script type="text/javascript" src="http://forms\.aweber\.com/form/[^"]+\.js">\s*</script>$;si',
	'platial-mapkit' => ';^(<!\-\- START MAPKIT \-\->)?\s*<script type="text/javascript" src="http://platial\.com/mapkit/load[^"]+">\s*</script>\s*<script type="text/javascript">MapKit\.display\(\)\;</script>\s*(<!\-\- END MAPKIT \-\->)?$;si',
	'odeo1' => '/^<embed\ssrc="http:\/\/www\.odeo\.com\/flash\/[a-z0-9_]+\.swf"[^<]*<\/embed>' .
		'<br ?\/><a style="[^"]+"\s+href="http:\/\/(www\.)?odeo\.com[^"]+">powered by <strong>ODEO<\/strong><\/a>.*$/s',
	'odeo2' => ';^<embed src="http://odeo.com/flash/[^"]*"[^>]+></embed><br /><a[^>]+>powered by <strong>ODEO</strong></a>$;si',
	'dailymotion' => ';^<div><object width="[0-9]+" height="[0-9]+">\s*<param name="movie" value="http://www\.dailymotion\.com/swf/[^"]+"></param>\s*<param name="allowfullscreen" value="true">\s*</param>\s*<embed src="http://www\.dailymotion\.com/swf/[^"]+" type="application/x\-shockwave\-flash" width="[0-9]+" height="[0-9]+"[^>]+></embed></object>\s*(<br /><b><a href="http://www\.dailymotion\.com/video/[^"]+">[^<]+</a></b><br /><i>[a-z0-9 ]+<a href="http://www\.dailymotion\.com/[^"]+">[^<]+</a></i>)?</div>$;si',
	'delicious_tagometer' => ';^(<script type="text/javascript">\s+if \(typeof window\.Delicious == "undefined"\) window\.Delicious = {}\;\s+Delicious\.BLOGBADGE_DEFAULT_CLASS = \'delicious\-blogbadge\-line\'\;\s*</script>\s*)?<script src="http://images\.del\.icio.us/static/js/blogbadge\.js"></script>$;si',
	'finetune' => ';^<embed src="http://www\.finetune\.com/player/FineTuneShell\.swf[^"]+"[^>]*></embed>$;si',
	'brainyquote' => ';^<script\s+type="text/javascript"\s+src="http://www\.brainyquote\.com/link/quote[a-z]+\.js">\s*</script>$;si',
	'skype_status' => ';^<!--[^\-]*-->\s*<script type="text/javascript" src="http://download\.skype\.com/share/skypebuttons/js/skypeCheck\.js"></script>\s*<a href="skype:[^\?"]+\?call"><img src="http://[a-z]+\.skype\.com/[^"]+"[^>]+/></a>$;si',
	'slideshare' => ';^<object type="application/x-shockwave-flash" data="http://s3\.amazonaws\.com/slideshare/ssplayer\.swf[^"]+" width="[0-9]+" height="[0-9]+"><param name="movie" value="http://s3\.amazonaws\.com/slideshare/ssplayer\.swf[^"]+"\s*/></object>$;si',
	'googlecse_sb' => ';^<!\-\- Google CSE Search Box Begins  \-\->\s*<form action="http://[^"]+" id="[^"]*">\s*<input type="hidden" name="cx" value="[^"]+"\s*/>\s*<input type="hidden" name="cof" value="[^"]+" />\s*<input (class="text" )?type="text" name="q" size="25" />\s*<input (class="button" )?type="submit" name="sa" value="Search" />\s*</form>\s*<script type="text/javascript" src="http://google\.com/coop/cse/brand\?form=searchbox_[^"]+"></script>\s*<!\-\- Google CSE Search Box Ends \-\->$;is',
	'googlecse_r' => ';^<!\-\- Google Search Result Snippet Begins \-\->\s*<div id="results_"></div>\s*<script type="text/javascript">\s*var googleSearchIframeName = "results_"\;\s*var googleSearchFormName = "searchbox_"\;\s*var googleSearchFrameWidth = [0-9]+\;\s*var googleSearchFrameborder = 0\;\s*var googleSearchDomain = "google\.com"\;\s*var googleSearchPath = "/cse"\;\s*</script>\s*<script type="text/javascript" src="http://www\.google\.com/afsonline/show_afs_search\.js"></script>\s*<!\-\- Google Search Result Snippet Ends \-\->$;si',
	'diggnew' => ';^(<script type="text/javascript">(\s*digg_[a-z]+ = \'[^\']+\'\;)+\s*</script>)?\s*<script src="http://digg\.com/tools/diggthis\.js" type="text/javascript"></script>$;',
	'wowdbtooltip' => ';^<script src="http://www\.wowdb\.com/js/extooltips\.js"></script>$;',
	'wowheadtooltip' => ';^<script src="http://www\.wowhead\.com/widgets/power\.js"></script>$;',
	'thottbottooltip' => ';^<script src="http://i\.thottbot\.com/power\.js"></script>$;',
	'schooltube' => ';^<object width="450" height="375"><param name="movie" value="http://www\.schooltube\.com/v/[a-z0-9]+"\s*/><param name="wmode" value="transparent" /><param name="allowFullScreen" value="true" /><embed src="http://www\.schooltube\.com/v/[a-z0-9]+" type="application/x-shockwave-flash" wmode="transparent" allowFullScreen="true" width="450" height="375"></embed></object>$;si',
	'teachertube' => ';^<embed src="http://www\.teachertube\.com/[a-z0-9\-/]+/mediaplayer\.swf" width="425" height="350" type="application/x-shockwave-flash" allowfullscreen="true"\s+(menu="false")?\s+flashvars="height=350&width=425&file=http://www\.teachertube\.com/flvideo/[a-z0-9]+\.flv&image=http://www\.teachertube\.com/thumb/[a-z0-9]+\.jpg&location=http://www\.teachertube\.com/[a-z0-9\-/]+/mediaplayer\.swf&logo=http://www\.teachertube\.com/images/greylogo\.swf&searchlink=http://teachertube\.com/search_result\.php%3Fsearch_id%3D&frontcolor=0xffffff&backcolor=0x000000&lightcolor=0xFF0000&screencolor=0xffffff&autostart=false&volume=80&overstretch=fit&link=http://www\.teachertube\.com/view_video.php\?viewkey=[a-z0-9]+&linkfromdisplay=true&recommendations=http://www\.teachertube\.com/embedplaylist\.php\?chid=[0-9]+"></embed>$;si',
	'slideBoom' => ';^<object classid="clsid:d27cdb6e\-ae6d\-11cf\-96b8\-444553540000" codebase="http://fpdownload\.macromedia\.com/pub/shockwave/cabs/flash/swflash\.cab[^"]*" width="[0-9]+" height="[0-9]+" id="onlinePlayer"><param name="allowScriptAccess" value="always" /><param name="movie" value="http://www\.slideboom\.com/player/player\.swf\?id_resource=[0-9]+" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" /><param name="flashVars" value="mode=[0-9]+&idResource=[0-9]+&siteUrl=http://www\.slideboom\.com&embed=[0-9]+" /><param name="allowFullScreen" value="true" /><embed src="http://www\.slideboom\.com/player/player\.swf\?id_resource=[0-9]+" quality="high" bgcolor="#ffffff" width="[0-9]+" height="[0-9]+" name="onlinePlayer" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www\.macromedia\.com/go/getflashplayer" allowFullScreen="true" flashVars="mode=[0-9]+&idResource=[0-9]+&siteUrl=http://www\.slideboom\.com&embed=[0-9]+"></embed></object>$;si',
	'voicethread' => ';^<object width="[0-9]+" height="[0-9]+"><param name="movie" value="http://voicethread\.com/book.swf\?b=[0-9]+"></param><param name="wmode" value="transparent"></param><embed src="http://voicethread\.com/book\.swf\?b=[0-9]+" type="application/x-shockwave-flash" wmode="transparent" width="[0-9]+" height="[0-9]+"></embed></object><img style="visibility:hidden\;width:0px\;height:0px\;" border=0 width=0 height=0 src="http://counters\.gigya\.com/wildfire/[^"]+" />$;si',
	'alexa' => '|^<!\-\- Alexa Graph Widget from http://www\.alexa\.com/site/site_stats/signup \-\->\s*<script type="text/javascript"\s+src="http://widgets\.alexa\.com/traffic/javascript/graph\.js"></script>\s*<script type="text/javascript">/\*\s*<!\[CDATA\[\*/\s*// USER\-EDITABLE VARIABLES\s*// enter up to 3 domains, separated by a space\s*var sites\s*= \[\'[^\']+\'\];\s*var opts = {\s*width:\s*[0-9]+,  // width in pixels \(max 400\)\s+height:\s*[0-9]+,  // height in pixels \(max 300\)\s+type:\s*\'[a-z]\',  // "r" Reach, "n" Rank, "p" Page Views\s+range:\s*\'[^\']+\', // "7d", "1m", "3m", "6m", "1y", "3y", "5y", "max"\s+bgcolor:\s*\'[a-z0-9]+\' // hex value without "#" char \(usually "e6f3fc"\)\s*};\s*// END USER\-EDITABLE VARIABLES\s+AGraphManager\.add\( new AGraph\(sites, opts\) \);\s+//\]\]></script>\s*<!-- end Alexa Graph Widget -->$|si',	
	'dailymotion2'		=> ';^\<div\>\<object\s+width\="[0-9]+"\s+height\="[0-9]+"\>\<param\s+name\="movie"\s+value\="http\://www\.dailymotion\.com/swf/[^">]+"\>\</param\>\<param\s+name\="allowFullScreen"\s+value\="true"\>\</param\>\<param\s+name\="allowScriptAccess"\s+value\="always"\>\</param\>\<embed\s+src\="http\://www\.dailymotion\.com/swf/[^">]+"\s+type\="application/x-shockwave-flash"\s+width\="[0-9]+"\s+height\="[0-9]+"\s+allowFullScreen\="true"\s+allowScriptAccess\="always"\>\</embed\>\</object\>\<br\s+/\>\<b\>\<a\s+href\="http\://www\.dailymotion\.com/video/[^">]+"\>[^<>]+\</a\>\</b\>\<br\s+/\>\<i\>[^<>]+\<a\s+href\="http\://www\.dailymotion\.com/[^">]+"\>[^<>]+\</a\>\</i\>\</div\>$;si',
	'reflection.js'		=> ';^\<script\s+type\="text/javascript"\s+src\="https?\://static\.wikidot\.com/common--misc/reflection\.js"\>\</script\>$;si',
	'blip.tv'			=> ';^\<embed\s+src\="http\://blip\.tv/play/[^">]+"\s+type\="application/x-shockwave-flash"\s+width\="[0-9]+"\s+height\="[0-9]+"\s+allowscriptaccess\="always"\s+allowfullscreen\="true"\>\</embed\>$;si',
	'flickrvideo'		=> ';^\<object\s+type\="application/x-shockwave-flash"\s+width\="[0-9]+"\s+height\="[0-9]+"\s+data\="http\://www\.flickr\.com/apps/video/[^">]+"\s+classid\="[^">]+"\>\s+\<param\s+name\="flashvars"\s+value\="[^">]+"\>\</param\>\s+\<param\s+name\="movie"\s+value\="http\://www\.flickr\.com/apps/video/[^">]+"\>\</param\>\s+\<param\s+name\="bgcolor"\s+value\="#[^">]+"\>\</param\>\s+\<param\s+name\="allowFullScreen"\s+value\="true"\>\</param\>\s*\<embed\s+type\="application/x-shockwave-flash"\s+src\="http\://www\.flickr\.com/apps/video/[^">]+"\s+bgcolor\="#[^">]+"\s+allowfullscreen\="true"\s+flashvars\="[^">]+"\s+height\="[0-9]+"\s+width\="[0-9]+"\>\</embed\>\</object\>$;si',
	'playlist'			=> ';^\<div\s+style\="[^">]+"\>\<embed\s+style\="[^">]+"\s+allowScriptAccess\="never"\s+src\="http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/mc/mp3player-othersite\.swf\?config\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/mc/config/[^.">]+\.xml&mywidth\=[0-9]+&myheight\=[0-9]+&playlist_url\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/loadplaylist\.php\?playlist\=[0-9]+"\s+menu\="false"\s+quality\="high"\s+width\="[0-9]+"\s+height\="[0-9]+"\s+name\="mp3player"\s+wmode\="transparent"\s+type\="application/x-shockwave-flash"\s+pluginspage\="http\://www\.macromedia\.com/go/getflashplayer"\s+border\="0"/\>\<BR\>\<a\s+href\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)\>\<img\s+src\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/mc/images/[^">\s+.]+\.jpg\s+border\=0\>\</a\>\<a\s+href\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/standalone/[0-9]+\s+target\=_blank\>\<img\s+src\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/mc/images/[^\s+.>"]+\.jpg\s+border\=0\>\</a\>\<a\s+href\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/download/[0-9]+\>\<img\s+src\=http\://www\.(musicplaylist\.net|greatprofilemusic\.com)/mc/images/[^\s+.>"]+\.jpg\s+border\=0\>\</a\>\s+\</div\>$;si',
	'vimeo' => ';^<object width="[0-9]+" height="[0-9]+">\s*<param name="allowfullscreen" value="true" />\s*<param name="allowscriptaccess" value="always" />\s*<param name="movie" value="http://www\.vimeo\.com/moogaloop\.swf\?clip_id=[0-9a-z]+&amp\;server=www\.vimeo\.com&amp\;show_title=[0-9]&amp\;show_byline=[0-9]&amp\;show_portrait=[0-9]&amp\;color=&amp\;fullscreen=[0-9]" />\s*<embed src="http://www\.vimeo\.com/moogaloop\.swf\?clip_id=[a-z0-9]+&amp\;server=www\.vimeo\.com&amp\;show_title=[0-9]+&amp\;show_byline=[0-9]+&amp\;show_portrait=[0-9]+&amp\;color=&amp\;fullscreen=[0-9]+" type="application/x\-shockwave\-flash" allowfullscreen="true" allowscriptaccess="always" width="[0-9]+" height="[0-9]+"></embed></object><br /><a href="http://www\.vimeo.com/[0-9]+\?pg=embed&(amp\;)?sec=[0-9]+">[^<>]+</a> from <a href="http://www\.vimeo\.com/[^"]+">[^<>]+</a> on <a href="http://vimeo.com\?pg=embed&(amp\;)?sec=[0-9]+">Vimeo</a>\.$;si',
	'ohloh'				=> ';^\<script type\="text/javascript" src\="http\://www\.ohloh\.net/projects/[0-9]+/widgets/project_[^>"]+"\>\</script\>$;si',
	'plugoo'			=> ';^\<object\s+type\="application/x-shockwave-flash"\s+id\="plugoo"\s+data\=\s*"http\://www\.plugoo\.com/plg\.swf\?go\=[a-z0-9]+"\s+width\="[0-9]+"\s+height\="[0-9]+"\>\s+\<param\s+name\="movie"\s+value\=\s*"http\://www\.plugoo\.com/plg\.swf\?go\=[A-Z0-9]+"\s+/\>\s+\<param\s+name\="allowScriptAccess"\s+value\="always"\s+/\>\s+\<param\s+name\="wmode"\s+value\="transparent"\s+/\>\s+\</object\>$;si',
	'jskit.rating'		=> ';^(\<div\sclass\="js-kit-rating"(\s[a-z]+\="[^">]*")*\>\</div\>\s*)+' .
							'\<script\ssrc\="http\://js-kit\.com/ratings\.js"\>\</script\>$;si',
	'jskit.top'			=> ';^(\<div\sclass\="js-kit-top"(\s[a-z]+\="[^">]*")*\>\</div\>\s*)+' .
							'\<script\ssrc\="http\://js-kit\.com/top\.js"\>\</script\>$;si',
	'picasa2' => ';^<embed type="application/x\-shockwave\-flash" src="http://picasaweb\.google\.pl/s/c/bin/slideshow\.swf" width="[0-9]+" height="[0-9]+" flashvars="[^"<>]+" pluginspage="http://www\.macromedia\.com/go/getflashplayer"></embed>$;si',
	);