<%

    memberseolink="/i/uyelik.html"
nomemberseolink="/i/nomember.html"
odemememberseolink="/i/odeme.html"
eticaretuyelikseolink="i/uyelik.html"
editmemberprofileseolink="/y/uyelik-bilgileriniz.html"
editmembermessagesseolink="/y/mesajlar.html"
    eticaretyeni_uye_kaydiseolinky="y/yeni-uye-kaydi.html"
eticaretuyelikseolinky="y/uyelik.html"
eticaretodeme_secenekleriseolinky="y/odeme-secenekleri.html"
eticaretteslimat_profillerinizseolinky="y/teslimat-profilleriniz.html"
eticaretfatura_profillerinizseolinky="y/fatura-profilleriniz.html"
eticaretsiparis_bilgileriseolinky="y/siparis-bilgileri.html"
eticaretsiparis_onayseolinky="y/siparis-onay.html"
eticaretsifremi_unuttumseolinky="y/sifremi-unuttum.html"
eticaretuyelik_bilgilerinizseolinky="y/uyelik-bilgileriniz.html"
eticaretsifre_degistirseolinky="y/sifre-degistir.html"
eticaretsiparislerinizseolinky="y/siparisleriniz.html"
eticarethavale_eft_bildirim_formuseolinky="y/havale-eft-bildirim-formu.html"
eticaretdestekseolinky="y/destek.html"
islem=Request.QueryString("islem")
    
    if request.cookies("remember"&domaini&"pb")="" then
set mmmYardimci2 = Con.Execute ("SELECT * from "&dbsparabirimi&" where vpb  = '1'")
response.cookies("remember"&domaini&"pb")=mmmYardimci2("pb")
close(mmmYardimci2)
else
if request("pb")="" then
response.cookies("remember"&domaini&"pb")=request.cookies("remember"&domaini&"pb")
else
response.cookies("remember"&domaini&"pb")=request("pb")
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end if

end if



     'session("myrinn_uye_kodu1")=request("sifre2") or session("gkodgoster")<=3 or 
sub uyegirisi
    Response.AddHeader "Content-Type", "application/json"
if session("myrinn_uye_kodu1")=session("myrinn_uye_kodu1") or request.Cookies("remember"&domaini&"ck2")="1" or request.Cookies("remember"&domaini&"ck3")="1" then
if request.Cookies("remember"&domaini&"ck3")="1" then
girisuyeid = giriskont(request.cookies("remember"&domaini&"ck4")) 
if girisuyeid="" then
    mes="Üye Girişi Başarısız -001"
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(mes)&""",""link"":""?sayfa=uyelik&islem=cikis""}"
'response.Redirect("?sayfa=uyelik&islem=cikis")
else
end if
sqlString = "select * from "&dbsuyeler&" where id="&girisuyeid&"" 
else

Email = giriskont(trim(request.form("admin")))
Email1 = md5(giriskont(trim(request.form("pass"))))
admin = EmailDuzelt(Email) 
sifre = EmailDuzelt(Email1)
' and durum='1'
sqlString = "select * from "&dbsuyeler&" where email = '"&admin&"' and sifre='"&sifre&"'" 
end if

set mmmGenel = Con.Execute (sqlString)
if mmmGenel.Eof then
session("gkodgoster")=session("gkodgoster")+1
'session("hata")=""&storeesser(236)&""
'session("hatam")="red"
'response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
    mes="Üye Girişi Başarısız -002 ("&storeesser(236)&")"
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(mes)&"""}"
else
girisuyeid=mmmGenel("yid")
ip=Request.ServerVariables("REMOTE_ADDR") ' IP adresi

if request.Form("forever")="1" or request.cookies("remember"&domaini&"ck3")="1" then

response.cookies("remember"&domaini&"ck3").Expires=dateAdd("d", 30, Now())
remember_rin3=request.cookies("remember"&domaini&"ck3")
if remember_rin3="" or remember_rin3="0" then
Response.AddHeader "Set-Cookie", "remember"&domaini&"ck4="&girisuyeid&"; expires="&dateAdd("d", 30, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"ck3")=request("forever")
else
end if
response.cookies("remember"&domaini&"cksecure")="1"
response.cookies("remember"&domaini&"cksecure").Expires=dateAdd("d", 30, Now())

else
'response.cookies("remember"&domaini&"ck4").Expires=dateAdd("n", 30, Now())
Response.AddHeader "Set-Cookie", "remember"&domaini&"ck4="&girisuyeid&"; expires="&dateAdd("n", 30, Now())&"; path=/;"&httpsonly&"" 
response.cookies("remember"&domaini&"cksecure")="1"
response.cookies("remember"&domaini&"cksecure").Expires=dateAdd("n", 30, Now())
   response.cookies("remember"&domaini&"ck3")=""
end if
if request.cookies("remember"&domaini&"ckM_Uye_ID")="" or isNull(request.cookies("remember"&domaini&"ckM_Uye_ID")) then
    ckM_Uye_ID="0"
    else
    ckM_Uye_ID=request.cookies("remember"&domaini&"ckM_Uye_ID")
    end if

Con.execute("update "&dbsuyeler&" set son_tarih='"&now&"',last_ip='"&Request.ServerVariables("REMOTE_ADDR")&"' where yid="&girisuyeid&"")

