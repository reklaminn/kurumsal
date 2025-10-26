<!--#Include file="../functions/aspJSON1.17.asp"-->
<!--#Include file="../functions/dbbilgi.asp"-->
<!--#Include file="../functions/function.asp"-->

<%
    'response.Write web_fonts
imggaleriyol="../images/"
imgtempyol="../images/temp/"
dbyolurun="../images/siiroyku/"
dbyolref="../images/referans/"
dbupload="../images/haber/"
dbuploadyazar="../images/yazar/"
dbuploadyazi="../images/yazi/"
dbuploadreklam="../images/reklam/"
dbuploadbaslik="../images/baslik/"
dbuploadgaleri="../images/galeri/"
domaini=replace(replace(Request.ServerVariables("Server_Name"),".",""),"-","")
domainhttps=Request.ServerVariables("HTTPS")
if domainhttps="off" then
httpsonly=""
else
httpsonly=" Secure; HttpOnly"
end if
session("yonet_dil")="240"
if request("sek")="757" then
ceviridil="nl"
elseif request("sek")="736" then
ceviridil="fr"
else
ceviridil="en"
end if
silinmiyecekler="s835,s1013,s1011,s979,f91,f90,c155,c156,c157,c158,c159,c160,c161,c162,c163,c164,c165,c166,c167,c170,c172,c174,c175,c182,c183,c184,c90,s1080"
%>
<%
 set mmmGenel = Con.Execute ("select * from tasarim where aktif = '1'")
 menusiraadet=mmmGenel("d1")
d2=mmmGenel("d2")
d4=mmmGenel("d4")
d6=mmmGenel("d6")
d8=mmmGenel("d8")
d42=mmmGenel("d42")
d43=mmmGenel("d43")
d19=mmmGenel("d19")
d20=mmmGenel("d20")
d21=mmmGenel("d21")
d22=mmmGenel("d22")
d23=mmmGenel("d23")
d24=mmmGenel("d24")
d54=mmmGenel("d54")
d55=mmmGenel("d55")
d57=mmmGenel("d57")
temppath=mmmGenel("id")&"/"
close(mmmGenel)

%>

<%
Response.ContentType = "text/html" 
Response.Charset = "UTF-8" 
Response.Codepage = 65001 
Response.Buffer=True
session.Timeout=60

session.Timeout=60
anasayfalink=yoneticilink

if request.querystring("redirect")="0" then
redirectqry="?iframe=true&redirect=0"
end if
 if request.cookies("remember"&domaini&"rinn4")="" then%>
<!--#Include file="../functions/md5.asp"-->
<%
islem=Request("islem")
if islem="giris" then
call giris
elseif islem="sifreunutt" then
call sifreunutt
else
end if



sub sifreunutt
email = giriskont(request("email")) 
sqlString = "select * from yonetici where email='"&email&"'" 
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.Eof then
Response.redirect("index.asp?hata=4")
Response.End
else
alici=email
smtpserver=""
smtpport="25"
baslik1= ""&sitename&" Sitenizin Admin Panel Şifreniz"
 Dim html
    html = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    html = html & "<html>"
    html = html & "<head>"
    html = html & "<title>"&sitename&" Sitenizin Admin Panel Şifreniz</title>"
    html = html & "</head>"
    html = html & "<body>"
    html = html & "<br>"
	html = html & "<b>" & rs("adsoyad")&" :</b> " 
				html = html & "<hr>"  
				html = html & "<b>Kullanıcı Adınız :" & mmmGenel("admin")&"</b> " 	
				html = html & "<hr>" 
				html = html & "<b>Şifreniz :" & mmmGenel("sifre")&"</b> " 
				html = html & "<hr>" 
	 html = html & "</body>"
    html = html & "</html>"
	
	Set objMail = Server.CreateObject("CDO.Message")
	Set objConf = Server.CreateObject("CDO.Configuration") 
	Set objFields = objConf.Fields
	
	With objFields
		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")  = smtpserver 
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10 
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = smtpport
		.Update 
	End With

	With objMail
		Set .Configuration = objConf
		.From = alici&","&siteemail
		.To = alici
		.Subject = baslik1
		.HtmlBody = HTML
	End With
    
    Err.Clear 
	on error resume next

    objMail.Send
	if len(Err.Description) = 0 then
        mes = " The message was sent to " + sTo
        mes = mes + " "
        IsSuccess = true
    else
		mes = " " + Err.Description + " The mail sending test failed."
	end if
	Set objFields = Nothing
	Set objConf = Nothing
	Set objMail = Nothing

end if
close(mmmGenel)
end sub

sub giris
Emaily = trim(request("admin")) 
Emaily1 = md5(trim(request("sifre")))

if session("myrinn_uye_kodu1")=request("sifre2") or session("gkodgoster")<=3 or request.Cookies("remember"&domaini&"rinn2")="1" or request.Cookies("remember"&domaini&"rinn3")="1" then
if request.Cookies("remember"&domaini&"rinn3")="1" then
uyeid = giriskont(request.cookies("remember"&domaini&"rinn4")) 
if uyeid="" then
response.Redirect("logout.asp")
else
end if
sqlString = "select * from yonetici where id="&uyeid&"" 
else
admin = giriskont(Emaily) 
sifre = giriskont(Emaily1) 
' and durum='1'
sqlString = "select * from yonetici where admin='"&admin&"' and sifre='"&sifre&"'" 
end if

set mmmGenel = Con.Execute (sqlString)
if mmmGenel.Eof then
session("gkodgoster")=session("gkodgoster")+1
Response.redirect("index.asp?hata=1")
Response.End
else
uyeid=mmmGenel("id")
ip=Request.ServerVariables("REMOTE_ADDR") ' IP adresi

