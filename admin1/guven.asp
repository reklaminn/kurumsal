<%
sessionDuration = 120 ' Süreyi buradan değiştirebilirsin (dakika cinsinden)
domaini=replace(replace(Request.ServerVariables("Server_Name"),".",""),"-","")
domainhttps=Request.ServerVariables("HTTPS")
if domainhttps="off" then
httpsonly=""
else
httpsonly=" Secure; HttpOnly"
end if
sessionExpired = "false"
if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then

sessionExpired = "true"
response.Redirect("logout.asp?hata=2")%>
<%
Response.End%>
<%else

ip=Request.ServerVariables("REMOTE_ADDR") ' IP adresi
uyeid=request.cookies("remember"&domaini&"rinn4")

if request.cookies("remember"&domaini&"rinn3")="1" then

response.cookies("remember"&domaini&"rinn3").Expires=dateAdd("n", sessionDuration, Now())
Response.AddHeader "Set-Cookie", "remember"&domaini&"rinn4="&uyeid&"; expires="&dateAdd("n", sessionDuration, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"rinnsecure").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinn4").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinn3").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinnexpire")=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinnexpire").Expires=dateAdd("n", sessionDuration, Now())

else
Response.AddHeader "Set-Cookie", "remember"&domaini&"rinn4="&uyeid&"; expires="&dateAdd("n", sessionDuration, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"rinnsecure").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinn4").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinn3").Expires=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinnexpire")=dateAdd("n", sessionDuration, Now())
response.cookies("remember"&domaini&"rinnexpire").Expires=dateAdd("n", sessionDuration, Now())
end if

sayfa=Request.ServerVariables("SCRIPT_NAME")&"-"&Request.ServerVariables("http_referer")&"-"&Request.ServerVariables("Server_Name")

sqlString= "SELECT * FROM yonetici where id="&uyeid&""
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
session("gkodgoster")=session("gkodgoster")+1
Response.redirect("logout.asp?hata=1")
Response.End
'Set file_object = CreateObject("Scripting.FileSystemObject")
'Set file = file_object.CreateTextFile(Server.MapPath("../images/log"&month(date)&""&year(date)&".txt"), True)
'file.WriteLine("Bu bir denemedir.")
'file.Close

if logd="1" then
Con.execute("insert log set tarih='"&now&"',uyeid='"&uyeid&"',ip='"&ip&"',sayfa='"&sayfa&"'")
else
end if
else
yetkiuye=mmmGenel("yetki")
aduye=mmmGenel("adsoyad")
iduye=mmmGenel("id")
Con.execute("update yonetici set enson='"&now&"',ipson='"&ip&"',sayfa='"&sayfa&"' where id="&uyeid&"")

sql_kodu= "SELECT * FROM yetkiler where id="&mmmGenel("yetki")&""
set mmmYardimci = Con.Execute (sql_kodu)
if mmmYardimci.eof then
else
kullanicilar = mmmYardimci("kullanicilar")
kullanicilars = mmmYardimci("kullanicilars")
ayarlar = mmmYardimci("ayarlar")
ayarlars = mmmYardimci("ayarlars")
sayarlar = mmmYardimci("sayarlar")
sayarlars = mmmYardimci("sayarlars")
anketler = mmmYardimci("anketler")
anketlers = mmmYardimci("anketlers")
icerikler = mmmYardimci("icerikler")
iceriklers = mmmYardimci("iceriklers")
reklamlar = mmmYardimci("reklamlar")
reklamlars = mmmYardimci("reklamlars")
diller = mmmYardimci("diller")
dillers = mmmYardimci("dillers")
mayarlar = mmmYardimci("mayarlar")
mayarlars = mmmYardimci("mayarlars")
end if
close(mmmYardimci)


if logd="1" then
Con.execute("insert log set tarih='"&now&"',uyeid='"&uyeid&"',ip='"&ip&"',sayfa='"&sayfa&"'")
else
end if

end if
Close(mmmGenel)
end if
%>