set mmmYardimci3 = Con.Execute ("SELECT * FROM "&dbssepet&" where uyeid="&ckM_Uye_ID&"") 
Do While Not mmmYardimci3.eof 
Con.execute("update "&dbssepet&" set uyeid='"&girisuyeid&"' where id="&mmmYardimci3("id")&"")
mmmYardimci3.MoveNext
  loop
close(mmmYardimci3)

sure=3 ' Tekil hitlerdeki zaman farkını burdan belirleyebilirsiniz 
online_sure=30  'Burada kişi çıktıktan kaç dakika sonra database'den sileneceğini belirliyoruz.

set mmmYardimci3 = Con.Execute ("SELECT * FROM "&dbsonline&" where ip='"&ip&"' and uyeid='"&girisuyeid&"'") 
if mmmYardimci3.eof then
Con.execute("insert "&dbsonline&" set ip='"&ip&"',tarih='"&now&"',uyeid='"&girisuyeid&"'")
else
Con.execute("update "&dbsonline&" set tarih='"&now&"' where ip='"&ip&"' and uyeid='"&girisuyeid&"'")
end if
close(mmmYardimci3)

set mmmYardimci3 = Con.Execute ("SELECT * FROM "&dbsonline&"") 
Do While Not mmmYardimci3.eof 
zaman=datediff("n",mmmYardimci3("tarih"),now) 'datediff komutu iki farklı zaman dilimi arasında ne kadar fark olduğunu bulmaya yarıyor. Bu farkı ay=m, gun=d, hafta=w, saat=h, dakika=n, saniye=s cinsinden bulabiliryoruz. Örneğin datediff("n",rsesser1("tarih_saat"),now) burda veirtabanındaki kayıtlı tarih ile şu an ki tarih arasında "n" yani dakika cinsinden ne kadar fark var diye bakıyoruz.1 dk'yi geçen ip'leri böylece tespit edip aşağıda siliyoruz
if zaman > online_sure then ' 1 dk geçtiyse o ip'yi sil
Con.Execute ("delete from "&dbsonline&" where ip = '"&mmmYardimci3("ip")&"'") 
end if
mmmYardimci3.movenext
Loop
online_toplam = mmmYardimci3.RecordCount ' kaç kişi online onu buluyoruz
close(mmmYardimci3)

'session("hata")=""&storeesser(235)&""
'session("hatam")="green"
'response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
    if request.QueryString("durum")="siparisgec" then
response.Write "{""response"":""success"",""selfLink"":"""&server.HTMLEncode("/"&eticaretsiparis_bilgileriseolinky&"")&"""}"
    else
response.Write "{""response"":""success"",""selfLink"":"""&server.HTMLEncode("/"&eticaretuyelikseolink&"")&"""}"
    end if
 End If 
else

session("gkodgoster")=session("gkodgoster")+1
'session("hata")=""&storeesser(236)&""
'session("hatam")="red"
    mes="Üye Girişi Başarısız -002 ("&storeesser(236)&")"
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(mes)&"""}"
'response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
end if
close(mmmGenel)
    response.End
 end sub

 if request.Cookies("remember"&domaini&"ck4")="" then
if request.cookies("remember"&domaini&"ckM_Uye_ID")="" and request("httpssession")="" then
karakterler1="0123456789"
randomize
karakterboyu1=len(karakterler1)
for iks = 1 to 8
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
muyeid = uretilensifre1
Response.AddHeader "Set-Cookie", "remember"&domaini&"ckM_Uye_ID="&muyeid&"; expires="&dateAdd("n", 30, Now())&"; path=/;"&httpsonly&"" 
   ' girisuyeid=muyeid
else
     'girisuyeid=request.cookies("remember"&domaini&"ckM_Uye_ID")
end if
else

set mmmYardimci2 = Con.Execute ("select * from "&dbsuyeler&" where yid="&request.cookies("remember"&domaini&"ck4")&"") 
IF mmmYardimci2.Eof Then
else

Session("kulad") = mmmYardimci2("email")
Session("pass") = mmmYardimci2("sifre")
Session("S_Uye_ID") = mmmYardimci2("yid")
Session("grup") = mmmYardimci2("grup")
Session("uturu") = mmmYardimci2("uturu")
Session("onay") = mmmYardimci2("onay")
Session("odemed") = mmmYardimci2("odemed")
uye_uyeadi=mmmYardimci2("ad")
girisuyeid=mmmYardimci2("yid")
girisuyeemail=mmmYardimci2("email")
if session("grup")="" then
grupidd=1
else
grupidd=session("grup")
end if
set mmmYardimci3 = Con.Execute ("select * from "&dbsuyegrup&" where id="&grupidd&"") 
Session("fiyat") = mmmYardimci3("fiyat")
Session("bindirme") = mmmYardimci3("kar")
Session("indirim") = mmmYardimci3("indirim")
Session("kdvgoster") = mmmYardimci3("kdv")
 End If 
 close(mmmYardimci3)

end if

