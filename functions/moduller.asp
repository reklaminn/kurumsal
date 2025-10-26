<% Sub moduller(ldh1,ldh2,ldh3,ldh4,ldh5,ldh6,ldh7) 

    if smodula="1" then

		  modaid=anaid

		  else

		  modaid=id

		  end if

strmsid=ldh1

strmssayfa=ldh3

strmsmodulid=ldh4

strmstemp=ldh5

strmsbaslik=ldh2

strmsgoster=ldh6

strmsonay=ldh7


		if isNull(strmssayfa) then

		strmssayfa="0"

		else

		strmssayfa=strmssayfa

		end if

		strmssayfa=replace(replace(strmssayfa,"k",""),"y","")

   ' response.Write strmssayfa

  if strmsmodulid=87 then

  Call yanmenu(strmssayfa,strmstemp)

  elseif strmsmodulid=110 then

  Call baslik(deger1,deger2)

  elseif strmsmodulid=1381 then

  Call menuustkurumsal(strmssayfa,deger2)

  elseif strmsmodulid=136 then

  response.Write(logomenu(deger1,deger2))

  elseif strmsmodulid=137 then

  response.Write(ustmenu(2,strmssayfa,strmstemp))

  elseif strmsmodulid=293 then

  response.Write(sitereviews(hdrturid,strmstemp))

  elseif strmsmodulid=112 then

  Call harita(strmssayfa,strmstemp,1,strmsbaslik)

  elseif strmsmodulid=114 or strmsmodulid=131 or strmsmodulid=130 or strmsmodulid=134 or strmsmodulid=135 or strmsmodulid=123 then

    if strmsmodulid=114 or strmsmodulid=134 then

    kod="resim"

    elseif strmsmodulid=131 or strmsmodulid=123 then

    kod="kate"

    else

    kod="yazi"

    end if

  response.Write(yanliste(strmssayfa,strmstemp,strmsbaslik,ayar2,kod))

  elseif strmsmodulid=115 then

  Call tamicerik(strmssayfa,strmstemp,strmsbaslik,ayar2)

  elseif strmsmodulid=282 then

    'Response.Clear()

    Response.Status = "404 Not Found"

    servername= Request.ServerVariables ("SERVER_NAME")

    QUERYSTRING= Request.ServerVariables ("QUERY_STRING")



    eskiseolinkk= ucbirurlc(QUERYSTRING,servername)



  elseif strmsmodulid=121 then

  Call filtremenu(strmssayfa,89,strmstemp,ayar2)

  elseif strmsmodulid=9999 then

  i1ayar3=strmssayfa

	  if i1ayar3=0 or i1ayar3="" then

	  i1ayar3="" 

	  else

	  end if

	  kayar2=strmstemp

	  kayar3=ayar2

	  if kayar2=0 then

csstip=""

else

csstip=i1ayar3

end if



  Call kategoriayar(i1ayar3,kayar2,kayar3)

if menuisimyazi1="" or isNull(menuisimyazi1) or menuisimyazi1="99999" then

if kayar2=0 then

menuisimyazi1="<div class=""col-md-12"">#slaytresim#</div><div class=""col-md-12"">#baslikisim##yaziisim#</div>"

else

menuisimyazi1=i1

end if

else

menuisimyazi1=menuisimyazi1

end if

jsisveri1=listeleme1style(l6,csstip)

stylisveri1=listeleme1style(i8,csstip)

%>

<style>

<%=stylisveri1%>

</style>



<%session("jsisveri1")=jsisveri1%>



<%

  Call listeleme(strmssayfa,strmstemp,12,1)

  elseif strmsmodulid=125 then

  Call ekatalog(strmssayfa,strmstemp)

      elseif strmsmodulid=90 then

	  if sifreli="1" and session("rinn_sifre")="" then

	  call sifrelisayfa(ss1,ss2,ss3)

	  else

	  if Submit="sifregiris" then%>

  <div class="sifreshata"><%=session("hatamesaj")%></div>

  <%else

  end if

	  i1ayar3=strmssayfa

	  if i1ayar3=0 or i1ayar3="" then

	  i1ayar3="" 

	  else

	  end if

	  kayar2=strmstemp

	  kayar3=ayar2

	  if kayar2="0" then

