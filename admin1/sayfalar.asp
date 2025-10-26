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
  <%if dkate2="" then
   altsayfaekle="?rinn=web"
else
if dkate2="0" or request("sek")="0" then
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek=1"
else
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek="&request("sek")&""
end if
end if
modulmuagac=" and modulmu = '0'"%>
  <div class="input-group">
  <div class="input-group-addon">
    <%if dkate2="" or dkate2="0" or dkate2="1" then
else%>
<div class="input-group-btn">      
      <div class="dropdown">
        <button class="btn btn-danger dropdown-toggle" style="padding:1px 6px;" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false"><em class="fa fa-plus" style="font-size:11px; color:#FFF;"></em></button>
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
acilimadres="admin_uruny_duzenle.asp?modulv=0&yazi=yeni"
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
          <%
  end if
  close(mmmGenel)
  close(mmmYardimci)
  end if
  %>
      </div>      
    </div>
	<%end if%>
    <div class="input-group-btn">
  
         <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Sayfa Ekle" style="display:table;">
      <a href="baslik.asp<%=altsayfaekle%>" class="btn btn-success dropdown-toggle btn-xs" data-toggle="modal" data-target="#baslikmodal"><em class="fa fa-clipboard" style="font-size:11px;"></em></a>
      </div>
   
    </div>
  <%

      
sqlString = "SELECT id, bagli, yazib, yazi, yazicode,dil FROM yazilar where modulmu='1' and dil=256 order by bagli"
set mmmYardimci = Con.Execute (sqlString)
      
Do While Not mmmYardimci.EOF
      strbagli=mmmYardimci("bagli")
      if strbagli="" or isNull(strbagli) then
      strbagli="0"
      end if
      sqlString = "update yazilar set  yazi='"&mmmYardimci("yazi")&"', yazicode='"&mmmYardimci("yazicode")&"'  where id="&strbagli&""
'Con.execute(sqlString)
      mmmYardimci.MoveNext
  loop
      close(mmmYardimci)

      if dkate2="" or dkate2="0" or dkate2="1" then
   else
   %>
  <div class="input-group-btn">

      <a href="ortak_sayfalar_ayar.asp?dkate2=<%=dkate2%>&urunid=&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs" data-fancybox-type="iframe" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Blok Düzenlemesi"><em class="fa fa-th-large" style="font-size:11px;"></em></a>

    </div>
      <%end if%>
  </div>
      <%if eser="1" then %>
<div class="btn-group">
  <button type="button" class="btn btn-default btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Action <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" style="overflow-y:scroll; height:500px;">
      <% response.Write kategoriyaziliste("1","<li><a href=""?id=#kylid#&baslik=#kylid#&sek=#kylanasek#&dkate2=#kylid#"">#kylico##kylisim#</a></li>#kylsub{(,,,,"&sayfagosterme&", &nbsp;&nbsp;,240)}#","",dkate2,sayfagosterme,"","240") %>  
  </ul>
</div>
      <%end if %>
    <select name="dkate2" class="selctize1" onchange1="MM_jumpMenu('parent',this,0)" id="dkate2" style="width:100%;">        
      <option value="?"> TÜM SAYFALAR </option>
   <% response.Write kategoriyaziliste("1","<option value=""?id=#kylid#&baslik=#kylid#&sek=#kylanasek#&dkate2=#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&", &nbsp;&nbsp;,240)}#","",dkate2,sayfagosterme,"","240") %>     
    </select>
  </div>
</div>

    <%
        kategorimodullistesi= kategoriyaziliste("1","<option value=""#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&", &nbsp;,240)}#","",dkate2,sayfagosterme&"","","240")
if dkate2="" or dkate2=0 then
sqlString = "select * from kategoriyazi where alt = '1'"&modulmuagac&""&sayfagosterme&" order by durum desc,sira, id desc"
else
  sqlString = "select * from kategoriyazi where anasek='"&dkate2&"'"&modulmuagac&""&sayfagosterme&"  order by durum desc,sira, id desc"
  end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else%>
    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>" target="_self">
  <div class="x_panel">
    <div>
            <div class="icerik1 icerik">
      <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil');">
      <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit();formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenle');">
    </div>           
    </div>
    <div style="clear:both;"></div>
    <div class="sortpage">
    <ol class="ui-sortable1 vertical">  <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
