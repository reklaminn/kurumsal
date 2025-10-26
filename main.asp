<%if varmiaspjson<>"1" then response.End%>

<!--#Include file="functions/fnk_db.asp"-->

<%

'strasync=" async"

if giriskont(aid)="" or isnumeric(aid)=false then

aid=835

else

aid=giriskont(aid)

end if

    

if giriskont(id)="" or isnumeric(id)=false then 

if giriskont(aid)="" or isnumeric(aid)=false then

id=835

else

id=giriskont(aid)

end if

else

id=giriskont(id)

end if



if giriskont(rid)="" or isnumeric(rid)=false then

rid=835

else

rid=giriskont(rid)

end if



if giriskont(urunid)="" or isnumeric(urunid)=false then

urunid=0

else

urunid=giriskont(urunid)

end if





sitesahip1=sitesahip



if seolinkim="" then

sitelink=siteadres

else

end if

    

if modullink="" then

sitelink=sitelink    

heading_desc=desc

heading_resim=pager

    'modultitle=sayfaadi&""&title

    if aid="" or aid="835" then

    modultitle=sayfaadi&""&title

    moduldesc=desc

    else

    if modultitle="" or isNull(modultitle) or modultitle="0" then

    modultitle=sayfaadi

    moduldesc=sayfaadi&" "&desc

    else

    modultitle=title

    moduldesc=desc

    end if

    end if

else

if modultitle="" or isNull(modultitle) or modultitle="0" then

modultitle=heading_banner

heading_desc=moduldesc

moduldesc=heading_banner

modulkey=heading_banner

'sitelink=sitelink & "" & modullink

sitelink=sitelink

else

modultitle=modultitle

heading_desc=moduldesc

moduldesc=moduldesc

modulkey=modulkey

sitelink=sitelink

'sitelink=sitelink & "" & modullink

end if

end if

if instr(heading_resim,"notfound.") then

    heading_resim=pager

    if instr(heading_resim,"http://") or instr(heading_resim,"https://") then

    heading_resim=heading_resim

    else

    heading_resim=siteadres&""& heading_resim

    end if

    elseif instr(heading_resim,"http://") or instr(heading_resim,"https://") then

    heading_resim=heading_resim

    else

    heading_resim=siteadres&""& heading_resim

    end if

    if request.cookies("remember_dil")="533" or ceviridilek="ar" then

    htmldirstr=" dir=""rtl"""

    end if

%>

        <%            

             response.Write(setchar(request.cookies("remember_dil"),"0"))

            'Response.addHeader "Cache-Control", "max-age=0, no-store, must-revalidate"

'Response.addHeader "Pragma", "no-cache"

if smidpcss="" or isNull(smidpcss) then

smidpcss=" "

end if

if smidpjs="" or isNull(smidpjs) then

smidpjs=" "

end if



SetLocale ceviridilekaktif

            %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=ceviridilekaktif %>" lang="<%=ceviridilekaktif %>"<%=" "&htmldirstr %><%=html_tag %>>

<head>

    <%=head_oncesi_veri %>

    <title><%=modultitle%></title>

    <meta name="description" content="<%=moduldesc%>" />    



		<!-- Vendor CSS -->

		<%=replace(vendor_css,"#pagecss#","") %>

        <%if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then

            else%>

		<%=admin_css %>

        <%end if %>

		<!-- Theme CSS -->

		<%=replace(theme_css,"#pagecss#","") %>



		<!-- Current Page CSS -->

		<%=replace(current_page_css,"#pagecss#","") %>

		

		<!-- Template CSS -->

		<%=replace(current_template_css,"#pagecss#","") %>



		<!-- Skin CSS -->

		<%=replace(skin_css,"#pagecss#",smidpcss) %>



		<!-- Theme Custom CSS -->

		<%=replace(theme_custom_css,"#pagecss#",smidpcss) %>

        <!--#Include file="contents/css/criticalcss.asp"-->

        <%= LoadCriticalCss(aid) %>

    <%'='smidhraflang %>  

    <%if smidnoindex="1" then

    else %>     

    <%if smidhraflang="" or isNull(smidhraflang) then %>

        <%response.Write hreflangcrt(id,request.cookies("remember_dil_code"),seotur,request.cookies("remember_dil")) %>

    <%else %>

    <%=smidhraflang %>

    <%end if %>

    <%end if %>



    <%if smidstructredstatu="1" then %>

        

    <%else %>

    <%if smidstructred="" or isNull(smidstructred) then 

    else%>