if request("istediklerim")="1" then
if girisuyeid="" then
response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
else
end if
set mmmYardimci2 = Con.Execute ("select * from "&dbsistediklerim&" where urunid='"&giriskont(request("urunid"))&"' and uyeid='"&girisuyeid&"' and istektur = '0'")
if mmmYardimci2.eof then
Con.execute("insert "&dbsistediklerim&" set urunid='"&giriskont(request("urunid"))&"', uyeid='"&girisuyeid&"', tarih='"&now&"', istektur='0'")
session("hata")=""&storeesser(225)&""
session("hatam")="green"
else
session("hata")=""&storeesser(226)&""
session("hatam")="red"
end if
close(mmmYardimci2)
elseif request("istediklerim")="2" then
if girisuyeid="" then
response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
else
end if
set mmmYardimci2 = Con.Execute ("select * from "&dbsistediklerim&" where urunid='"&giriskont(request("urunid"))&"' and uyeid='"&girisuyeid&"' and istektur = '1'")
if mmmYardimci2.eof then
Con.execute("insert "&dbsistediklerim&" set urunid='"&giriskont(request("urunid"))&"', uyeid='"&girisuyeid&"', tarih='"&now&"', istektur='1'")
session("hata")=""&storeesser(227)&""
session("hatam")="green"
else
session("hata")=""&storeesser(228)&""
session("hatam")="red"
end if
close(mmmYardimci2)
elseif request("istediklerim")="3" then
Con.Execute  ("delete from "&dbsistediklerim&" where urunid='"&giriskont(request("urunid"))&"' and uyeid='"&girisuyeid&"' and istektur = '1'")
session("hata")=""&storeesser(232)&""
session("hatam")="red"
elseif request("istediklerim")="4" then
Con.Execute  ("delete from "&dbsistediklerim&" where urunid='"&giriskont(request("urunid"))&"' and uyeid='"&girisuyeid&"' and istektur = '0'")
session("hata")=""&storeesser(231)&""
session("hatam")="red"
else
end if


if session("karsilastir")="" then
session("karsilastir")="Q=0"
else
if request("karsilastir")="" then
session("karsilastir")=session("karsilastir")
else
if girisuyeid="" then
response.Redirect(""&pathim&""&eticaretuyelikseolink&"")
else
end if
if instr(1,session("karsilastir"),request("kurunid"))="0" then
session("karsilastir")=session("karsilastir")&"&Q="&request("kurunid")
session("hata")=""&storeesser(223)&""
session("hatam")="green"
else
session("hata")=""&storeesser(224)&""
session("hatam")="red"
end if
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end if

end if

if session("grup")="" then
grupidd=2
else
grupidd=session("grup")
end if
set mmmYardimci2 = Con.Execute ("select * from "&dbsuyegrup&" where id="&grupidd&"")
Session("fiyat") = mmmYardimci2("fiyat")
Session("bindirme") = mmmYardimci2("kar")
Session("indirim") = mmmYardimci2("indirim")
Session("kdvgoster") = mmmYardimci2("kdv")
close(mmmYardimci2)

if islem="emailkontrol" then
call emailkontrol
    elseif islem="uyegirisi" then
call uyegirisi
    elseif islem="emailvarmi" then
call emailvarmi
elseif islem="iletisimgonder" then
call iletisimgonder
elseif islem="cikis" then
call cikis
elseif islem="uyeeklefacebook" then
call uyeeklefacebook
elseif islem="uyeekle" then
call uyeekle
elseif islem="sifresor" then
call sifresor
elseif islem="sifresordegis" and (girisuyeid<>"" or girisuyeid<>"0") then
call sifresordegis
elseif islem="duzenleuye" and (girisuyeid<>"" or girisuyeid<>"0") then
call duzenleuye
elseif islem="savewatchlist" and (girisuyeid<>"" or girisuyeid<>"0") then
call savewatchlist
elseif islem="uyesifred" and (girisuyeid<>"" or girisuyeid<>"0") then
call uyesifred
elseif (islem="messageoku" or islem="replaymessage" or islem="messagewrite" or islem="recommendmember" or islem= "reportmember") and (girisuyeid<>"" or girisuyeid<>"0") then
call messageoku
elseif islem="replaymessageadd" and (girisuyeid<>"" or girisuyeid<>"0") then
call replaymessage
elseif islem="messagedelete" and (girisuyeid<>"" or girisuyeid<>"0") then
call messagedelete
elseif islem="deepmessagedelete" and (girisuyeid<>"" or girisuyeid<>"0") then
call deepmessagedelete
    elseif islem="signin" then
call signin(0)
else
end if

    sub signin(durum)
%>

        <form method="post" action="?sayfa=uyelik&islem=uyegirisi" name="uyegirisForm" id="uyegirisForm">
            <%if eser="1" then %>
          <div class="txt-center pa1"> <a href="/eticaret/fb.asp" class="btn btn--expand btn--facebook"> <img src="/images/facebook.png" alt="Facebook" style="margin-right: 5px; margin-top: -3px" width="20"> <%=touresser(15)%> </a> </div>
          <div class="form-divider form-divider--grey">
            <div>or</div>
          </div>
            <%end if %>
          <div class="form-section signin-form">
              <div class="form-group">
          <div class="col-xs-12 padding-right-10">
            <div class="custom-placeholder">
              <label for="kullanici_email" class="custom-label" required="required" aria-required="true"> <%=storeesser(97)%> </label>
              <INPUT type="text" name="admin" class="form-control" id="kullanici_email" tabindex="1">
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-xs-12 padding-right-10">
            <div class="custom-placeholder">
              <label for="passwd" class="custom-label" required="required" aria-required="true"> <%=storeesser(306)%> </label>
              <INPUT type="password" name="pass" class="form-control" id="passwd" tabindex="1">
                <%=storeesser(109)%> <a class="floatright nounder" href="/<%=eticaretsifremi_unuttumseolinky%>?sayfa=uyelik"><%=storeesser(110)%></a>
                
                <div class="clearfix"></div>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-xs-12 padding-right-10">
            <div class="custom-placeholder">
              <label class="floatleft">
                  <input id="signinAuto" name="signinAuto" checked="checked" value="1" type="checkbox">
                  <%=touresser(18)%></label>
              <input type="submit" name="Submit" value="<%=storeesser(139)%>" class="btn btn-success pull-right">
            </div>
          </div>
        </div>
          </div>
        </form>
        <div class="form-divider"></div>
        <div class="txt-center"> <%=touresser(21)%>&nbsp;&nbsp;<a href="/<%=eticaretyeni_uye_kaydiseolinky%>" class="nounder"><%=storeesser(29)%></a> </div>
