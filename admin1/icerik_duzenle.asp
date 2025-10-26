<!--#Include File="admin_menu1.asp"-->
<div class="right_col" role="main">

    <%
  dim so(14),sou(14),sl(14),slu(14)
urunid = Request.QueryString("urunid")
if urunid="" then
urunid="0"
else
end if
sqlString = "select * from yazilar where id="&urunid&""
set mmmGenel = Con.Execute (sqlString)
strid=mmmGenel("id")
stemptur=mmmGenel("temp")
stemptur1=stemptur
strbilgi1a=mmmGenel("bilgi1")
strbilgi2a=mmmGenel("bilgi2")
strbilgi3a=mmmGenel("bilgi3")
strbilgi4a=mmmGenel("bilgi4")
strmodulmu=mmmGenel("modulmu")
stryazib=mmmGenel("yazib")
strlink=mmmGenel("link")
strtarget=mmmGenel("target")
strform=mmmGenel("form")
strkategori=mmmGenel("kategori")
stryazi=mmmGenel("yazi")
sqlString = "select * from ozellikler2 where kateid='"&strid&"'"
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
close(mmmGenel)
stryaziplus="[456]{456b}Başlık 1{/456b}[/456][456]{456b}Başlık 2{/456b}[/456][456]{456dy}Düz Yazı 1{/456dy}[/456][456]{456dy}Düz Yazı 2{/456dy}[/456][456]{456zy}Zengin Yazı 1{/456zy}[/456][456]{456zy}Zengin Yazı 2{/456zy}[/456][456]{456tr}resimid1{/456tr}[/456][456]{456tr}resimid2{/456tr}[/456][456]{456rg}resimid1{/456rg}{456rg}resimid2{/456rg}{456rg}resimid3{/456rg}{456rg}resimid4{/456rg}{456rg}resimid5{/456rg}[/456][456]{456tv}video1{/456tv}[/456][456]{456vg}videoid1{/456vg}{456vg}videoid2{/456vg}{456vg}videoid3{/456vg}{456vg}videoid4{/456vg}{456vg}videoid5{/456vg}[/456][456]{456th}harita1{/456th}[/456][456]{456hg}haritaid1{/456hg}{456hg}haritaid2{/456hg}{456hg}haritaid3{/456hg}{456hg}haritaid4{/456hg}{456hg}haritaid5{/456hg}[/456][456]{456f}form1{/456f}[/456]"

function stryplusust(basliki,turi)
stryplusust=stryplusust&"<div data-section=""1"" class=""accordion section section-t collapsable is-open"">"
stryplusust=stryplusust&"<h2 class=""show-mobile"">"&basliki&"</h2>"           
stryplusust=stryplusust&"<div class=""clearfix""></div>"
stryplusust=stryplusust&"<div class=""photoTable js-photo-table"" style=""width:100%;"">"
end function