strid1=strid
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strsifreli=mmmGenel("sifreli")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
smidseolink=mmmGenel("seolink")
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
          
          <div class="col-md-12">
           
              <div class="col-md-11 col-xs-9"> 
                           
              <input name="sayfalama" type="hidden" value="<%=mmmGenel("anasek")%>" />
              
              <div class="col-md-12">
              <div class="input-group"> 
              <div class="input-group-btn">   
                 <div style="min-width:30px; font-size:initial;">
                     <span class="handle ui-sortable-handle">
                        <i class="fas fa-arrows-alt"  style=" <%if strdurum = "1" Then%><%else%> color: #bbb; <%end if%>"></i>
                     </span>
              </div>
              </div>               
                <div class="input-group-btn">
                  <ul class="nav-pills" role="tablist" style="padding:0px;">
                    <%
sqlString = "SELECT * from yazilar where kategori='"&strid&"'"&modulmuagac&"  order by id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
sqlString = "SELECT * from kategori where ana='1' order by id"
srvyid="0"
else
srvyuid=mmmYardimci("urunid")
srvyid=mmmYardimci("id")
sqlString = "SELECT * from kategori where id="&srvyuid&" and ikincii = '1' order by id"
end if
set mmmYardimci1 = Con1.Execute (sqlString)
if mmmYardimci1.eof then
iceriklink="admin_uruny_duzenle.asp?duzelt1=1&urunid="&srvyid&"&baslik="&srvyid&"&sek="&strid&"&dkate2="&strid&"&katebaslik="&server.urlencode(strisim) &""
else
iceriklink="?"&linked&"dkate2="&strid&"&sek="&dkate2*1&""
                        %>
                    <li role="presentation" class="btn-danger dropdown-toggle btn-xs" style="padding:8px 5px; <%if strdurum = "1" Then%><%else%> background-color: #bbb; <%end if%>"><a id="drop4" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"><em class="fa fa-plus" style="font-size:14px; color:#FFF;"></em></a>
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
formicev=""
else
acilim=""
acilimadres="admin_uruny_duzenle.asp?modulv=0&yazi=yeni"
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
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="<%=acilimadres%>&modul=0&dkate2=<%=strid%>&dkate=<%=strid%>&coklu=<%=strviikincii%>&iceriktur=<%=strviid%><%=formicev%>&titlee=<%=server.urlencode(strisim) %>"<%=acilim%>><%=strvikate%></a></li>
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
                <input name="sayfaadi" type="text" class="form-control" id="sayfaadi" value="<%=strisim%>" style=" <%if strdurum = "1" Then%><%else%> color: #bbb; <%end if%><%if instr(request("id"),stryid) and request("islem")="duzenleyazi" then%>border-color:#CC0000;<%else%><%end if%>">
                
                </div>
              </div>
            
            
            <div class="col-md-12 islevler">
              <div class="islevler1" style="padding-left:30px;">                

                <%if sonkate=1 or strid="835" then%>
                <%else
               sqlString = "SELECT id from kategoriyazi where id="&mmmGenel("anasek")&" and anasek in (SELECT id from kategoriyazi where anasek = '1')"
                    set mmmYardimci1 = Con.Execute (sqlString)
                    if mmmYardimci1.eof then
                    %>
      <a href="baslik.asp?id=<%=strid%>&baslik=<%=strid%>&sek=<%=mmmGenel("anasek")%>" class="btn btn-success dropdown-toggle btn-xs" data-toggle="modal" data-target="#baslikmodal"><em class="fa fa-clipboard" style="font-size:11px;"></em> Alt Sayfa Ekle</a>
                <%else
                    end if
                    close(mmmYardimci1)
                    end if%>

                <%if toplam5="0" then%>
                <%else%>
                <a href="?dkate2=<%=strid%>&sek=<%=dkate2%>" class="btn btn-info dropdown-toggle btn-xs"><em class="fa fa-list-alt" style="font-size:11px;"></em> Alt Sayfalar (<%=toplam5%>)</em></a>
                <%end if%>

                <%if toplam4="0" then%>
                <%else%>
                <a href="<%=iceriklink%>" class="btn btn-warning dropdown-toggle btn-xs"><em class="fa fas fa-clone" style="font-size:11px;"></em> İçerik Sayfaları</a>
                <%end if%>

                <%if mayarlar=1 then%>
                <a href="ortak_sayfalar_ayar.asp?dkate2=<%=strid%>&urunid=<%=strurunid%>&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs"><em class="fa fa-th-large" style="font-size:11px;"></em> Blok Düzenlemesi</a>
                <%else%>
                <%end if%>
                  <%if strid="835" then%>
                <%else%>
                <a href="galeri.asp?baslik=<%=strid%>&amp;dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" class="btn btn-default dropdown-toggle btn-xs"><em class="fa fa-camera" style="font-size:16px;"></em> Resim Ekle (<%=toplam6%>) </a>
                  <%end if %>
                  <%if yetkiuye="1" then %>
                  <a href="?islem=cachepage&aid=<%=strid %>&seolink=<%=siteadres %><%=seolarlink(strid1,"sayfa",lang) %>&seolinkim=<%=seolarlink(strid1,"sayfa",lang) %>&dkate2=<%=strid %>&sayfaayar=modul&sek=<%=strid %>" class="btn btn-danger dropdown-toggle btn-xs float-right pull-right"><em class="fa fa-reload" style="font-size:16px;"></em> Cache Güncelle </a>
                  <%end if %>

              <%if strsifreli = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("sifreli","Şifreli Sayfa Durumu",iks,cbcdisstr,cbccheckstr,"danger"))%>
                

              <%if strdurum = "1" Then
                cbcdisstr="disabled"
				cbccheckstr="checked"
				 else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Durum",iks,cbcdisstr,cbccheckstr,"info"))%>
                
              <%
                 
                  if strmenugosterim = "1" Then
              cbcdisstr="disabled"
			  cbccheckstr="checked"
			  else
			  cbcdisstr=""
			  cbccheckstr=""
			  end if
		response.Write(checkboxcreat("menugosterim","Vitrin Sayfası",iks,cbcdisstr,cbccheckstr,"success"))			 
                  if yetkiuye="1" then							
                else
                  '<input name="menugosterim" type="hidden" value="<%=strmenugosterim %'>" />
                  %>
                 
                 <% end if %>
                <%if strhabertemp="1" then%>
                <a href="<%=altsayfaekle%>&sky=0&islem=skyduzenle&dkate2=<% =dkate2%>&islemtur=sky&skyid=<%=strid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sık Kullanılanlardan Kaldır"><em class="fa fa-star" style="color:#FC0; font-size:16px;"></em></a>
                <%else%>
                <a href="<%=altsayfaekle%>&sky=1&islem=skyduzenle&dkate2=<% =dkate2%>&islemtur=sky&skyid=<%=strid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sık Kullanılanlar Butonu Yap"><em class="fa fa-star" style="color:#999; font-size:16px;"></em></a>
                <%end if%>
			  
              </div>
              </div>
               </div>
               
		<div class="col-md-1 col-xs-3">
            <div class="col-md-6 col-xs-6">
     
              </div>
              <div class="col-md-6 col-xs-6">
                 <%
              if silinmiyecekler="1" then		   
              else
              %>
                    <label>
                      <input type="checkbox" name="urunidsil" class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>">
                    </label>
      		  <%end if%>
                </div>
              </div>
              
          </div>
          </div>
        </div>
      </li>
  <%
  mmmGenel.MoveNext
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

  </div>