<SCRIPT LANGUAGE="JavaScript">

	function formla16(gelen16)
	{
	document.uyegirisForm.action=gelen16;
	if ($("#uyegirisForm").valid())
                {
                  document.uyegirisForm.submit();
                }	else
				{
					validatorugf.focusInvalid();
					return false;
                }
	}
  //-->
  </SCRIPT>
<%
    if durum="0" then
response.end
    end if
end sub    

sub messagedelete
if girisuyeid="" or girisuyeid="0" then
response.Redirect(""&memberseolink&"")
else
deletemessage=giriskont(request.QueryString("messageid"))
silmek = "update "&dbsuyelermessage&" set onay='2' where id="&deletemessage&""
Con.execute(silmek)

session("hata1")=""&touresser(23)&""
session("hatam1")="red"
end if
end sub

sub replaymessage()
if girisuyeid="" or girisuyeid="0" then
response.Redirect(""&memberseolink&"?sayfa=member&islem=signin")
else
end if
messagefrom=giriskont(request.QueryString("messagefrom"))
messageto=giriskont(request.QueryString("messageto"))
messageid=giriskont(request.QueryString("messageid"))
messagesubject=giriskont(request.Form("subject"))
messagemessage=giriskont(request.Form("message"))
messagemessageaboutt=giriskont(request.Form("messageabout"))
messagetor=giriskont(request.Form("messageto"))

if messagemessageaboutt="0" then
messagemessageabout="Message"
elseif messagemessageaboutt="1" then
messagemessageabout="Job Contact"
elseif messagemessageaboutt="3" then
messagemessageabout="Report"
else
messagemessageabout="Recommended"
end if
if messagefrom="" then
messagefrom="0"
else
messagefrom=messagefrom
end if

if messageto="" then
messageto="0"
else
messageto=messageto
end if

if messageid="" then
messageid="0"
else
messageid=messageid
end if

sqlString = "insert "&dbsuyelermessage&" set gelenid='"&messagefrom&"', gidenid='"&messageto&"', firstmessage='"&messageid&"', subject='"&messagesubject&"', message='"&messagemessage&"', mesajturu='"&messagemessageabout&"', tarih='"&now&"', onay='0'"
Con.execute(sqlString)
if messagemessageaboutt="2" then
e_mailfirma=messagetor
session("hata1")="Recommended"
elseif messagemessageaboutt="3" then
e_mailfirma=siteemail
session("hata1")="Reported"
else
sqlString = "SELECT * FROM "&dbsuyeler&" where yid="&messageto&""
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then	
else
c_ompany=mmmYardimci1("firma")
e_mailfirma=mmmYardimci1("email")
end if
close(mmmYardimci1)
session("hata1")=""&touresser(24)&""
end if
sqlString = "SELECT * FROM "&dbsuyeler&" where yid="&messagefrom&""
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then	
else
strad=mmmYardimci1("ad")
stremail=mmmYardimci1("email")
strnick=mmmYardimci1("link")
end if
close(mmmYardimci1)
strehtmlmail="<hr><span style=""font-weight: bold;"">"&touresser(25)&" :</span> "&strad&"<hr><span style=""font-weight: bold;"">"&touresser(26)&" :</span> "& messagemessageabout&"<hr> <span style=""font-weight: bold;"">"&touresser(27)&" :</span> "&messagesubject&"<hr /><span style=""font-weight: bold;"">"&touresser(28)&" :</span> "&messagemessage&"<hr /><br />"
Call emailgonder(""&strad&" "&touresser(29)&" "&siteadres&"",e_mailfirma,1,strehtmlmail,girisuyeid,"uyekaydi","92")


session("hatam1")="green"

end sub

    sub messageoku()
if girisuyeid="" or girisuyeid="0" then
response.Redirect(""&memberseolink&"?sayfa=member&islem=signin")
else
end if
if request.QueryString("messageid")="" then
strmessageid="0"
else
strmessageid=giriskont(request.QueryString("messageid"))
end if

if request.QueryString("messageto")="" then
strmessageto="0"
else
strmessageto=giriskont(request.QueryString("messageto"))
end if

if request.QueryString("messagetoimage")="" then
strmessagetoimage="0"
else
strmessagetoimage=giriskont(request.QueryString("messagetoimage"))
end if

if request.QueryString("messageiabout")="" then
strmessageiabout="0"
else
strmessageiabout=giriskont(request.QueryString("messageiabout"))
end if

