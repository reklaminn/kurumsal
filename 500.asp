<!--#Include file="functions/aspJSON1.17.asp"-->
<!--#Include file="functions/dbbilgi.asp"-->
<!--#Include file="fnk.asp"-->
<%'response.write response.Status
    On Error Resume Next
Response.Clear
Dim objError
Set objError = Server.GetLastError()

set objError = 			Server.getLastError()
strNumber = 			objError.AspCode
strSource = 			objError.Category
strDesc = 			newstr(objError.Description)
strCode = 			newstr(objError.Source)
strLine = 			ObjError.Line
strASPDesc = 			ObjError.ASPDescription
strRemoteAddr = 		Request.ServerVariables("REMOTE_ADDR")
ref = 				request.servervariables("HTTP_REFERER")
str = 				request.servervariables("QUERY_STRING")
cookies = 			request.servervariables("HTTP_COOKIE")
ip_url = 			strRemoteAddr
ua = 				newstr(request.servervariables("HTTP_USER_AGENT"))
totalstring = 			objError.File & "?" & str
    response.Write ua
    smidnoindex="1"

    
    Response.Write Server.HTMLEncode(objError.Category)
    If Len(CStr(objError.ASPCode)) > 0 Then
        Response.Write Server.HTMLEncode(", " & objError.ASPCode)
    End If
    Response.Write Server.HTMLEncode(" (0x" & Hex(objError.Number) & ")" ) & "<br>"
    If Len(CStr(objError.ASPDescription)) > 0 Then 
        Response.Write Server.HTMLEncode(objError.ASPDescription) & "<br>"
    ElseIf Len(CStr(objError.Description)) > 0 Then 
        Response.Write Server.HTMLEncode(objError.Description) & "<br>" 
    End If


            Dim err
Set err = Server.GetLastError

LogErrorToFile

Sub LogErrorToFile()
    Dim logFso
    Dim log

    On Error Resume Next

    Set logFso = Server.CreateObject("Scripting.FileSystemObject")
    If Err.number <> 0 Then
        Exit Sub
    End If

    Set log = objFS.OpenTextFile(Server.MapPath("images/log.txt"), 8, True)
    If Err.number <> 0 Then
        Exit Sub
    End If

    log.WriteLine "URL: " & Request.ServerVariables("URL")
    'log.WriteLine "File: " & err.File
    'log.WriteLine "Line, col: " & err.Line & ", " & err.Column
    log.WriteLine "Description" & err.Description & vbCrLf

    logFso.Close
End Sub
    %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=ceviridilekaktif %>" lang="<%=ceviridilekaktif %>">
<head>
    <title>500 - Unexpected Error - <%=modultitle%></title>
    <meta name="description" content="500 - Unexpected Error - <%=moduldesc%>" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
    <noscript id="deferred-styles">
    <!-- Web Fonts  -->
		<%=web_fonts %>
    </noscript>

		<!-- Vendor CSS -->
		<%=vendor_css %>
        <%if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then
            else%>
		<%=admin_css %>
        <%end if %>

		<!-- Theme CSS -->
		<%=theme_css %>

		<!-- Current Page CSS -->
		<%=current_page_css %>
		
		<!-- Template CSS -->
		<%=current_template_css %>

		<!-- Skin CSS -->
		<%=skin_css %>

		<!-- Theme Custom CSS -->
		<%=theme_custom_css %>

    <meta name="theme-color" content="<%=preloader_innercolor%>" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,maximum-scale=5" />
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
    <meta property="og:image" content="<%=heading_resim%>" />
    <meta property="og:url" content="<%=sitelink%>" />
    <meta property="og:type" content="article" />
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
    <%if smidnoindex="1" then %>
    <meta name="Robots" content="noindex" />
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
</head>

