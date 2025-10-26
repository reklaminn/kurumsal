<%
'For Each Cookie In Response.Cookies
'	Response.Cookies(Cookie) = ""
'	Response.Cookies(Cookie).Expires = Date() - 1
'Next
domaini=replace(replace(Request.ServerVariables("Server_Name"),".",""),"-","")
response.cookies("remember"&domaini&"rinn3")=""
response.cookies("remember"&domaini&"rinn4")=""
response.cookies("remember"&domaini&"rinnsecure")=""

response.cookies("remember"&domaini&"rinn3").Expires = Date() - 1
response.cookies("remember"&domaini&"rinn4").Expires = Date() - 1
response.cookies("remember"&domaini&"rinnsecure").Expires = Date() - 1

session.Abandon
if request.querystring("redirect")="0" then
else
response.Redirect("index.asp?hata=2&sayfa=logout")
end if
%>
<form action="<%=request.ServerVariables("HTTP_REFERER")%>" method="post" name="form4568" target="_parent">
<div align="center" class="header">Güvenli Çıkışınız Yapıldı. İyi Çalışmalar... <br>
  <br>
  <br>
</div>
  <div align="center">
    <input name="submit" type="submit" value="Yönetici Sayfasına Dön">
  </div>
</form>
</body>

</html>