<%If InStr(smidstructred, "<script")>0 And InStr(smidstructred, "application/ld+json")>0 Then

    Response.Write "<script type=""application/ld+json"">" & vbCrLf
    Response.Write smidstructred & vbCrLf
    Response.Write "</script>" & vbCrLf
    else
    %>
    <%=smidstructred %>


    <%end if %>
    <%end if %>

    <%end if %>

    

    <meta name="theme-color" content="<%=preloader_innercolor%>" />

    <meta charset="utf-8" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <%if syenile="" or syenile="0" or isNull(syenile) then

    else

    %>

    <meta http-equiv="refresh" content="<%=syenile%>" />

    <%end if%>

    <%

    if gvmvar="-" or gvmvar="" then

    else%>

    <meta name="google-site-verification" content="<%=gvmvar%>" />

    <%end if%>

    <%if isNull(d42) or d42="" or d42="0" then

    else%>

    <link rel="shortcut icon" href="<%=siteadres%><%=d42%>" />

    <%end if%>

    <link rel="image_src" type="image/jpeg" href="<%=heading_resim%>" />

    <meta property="og:site_name" content="<%=siteadres%>" />

    <meta property="og:title" content="<%=modultitle%>" />

    <meta property="og:image" content="<%=replace(heading_resim,"//contents","/contents")%>" />

    <meta property="og:url" content="<%=replace(sitelink,"//contents","/contents")%>" />

    <meta property="og:type" content="website" />

    <%if faceid="" or faceid="-" then

	else%>

    <meta property="fb:app_id" content="<%=faceid%>" />

    <%end if%>

    <meta property="og:description" content="<%=moduldesc%>" />

    <%if isNull(facekid) or facekid="" or facekid="-" then

	else%>

    <link rel="author" href="https://www.facebook.com/<%=facekid%>" title="<%=facekid%> on Facebook" />

    <%end if %>

    <%if isNull(twitterkadi) or twitterkadi="" or twitterkadi="-" then

	else%>

    <meta name="twitter:card" content="summary" />

    <meta name="twitter:site" content="@<%=twitterkadi%>" />

    <meta name="twitter:title" content="<%=modultitle%>" />

    <meta name="twitter:description" content="<%=moduldesc%>" />

    <meta name="twitter:creator" content="@<%=twitterkadi%>" />

    <meta name="twitter:image" content="<%=heading_resim%>" />

    <%end if

    response.Write heading_canonical

        %>

    <meta content="After 1 days" name="Revisit" />

    <meta content="all" name="audience" />

    <meta name="author" content="<%=sitesahip%>" />

    <%if smidnoindex="1" then 

        Response.AddHeader "X-Robots-Tag", "noindex"%>

    <meta name="robots" content="noindex" />

    <%else %>

    <meta name="Robots" content="index,follow" />

    <meta name="googlebot" content="index,follow" />

    <meta name="yandexbot" content="index, follow" />

    <meta name="bingbot" content="index, follow" />

    <meta name="YandexImages" content="index, follow" />

    <meta name="YandexMedia" content="index, follow" />

    <meta name="YandexBlogs" content="index, follow" />

    <%end if %>

    <%call googletagmanager(googletag,webadres,1) %>

    <%=head_oncesi_son_veri %>

</head>



<body class="cms-<%=aid%> <%response.write " "&body_attr %>">

    <%=body_sonrasi_veri %>

    <%call googletagmanager(googletag,webadres,0) %>


    <%

    if anaid="" or isNull(anaid) then

    anaid="835"

    end if

  

    %>

        <%=adminbuttons %>

    

			 <%

