<!--#Include file="admin_menu1.asp"-->

<%kateid=request.QueryString("urunid")
dim so(14),sou(14),sl(14),slu(14)%>
<div class="right_col" role="main">
    <div class="x_panel">


        <%
' if request("dkate2")="" 
' adres='"&request("dkate2")&"'
 sqlString = "select * from kategoriayar where id="&kateid&" order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
        <table class="table table-striped">
            <form name="form1" method="post" action="?islem=eklesayfatur&urunid=<%=request("urunid")%>">
                <%if request("adres")="" then%>
                <input name="dkate2" type="hidden" value="11111111" />
                <%else%>
                <input name="dkate2" type="hidden" value="<%=request("adres")%>" />
                <%end if%>
                <tr>
                    <td width="18%">Listeleme Adı</td>
                    <td width="30%">
                        <input name="sektor" type="text" id="sektor" /></td>
                    <td width="18%">Listeleme Template</td>
                    <td width="30%">
                        <select name="turu" size="1" id="turu" class="form-control">
                            <option value="90">Boş Ayar</option>
                            <option value="999999" disabled="disabled" style="background-color: #CCC;">Template</option>
                            <%
 sqlString = "select * from kategoriayar where adres = '11111111' order by id desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF%>
                            <option value="<%=mmmYardimci("id")%>"><%=mmmYardimci("kate")%></option>
                            <%mmmYardimci.MoveNext
  loop
  close(mmmYardimci)
                            %>
                            <option value="999999" disabled="disabled" style="background-color: #CCC;">Oluşturulmuşlar</option>
                            <%
 sqlString = "select * from kategoriayar where adres <> '11111111' order by id desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF%>
                            <option value="<%=mmmYardimci("id")%>"><%=mmmYardimci("kate")%></option>
                            <%mmmYardimci.MoveNext
  loop
  close(mmmYardimci)
                            %>
                        </select></td>
                    <td width="6%">
                        <input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right" /></td>
                </tr>
            </form>
        </table>
        <%
