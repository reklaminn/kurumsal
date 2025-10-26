<!--#Include file="admin_menu1.asp"-->

<%
	if request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
%>
<div class="right_col" role="main">
<div class="x_panel">
  <%if dkate2="" or request("sek")="" then
   altsayfaekle="?rinn=web"
else
if request("sek")="0" then
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek=1"
else
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek="&request("sek")&""
end if
end if
modulmuagac=" and modulmu = '0'"%>
  <div class="col-md-3">
    <div class="col-md-4">
      <%if dkate2="" or request("sek")="" then
else%>
      <div class="dropdown" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçerik Ekle">
        <button class="btn btn-danger dropdown-toggle" style="padding:1px 6px;" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false"><em class="fa fa-file-text" style="font-size:11px; color:#FFF;"></em> <span class="caret"></span></button>
        <ul class="dropdown-menu animated fadeInDown">
          <%
		if request("dkate2")="979" or request("dkate2")="1010" or request("dkate2")="1013" then
		else
		%>
          <%
sqlString = "SELECT * from yazilar where kategori='"&dkate2&"'"&modulmuagac&" order by id"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
sqlString = "SELECT * from kategori order by id"
else
srvytuid=mmmGenel("urunid")
srvytid=mmmGenel("id")
sqlString = "SELECT * from kategori where id="&srvytuid&" and ikincii = '1' order by id"
end if
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
stryadres=mmmYardimci("adres")
if mmmGenel.eof then
if instr(stryadres,"a_icerik_ekle") then
acilim=" data-toggle=""modal"" data-target=""#baslikmodal"""
else
acilim=""
end if
acilimadres=stryadres
else
acilim=""
acilimadres="uruny_ekle.asp?modulv=0&yazi=yeni"
sqlString = "select * from ozellikler2 where kateid='"&srvytid&"'"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
formid="1"
formicev=""
else
formid=mmmYardimci3("formid")
formicev="&formice="&formid&""
end if
close(mmmYardimci3)
end if
%>
              <li><a href="<%=acilimadres%>&modul=0&dkate2=<%=dkate2%>&dkate=<%=dkate2%>&coklu=<%=mmmYardimci("ikincii")%>&iceriktur=<%=mmmYardimci("id")%><%=formicev%>"<%=acilim%>><%=mmmYardimci("kate")%></a></li>
              <%mmmYardimci.MoveNext
  loop
%>
            </ul>
          </li>
          <%
  end if
  close(mmmGenel)
  close(mmmYardimci)
  end if
  %>
        </ul>
      </div>
      <%end if%>
    </div>
    <div class="col-md-4">
  
         <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sayfaya Alt Sayfa Eklemek İçin Tıklayınız." style="display:table;">
      <a href="baslik.asp<%=altsayfaekle%>" class="btn btn-success dropdown-toggle btn-xs" data-toggle="modal" data-target="#baslikmodal"><em class="fa fa-clipboard" style="font-size:11px;"></em></a>
      </div>
   
    </div>
    <div class="col-md-4">
      <%if dkate2="" or dkate2="0" then
else
%>
      <a href="ortak_sayfalar_ayar.asp?dkate2=<%=dkate2%>&urunid=&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs" data-fancybox-type="iframe" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bu Sayfanın veya Alt Sayfaların Yerleşim Ayarları İçin."><em class="fa fa-th-large" style="font-size:11px;"></em></a>
      <%
end if%>
    </div>
  </div>
  <div class="col-md-9">
    <select name="dkate2" class="form-control" onchange="MM_jumpMenu('parent',this,0)" id="dkate" style="width:100%;">
      <option value="?"> TÜM SAYFALAR </option>
      <%
sqlString = "select * from kategoriyazi where alt = '1' and modulmu='0'"&sayfagosterme&"  ORDER BY modulmu, sira"
set mmmYardimci = Con.Execute (sqlString)

Do While Not mmmYardimci.EOF
if mmmYardimci("id")=int(dkate2) then
sayfanerde=" Sayfasındasınız."
else
sayfanerde=""
    end if