else

Call kategoriayar(i1ayar3,kayar2,kayar3)

end if



'response.Write(i4&"-"&anaid&"-"&aid&"-"&id)

'if seotur="i" then

'if ""&anaid&""=""&aid&"" and i4=1 then

'istrmodulmu="2"

'istrid=aid

'else

istrmodulmu="0"

'istrid=aid

istrid=id

'end if

      'if request.cookies("remember_ana_dil")=request.cookies("remember_dil") then

      if request.cookies("remember_dil")="240" then

sqlstring="select * from kategoriyazi,yazilar where yazilar.kategori = kategoriyazi.id and  kategoriyazi.id = "&istrid&" and yazilar.modulmu='"&istrmodulmu&"' and yazilar.durum='1' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

      else

     ' if seotur="yazi" then

'sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.bagli = "&istrid&" and  kategoriyazi.id and yazilar.modulmu='"&istrmodulmu&"' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

sqlstring="select * from kategoriyazi,yazilar where yazilar.kategori = '"&istrid&"' and  kategoriyazi.id = '"&istrid&"' and yazilar.modulmu='"&istrmodulmu&"' and yazilar.durum='1' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

 '     else

'sqlstring="select * from kategoriyazi,yazilar where yazilar.kategori = kategoriyazi.bagli and  kategoriyazi.id = "&istrid&" and yazilar.modulmu='"&istrmodulmu&"' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

  '    end if

      end if

'else

'istrid=id

'sqlstring="select * from yazilar where id = "&urunid&" order by id"

'end if

      set mmmsayfa2 = Con.Execute (sqlstring)

if mmmsayfa2.eof then   

      'response.Write istrid&"-"&kayar2&"-"&strmsbaslik

response.Write(yanliste(istrid,kayar2,strmsbaslik,12,"kate1"))

else

if kayar2=0 then

csstip=""

else

csstip=i1ayar3

end if

mdoksanid=mmmsayfa2("id")

mdoksanurunid=mmmsayfa2("urunid")

mdoksanyazib=mmmsayfa2("yazib")

mdoksanyazi=veriguncelle(mmmsayfa2("yazi"))

mdoksanform=mmmsayfa2("form")

menuisimyazi1=mmmsayfa2("temp")

baslikisim=dilyazib(mdoksanid,mdoksanyazib,lang)

yaziisim=dilyazi(mdoksanid,mdoksanyazi,lang)

str_bilgi3=mmmsayfa2("bilgi3")

close(mmmsayfa2)



if str_bilgi3="" or isNull(str_bilgi3) then

else

'str_fi="<br />"

str_fi=str_fi&"<div class=""liste_cerceve_fi"">"

str_fi=str_fi&"<div class=""liste_cerceve_fyat"">"&str_bilgi3&"</div>"

str_fi=str_fi&"</div>"

end if

str_bilgi3=str_fi

		set mmmYardimci3 = Con.Execute ("select * from kategoriyazi where id = "&istrid&" order by id")

if mmmYardimci3.eof then

else

kateisim=dilkate(mmmYardimci3("id"),mmmYardimci3("isim"),lang)

end if

close(mmmYardimci3)

modulturs=mdoksanurunid





jsisveri1=listeleme1style(l6,csstip)

stylisveri1=listeleme1style(i8,csstip)

%>

<style>

<%=stylisveri1%>

</style>

<%session("jsisveri1")=jsisveri1%>



<%

    if modulturs=1 or modulturs=12 or (urunid<>"" and seotur="yazi") then

    if seotur="sayfa" then

      if request.cookies("remember_dil")="240" then

sqlstring="select * from kategoriyazi,yazilar where yazilar.kategori = kategoriyazi.id and  kategoriyazi.id = '"&istrid&"' and yazilar.modulmu='"&istrmodulmu&"' and yazilar.durum='1' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

      else