else
temp=mmmGenel("l1")
strsid=mmmGenel("id")
strsr2=replace(mmmGenel("r2"),"`","'")
strsr3=mmmGenel("r3")
strsr4=mmmGenel("r4")
strsr5=mmmGenel("r5")
strsr6=replace(mmmGenel("r6"),"`","'")
strsl1=mmmGenel("l1")
strsl2=mmmGenel("l2")
strsl3=mmmGenel("l3")
strsl4=mmmGenel("l4")
strsl6=mmmGenel("l6")
strsl9=mmmGenel("l9")
strsl10=mmmGenel("l10")
strsi1=mmmGenel("i1")
strsi2=mmmGenel("i2")
strsi3=mmmGenel("i3")
strsi4=mmmGenel("i4")
strsi5=mmmGenel("i5")
strsi6=mmmGenel("i6")
strsi7=mmmGenel("i7")
strsi8=mmmGenel("i8")
strskate=mmmGenel("kate")
strsbilgi1=mmmGenel("bilgi1")
strsbilgi1i=mmmGenel("bilgi1i")
strsbilgi2=mmmGenel("bilgi2")
strsbilgi2i=mmmGenel("bilgi2i")
strsbilgi3=mmmGenel("bilgi3")
strsbilgi3i=mmmGenel("bilgi3i")
strsbilgi4=mmmGenel("bilgi4")
strsbilgi4i=mmmGenel("bilgi4i")
strskate1=mmmGenel("kate1")
strsadres=mmmGenel("adres")
stempturrepeat=replace(strsi3,"`","'")
stemptur=replace(strsi1,"`","'")
stemptur1=replace(strsi5,"`","'")
if strsadres="" then
  strsadres="0"
  else
  end if%>
   
   <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#ayarlar">Sayfa Diğer Ayarlar</a></li>     
    <li><a data-toggle="tab" href="#script" id="headingjs" onclick='format("js","javascript", this)'>Sayfa Script</a></li>
    <li><a data-toggle="tab" href="#listesablon" id="headinglistes1" onclick='format("listes","text/html", this);format("listes1","text/html", this);'>Sayfa Liste Şablonu</a></li>
                    <%if strskate1="1" or strskate1="3" then
			  else%>
    <li><a data-toggle="tab" href="#resimsablon" id="headingresim1a" onclick='format("resim","text/html", this);format("resim1","text/html", this);'>Sayfa Resim Galerisi Şablonu</a></li>
    <li><a data-toggle="tab" id="headinghtml" onclick='format("html","text/html", this);' href="#sablon">Sayfa Şablonu</a></li>
       <%end if %>
    <li><a data-toggle="tab" href="#css">Sayfa Css</a></li>
  </ul>
        <form method="post" name="custlist12" id="Form1" action="?" target="_self">
            <div class="tab-content">
            <input name="urunid" type="hidden" value="<%=strsid%>" />
               <div id="ayarlar" class="tab-pane fade in active">
                            <table class="table table-striped">
                                <tr class="icerik1 icerik">
                                    <td>Listeleme Adı</td>
                                    <td colspan="3">
                                        <input name="ad" type="text" id="sayfaadi" value="<%=strskate%>" class="form-control" />
                            <%if strsadres="" or strsadres="0" then%><%else%><a href="sayfalar.asp?urunid=<%=request("urunid")%>&dkate2=<% =strsadres%>&id=<%=strsid%>&yer=<% =yer%>&sayfaayar=<%=request("sayfaayar")%>&islem=silsayfaturtek" class="btn btn-danger pull-right">Temizle</a><%end if%>
                                    </td>
                                </tr>
                                <tr class="icerik2 icerik">
                                    <td>Kategori</td>
                                    <td>
                                        <div align="left">
                                            <select name="iceriktur" class="form-control" id="i">
                                                <%for each xarr in arrcsskategori
										 xarr=xarr-1%>
                                                <option value="<%=arrcsskategori(xarr)%>" <%if ""&arrcsskategori(xarr)&""=""&strskate1&"" then%>selected<%else%><%end if%>><%=arrcsskategoribaslik(xarr)%></option>
                                                <%next%>
                                            </select>
                                        </div>
                                    </td>
                                    <td style="text-align:right;">Yeri</td>
                                    <td>
                                        <select name="adres" class="form-control" id="i3">
                                            <option value="0" <%if "0"=""&strsadres&"" then%>selected<%else%><%end if%>>Sitede</option>
                                            <option value="1" <%if "1"=""&strsadres&"" then%>selected<%else%><%end if%>>Kütüphanede</option>
                                        </select></td>
                                </tr>

                                <%if strskate1="3" then%>
                                <tr class="icerik2 icerik">
                                    <td>Listeleme Sütün Adedi :</td>
                                    <td>
                                        <select name="i6" class="form-control" id="i6">
                                            <option value="12" <%if strsi6="12" then%>selected<%else%><%end if%>>Tek</option>
                                            <option value="6" <%if strsi6="6" then%>selected<%else%><%end if%>>2 li</option>
                                            <option value="4" <%if strsi6="4" then%>selected<%else%><%end if%>>3 lü</option>
                                            <option value="3" <%if strsi6="3" then%>selected<%else%><%end if%>>4 lü</option>
                                            <option value="2" <%if strsi6="2" then%>selected<%else%><%end if%>>6 lı</option>
                                            <option value="1" <%if strsi6="1" then%>selected<%else%><%end if%>>12 li</option>
                                        </select>
                                        <input name="i2" type="hidden" id="i2" value="0" size="15" /></td>
                              
                                    <td style="text-align:right;">Listeleme Toplam Sayısı :</td>
                                    <td>
                                        <input name="bilgi1i" type="text" class="form-control" id="bilgi1" value="<%=strsbilgi1i%>" size="15" /></td>
                                </tr>
                                <%else%>
                                <%end if%>

                                <%if strskate1="2" then%>
                                <tr class="icerik2 icerik">
                                    <td>Ana Sayfa Alt Kategorileri :</td>
                                    <td colspan="3">
                                        <select name="i4" class="form-control" id="i4">
                                            <option value="0" <%if strsi4="0" then%>selected<%else%><%end if%>>Listeleme</option>
                                            <option value="1" <%if strsi4="1" then%>selected<%else%><%end if%>>Listele</option>
                                        </select></td>
                                </tr>
                                <%else%>
                                <%end if%>

                                <%if strskate1="1" or strskate1="3" then%>

                                <%else%>

                                <tr class="icerik2 icerik">
                                    <td colspan="2">Listeleme Adedi :</td>
                                    <td colspan="2">
                                        <select name="i6" class="form-control" id="i6">
                                            <option value="12" <%if strsi6="12" then%>selected<%else%><%end if%>>Tek</option>
                                            <option value="6" <%if strsi6="6" then%>selected<%else%><%end if%>>2 li</option>
                                            <option value="4" <%if strsi6="4" then%>selected<%else%><%end if%>>3 lü</option>
                                            <option value="3" <%if strsi6="3" then%>selected<%else%><%end if%>>4 lü</option>
                                            <option value="2" <%if strsi6="2" then%>selected<%else%><%end if%>>6 lı</option>
                                            <option value="1" <%if strsi6="1" then%>selected<%else%><%end if%>>12 li</option>
                                        </select></td>
                                    <td colspan="2" style="text-align:right;">Resim Slayt Css</td>
                                    <td colspan="2">
                                        <select name="i2" class="form-control" id="i2">
                                            <option value="0">Listeleme Tempi
                                            </option>
                                            <%
				if strsi2="" then
				strsi2="0"
				else
				end if
 sqlString = "select * from kategoriayar  order by id desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF%>
                                            <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(strsi2) then%>selected<%else%><%end if%>><%=mmmYardimci("kate")%></option>
                                            <%mmmYardimci.MoveNext
  loop
  close(mmmYardimci)
                                            %>
                                        </select></td>
                                </tr>
                                <%end if%>
                            </table>
                   </div>
               <div id="script" class="tab-pane fade">
                   <table class="table table-striped">
                                <%if strskate1="1" then%>

                                <tr class="icerik1 icerik">
                                    <td>Tür Seçiniz :</td>
                                </tr>
                                <tr class="icerik1 icerik">
                                    <td>
                                        <select name="temptur" size="1" id="temptur" class="form-control">
                                            <option value="single-item" <%if strsi1="single-item" then%>selected<%else%><%end if%>>single-item</option>
                                            <option value="multiple-items" <%if strsi1="multiple-items" then%>selected<%else%><%end if%>>multiple-items</option>
                                            <option value="variable-width" <%if strsi1="variable-width" then%>selected<%else%><%end if%>>variable-width</option>
                                            <option value="data-mode" <%if strsi1="data-mode" then%>selected<%else%><%end if%>>data</option>
                                            <option value="one-time" <%if strsi1="one-time" then%>selected<%else%><%end if%>>one-time</option>
                                            <option value="responsive-items" <%if strsi1="responsive-items" then%>selected<%else%><%end if%>>responsive-items</option>
                                            <option value="center-mode" <%if strsi1="center-mode" then%>selected<%else%><%end if%>>center-mode</option>
                                            <option value="lazy-load" <%if strsi1="lazy-load" then%>selected<%else%><%end if%>>lazy</option>
                                            <option value="auto-play" <%if strsi1="auto-play" then%>selected<%else%><%end if%>>autoplay</option>
                                            <option value="fade-items" <%if strsi1="fade-items" then%>selected<%else%><%end if%>>fade</option>
                                            <option value="slider-nav" <%if strsi1="slider-nav" then%>selected<%else%><%end if%>>slider-nav</option>
                                            <option value="singl-ite-rtl" <%if strsi1="single-item-rtl" then%>selected<%else%><%end if%>>single-item-rtl</option>
                                        </select></td>
                                </tr>
                                <%else
			  end if%>
                                <tr class="icerik2 icerik">
                                    <td>Script</td>
                                </tr>
                                <tr class="icerik2 icerik">
                                    <td>
                                        <input name="duzenlemetur" type="hidden" value="icerik" />
                                        <textarea name="l6" id="beautifiedjs" rows="20" class="form-control"><%=strsl6%></textarea>
                                        
                                    </td>
                                </tr>
                            </table>
                   </div>
               <div id="resimsablon" class="tab-pane fade">                   
                            <%sayfatemptur="2"%>
                            Tekrarlayan Alan
                            <input name="temptura" type="hidden" id="sl0" value="0" checked="checked">
                            <textarea name="r2" class="form-control" id="beautifiedresim" aria-hidden="true"><%=strsr2 %></textarea>
                            Ana Alan
                            <textarea name="r6" class="form-control" id="beautifiedresim1" aria-hidden="true"><%=strsr6 %></textarea>
                   </div>
                <div id="listesablon" class="tab-pane fade">                   
                            <%sayfatemptur="2"%>
                            Tekrarlayan Alan
                            <textarea name="temptura1" class="form-control" id="beautifiedlistes" aria-hidden="true"><%=stemptur1 %></textarea>
                            Ana Alan
                            <textarea name="i3" class="form-control" id="beautifiedlistes1" aria-hidden="true"><%=stempturrepeat %></textarea>
                   </div>
                
                    <%if strskate1="1" or strskate1="3" then
			  else%>
               <div id="sablon" class="tab-pane fade">
                    <%sayfatemptur="1"%>
                            <!--#Include file="ortak_template.asp"-->
                   </div>
                <%end if %>
               <div id="css" class="tab-pane fade">
                   
            <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                    <%
										 strsi8=strsl10
										 if instr(strsi8,"*/") then
		  cssanan=split(strsi8,"*/")
