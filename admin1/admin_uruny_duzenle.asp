<!--#Include File="admin_menu1.asp"-->
<div class="right_col" role="main">
    <style>
        .list.list-icons {
	list-style: none;
	padding-left: 0;
	padding-right: 0;
}

.list.list-icons li {
	position: relative;
}


.list.list-borders li {
    display:table !important;
    width:100%;
	border-bottom: 1px solid #eaeaea;
	margin-top: 9px;
	margin-bottom: 0;
	padding-bottom: 9px;
}

.list.list-borders li:last-child {
	border-bottom: 0;
}

.list.list-side-borders {
	border-left: 1px solid #eaeaea;
	padding-left: 10px;
}

    </style>

    <div class="">
        <div class="page-title">
            <div class="title_left">

</div>
    <%
       
  dim so(14),sou(14),sl(14),slu(14)
urunid = Request.QueryString("urunid")
referer = Request.QueryString("referer")
langstr = Request.QueryString("dil")
              
                   if Request.QueryString("anaurunid")="" then
                   anaurunid=urunid
                   else
                   anaurunid=Request.QueryString("anaurunid")
                   end if

              if langstr="" then
              else
        response.Write(setchar(langstr,"0"))

            set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&langstr&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)

        if Request.QueryString("urunid")="" or Request.QueryString("urunid")="0" then

sqlString = "SELECT * FROM yazilar where id="&Request.QueryString("anaurunid")&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
seolink= seomlink
        if request.QueryString("iceriktur")="1" then
        yazib=request.QueryString("titlee")&" Sayfası"
        end if
else
urunid=mmmYardimci("urunid")
yazib=mmmYardimci("yazib")
yazib1=yazib
yazi=mmmYardimci("yazi")
yazicode=mmmYardimci("yazicode")
modulmu=mmmYardimci("modulmu")
bilgi1=mmmYardimci("bilgi1")
bilgi2=mmmYardimci("bilgi2")
bilgi3=mmmYardimci("bilgi3")
bilgi4=mmmYardimci("bilgi4")
durum=mmmYardimci("durum")
ilksayfa=mmmYardimci("ilksayfa")
form=mmmYardimci("form")
sira=mmmYardimci("sira")
admin=mmmYardimci("admin")
temp=mmmYardimci("temp")
yayinlang=mmmYardimci("sira1")

end if
close(mmmYardimci)

        seomlink=csskont(baslikkont(yazib1))&".html"
            
con.Execute("insert yazilar Set dil='"&langstr&"',yazib='"&yazib&"',yazi='"&yazi&"',yazicode='"&yazicode&"',bagli='"&Request.QueryString("anaurunid")&"',seolink='"&seolink&"',urunid='"&urunid&"' ,modulmu='"&modulmu&"' ,bilgi1='"&bilgi1&"' ,bilgi2='"&bilgi2&"' ,bilgi3='"&bilgi3&"' ,bilgi4='"&bilgi4&"' ,durum='"&durum&"' ,ilksayfa='"&ilksayfa&"' ,form='"&form&"' ,sira='"&sira&"' ,admin='"&admin&"' ,temp='"&temp&"'")
        strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)

        urunid=tfgid
end if
      '  response.Write urunid


              end if

        stredittype=request.QueryString("edittype")

        formid=request("formice")

              if formid="0" or formid="" then
              formid="0"
              end if
              if urunid="0" or urunid="" then
              urunid="0"
              end if
sqlString = "select * from yazilar where id="&urunid&""
set mmmGenel = Con.Execute (sqlString)
              if mmmGenel.eof then
              skategori="0"
        submitlink="?id="&Request("dkate2")&"&baslik="&Request("dkate2")&"&sek=1&islem=icerikekle&dkate2="&Request("dkate2")&"&tur="&Request("iceriktur")&"&modulv="&Request("modulv")&"&yer="&Request("sayfayeri")&"&lang="&dil&"&dil="&dil&""
        kopyalink=""
        baslikstr="İçerik Ekle"
        urunidd=request("iceriktur")
        submitbuton="Ekle"
        strmodulmu=Request("modulv")
strtarih=mysqltarihsaat(now)
        syaziid="0"
        syazibagli="0"
        if request.QueryString("iceriktur")="1" then
        syazib=request.QueryString("titlee")&" Sayfası"
        end if
smidseolar="1"
              else
syaziid=mmmGenel("id")
stemptur=mmmGenel("temp")
stemptur1=stemptur
syazibagli=mmmGenel("bagli")
              syazib=mmmGenel("yazib")
              syazib1=syazib
              syazi=mmmGenel("yazi")
              syazicode=mmmGenel("yazicode")
        if instr(syazicode,"${edit}${edit}") then
        syazicode=syazi
        end if
              starget=mmmGenel("target")
              sform=mmmGenel("form")
              skategori=mmmGenel("kategori")
              strtarih=mmmGenel("tarih")
              strgtarih=mmmGenel("gtarih")
yayinlang=mmmGenel("sira1")
strgtarihn=mysqltarihsaat(now)
              strkisadesc=mmmGenel("descri")
urunidd=mmmGenel("urunid")
              if syazibagli="" or isNull(syazibagli) then
              syazibagli="0"
              end if
bilgi1=mmmGenel("bilgi1")
dil=mmmGenel("dil")
        
        if referer="" then
        refererqry="&lang="&dil&""
        else
        refererqry="&referer="&referer&"&lang="&dil&""
        end if
        if (syazi="" or isNull(syazi)) and dil<>"240" then
        sqlString = "select yazi,yazicode,descri from yazilar where id='"&syazibagli&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
syazi=mmmYardimci("yazi")
              strkisadesc=mmmYardimci("descri")
syazicode=mmmYardimci("yazicode")
if syazicode="" or isNull(syazicode) then
else
syazicode=replace(syazicode,"'","&#39;")
end if
        if instr(syazicode,"${edit}${edit}") then
        syazicode=syazi
        end if
end if
close(mmmYardimci)
        end if
strmodulmu=mmmGenel("modulmu")
strlink=mmmGenel("link")
strseolink=mmmGenel("seolink")
              sbilgi2=mmmGenel("bilgi2")
              sbilgi3=mmmGenel("bilgi3")
              sbilgi4=mmmGenel("bilgi4")
sqlString = "select * from ozellikler2 where kateid='"&syaziid&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
formid="1"
else
formid=mmmYardimci("formid")
formidtur=mmmYardimci("tur")
end if
close(mmmYardimci)
lojik4=con.execute("select count(fid) as toplam4 from resimd where baslik='"&urunid&"' ")
toplam4=lojik4("toplam4")

              
sqlString = "select * from seolar where seoid='"&syaziid&"' and seoturu='yazi'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
smidseolar="0"
        if langstr="" then
smidlang=aktifdil
        else
smidlang=langstr
        end if
smidseolink=baslikkont(syazib1)&".html"
else
smidseolar="1"
smidtitle=mmmYardimci("seobaslik")
smiddescri=mmmYardimci("seoaciklama")
smidkeysi=mmmYardimci("seotag")
smidh1=mmmYardimci("seoh1")
smidseolink=mmmYardimci("seolink")
smidlang=mmmYardimci("lang")
smidcanoncial=mmmYardimci("canoncial")
smidhraflang=mmmYardimci("hraflang")
seonoindex=mmmYardimci("noindex")
        if smidlang="" then
        if langstr="" then
smidlang=aktifdil
        else
smidlang=langstr
        end if
        end if
