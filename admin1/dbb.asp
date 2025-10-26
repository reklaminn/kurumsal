<!--#Include file="../functions/dbbilgi.asp"-->
<!--#Include file="../functions/function.asp"-->
<%
imggaleriyol="../images/"
dbyolurun="../images/siiroyku/"
dbyolref="../images/referans/"
dbupload="../images/haber/"
dbuploadyazar="../images/yazar/"
dbuploadyazi="../images/yazi/"
dbuploadreklam="../images/reklam/"
dbuploadbaslik="../images/baslik/"
dbuploadgaleri="../images/galeri/"
domaini=replace(Request.ServerVariables("Server_Name"),".","")
%>
<%
Response.ContentType = "text/html" 
Response.Charset = "UTF-8" 
Response.Codepage = 65001 
%>

<!--#Include file="guven.asp"-->
<!--#Include file="fnk_y.asp"-->