%>
      <option value="?id=<%=mmmYardimci("id")%>&baslik=<%=mmmYardimci("id")%>&sek=<%=mmmYardimci("anasek")%>&dkate2=<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(dkate2) then%>selected<%else%><%end if%> style="background:#FfCc00; font-weight:bold;"><%=mmmYardimci("isim")%><%=sayfanerde%></option>
      <%
sqlString = "select * from kategoriyazi where anasek='"&mmmYardimci("id")&"' ORDER BY sira"
set mmmYardimci1 = Con.Execute (sqlString)
%>
      <%
Do While Not mmmYardimci1.EOF
if mmmYardimci1("id")=int(dkate2) then
sayfanerde=" Sayfasındasınız."
else
sayfanerde=""
    end if
%>
      <option value="?id=<%=mmmYardimci1("id")%>&baslik=<%=mmmYardimci1("id")%>&sek=<%=mmmYardimci1("anasek")%>&dkate2=<%=mmmYardimci1("id")%>" <%if mmmYardimci1("id")=int(dkate2) then%>selected<%else%><%end if%>>&nbsp;&nbsp;&nbsp;<%=mmmYardimci1("isim")%><%=sayfanerde%></option>
      <%
sqlString = "select * from kategoriyazi where anasek='"&mmmYardimci1("id")&"' ORDER BY sira"
set mmmYardimci2 = Con.Execute (sqlString)
%>
      <%
		if mmmYardimci1("id")=int(dkate2) then
sayfanerde=" Sayfasındasınız."
else
sayfanerde=""
    end if
Do While Not mmmYardimci2.EOF
if mmmYardimci2("id")=int(dkate2) then
sayfanerde=" Sayfasındasınız."
else
sayfanerde=""
    end if
%>
      <option value="?id=<%=mmmYardimci2("id")%>&baslik=<%=mmmYardimci2("id")%>&sek=<%=mmmYardimci2("anasek")%>&dkate2=<%=mmmYardimci2("id")%>" <%if mmmYardimci2("id")=int(dkate2) then%>selected<%else%><%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mmmYardimci2("isim")%><%=sayfanerde%></option>
      <%
mmmYardimci2.MoveNext
loop
close(mmmYardimci2)

mmmYardimci1.MoveNext
loop
close(mmmYardimci1)

mmmYardimci.MoveNext
loop
close(mmmYardimci)
%>
    </select>
  </div>
</div>
<form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>" target="_self">
  <div class="x_panel">
    <%
if dkate2="" or dkate2=0 then
sqlString = "select * from kategoriyazi where alt = '1'"&modulmuagac&""&sayfagosterme&" order by sira"
else
  sqlString = "select * from kategoriyazi where anasek='"&dkate2&"'"&modulmuagac&""&sayfagosterme&"  order by sira"
  end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else%>
    <div>
      <div class="col-md-12 x_title">
        <div class="col-md-6">
        <div class="col-md-1"></div>
          <div class="col-md-3">
            <h2>Sayfalama</h2>
          </div>
          <div class="col-md-8">
            <h2>Sayfa Ad&#305;</h2>
          </div>
        </div>
        <div class="col-md-3"></div>
        <div class="col-md-3">
          <div class="col-md-2"></div>
          <div class="col-md-2"></div>
          <div class="col-md-2"></div>
          <div class="col-md-2"></div>
          <div class="col-md-2"></div>
          <div class="col-md-2"></div>
        </div>
      </div>
    </div>
    <div style="clear:both;"></div>
    <div class="sortpage">
    <ol class="ui-sortable1 vertical">  <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strsifreli=mmmGenel("sifreli")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
if sid="" or isNull(sid) or sid="835" then
sida=strid
else
sida=sid
end if
%>
      <li class="ui-state-default">
        <%