end if
close(mmmYardimci)
        baslikstr=syazib&" Düzenle"
        submitlink="sayfalar.asp?dkate2="&request("sek")&"&sek="&request("dkate2")&"&islem=duzenleyazi"&refererqry&""
        kopyalink="sayfalar.asp?dkate2="&request("sek")&"&sek="&request("dkate2")&"&islem=duzenleyazi&islemim=kopyayazi"&refererqry&""
        submitbuton="Güncelle"
        submitbutona="Güncelle Kal"
              end if
              close(mmmGenel)
        if (strmodulmu="1" or urunidd="12") and stredittype ="" and yetkiuye="2" then
        stredittype="4"
       elseif (strmodulmu="1" or urunidd="12") and stredittype ="" and yetkiuye="1" then
        stredittype="2"        
        elseif yetkiuye<>"1" and yetkiuye<>"2" and strmodulmu="1" then
        stredittype="4"
        end if
        'response.Write stredittype 
    %>
    <div class="x_panel">
        <form method="post" name="custlist17" id="custlist17" action="">
            <div class="x_title">
               <h2> <%=baslikstr %></h2>
               
                <%if strmodulmu<>"1" then %>
                <a href="/<%=smidseolink%>" target="_blank" style="padding:1px 6px;" class="btn btn-primary pull-right"><em class="fa fas fa-external-link" style="font-size:11px;"></em></a>
                <a href="ortak_sayfalar_ayar.asp?dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&sayfaayar=modul" class="btn btn-dark dropdown-toggle pull-right" data-fancybox-type="iframe" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bu Sayfanın veya Alt Sayfaların Yerleşim Ayarları İçin." style="padding:1px 6px;"><em class="fa fa-th-large" style="font-size: 11px;"></em></a>
                <%end if %>


                  
      <span class="dropdown pull-right">
        <button class="btn btn-danger dropdown-toggle" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false"><em class="fa fa-plus" style="font-size:11px; color:#FFF;"></em> Kodlama</button>
        <ul class="dropdown-menu keep-inside-clicks-open dropdown-menu-right">        
            <%if yetkiuye="1" then %>
            <li><a href="?duzelt1=1&urunid=<%=urunid %>&baslik=<%=urunid %>&sek=<%=request("sek") %>&dkate2=<%=request("dkate2") %>&dataurl=<%=request("dkate2") %>&edittype=3&dil=<%=request.querystring("dil") %>" class=" text-right">Tiny</a></li>
        <%end if %>
        <li><a href="?duzelt1=1&urunid=<%=urunid %>&baslik=<%=urunid %>&sek=<%=request("sek") %>&dkate2=<%=request("dkate2") %>&dataurl=<%=request("dkate2") %>&edittype=2&dil=<%=request.querystring("dil") %>" class=" text-right">Code</a></li>

        <%if eser="1" then %>
        <li><a href="?duzelt1=1&urunid=<%=urunid %>&baslik=<%=urunid %>&sek=<%=request("sek") %>&dkate2=<%=request("dkate2") %>&dataurl=<%=request("dkate2") %>&edittype=1&dil=<%=request.querystring("dil") %>" class=" text-right">Adv Bloklanmış Yarım</a></li>
        <%end if %>
        <li><a href="?duzelt1=1&urunid=<%=urunid %>&baslik=<%=urunid %>&sek=<%=request("sek") %>&dkate2=<%=request("dkate2") %>&dataurl=<%=request("dkate2") %>&edittype=4&dil=<%=request.querystring("dil") %>" class=" text-right">Adv</a></li>

        <%if yetkiuye="1" and (instr(syazicode,"${edit}")="0" or syazicode="" or isNull(syazicode)) then %>
        <li><a href="?duzelt1=1&urunid=<%=urunid %>&baslik=<%=urunid %>&sek=<%=request("sek") %>&dkate2=<%=request("dkate2") %>&dataurl=<%=request("dkate2") %>&edittype=2&bolme=1" class=" text-right">Adv Böl</a></li>
        <%end if %>
        <li><hr></li>
        <li><a href="sayfalar.asp?id=0&baslik=0&sek=1&sira=&dkate2=0&Submit=Silicerik&iceriksil=<%=syaziid %>" class="text-danger text-right">Sil</a></li>
            </ul>
        </span>

            <span class="dropdown pull-right">
                <%
                sqlString = "select id,kate from diller1 where alt = '1' and sira='1' and id='"&dil&"' ORDER BY bagli"
                set mmmYardimci1= Con.Execute (sqlString)
                if mmmYardimci1.eof then
                else
                %>
                <button class="btn btn-success dropdown-toggle"  type="button" aria-expanded="false"><%=mmmYardimci1("kate")%> dili görüntüleniyor</button>
                <%end if
                close(mmmYardimci1)
                %>
        <button class="btn btn-danger dropdown-toggle"  type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false"><em class="fa fa-plus" style="font-size:11px; color:#FFF;"></em> Çeviriler</button>
        <ul class="dropdown-menu keep-inside-clicks-open dropdown-menu-right">  

                <%
sqlString = "select id,kate from diller1 where alt = '1' and sira='1' ORDER BY bagli"
set mmmYardimci1= Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
                    if langstr="" or langstr="240" then
sqlString = "select * from yazilar where dil='"&mmmYardimci1("id")&"' and (bagli="&syaziid&" or id="&syaziid&" or id="&syazibagli&")"
                    else
sqlString = "select * from yazilar where dil='"&mmmYardimci1("id")&"' and (bagli="&syazibagli&" or id="&syaziid&" or id="&syazibagli&")"
                    end if
set mmmYardimci= Con.Execute (sqlString)
if mmmYardimci.eof then

                    %>
                 <li><a href="?duzelt=1&amp;urunid=0&amp;dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&anaurunid=<%=anaurunid %>&dil=<%=mmmYardimci1("id") %>" class="border-danger btn-md border-red text-right" style="border:1px solid;border-color:#cc0000;"><%=mmmYardimci1("kate")%></a></li>
               <%
else
if dil&""<>""&mmmYardimci1("id") then
                %>
                <li><a href="?duzelt=1&amp;urunid=<%=mmmYardimci("id")%>&amp;dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&anaurunid=<%=anaurunid %>&dil=<%=mmmYardimci1("id") %>" class=" btn-md text-right"><%=mmmYardimci1("kate")%></a></li>
                <%
			  end if
			  end if
			  close(mmmYardimci)
mmmYardimci1.movenext
loop
close(mmmYardimci1)
                %>
                
            </ul>
        </span>      



                <div class="clearfix"></div>
            </div>
            <%if request.QueryString("yazi")="yeni" then %> 
                      <input name="coklu" type="hidden" value="<%=request("coklu")%>">
                        <%if request.QueryString("res")=1 then%>
                        <input type="hidden" name="sayi" value="<%=Request.QueryString("sayi")%>">
                        <%else%>
                        <input type="hidden" name="sayi" value="<%=Sayilar%>">
                        <input type="hidden" name="res" value="1">
                        <%end if%>
                        <input type="hidden" name="sayi1" value="<% = Request.QueryString("sayi1")%>">
                        <input type="hidden" name="sayi2" value="<% = Request.QueryString("sayi2")%>">
                        <input name="modul" type="hidden" value="<%=strmodulmu%>">
                        <input name="goster" type="hidden" value="2">
                        <input name="kategoriyeni" type="hidden" value="<%=request("kategoriyeni")%>">
<%else%>            
            <input type="hidden" name="id" value="<%=syaziid%>" />
            <input type="hidden" name="modulmu" value="<%=strmodulmu%>" />
            <input type="hidden" name="urunidd" value="<%=urunidd%>" />
            <%end if %>
            
            <input type="hidden" name="charcode" value="<%=ceviridileki%>" />
            <input type="hidden" name="urunadminlink" value="/admin/admin_uruny_duzenle.asp?<%=request.QueryString%>" />
            <table class="table table-striped" style="margin: 0px; ">
                <tr>
                    <td colspan="2">
                        <div class="input-group col-md-12">
                            <%if request.QueryString("yazi")="yeni" and strmodulmu="1" then 
                else%> 
                            <div class="input-group-addon">
                                <a href="galeri.asp?sayfa=galeri&redirect=1&baslik=<%=urunid%>&dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Resim Ekle"><em class="fa fa-camera" style="font-size: 16px;"></em>(<%=toplam4%>)</a>
                            </div>
                            <%end if 
                            if syazib="" then
                            syazib=request.QueryString("katebaslik")&" Sayfası"
                            end if %>
                            <input type="text" name="urun" value="<%=syazib%>" class="form-control input-lg" placeholder="Başlık Giriniz" />
                            
                            <%if (smidseolar="" or smidseolar="0") and strmodulmu<>"1" and urunidd<>"1" and urunidd<>"7" and urunidd<>"12" then %>
<div role="alert" class="alert alert-danger alert-dismissible">
  <button type="button" data-dismiss="alert" aria-label="Close" class="close"><span aria-hidden="true" class="fa fa-close"></span></button><span class="icon fa fa-exclamation-triangle"></span> Link Oluşturulmamış Lütfen link oluşturun.   <button type="submit" class="btn btn-default btn-xs" onclick="formla7('?urunid=<%=request("urunid")%>&dkate2=<% =dkate2%>&sayfaayar=<%=request("sayfaayar")%>&Submit=sayfatumDuzenle&seoturu=yazi&dil=<%=langstr %>');" >Tıklayın</button>
                                <input type="hidden" name="seolinkyenilebtn" value="1"> 
                </div>
                            <%end if %>
                            <%if strmodulmu="1" then %>
                        <input name="yazikategori" type="hidden" value="<%=skategori%>">
                        <input name="iceriktur" type="hidden" value="<%=urunidd%>">
                            <%else%>
            <%if request.QueryString("yazi")="yeni" then%>
                            
                        <input name="kateana" type="hidden" value="<%=request("kateana")%>">
                        <input name="kategoria" type="hidden" value="<%=request("dkate2")%>">
                <%else%> 
                                <%end if %>
                            <%end if %>
                        </div>
                        <%if strmodulmu="1" then %>
                        <input name="haber_tarihi" type="hidden" value="<%=strtarih%>">
                            <%else%>
                        <div class="row"> 
                            <div class="col-md-12">          
                             <%if request.QueryString("yazi")="yeni" then%>
              <input type="text" name="haber_tarihi" id="haber_tarihi" class="form-control datetimepicker12" value="<%=strtarih%>" placeholder="İçerik Yayınlama Tarihi">
              <%else%>
              <span class="pull-left">İçerik Yayınlama Tarihi: <%=strtarih%> </span><span class="pull-right"> İçerik Son Güncelleme Tarihi: <%=strgtarih%></span>
          <%end if %>
                </div>
          <%if request.QueryString("yazi")="yeni" then
              else%>
                            <div class="col-md-12">
       <span class="input-group"><span class="input-group-btn"><button type="button" class="btn btn-default">İçerik Yeni Güncelleme Tarihi:</button></span><input type="text" name="haber_tarihi" id="haber_tarihi" class="form-control datetimepicker12" value="<%=strgtarihn%>" placeholder="İçerik Son Güncelleme Tarihi"></span>
                            </div>
          <%end if %>
                        </div>
                        <div class="row">
                            
          <%
              if (request.QueryString("yazi")="yeni" and skategori<>"0") or (langstr<>"" and langstr<>"240") then
              else
              skategori=request("dkate2")
              %>
                            <div class="col-md-3">
                                
                                <select name="yazikategori" class="form-control" id="iceriktur" style="min-width: 150px;">
                                     <%
          response.Write kategoriyaziliste("1","<option value=""#kylid#""> #kylico# #kylisim#</option>#kylsub{(,,,,"&sayfagosterme&",&nbsp;>,240)}#","",skategori,sayfagosterme,"","240")
      %>
                                </select>
                            </div>
                            <%end if %>
                            <div class="col-md-3">
                                
                                <select name="iceriktur" class="form-control" id="iceriktur" style="min-width: 150px;">
                                    <option value="0">T&uuml;r Se&ccedil;in</option>
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
                            <%if modulmu="1" then
                                haricicol="col-md-6"
                                else
                                