function stryplusicerik(basliki,turi)
stryplusicerik=stryplusicerik&"<fieldset>"   
if turi="b" then
stryplusicerik=stryplusicerik&"<input name=""myTextarea"" size=""40"" id=""myTextarea"" class=""input-half"" type=""text"" value="""&basliki&""">"
elseif turi="dy" then
stryplusicerik=stryplusicerik&"<textarea  rows=""5"" name=""myTextarea"" id=""myTextarea"" style=""width:100%;"" class=""form-control"">"&basliki&"</textarea>"
elseif turi="zy" then
stryplusicerik=stryplusicerik&"<textarea  rows=""30"" name=""myTextarea"" id=""myTextarea"" style=""width:100%;"" class=""normal form-control"">"&basliki&"</textarea>"
elseif turi="tr" then
stryplusicerik=basliki
elseif turi="rg" then
stryplusicerik=basliki
elseif turi="tv" then
stryplusicerik=stryplusicerik&"<input name=""myTextarea"" size=""40"" id=""myTextarea"" class=""input-half"" type=""text"" value="""&basliki&""">"
elseif turi="vg" then
stryplusicerik=stryplusicerik&"<input name=""myTextarea"" size=""40"" id=""myTextarea"" class=""input-half"" type=""text"" value="""&basliki&""">"
elseif turi="th" then
stryplusicerik=stryplusicerik&"<input name=""myTextarea"" size=""40"" id=""myTextarea"" class=""input-half"" type=""text"" value="""&basliki&""">"
elseif turi="hg" then
stryplusicerik=stryplusicerik&"<input name=""myTextarea"" size=""40"" id=""myTextarea"" class=""input-half"" type=""text"" value="""&basliki&""">"
elseif turi="f" then
stryplusicerik=stryplusicerik&"<select id=""kategori"" name=""form"">"
sqlString = "select * from formlar  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
if basliki=int(mmmYardimci("id")) then
strkategorics="selected"
else
end if
stryplusicerik=stryplusicerik&"<option value="""&mmmYardimci("id")&""" "&strkategorics&">"&mmmYardimci("formadi")&"</option>"
mmmYardimci.movenext
loop
close(mmmYardimci)
stryplusicerik=stryplusicerik&"</select>"
else

end if                     
          stryplusicerik=stryplusicerik&"</fieldset>"
end function

function stryplusalt(basliki,turi)
stryplusalt=stryplusalt&"</div>"
stryplusalt=stryplusalt&"</div>"
end function

if instr(stryaziplus,"["&strid&"]") then
stryazipluscount=ubound(split(stryaziplus,"["&strid&"]"))
for ypc=1 to stryazipluscount
strypc=split(stryaziplus,"["&strid&"]")(ypc)
if instr(strypc,"{"&strid&"b}") then
strypcbcount=ubound(split(strypc,"{"&strid&"b}"))
for ypcb=1 to strypcbcount
strypcb=split(strypc,"{"&strid&"b}")(ypcb)
strypcb=split(strypcb,"{/"&strid&"b}")(0)
strypcba=strypcba&""&stryplusicerik(strypcb,"b")
next
elseif instr(strypc,"{"&strid&"dy}") then
strypcdycount=ubound(split(strypc,"{"&strid&"dy}"))
for ypcdy=1 to strypcdycount
strypcdy=split(strypc,"{"&strid&"dy}")(ypcdy)
strypcdy=split(strypcdy,"{/"&strid&"dy}")(0)
strypcdya=strypcdya&""&stryplusicerik(strypcdy,"dy")
next
elseif instr(strypc,"{"&strid&"zy}") then
strypczycount=ubound(split(strypc,"{"&strid&"zy}"))
for ypczy=1 to strypczycount
strypczy=split(strypc,"{"&strid&"zy}")(ypczy)
strypczy=split(strypczy,"{/"&strid&"zy}")(0)
strypczya=strypczya&""&stryplusicerik(strypczy,"zy")
next
elseif instr(strypc,"{"&strid&"tr}") then
strypctrcount=ubound(split(strypc,"{"&strid&"tr}"))
for ypctr=1 to strypctrcount
strypctr=split(strypc,"{"&strid&"tr}")(ypctr)
strypctr=split(strypctr,"{/"&strid&"tr}")(0)
strypctra=strypctra&""&stryplusicerik(strypctr,"tr")
next
elseif instr(strypc,"{"&strid&"rg}") then
strypcrgcount=ubound(split(strypc,"{"&strid&"rg}"))
for ypcrg=1 to strypcrgcount
strypcrg=split(strypc,"{"&strid&"rg}")(ypcrg)
strypcrg=split(strypcrg,"{/"&strid&"rg}")(0)
strypcrga=strypcrga&""&stryplusicerik(strypcrg,"rg")
next
elseif instr(strypc,"{"&strid&"tv}") then
strypctvcount=ubound(split(strypc,"{"&strid&"tv}"))
for ypctv=1 to strypctvcount
strypctv=split(strypc,"{"&strid&"tv}")(ypctv)
strypctv=split(strypctv,"{/"&strid&"tv}")(0)
strypctva=strypctva&""&stryplusicerik(strypctv,"tv")
next
elseif instr(strypc,"{"&strid&"vg}") then
strypcvgcount=ubound(split(strypc,"{"&strid&"vg}"))
for ypcvg=1 to strypcvgcount
strypcvg=split(strypc,"{"&strid&"vg}")(ypcvg)
strypcvg=split(strypcvg,"{/"&strid&"vg}")(0)
strypcvga=strypcvga&""&stryplusicerik(strypcvg,"vg")
next
elseif instr(strypc,"{"&strid&"th}") then
strypcthcount=ubound(split(strypc,"{"&strid&"th}"))
for ypcth=1 to strypcthcount
strypcth=split(strypc,"{"&strid&"th}")(ypcth)
strypcth=split(strypcth,"{/"&strid&"th}")(0)
strypctha=strypctha&""&stryplusicerik(strypcth,"th")
next
elseif instr(strypc,"{"&strid&"hg}") then
strypchgcount=ubound(split(strypc,"{"&strid&"hg}"))
for ypchg=1 to strypchgcount
strypchg=split(strypc,"{"&strid&"hg}")(ypchg)
strypchg=split(strypchg,"{/"&strid&"hg}")(0)
strypchga=strypchga&""&stryplusicerik(strypchg,"hg")
next
elseif instr(strypc,"{"&strid&"f}") then
strypcfcount=ubound(split(strypc,"{"&strid&"f}"))
for ypcf=1 to strypcfcount
strypcf=split(strypc,"{"&strid&"f}")(ypcf)
strypcf=split(strypcf,"{/"&strid&"f}")(0)
strypcfa=strypcfa&""&stryplusicerik(strypcf,"f")
next
else

end if
next

    %><div class="x_panel">
        <div class="x_title">
            <h2>İçerik Düzenle&nbsp;&nbsp;</h2>
            <a href="ortak_sayfalar_ayar.asp?dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs" data-fancybox-type="iframe" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bu Sayfanın veya Alt Sayfaların Yerleşim Ayarları İçin."><em class="fa fa-th-large" style="font-size: 11px;"></em></a>
            <div class="clearfix"></div>
        </div>
        <form method="post" name="Form1" id="myForm" action="sayfalar.asp?dkate2=<%=request("sek")%>&sek=<%=request("dkate2")%>&islem=duzenleyazi">
            <input type="hidden" name="id" value="<%=strid%>" />
            <input type="hidden" name="modulmu" value="<%=strmodulmu%>" />
            <div class="col-md-1">
                <a href="galeri.asp?baslik=<%=urunid%>&dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Resim Ekle"><em class="fa fa-camera" style="font-size: 16px;"></em>(<%=toplam4%>)</a>
            </div>
            <div class="col-md-2">
                <label>
                    <input name="harici" type="checkbox" id="harici" value="1" <%if strlink = "" or strlink = "0" or isNull(strlink) Then%><%else%>checked<%end if%> onclick="javascript: toggleDiv('block', this.checked);" />
                    Harici Linke Git</label>
            </div>
            <div id="block" class="col-md-9" style="display: none;">
                <div class="col-md-8">
                    <input name="link" type="text" value="<%=strlink%>" size="25" class="form-control" />
                </div>
                <div class="col-md-4">
                    <select id="target" size="1" name="target" class="form-control">
                        <option value="0">Sayfa Açılma</option>
                        <option value="_blank" <%if strtarget = "_blank" Then%>selected<%else%><%end if%>>Boş Sayfada Aç</option>
                        <option value="_parent" <%if strtarget = "_parent" Then%>selected<%else%><%end if%>>Kendi İçinde Aç</option>
                    </select>
                </div>
            </div>
            <script language="javascript">
                function toggleDiv(id, show) {
                    document.getElementById(id).style.display = show ? 'block' : 'none';
                    document.getElementById(id).style.display = show ? 'block1' : 'none';
                }
            </script>
            <div class="clearfix"></div>
            <%            
turler="Başlık,Düz Yazı,Zengin Yazı,Tek Resim,Resim Galerisi,Tek Video,Video Galerisi,Harita,Haritalar,Form"
turlercount=ubound(split(turler,","))
for ypctur=0 to turlercount
strturler=split(turler,",")(ypctur)
response.write stryplusust(strturler,"f")
if strturler="Başlık" then
response.Write(strypcba)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
formid=80 
sqlString = "select * from kategoriayar where adres='"&request("dkate2")&"'  ORDER BY id"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
if request("iceriktur")="112"  then
bilgi1i="Adresi"
bilgi2i="Koordinat"
else
end if
else
bilgi1=mmmGenel("bilgi1")
bilgi2=mmmGenel("bilgi2")
bilgi3=mmmGenel("bilgi3")
bilgi4=mmmGenel("bilgi4")
bilgi1i=mmmGenel("bilgi1i")
bilgi2i=mmmGenel("bilgi2i")
bilgi3i=mmmGenel("bilgi3i")
bilgi4i=mmmGenel("bilgi4i")
stemptur=mmmGenel("i1")
end if
close(mmmGenel)
            %>
            <h2 class="show-mobile">Detay Özellik</h2>
            <%
	if bilgi1=1 or request("iceriktur")="112"  then%>
            <fieldset>
                <label><%if request("duzelt1")="11" then%>Adres<%else%><%=strbilgi1i%><%end if%> : <span class="req">*</span></label>
                <input name="bilgi1" size="40" id="bilgi1" class="input-half" type="text" value="<%=strbilgi1a%>">
            </fieldset>
            <%else%><%end if%>
            <%if bilgi2=1 or request("iceriktur")="112" or request("iceriktur")="11" then%>
            <fieldset>
                <label><%if request("duzelt1")="11" then%>Koordinat<%else%><%=strbilgi2i%><%end if%> : <span class="req">*</span></label>
                <input name="bilgi2" size="40" id="bilgi2" class="input-half" type="text" value="<%=strbilgi2a%>">
            </fieldset>
            <%else%><%end if%>
            <%if bilgi3=1 or request("iceriktur")="8" or request("iceriktur")="11" or request("iceriktur")="4" then%>
            <fieldset>
                <label><%if request("duzelt1")="11" then%>Adres<%elseif request("urunid")="8" or request("duzelt1")="4" then%>Fiyatı<%else%><%=strbilgi3i%><%end if%> : <span class="req">*</span></label>
                <input name="bilgi3" size="40" id="bilgi3" class="input-half" type="text" value="<%=strbilgi3a%>">
            </fieldset>
            <%else%><%end if%>
            <%if bilgi4=1 then%>
            <fieldset>
                <label><%=strbilgi4i%>: <span class="req">*</span></label>
                <input name="bilgi4" size="40" id="bilgi4" class="input-half" type="text" value="<%=strbilgi4a%>">
            </fieldset>
            <%else%><%end if%>

            <%if request("duzelt1")=5 then%>
            <fieldset>
                <label>Form Se&ccedil;: <span class="req">*</span></label>
                <input name="form" size="40" id="form" class="input-half" type="text" value="<%=strform%>">
            </fieldset>
            <%else%>
            <%end if
if formid="1" or formid="" then
else%>
            <input name="formice" type="hidden" value="<%=formid%>" />
            <input name="formekle" type="hidden" value="ekle" />
            <%
set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira")

Do While Not mmmYardimci3.EOF
fname=mmmYardimci3("name")
fisim=mmmYardimci3("isim")
fid=mmmYardimci3("id")
ftur=mmmYardimci3("tur")
formisim=dilformv(fid,fisim)
if ftur=8 then%>
            <div class="grupanabaslik"><%=formisim%></div>
            <div class="grupform1">
                <%
 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid&"' order by sira")
Do While Not mmmYardimci2.EOF
fid1=mmmYardimci2("id")
fisim1=mmmYardimci2("isim")
ftur1=mmmYardimci2("tur")
formisim1=dilformv(fid,fisim)
if ftur1=8 then
                %>
                <div class="grupanabaslik"><%=formisim1%></div>
                <div class="grupform1">
                    <%
 set mmmYardimci1 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid1&"' order by sira")
Do While Not mmmYardimci1.EOF
fid3=mmmYardimci1("id")
ftur3=mmmYardimci1("tur")
                    %>
                    <fieldset>
                        <%response.Write(formolustur(fgtur,1,fid3))%>
                    </fieldset>
                    <%		fname3=""				  
mmmYardimci1.movenext
loop
close(mmmYardimci1)
                    %>
                </div>
                <%
else%>
                <fieldset>
                    <%response.Write(formolustur(fgtur,1,fid1))%>
                </fieldset>
                <%end if

		fname1=""				  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
                %>
            </div>
            <%
elseif ftur=9 then
            %>
            <fieldset>
                <select id="Select12" size="1" onchange="return kategoriSec()" name="<%=fname%>">
                    <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&fid&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
fname2=mmmYardimci2("name")
fisim2=mmmYardimci2("isim")
fid2=mmmYardimci2("id")
ftur2=mmmYardimci2("tur")
formisim2=dilformv(fid2,fisim2)%>
                    <option value="<%=fid2%>"><%=formisim2%></option>
                    <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
                    %>
                </select>
            </fieldset>
            <fieldset>
                <div id="sonuc"></div>
                <script type="text/javascript">



                    // Internet Explorer (5.0+)
                    try {
                        http = new ActiveXObject("Msxml2.XMLHTTP");  // yeni versiyon xmlhttp
                    } catch (e) {

                        try {
                            http = new ActiveXObject("Microsoft.XMLHTTP");  // eski versiyon xmlhttp
                        } catch (e) {
                            http = false;
                        }

                    }

                    // Mozilla ve Safari
                    if (!http && typeof XMLHttpRequest != 'undefined') {

                        try {
                            http = new XMLHttpRequest();
                        } catch (e) {
                            http = false;
                        }

                    }

                    // Diger
                    if (!http && window.createRequest) {

                        try {
                            http = window.createRequest();
                        } catch (e) {
                            http = false;
                        }

                    }


                    function kategoriSec() {

                        var kategori = document.getElementById('Select12').value;
                        if (kategori != 0) {
                            http.open('get', '/sehirsec1.asp?Kategori=' + kategori);
                            http.onreadystatechange = function () {
                                document.getElementById('sonuc').innerHTML = "Bekleyiniz...";
                                if (http.readyState == 4) {
                                    document.getElementById('sonuc').innerHTML = http.responseText;
                                }
                            };
                            http.send(null);
                        };
                    }

                    window.onload = kategoriSec;
                </script>
            </fieldset>
            <%
else%>
            <fieldset>
                <%response.Write(formolustur(fgtur,1,fid))%>
            </fieldset>
            <%end if
		fname=""				  
mmmYardimci3.movenext
loop
close(mmmYardimci3)

end if
elseif strturler="Düz Yazı" then
response.Write(strypcdya)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Zengin Yazı" then
            %>
            <textarea rows="30" name="myTextarea" id="myTextarea" style="width: 100%;" class="normal form-control"><%=stryazi%></textarea>
            <%response.Write(strypczya)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Tek Resim" then
response.Write(strypctra)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Resim Galerisi" then
response.Write(strypcrga)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Tek Video" then
response.Write(strypctva)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Video Galerisi" then
response.Write(strypcvga)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Harita" then
response.Write(strypctha)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Haritalar" then
response.Write(strypchga)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
elseif strturler="Form" then
response.Write(strypcfa)
            %>
            <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=strturler%>','c<%=strturler%>');">+</div>
            <%
else

end if
response.write stryplusalt(strypcf,"f")
next
else
end if

            %>

            <%if request("duzelt1")=7 then%>
            <fieldset>
                <label>Form Se&ccedil;: <span class="req">*</span></label>
                <select id="kategori" name="form">
                    <%
sqlString = "select * from formlar  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                    %>
                    <option value="<%=mmmYardimci("id")%>" <%if int(strform)=int(mmmYardimci("id")) then%>selected<%else%><%end if%>><%=mmmYardimci("formadi")%></option>
                    <%
mmmYardimci.movenext
loop
close(mmmYardimci)
                    %>
                </select>
            </fieldset>
            <%else%>
            <input name="form" type="hidden" value="0" />
            <%end if%>



            <%if request("modul")=1 or strmodulmu="1" then%>

            <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">

                <div class="panel">
                    <script src="js/codemirror.js" charset="utf-8"></script>
                    <script src="js/css.js" charset="utf-8"></script>
                    <link rel="stylesheet" type="text/css" href="css/codemirror.css" />
                    <script src="js/cssbeautify.js" charset="utf-8"></script>
                    <script src="js/format.js" charset="utf-8"></script>
                    <div class="panel">
                        <a class="panel-heading" role="tab" id="headingfive" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="true" aria-controls="collapseFive">
                            <h4 class="panel-title">Css</h4>
                        </a>
                        <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfive">
                            <%
										 strsi8=strbilgi1a
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
                                <a class="panel-heading" role="tab" id="heading<%=u%>" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=u%>" aria-expanded="true" aria-controls="collapse<%=u%>" onclick='format(<%=u%>)'>
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
                                <a class="panel-heading" role="tab" id="heading9999" data-toggle="collapse" data-parent="#accordion" href="#collapse9999" aria-expanded="true" aria-controls="collapse9999" onclick='format(9999)'>
                                    <h4 class="panel-title">Css Text</h4>
                                </a>
                                <div id="collapse9999" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading9999">
                                    <input type="checkbox" name="listecss" id="checkbox" value="1" />
                                    Aşağıdaki Cssi Komple Uygula
              <textarea name="csstam" rows="7" id="beautified9999" style="width: 98%;"><%=strsi8%></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="options">
                        <input type="hidden" name="indent" id="fourspaces" value="fourspaces" onchange='format()'>
                        <input type="hidden" name="indent1" id="twospaces" value="twospaces" onchange='format()'>
                        <input type="hidden" name="indent1" id="tab" value="tab" onchange='format()'>
                        <input checked type="hidden" name="openbrace" id="openbrace-end-of-line" onchange='format()'>
                        <input type="hidden" name="openbrace1" id="openbrace-separate-line" onchange='format()'>
                        <input checked type="hidden" name="autosemicolon" id="autosemicolon" onchange='format()'>
                    </div>
                </div>
            </div>
            <%else%>
            <%end if%>
            <div class="form-actions">
                <div class="wrap">
                    <div></div>
                    <input name="submitButton" value="Düzenle" id="submitButton" class="btn" type="submit">
                </div>
            </div>
        </form>

    </div>
</div>
<%call footer(1)%>