sqlString = "select * from resimd where baslik='"&strid&"'  order by fid desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
resim=""
else
resim="<img src="""&dbuploadgaleri&""&mmmYardimci("resimid")&""" width=""190"" border=""0""><br />"
end if
close(mmmYardimci)
	  lojik4=con.execute("select count(id) as toplam4 from yazilar where kategori='"&strid&"' ")
toplam4=lojik4("toplam4")
  lojik5=con.execute("select count(id) as toplam4 from kategoriyazi where anasek='"&strid&"' ")
toplam5=lojik5("toplam4")
 lojik6=con.execute("select count(fid) as toplam4 from resimd where baslik='"&strid&"' ")
toplam6=lojik6("toplam4")

%>
        <input name="urunid" type="hidden" value="<%=strid%>">
        <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
        <%collor="1"%>
        <%else%>
        <%collor="2"%>
        <%end if%>
        <div class="icerik<%=collor%> icerik">
          <div>
            <div class="col-md-6">
              <div class="col-md-1"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
                      </span></div>
              <div class="col-md-3">
                <select name="sayfalama" class="form-control" id="sayfalama">
                  <option value="1"> Ana Sayfa </option>
                  <%
sqlString = "SELECT * from kategoriyazi where alt = '1' and modulmu='0'"&sayfagosterme&" order by modulmu, sira"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                  <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("isim")%></option>
                  <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
if mmmYardimci1("id")=int(mmmGenel("anasek")) then
sonkate=1

else
end if
%>
                  <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=mmmYardimci1("isim")%></option>
                  <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci1("id")&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF

%>
                  <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=mmmYardimci2("isim")%></option>
                  <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci2("id")&"' order by sira"
set mmmSayfa = Con.Execute (sqlString)
Do While Not mmmSayfa.EOF

%>
                  <option value="<%=mmmSayfa("id")%>" <% if mmmSayfa("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=mmmSayfa("isim")%></option>
                  <%mmmSayfa.MoveNext
loop
 close(mmmSayfa)
 mmmYardimci2.MoveNext
loop
close(mmmYardimci2)
  mmmYardimci1.MoveNext
loop
  close(mmmYardimci1)
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                </select>
              </div>
              <div class="col-md-8">
                <input name="sayfaadi" type="text" class="form-control" id="sayfaadi" value="<%=strisim%>" style="width:100%;">
              </div>
            </div>
            <div class="col-md-3">
              <div class="col-md-2">
                <div class="btn-group">
                  <ul class="nav-pills" role="tablist">
                    <%
sqlString = "SELECT * from yazilar where kategori='"&strid&"'"&modulmuagac&"  order by id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
sqlString = "SELECT * from kategori order by id"
else
srvyuid=mmmYardimci("urunid")
srvyid=mmmYardimci("id")
sqlString = "SELECT * from kategori where id="&srvyuid&" and ikincii = '1' order by id"
end if
set mmmYardimci1 = Con1.Execute (sqlString)
if mmmYardimci1.eof then
else%>
                    <li role="presentation" class="btn btn-danger dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçerik Ekle"><a id="drop4" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"><em class="fa fa-file-text" style="font-size:11px; color:#FFF;"></em> <span class="caret" style="color:#FFF;"></span></a>
                      <ul id="menu6" class="dropdown-menu animated fadeInDown" role="menu">
                        <%Do While Not mmmYardimci1.EOF
strviadres=mmmYardimci1("adres")
strviikincii=mmmYardimci1("ikincii")
strviid=mmmYardimci1("id")
strvikate=mmmYardimci1("kate")
if mmmYardimci.eof then
if instr(strviadres,"a_icerik_ekle") then
acilim=" data-toggle=""modal"" data-target=""#baslikmodal"""
else
acilim=""
end if
acilimadres=strviadres
else
acilim=""
acilimadres="uruny_ekle.asp?modulv=0&yazi=yeni"
sqlString = "select * from ozellikler2 where kateid='"&srvyid&"'"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
formid="1"
formicev=""
else
formid=mmmYardimci3("formid")
formicev="&formice="&formid&""
end if
close(mmmYardimci3)
end if
%>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="<%=acilimadres%>&modul=0&dkate2=<%=strid%>&dkate=<%=strid%>&coklu=<%=strviikincii%>&iceriktur=<%=strviid%><%=formicev%>"<%=acilim%>><%=strvikate%></a></li>
                        <%mmmYardimci1.MoveNext
  loop