if (request.QueryString("yazi")="yeni" and skategori="0") then
                                haricicol="col-md-9"
              else
                                haricicol="col-md-6"
                                end if
                                end if
                                %>
                            <div class="<%=haricicol %>">
                                <div class="input-group">
                                    <input name="link" type="text" placeholder="Harici Bağlantıya Gitmesini İstemiyorsanız Boş Bırakın." value="<%if strlink="" or strlink="0" then%><%else%><%=strlink%><%end if %>" class="form-control" />
                                    <div class="input-group-btn">
                                        <select id="target" name="target" class="form-control" style="width: 140px;">
                                            <option value="0" <%if starget="0" then%>selected<%else%><%end if%>>Sayfa Açılma</option>
                                            <option value="_blank" <%if starget="_blank" then%>selected<%else%><%end if%>>Yeni Sekmede Aç</option>
                                            <option value="_parent" <%if starget="_parent" then%>selected<%else%><%end if%>>Kendi Sekmesinde Aç</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <%if  modulmu="1" and yetkiuye="1" then %>
                                                        <div class="col-md-3">
                                
                                <select name="modulbagla" class="form-control" id="modulbagla" style="min-width: 150px;">
                                    <option value="0">Bağlantılı Modül</option>
                                    <%
sqlString = "SELECT * from moduller"&modulgosterme&" and temp='99999'  order by temp desc"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
                                    %>
                                    <option value="<%=mmmYardimci("id")%>" <% if ""&mmmYardimci("id")=""&stemptur then%>selected<%else%><%end if%>><%=mmmYardimci("moduladi")%></option>
                                    <%mmmYardimci.MoveNext
loop
close(mmmYardimci)%>
                                </select>
                            </div>
                            <%end if %>

                        </div>
                        <%end if %>
                    </td>
                </tr>
                
 
                <tr>
                    <td>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#icerik">İçerik</a></li>      
                    <%if request("modul")=1 or strmodulmu="1" or urunidd="12" then%>
    <li><a data-toggle="tab" href="#css" id="headingcss" onclick='format("css","css",this)'>Css</a></li>
      <%end if %>
            <%
                if request.QueryString("yazi")="yeni" then
                else
			if strmodulmu="1" or urunidd="12" then
            else
            %>  
    <li><a data-toggle="tab" href="#sablon">Sayfa Şablonu</a></li>
            <%end if%>
            <%end if%>
            <%
                if request.QueryString("yazi")="yeni" then
                else%>        
    
                    <%
			if strmodulmu="1" or urunidd="12" or urunidd="7" or urunidd="1" then
else
                    %>
    <li><a data-toggle="tab" href="#seo" onclick='format("listes4","text/html", this);format("listes1","text/html", this);format("listes2","text/html", this);format("listes3","text/html", this);'>Seo</a></li>
      <%end if
          end if%>
  </ul>
                    </td>
                </tr>
                </table>
              <div class="tab-content">