sqlstring="select * from kategoriyazi,yazilar where yazilar.kategori = kategoriyazi.bagli and  kategoriyazi.id = '"&sseoid&"' and yazilar.modulmu='"&istrmodulmu&"' and yazilar.durum='1' order by ilksayfa desc, yazilar.sira, yazilar.id desc"

      end if

    else

      if request.cookies("remember_dil")="240" then

    sqlstring="select * from yazilar where id = "&sseoid&" and yazilar.durum='1' order by id"

    else

    sqlstring="select * from yazilar where id=(select bagli from yazilar where id="&sseoid&") and yazilar.durum='1' order by id"

    end if

    end if

    'response.Write "<br>"&sqlstring

      set mmmYardimci2 = Con.Execute (sqlstring)

if mmmYardimci2.eof then 

else

    

Do While Not mmmYardimci2.EOF

if kayar2=0 then

csstip=""

else

csstip=i1ayar3

end if

mdoksanid=mmmYardimci2("id")

mdoksanurunid=mmmYardimci2("urunid")

mdoksanyazib=mmmYardimci2("yazib")

mdoksanyazi=veriguncelle(mmmYardimci2("yazi"))

mdoksanform=mmmYardimci2("form")

menuisimyazi1=mmmYardimci2("temp")

strgtarih=mmmYardimci2("gtarih")

strtarih=mmmYardimci2("tarih")

'aidyaziisim=?

strozet=mmmYardimci2("descri")

    

set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where id="&istrid&"")

if mmmYardimci1.eof then

else

aidyazi=mmmYardimci1("anasek")

aidyaziisim=mmmYardimci1("isim")

end if

close(mmmYardimci1)

    

    if mmmYardimci2("admin")="" or isNull(mmmYardimci2("admin")) then

        stradmin="0"

        else

        stradmin=mmmYardimci2("admin")

        end if

set mmmYardimci1 = Con.Execute ("select id,adsoyad from yonetici where id="&stradmin&"")

if mmmYardimci1.eof then

else

adminid=mmmYardimci1("id")

adminisim=mmmYardimci1("adsoyad")

end if

close(mmmYardimci1)

if menuisimyazi1="" or isNull(menuisimyazi1) or menuisimyazi1="99999" then

if kayar2=0 then

menuisimyazi1="#yaziisim#"

else

Call kategoriayar(i1ayar3,kayar2,kayar3)

menuisimyazi1=i1

end if

else

menuisimyazi1=menuisimyazi1

end if

'baslikisim=dilyazib(mdoksanid,mdoksanyazib,lang)

baslikisim=dilicerikcek(mdoksanid,mdoksanyazib,lang,"yazib","1")

   ' response.Write mdoksanyazi&"<br><br>"

yaziisim=dilicerikcek(mdoksanid,mdoksanyazi,lang,"yazi","1")

strozet=dilicerikcek(mdoksanid,strozet,lang,"descri","1")

'yaziisim=dilyazi(mdoksanid,mdoksanyazi,lang)

    'response.Write "<br>"&mdoksanid

str_bilgi3=mmmYardimci2("bilgi3")



		 set mmmYardimci3 = Con.Execute ("select * from resimd where baslik='"&mdoksanid&"' and type = '1' order by tur desc")

if mmmYardimci3.eof then

	else

   resimim=mmmYardimci3("dosyad")

  buyukresim=buyukresim&"<div class=""single"&csstip&" buyukurun"&csstip&" lightbox text-center"" href="""&imgyol&""&resimim&""" data-plugin-options=""{'type':'image'}"">"

   link=""""&imggaleriyol&""&resimim&""""

   resimimbuyuk=""&imgyol&""&resimim&""

    buyukresim=buyukresim&"<a rel="""&rid&""" href="""&imgyol&""&resimim&""" data-toggle=""lightbox"" data-gallery=""multiimages"" data-title="""&mmmYardimci3("resad")&""" data-footer="""&resimacik&"""><img src="""&imgyol&""&resimim&""" width=""100%"" border=""0"" alt="""&baslikisim&" "&resimacik&" image"" /></a>"

  buyukresim=buyukresim&"</div>"

  end if

  close(mmmYardimci3)

  sqlString = "select * from ozellikler2 where kateid='"&mdoksanid&"' and ozelikid = '1'"