sablon=rowtemp

    'strrowtempyeni=verialjson(siteadres&""&searchjsonpath&"home.json",apiKey,HashData,ekurl,"application/json","GET")

     if instr(strrowtempyeni,": [") and seotur<>"" then

            'yenibasla            

sablon=strrowtempyeni

            Set oJSON = New aspJSON

    oJSON.loadJSON(sablon)

            set rows = oJSON.data(0)

                 response.Write("<div class=""body"">")

            for each rowii in rows

if rows.count>2 then

            rowtype=rows(rowii)("type")

            rowtypee=rows(rowii)("cont")

            rowcss=rows(rowii)("elcss")

                 if rowcss="" then

                 rowcssstr=""

                 else

                 rowcssstr=" class="""&rowcss&""""

                 end if

            rowid=rows(rowii)("elid")

                 if rowid="" then

                 rowidstr=""

                 else

                 rowidstr=" id="""&rowid&""""

                 end if

            rowstyle=rows(rowii)("elstyle")

                 if rowstyle="" then

                 rowstylestr=""

                 else

                 rowstylestr=" style="""&rowstyle&""""

                 end if

            rowotherr=replace(replace(rows(rowii)("elother"),"``",""""),"`","'")

    

            rowi=rowi+1

    if rowtype="header" then

response.Write("<header"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

if rowtypee="column" then

response.Write("<section"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

elseif instr(rowtypee,"container") then

response.Write("<div"&rowidstr&""&rowstylestr&" class="""&rowtypee&""" "&rowotherr&">")

response.Write("<div"&rowcssstr&">")

else

end if

elseif rowtype="footer" then

response.Write("<footer"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

'response.Write("</main><footer"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

if rowtypee="column" then

response.Write("<section"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

elseif instr(rowtypee,"container") then

response.Write("<div"&rowidstr&""&rowstylestr&" class="""&rowtypee&""" "&rowotherr&">")

response.Write("<div"&rowcssstr&">")

else

end if

else

if rowtypee="column" then

response.Write("<section"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

elseif instr(rowtypee,"container") then

response.Write("<div"&rowidstr&""&rowstylestr&" class="""&rowtypee&""" "&rowotherr&">")

response.Write("<div"&rowcssstr&">")

else

                 if rowidstr="" or rowcssstr="" or rowstylestr="" or rowotherr="" then

                 else

response.Write("<div"&rowidstr&""&rowcssstr&""&rowstylestr&" "&rowotherr&">")

                 end if

end if

end if

             set cols = rows(rowii)("children")(0)

            for each colii in cols

    if cols.count>=1 then

             colid=cols(colii)("id")

             coltype=cols(colii)("colmd")

            colcss=cols(colii)("celcss")   

            colid=cols(colii)("celid")

                 if colid="" then

                 colidstr=""

                 else

                 colidstr=" id="""&colid&""""

                 end if  

            colstyle=cols(colii)("celstyle")  

                 if colstyle="" then

                 colstylestr=""

                 else

                 colstylestr=" style="""&colstyle&""""

                 end if  

            colotherr=cols(colii)("celother")  

                 if colotherr="" then

                 colotherrstr=""

                 else

                 colotherrstr=" "&colotherr&""

                 end if  

            coltype=cols(colii)("coltype")   

                 if coltype="none" then

                 coltype=""

                 end if

            colsmtype=cols(colii)("colsmtype")   

                 if colsmtype="none" then

                 colsmtype=""

                 end if

            colmdtype=cols(colii)("colmdtype") 

                 if colmdtype="none" then

                 colmdtype=""

                 end if  

            collgtype=cols(colii)("collgtype")  

                 if collgtype="none" then

                 collgtype=""

                 end if 

            colxltype=cols(colii)("colxltype")

                 if colxltype="none" then

                 colxltype=""

                 end if

            coli=coli+1

                 if colcss="" and colstyle="" and colotherr="" and coltype="" and colsmtype="" and colmdtype="" and collgtype="" and colxltype="" then

                 else                 

    response.Write("<div"&colidstr&" class="""&colcss&""&coltype&" "&colsmtype&" "&colmdtype&" "&collgtype&" "&colxltype&""""&colstylestr&""&colotherrstr&">")

                     end if              

            set mods = cols(colii)("children")(0)

            for each modii in mods

             modid=mods(modii)("id")

             modmodulid=mods(modii)("modulid")

          

                    if isObject(mods(modii)("json")) then

                    set modoptions = mods(modii)("json")



                    'Set oJSONmodul = New aspJSON

                    'oJSONmodul.data.Add 0, modoptions  

                    'moduloptfull= oJSONmodul.JSONoutput()



                    for each modoi in modoptions

                    modopname=modoptions(modoi)("name")

                    modopvalue=modoptions(modoi)("value")

                    'moduloptfull="{""name"":"""&modopname&""", ""value"":"""&modopvalue&"""},"&moduloptfull

                    if modopname="mid" then

                    modulid=modopvalue

                    elseif modopname="toplu" then

                    strmsmtoplu=modopvalue

                    elseif modopname="ladet" then

                    strmsmladet=modopvalue

                    elseif modopname="moduldurumu" then

                    strmsmdurum=modopvalue

                    elseif modopname="goster" then

                    strmsgoster=modopvalue

                    elseif modopname="baslik" then

                    strmsbaslik=modopvalue

                    elseif modopname="sayfa" then

                    strmssayfa=modopvalue

                    elseif modopname="sayfaozelvar" then

                    strmsozelvar=modopvalue

                    elseif modopname="sayfaozel" then

                    strmsozel=modopvalue

                    elseif modopname="moduller" then

                    strmsmodulid=modopvalue

                    elseif modopname="temp" then

                    strmstemp=modopvalue

                    elseif modopname="yetki" then

                    strmsonay=modopvalue

                    end if

                    next

                    'moduloptfull="["&moduloptfull&"]"

                    end if

                 if strmsozelvar="1" then

                 strmssayfa=strmsozel

                 kategorisayi=strmsozel

                 end if

                    

            modi=modi+1



if seotur="sayfa" then

if (strmsgoster="0" or strmsgoster="2") and strmsonay="1" then
modgoster="1"
else
modgoster="0"
end if

else

if (strmsgoster="1" or strmsgoster="2") and strmsonay="1" then
modgoster="1"
else
modgoster="0"
end if

end if

if modgoster="1" then


    
Call moduller(modulid,strmsbaslik,strmssayfa,strmsmodulid,strmstemp,strmsgoster,strmsonay)

            
else

end if     

				modcol=""



 next    

                 if colcss="" and colstyle="" and colotherr="" and coltype="" and colsmtype="" and colmdtype="" and collgtype="" and colxltype="" then

                 else

     response.Write("</div>")

                 end if

    else

    end if

    next

        if rowtype="header" then

if rowtypee="column" then

response.Write("</section>")

elseif instr(rowtypee,"container") then

response.Write("</div></div>")

else

end if

                 

response.Write("</header>")

'response.Write("</header><main role=""main"" class=""main overflow-hidden"">")

Call hatam()

elseif rowtype="footer" then

if rowtypee="column" then

response.Write("</section>")

elseif instr(rowtypee,"container") then

response.Write("</div></div>")

else

end if

response.Write("</footer>")

else

if rowtypee="column" then

response.Write("</section>")

elseif instr(rowtypee,"container") then

response.Write("</div></div>")

else

                 if rowidstr="" or rowcssstr="" or rowstylestr="" or rowotherr="" then

                 else

response.Write("</div>")

                 end if

end if

end if

else

end if

            next

response.Write("</div>")



            'yenibit

            else



end if



        %>



        <!-- Vendor -->

		<%=replace(vendor_js,"#pagejs#","") %>

        <%if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then

            else%>

		<%=admin_js %>

        <%end if %>

		

		<!-- Theme Base, Components and Settings -->

		<%=replace(theme_base_components_settings,"#pagejs#","") %>



		<!-- Current Page Vendor and Views -->

		<%=replace(current_page_vendor_views,"#pagejs#","") %>

		

		<!-- Current Theme Js -->

		<%=replace(current_theme_js,"#pagejs#","") %>



		<!-- Theme Custom -->

		<%=replace(theme_custom_js,"#pagejs#",smidpjs) %>



<%if twitterid="-" or twitterid="" then

else%>

<script<%=strasync%> type="fasterlazyloadscript">!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

<%end if%>

<%if faceid="-" or faceid="" then

else%>

<div id="fb-root"></div>

<script<%=strasync%> type="fasterlazyloadscript">

window.fbAsyncInit=function(){FB.init({appId:"<%=faceid%>",cookie:!0,xfbml:!0,version:"v3.2"}),FB.AppEvents.logPageView()},function(e,n,t){var o,c=e.getElementsByTagName(n)[0];e.getElementById(t)||((o=e.createElement(n)).id=t,o.src="//connect.facebook.net/tr_TR/sdk.js",c.parentNode.insertBefore(o,c))}(document,"script","facebook-jssdk");

    </script>

   <%end if%>



<script>const LAZY_TIMEOUT_SEC=5;class FasterLazyLoadScripts{constructor(e,t=2,n={}){this.triggerEvents=e,this.eventOptions={passive:!0},this.userEventListener=this.triggerListener.bind(this),this.delayedScripts={normal:[],async:[],defer:[]},this.allJQueries=[],this.domReadyFired=!1,this.timeoutMs=Math.max(0,0|t)*1e3,this.opts=Object.assign({fireDomReady:!0,fireWindowLoad:!0,rewriteNativeEvents:!1,patchJQueryLoad:!1},n),this.timeoutMs>0&&(this.timeoutID=setTimeout((()=>this.triggerListener()),this.timeoutMs))}static run(){const e=new FasterLazyLoadScripts(["keydown","mousemove","touchmove","touchstart","touchend","wheel"],LAZY_TIMEOUT_SEC);e._addUserInteractionListener(e)}_addUserInteractionListener(e){this.triggerEvents.forEach((t=>window.addEventListener(t,e.userEventListener,e.eventOptions)))}_removeUserInteractionListener(e){this.triggerEvents.forEach((t=>window.removeEventListener(t,e.userEventListener,e.eventOptions)))}triggerListener(){this._removeUserInteractionListener(this),this.timeoutID&&(clearTimeout(this.timeoutID),this.timeoutID=null),"loading"===document.readyState?document.addEventListener("DOMContentLoaded",this._loadEverythingNow.bind(this),{once:!0}):this._loadEverythingNow()}async _loadEverythingNow(){this._handleDocumentWrite(),this._registerAllDelayedScripts(),this._preloadAllScripts(),await this._loadScriptsFromList(this.delayedScripts.normal),await this._loadScriptsFromList(this.delayedScripts.defer),await this._loadScriptsFromList(this.delayedScripts.async),this.opts.fireDomReady&&await this._triggerDOMContentLoaded(),this.opts.fireWindowLoad&&await this._triggerWindowLoad(),window.dispatchEvent(new Event("faster-allScriptsLoaded"))}_registerAllDelayedScripts(){document.querySelectorAll('script[type="fasterlazyloadscript"]').forEach((e=>{if("1"===e.dataset.fasterDone)return;e.hasAttribute("src")?e.hasAttribute("async")&&!1!==e.async?this.delayedScripts.async.push(e):e.hasAttribute("defer")&&!1!==e.defer||"module"===e.getAttribute("data-faster-type")?this.delayedScripts.defer.push(e):this.delayedScripts.normal.push(e):this.delayedScripts.normal.push(e)}))}async _transformScript(e){if("1"===e.dataset.fasterDone)return;await this._requestAnimFrame();return new Promise((t=>{const n=document.createElement("script");let s;[...e.attributes].forEach((e=>{let t=e.nodeName,r=e.nodeValue;"type"!==t&&("data-faster-type"===t&&(t="type",s=r),n.setAttribute(t,r))})),e.nonce&&(n.nonce=e.nonce),e.crossOrigin&&(n.crossOrigin=e.crossOrigin),e.integrity&&(n.integrity=e.integrity),s&&(n.type=s);const r=()=>{n.removeEventListener("load",r),n.removeEventListener("error",r),t()};e.hasAttribute("src")?(n.addEventListener("load",r),n.addEventListener("error",r)):(n.text=e.text,setTimeout(r,0)),e.dataset.fasterDone="1",e.parentNode.replaceChild(n,e)}))}async _loadScriptsFromList(e){const t=e.shift();return t?(await this._transformScript(t),this._loadScriptsFromList(e)):Promise.resolve()}_preloadAllScripts(){const e=document.createDocumentFragment();[...this.delayedScripts.normal,...this.delayedScripts.defer,...this.delayedScripts.async].forEach((t=>{const n=t.getAttribute("src");if(n){const t=document.createElement("link");t.href=n,t.rel="preload",t.as="script",e.appendChild(t)}})),document.head.appendChild(e)}_delayEventListeners(){}_delayJQueryReady(e){let t=window.jQuery;Object.defineProperty(window,"jQuery",{get:()=>t,set:n=>{n&&n.fn&&!e.allJQueries.includes(n)&&(n.fn.ready=n.fn.init.prototype.ready=function(t){e.domReadyFired?t.bind(document)(n):document.addEventListener("faster-DOMContentLoaded",(()=>t.bind(document)(n)),{once:!0})},e.allJQueries.push(n)),t=n}})}async _triggerDOMContentLoaded(){this.domReadyFired=!0,await this._requestAnimFrame(),document.dispatchEvent(new Event("faster-DOMContentLoaded")),await this._requestAnimFrame(),window.dispatchEvent(new Event("faster-DOMContentLoaded"))}async _triggerWindowLoad(){await this._requestAnimFrame(),window.dispatchEvent(new Event("faster-load"))}_handleDocumentWrite(){const e=new Map;document.write=document.writeln=function(t){const n=document.currentScript,s=document.createRange(),r=n.parentElement;let i=e.get(n);void 0===i&&(i=n.nextSibling,e.set(n,i));const a=document.createDocumentFragment();s.setStart(a,0),a.appendChild(s.createContextualFragment(t)),r.insertBefore(a,i)}}async _requestAnimFrame(){return new Promise((e=>requestAnimationFrame(e)))}}FasterLazyLoadScripts.run();window.addEventListener("faster-load",(function(){var e=document.getElementById("critical-css-desktop"),t=document.getElementById("critical-css-mobile");e&&e.remove(),t&&t.remove()}));</script>

<script type="fasterlazyloadscript" data-delay-type="interaction">var loadDeferredStyles=function(){var e=document.getElementById("deferred-styles");if(e){var t=document.createElement("div");t.innerHTML=e.textContent||e.innerHTML,Array.from(t.children).forEach((function(e){"LINK"===e.tagName&&document.head.appendChild(e)})),e.remove()}},raf=window.requestAnimationFrame||window.mozRequestAnimationFrame||window.webkitRequestAnimationFrame||window.msRequestAnimationFrame;raf?raf((function(){window.setTimeout(loadDeferredStyles,0)})):window.addEventListener("load",loadDeferredStyles,{once:!0});</script>




    <script id="deferred-styles" type="text/plain">

    <!-- Web Fonts  -->

		<%=replace(web_fonts,"#pagecss#",smidpcss) %>

    </script>

<%

   

call googleanaly(google,webadres)


    close(Con)

    close(Contur)


%>

</body>

</html>