<div id="icerik" class="tab-pane fade in active">
    <%if strmodulmu="1" then 
        else
        %>
            <table class="table table-striped">
     
                <%if request("duzelt1")=5 or urunidd="5" then%>
                <tr>
                    <td>Youtube Vide Linki Aşağıdaki Şekilde Olmalı (https://www.youtube.com/watch?v=3sN-DKevBuE):</td>
                    <td colspan="2">
                        <input type="text" name="form" id="form" class="form-control" value="<%=sform%>"></td>
                </tr>
                <%else%>
                <%end if%>
                <%if request("duzelt1")=7 or urunidd="7" then%>
                <tr>
                    <td>Form Se&ccedil; :</td>
                    <td colspan="2">
                        <select id="kategori" size="1" name="form" class="form-control">
                            <%
sqlString = "select * from formlar  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                            %>
                            <option value="<%=mmmYardimci("id")%>" <%if int(sform)=int(mmmYardimci("id")) then%>selected<%else%><%end if%>><%=mmmYardimci("formadi")%></option>
                            <%
mmmYardimci.movenext
loop
close(mmmYardimci)
                            %>
                        </select></td>
                </tr>
                <%else
                if request("duzelt1")=5 or urunidd="5" then
                else%>
                <input name="form" type="hidden" value="0" />
                <%
                end if
                if request("modul")=1 then
sqlString = "select * from sayfamodul where modulid='"&request("duzelt1")&"'"
set mmmYardimci = Con.Execute (sqlString)
 if mmmYardimci.eof then
 urunayar=0
 else
 urunayar=mmmYardimci("temp")
 end if
 close(mmmYardimci)
		  
		  else
		  if stura2=1 or stura3=1 or stura4=1 or stura5=1 then
		  if stura5="" then
		  if stura4="" then
		  if stura3="" then
		  if stura2="" then
		else
		urunayar=sid2
		end if
		else
		urunayar=sid3
		end if
		else
		urunayar=sid4
		end if
		else
		urunayar=sid5
		end if
else
urunayar=skategori
end if

end if

if request("modul")=1 then
sqlString = "select * from kategoriayar where id="&urunayar&"  ORDER BY id"
else
sqlString = "select * from kategoriayar where adres='"&urunayar&"'  ORDER BY id"
end if
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
strbilgi1=mmmYardimci("bilgi1")
strbilgi1i=mmmYardimci("bilgi1i")
strbilgi2=mmmYardimci("bilgi2")
strbilgi2i=mmmYardimci("bilgi2i")
strbilgi3=mmmYardimci("bilgi3")
strbilgi3i=mmmYardimci("bilgi3i")
strbilgi4=mmmYardimci("bilgi4")
strbilgi4i=mmmYardimci("bilgi4i")
                %>
                <%end if
			close(mmmYardimci)%>
                <%if strbilgi1="1" then%>
                <tr>
                    <td><%if request("duzelt1")="11" then%>Adres<%else%><%=strbilgi1i%><%end if%> :</td>
                    <td colspan="2">
                        <textarea name="bilgi1" cols="25" id="bilgi1" class="form-control"><%=sbilgi1%></textarea></td>
                </tr>
                <%else%>
                <%end if%>
                <%if strbilgi2="1" or request("duzelt1")="11" or urunidd="11" then%>
                <tr>
                    <td><%if request("duzelt1")="11" or urunidd="11" then%>Koordinat<%else%><%=strbilgi2i%><%end if%> :</td>
                    <td colspan="2">
                        <input type="text" name="bilgi2" id="bilgi2" value="<%=sbilgi2%>" size="25" class="form-control" /></td>
                </tr>
                <%else%>
                <%end if%>
                <% 'or request("duzelt1")="4"
			if strbilgi3="1" or request("duzelt1")="81" or request("duzelt1")="11" or urunidd="11" then%>
                <tr>
                    <td><%if request("duzelt1")="11" or urunidd="11" then%>Adres<%elseif request("urunid")="8" or request("duzelt1")="4" or urunidd="8" or urunidd="4" then%>
                Fiyatı
                <%else%>
                        <%=strbilgi3i%>
                        <%end if%>
                :</td>
                    <td colspan="2">
                        <input type="text" name="bilgi3" id="bilgi3" value="<%=sbilgi3%>" size="25" class="form-control" /></td>
                </tr>
                <%else%>
                <%end if%>
                <%if strbilgi4="1" then%>
                <tr>
                    <td><%=strbilgi4i%> :</td>
                    <td colspan="2">
                        <input type="text" name="bilgi4" id="bilgi4" value="<%=sbilgi4%>" size="25" class="form-control" /></td>
                </tr>
                <%else%>
                <%end if%>

                <%end if%>
                <script language="javascript">
                    function toggleDiv(id, show) {
                        document.getElementById(id).style.display = show ? 'block' : 'none';
                        document.getElementById(id).style.display = show ? 'block1' : 'none';
                    }
                </script>


                <%if formid="1" or formid="" then
					else
                     sqlString = "select * from formlar where id="&formid&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
                                        else
                    %>
                <tr>
                    <td colspan="2">
                        <table class="table table-striped">
                            <script language="JavaScript">
<!--
    /*
    Script validates form field entries
    Only the first three ones are checked
    If you need the others to be checked, just follow the same code examples
    (change field name and number of characters if needed
    */
    function validate(theForm) {
                        <%
            sqlString = "select * from ozellikler where formid='" & formid & "' and alt = '1' and gerekli = '1' order by sira"
        set mmmYardimci = Con.Execute(sqlString)
        Do While Not mmmYardimci.EOF
        if emailvarmi = "1" then %>
	if (theForm.<%= mmmYardimci("name") %>.value.indexOf('@', 1) == -1 || theForm.<%=mmmYardimci("name") %>.value.indexOf('.', 2) == -1) {
            alert("<%=mmmYardimci("isim")%> Doğru Doldurunuz.");
            theForm.<%=mmmYardimci("name") %>.focus();
            return false;
        }
	<%else%>
	if (theForm.<%= mmmYardimci("name") %>.value == "" || theForm.<%=mmmYardimci("name") %>.value.length < 1) {
            alert("<%=mmmYardimci("isim")%> Doldurunuz.");
            theForm.<%=mmmYardimci("name") %>.focus();
            return false;
        }
	<% end if
	mmmYardimci.movenext
loop
        close(mmmYardimci) %>

return true;
    }
//-->
                            </script>
                                    <%

strfkolonlar=mmmYardimci("kolonlar")
if instr(strfkolonlar,"-") then
if instr(strfkolonlar,",") then
strfkolonlar1=split(split(strfkolonlar,"-")(0),",")(0)
strfkolonlar2=split(split(strfkolonlar,"-")(0),",")(1)
strfkolonlar3=split(split(strfkolonlar,"-")(1),",")(0)
strfkolonlar4=split(split(strfkolonlar,"-")(1),",")(1)
else
strfkolonlar1="0"
strfkolonlar2="0"
strfkolonlar3="0"
strfkolonlar4="0"
end if
else
if instr(strfkolonlar,",") then
strfkolonlar1=split(strfkolonlar,",")(0)
strfkolonlar2=split(strfkolonlar,",")(1)
strfkolonlar3="0"
strfkolonlar4="0"
else
strfkolonlar1="0"
strfkolonlar2="0"
strfkolonlar3="0"
strfkolonlar4="0"
end if
end if
                                    %>
                            <input name="formice" type="hidden" value="<%=formid%>" />
                            <input name="formekle" type="hidden" value="ekle" />
                            <input name="formidtur" type="hidden" value="<%=formidtur%>" />
                            <input name="kolon1" type="hidden" value="<%=strfkolonlar2%>" />
                            <input name="kolon2" type="hidden" value="<%=strfkolonlar4%>" />
                            <%
				  ' and tur<50 
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' and (id<>"&strfkolonlar2&" and id<>"&strfkolonlar4&") and tur<>'7' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
Do While Not mmmYardimci1.EOF
iks=iks+1
formisim=mmmYardimci1("isim")
strvnamee=mmmYardimci1("name")
strvidd=mmmYardimci1("id")
strvturr=mmmYardimci1("tur")
 sqlString = "select * from ozellikler2 where ozelikid='"&strvidd&"' and tur='"&formidtur&"' order by id"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
valuefo=""
else
valuefo=mmmYardimci2("isim")
end if
close(mmmYardimci2)
                            %>
                            <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
                            <%collor="1"%>
                            <%else%>
                            <%collor="2"%>
                            <%end if%>
                            <tr class="icerik<%=collor%> icerik">
                                <td>
                                   <label> <%=formisim%></label>
                                    <%
                        if strvturr=1 then%>
                                    <input type="text" name="<%=strvnamee%>" id="<%=strvnamee%>" value="<%=valuefo%>" class="form-control" />
                                    <%elseif strvturr=2 then%>
                                    <input name="<%=strvnamee%>" type="hidden" value="<%=strvnamee%>" />
                                    <%elseif strvturr=3 or strvturr=13 or strvturr=12 then%>
                                    <textarea name="<%=strvnamee%>" rows="6" id="<%=strvnamee%>" class="normal form-control"><%=valuefo%></textarea>
                                    
                                    <%elseif strvturr=4 then%>
                                    <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&strvidd&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
formisim=mmmYardimci2("isim")%>
                                    <div style="width: 49%; float: left;">
                                        <input name="<%=strvnamee%>" type="checkbox" value="<%=formisim%>" <%if instr(valuefo,formisim) then%>checked<%else%><%end if%> />
                                        <%=formisim%>&nbsp;&nbsp;
                                    </div>
                                    <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
                                    %>
                                    <%elseif strvturr=5 then%>
                                    <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&strvidd&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
formisim=mmmYardimci2("isim")%>
                                    <input name="<%=strvnamee%>" type="radio" value="<%=formisim%>" />
                                    <%=formisim%>&nbsp;&nbsp;
                      <%
							  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
                      %>
                                    <%elseif strvturr=6 then
					   if strvidd="94" then
						session("valuefo")=valuefo
                                    %>
                                    <div id="sonuc"></div>
                                    <%else%>
                                    <select id="select4" size="1" name="<%=strvnamee%>" class="form-control">
                                        <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&strvidd&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
formisim=mmmYardimci2("isim")
formnamee=mmmYardimci2("name")
                                        %>
                                        <option value="<%=formnamee%>" <%if  valuefo=formnamee then%>selected<%else%><%end if%>><%=formisim%></option>
                                        <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
                                        %>
                                    </select>
                                    <%end if%>
                                    <%elseif strvturr=7 then
								  formurunid="f_"&strvidd&""&syaziid&""
								  lojik4=con.execute("select count(fid) as toplam4 from resimd where baslik='"&formurunid&"' ")
toplam4=lojik4("toplam4")
                                    %>
                                    <a href="?sayfa=galeri&redirect=1&baslik=<%=urunid%>&amp;dkate2=<%=dkate2%>&amp;sek=<%=dkate2*1%>" class="thumbnails">
                                        <img src="images/picture.gif" width="19" height="15" border="0" /></a><a href="?sayfa=galeri&redirect=1&baslik=f_<%=strvidd%><%=syaziid%>&dkate2=0&sek=0">Resim Ekle (<%=toplam4%>)</a>
                                    <%else%>
                                    <select id="Select12" size="1" onchange="return kategoriSec()" class="form-control" name="<%=strvnamee%>">
                                        <%
 sqlString = "select * from kategoriyazi where anasek='"&strvturr&"' order by sira"
set mmmSayfa1 = Con.Execute (sqlString)
if mmmSayfa1.eof then%>
                                        <%else
  for s = 0 to 100
if mmmSayfa1.eof then exit for
if session("yonet_dil")=240 then
formisim=mmmSayfa1("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmSayfa1("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
formisim="-"
else
formisim=mmmYardimci2("isim")
end if
close(mmmYardimci2)
end if
                                        %>
                                        <option value="<%=mmmSayfa1("id")%>" <%if  int(mmmSayfa1("id"))=int(valuefo) then%>selected<%else%><%end if%>><%=formisim%></option>
                                        <%
mmmSayfa1.movenext
Next
end if
close(mmmSayfa1)
                                        %>
                                    </select>
                                    <%end if%></td>
                            </tr>
                            <%
						  
mmmYardimci1.movenext
loop
end if
close(mmmYardimci1)

                            %>
                        </table>
                    </td>
                </tr>
                <%
                                end if
close(mmmYardimci)
                    end if%>
            </table>

            <%
                end if
                if stredittype="1" then
                            yazistr=syazi
                            if yazistr="" or isNull(yazistr) then
                            else
                      yazistrcnt=ubound(split(yazistr,"<"))
                      for ysc=1 to yazistrcnt
                      yazistrsi=split(yazistr,"<")(ysc)
                      elementi=split(yazistrsi,"</")(0)
                classstr=""
                      if instr(elementi,"=""") then
                      elementiv1=split(elementi," ")(0)
                if instr(elementi,"class") then
                classstr=" class="""&split(split(elementi,"class")(1),"""")(1)&""""
                else
                classstr=""
                end if
                      'ev2="data-json="""&replace(replace(replace(replace(split(elementi,">")(0),""" ","', "),"=",": "),"""","'"),""&elementiv1&" ","")&""""
                      ev2="data-"&replace(replace(split(elementi,">")(0),""" ",""" data-"),""&elementiv1&" ","")&""
                      ev3=split(elementi,">")(1)
                      etype=elementiv1

                      elseif instr(elementi,"/>") then
                      elementiv1=split(elementi,"/>")(0)
                      ev3=split(elementi,"/>")(1)
                      ev2=""
                      etype=elementiv1
                      
                      else
                      ev2=""
                      ev3=split(elementi,">")(1)
                      elementiv1=split(elementi,">")(0)  
                      etype=elementiv1                    
                      
                      end if

                                            
                      if instr(elementiv1,"/") then                
               if trim(ev3)="" or ev3=" " or len(trim(ev3))<3 or isNull(ev3) then
                      eolli="</div></div></ol></li>"
                else
                     eolli="</div></div></div></ol></li>"
                end if
                      else
                      if instr(elementiv1,"br") then
                      eolli=""
                      else
                      
                if trim(ev3)="" or ev3=" " or len(trim(ev3))<3 or isNull(ev3) then
                      eolli="<li data-type="""&etype&""" "&ev2&" "&classstr&"><ol><div class=""panel panel-default""><div class=""panel-heading""> <i class=""fa fa-arrows""></i>"&ev3&""
                     eolli=eolli&"<a href=""db.asp?islem=blocktab&blocktabcol=coledit&checked=c"&rowi&""&coli&"&checked1=col"&rowi&""&coli&"&blockstring="&datamoduljson&""" class=""dropdown-toggle coledit"" data-toggle=""modal"" data-target=""#moduladd"" style=""cursor: pointer;"" data-type="""&etype&""" "&ev2&"><em class=""fas fa-cog iconadmin"" style=""color: #39C;""></em></a>"
                     eolli=eolli&"<a href=""db.asp?islem=blocktab&blocktabcol=coledit&checked=c"&rowi&""&coli&"&checked1=col"&rowi&""&coli&"&blockstring="&datamoduljson&""" class=""dropdown-toggle coledit"" data-toggle=""modal"" data-target=""#moduladd"" style=""cursor: pointer;"" data-type="""&etype&""" "&ev2&"><em class=""fas fa-clone iconadmin"" style=""color: #e4b600;""></em></a></div>"
                     eolli=eolli&"<div class=""panel-body"">"&ev3&""
                else
                eolli="<li data-type="""&etype&""" "&ev2&"><ol> "
                      eolli=eolli&"<div class=""panel panel-default""><div class=""panel-heading""> <i class=""fa fa-arrows""></i>"
                     eolli=eolli&"<a href=""db.asp?islem=blocktab&blocktabcol=coledit&checked=c"&rowi&""&coli&"&checked1=col"&rowi&""&coli&"&blockstring="&datamoduljson&""" class=""dropdown-toggle coledit"" data-toggle=""modal"" data-target=""#moduladd"" style=""cursor: pointer;"" data-type="""&etype&""" "&ev2&"><em class=""fas fa-cog iconadmin"" style=""color: #39C;""></em></a>"
                     eolli=eolli&"<a href=""db.asp?islem=blocktab&blocktabcol=coledit&checked=c"&rowi&""&coli&"&checked1=col"&rowi&""&coli&"&blockstring="&datamoduljson&""" class=""dropdown-toggle coledit"" data-toggle=""modal"" data-target=""#moduladd"" style=""cursor: pointer;"" data-type="""&etype&""" "&ev2&"><em class=""fas fa-clone iconadmin"" style=""color: #e4b600;""></em></a></div>"
                     eolli=eolli&"<div class=""panel-body""><div class=""editable1"">"&ev3&""
                      end if

                      end if
                      end if

                      htmlelement= htmlelement&""&eolli

                      next
                            end if
                %>

            <style>
                .panel{margin-bottom:7px;}
                .panel-body{padding:2px;}
                .panel-heading{padding:5px 10px;}
                .block li ol{padding-left:0;}

            </style>
            <%
                      response.Write "<ol class=""block nested_with_switch vertical"">"&htmlelement&"</ol>"
              
            %>
            <input name="serializede" type="hidden" value="" id="serialize_outputhidden" />
    <%elseif stredittype="4" then%>
    <div class="sortpage">
    <ol style="padding:0px;background-color:#fff;" class="list list-icons list-primary list-borders ui-sortable1 vertical">
    <%
if instr(syazicode,"${rpt}") then
ocadetr=ubound(split(syazicode, "${rpt}"))
        rptstrbfr=split(syazicode, "${rpt}")(0)
         response.Write geteditstr(rptstrbfr,ocar) 
for ocar=1 to ocadetr
        ocarlist=ocarlist+1
        rptstr=split(split(syazicode, "${rpt}")(ocar), "${/rpt")(0)
        if ocarlist="1" then
        rptstr=rptstr
        %> 
        <li style="width:auto;" class="ui-state-default">
            <div class="form-group col-md-12">
                <textarea style="visibility:hidden;" name="rpttext"><%=rptstr %></textarea>
                <div class="input-group" style="margin-bottom:0px;">
                    <div class="input-group-btn" style="width:40px;">
        <input class="form-control" name="rptcnt" type="text" value="1"></div>
                <h2>&nbsp;&nbsp; adet Yeni Öğe Ekle&nbsp;</h2>
                <div class="input-group-btn">
                    <input type="submit" value="Ekle" name="Submit" class="btn btn-info" onclick=" formla7('sayfalar.asp?dkate2=979&sek=835&islem=duzenleyazi&duzenletype=yaziadvrptekle&lang=240');"/>
                </div> 
                    </div>
            </div>
        </li>
        <%end if %>
        <li id="rpt<%=ocar %>">
        <input type="hidden" value="1" name="rptd" id="rpt<%=ocar %>d" />
            <div class="form-group col-md-12">
                <div class="input-group" style="margin-bottom:0px;">
                <div class="input-group-btn">
                     <i class="btn btn-info fas fa-arrows-alt"></i>
                    <a href="#" class="" type="button" style="margin:0px 2px;" onclick="rptremove('rpt<%=ocar %>');">
                     <span class="btn btn-danger fa fa-trash"></span></a>
                </div>
                <h2><%=ocarlist %>. Öğe</h2>
                    </div>
            </div>
            <div class="oge">
                <%response.Write geteditstr(rptstr,ocar) %>

                </div>
        </li>
        <%
            'if ocar=ocadetr then
            rptstrftr=split(split(syazicode, "${rpt}")(ocar), "${/rpt")(1)
           'end if
        if instr(rptstrftr,"${edit}") then
           'ocarlist="0"
         response.Write geteditstr(rptstrftr,ocar)
            end if
        'response.Write rptclonestr
next
            
            else
response.Write geteditstr(syazicode,ocar)
        end if
        %>
        </ol><hr />
    </div>
            <input name="advcode" type="hidden" value="2" />

            <%elseif (strmodulmu="1" or urunidd="12" or urunidd="4" or urunidd="1") and stredittype="2" then
                if syazicode="" or isNull(syazicode) then
                syazicode=syazi
                else
                syazicode=syazicode
                end if
                yazistr=syazicode
                dosyauzanti="../"
                    if request.QueryString("bolme")="1" then
                yazistrcnt=ubound(split(yazistr,"<"))
                      for ysc=1 to yazistrcnt
                      yazistrsi=split(yazistr,"<")(ysc)
                      elementi=split(yazistrsi,"</")(0)
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))

                    if elementstr="" or len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    if instr(yazistrsi,"href=") then
                    hrefstrbas=split(yazistrsi,"href=""")(0)
                    hrefstrorta=split(split(yazistrsi,"href=""")(1),"""")(0)
                    hrefstrorta1="href="""&split(split(yazistrsi," href=""")(1),"""")(0)&""""
                if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi,"href=""""")(1)
                hrefkesmevar=""
                    else
                    'hrefstrson=split(yazistrsi,"href="""&hrefstrorta1)(1)
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                'response.Write hrefstrson&"<br>"
                    yazistrsi=""&hrefstrbas&" href=""${edit}"&hrefstrorta&"${/edit(link,#cnt#-"&ysc&")}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," alt=") then
                    hrefstrbas=split(yazistrsi," alt=""")(0)
                    hrefstrorta=split(split(yazistrsi," alt=""")(1),"""")(0)
                    hrefstrorta1="alt="""&split(split(yazistrsi," alt=""")(1),"""")(0)&""""
                    if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi,"alt=""""")(1)
                hrefkesmevar=""
                    else
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    'hrefstrson=split(yazistrsi,"alt="""&hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                    yazistrsi=""&hrefstrbas&" alt=""${edit}"&hrefstrorta&"${/edit(text,#cnt#-"&ysc&",Alt Tagi)}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi,"title=") then
                    hrefstrbas=split(yazistrsi,"title=""")(0)
                    hrefstrorta1="title="""&split(split(yazistrsi,"title=""")(1),"""")(0)&""""
                    hrefstrorta=split(split(yazistrsi,"title=""")(1),"""")(0)
                    if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi,"title=""""")(1)
                hrefkesmevar=""
                    else
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    'hrefstrson=split(yazistrsi,"title="""&hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                    yazistrsi=""&hrefstrbas&"title=""${edit}"&hrefstrorta&"${/edit(text,#cnt#-"&ysc&",Title Tagi)}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-thumb=") then
                    hrefstrbas=split(yazistrsi," data-thumb=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-thumb=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-thumb="""&hrefstrorta)(1)
                    yazistrsi=""&hrefstrbas&" data-thumb=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Thumb Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-image_src=") then
                    hrefstrbas=split(yazistrsi," data-image_src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-image_src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-image_src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-image_src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-src=") then
                    hrefstrbas=split(yazistrsi," data-src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-image-src=") then
                    hrefstrbas=split(yazistrsi," data-image-src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-image-src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-image-src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-image-src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-background_image_src=") then
                    hrefstrbas=split(yazistrsi," data-background_image_src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-background_image_src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-background_image_src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-background_image_src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-background=") then
                    hrefstrbas=split(yazistrsi," data-background=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-background=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-background="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-background=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",data-background Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi,"background-image: url") or instr(yazistrsi,"background-image:url") then
                    hrefstrbas=split(yazistrsi,"background-image:")(0)
                    if instr(yazistrsi,"background-image: url") then
                    hrefstrorta1="url("&split(split(yazistrsi,"background-image: url(")(1),")")(0)&")"
                    hrefstrorta=split(split(yazistrsi,"background-image: url(")(1),")")(0)
                else
                    hrefstrorta1="url("&split(split(yazistrsi,"background-image:url(")(1),")")(0)&")"
                    hrefstrorta=split(split(yazistrsi,"background-image:url(")(1),")")(0)
                end if
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                'response.Write hrefstrson&"<br>"
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&"background-image: url(${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Arka Zemin Resmi)})"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," src=") then
                    hrefstrbas=split(yazistrsi," src=""")(0)
                    hrefstrorta=split(split(yazistrsi," src=""")(1),"""")(0)
                    hrefstrorta1="src="""&split(split(yazistrsi," src=""")(1),"""")(0)&""""
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&")}"""&hrefstrson
                    cnt=cnt+1
                    end if
                    if cnt="1" then
                    cntstr="12"
                    elseif cnt="2" then
                    cntstr="6"
                    elseif cnt="3" then
                    cntstr="4"
                    elseif cnt="4" then
                    cntstr="3"
                    else
                    cntstr="2"
                    end if
                    ev3="<"&replace(yazistrsi,"#cnt#",cntstr)
    
                    else
                      ev3="<"&split(elementi,">")(0)&">${edit}"&elementstr&"${/edit(text,6-"&ysc&")}"
                    
                    if instr(ev3,"href=") then
                    hrefstrbas=split(ev3,"href=""")(0)
                    hrefstrorta=split(split(ev3,"href=""")(1),"""")(0)
                    hrefstrson=split(ev3,hrefstrorta)(1)
                    ev3=""&hrefstrbas&"href=""${edit}"&hrefstrorta&"${/edit(link,6-"&ysc&")}"&hrefstrson
                    else
                    ev3=replace(ev3,"edit(text,6","edit(text,12")
                    end if

                    end if
                    'response.Write yazistrsi&"<br>"
                    sablonnew=sablonnew&ev3
                      if instr(elementi,"=""") then
                      elementiv1=split(elementi," ")(0)
                      'ev2="data-json="""&replace(replace(replace(replace(split(elementi,">")(0),""" ","', "),"=",": "),"""","'"),""&elementiv1&" ","")&""""
                      ev2="data-"&replace(replace(split(elementi,">")(0),""" ",""" data-"),""&elementiv1&" ","")&""
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      etype=elementiv1

                      elseif instr(elementi,"/>") then
                      elementiv1=split(elementi,"/>")(0)
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(elementstr,"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      ev2=""
                      etype=elementiv1
                      
                      else
                      ev2=""
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      elementiv1=split(elementi,">")(0)  
                      etype=elementiv1                    
                      
                      end if

                                            
                      if instr(elementiv1,"/") then
                      eolli="</ol></li>"
                      else
                      if instr(elementiv1,"br") then
                      eolli=""
                      else
                      eolli="<li data-type="""&etype&""""&ev2&"><ol>"&ev3&""
                      end if
                      end if

                      htmlelement= htmlelement&""&eolli
                    cnt="0"
                      next
               syazicode= sablonnew
                end if
                %>
            <!--#Include file="codeeditor.html"-->

        
            <input name="advcode" type="hidden" value="1" />
            <textarea name="myTextarea" id="beautified6" style="width: 100%; height: 50vh;" class="form-control"><%=replace(replace(replace(syazicode&" ","`","'"),"</textarea>","[/textarea]"),"&#","&+#")%></textarea>
            <div class="handle"></div>
            <script>
                window.addEventListener('DOMContentLoaded', ()=>{                        
                format25("6", "text/html", <%=aits%>, ['translate_text','rewrite_html_seo'], true, this);
                });
            </script>
            <%else %>
            <textarea rows="30" name="myTextarea" id="myTextarea" style="width: 100%;" class="normal form-control"><%=replace(syazi&" ","`","'")%></textarea>
            <div class="inlineeditor" style="margin-top:5px;"><%=syaziasds%></div>

            <%end if %>
      <%if strmodulmu="1" then 
        else
        %>
            <table class="table table-striped">
                <%if urunidd="9" or urunidd="4" or urunidd="1" or urunidd="12" then%>
                <tr>
                    <td><label>Özet :</label>

                        <textarea name="descri" cols="25" id="descri" class="form-control shortn"><%=strkisadesc%></textarea></td>
                </tr>
                </table>
    <div class="col-sm-12 form-group">
                            
                            <label class="control-label" for="tour_name">Yayınlanacağı Diller <span  class="yayinlang"></span>:<span class="required">*</span></label>
                                 
                                         <select name="yayinlang" id="yayinlang" multiple class="selectmultrmv">
           
              <%
                  if yayinlang="" or isNull(yayinlang) then
                  yayinlang="0"
                  end if
sqlString = "select * from diller1 where alt = '1' and sira='1' ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF

          
%>
              <option value="<%=mmmGenel("id")%>"  <% if instr(yayinlang,mmmGenel("id")) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
            </select>
                             
                        </div>
                <%else%>
                <%end if%>
                <%end if%>

            <div class="col-md-12">

                <div class="btn-group pull-right dropup" style="margin-top: 10px;">
                    <input type="submit" value="<%=submitbuton %>" name="Submit" class="btn btn-info" onclick=" formla7('<%=submitlink %>');"/>
                    <button type="button" class="btn btn-info dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <span class=" fa fa-arrow-down"></span>
                    </button>
                    <div class="dropdown-menu">

                <input type="submit" value="<%=submitbuton %>" name="Submit" class="btn btn-info col" style=" width: 100%; " onclick=" formla7('<%=submitlink %>');"/>
                        <%if submitbutona="" then
                        else%>
                        <input type="submit" value="<%=submitbutona %>" name="Submit" class="btn btn-info col" style=" width: 100%; " onclick=" formla7('<%=submitlink %>&redirect=1');"/>
                    <%end if %>
                    
                      <div class="dropdown-divider"></div>
                      <%if kopyalink="" then
                    else%>
                <input type="submit" value="Farklı Kaydet" name="Submit" class="btn btn-warning col" style=" width: 100%; " onclick=" formla7('<%=kopyalink %>');"/>
    <%end if %>
                    </div>
                  </div>

               </div>
                  </div>
            <%
                if request.QueryString("yazi")="yeni" then
                else
			if strmodulmu="1" or urunidd="12" then
            else
            %>                  
                  <div id="sablon" class="tab-pane fade">
            <script language="javascript">

                function disable_ilksayfa1(checked) {

                    document.getElementById("ilksayfa1").disabled = checked;
                }
            </script>

            <label>
                <input name="ozeltemp" type="hidden" value="0" id="ilksayfa1" <%if stemptur = "" or  stemptur = "99999" or isNull(stemptur) Then%><%else%>disabled<%end if%>>
                <input name="ozeltemp" type="checkbox" id="ilksayfaa1" value="1" <%if stemptur = "" or  stemptur = "99999" or isNull(stemptur) Then%><%else%>checked<%end if%> onclick="disable_ilksayfa1(this.checked); toggleDiv('accordion', this.checked);">Özel Temp Oluştur</label>
            <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true" <%if stemptur = "" or stemptur = "99999" or isNull(stemptur) Then%>style="display:none;" <%else%><%end if%>>
                <div class="panel">
                    <a class="btn btn-info" role="tab" id="headingOne" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        <h4 class="panel-title">Sayfa Şablonu <span class="caret"></span></h4>
                    </a>
                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <%sayfatemptur="1"%>
                            <!--#Include file="ortak_template.asp"-->
                        </div>
                    </div>
                </div>
            </div>
            </div>

            <%end if%>
            <%end if%>
                    <%if request("modul")=1 or strmodulmu="1" or urunidd="12" then%>
                  <div id="css" class="tab-pane fade">
                        <%
										 strsi8=bilgi1
                        %>
                        <input type="hidden" name="listecss" id="checkbox" value="1" />
                        <textarea id="beautifiedcss" name="csstam" rows="7"><%=strsi8%></textarea>
            <div class="col-md-12"><input type="submit" value="<%=submitbuton %>" name="submit2" class="btn btn-info pull-right"  onclick="formla7('<%=submitlink%>');" /></div>
                    </div>
                  <%if (strmodulmu="1" or urunidd="12") and stredittype="2" then
                      else%>
                  <!--#Include file="codeeditor.html"-->
                  <%end if %>
                    <%else%>
                    <%end if%>

            <%
                if request.QueryString("yazi")="yeni" then
                else
			if strmodulmu="1" or urunidd="12" or urunidd="7" or urunidd="1"  then
else
                    %>

        <div id="seo" class="tab-pane fade">
    
     <%strisim=syazib
     smidsayara=syaziid
     call seoserp(syaziid,"yazi",ceviridileki,aktifdil,"?urunid="&request("urunid")&"&dkate2="&dkate2&"&sayfaayar="&request("sayfaayar")&"&Submit=sayfatumDuzenle&seoturu=yazi&dil="&langstr&"")%> 
                       <!--#Include file="codeeditor.html"-->

            </div>
                    <%end if
                        end if%>
        </div>
        </form>
        <%if request.QueryString("yazi")<>"yeni" and strmodulmu<>"1" and request.QueryString("urunid")<>"" then %>
        <div class="content_gallery">

            <hr>
            <div class="x_title"><h2>Galeri</h2>&nbsp;&nbsp;
    
            <div class="clearfix"></div></div>
            
                 <%fldr="galeri"
                
                 glrurl="?sayfa=galeri&redirect=1&sek="&request.QueryString("sek")&"&sayi="&Sayilar&"&dkate2="&request.QueryString("dkate2")&"&baslik="&request.QueryString("urunid")&"&tur="&request("urunid")+0&"&modul="&request("modul")&"&modulv="&request("modulv")&"&yazi="&request("yazi")&"&islem=resimekle"

                %>
            <%call glradd(fldr,glrurl) %>
            
            <hr>
            <%
            
            Set mmmYardimci = Server.CreateObject("ADODB.Recordset")
            sqlString = "select * from resimd where baslik='"&request.QueryString("urunid")&"' order by firma, fid"
            mmmYardimci.ActiveConnection = Con
            mmmYardimci.Open sqlString,Con,1,3
            %>
              <%if mmmYardimci.eof then%>
            
              <%else%>
            
                                 <form name="custlist" method="post"  action="?sayfa=galeri&redirect=1&baslik=<%=request.QueryString("urunid")%>&dkate2=<%=request.QueryString("dkate2")%>&tur=<%=mmmYardimci("fid")%>">
                                  
              <div class="pull-right" style="height: 34px;padding: 7px 7px 7px 7px; background:#ebebeb; border:1px solid #d9534f; border-radius: 3px;" data-toggle="tooltip" data-placement="top" title="" data-original-title="Hepsini Seç">
                        <input type="checkbox" name="resimid1" class="flatred" id="checkAll">
                  </div>                       
            <input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("urunid")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil');">
            
                  <input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("urunid")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=resimDuzenle');">
            <div style="clear:both; float:none;"></div>
            <div class="sortpage">
                <ol class="ui-sortable1 vertical">
               <%
               Set mmmGenel = Server.CreateObject("ADODB.Recordset")
            sqlString = "select * from resimd where baslik='"&request.QueryString("urunid")&"' order by firma, fid"
            mmmGenel.ActiveConnection = Con
            mmmGenel.Open sqlString,Con,1,3
            Do While Not mmmGenel.EOF
            iks=iks+1
            %>
            <li class="ui-state-default">
                   <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
                    <%collor="1"%>
                    <%else%>
                    <%collor="2"%>
                    <%end if%>
                    <div class="icerik<%=collor%> icerik">
            <div class="col-md-12 galerigrid">
            
                                      <div class="col-md-2">
                                      <div class="row">
                                      <div class="col-sm-2"><span class="handle ui-sortable-handle">
                                    <i class="fa fa-arrows"></i>
                                  </span></div>
                                      <div class="image view view-first col-md-5" align="center" <%if mmmGenel("tur")=1 then%>style="border-left:3px solid #c00;border-right:3px solid #c00; width:auto;"<%else%><%end if%>>
                                        <img height="40px" style="display: block;" src="<%=imgyol%><%=mmmGenel("dosyad")%>" alt="<%=mmmGenel("resad")%>" />
                                        </div>
                                        </div>
                                      </div>
                                      <div class="col-md-9">
                                      <div class="row">
                                      <div class="col-md-3">
                                        <p><input name="ad2" type="text" id="ad2" value="<%=mmmGenel("resad")%>" class="form-control" placeholder="Resim Adi"></p></div>
                                        <div class="col-md-4"> 
                                            <div class="input-group">
                  <input class="form-control" id="fieldID<%=iks %>" aria-multiselectable="true" type="text" name="link" value="<%=mmmGenel("link")%>" placeholder="Harici Link">
                  <div class="input-group-btn">
                     <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID<%=iks %>&multiple=0<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Dosya Seç</a>
                      </div>
                </div>
            <style>
                .modal-dialog {
              width: 100%;
              height: 100%;
              margin: 0;
              padding: 0;
            }
            
            .modal-content {
              height: auto;
              min-height: 100%;
              border-radius: 0;
            }
            </style>
                  <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title"></h4>
                </div>
                
                <div class="modal-body" style="padding:0px; margin:0px; width: 100%;">
                  <iframe width="100%" height="500" src="" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>
                </div>
              </div><!-- /.modal-content&fldr=/ceimages/flayers/file -->
            </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            
                                        </div>
                                        <div class="col-md-5">
                                        <p><textarea name="acik" id="acik" rows="1" class="form-control" placeholder="Kisa A&ccedil;iklama"><%=mmmGenel("acik")%></textarea></p>
                                        </div>
                                        </div>
                                      </div>
                                      <div class="col-md-1 tools tools-bottom">
                      
                                            <%if mmmGenel("tur")=0 then%>
                    <a href="?sayfa=galeri&redirect=1&islem=resimonay&baslik=<%=request.QueryString("urunid")%>&id=<%=mmmGenel("fid")%>&ilk=1&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-success pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="İlk Resim Değil"><i class="fab fa-star" style="font-size:11px;"></i></a>
                    <%else%>
              <a href="?sayfa=galeri&redirect=1&islem=resimonay&baslik=<%=request.QueryString("urunid")%>&id=<%=mmmGenel("fid")%>&ilk=0&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-success pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="İlk Resim"><i class="fa fa-star" style="font-size:11px;"></i></a>
              <%end if%>     
                   <%if mmmGenel("type")=1 then%>
                 <a href="?sayfa=galeri&redirect=1&islem=resimonay2&baslik=<%=request.QueryString("urunid")%>&id=<%=mmmGenel("fid")%>&ilk=0&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-primary pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="Büyük Resim"><i class="fa fa-toggle-on" style="font-size:11px;"></i></a>
                    <%else%>
             <a href="?sayfa=galeri&redirect=1&islem=resimonay2&baslik=<%=request.QueryString("urunid")%>&id=<%=mmmGenel("fid")%>&ilk=1&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-primary pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="Büyük Resim Değil"><i class="fa fa-toggle-off" style="font-size:11px;"></i></a>
              <%end if%>
              <input name="rid" type="hidden" id="resimid" value="<%=mmmGenel("fid")%>" />
              
                    <div class="pull-right" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil">
                        <input type="checkbox" name="resimid" class="flatred" id="resimid<%=iks%>" value="<%=mmmGenel("fid")%>">
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
               <div style="clear:left;"></div> <hr />
            <input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("urunid")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil');">
                                      <%if yetkiuye="1" then %>
             <input name="Submit" type="submit" id="Submit" value="Tam Sil" class="btn btn-danger pull-left" ONCLICK="this.form.submit(); formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("urunid")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil&resimdosyasil=1');">
                                     <%end if %>
            <input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("urunid")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=resimDuzenle');">
            <% 
               close(mmmGenel)
              %>
            
                                   </form>
            <SCRIPT LANGUAGE="JavaScript">
            
                function formla(gelen)
                {
                document.custlist.action=gelen;
                document.custlist.submit();
                }
              //-->
              </SCRIPT>
                                 
             <% end if
              close(mmmYardimci)
              %>
            
            </div>
            <%end if%>
    </div>

    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>

                <div class="modal-body" style="padding: 0px; margin: 0px; width: 100%;">
                    <iframe width="100%" height="500" src="" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll;"></iframe>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
 <SCRIPT LANGUAGE="JavaScript">

     function formla7(gelen7) {
         document.custlist17.action = gelen7;
         document.custlist17.submit();
     }
  //-->
  </SCRIPT>

    <%call footer(1)%>
    <%if stredittype="1" then%>
            
<div id="moduladd" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Yükleniyor</h4>
                        </div>

						<div class="modal-body with-padding">
							
						</div>

						<div class="modal-footer">
							<button class="btn btn-warning" data-dismiss="modal">Close</button>
							<button class="btn btn-primary">Save</button>
						</div>
					</div>
				</div>
			</div>

    <%end if %>
    <script>
        
    $('.datetimepicker12').datetimepicker({
        sideBySide: true,
        format:"YYYY-MM-DD hh:mm"
});

     $(document).ready(function() {
  $(".iframe-btn").click(function(e) {
    e.preventDefault();
    var url = $(this).attr("data-href");
    $("#myModal iframe").attr("src", url);
  });
});
    </script>
    <script>
    
    function updatedatajson(jsond,jsonmodid)
    {
    var jsonStringdata = JSON.stringify(jsond, null, ' ');
    $('#'+jsonmodid+'').attr('data-json', jsonStringdata).data('json', ''+jsond+'');
    }

function divremove(checked)
	{
		var data3=document.getElementById(checked);
		data3.remove();
		updateserialize();
	}
	function mdetailjs(checked)
	{
		var data4=document.getElementById(checked);
    $( data4 ).toggleClass( "moduldv", 1000 );	
	}

    function btn3(checked,checked1)
	{
	var ollicount=$('li[data-id^="col"]').length+1;    
    getajaxstr('blocktab','addcolumn',"&blockstring=" + ollicount+"&checked=" + checked+"&checked1=" + checked1+"",'',function (response) {
    var strblock=response;    
    $("ol#"+checked1+"").append(strblock);
	updateserialize();
});
	updateserialize();
    }
    	
    function btn4(checked,checked1)
	{
	var ollicount=$('ol#'+checked1+' > li').length+1;      
    getajaxstr('blocktab','addmodul',"&blockstring=" + ollicount+"&checked=" + checked+"&checked1=" + checked1+"",'',function (response) {
    var strblock=response;    
    $("ol#"+checked1+"").append(strblock);
	updateserialize();
});
	updateserialize();
    }
$('.selectmultrmv').selectize({
    plugins: ['remove_button'],
    delimiter: ',',
    persist: false,
    create: function(input) {
        return {
            value: input,
            text: input
        }
    }
});

function colchange(checked,checked1)
 {
		var data2=document.getElementById(checked1);
		var data=data2.className;
		$(data2).removeClass(data);
        var data1=document.getElementById(checked);
        var multipleValues = $( data1 ).val() || [];
        $(data2).addClass(multipleValues);
    
    $('#'+checked1+'').attr('data-colmd', multipleValues).data('colmd', multipleValues);
		updateserialize();
 }    

function contchange(checked,checked1)
 {
		var data2=document.getElementById(checked1);
        var data1=document.getElementById(checked);
        var multipleValues = $( data1 ).val() || [];
        $(data2).addClass(multipleValues);
    
    $('#'+checked1+'').attr('data-cont', multipleValues).data('cont', multipleValues);
		updateserialize();
 }

function confirmSubmit(caller) {
  var form = caller.parents("form");
  jConfirm('Are you sure?', 'Please Confirm', function(result){
    if (result) {
      form.submit();
    } else {
      return false;
    }
  });
}

    </script>
    <script>

   <%if stredittype="1" then %> 
var group = $("ol.nested_with_switch > li > ol > li > ol").sortable({
  handle: 'i.fa-arrows',
  nested: false,
  delay: 500,
  group: 'columnParent2', 
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});
var group = $("ol.nested_with_switch > li > ol").sortable({
  handle: 'i.fa-arrows',
  nested: false,
  delay: 500,
  group: 'columnParent', 
  isValidTarget: function  ($item, container) {
    if($item.is(".columnParent > li"))	
      return true;	 
    else
      return $item.parent("ol")[0] == container.el[0];
  },
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	 
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});

var group = $("ol.nested_with_switch").sortable({
  handle: 'i.fa-arrows',
  nested: false,
  delay: 500,
  group: 'nested_with_switch', 
  isValidTarget: function  ($item, container) {
    if($item.is(".nested_with_switch > li"))	
      return true;	 
    else
      return $item.parent("ol")[0] == container.el[0];
  },
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	 
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});
function updateserialize(){
   var groups = $("ol.nested_with_switch").sortable("refresh");
	var data = groups.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

	document.getElementById("serialize_outputhidden").value = jsonString;

	}


    function showSerialize(checked,checked1) {
        var fields = $( 'table#'+checked+' :input' ).serializeArray();
    console.log(fields);
        var jsonStringdata = JSON.stringify(fields);
    console.log(jsonStringdata);

        //foroldjson

            var modid=$( 'table#'+checked+' input[name=mid]' ).val();
            var strmsbaslik=$( 'table#'+checked+' input[name=baslik]' ).val();
            var strmssayfa=$( 'table#'+checked+' *[name=sayfa]' ).find(":selected").val();
            var strmsmodulid=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").val();
            var strmsmodulname=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").text();
            var strmstemp=$( 'table#'+checked+' *[name=temp]' ).find(":selected").val();
            var strmsgoster=$( 'table#'+checked+' *[name=goster]' ).val();
            var strmsonay=$( 'table#'+checked+' *[name=yetki]' ).find(":selected").val();
            var strmsmdurum=$( 'table#'+checked+' input[name=moduldurumu]' ).val();
            var strmsozel=$( 'table#'+checked+' input[name=sayfaozel]' ).val();
            var strmsozelvar=$( 'table#'+checked+' *[name=sayfaozelvar]' ).find(":selected").val();
            var jsonold=''+modid+','+strmsbaslik+','+strmssayfa+','+strmsmodulid+','+strmstemp+','+strmsgoster+','+strmsonay+','+strmsmdurum+','+strmsozel+','+strmsozelvar+''

        //fornewjson
            $('#'+checked1+'').attr('data-json', jsonStringdata).data('json', fields);
            $('#'+checked1+'').attr('data-jsonold', jsonold).data('jsonold', jsonold);
            $('#'+checked1+' .modulTitle').html('<i class="fa fa-arrows"></i> '+strmsbaslik+' ('+strmsmodulname+')');
            $('#'+checked1+' .modulHead a.moduledit').attr("href", 'db.asp?islem=blocktab&blocktabcol=editmodul&checked='+checked+'&checked1='+checked1+'&blockstring='+jsonold+'');

            //$.each(fields, function(i, field){
            //$('#'+checked1+'').attr('data-'+field.name+'', field.value).data(''+field.name+'', field.value);
            //});
            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    }
    function rowshowSerialize(checked,checked1) {
        //var fields = $( 'table#'+checked+' :input' ).serializeArray();
        //var jsonStringdata = JSON.stringify(fields);
    
            var elid=$( 'table#'+checked+' :input[name="elid"]' ).val();
            //var eltype=$( 'table#'+checked+' :input[name="eltype"]' ).val();
            var elcss=$( 'table#'+checked+' :input[name="elcss"]' ).val();
            var elstyle=$( 'table#'+checked+' :input[name="elstyle"]' ).val();
            var elother=$( 'table#'+checked+' :input[name="elother"]' ).val();
            var elcont=$( 'table#'+checked+' #elcont option:selected' ).val();
            var rowtype=$( 'table#'+checked+' #eltype option:selected' ).val();
    console.log(elcont);
    console.log(rowtype);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elid', elid).data('elid', elid);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elcss', elcss).data('elcss', elcss);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elstyle', elstyle).data('elstyle', elstyle);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elother', elother).data('elother', elother);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-cont', elcont).data('cont', elcont);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-type', rowtype).data('type', rowtype);

            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    }
    function colshowSerialize(checked,checked1) {
        //var fields = $( 'table#'+checked+' :input' ).serializeArray();
        //var jsonStringdata = JSON.stringify(fields);
    
            var elid=$( 'table#'+checked+' :input[name="elid"]' ).val();
            //var eltype=$( 'table#'+checked+' :input[name="eltype"]' ).val();
            var elcss=$( 'table#'+checked+' :input[name="elcss"]' ).val();
            var elstyle=$( 'table#'+checked+' :input[name="elstyle"]' ).val();
            var elother=$( 'table#'+checked+' :input[name="elother"]' ).val();
            var coltype=$( 'table#'+checked+' #coltype option:selected' ).val();
            var colsmtype=$( 'table#'+checked+' #colsmtype option:selected' ).val();
            var colmdtype=$( 'table#'+checked+' #colmdtype option:selected' ).val();
            var collgtype=$( 'table#'+checked+' #collgtype option:selected' ).val();
            var colxltype=$( 'table#'+checked+' #colxltype option:selected' ).val();

            $('#'+checked+', #'+checked+' a.coledit').attr('data-elid', elid).data('elid', elid);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-elcss', elcss).data('elcss', elcss);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-elstyle', elstyle).data('elstyle', elstyle);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-elother', elother).data('elother', elother);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-coltype', coltype).data('coltype', coltype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colsmtype', colsmtype).data('colsmtype', colsmtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colmdtype', colmdtype).data('colmdtype', colmdtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-collgtype', collgtype).data('collgtype', collgtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colxltype', colxltype).data('colxltype', colxltype);

            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    }
		 
    $(document).ready(function () {
    $("#btn2").click(function(){
	var ollicount=$('ol.nested_with_switch > li').length+1;
    getajaxstr('blocktab','addrow',"&blockstring=" + ollicount,'',function (response) {
    var strblock=response;    
    $("ol.nested_with_switch").append(strblock);
	updateserialize();
});
    
    });
updateserialize();
    });
    
    function getajaxstr(islem,sonuc,qry1,qry2,callback) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
   callback(this.responseText);
    }
  };
  xhttp.open("GET", "db.asp?islem=" + islem+"&blocktabcol=" + sonuc+"" + qry1+"" + qry2+"", true);
  xhttp.send();
}
    

    var formatId;
$('#moduladd').on('show.bs.modal', function (event) {

    if (formatId) {
        window.clearTimeout(formatId);
    }
    formatId = window.setTimeout(function () {
  var button = $(event.relatedTarget)
        console.log(button.data.length);
        var attrs = button;
        $.each(attrs,function(i,elem){
        console.log(elem.name);
    //$("#attrs").html(    $("#attrs").html()+"<br><b>"+elem.name+"</b>:<i>"+elem.value+"</i>");
  });

  var modaleltype = button.data('eltype')

  var elid = button.data('elid')
  var elcss = button.data('class')
  var elstyle = button.data('elstyle')
  var elother = button.data('elother')
  var elcont = button.data('cont')
  var eltype = button.data('type')
        
  var modal = $('#moduladd')
  modal.find('.modal-body input[name="elid"]').val(elid)
  modal.find('.modal-body input[name="elcss"]').val(elcss)
  modal.find('.modal-body input[name="elstyle"]').val(elstyle)
  modal.find('.modal-body input[name="elother"]').val(elother)
  modal.find('.modal-body select[name="cont"]').val(elcont)
  modal.find('.modal-body select[name="eltype"]').val(eltype)

    
        formatId = undefined;
    }, 420);
})
        <%end if %>
         function rptremove(checked)
	{
            var rptdstr=checked+'d'
		var data3=document.getElementById(checked);
		//data3.remove();        
    $('#'+checked+' .oge').attr('style', 'display:none;');
    $('#'+checked+'').append('<div class="form-group col-md-12 ogealert"><span class="alert alert-danger">Öğe Silinecek</span></div>');
            document.getElementById(rptdstr).value = '0';
	}
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
    </script>