set mmmYardimci1 = Con.Execute (sqlString)

if mmmYardimci1.eof then

formid="1"

else

formid=mmmYardimci1("formid")

formidtur=mmmYardimci1("tur")

end if

close(mmmYardimci1)

  if modulturs=1 or (urunid<>"" and seotur="yazi") then

	  if twitterkadi="-" or twitterkadi="" then

	  strvia="&via="&twitterkadi&""

	  else

	  strvia=""

	  end if

      sosyal=sosyalpaylas1(sitelink,sayfaurun,facebooktag)

	  faceboky=facebokyorum(sitelink,sayfaurun,facebooktag)

   ' response.Write yaziisim&"-"&menuisimyazi1

    if menuisimyazi1="" or isNull(menuisimyazi1) or menuisimyazi1="99999" then

    menuisimyazi1="#yaziisim#"

    end if

Veri2=menuisimyazi1

Veri2=Veri2&""

Veri2 = Replace(Veri2, "`","'")

Veri2 = Replace(Veri2, "#resimimbuyuk#",""&resimimbuyuk&"")

Veri2 = Replace(Veri2, "#baslikisim#",""&baslikisim&"")

Veri2 = Replace(Veri2, "#yaziisim#",""&yaziisim&"")

Veri2 = Replace(Veri2, "#yaziid#",""&mdoksanid&"")

if Instr(Veri2,"#slaytresim#") then

Veri2 = Replace(Veri2, "#slaytresim#",yanliste(mdoksanid,i2,"",kayar2,"resim"))

else

end if

if Instr(Veri2,"#buyukresim#") then

Veri2 = Replace(Veri2, "#buyukresim#",buyukresim)

else

end if

if Instr(Veri2,"#buyukresimsngl#") then

Veri2 = Replace(Veri2, "#buyukresimsngl#",buyukresimsngl)

else

end if

if Instr(Veri2,"#kucukresim#") then

            kucukresim=kucukresim&""&yanliste(mdoksanid,kayar2,strmsbaslik,"ana","resim")

Veri2 = Replace(Veri2, "#kucukresim#",kucukresim)

else

end if

if Instr(Veri2,"#strbilgi3#") then

Veri2 = Replace(Veri2, "#strbilgi3#",str_bilgi3)

else

end if

if Instr(Veri2,"#sosyal#") then

Veri2 = Replace(Veri2, "#sosyal#",sosyal)

else

end if

if Instr(Veri2,"#facebokyorum#") then

Veri2 = Replace(Veri2, "#facebokyorum#",faceboky)

else

end if

    

Veri2 = Replace(Veri2, ""&rsablonstr&"#strozet#"&rsablonstr&"", strozet&" ")

Veri2 = Replace(Veri2, ""&rsablonstr&"#strkategori#"&rsablonstr&"", aidyaziisim)

Veri2 = Replace(Veri2, ""&rsablonstr&"#stradmin#"&rsablonstr&"", adminisim)

Veri2 = Replace(Veri2, ""&rsablonstr&"#strtarih#"&rsablonstr&"", strtarih)

Veri2 = Replace(Veri2, ""&rsablonstr&"#strtarihday#"&rsablonstr&"", day(strtarih))

Veri2 = Replace(Veri2, ""&rsablonstr&"#strtarihmonth#"&rsablonstr&"", month(strtarih))

Veri2 = Replace(Veri2, ""&rsablonstr&"#strtarihmonthname#"&rsablonstr&"", MonthName(month(strtarih),True))

Veri2 = Replace(Veri2, ""&rsablonstr&"#strtarihyear#"&rsablonstr&"", year(strtarih))