</form>
    <%
end if
close(mmmGenel)
%>
<%
  if request("usayi")="" then
	KayitSayisi=200
	else
	KayitSayisi=request("usayi")
	end if
	
  git = Request.QueryString("git")
if git="" then
git=1
end if
if dkate2="" or dkate2=0 then
sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&" order by durum desc, sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
else
  sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&"  order by durum desc, sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
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
  <div class="icerik1 icerik">
  <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik');">
      <div class="btn-group pull-right" style="margin-right:5px;">
  <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
    Kopyala  <span class="caret"></span>
  </button>
  <div class="dropdown-menu keep-inside-clicks-open dropdown-menu-right" style="padding:15px;">

    <div class="form-group">
      <label for="exampleDropdownFormEmail1">Kopyalanacak Kategori</label>
      
    <select name="kdkate2" class="form-control" id="kdkate" style="width:100%;">

   <% response.Write kategorimodullistesi %>

    </select>
    </div>
    <button type="submit" class="btn btn-warning" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Kopyalaicerikt');">Seçili Olanları Kopyala</button>

  </div>
</div>
  <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenleicerikt');">
</div>    
  </div>
  <div style="clear:both;"></div>
<div class="sortpage">
    <ol class="ui-sortable1 vertical">
    <%
Do While Not mmmGenel.EOF
iksss=iksss+1
stryid=mmmGenel("id")
stryidilk=stryid
strybagli=mmmGenel("bagli")
        if strybagli="" or isNull(strybagli) then
        strybagli="0"
        end if
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
                      
            <div class="col-md-9 col-xs-7">
            <div class="col-md-12">
                 
            <div class="input-group" style="margin-bottom:0px;"> 
            <div class="input-group-btn">   
                 <div style="min-width:30px; font-size:initial;">
                     <span class="handle ui-sortable-handle">
                        <i class="fas fa-arrows-alt" style=" <%if strydurum = "1" Then%><%else%> color: #bbb; <%end if%>"></i>
                     </span>
              </div>
              </div>
            <div class="input-group-btn"> 
              <select name="sayfalama"  class="form-control" id="sayfalama" style="min-width:180px;<%if strydurum = "1" Then%><%else%> color: #bbb; <%end if%>">
                <option value="1"> Ana Sayfa </option>               
                <%response.Write replace(kategorimodullistesi,"value="""&strykategori&"""","value="""&strykategori&""" selected")%>
              </select>
    </div>
    <div class="input-group-btn">
            <select name="iceriktur" class="form-control" id="iceriktur" style="min-width:150px;<%if strydurum = "1" Then%><%else%> color: #bbb; <%end if%>">
              <option value="0" >T&uuml;r Se&ccedil;in</option>
              <%
sqlString = "SELECT * from kategori where ana='1' order by id"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
              <option value="<%=mmmYardimci("id")%>" <% if int(mmmYardimci("id"))=int(urunidd) then%>selected<%else%><%end if%>><%=mmmYardimci("kate")%></option>
              <%mmmYardimci.MoveNext
loop
close(mmmYardimci)%>
            </select>
   </div>

            <input name="icerikadi" type="text" class="form-control" id="icerikadi" value="<%=mmmGenel("yazib")%>" style="margin-top:1px;<%if instr(request("id"),stryid) and request("islem")="duzenleyazi" then%>border-color:#CC0000;<%else%><%end if%> <%if strydurum = "1" Then%><%else%> color: #bbb; <%end if%>">
            
    
           <div class="input-group-btn"> 
                        <%
sqlString = "SELECT * from kategori where id="&urunidd&" order by id"
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
                            xstradresd=mmmYardimci("adresd")
                            xstrid=mmmYardimci("id")
%>
        <%            
sqlString = "select id,kate from diller1 where alt = '1' and sira='1' ORDER BY bagli"
set mmmYardimci1= Con.Execute (sqlString)
           if mmmYardimci1.eof then
            %>
               <a href="<%=xstradresd%>duzelt1=<%=xstrid%>&urunid=<%=stryid%>&baslik=<%=stryid%>&sek=<%=strykategori%>&dkate2=<%=strykategori%>" style="padding:7px 5px;" class="btn btn-warning dropdown-toggle btn-xs"><em class="fa fas fa-clone" style="font-size:11px;"></em></a>
               <%else%>           
      <span class="dropdown">
        <button class="btn btn-warning dropdown-toggle" style="padding:7px 5px;" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false"><em class="fa fa-clone" style="font-size:11px; color:#FFF;"></em></button>
        <ul class="dropdown-menu animated fadeInDown">
       <%
Do While Not mmmYardimci1.EOF
           yazidilim=mmmYardimci1("id")
sqlString = "select * from yazilar where dil='"&mmmYardimci1("id")&"' and (bagli="&stryid&" or id="&stryid&" or id="&strybagli&")"
set mmmYardimci3= Con.Execute (sqlString)
if mmmYardimci3.eof then
           if yazidilim="240" then
           yazidilcss=""
           else
           yazidilcss=" class=""border-red"" style=""border:1px solid;"""
           end if
                    %>
                <li><a<%=yazidilcss %> href="<%=xstradresd%>duzelt=1&amp;urunid=&amp;dkate2=<%=strykategori%>&sek=<%=strykategori%>&anaurunid=<%=stryid %>&dil=<%=yazidilim %>"><%=mmmYardimci1("kate")%></a></li>
               <%
else
if dil&""<>""&mmmYardimci1("id") then
                %>
                <li><a href="<%=xstradresd%>duzelt=1&amp;urunid=<%=mmmYardimci3("id")%>&amp;dkate2=<%=strykategori%>&sek=<%=strykategori%>&anaurunid=<%=stryid %>&dil=<%=yazidilim %>"><%=mmmYardimci1("kate")%></a></li>
                <%
			  end if
			  end if
			  close(mmmYardimci3)
mmmYardimci1.movenext
loop
close(mmmYardimci1)
                %>

            </ul>

      </span> 
            <%

end if
end if
close(mmmYardimci)%>
               <%if strmodulmu="1" or urunidd="12" or urunidd="7" or urunidd="1"  then
else
                    %>
            <a href="/<%=seolarlink(stryid,"yazi",lang)%>" target="_blank" style="padding:7px 5px;" class="btn btn-primary dropdown-toggle btn-xs"><em class="fa fas fa-external-link" style="font-size:11px;"></em></a>
               <%
                   end if %>
</div>
<div class="input-group-btn"> 
<a href="galeri.asp?baslik=<%=stryidilk%>&dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" style="padding:7px 5px;" class="btn btn-default dropdown-toggle btn-xs"><em class="fa fa-camera" style="font-size:16px;"></em> (<%=toplam4%>) </a>
</div>
            </div>
          </div>
        </div>

<div class="col-md-3 col-xs-5">

<div class="col-md-6 col-xs-8">
                <%=mmmGenel("gtarih")%>
              </div>
              <div class="col-md-4">  
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
						  response.Write(checkboxcreat("ilksayfa","Vitrin Yazısı",iksss,cbcdisstr,cbccheckstr,"success"))%>
                         </div>
          
        </div>
            
              <div class="col-md-2 col-xs-2">
                 <%
              if instr(silinmiyecekler,"s"&stryid) then		   
              else
              %>
                    <label>
                      <input type="checkbox" name="iceriksil" class="flatred" id="iceriksila<%=iksss%>" value="<%=stryidilk%>">
                    </label>
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
                 $(document).on('click.bs.dropdown.data-api', '.dropdown-menu.keep-inside-clicks-open', function (e) {
  e.stopPropagation();
});
		
	var oldContainer;
$("ol.ui-sortable1").sortable({
  group: 'nested', 
  handle: 'i.fa-arrows-alt',  
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

$('ul.nav-pills li.dropdown-toggle').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(500);
}, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(500);
});
$('.selctize1').selectize({

delimiter: '*',

persist: false

});


$(document).ready(function () {
    $("#dkate2").change(function(){
      strmssayfa=$( '#dkate2' ).find(":selected").val();
      if (strmssayfa!==""){
      window.location.href = strmssayfa;
    }
    });
  });
</script>