%>
                      </ul>
                    </li>
                    <%
  end if
  close(mmmYardimci)
  close(mmmYardimci1)
  %>
                  </ul>
                </div>
              </div>
              <div class="col-md-2">
                <%if sonkate=1 then%>
                <%else%>
                <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sayfaya Alt Sayfa Eklemek İçin Tıklayınız." style="display:table;">
      <a href="baslik.asp?id=<%=strid%>&baslik=<%=strid%>&sek=<%=mmmGenel("anasek")%>" class="btn btn-success dropdown-toggle btn-xs" data-toggle="modal" data-target="#baslikmodal"><em class="fa fa-clipboard" style="font-size:11px;"></em></a></div>
                <%end if%>
              </div>
              <div class="col-md-2">
                <%if toplam5="0" then%>
                <%else%>
                <a href="?dkate2=<%=strid%>&sek=<%=dkate2%>" class="btn btn-info dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sayfaya ait Alt Sayfaları Görmek İçerik Eklemek Düzenlemek veya Silmek İçin Tıklayınız."><em class="fa fa-list-alt" style="font-size:11px;"></em> (<%=toplam5%>)</em></a>
                <%end if%>
              </div>
              <div class="col-md-2">
                <%if toplam4="0" then%>
                <%else%>
                <a href="?<%=linked%>dkate2=<%=strid%>&sek=<%=dkate2*1%>" class="btn btn-warning dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sayfanın İçeriğini Görmek Düzenlemek ve Resim Eklemek İçin Tıklayınız."><em class="fa fa-files-o" style="font-size:11px;"></em></a>
                <%end if%>
              </div>
              <div class="col-md-2">
                <%if mayarlar=1 then%>
                <a href="ortak_sayfalar_ayar.asp?dkate2=<%=strid%>&urunid=<%=strurunid%>&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bu Sayfanın veya Alt Sayfaların Yerleşim Ayarları."><em class="fa fa-th-large" style="font-size:11px;"></em></a>
                <%else%>
                <%end if%>
              </div>
              <div class="col-md-2">
                <div align="center"> <a href="galeri.asp?baslik=<%=strid%>&amp;dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" class="btn btn-default dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Resim Ekle"><em class="fa fa-camera" style="font-size:16px;"></em> (<%=toplam6%>) </a> </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="col-md-2"></div>
              <div class="col-md-2">
              <%if strsifreli = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("sifreli","Şifreli Sayfa Durumu",iks,cbcdisstr,cbccheckstr,"danger"))%>
                
              </div>
              <div class="col-md-2">
              <%if strdurum = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Durum",iks,cbcdisstr,cbccheckstr,"info"))%>
               
              </div>
              <div class="col-md-2">
              <%if strmenugosterim = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("menugosterim","Üst Menü Gösterimi",iks,cbcdisstr,cbccheckstr,"success"))%>
                
              </div>
              <div class="col-md-2">
                <%if strhabertemp="1" then%>
                <a href="<%=altsayfaekle%>&sky=0&islem=skyduzenle&dkate2=<% =dkate2%>&islemtur=sky&skyid=<%=strid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sık Kullanılanlardan Kaldır"><em class="fa fa-star" style="color:#FC0; font-size:16px;"></em></a>
                <%else%>
                <a href="<%=altsayfaekle%>&sky=1&islem=skyduzenle&dkate2=<% =dkate2%>&islemtur=sky&skyid=<%=strid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sık Kullanılanlar Butonu Yap"><em class="fa fa-star" style="color:#999; font-size:16px;"></em></a>
                <%end if%>
              </div>
              <div class="col-md-2">
                <%
		   if instr(silinmiyecekler,"s"&sida) then
		   
	  else%>
                <div class="form-group">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="urunidsil" class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>">
                    </label>
                  </div>
                </div>
                <%end if%>
              </div>
            </div>
          </div>
        </div>
      </li>
      <%mmmGenel.MoveNext
  loop
  %>
  </ol>
    </div>
    <div style="clear:both;"></div>
    <div class="icerik1 icerik">
      <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil');">
      <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit();formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenle');">
    </div>
    <SCRIPT LANGUAGE="JavaScript">

	function formla16(gelen16)
	{
	document.custlist16.action=gelen16;
	document.custlist16.submit();
	}
  //-->
  </SCRIPT>
    <div style="clear:both;"></div>
    <%