if request.Form("forever")="1" or request.cookies("remember"&domaini&"rinn3")="1" then

response.cookies("remember"&domaini&"rinn3").Expires=dateAdd("d", 30, Now())
remember_rin3=request.cookies("remember"&domaini&"rinn3")
if remember_rin3="" or remember_rin3="0" then
Response.AddHeader "Set-Cookie", "remember"&domaini&"rinn4="&uyeid&"; expires="&dateAdd("d", 30, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"rinn3")=request("forever")
else
end if
response.cookies("remember"&domaini&"rinnsecure")="1"
response.cookies("remember"&domaini&"rinnsecure").Expires=dateAdd("d", 30, Now())

else
'response.cookies("remember"&domaini&"rinn4").Expires=dateAdd("n", 30, Now())
Response.AddHeader "Set-Cookie", "remember"&domaini&"rinn4="&uyeid&"; expires="&dateAdd("n", 30, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"rinnsecure")="1"
response.cookies("remember"&domaini&"rinnsecure").Expires=dateAdd("n", 30, Now())
   response.cookies("remember"&domaini&"rinn3")=""
end if

close(mmmGenel)
uyeid=request.cookies("remember"&domaini&"rinn4")

sqlString= "update yonetici set enson='"&now&"',ip='"&ip&"' where admin='"&admin&"' and sifre='"&sifre&"'"
Con.execute(sqlString)
if request.querystring("redirect")="0" then
%>

<script>
  if (window.top !== window.self) {
    window.top.postMessage({ type: 'SESSION_RENEWED' }, '*'); // mümkünse '*' yerine üst origin'i yaz
  }
</script>

<%
redirectqry="?iframe=true&redirect=0"
else
Response.redirect(""&anasayfalink&"")
end if
 End If 
else
session("gkodgoster")=session("gkodgoster")+1
Response.redirect("index.asp?hata=1")
Response.End
end if
end sub%>
<%if request.Cookies("remember"&domaini&"rinn3")="1" then  
response.Redirect("?islem=giris")
else
end if%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <META http-equiv=Copyright  content="Copyright   <%=year(date)%>&nbsp;&nbsp;http://www.rinn.web.tr/">
    <meta name="robots" content="noindex">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=sitesahip%> Admin Paneli</title>

    <!-- Bootstrap -->
    <link href="<%=cloudpath%>admin/vendors/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<%=cloudpath%>admin/vendors/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<%=cloudpath%>admin/vendors/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="<%=cloudpath%>admin/vendors/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
      <link href="<%=cloudpath%>admin/css/admin.min.css" rel="stylesheet">
    <link href="<%=cloudpath%>admin/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>
      
    <% karakterler1a="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1a=len(karakterler1a)
for iks = 1 to 4
kacincikarakter1a=int((karakterboyu1a*rnd)+1)
uretilensifre1a=uretilensifre1a&mid(karakterler1a,kacincikarakter1a,1)
next
sifreuret1a = uretilensifre1a

session("myrinn_uye_kodu1")=sifreuret1a
%>
      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form name="formLogin"  id="formLogin" onSubmit="return validate(this);" action="index.asp<%=redirectqry%>" method="post" target="_self">
            <input name="islem" type="hidden" value="giris"/>
              <h1>Admin Form</h1>
              <div>
              <input name="admin" type="text" class="form-control" id="username_id" placeholder="Kullanıcı Adınız" autocomplete="off" value="" required/>
              </div>
              <div>
              <input name="sifre" type="password" id="password" class="form-control" placeholder="Şifreniz" value="" required/>
              </div>
              <%if request.cookies("remember"&domaini&"rinn2")="1" or session("gkodgoster")<=3 then
		  else%>
          <input name="gkodu" type="hidden" value="<%=session("myrinn_uye_kodu1")%>"/>
          <div>
          <div id="gkod2"><%=session("myrinn_uye_kodu1")%></div><input name="sifre2" type="text" id="gkod"   title="GÃ¼venlik Kodu" autocomplete="off" />
          </div>
          <%end if%>
              <div>
               <input type="submit" name="Submit" value="Giriş Yap" class="btn btn-default submit">
                <a class="reset_pass" href="#signup">Şifrenizimi Unuttunuz?</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <input type="checkbox" id="on_off" name="forever" class="on_off_checkbox"  value="1" <%if request.cookies("remember"&domaini&"rinn3")="1" then%>checked<%else%><%end if%>   />
              <span class="f_help">Oturumu Açık Tut</span>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> <a href="http://<%=webadmin%>" title="<%=webadmin%>" target="_blank"><%=webadmin%></a></h1>
                  <p>&copy; Copyright <%=year(date)%>  All Rights Reserved. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>

    
        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form name="formLogin"  id="formLogin" onSubmit="return validate(this);" action="index.asp?hata=3" method="post" target="_parent">
            <input name="islem" type="hidden" value="sifreunutt"/>
              <h1>Şifremi Unuttum</h1>
              <div>
                <input type="text" name="email" class="form-control" placeholder="Email Adresiniz" required autocomplete="off" />
              </div>
              <div>
                Email Adresinizi Girin ve Göndere Basın.
              </div>
              <div>
                <input type="submit" name="Submit" value="Gönder" class="btn btn-default submit">
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">
                  <a href="#signin" class="to_register"> Giriş Yap </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> <a href="http://<%=webadmin%>" title="<%=webadmin%>" target="_blank"><%=webadmin%></a></h1>
                  <p>&copy; Copyright <%=year(date)%>  All Rights Reserved. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>

<%else%>
<%

session("gkodgoster")=0
Response.redirect(""&anasayfalink&"")

end if%>