Veri2 = Replace(Veri2, ""&rsablonstr&"#strgtarih#"&rsablonstr&"", strgtarih)

Veri2 = Replace(Veri2, ""&rsablonstr&"#str_bilgi3#"&rsablonstr&"", str_fi)

Veri2 = Replace(Veri2, ""&rsablonstr&"#yazilink#"&rsablonstr&"", siteadres&seolinkim)

    

    if cdnstatu="1" then

    if instr(Veri2,"""/contents/img/") then

Veri2 = Replace(Veri2, """/contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")

Veri2 = Replace(Veri2, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")

    else

Veri2 = Replace(Veri2, "=/contents/img/","="&cdnimgfldr&""&cdnsitefolder&"/contents/img/")

Veri2 = Replace(Veri2, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")

    end if

    end if



if Instr(Veri2,"#ozellikcek(") then

ocadet=ubound(split(Veri2,"#ozellikcek("))

for oca=1 to ocadet

strocv=split(split(Veri2,"#ozellikcek(")(1),")#")(0)



ocvadet=ubound(split(strocv,","))

if ocvadet<3 then

else

gorozel=split(strocv,",")(1)

csstip=split(strocv,",")(3)

Veri2 = Replace(Veri2, "#ozellikcek(#formid#,"&gorozel&",#formidtur#,"&csstip&")#",ozellikcek(formid,gorozel,formidtur,csstip))

end if

next

else

end if



if Instr(Veri2,"#hesapla(") then

ocadet=ubound(split(Veri2,"#hesapla("))

for oca=1 to ocadet

strocv=split(split(Veri2,"#hesapla(")(1),")#")(0)

ocvadet=ubound(split(strocv,","))

if ocvadet<2 then

else

value1=split(strocv,",")(0)

islemi=split(strocv,",")(1)

value2=split(strocv,",")(2)

if isNumeric(value1)=false or isNumeric(value2)=false then

valuem="0"

else

if islemi="%" then

valuem=((cint(value1)-cint(value2))/cint(value1))*100

else

end if

end if

Veri2 = Replace(Veri2, "#hesapla("&value1&","&islemi&","&value2&")#",valuem)

end if

next

else

end if

		response.Write(veriguncelle(replace(Veri2,"`","'")))

    else

		response.Write(replace(yaziisim,"`","'"))

    end if

	mmmYardimci2.MoveNext

loop

    end if

close(mmmYardimci2)



    else if  modulturs=5 then

						Call video()

						elseif modulturs=84444 then%>

                        <h3><%=kateisim%></h3>

<div style="clear:left;"></div>

<%  Call listelemeform(id,kayar2,csstip,istrid)

						elseif modulturs=4 or modulturs=8 or modulturs=9 or modulturs=3 then

    'response.Write mdoksanid&"-"&kayar2&"-"&strmsbaslik&"-"&&"-"&

    if modulturs=3 then

    ayar3="resim"

    istrid=mdoksanid

    else

    ayar3="yazi1"

    istrid=istrid

    end if

						%>

<%  'Call listeleme(listeayar1,listeayar2,csstip,istrid)

    response.Write(yanliste(istrid,kayar2,strmsbaslik,12,ayar3))

  elseif modulturs=7 then%>

  

<h3><%=baslikisim%></h3>

<p><%=yaziisim%></p>

<%Call iletisimform(mdoksanform)

elseif modulturs=10 then

%>

<h3><%=baslikisim%></h3>

<p><%=yaziisim%></p>

<div style="clear:both;"></div>

<%

  Call ekatalog(mdoksanid,strmstemp)

						elseif modulturs=11 then

%>

<h3><%=baslikisim%></h3>

<p><%=yaziisim%></p>

<div style="clear:both;"></div>

<%

Call harita(mdoksanid,id,1)

						else

						end if

						end if

						%>

		

                        <%

						end if

						

						end if							

  else

                         

  %>

                        <!--#Include file="ek_modul.asp"-->

<%



  end if

  


  %>

<% End Sub%>