end if
close(mmmGenel)
%>
  </div>
</form>
<%
  if request("usayi")="" then
	KayitSayisi=30
	else
	KayitSayisi=request("usayi")
	end if
	
  git = Request.QueryString("git")
if git="" then
git=1
end if
if dkate2="" or dkate2=0 then
sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&" order by sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
else
  sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&"  order by sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
  end if
  set mmmYardimci2=con.execute("select count(id) as toplam5 from yazilar where kategori='"&dkate2&"'"&modulmuagac&"")
toplam5=mmmYardimci2("toplam5")
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
<%else
 linkbaslangic="?alt1="&request("alt1")&"&dkate2="&request("dkate2")&"&sek="&request("sek")&""%>
<form method="post" name="custlist2" id=Form2 action="<%=altsayfaekle%>" target="_self">
<div class="x_panel">
  <div>
    <div class="col-md-12 x_title">
      <div class="col-md-6">
        <div class="col-md-3">
          <h2>Sayfalama</h2>
        </div>
        <div class="col-md-3">
          <h2>İçerik Türü</h2>
        </div>
        <div class="col-md-3">
          <h2>İçerik Adı</h2>
        </div>
      </div>
      <div class="col-md-3"></div>
      <div class="col-md-3">
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
      </div>
    </div>
  </div>
  <div style="clear:both;"></div>
<div class="sortpage">
    <ol class="ui-sortable1 vertical">
    <%
Do While Not mmmGenel.EOF
iksss=iksss+1
stryid=mmmGenel("id")
stryilksayfa = mmmGenel("ilksayfa")
strydurum = mmmGenel("durum")
strykategori=mmmGenel("kategori")
strysifreli  =mmmGenel("sifreli")
%>
    <li class="ui-state-default">
      <%