sqlString = "SELECT * FROM "&dbsuyelermessage&" where id='"&strmessageid&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then	

else
strmessageisubject=mmmYardimci("subject")
strmessageimessage=mmmYardimci("message")
strmessageiabout=mmmYardimci("mesajturu")
strmessageitarih=mmmYardimci("tarih")
strgelenid=mmmYardimci("gelenid")
			set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&strgelenid&"")
			if mmmYardimci1.eof then
			strgelenad=""&touresser(30)&""
			else
			strgelenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
			strgidenid=mmmYardimci("gidenid")
			set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&strgidenid&"")
			if mmmYardimci1.eof then
			strgidenad=""&touresser(30)&""
			else
			strgidenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
			end if
close(mmmYardimci)
			%>
            <div class="modal-body">
			<%if islem="messageoku" then%>
          <h2><%=touresser(31)%> <%=strgelenad%></h2>
        <form method="post">
        <p style="display:none;" class="debug-url"></p>
        <fieldset>
            <p><%=touresser(32)%></p>
            <%if strmessageiabout="1" then%>
            Job Contact
            <%elseif strmessageiabout="2" then%>
            Recommended
            <%elseif strmessageiabout="3" then%>
            Report
            <%else%>
            Message
            <%end if%>
          </fieldset>
        <fieldset>
           <%=strmessageisubject%>
          </fieldset>
        <fieldset>
            <%=strmessageimessage%>
          </fieldset>
          <button type="button" class="btn btn--grey mt1" data-dismiss="modal" style="width: 100%"><%=touresser(33)%></button>          
        </form>
          <%else%>
           <%if islem="replaymessage" then
		   recommendeks="Fw: "
		   recommendekm="&#13;&#13;"&touresser(34)&": "&strgelenad&" &#13;"&touresser(35)&": "&strmessageitarih&"&#13;"&touresser(36)&": "&strgidenad&"&#13;"&touresser(27)&": RE: "&strmessageisubject&"&#13;&#13;"
		   recommendeka="?sayfa=messages&islem=replaymessageadd&messagefrom="&strgidenid&"&messageto="&strgelenid&"&firstmessageid="&strmessageid&""%>
          <h2><%=touresser(37)%> <%=strgelenad%></h2>
          <%elseif islem="messagewrite" then
		  strgidenid=strmessageto
			set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&strgidenid&"")
			if mmmYardimci1.eof then
			strgidenad=""&touresser(30)&""
			else
			strgidenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
			recommendeka="?sayfa=messages&islem=replaymessageadd&messagefrom="&girisuyeid&"&messageto="&strgidenid&""
			elseif islem="reportmember" then
			set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&strmessageto&"")
			if mmmYardimci1.eof then
			strgidenad=""&touresser(30)&""
			else
			strgidenid=mmmYardimci1("yid")
			strgidenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
			recommendeks=""&touresser(38)&" "&strgidenad&": "
		   recommendekm=""&touresser(39)&": "&strmessageitarih&"&#13;"&touresser(25)&": "&strgidenad&"&#13;"&touresser(40)&": "&strgidenid&"&#13;"&touresser(41)&": &#13;&#13; "
		   recommendeka="?sayfa=messages&islem=replaymessageadd&messagefrom="&strgidenid&"&messageto=0"%>
          <h2><%=touresser(50)%> <%=strgidenad%></h2>
          <%
		   else
		   set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&strmessageto&"")
			if mmmYardimci1.eof then
			strgidenad=""&touresser(30)&""
			else
			strgidenid=mmmYardimci1("yid")
			strgidenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
			set mmmYardimci1 = Con.Execute ("SELECT * from "&dbsuyeler&" where yid="&girisuyeid&"")
			if mmmYardimci1.eof then
			strgonderenad=""&touresser(30)&""
			else
			strgonderenid=mmmYardimci1("yid")
			strgonderenad=mmmYardimci1("ad")
			end if
			close(mmmYardimci1)
		   recommendeks=""&strgonderenad&" "&touresser(42)&" "&strgidenad&": "
		   recommendekm=""&strgonderenad&" "&touresser(43)&": "&strmessageitarih&"&#13;"&touresser(25)&": "&strgidenad&"&#13;"&touresser(40)&": "&strgidenid&"&#13;"&touresser(41)&": &#13;&#13; "
		  recommendeka="?sayfa=messages&islem=replaymessageadd&messagefrom="&girisuyeid&""%>
        <h2><%=touresser(51)%> <%=strgelenad%></h2>
        <%end if%>
        <form method="post" action="<%=recommendeka%>">
        <p style="display:none;" class="debug-url"></p>
        <%if islem="replaymessage" or islem="messagewrite" then%>
        <fieldset>
        <p><%=touresser(45)%></p> <div class="message-to-profile"><div class="mtpimage"><img src="<%=strmessagetoimage%>" height="35" /></div> <div class="mtpname"><%=strgidenad%></div></div>
        </fieldset>
        <fieldset>
            <p><%=touresser(32)%></p>
            <select name="messageabout" id="messageabout" class="form-control">
              <option value="0">-- <%=touresser(44)%> --</option>
              <option value="0" <%if strmessageiabout="0" then%>selected<%else%><%end if%>>Message</option>
              <option value="1" <%if strmessageiabout="1" then%>selected<%else%><%end if%>>Job Contact</option>
              <option value="2" <%if strmessageiabout="2" then%>selected<%else%><%end if%>>Recommended</option>
              <option value="3" <%if strmessageiabout="3" then%>selected<%else%><%end if%>>Report</option>              
            </select>
          </fieldset>
            <div class="form-divider"></div>
          <%else
		  if islem="reportmember" then%>
          <input type="hidden" name="messageto" value="<%=siteemail%>" />
          <input type="hidden" name="messageabout" value="3" />
          <%else%>
          <input type="text" name="messageto" value="" placeholder="<%=touresser(46)%>"  class="form-control"/>
          <input type="hidden" name="messageabout" value="2" />
          <%end if
		  end if%>
            <div class="form-divider"></div>
        <fieldset>
            <input name="subject" type="text" maxlength="75" id="subject" class="form-control" value="<%=recommendeks%><%=strmessageisubject%>" placeholder="<%=touresser(27)%>">
          </fieldset>
            <div class="form-divider"></div>
        <fieldset>
            <textarea name="message" rows="6" cols="20" id="message" class="form-control" placeholder="<%=touresser(28)%>"><%=recommendekm%><%=strmessageimessage%></textarea>
            <div class="textCounter maxLength4000">
              <p class="help"><strong>4000</strong> <%=touresser(47)%></p>
            </div>
          </fieldset>
            <div class="form-divider"></div>
          <%if islem="replaymessage" or islem="messagewrite" or islem="reportmember" then%>
          <button style="width: 100%" type="submit" class="btn btn-success"><%=touresser(48)%></button>
        <button type="button" class="btn btn--grey mt1" data-dismiss="modal" style="width: 100%"><%=touresser(52)%></button>
		  <%else%>
         <button style="width: 100%" type="submit" class="btn btn-default"><%=touresser(49)%></button>
        <button type="button" class="btn btn--grey mt1" data-dismiss="modal" style="width: 100%"><%=touresser(52)%></button>
        <%end if%>
        </form>
        <%end if%>
        </div>