<body class="cms-<%=aid%>">
    <%call googletagmanager(googletag,webadres,0) %>
    <%call facemessenger(fmcode,site) %>

    <div class="body coming-soon">
		<header id="header" data-plugin-options="{'stickyEnabled': false}">
			<div class="header-body border border-top-0 border-right-0 border-left-0">
				<div class="header-container container py-2">
					<div class="header-row">
						<div class="header-column">
							<div class="header-row">
								<p class="mb-0"><strong>Get in touch!</strong> <%=sitetel %></span><span class="d-none d-sm-inline-block pl-1"> | <a href="mailto:<%=siteemail %>"><%=siteemail %></a></span></p>
							</div>
						</div>
						<div class="header-column justify-content-end">
							<div class="header-row">
								<ul class="header-social-icons social-icons mr-2">
									<li class="social-icons-facebook"><a href="http://www.facebook.com/<%=facekid %>" target="_blank" title="Facebook"><i class="fab fa-facebook-f"></i></a></li>
									<li class="social-icons-instagram"><a href="http://www.instagram.com/<%=instagramkadi %>" target="_blank" title="Instagram"><i class="fab fa-instagram"></i></a></li>

								</ul>
								<div class="header-nav-features">
									<div class="header-nav-features-search-reveal-container">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="header-nav-features header-nav-features-no-border p-static">
				<div class="header-nav-feature header-nav-features-search header-nav-features-search-reveal header-nav-features-search-reveal-big-search header-nav-features-search-reveal-big-search-full">
					<div class="container">
						<div class="row h-100 d-flex">
							<div class="col h-100 d-flex">
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</header>

		<div role="main" class="main" style="min-height: calc(100vh - 393px);">
			<div class="container">
				<div class="row mt-5">
					<div class="col text-center">
						<div class="logo">
							<a href="/">
								<img height="48" src="<%=pager %>" alt="<%=sitesahip %>"/>
							</a>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<hr class="solid my-5">
					</div>
				</div>
				<section class="http-error py-0">
					<div class="row justify-content-center py-3">
						<div class="col-6 text-center">
							<div class="http-error-main">
								<h2 class="mb-0">500!</h2>
								<span class="text-6 font-weight-bold text-color-dark">UNEXPECTED ERROR</span>
								<p class="text-3 my-4">An unexpected error has occured.</p>
							</div>
							<a href="/" class="btn btn-primary btn-rounded btn-xl font-weight-semibold text-2 px-4 py-3 mt-1 mb-4"><i class="fas fa-angle-left pr-3"></i><%=esser("s","Anasayfa") %></a>
						</div>
					</div>
				</section>
			</div>
		</div>

		<footer id="footer">
			<div class="container">
				<div class="row py-5">
					<div class="col-md-4 d-flex justify-content-center justify-content-md-start mb-4 mb-lg-0">
						<a href="/" class="logo pr-0 pr-lg-3 pl-3 pl-md-0">
							<img alt="<%=sitesahip %>" src="<%=pager %>" height="33"/>
						</a>
					</div>
                    
					<div class="col-md-8 d-flex justify-content-center justify-content-md-end mb-4 mb-lg-0">
						<div class="row">
							<div class="col-md-12 mb-3 mb-md-0">
								<div class="ml-3 text-center text-md-right">
									<h5 class="text-3 mb-0 text-color-light">Tel</h5>
									<p class="text-4 mb-0"><i class="fab fa-whatsapp text-color-primary top-1 p-relative"></i><span class="pl-1"><%=sitetel %></span></p>            
								</div>
							</div>
						</div>
					</div>
                    
				</div>
			</div>
			<div class="footer-copyright footer-copyright-style-2">
				<div class="container py-2">
					<div class="row py-4">
						<div class="col-md-4 d-flex align-items-center justify-content-center justify-content-md-start mb-2 mb-lg-0">
							<p>© Copyright <%=year(date) %>. All Rights Reserved.</p>
						</div>
						<div class="col-md-8 d-flex align-items-center justify-content-center justify-content-md-end mb-4 mb-lg-0">
							<p><i class="far fa-envelope text-color-primary top-1 p-relative"></i><a href="mailto:<%=siteemail %>" class="opacity-7 pl-1"><%=siteemail %></a></p>
							<ul class="footer-social-icons social-icons social-icons-clean social-icons-icon-light ml-3">
								<li class="social-icons-facebook"><a href="http://www.facebook.com/<%=facekid %>" target="_blank" title="Facebook"><i class="fab fa-facebook-f"></i></a></li>
								<li class="social-icons-instagram"><a href="http://www.instagram.com/<%=instagramkadi %>" target="_blank" title="Instagram"><i class="fab fa-instagram"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</footer>
	</div>

        <!-- Vendor -->
		<%=vendor_js %>
        <%if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then
            else%>
		<%=admin_js %>
        <%end if %>
		
		<!-- Theme Base, Components and Settings -->
		<%=theme_base_components_settings %>

		<!-- Current Page Vendor and Views -->
		<%=current_page_vendor_views %>
		
		<!-- Current Theme Js -->
		<%=current_theme_js %>

		<!-- Theme Custom -->
		<%=theme_custom_js %>
		
		<!-- Theme Initialization Files -->
		<script src="<%=cloudpath%>js/theme.init.js"></script>


<%if twitterid="-" or twitterid="" then
else%>
<script<%=strasync%>>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
<%end if%>
<%if faceid="-" or faceid="" then
else%>
<div id="fb-root"></div>
<script<%=strasync%>>
window.fbAsyncInit=function(){FB.init({appId:"<%=faceid%>",cookie:!0,xfbml:!0,version:"v3.2"}),FB.AppEvents.logPageView()},function(e,n,t){var o,c=e.getElementsByTagName(n)[0];e.getElementById(t)||((o=e.createElement(n)).id=t,o.src="//connect.facebook.net/tr_TR/sdk.js",c.parentNode.insertBefore(o,c))}(document,"script","facebook-jssdk");
    </script>
   <%end if%>
    
    <script>
      var loadDeferredStyles = function() {
        var addStylesNode = document.getElementById("deferred-styles");
        var replacement = document.createElement("div");
        replacement.innerHTML = addStylesNode.textContent;
        document.body.appendChild(replacement)
        addStylesNode.parentElement.removeChild(addStylesNode);
      };
      var raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
          window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
      if (raf) raf(function() { window.setTimeout(loadDeferredStyles, 0); });
      else window.addEventListener('load', loadDeferredStyles);
    </script>
<%

call googleanaly(google,webadres)
call zopimkod(zopim,webadres)
    close(Con)
    close(Con1)
%>
</body>
</html>