urunidd=mmmGenel("urunid")
sqlString = "select * from resimd where baslik='"&stryid&"'  order by fid desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
resim=""
else
resim="<img src="""&dbuploadgaleri&""&mmmYardimci("resimid")&""" width=""190"" border=""0""><br />"
end if
close(mmmYardimci)
lojik4=con.execute("select count(fid) as toplam4 from resimd where baslik='"&stryid&"' ")
toplam4=lojik4("toplam4")
%>
      <input name="urunid" type="hidden" value="<%=stryid%>">
      <%if right(iksss,1)=1 or right(iksss,1)=3 or right(iksss,1)=5 or right(iksss,1)=7 or right(iksss,1)=9 then%>
      <%collor="1"%>
      <%else%>
      <%collor="2"%>
      <%end if%>
      <div class="icerik<%=collor%> icerik">
        <div class="col-md-7">
          <div class="col-md-3">
            <div class="col-md-2"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
                      </span></div>
            <div class="col-md-9">
              <select name="sayfalama"  class="form-control" id="sayfalama" style="width:100%;">
                <option value="1"> Ana Sayfa </option>
                <%
sqlString = "SELECT * from kategoriyazi where alt = '1' order by sira"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(strykategori) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("isim")%></option>
                <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
%>
                <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(strykategori) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=mmmYardimci1("isim")%></option>
                <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci1("id")&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
%>
                <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(strykategori) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=mmmYardimci2("isim")%></option>
                <%
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci2("id")&"' order by sira"
set mmmSayfa = Con.Execute (sqlString)
Do While Not mmmSayfa.EOF
%>
                <option value="<%=mmmSayfa("id")%>" <% if mmmSayfa("id")=int(strykategori) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mmmSayfa("isim")%></option>
                <%mmmSayfa.MoveNext
loop
 close(mmmSayfa) %>
                <%mmmYardimci2.MoveNext
loop
  close(mmmYardimci2)%>
                <%mmmYardimci1.MoveNext
loop
  close(mmmYardimci1)%>
                <%mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <select name="iceriktur" class="form-control" id="iceriktur">
              <option value="0" >T&uuml;r Se&ccedil;in</option>
              <%
sqlString = "SELECT * from kategori order by id"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
              <option value="<%=mmmYardimci("id")%>" <% if int(mmmYardimci("id"))=int(urunidd) then%>selected<%else%><%end if%>><%=mmmYardimci("kate")%></option>
              <%mmmYardimci.MoveNext
loop
close(mmmYardimci)%>
            </select>
          </div>
          <div class="col-md-6">
            <input name="icerikadi" type="text" class="form-control" id="icerikadi" value="<%=mmmGenel("yazib")%>" style="width:80%;">
            <%if instr(request("id"),stryid) and request("islem")="duzenleyazi" then%>
            <font color="#CC0000">Bilgiler Düzenlendi</font>
            <%else%>
            <%end if%>
          </div>
        </div>
        <div class="col-md-3">
          <div class="col-md-2">
            <%
sqlString = "SELECT * from kategori where id="&urunidd&" order by id"
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
%>
            <a href="<%=mmmYardimci("adresd")%>duzelt1=<%=mmmYardimci("id")%>&urunid=<%=stryid%>&baslik=<%=stryid%>&sek=<%=strykategori%>&dkate2=<%=strykategori%>" class="btn btn-warning dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<%=mmmYardimci("kate")%> İçeriği"><em class="fa fa-files-o" style="font-size:11px;"></em></a>
            <%
end if
close(mmmYardimci)%>
          </div>
          <div class="col-md-3"><a href="galeri.asp?baslik=<%=stryid%>&dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" class="btn btn-default dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Resim Ekle"><em class="fa fa-camera" style="font-size:16px;"></em> (<%=toplam4%>) </a> </div>
          <div class="col-md-7"><%=mmmGenel("gtarih")%></div>
        </div>
        <div class="col-md-2">
          <div class="col-md-3"> 
          <%if strysifreli = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("sifreli","Şifreli Sayfa Durumu",iksss,cbcdisstr,cbccheckstr,"danger"))%>
                         </div>
          <div class="col-md-3"> 
           <%if strydurum = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onayi","Durum",iksss,cbcdisstr,cbccheckstr,"info"))%>
                        </div>
          <div class="col-md-3"> 
          <%if stryilksayfa = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("ilksayfa","İlk Sayfa",iksss,cbcdisstr,cbccheckstr,"success"))%>
                         </div>
          <div class="col-md-3">
            <%if instr(silinmiyecekler,"s"&stryid) then
	  else%>
            <div class="form-group" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil İçin Seçiniz" style="display:table;">
              <div class="checkbox">
                <input type="checkbox" name="iceriksil" class="flatred" id="iceriksila<%=iksss%>" value="<%=stryid%>">
              </div>
            </div>
            <%end if%>
          </div>
        </div>
      </div>
  </li>
  <%mmmGenel.MoveNext
  loop
  %>
  </ol>
</div>
<div style="clear:both;"></div>
<div class="icerik1 icerik">
  <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik');">
  <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenleicerikt');">
</div>
</div>
</form>
<SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist2.action=gelen;
	document.custlist2.submit();
	}
  //-->
  </SCRIPT>
<div style="clear:both;"></div>
<%
end if
close(mmmGenel)
%>
</div>
<%call footer(1)%>
        <script>
	var oldContainer;
$("ol.ui-sortable1").sortable({
  group: 'nested', 
  handle: 'i.fa-arrows',  
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {
    container.el.removeClass("active");
    _super($item, container);
  }
});

</script>