cssananadet=ubound(cssanan)

if cssananadet="0" then
cssananadet=1
else
cssananadet=cssananadet
end if
else
end if
for u= 0 to cssananadet-1
if ubound(split(cssanan(u),"/*"))="0" then
cssananadet=0
cssananbas="Anagovde"
else
cssananbas=split(cssanan(u),"/*")(1)
end if

                            %>
                   
                            <div class="panel">
                                <a class="panel-heading" role="tab" id="heading<%=u%>" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=u%>" aria-expanded="true" aria-controls="collapse<%=u%>" onclick='format(<%=u%>,"css",this)'>
                                    <h4 class="panel-title"><%=cssananbas%></h4>
                                </a>
                                <div id="collapse<%=u%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=u%>">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                        <tr>
                                            <td>Css Satır Başlık :<br />
                                                <input name="cssnbas" type="text" id="dbosluk" value="<%=cssananbas%>" class="form-control" /></td>
                                        </tr>
                                    </table>
                                    <%
			if cssananadet="1" then
			cssanah=cssanan(u+1)
			else
			cssanah=split(cssanan(u+1),"/*")(0)
			end if
                                    %>

                                    <div class="panel">
                                        <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                            <tr>
                                                <td>
                                                    <textarea name="logodegera<%=u+1%>" class="form-control" id="beautified<%=u%>" rows="5"><%=replace(replace(cssanah,"-//-","{"),"/--/","}")%></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </div>
                            </div>
                            <%next%>
                            <div class="panel">
                                <a class="panel-heading" role="tab" id="heading<%=u+1%>" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=u+1%>" aria-expanded="true" aria-controls="collapse<%=u+1%>" onclick='format(<%=u+1%>,"css",this)'>
                                    <h4 class="panel-title">Css Text</h4>
                                </a>
                                <div id="collapse<%=u+1%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=u+1%>">
                                    <input type="checkbox" name="listecss" id="checkbox" value="1" />
                                    Aşağıdaki Cssi Komple Uygula
              <textarea name="csstam" rows="7" style="width: 98%;" id="beautified<%=u+1%>"><%=strsi8%></textarea>
                                </div>
                            </div>
                   </div>
              </div>
                
                <input name="Submit" type="submit" id="Submit5" value="Düzenle" onclick="this.form.submit(); formla12('?Submit=katedDuzenle&urunid=<%=kateid%>&sek=<%=request.QueryString("sek")%>');" class="btn btn-info pull-right" />
                </div>
            
            
        </form>

        <script language="JavaScript">

            function formla12(gelen12) {
                document.custlist12.action = gelen12;
                document.custlist12.submit();
            }
  //-->
        </script>
        <div class="col-md-12">
            <div class="accordion" id="accordionresim" role="tablist" aria-multiselectable="true">
                <div class="panel">
                    <a class="panel-heading" role="tab" id="headingresim" data-toggle="collapse" data-parent="#accordion" href="#collapseresim" aria-expanded="true" aria-controls="collapseresim">
                        <h4 class="panel-title">Css Resimleri</h4>
                    </a>
                    <div id="collapseresim" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingresim">
                       
    <div class="form-group">
    <div class="input-group">
                <input class="form-control" id="fieldID1" aria-multiselectable="true" name="advtext" type="text" value="<%=strocvstr %>">
                <div class="input-group-btn">
                    <a data-toggle="modal" href="#" data-href="<%=siteadres %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=0&fldr=/temp" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>
                </div>
                </div>
                </div>
                    </div>
                </div>
            </div>
            <%end if
  close(mmmGenel)%>
        </div>
        <!--#Include file="codeeditor.html"-->
    </div>
</div>
<%call footer(1)%>