<%
response.end
end sub


       sub uyesifred
    Con.execute("update "&dbsuyeler&" set sifre='"&giriskont(md5(Request.Form("yeni_sifre")))&"' where yid="&girisuyeid&" and sifre='"&giriskont(md5(request("eski_sifre")))&"'")
'Call emailgonder(""&touresser(71)&""&siteadres&"",request("email"),1,mmmYardimci("ad"),girisuyeid,"uyesifresor","91")
      
     Response.AddHeader "Content-Type", "application/json"
          response.Write "{""response"":""success"",""successMessage"":"""&server.HTMLEncode("Şifre Değiştirildi")&"""}"
response.End
call islemmessagesession("blue",""&esser(67)&"",1)
end sub

    sub duzenleuye
Con.execute("update "&dbsuyeler&" set ad='"&giriskont(Request.Form("name"))&"',adres='"&giriskont(Request.Form("adres"))&"',ulke='"&giriskont(Request.Form("ulke"))&"',il='"&giriskont(Request.Form("teslim_adres_sehir"))&"',ilce='"&giriskont(Request.Form("teslim_adres_ilce"))&"',tel='"&giriskont(Request.Form("tel"))&"',fax='"&giriskont(Request.Form("cep"))&"',meslek='"&giriskont(Request.Form("meslek"))&"',cins='"&giriskont(Request.Form("cins"))&"',dgun='"&giriskont(Request.Form("dgun"))&"',mailbildir='"&giriskont(Request.Form("mailbildir"))&"',smsbildir='"&giriskont(Request.Form("smsbildir"))&"' where yid="&girisuyeid&"")
    
     Response.AddHeader "Content-Type", "application/json"
          response.Write "{""response"":""success"",""successMessage"":"""&server.HTMLEncode("Üye Bilgileri Güncellendi")&"""}"
response.End
call islemmessagesession("blue","D&uuml;zenleme Yapıldı",1)
end sub


sub uyeekle
  
'Save entered data
	first_name = Request.Form("isim")
	Birth_Year = Request.Form("dtarih")
	e_mail = Request.Form("email")
	Password =  md5(Request.Form("sifre"))
	password2 = md5(Request.Form("sifre_tekrar"))
	key_ent = Request.form("key_ent")

	
	'If nothing is entered then redirect to error page!
Set mmmYardimci=Con.execute("select * from "&dbsuyeler&" where email='"&e_mail&"'")

if NOT mmmYardimci.eof then
	call islemmessagesession("red","Email Adresi Daha Önce Kayıtlı.","/"&eticaretyeni_uye_kaydiseolinky&"")
	else
	end if
close(mmmYardimci)
	if NOT request.form("uyesozlesme") = "1" then 
	call islemmessagesession("red","Üyelik Sözleşmesini Kabul Etmediniz.","/"&eticaretyeni_uye_kaydiseolinky&"")
	else
	end if
	if NOT password = password2 then 
	call islemmessagesession("red","Şifre Bilgilerniz Tutmuyor. Lütfen Şifrenizi Tekrar Giriniz.","/"&eticaretyeni_uye_kaydiseolinky&"")
	else
	end if
	if password ="" or password2 ="" then 
	call islemmessagesession("red","Şifre Bilgilerinizi Boş Girmeyiniz.","/"&eticaretyeni_uye_kaydiseolinky&"")
	else
	end if
	if e_mail = "" or instr(e_mail,"@")="0"  then 
	call islemmessagesession("red","Emailinizi Boş veya Geçerli Olmayan Bir Email Adresi Olarak Girmeyiniz.","/"&eticaretyeni_uye_kaydiseolinky&"")
	else
	end if
	
Con.execute("insert "&dbsuyeler&" set ad='"&giriskont(Request.Form("name"))&"',email='"&giriskont(Request.Form("email"))&"',sifre='"&giriskont(Password)&"',il='"&giriskont(Request.Form("sehir"))&"',fax='"&giriskont(Request.Form("cep"))&"',uturu='"&giriskont(Request.Form("uyeturu"))&"',dgun='"&giriskont(Request.Form("dgun"))&"',firma='"&giriskont(Request.Form("firma"))&"',onay='1',grup='2',uyesozlesme='1',mailbildir='"&giriskont(Request.Form("mailbildir"))&"',smsbildir='0',tarih='"&now()&"'")
Call emailgonder(""&siteadres&" Sitemize Üye Oldunuz.",request("email"),1,Request.Form("name")&"/-/"&Request.Form("email")&"/-/"&Request.Form("sehir")&"/-/"&Request.Form("dgun")&"/-/"&Request.Form("cep")&"",girisuyeid,"uyekaydi","92")

call islemmessagesession("green",storeesser(96),"/"&eticaretuyelikseolink&"")
end sub

sub sifresordegis
    if request.QueryString("tarih")=date then
Con.execute("select * from "&dbsuyeler&" where yid='"&giriskont(request.QueryString("uyeid"))&"' and sifre='"&giriskont(request.QueryString("gkodu"))&"'")	  
if mmmYardimci.eof then
call islemmessagesession("red",""&touresser(73)&"",1)
else
Con.execute("update "&dbsuyeler&" set sifre='"&giriskont(request.QueryString("yenisifre"))&"' where yid='"&giriskont(request("uyeid"))&"' and sifre='"&giriskont(request("gkodu"))&"'")
call islemmessagesession("green",""&touresser(74)&"","/"&eticaretuyelikseolink)
end if
close(mmmYardimci)
else
call islemmessagesession("red",""&touresser(75)&"",1)
end if

end sub

sub sifresor

    Set mmmYardimci=Con.execute("select * from "&dbsuyeler&" where email='"&giriskont(request("email"))&"'")	  
if mmmYardimci.eof then
call islemmessagesession("red",""&touresser(73)&"",1)
else
karakterler1="0123456789AbCdEfGhIjKlYz"
randomize
karakterboyu1=len(karakterler1)
for ssoi = 1 to 5
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
yenisifre = uretilensifre1
call islemmessagesession("green",""&storeesser(111)&" <strong>"&request("email")&"</strong> Adresine Gönderilmiştir...",1)
email=giriskont(request("email"))
sssitename = webadres
sssifre = mmmYardimci("sifre")
ssuyeid = mmmYardimci("yid")
sskulad = mmmYardimci("email")
Call emailgonder(""&touresser(78)&" "&siteadres&"",sskulad,1,mmmYardimci("ad")&"/-/"&sssifre&"/-/"&yenisifre,ssuyeid,"uyesifresor","93")
mesaj=""&webadres&""&touresser(77)&""
yenisifre=""
end if
close(mmmYardimci)

 end sub

sub cikis
	domaini=replace(Request.ServerVariables("Server_Name"),".","")
response.cookies("remember"&domaini&"ck3")=""
response.cookies("remember"&domaini&"ck4")=""
response.cookies("remember"&domaini&"cksecure")=""

response.cookies("remember"&domaini&"ck3").Expires = Date() - 1
response.cookies("remember"&domaini&"ck4").Expires = Date() - 1
response.cookies("remember"&domaini&"cksecure").Expires = Date() - 1

session.Abandon
	call islemmessagesession("red",storeesser(307),1)
    End Sub

sub uyeeklefacebook
strID =request("strID")
	strFirstName =request("strFirstName")
	strLastName =request("strLastName")
	strLocation =request("strLocation")
	strEducation =request("strEducation")
	strEMail =request("strEMail")
	strGender = request("strGender")
    json_str =request("json_str")
if request.QueryString("uturu")="" then
uturu="1"
stronay=ud10
else
uturu=request.QueryString("uturu")
if uturu="1" then	
	stronay=ud10
	else
	stronay=ud13
	end if
end if

 karakterler1="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1=len(karakterler1)
for ifc = 1 to 8
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
sifreuret1 = uretilensifre1

l_ink=linkmember(strFirstName & " " & strLastName)

ip=Request.ServerVariables("REMOTE_ADDR") ' IP adresi
set mmmYardimci = Con.Execute ("select * from "&dbsuyeler&" where email = '"&strEMail&"'")
if mmmYardimci.eof then
'"ulke='"&giriskont(strLocation)&"'," & _
Con.execute("insert uyeler set " & _
"ad='"&giriskont(strFirstName & " " & strLastName)&"'," & _
"displayname='"&giriskont(strFirstName)&"'," & _
"email='"&giriskont(strEMail)&"'," & _
"sifre='"&giriskont(md5(sifreuret1))&"'," & _
"uturu='"&uturu&"'," & _
"cinsiyet='"&left(strGender,1)&"'," & _
"link='"&giriskont(l_ink)&"'," & _
"onay='"&stronay&"'," & _
"grup='2'," & _
"uyesozlesme='1'," & _
"mailbildir='1'," & _
"smsbildir='0'," & _
"facebook='1'," & _
"fbid='"&giriskont(strID)&"'," & _
"json='"&giriskont(json_str)&"'," & _
"tarih='"&now()&"'," & _
"son_tarih='"&now()&"'," & _
"last_ip='"&ip&"'")
strehtmlmail="<hr><span style=""font-weight: bold;"">Adınız Soyadınız :</span> "&giriskont(strFirstName & " " & strLastName)&"<hr> <span style=""font-weight: bold;"">Email Adresiniz :</span> "&strEMail&"<hr /><br />"
Call emailgonder(""&siteadres&" Sitemize Üye Oldunuz.",strEMail,1,strehtmlmail,girisuyeid,"uyekaydi","92")
strehtmlmail="<hr><span style=""font-weight: bold;"">Adı Soyadı :</span> "&giriskont(strFirstName & " " & strLastName)&"<hr> <span style=""font-weight: bold;"">Email Adresi :</span> "&strEMail&"<hr /><br />"
Call emailgonder(""&siteadres&" Sitemize Üye Oldunuz.",strEMail,0,strehtmlmail,girisuyeid,"uyekaydiyonetici","91")
set mmmYardimci1 = Con.Execute ("select * from "&dbsrehberfirmalar&" where fbid='"&strID&"'order by id desc")
if mmmYardimci1.eof then
else
Session("my_talent_Uye_ID") = mmmYardimci1("id")
uye_uyeadi=mmmYardimci1("ad")
end if
close(mmmYardimci1)
else
if mmmYardimci("facebook")="1" then
else
Con.execute("update uyeler set facebook='1',fbid='"&strID&"',json='"&giriskont(json_str)&"',son_tarih='"&now&"',last_ip='"&ip&"' where email = '"&strEMail&"'")
end if
session("hata")=""&touresser(80)&""
session("hatam")="green"
Session("my_talent_Uye_ID") = mmmYardimci("id")
uye_uyeadi=mmmYardimci("ad")

end if
close(mmmYardimci)

response.Redirect(""&memberseolink&"")
end sub

sub iletisimgonder
	session("hata")=touresser(84)
session("hatam")="green"
    strehtmlmail="<hr><span style=""font-weight: bold;"">"&touresser(59)&" :</span> "&request.form("isim")&"<hr> <span style=""font-weight: bold;"">"&touresser(16)&" :</span> "&request.form("email")&"<hr> <span style=""font-weight: bold;"">"&touresser(86)&" :</span> "&request.form("irtibat_tel")&"<hr> <span style=""font-weight: bold;"">"&touresser(32)&" :</span> "&request.form("sebeb")&"<hr> <span style=""font-weight: bold;"">"&touresser(27)&" :</span> "&request.form("mesaj")&"<hr /><br />"
Call emailgonder(""&touresser(87)&" "&siteadres&"",e_mail,0,strehtmlmail,girisuyeid,"uyekaydiyonetici","80")
    End Sub 

sub emailkontrol
sqlString = "SELECT * FROM "&dbsuyeler&" where email='"&Request.QueryString("email")&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then		
	succes="isfailed"
response.Write(succes)	
response.End()		
else
succes="issucces"
response.Write(succes)
response.End()
end if
close(mmmYardimci)

end sub

        function ililcecek(varyantidfnc,tur)
    if tur="1" then
set mmmSayfa2 = Con.Execute ("select sehir from "&dbcil&" where il="&varyantidfnc&"")
if mmmSayfa2.eof then
ililcecek=""
else
ililcecek=mmmSayfa2("sehir")
end if
close(mmmSayfa2)
    else
set mmmSayfa2 = Con.Execute ("select ilce from "&dbcilce&" where id="&varyantidfnc&"")
if mmmSayfa2.eof then
ililcecek=""
else
ililcecek=mmmSayfa2("ilce")
end if
close(mmmSayfa2)
    end if
end function

function sociallinkal(socialsecim,strsocial)
if instr(strsocial,"["&socialsecim&"]") then
socialsec=split(strsocial,"["&socialsecim&"]")(1)
socialsec=split(socialsec,"[/"&socialsecim&"]")(0)
sociallinkal=socialsec
else
sociallinkal=""
end if
end function

function sociallinkbutton(socialsecim,strsocial,socialbaslink)
if instr(strsocial,"["&socialsecim&"]") then
socialsec=split(strsocial,"["&socialsecim&"]")(1)
socialsec=split(socialsec,"[/"&socialsecim&"]")(0)
sociallinkbutton="<a class=""js-social-click influence__item"" href="""&socialbaslink&""&socialsec&""" target=""_blank""><img class=""influence__icon"" src=""/images/"&socialsecim&"-square.svg""></a>"
else
sociallinkbutton=""
end if
end function

sub emailvarmi()
e_mail=request("email")
Set mmmYardimci=Con.execute("select * from "&dbsuyeler&" where email='"&e_mail&"'")

if mmmYardimci.eof then
response.Write("true")
response.End()
	else
	response.Write("false")
response.End()
	end if
close(mmmYardimci)
end sub
%>