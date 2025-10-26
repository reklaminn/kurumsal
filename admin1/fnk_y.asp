<%
    arrcsskategori=Array(1,2,3,4)
arrcsskategoribaslik=Array("Slick","İçerik","İçerik Listeleme","Html İçerik")

if d2="" then
menulogo="../images/temp/"&d2
else
menulogo="images/"&webadminlogo&""
end if
    
    if request.ServerVariables("HTTPS")="on" then
    servername="https://"& request.ServerVariables("Server_name")&"/"
    else
    servername="http://"& request.ServerVariables("Server_name")&"/"
    end if
'sayfagosterme=" and ((id<>'1053' and id<>'1055' and id<>'1076' and id<>'1081' and id<>'1105' and id<>'1121' and id<>'1048') and (anasek<>'1053' and anasek<>'1055' and anasek<>'1076' and anasek<>'1081' and anasek<>'1105' and anasek<>'1121' and anasek<>'1048') and id not in (select id from kategoriyazi where anasek = '1055' or anasek = '1076' or anasek = '1053' or anasek = '1063' or anasek = '1081' or anasek = '1105' or anasek = '1121' or anasek = '1048') and id not in (select id from kategoriyazi where id = '1055' or id = '1076' or id = '1053' or id = '1063' or id = '1081' or id = '1105' or id = '1121' or id = '1048'))"
'yazigosterme=" and (kategori<>'1081' and kategori not in (select id from kategoriyazi where anasek = '1081')) and (kategori<>'1053' and kategori not in (select id from kategoriyazi where anasek = '1053') and kategori<>'1055' and kategori not in (select id from kategoriyazi where anasek = '1055') and kategori<>'1076' and kategori not in (select id from kategoriyazi where anasek = '1076') and kategori<>'1105' and kategori not in (select id from kategoriyazi where anasek = '1105') and kategori<>'1121' and kategori not in (select id from kategoriyazi where anasek = '1121') and kategori<>'1048' and kategori not in (select id from kategoriyazi where anasek = '1048'))"
    if yetkiuye="1" then
    else
    sabitsayfa=" and orta<>'11'"
    sabittemp=" and temp<>'11'"
    sabitmodul=" and modulmu<>'11'"
    end if
    for pil=2 to 20
    temfstr=temfstr&" and modulmu<>'"&pil&"'"
    if pil="2" then
    modulgostermestr=modulgostermestr&" temp<>'"&pil&"'"
    else
    modulgostermestr=modulgostermestr&" and temp<>'"&pil&"'"
    end if
    sayfagostermestr=sayfagostermestr&" and orta<>'"&pil&"'"
    next
tempf=replace(temfstr," and modulmu<>'11'","")&""&sabitmodul&""
modulgosterme=replace(modulgostermestr," and temp<>'11'","")&""&sabittemp&""
sayfagosterme=replace(sayfagostermestr," and orta<>'11'","")&""&sabitsayfa&""
if instr(sistem_site_turu,"*eticaret*") then
tempf=replace(tempf,"'2'","'99999999'")
modulgosterme=replace(modulgosterme,"'2'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'2'","'99999999'")
else
end if
if instr(sistem_site_turu,"*haber*") then
tempf=replace(tempf,"'3'","'99999999'")
modulgosterme=replace(modulgosterme,"'3'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'3'","'99999999'")
else
end if
if instr(sistem_site_turu,"*cicek*") then
tempf=replace(tempf,"'4'","'99999999'")
modulgosterme=replace(modulgosterme,"'4'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'4'","'99999999'")
else
end if
if instr(sistem_site_turu,"*rehber*") then
tempf=replace(tempf,"'5'","'99999999'")
modulgosterme=replace(modulgosterme,"'5'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'5'","'99999999'")
else
end if
if instr(sistem_site_turu,"*tur*") then
tempf=replace(tempf,"'6'","'99999999'")
modulgosterme=replace(modulgosterme,"'6'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'6'","'99999999'")
else
end if
if instr(sistem_site_turu,"*uyelik*") then
tempf=replace(tempf,"'7'","'99999999'")
modulgosterme=replace(modulgosterme,"'7'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'7'","'99999999'")
else
end if
if instr(sistem_site_turu,"*kupon*") then
tempf=replace(tempf,"'8'","'99999999'")
modulgosterme=replace(modulgosterme,"'8'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'8'","'99999999'")
else
end if
if instr(sistem_site_turu,"*ce*") then
tempf=replace(tempf,"'9'","'99999999'")
modulgosterme=replace(modulgosterme,"'9'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'9'","'99999999'")
else
end if
if instr(sistem_site_turu,"*emlak*") then
tempf=replace(tempf,"'10'","'99999999'")
modulgosterme=replace(modulgosterme,"'10'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'10'","'99999999'")
else
end if
if instr(sistem_site_turu,"*tahsilat*") then
tempf=replace(tempf,"'12'","'99999999'")
modulgosterme=replace(modulgosterme,"'12'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'12'","'99999999'")
else
end if
if instr(sistem_site_turu,"*acc*") then
tempf=replace(tempf,"'13'","'99999999'")
modulgosterme=replace(modulgosterme,"'13'","'99999999'")
sayfagosterme=replace(sayfagosterme,"'13'","'99999999'")
else
end if
  
    function ruscyrltolat(str)
    rustrn=array("А","а","Б","б","В","в","Г","г","Д","д","Е","е","Ё","ё","Ж","ж","З","з","И","и","Й","й","К","к","Л","л","М","м","Н","н","О","о","П","п","Р","р","С","с","Т","т","У","у","Ф","ф","Х","х","Ц","ц","Ч","ч","Ш","ш","Щ","щ","Ъ","ъ","Ы","ы","Ь","ь","Э","э","Ю","ю","Я","я","ʹ","ʺ","Č","č","Š","š","Ŝ","ŝ","Ë","ë","Ž","ž","è")
     ' rustr=array("б","в","г","д","ё","ж","з","и","й","к","л","н","п","p","c","т","f","x","ц","ч","ш","щ","н","ь","ы","с","у","ë","ž","j","č","š","ŝ","а","м","о","е","ʹ","Б","р")
    rucnt=ubound(rustrn)
    'latstr =array("b","v","g","d","ë","ž","z","i","j","k","l","n","p","p","c","t","f","x","c","č","š","ŝ","n","ʹ","y","s","u","o","j","y","c","s","ss","a","m","o","e","","B","r")
    latstrn =array("A","a","B","b","V","v","G","g","D","d","E","e","Ë","ë","Ž","ž","Z","z","I","i","J","j","K","k","L","l","M","m","N","n","O","o","P","p","R","r","S","s","T","t","U","u","F","f","H","h","C","c","Č","č","Š","š","Ŝ","ŝ","ʺ","ʺ","Y","y","ʹ","ʹ","È","è","Ju","ju","Ja","ja","","","C","c","S","s","SS","ss","O","o","J","j","e")
'   latstr =array("b","v","g","d","o","j","z","i","y","k","l","h","p","r","s","t","f","h","ts","c","s","ss","H")
    for rui=0 to rucnt
str = replace(str,rustrn(rui),latstrn(rui))
    next
    ruscyrltolat=str
    end function

function checkboxcreat(cbcname,cbctitle,cbci,cbcdis,cbccheck,cbcturstr)
  checkboxcreat=checkboxcreat&"<div class=""checkbox-inline checkbox-"&cbcturstr&""" data-toggle=""tooltip"" data-placement=""bottom"" title="""&cbctitle&""" data-original-title="""&cbctitle&""">"
         checkboxcreat=checkboxcreat&"<div id=""cd"&cbcname&""&cbci&""" class=""checker"">"
	checkboxcreat=checkboxcreat&"<span class="""&cbccheck&""">"
        checkboxcreat=checkboxcreat&"<input name="""&cbcname&""" type=""hidden"" value=""0"" id="""&cbcname&""&cbci&""" "&cbcdis&">"
       checkboxcreat=checkboxcreat&"<INPUT name="""&cbcname&""" type=""checkbox"" id=""c"&cbcname&""&cbci&""" "&cbccheck&" value=""1"" onClick=disable_s(this.checked,'"&cbcname&""&cbci&"',this);>"
checkboxcreat=checkboxcreat&"</span></div>"
      checkboxcreat=checkboxcreat&"</div>"
  end function
  
karakterler1="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1=len(karakterler1)
for ikr = 1 to 3
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next

function sifreuret() 
for a = 1 to 3
kacincikarakter1a=int((karakterboyu1*rnd)+1)
uretilensifre1a=uretilensifre1a&mid(karakterler1,kacincikarakter1a,1)
next
sifreuret=uretilensifre1a
end function

Min = 1
Max = 99999
Randomize
Sayilar = Int((Max - Min + 1) * Rnd + Min)


function duzelt(nesne)  
nesne = Replace(nesne , ".jpg" , "" ) 
nesne = Replace(nesne , ".JPG" , "" ) 
nesne = Replace(nesne , ".GIF" , "" ) 
nesne = Replace(nesne , ".gif" , "" ) 
nesne = Replace(nesne , ".BMP" , "" ) 
nesne = Replace(nesne , ".bmp" , "" ) 
nesne = Replace(nesne , ".PNG" , "" ) 
nesne = Replace(nesne , ".png" , "" ) 
duzelt = nesne 
end function
%>
<!--#Include file="ortak_fnk_y.asp"-->
<%

if request("sayfaayar")="" then
sayfaayart="sayfaayar"
else
sayfaayart=request("sayfaayar")
end if

  %>
<%if sayfaayart="cssekled" then%>

<%
if isNull(request("dkate2")="") or request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
	
	if request("yer")="" or request("yer")="0" then
	yer=0
	else
	yer=request("yer")
	end if
	
%>

<div class="x_title">
  <h2>Css Ekle</h2><button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span></button>
  <div class="clearfix"></div>
</div>
<form name="form1" method="post" action="?islem=katecssekle&cssyeni=1&urunid=<%=request("smid")%>&yer=<%=request("yer")%>" target="_parent">
<table class="table table-striped">
  <%if request("dkate2")="" then%>
    <input name="dkate2" type="hidden" value="0" />
    <%else%>
    <input name="dkate2" type="hidden" value="<%=request("dkate2")%>" />
    <%end if%>
    <%if request("sek")="" then%>
    <input name="sek" type="hidden" value="0" />
    <%else%>
    <input name="sek" type="hidden" value="<%=request("sek")%>" />
    <%end if%>
    <tr>
      <td width="10%">Listeleme Adı</td>
      <td width="20%"><input name="sektor" type="text" id="sektor" class="form-control"/></td>
      <td width="10%" align="right">Listeleme Template</td>
      <td width="20%"><select name="turu" size="1" id="turu" class="form-control">
      <option value="90">Css Seçiniz</option>
             <option value="" disabled="disabled" style="background:#FFD2D2;">Kütüphaneden</option>
                <%
 sqlString = "select * from kategoriayar order by id"
set mmmGenel = Con1.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>">&nbsp;>&nbsp;<%=mmmGenel("kate")%></option>
              <%mmmGenel.MoveNext
  loop
  close(mmmGenel)
  %>
   <option value="" disabled="disabled" style="background:#D5FFD5;">Siteden</option>
              <%
 sqlString = "select * from kategoriayar order by id desc"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>"><%=mmmGenel("kate")%></option>
              <%mmmGenel.MoveNext
  loop
  close(mmmGenel)
  %>
  
            </select></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"/></td>
    </tr>

</table>
  </form>
<%
  response.End()
  else
  end if
if sayfaayart="modultempbul" then%>

<%
if isNull(request("dkate2")="") or request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
	
	if request("yer")="" or request("yer")="0" then
	yer=0
	else
	yer=request("yer")
	end if

%>
<% 
Session.CodePage=1254 
'" where kate1='"&request("tempbul")&"'"
Response.CharSet = "iso-8859-9" 
if request("tempbul")="" then
ilidd=""
else
ilidd=""
end if
tempbull=session("tempbul")
%>
<select name="temp" size="4" id="moduller2" class="form-control">
  <option value="0"> Listeleme Tempi </option>
  <%
 sqlString = "select * from kategoriayar"&ilidd&" order by id desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF%>
  <option value="<%=mmmYardimci("id")%>" <%if ""&mmmYardimci("id")&""=""&tempbull&"" then%>selected<%else%><%end if%>><%=mmmYardimci("kate")%></option>
  <%mmmYardimci.MoveNext
  loop
  close(mmmYardimci)
  %>
</select>
<% response.End()
  else
  end if


islem=Request.QueryString("islem")
if islem="dillersilceviri" then
call dillersilceviri
elseif islem="dillerekle" then
call dillerekle
elseif islem="dillersilu" then
call dillersilu
elseif islem="dillerduzenle" then
call dillerduzenle
elseif islem="dilleraktif" then
call dilleraktif
elseif islem="dilduzenle1" then
call dilduzenle1
elseif islem="duzenlediller" then
call duzenlediller
elseif islem="duzenledillerkate" then
call duzenledillerkate
elseif islem="sildillerkate" then
call sildillerkate
elseif islem="duzenledilleryazi" then
call duzenledilleryazi
elseif islem="sildilleryazi" then
call sildilleryazi
elseif islem="duzenleicerik" then
call duzenleicerik
elseif islem="duzenledillerform" then
call duzenledillerform
elseif islem="duzenledillerformalt" then
call duzenledillerformalt
elseif islem="cssduzenle" then
call cssduzenle
elseif islem="cssduzenlemodul" then
call cssduzenlemodul
elseif islem="resimonay" then
call resimonay
elseif islem="resimonay1" then
call resimonay1
elseif islem="resimonay2" then
call resimonay2
elseif islem="resimekle" then
call resimekle
elseif islem="formnekle" then
call formnekle
elseif islem="formnsira" then
call formnsira
elseif islem="formekle" then
call formekle
elseif islem="formsmtpekle" then
call formsmtpekle
elseif islem="formkopya" then
call formkopya
elseif islem="formiekle" then
call formiekle
elseif islem="formgekle" then
call formgekle
elseif islem="eskseolinkekle" then
call eskseolinkekle
elseif islem="seoduzen" then
call seoduzen
elseif islem="seoduzenbaslik" then
call seoduzenbaslik
elseif islem="site" then
call site
elseif islem="icerikekle" then
call icerikekle
elseif islem="yetkiekle" then
call yetkiekle
elseif islem="uyesil" then
call uyesil
elseif islem="uyeekle" then
call uyeekle
elseif islem="duzenleyazi" then
call duzenleyazi
elseif islem="kopyayazi" then
call kopyayazi
elseif islem="sayfaekle" then
call sayfaekle
elseif islem="sira" then
call sira
elseif islem="duzenle" then
call duzenle
elseif islem="silsayfatur" then
call silsayfatur
elseif islem="silsayfaturtek" then
call silsayfaturtek
elseif islem="eklesayfatur" then
call eklesayfatur
elseif islem="formdanicerige" then
call formdanicerige
    elseif islem="formcall" then
   call formcontentcall(request.QueryString("fgtur"),request.QueryString("formid"))
    elseif islem="blocktab" then
    if request.QueryString("blocktabcol")="addrow" then
    addrowstr=request.QueryString("blockstring")
response.Write addrow(addrowstr)
    elseif request.QueryString("blocktabcol")="rowedit" then
    checked=request.QueryString("checked")
    checked1=request.QueryString("checked1")
    ollicount=request.QueryString("blockstring")
response.Write rowedit(checked,checked1,blockstring)
    elseif request.QueryString("blocktabcol")="coledit" then
    checked=request.QueryString("checked")
    checked1=request.QueryString("checked1")
    ollicount=request.QueryString("blockstring")
response.Write coledit(checked,checked1,blockstring)
    elseif request.QueryString("blocktabcol")="addcolumn" then
    checked=request.QueryString("checked")
    checked1=request.QueryString("checked1")
    ollicount=request.QueryString("blockstring")
response.Write addcolumn(checked,checked1,ollicount)
    elseif request.QueryString("blocktabcol")="addmodul" then
    checked=request.QueryString("checked")
    checked1=request.QueryString("checked1")
    ollicount=request.QueryString("blockstring")
response.Write addmodul(checked,checked1,ollicount)
    elseif request.QueryString("blocktabcol")="editmodul" then
    checked=request.QueryString("checked")
    checked1=request.QueryString("checked1")
    blockstring=request.QueryString("blockstring")
response.Write modtext(checked,checked1,blockstring)
    else
    end if
    response.End
    elseif request("islem")="htmlekle" then

        urunids=request.QueryString("strmsmodulid")
        strmsbaslik=request.QueryString("strmsbaslik")
sqlString = "select * from moduller where id="&urunids&" order by id desc"
set mmmGenel = Con1.Execute (sqlString)
urunids=mmmGenel("kod")
if urunids="0" or urunids="yazi" or urunids="kate"  then
urunids="1"
else
urunids="3"
end if
close(mmmGenel)
sqlString = "insert yazilar set yazib='"&giriskont(strmsbaslik)&"',dil='240',bilgi1='/*Ana Govde*//*media*/@media (min-width:823px) {}@media (min-width:824px) {}@media (min-width:992px) {}@media (min-width:1200px) {}@media screen and (max-width:767px) {}@media screen and (max-width:480px) {}@media (max-device-width:480px) and (orientation:landscape) {}',link='0',durum='1',kategori='979',form='"&request.Form("form")&"',urunid='"&urunids&"',modulmu='1',tarih='"&now&"',gtarih='"&now&"'"
Con.execute(sqlString)
sqlString = "select * from yazilar order by id desc"
set mmmGenel = Con.Execute (sqlString)
msayfa="y"&mmmGenel("id")
close(mmmGenel)
response.Write msayfa
        response.End
else
end if

    function addrow(ollicount)
    addrow="<li data-id='row"&ollicount&"' data-type='content' id='r"&ollicount&"'>"&_
    "<div class='columnHead'><input type='hidden' name='rowidh' value='r"&ollicount&"' />"&_
    "<span class='columnTitle'><i class='fa fa-arrows'></i>"&_
    "<select id='rowtypee' size='1' name='rowtypee' style='width:auto; border:none; background:none;'>"&_
    "<option value='column'>Full Genişlik row"&ollicount&"</option>"&_
    "<option value='container' selected=''>Daraltılmış Genişlik row"&ollicount&"</option>"&_
    "</select>"&_
    "</span>"&_
    "<a style='margin:0px 0px; position:absolute; padding:5px !important; cursor:pointer; margin-top:-28px; background:#cccccc !important; right:25px; float:right; font-size:14px; color:#000;' onclick=divremove('r"&ollicount&"');>-</a>"&_
    "</div>"&_
    "<ol class='columnParent' id='c"&ollicount&"'>"&_
    ""&addcolumn(ollicount,"c"&ollicount&"",ollicount)&""&_
    "<div id='btn3' class='appendekle btn btn-primary' onClick=btn3('"&ollicount&"','c"&ollicount&"');>+</div>"&_
    "</ol>"&_
    "</li>"
    end function
    
    function rowedit(checked,checked1,blockstring)
    rowedit="<div class=""modal-header""><button type=""button"" class=""close"" data-dismiss=""modal"" aria-label=""Kapat""><span aria-hidden=""true"">×</span></button><h4 class=""modal-title"" id=""myModalLabel2"">Row Ayarları</h4></div><div class=""modal-body with-padding""><table class=""table table-striped"" id="""&checked&""">"    
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>ID Element</td>"
      rowedit=rowedit&"<td><input name=""elid"" id=""elid"" type=""text"" value="""" class=""form-control""/></td>"
    rowedit=rowedit&"</tr>"    
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>Css Element</td>"
      rowedit=rowedit&"<td><input name=""elcss"" id=""elcss"" type=""text"" value="""" class=""form-control""/></td>"
    rowedit=rowedit&"</tr>"
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>Style Element</td>"
      rowedit=rowedit&"<td><input name=""elstyle"" id=""elstyle"" type=""text"" value="""" class=""form-control""/></td>"
    rowedit=rowedit&"</tr>"
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>Other Element</td>"
      rowedit=rowedit&"<td><input name=""elother"" id=""elother"" type=""text"" value="""" class=""form-control""/></td>"
    rowedit=rowedit&"</tr>"
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>Container Element</td>"
      rowedit=rowedit&"<td><select id=""elcont"" size=""1"" name=""cont"" class=""form-control""><option value=""0"">None</option><option value=""column"">Full Genişlik</option><option value=""container"">Daraltılmış Genişlik</option><option value=""container-lg"">Daraltılmış Genişlik (lg)</option><option value=""container-xl"">Daraltılmış Genişlik (xl)</option></select></td>"
    rowedit=rowedit&"</tr>"
    rowedit=rowedit&"<tr>"
      rowedit=rowedit&"<td>Type Element</td>"
      rowedit=rowedit&"<td><select id=""eltype"" size=""1"" name=""eltype"" class=""form-control""><option value=""header"">Header</option><option value=""main"">Main</option><option value=""footer"">Footer</option></select></td>"
    rowedit=rowedit&"</tr>"
  rowedit=rowedit&"</table>"
    rowedit=rowedit&"<div class=""modal-footer""><input type=""submit""  onclick=rowshowSerialize("""&checked&""","""&checked1&"""); name=""Submit5"" value=""Kaydet"" class=""btn btn-success pull-right""/><input type=""button"" class=""btn btn-secondary"" data-dismiss=""modal"" id=""row1close"&rowi&""" value=""Close""></div></div>"
    
    end function
    
    function coledit(checked,checked1,blockstring)
    coledit="<div class=""modal-header""><button type=""button"" class=""close"" data-dismiss=""modal"" aria-label=""Kapat""><span aria-hidden=""true"">×</span></button><h4 class=""modal-title"" id=""myModalLabel2"">Column Ayarları</h4></div><div class=""modal-body with-padding""><table class=""table table-striped"" id="""&checked&""">"    
    coledit=coledit&"<tr>"
      coledit=coledit&"<td>ID Element</td>"
      coledit=coledit&"<td><input name=""elid"" id=""elid"" type=""text"" value="""" class=""form-control""/></td>"
    coledit=coledit&"</tr>"    
    coledit=coledit&"<tr>"
      coledit=coledit&"<td>Css Element</td>"
      coledit=coledit&"<td><input name=""elcss"" id=""elcss"" type=""text"" value="""" class=""form-control""/></td>"
    coledit=coledit&"</tr>"
    coledit=coledit&"<tr>"
      coledit=coledit&"<td>Style Element</td>"
      coledit=coledit&"<td><input name=""elstyle"" id=""elstyle"" type=""text"" value="""" class=""form-control""/></td>"
    coledit=coledit&"</tr>"
    coledit=coledit&"<tr>"
      coledit=coledit&"<td>Other Element</td>"
      coledit=coledit&"<td><input name=""elother"" id=""elother"" type=""text"" value="""" class=""form-control""/></td>"
    coledit=coledit&"</tr>"
    coledit=coledit&"<tr>"
      coledit=coledit&"<td>Column Element</td>"

      coledit=coledit&"<td>"
    coledit=coledit&"<table class=""table table-striped table-sm""><thead><tr><th>Extra small&lt;576px</th><th>Small≥576px</th><th>Medium≥768px</th><th>Large≥992px</th><th>Extra large≥1200px</th></tr></thead><tbody>"&_
    "<tr><td>None (auto)</td><td>540px</td><td>720px</td><td>960px</td><td>1140px</td>"&_
    "</tr><tr>"&_
      "<td><select id='coltype' size='1' name='coltype' class='form-control'>"&_
    "<option value='none'>Yok</option>"&_
    "<option value='col'>col (Eşit)</option>"&_
    "<option value='col-auto'>col-auto (Otomatik)</option>"&_
    "<option value='col-1'>col-1</option>"&_
    "<option value='col-2'>col-2</option>"&_
    "<option value='col-3'>col-3</option>"&_
    "<option value='col-4'>col-4</option>"&_
    "<option value='col-5'>col-5</option>"&_
    "<option value='col-6'>col-6</option>"&_
    "<option value='col-7'>col-7</option>"&_
    "<option value='col-8'>col-8</option>"&_
    "<option value='col-9'>col-9</option>"&_
    "<option value='col-10'>col-10</option>"&_
    "<option value='col-11'>col-11</option>"&_
    "<option value='col-12'>col-12</option>"&_
    "</select></td>"&_
      "<td><select id='colsmtype' size='1' name='colsmtype' class='form-control'>"&_
    "<option value='none'>Yok</option>"&_
    "<option value='col-sm'>col-sm (Eşit)</option>"&_
    "<option value='col-sm-auto'>col-sm-auto (Otomatik)</option>"&_
    "<option value='col-sm-1'>col-sm-1</option>"&_
    "<option value='col-sm-2'>col-sm-2</option>"&_
    "<option value='col-sm-3'>col-sm-3</option>"&_
    "<option value='col-sm-4'>col-sm-4</option>"&_
    "<option value='col-sm-5'>col-sm-5</option>"&_
    "<option value='col-sm-6'>col-sm-6</option>"&_
    "<option value='col-sm-7'>col-sm-7</option>"&_
    "<option value='col-sm-8'>col-sm-8</option>"&_
    "<option value='col-sm-9'>col-sm-9</option>"&_
    "<option value='col-sm-10'>col-sm-10</option>"&_
    "<option value='col-sm-11'>col-sm-11</option>"&_
    "<option value='col-sm-12'>col-sm-12</option>"&_
    "</select></td>"&_
      "<td><select id='colmdtype' size='1' name='colmdtype' class='form-control'>"&_
    "<option value='none'>Yok</option>"&_
    "<option value='col-md'>col-md (Eşit)</option>"&_
    "<option value='col-md-auto'>col-md (Otomatik)</option>"&_
    "<option value='col-md-1'>col-md-1</option>"&_
    "<option value='col-md-2'>col-md-2</option>"&_
    "<option value='col-md-3'>col-md-3</option>"&_
    "<option value='col-md-4'>col-md-4</option>"&_
    "<option value='col-md-5'>col-md-5</option>"&_
    "<option value='col-md-6'>col-md-6</option>"&_
    "<option value='col-md-7'>col-md-7</option>"&_
    "<option value='col-md-8'>col-md-8</option>"&_
    "<option value='col-md-9'>col-md-9</option>"&_
    "<option value='col-md-10'>col-md-10</option>"&_
    "<option value='col-md-11'>col-md-11</option>"&_
    "<option value='col-md-12'>col-md-12</option>"&_
    "</select></td>"&_
      "<td><select id='collgtype' size='1' name='collgtype' class='form-control'>"&_
    "<option value='none'>Yok</option>"&_
    "<option value='col-lg'>col-lg (Eşit)</option>"&_
    "<option value='col-lg-auto'>col-lg-auto (Otomatik)</option>"&_
    "<option value='col-lg-1'>col-lg-1</option>"&_
    "<option value='col-lg-2'>col-lg-2</option>"&_
    "<option value='col-lg-3'>col-lg-3</option>"&_
    "<option value='col-lg-4'>col-lg-4</option>"&_
    "<option value='col-lg-5'>col-lg-5</option>"&_
    "<option value='col-lg-6'>col-lg-6</option>"&_
    "<option value='col-lg-7'>col-lg-7</option>"&_
    "<option value='col-lg-8'>col-lg-8</option>"&_
    "<option value='col-lg-9'>col-lg-9</option>"&_
    "<option value='col-lg-10'>col-lg-10</option>"&_
    "<option value='col-lg-11'>col-lg-11</option>"&_
    "<option value='col-lg-12'>col-lg-12</option>"&_
    "</select></td>"&_
      "<td><select id='colxltype' size='1' name='colxltype' class='form-control'>"&_
    "<option value='none'>Yok</option>"&_
    "<option value='col-xl'>col-xl (Eşit)</option>"&_
    "<option value='col-xl-auto'>col-xl-auto (Otomatik)</option>"&_
    "<option value='col-xl-1'>col-xl-1</option>"&_
    "<option value='col-xl-2'>col-xl-2</option>"&_
    "<option value='col-xl-3'>col-xl-3</option>"&_
    "<option value='col-xl-4'>col-xl-4</option>"&_
    "<option value='col-xl-5'>col-xl-5</option>"&_
    "<option value='col-xl-6'>col-xl-6</option>"&_
    "<option value='col-xl-7'>col-xl-7</option>"&_
    "<option value='col-xl-8'>col-xl-8</option>"&_
    "<option value='col-xl-9'>col-xl-9</option>"&_
    "<option value='col-xl-10'>col-xl-10</option>"&_
    "<option value='col-xl-11'>col-xl-11</option>"&_
    "<option value='col-xl-12'>col-xl-12</option>"&_
    "</select></td>"&_
    "</tr></tbody></table></td>"
    coledit=coledit&"</tr>"
  coledit=coledit&"</table>"
    coledit=coledit&"<div class=""modal-footer""><input type=""submit""  onclick=colshowSerialize("""&checked&""","""&checked1&"""); name=""Submit5"" value=""Kaydet"" class=""btn btn-success pull-right""/><input type=""button"" class=""btn btn-secondary"" data-dismiss=""modal"" id=""col1close"&rowi&""" value=""Close""></div></div>"
    
    end function

    function addcolumn(checked,checked1,ollicount)
    addcolumn="<li data-id='col"&checked&""&ollicount&"' class='col-md-12' id='c"&checked&""&ollicount&"'>"&_
    "<div class='columnHead'><input type='hidden' name='colidh' value='c"&checked&""&ollicount&"' />"&_
    "<span class='columnTitle'><i class='fa fa-arrows'></i>"&_
    "</div>"&_
    "<ol class='columnParent2' id='m"&checked&""&ollicount&"'>"&_
    "<a class='divadd' onClick=btn4('c"&checked&""&ollicount&"','m"&checked&""&ollicount&"');>+</a>"&_
    "<a class='divdel' onclick=divremove('c"&checked&""&ollicount&"');>-</a>"&_
    "</ol>"&_
    "</li>"
    end function

    function modtext(checked,checked1,blockstring)   
      if instr(blockstring,",") then
    bscnt=ubound(split(blockstring,","))  
    modid=split(blockstring,",")(0)
    strmsbaslik=split(blockstring,",")(1)
    strmssayfa=split(blockstring,",")(2)
    strmsmodulid=split(blockstring,",")(3)
    strmstemp=split(blockstring,",")(4)
    strmsgoster=split(blockstring,",")(5)
    strmsonay=split(blockstring,",")(6)
    strmsmdurum=split(blockstring,",")(7)
        if bscnt>7 then
    strmsozel=split(blockstring,",")(8)
    strmsozelvar=split(blockstring,",")(9)
        end if
        if bscnt>9 then
    smidlock=split(blockstring,",")(10)
        end if
    end if
	'modtext="<div class=""modal fade"" id="""&checked&"""><div class=""modal-dialog"" role=""document""><div class=""modal-content""><div class=""modal-body"">"
	modtext="<div class=""modal-header""><button type=""button"" class=""close"" data-dismiss=""modal"" aria-label=""Kapat""><span aria-hidden=""true"">×</span></button><h4 class=""modal-title"" id=""myModalLabel2"">Modül Ayarları</h4></div><div class=""modal-body with-padding""><table class=""table table-striped"" id="""&checked&""">"
smid=modid
smidbaslika=strmsbaslik
smidmodulid=strmsmodulid
smidsayfa=strmssayfa
    'response.Write smidsayfa
smidtemp=strmstemp
session("tempbul")=smidtemp
smidgoster=strmsgoster
smidtoplu=1
smiddurum=strmsonay
     modtext=modtext&"<input name=""mid"" type=""hidden"" value="""&smid&""" />"
    modtext=modtext&"<input name=""toplu"" type=""hidden"" value="""&smidtoplu&""" />"
    modtext=modtext&"<input name=""ladet"" type=""hidden"" value=""0"" />"
	modtext=modtext&"<input name=""moduldurumu"" type=""hidden"" value="""&strmsmdurum&""" />"
	modtext=modtext&"<input name=""goster"" type=""hidden"" value=""2"" />"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>Sayfa</td>"
      modtext=modtext&"<td><select name=""sayfa"" id=""sayfa"" class=""selctize"">"
          modtext=modtext&"<option value=""0"">İçeriklere Özel </option>"
sqlString = "SELECT * from kategoriyazi where alt = '1'"&sayfagosterme&" order by modulmu,sira"
set mmmYardimci3 = Con.Execute (sqlString)
Do While Not mmmYardimci3.EOF
if smidtoplu="1" then
ayrac=""
ayrac1="k"
else
ayrac="k"
ayrac1="k"
end if
if ayrac1&""&mmmYardimci3("id")=ayrac&""&smidsayfa then
kys2="selected"
else
kys2=""
end if
          modtext=modtext&"<option value="""&ayrac1&""&mmmYardimci3("id")&""" "&kys2&" style=""background:#ebebeb;"">"&mmmYardimci3("isim")&"</option>"
sqlString = "SELECT * from yazilar where kategori='"&mmmYardimci3("id")&"' order by yazib desc"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
if smidtoplu="1" then
ayrac=""
ayrac1="y"
else
ayrac="y"
ayrac1="y"
end if
if ayrac1&""&mmmYardimci1("id")=ayrac&""&smidsayfa then
ys1="selected"
else
ys1=""
end if
          modtext=modtext&"<option value="""&ayrac1&""&mmmYardimci1("id")&""" "&ys1&">&nbsp;&nbsp;>&nbsp;"&mmmYardimci1("yazib")&"</option>"
         mmmYardimci1.MoveNext
  loop
  close(mmmYardimci1)
  
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci3("id")&"' order by isim desc"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
if smidtoplu="1" then
ayrac=""
ayrac1="k"
else
ayrac="k"
ayrac1="k"
end if
if ayrac1&""&mmmYardimci2("id")=ayrac&""&smidsayfa then
kys1="selected"
else
kys1=""
end if
          modtext=modtext&"<option value="""&ayrac1&""&mmmYardimci2("id")&""" "&kys1&">&nbsp;&nbsp;>&nbsp;"&mmmYardimci2("isim")&"</option>"

sqlString = "SELECT * from yazilar where kategori='"&mmmYardimci2("id")&"' order by yazib desc"
set mmmSayfa = Con.Execute (sqlString)
Do While Not mmmSayfa.EOF
if smidtoplu="1" then
ayrac=""
ayrac1="y"
else
ayrac="y"
ayrac1="y"
end if
if ayrac1&""&mmmSayfa("id")=ayrac&""&smidsayfa then
ys="selected"
else
ys=""
end if
 modtext=modtext&"<option value="""&ayrac1&""&mmmSayfa("id")&""" "&ys&">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;"&mmmSayfa("yazib")&"</option>"
        mmmSayfa.MoveNext
  loop
  close(mmmSayfa)
  
sqlString = "SELECT * from kategoriyazi where anasek='"&mmmYardimci2("id")&"' order by isim desc"
set mmmSayfa1 = Con.Execute (sqlString)
Do While Not mmmSayfa1.EOF
if smidtoplu="1" then
ayrac=""
ayrac1="k"
else
ayrac="k"
ayrac1="k"
end if

if ayrac&""&mmmSayfa1("id")=ayrac&""&smidsayfa then
kys="selected"
else
kys=""
end if

          modtext=modtext&"<option value="""&ayrac1&""&mmmSayfa1("id")&""" "&kys&">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;"&mmmSayfa1("isim")&"</option>"
   mmmSayfa1.MoveNext
  loop
  close(mmmSayfa1)
  mmmYardimci2.MoveNext
  loop
  close(mmmYardimci2)
  mmmYardimci3.MoveNext
  loop
  close(mmmYardimci3)
   	modtext=modtext&"</select></td>"
    modtext=modtext&"</tr>"
        
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>Opsiyonel Tanımlama Başlığı</td>"
      modtext=modtext&"<td><input name=""baslik"" type=""text"" value="""&smidbaslika&""" class=""form-control""/></td>"
    modtext=modtext&"</tr>"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>İçerik Özel Id</td>"		
      modtext=modtext&"<td><div class=""input-group""><div class=""input-group-btn""><select name=""sayfaozelvar"" class=""form-control"" style=""width:80px;"">"
		  if instr(smidsayfa,"vip") then
		  mgsov="selected"
		  elseif strmsozelvar="1" then
		  mgsov="selected"
		  else
		  mgsov=""
		  end if
		  if instr(smidsayfa,"vip") then
		  mgsovv=""
		  else
		  mgsovv="selected"
		  end if
          modtext=modtext&"<option value=""0"" "&mgsovv&">Pasif</option>"
          modtext=modtext&"<option value=""1"" "&mgsov&">Aktif</option>"
        modtext=modtext&"</select></div><input name=""sayfaozel"" type=""text"" value="""&replace(smidsayfa,"vip","")&""" class=""form-control""/></div></td>"
    modtext=modtext&"</tr>"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td width=""34%"" valign=""top"">Mod&uuml;l  :</td>"
      modtext=modtext&"<td width=""66%""><select name=""moduller"" class=""selctize"" >"
          modtext=modtext&"<option value=""0"" selected=""selected"">Mod&uuml;l Se&ccedil; </option>"
		sqlString = "select * from moduller where durum = '1' and temp<>'99999' and"&modulgosterme&" order by moduladi"
set mmmYardimci3 = Con1.Execute (sqlString)
if mmmYardimci3.eof then
else
Do While Not mmmYardimci3.EOF
if mmmYardimci3("id")&""=""&smidmodulid then
mls="selected"
else
mls=""
end if
          modtext=modtext&"<option value="""&mmmYardimci3("id")&""" "&mls&">"&mmmYardimci3("moduladi")&"</option>"
      										  
							mmmYardimci3.MoveNext
  loop
end if

Close(mmmYardimci3)

        modtext=modtext&"</select></td>"
    modtext=modtext&"</tr>"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>Temp</td>"
      modtext=modtext&"<td><select name=""temp"" class=""form-control"">"
          modtext=modtext&"<option value=""0""> Listeleme Tempi </option>"
sqlString = "select * from kategoriayar where adres='0'  order by id desc"
set mmmYardimci3 = Con.Execute (sqlString)
Do While Not mmmYardimci3.EOF
if mmmYardimci3("id")&""=""&smidtemp then
kas="selected"
else
kas=""
end if
modtext=modtext&"<option value="""&mmmYardimci3("id")&""" "&kas&">"&mmmYardimci3("kate")&"</option>"
mmmYardimci3.MoveNext
loop
close(mmmYardimci3)
        modtext=modtext&"</select></td>"
   modtext=modtext&"</tr>"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>Kilit :</td>"
      modtext=modtext&"<td><select name=""lock"" class=""form-control"">"
		  if "1"=smidlock then
		  mgyssss="selected"
		  else
		  mgyssss=""
		  end if
		  if "1"=smidlock then
		  mgysss=""
		  else
		  mgysss="selected"
		  end if
          modtext=modtext&"<option value=""1"" "&mgyssss&">Kilitli</option>"
          modtext=modtext&"<option value=""0"" "&mgysss&">Kilitsiz</option>"
        modtext=modtext&"</select></td>"
   modtext=modtext&"</tr>"
    modtext=modtext&"<tr>"
      modtext=modtext&"<td>Durum :</td>"
      modtext=modtext&"<td><select name=""yetki"" class=""form-control"">"
		  if "1"=smiddurum then
		  mgys="selected"
		  else
		  mgys=""
		  end if
		  if "1"=smiddurum then
		  mgyss=""
		  else
		  mgyss="selected"
		  end if
          modtext=modtext&"<option value=""1"" "&mgys&">Aktif</option>"
          modtext=modtext&"<option value=""0"" "&mgyss&">Pasif</option>"
        modtext=modtext&"</select></td>"
   modtext=modtext&"</tr>"
  modtext=modtext&"</table>"
    modtext=modtext&"<div class=""modal-footer""><input type=""submit""  onclick=showSerialize("""&checked&""","""&checked1&"""); name=""Submit5"" value=""Kaydet"" class=""btn btn-success pull-right""/><input type=""submit""  onclick=showSerialize25("""&checked&""","""&checked1&"""); name=""Submit5"" value=""Kaydet 25"" class=""btn btn-success pull-right""/><input type=""button"" class=""btn btn-secondary"" data-dismiss=""modal"" id=""modul1close"&rowi&""&modulid&""&coli&""&modi&""" value=""Close""></div></div>" 
  end function

    function addmodul(checked,checked1,ollicount)
    json=server.URLEncode("1,Yeni Modul,0,0,0,2,1,1,0,0")
    funstr="<li data-modulid='0' data-json='"&json&"' data-jsonold='' id='mod"&checked&""&ollicount&"' data-id='mod"&checked&""&ollicount&"' class='modull'>"
    funstr=funstr&"<div class='modulHead'>"
    funstr=funstr&"<div style='float:left; line-height:24px;'><span class='modulTitle'><i class='fa fa-arrows'></i>Yeni Modül</span></div>"
    funstr=funstr&"<div class='w-100 text-center' style='float:right; margin-left:10px; margin-top:5px;'>"
    funstr=funstr&"<div class='ienlarger' style='float:left;' data-toggle='tooltip' data-placement='bottom' data-original-title='Düzenle'><a href='db.asp?islem=blocktab&blocktabcol=editmodul&checked=md"&checked&"&checked1=mod"&checked&""&ollicount&"&blockstring="&json&"' class='dropdown-toggle moduledit' data-toggle='modal' data-target='#moduladd' style='cursor:pointer;'><em class='fa fa-pencil-alt iconadmin' style='color:#39C;'></em></a></div> "
    funstr=funstr&"<div class='ienlarger' style='float:left;'><a onclick=divremove('mod"&checked&""&ollicount&"') data-toggle='tooltip' data-placement='bottom' data-original-title='Sil' style='cursor:pointer;' class='delmodul'><em class='fa fa-trash iconadmin' style='color:#F00;'></em></a></div>"
    funstr=funstr&"</div></div></li>"
    'funstr=funstr&"<div class='modal fade' id='md"&checked&""&ollicount&"'><div class='modal-dialog' role='document'><div class='modal-content'><div class='modal-body'>"&response.Write(replace(modtext(1,"Yeni Modul",0,0,0,2,1,"md"&checked&""&ollicount&"",1),"""","'"))&"</div><div class='modal-footer'><input type='submit' onclick=mdetailjs('md"&checked&""+ollicount+"') name='Submit5' value='Kaydet' class='btn btn-success pull-right'/><input type='button' class='btn btn-secondary' data-dismiss='modal' value='Close'></div></div></div></div>"
    addmodul=funstr
    end function



    sub seoserp(strid,seoturu,ceviridileki,aktifdil,serpupdatelink)
    
sqlString = "select * from seolar where seoid='"&strid&"' and seoturu='"&seoturu&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
smidseolar="0"
smidlang=aktifdil
smidseolink=baslikkont(strisim)&""&seosonu&""
else
smidseolar="1"
smidtitle=mmmYardimci("seobaslik")
smiddescri=mmmYardimci("seoaciklama")
smidpcss=mmmYardimci("seoanahtar")
smidpjs=mmmYardimci("seohtml")
smidkeysi=mmmYardimci("seotag")
smidh1=mmmYardimci("seoh1")
smidata=mmmYardimci("structred")
smidatastatu=mmmYardimci("structredstatu")
smidseolink=mmmYardimci("seolink")
smidlang=mmmYardimci("lang")
            smidhraflang=mmmYardimci("hraflang")
            smidcanoncial=mmmYardimci("canoncial")
seonoindex=mmmYardimci("noindex")
        if smidlang="" then
        smidlang=aktifdil
        end if
end if
close(mmmYardimci)

   %>
<form action="?" name="custlist17" method="post">
                           
                <input name="dkate2" type="hidden" value="<%=strid%>" />
                <input name="lang" type="hidden" value="<%=smidlang%>" />
                <input name="seolar" type="hidden" value="<%=smidseolar%>" />
                <input name="sisim" type="hidden" value="<%=strisim%>" />
            <input type="hidden" name="charcode" value="<%=ceviridileki%>" />
                           <%if smidtitle="" and  dkate2="835" then 
                               else
                              sitetitle=smidtitle
                               end if
                               if smiddescri="" and  dkate2="835" then 
                               else
                              sitedesc=smiddescri
                               end if
                               if smidkeysi="" and  dkate2="835" then 
                               else
                              sitekey=smidkeysi
                               end if%> 
                             <div class="col-sm-12 icerik1 icerik">
                <span style="opacity:0;" id="seoh1"><%=smidh1%></span>
                <span style="opacity:0;" id="seotitle"><%=sitetitle%></span>
                <span style="opacity:0;" id="seoDescription"><%=sitedesc%></span>
                <span style="opacity:0;" id="seoKey"><%=smidkeysi%></span>
                <span style="opacity:0;" id="seoUrl"><%=smidseolink%></span>
                <span style="opacity:0;" id="seoUrlpath"><%=siteadres&""%></span>
                            <!--#Include file="serp.html"-->
                                 </div>
                             <div class="col-sm-12 icerik1 icerik">
                                 <div class="input-group"><div class="input-group-addon">noIndex</div><label><input name="seonoindex" class="flatblue" type="checkbox" value="1"<%if seonoindex="1" then %> checked="checked"<%end if %> />Arama Motorlarında Indexleme</label></div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="input-group"><div class="input-group-addon">Seo Linkini Oluştur</div><label> &nbsp;&nbsp; <%if smiddurum1 = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("seolinkyenile","Sayfa Adına Göre Seolinkini Güncelle",iks,cbcdisstr,cbccheckstr,"success"))%> &nbsp;&nbsp;Yazı Başlığına Göre Oluştur.</label></div>
                             </div>
                             
            <div class="form-title col-sm-12 form-group icerik1 icerik">
                <label style="font-size: 19px">Canoncial Linki</label><small>Kendi Linki Ekleniyor. Ek Eklemek istenirsen
                    doldurulmalı.</small>
                <input type="text" name="seocanoncial" id="seocanoncial" value="<%=smidcanoncial%>" class="form-control" />
            </div>
            <div class="form-title col-sm-12 icerik1 icerik">
                <label for="hreflang" style="font-size: 19px">Hreflang Tagleri</label><small>Sistem Ekliyor istenirse düzenleme
                    yapılabilir. Boş bırakılırsa sistem yine otomatik ekler</small>
                <textarea name="seohraflang" id="beautified1" style="width: 100%; class="
                    form-control"><%=smidhraflang %></textarea>
                          
            </div>
            <%if seoturu="sayfa" then%>
                <div class="form-title col-sm-12 icerik1 icerik">
                    <label for="smidpcss" style="font-size: 19px">Page Css</label><small>Sayfaya Özel Css Dosyası Eklemek İsterseniz
                        Doldurun.</small>
                    <textarea name="smidpcss" id="beautified2" style="width: 100%;"
                        class="form-control"><%=smidpcss %></textarea>
                           
                </div>
                <div class="form-title col-sm-12 icerik1 icerik">
                    <label for="smidpjs" style="font-size: 19px">Page Js</label><small>Sayfaya Özel Js Dosyası Eklemek İsterseniz
                        Doldurun.</small>
                    <textarea name="smidpjs" id="beautified3" style="width: 100%;"
                        class="form-control"><%=smidpjs %></textarea>
                </div>
                <%end if%>
                    <div class="form-title col-sm-12 icerik1 icerik">
                        <label for="smidpdata" style="font-size: 19px">Page Data Structured</label><small>Sayfaya Özel Data
                            Structured Eklemek İsterseniz Doldurun. Otomatik Doldurması İçin Butonu Seçin.</small>
                        <input name="smidpstatu" class="flatblue" type="checkbox" value="1" <%if smidatastatu="1" then %>
                        checked="checked"<%end if %> />
                            <textarea name="smidpdata" id="beautified4" style="width: 100%;"
                                class="form-control"><%=smidata %></textarea>
                            <script>
                                window.addEventListener('DOMContentLoaded', () => {
                                    setTimeout(() => {
                                        format25(1, 'text/html', ai, ['rewrite_html_seo'], true);
                                        format25(2, 'text/html', ai, ['rewrite_html_seo'], true);
                                        format25(3, 'text/html', ai, ['translate_text', 'rewrite_html_seo'], true);
                                        format25(4, 'text/html', ai, ['translate_text', 'rewrite_html_seo'], true);
                                        format25(5, 'text/html', false, ['translate_text', 'rewrite_html_seo'], false);
                                    }, 2000);
                                });
                            </script>
                    </div>

                                                          

      <input name="Submit" type="submit" value="Düzenle" class="btn btn-primary pull-right" style="width:100% !important;" ONCLICK="this.form.submit();formla7('<%=serpupdatelink%>');"/>  
    </form>

    
    <%if aits="true" then%>
    <hr>
<div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="card-body">
          <h3 class="card-title mb-4">AI ile Seo Önerisi Al</h3>
          

            <div class="seo-analyze-bar">
 <div class="form-group mb-3"> <input id="crawl-url-5" class="form-control" value="<%=siteadres&smidseolink%>" placeholder="https://..."></div>
  <div class="form-group mb-3"><button class="btn btn-primary" id="btn-crawl-5">Crawl</button></div>
  <br>
  <textarea name="smidpanalyze" id="beautified5" style="width: 100%;" class="form-control"></textarea>
  <br>
  <div class="form-group mb-3">
    <input type="text" placeholder="Ek prompt (örn: teknik İngilizceye çevir)" id="ai_extra_5" class="form-control" style="flex: 1 1 0%; margin-bottom:5px">
    <button class="btn btn-success" id="btn-analyze-fast-5">Analyze</button>
    <button class="btn btn-success" id="btn-analyze-deep-5">Derin Analiz (AI)</button>
    <button class="btn" id="btn-analyze-json-5" style="display: none;">JSON'u Göster</button></div>
</div>

<br><br>
          <h3 class="card-title mb-4">AI Seo Önerileri</h3>
<div id="resultaudit" class="mt-4">
    <div class="form-group mb-3">
        <label>Title</label>
<input id="titleField" placeholder="Title" class="form-control"></div>
<div class="form-group mb-3">
        <label>MetaDesc</label>
<input id="metaDescField" placeholder="Meta Description" class="form-control"></div>
<div class="form-group mb-3">
        <label>Issues</label>
<textarea id="issuesField" rows="6" class="form-control"></textarea></div>
<div class="form-group mb-3">
        <label>Suggestions</label>
<textarea id="suggestionsField" rows="6" class="form-control"></textarea></div>
<div class="form-group mb-3">
        <label>Schema</label>
<textarea id="schemaField" rows="6" class="form-control"></textarea></div>

          </div>
        </div>
      </div>
    </div>
  </div>

<!--
<div class="form-group mb-3"><input id="seoUrlprefer" type="url" placeholder="https://..." value="<%=siteadres&smidseolink%>" class="form-control"></div>
<div class="form-group mb-3"><button id="audit" class="btn btn-primary">SEO Önerisi Al</button></div>
-->
<script>
document.getElementById('audit').onclick = async ()=>{
  const url = document.getElementById('seoUrlprefer').value.trim();
  if (!url) return alert('URL girin');
  try{
    const out = await callProxy('analyze_seo_url', { url });
    const j = JSON.parse(out); // JSON string dönüyor
    titleField.value    = j.title || '';
    metaDescField.value = j.meta_description || '';
    issuesField.value   = (j.issues||[]).join('\n');
    schemaField.value   = j.schema_jsonld || '[]';
  }catch(e){ alert(e.message); }
};
</script>

    
    <%end if%>

    <%if seoturu="sayfa" then%>
          <hr>                       
   <div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="card-body">
          <h3 class="card-title mb-4">Critical CSS Oluştur</h3>

          <form id="criticalForm">
            <div class="form-group mb-3">
              <label for="url" class="form-label">Sayfa URL</label>
              <input type="text" id="url" name="url" class="form-control" placeholder="<%=siteadres%><%=smidseolink%>" value="<%=siteadres%><%=smidseolink%>" required>
            </div>

            <div class="form-group mb-3">
              <label for="ekad" class="form-label">Etiket (Dosya adı)</label>
              <input type="text" id="ekad" name="ekad" class="form-control" value="<%=smidsayara%>" placeholder="home, contact, tour1..." required>
            </div>

            <button type="submit" class="btn btn-primary w-100">CSS Üret</button>
          </form>

          <div id="result" class="mt-4"></div>
        </div>
      </div>
    </div>
  </div>

<script>
   function copyCommand(a) {
    const text = document.getElementById(""+a+"").innerText.trim();
    navigator.clipboard.writeText(text).then(function() {
      document.getElementById("copySuccess").style.display = "block";
      setTimeout(() => {
        document.getElementById("copySuccess").style.display = "none";
      }, 2000);
    }, function(err) {
      alert("❌ Kopyalama başarısız: " + err);
    });
  }

  document.getElementById('criticalForm').addEventListener('submit', async function (e) {
    e.preventDefault();
  
    const url = document.getElementById('url').value.trim();
    const ekad = document.getElementById('ekad').value.trim();
    const resultDiv = document.getElementById('result');
  
    resultDiv.innerHTML = `
      <div class="alert alert-info">⏳ CSS oluşturuluyor, lütfen bekleyin...</div>
    `;
  
    try {
      const response = await fetch('opt/generate-critical-from-post.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url, ekad })
      });
  
      const data = await response.json();
  
      if (data.error) {
        resultDiv.innerHTML = `<div class="alert alert-danger">❌ ${data.error}</div>`;
        return;
      }
  
      resultDiv.innerHTML = `
        <div class="alert alert-success">✅ CSS başarıyla oluşturuldu!</div>
        <ul class="list-group">
          <li class="list-group-item">Target: ${data.targetDir}</li>
          <li class="list-group-item">🖥️ Desktop: <code>${data.desktop.outputFile}</code> - ${data.desktop.status} - ${data.desktop.command}</li>
          <li class="list-group-item">📱 Mobile: <code>${data.mobile.outputFile}</code> - ${data.mobile.status} - ${data.mobile.command}</li>
        </ul>
        <details class="mt-3">
          <summary>📝 Logları Göster</summary>
          <pre class="bg-dark text-white p-3 mt-2 rounded" style="font-size: 0.85rem;">${[...data.desktop.log, ...data.mobile.log].join('\n')}</pre>
        </details>
      `;
    } catch (err) {
      resultDiv.innerHTML = `<div class="alert alert-danger">❌ Bir hata oluştu: ${err.message}</div>`;
    }
  });
  </script>
<%end if%>

  <%end sub

      sub formcontentcall(fgtur,formid) %>

						<div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Form Dataları</h4>
                        </div>

						<div class="modal-body with-padding" style="padding: 0px; margin: 0px; width: 100%;">
                          <div class="panel-body">
      
              <%
	'gorozel1=" and (id <> 424 and id<>429 and id<>422 and id<>421 and id<>320 and id<>317 and id <> 423 and id <> 312)"

	 set mmmYardimci6 = Con.Execute ("select * from ozellikler where formid='"&formid&"'"&gorozel1&" and alt = '1' order by sira")

Do While Not mmmYardimci6.EOF
fname=mmmYardimci6("name")
fisim=mmmYardimci6("isim")
fid=mmmYardimci6("id")
ftur=mmmYardimci6("tur")
formisim=dilformv(fid,fisim,lang)
if ftur=8 then%>
<div class="grupanabaslik"><%=formisim%> : </div><div class="grupform1">
<%
 set mmmYardimci61 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid&"' order by sira")
 if mmmYardimci61.eof then
 response.Write(formolustur(fgtur,0,fid,fovalue))
 else
Do While Not mmmYardimci61.EOF
fid1=mmmYardimci61("id")
fisim1=mmmYardimci61("isim")
ftur1=mmmYardimci61("tur")
formisim1=dilformv(fid,fisim,lang)
if ftur1=8 then
%>
<div class="grupanabaslik"><%=formisim1%> : </div><div class="grupform1">
<%
 set mmmYardimci62 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid1&"' order by sira")
 if mmmYardimci62.eof then
 response.Write(formolustur(fgtur,0,fid1,fovalue))
 else
Do While Not mmmYardimci62.EOF
fid3=mmmYardimci62("id")
ftur3=mmmYardimci62("tur")
response.Write(formolustur(fgtur,0,fid3,fovalue))
		fname3=""				  
mmmYardimci62.movenext
loop
end if
close(mmmYardimci62)
%>
</div>
<%
else
response.Write(formolustur(fgtur,0,fid1,fovalue))
end if

		fname1=""				  
mmmYardimci61.movenext
loop
end if
close(mmmYardimci61)
%>
</div>
<%
else
response.Write(formolustur(fgtur,0,fid,fovalue))
end if
		fname=""				  
mmmYardimci6.movenext
loop
close(mmmYardimci6)
session("uye_kodu1")="1"
set mmmYardimci62 = Con.Execute ("select response from ozellikler2 where formid='"&formid&"' and ozelikid = '1' and isim = '1' and tur ='"&fgtur&"'")
 if mmmYardimci62.eof then
 else
strresponse=mmmYardimci62("response")
if instr(strresponse,"<span title=") then
response.Write "<div class=""grupanabaslik"">"&(split(split(strresponse,"<span title=")(1),">...")(0))&"</div>"
else 
response.Write strresponse
end if
end if
close(mmmYardimci62)

%>
            </div>
            </div>

						<div class="modal-footer">
							<button class="btn btn-warning" data-dismiss="modal">Close</button>
						</div>
        <%
            response.end
            end sub 
%>
<%
Submit=Request.QueryString("Submit")
if Submit="Resimsil" then
call Resimsil
elseif Submit="resimDuzenle" then
call resimDuzenle
elseif Submit="formnDuzenle" then
call formnDuzenle
elseif Submit="formnSil" then
call formnSil
elseif Submit="formDuzenle" then
call formDuzenle
elseif Submit="formtDuzenle" then
call formtDuzenle
elseif Submit="formSil" then
call formSil
elseif Submit="formsmtpDuzenle" then
call formsmtpDuzenle
elseif Submit="formtsmtpDuzenle" then
call formtsmtpDuzenle
elseif Submit="formsmtpSil" then
call formsmtpSil
elseif Submit="formiDuzenle" then
call formiDuzenle
elseif Submit="formiSil" then
call formiSil
elseif Submit="formgDuzenle" then
call formgDuzenle
elseif Submit="formgSil" then
call formgSil
elseif Submit="eskseolinkDuzenle" then
call eskseolinkDuzenle
elseif Submit="eskseolinkSil" then
call eskseolinkSil
elseif Submit="yetkiDuzenle" then
call yetkiDuzenle
elseif Submit="ortakyetkiDuzenle" then
call ortakyetkiDuzenle
elseif Submit="yetkiSil" then
call yetkiSil
elseif Submit="Duzenle" then
call Duzenle
elseif Submit="Sil" then
call Sil
elseif Submit="Duzenleicerikt" then
call Duzenleicerikt
elseif Submit="Kopyalaicerikt" then
call Kopyalaicerikt
elseif Submit="Duzenleiceriktm" then
call Duzenleiceriktm
elseif Submit="Silicerik" then
call Silicerik
elseif Submit="SilSeolink" then
call SilSeolink
elseif Submit="sayfaayarduzenle" then
call sayfaayarduzenle
elseif Submit="sayfatDuzenle" then
call sayfatDuzenle
elseif Submit="Duzenlesayfaicerik" then
call Duzenlesayfaicerik
elseif Submit="DuzenlesayfaTur" then
call DuzenlesayfaTur
elseif Submit="silsayfatur" then
call silsayfatur

else
end if
%>
<%

 sub dilduzenle1
  Set Upload = Server.CreateObject("Persits.Upload")

' This is needed to enable the progress indicator
Upload.ProgressID = Request.QueryString("PID")

Upload.OverwriteFiles = true
Count = Upload.Save(Server.MapPath("/images/dil"))
For Each File in Upload.Files

tip = trim(file.Filename) 
fname=file.Filename
ressize=File.Size
rest=Right(file.Filename,3)
Next	
Con.execute("update diller1 set not='"&fname&"' where id="&upload.form("yazarid")&"")
response.redirect("?sek="&request.QueryString(request.QueryString("sek"))&"")
end sub

%> 

<%
sub sayfaayarduzenle
if request.Form("harici")=1 then
link = request.Form("link")
target = request.Form("target")
else
link = 0
target = 0
end if
Con.execute("update kategoriyazi set durum='"&Request.Form("durum")&"',title='"&Request.Form("title")&"',desc='"&Request.Form("desc")&"',key='"&Request.Form("key")&"',link='"&link&"',target='"&target&"',okusayi='"&Request.Form("okusayi")&"',sosyal1='"&Request.Form("sosyal1")&"',sosyal2='"&Request.Form("sosyal2")&"',facebookyorum='"&Request.Form("facebookyorum")&"',sayara='"&Request.Form("sayara")&"',stura='"&Request.Form("stura")&"',smodula='"&Request.Form("smodula")&"',sayfatemp='"&Request.Form("sayfatemp")&"',sol='"&Request.Form("sol")&"',orta='"&Request.Form("orta")&"',sag='"&Request.Form("sag")&"' where id="&request("id")&"")
session("hata1")="Sayfa Modulü Düzenlendi"
session("hatam1")="green"
end sub%> 


<%
sub DuzenlesayfaTur


if request("duzenlemetur")="sayfa" then
Con.execute("update kategoriayar set kate='"&Request.Form("ad")&"',adres='"&Request.Form("dkate2")&"',bilgi1='"&Request.Form("bilgi1")&"',bilgi2='"&Request.Form("bilgi2")&"',bilgi3='"&request.Form("bilgi3")&"',bilgi4='"&request.Form("bilgi4")&"',bilgi1i='"&Request.Form("bilgi1i")&"',bilgi2i='"&Request.Form("bilgi2i")&"',bilgi3i='"&Request.Form("bilgi3i")&"',bilgi4i='"&Request.Form("bilgi4i")&"' where id="&request("id")&"")
else
end if

for ho= 1 to request.Form("cssnbas").count
if request.Form("cssnbas")(ho)="" then
else
logocssnbas="/*"&request.Form("cssnbas")(ho)&"*/"

logocssnana=""&logocssnana&""&logocssnbas&""&request.Form("logodegera"&ho&"")&""
logocss=""
logocssana=""

end if
next
if request("duzenlemetur")="liste" then
if request.form("listecss")="1" then
l10= request.Form("csstam")
else
l10=logocssnana
end if
Con.execute("update kategoriayar set l1='"&Request.Form("l1")&"',l2='"&Request.Form("l2")&"',l3='"&Request.Form("l3")&"',l4='"&Request.Form("l4")&"',l5='"&request.Form("l5")&"',l6='"&request.Form("l6")&"',l7='"&Request.Form("l7")&"',l8='"&Request.Form("l8")&"',l9='"&Request.Form("l9")&"',l10='"&l10&"' where id="&request("id")&"")
else
end if

if request("duzenlemetur")="resim" then
rs("r1")= request.Form("r1")
rs("r2")= request.Form("r2")
rs("r3")= request.Form("r3")
rs("r4")= request.Form("r4")
rs("r5")= request.Form("r5")
if request.form("listecss")="1" then
r6= request.Form("csstam")
else
r6=logocssnana
end if
Con.execute("update kategoriayar set r1='"&Request.Form("r1")&"',r2='"&Request.Form("r2")&"',r3='"&Request.Form("r3")&"',r4='"&Request.Form("r4")&"',r5='"&request.Form("r5")&"',r6='"&r6&"' where id="&request("id")&"")
else
end if

if request("duzenlemetur")="icerik" then
if request.form("listecss")="1" then
i8= request.Form("csstam")
else
i8=logocssnana
end if
Con.execute("update kategoriayar set i1='"&Request.Form("i1")&"',i2='"&Request.Form("i2")&"',i3='"&Request.Form("i3")&"',i4='"&Request.Form("i4")&"',i5='"&Request.Form("i5")&"',i6='"&Request.Form("i6")&"',i7='"&request.Form("i7")&"',i8='"&i8&"' where id="&request("id")&"")
else
end if


'response.Write("ilan")
end sub%> 


<%
sub silsayfatur
id = Request.QueryString("id")

id = Request("urunid")
For icntt = 1 To Request.Form("id").Count 
silmek = "delete from kategoriayar where id="&Request.Form("id")(icntt)&""
Con.execute(silmek)
next

session("hata1")="Sayfa Türleri Silindi"
session("hatam1")="red"

end sub
%>
<%
sub silsayfaturtek

id = Request("id")
silmek = "delete from kategoriayar where id="&id&""
Con.execute(silmek)

session("hata1")="Sayfa Türü Silindi"
session("hatam1")="red"
end sub
%>

<% 	
sub eklesayfatur

sqlString = "select * from kategoriayar where id="&request("turu")&" order by id desc"
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
Con.execute("insert kategoriayar set kate = "&request.Form("sektor")&",adres= "&request.Form("dkate2")&",bilgi1 = '0',bilgi2 = '0',bilgi3= '0',bilgi4= '0',bilgi1i= "&request.Form("bilgi1i")&",bilgi2i= "&request.Form("bilgi2i")&",bilgi3i= "&request.Form("bilgi3i")&",bilgi4i= "&request.Form("bilgi4i")&",l1= "&request.Form("l1")&",l2= "&request.Form("l2")&",l3= "&request.Form("l3")&",l4= "&request.Form("l4")&",l5= "&request.Form("l5")&",l6= "&request.Form("l6")&",l7= "&request.Form("l7")&",l8= "&request.Form("l8")&",l9= "&request.Form("l9")&",l10= "&request.Form("l10")&",r1= "&request.Form("r1")&",r2= "&request.Form("r2")&",r3= "&request.Form("r3")&",r4= "&request.Form("r4")&",r5= "&request.Form("r5")&",r6= "&request.Form("r6")&",i1= "&request.Form("i1")&",i2= "&request.Form("i2")&",i3= "&request.Form("i3")&",i4= "&request.Form("i4")&",i5= "&request.Form("i5")&",i6= "&request.Form("i6")&",i7= "&request.Form("i7")&",i8= "&request.Form("i8")&"")
else
Con.execute("insert kategoriayar set kate= '"&request.Form("sektor")&"',adres=  '"&request.Form("dkate2")&"',bilgi1 = '"&mmmGenel("bilgi1")&"',bilgi2 = '"&mmmGenel("bilgi2")&"',bilgi3= '"&mmmGenel("bilgi3")&"',bilgi4= '"&mmmGenel("bilgi4")&"',bilgi1i= '"&mmmGenel("bilgi1i")&"',bilgi2i= '"&mmmGenel("bilgi2i")&"',bilgi3i= '"&mmmGenel("bilgi3i")&"',bilgi4i= '"&mmmGenel("bilgi4i")&"',l1= '"&mmmGenel("l1")&"',l2= '"&mmmGenel("l2")&"',l3= '"&mmmGenel("l3")&"',l4= '"&mmmGenel("l4")&"',l5= '"&mmmGenel("l5")&"',l6= '"&jskont(mmmGenel("l6"))&"',l7= '"&mmmGenel("l7")&"',l8= '"&mmmGenel("l8")&"',l9= '"&mmmGenel("l9")&"',l10= '"&csskont(mmmGenel("l10"))&"',r1= '"&mmmGenel("r1")&"',r2= '"&mmmGenel("r2")&"',r3= '"&mmmGenel("r3")&"',r4= '"&mmmGenel("r4")&"',r5= '"&mmmGenel("r5")&"',r6= '"&csskont(mmmGenel("r6"))&"',i1= '"&mmmGenel("i1")&"',i2= '"&mmmGenel("i2")&"',i3= '"&mmmGenel("i3")&"',i4= '"&mmmGenel("i4")&"',i5= '"&mmmGenel("i5")&"',i6= '"&mmmGenel("i6")&"',i7= '"&mmmGenel("i7")&"',i8='"&csskont(mmmGenel("i8"))&"'")
end if
close(mmmGenel)

session("hata1")="Sayfa Türü Eklendi"
session("hatam1")="green"
end sub
%>
<%
sub Duzenle
  '  response.Write Request.Form
    'response.End
For idk = 1 To Request.Form("onay").Count and Request.Form("menugosterim").Count and  Request.Form("sayfalama").Count and Request.Form("sayfaadi").Count and Request.Form("urunid").Count and Request.Form("sifreli").Count
sayilink = sifreuret()
if request.Form("sayfalama")(idk)=1 then
alt = 1
else
alt = 0
end if
if request.Form("sayfaadi")(idk)="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("sayfaadi")(idk)
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
sqlString = "update kategoriyazi set durum='"&request.Form("onay")(idk)&"',menugosterim='"&request.Form("menugosterim")(idk)&"',anasek='"&request.Form("sayfalama")(idk)&"',sifreli='"&request.Form("sifreli")(idk)&"',seolink='"&seolink&"',alt='"&alt&"',isim='"&csskont(request.Form("sayfaadi")(idk))&"', sira='"&idk&"' where id="&request.form("urunid")(idk)&""
Con.execute(sqlString)

next

session("hata1")="Sayfa Düzenlendi"
session("hatam1")="green"
end sub

sub Duzenleiceriktm
For icntt = 1 To Request.Form("onayi").Count and Request.Form("sayfalama").Count and  Request.Form("iceriktur").Count and Request.Form("icerikadi").Count and Request.Form("urunid").Count

strbaslikurun=request.Form("icerikadi")(icntt)

yazibb=csskont(strbaslikurun)
sqlString = "update yazilar set durum='"&request.Form("onayi")(icntt)&"',kategori='"&request.Form("sayfalama")(icntt)&"',urunid='"&request.Form("iceriktur")(icntt)&"',sira='"&icntt&"',yazib='"&yazibb&"' where id="&request.form("urunid")(icntt)&""
Con.execute(sqlString)

next
session("hata1")="İçerikler Düzenlendi"
session("hatam1")="green"

end sub


sub Duzenleicerikt
For icntt = 1 To Request.Form("onayi").Count and Request.Form("ilksayfa").Count and  Request.Form("sayfalama").Count and  Request.Form("iceriktur").Count and Request.Form("icerikadi").Count and Request.Form("urunid").Count and Request.Form("sifreli").Count
sayilink = sifreuret()
if request.Form("icerikadi")(icntt)="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("icerikadi")(icntt)
end if
yazibb=csskont(strbaslikurun)
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
sqlString = "SELECT * FROM yazilar where seolink='"&seomlink&"' and id<>"&request.form("urunid")(icntt)&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
seolink= seomlink
else
seolink= replace(seomlink,""&seosonu&"","")&"-"&sayilink&""&seosonu&""
end if
close(mmmYardimci)
',sira='"&icntt&"'
sqlString = "update yazilar set durum='"&request.Form("onayi")(icntt)&"',ilksayfa='"&request.Form("ilksayfa")(icntt)&"',kategori='"&request.Form("sayfalama")(icntt)&"',sifreli='"&request.Form("sifreli")(icntt)&"',seolink='"&seolink&"',urunid='"&request.Form("iceriktur")(icntt)&"',sira='"&icntt&"',yazib='"&yazibb&"' where id="&request.form("urunid")(icntt)&""
Con.execute(sqlString)

next
    call islemmessagesession("green","İçerikler Düzenlendi",1)
end sub

sub SilSeolink
if Request.QueryString("linksil")="" then
urunidiceriksilic=Request.Form("linksil").count
else
urunidiceriksilic=1
end if

For r = 1 To urunidiceriksilic
if Request.QueryString("linksil")="" then
urunidiceriksili=Request.Form("linksil")(r)
else
urunidiceriksili=Request.QueryString("linksil")
end if
    
silmek = "delete from seolar where id="&urunidiceriksili&""
Con.execute(silmek)

next
    
    call islemmessagesession("red","Linkler Silindi",1)
session("hata1")="Linkler Silindi"
session("hatam1")="red"

response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

sub Silicerik
if Request.QueryString("iceriksil")="" then
urunidiceriksilic=Request.Form("iceriksil").count
else
urunidiceriksilic=1
end if

For r = 1 To urunidiceriksilic
if Request.QueryString("iceriksil")="" then
urunidiceriksili=Request.Form("iceriksil")(r)
else
urunidiceriksili=Request.QueryString("iceriksil")
end if
 call sayfasil2(urunidiceriksili)
    if eser="1" then
sqlString = "select * from yazilar where id="&urunidiceriksili&""
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF

sqlString = "select * from resimd where baslik='"&mmmGenel("id")&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
resimsili=mmmYardimci("resimid")
set dosyasis=CreateObject("Scripting.FileSystemObject")

mmmYardimci.MoveNext
  loop
end if
close(mmmYardimci)

mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)

silmek = "delete from yazilar where id="&urunidiceriksili&""
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&urunidiceriksili&"'"
Con.execute(silmek)

silmek = "delete from resimd where baslik='"&urunidiceriksili&"'"
Con.execute(silmek)

silmek = "delete from ozellikler2 where kateid='"&urunidiceriksili&"'"
Con.execute(silmek)
    end if

next
    
    call islemmessagesession("red","İçerikler Silindi",1)
session("hata1")="İçerikler Silindi"
session("hatam1")="red"

response.Redirect("sayfalar.asp?dkate2="&request("dkate2")&"&sek="&request("dkate2")&"")
end sub

sub Kopyalaicerikt
if Request.QueryString("iceriksil")="" then
urunidiceriksilic=Request.Form("iceriksil").count
else
urunidiceriksilic=1
end if

For r = 1 To urunidiceriksilic
if Request.QueryString("iceriksil")="" then
urunidiceriksili=Request.Form("iceriksil")(r)
else
urunidiceriksili=Request.QueryString("iceriksil")
end if
    
    sqlString = "CREATE TEMPORARY TABLE tmptableyazi  SELECT * FROM yazilar WHERE id = "&urunidiceriksili&""
Con.execute(sqlString)

    sqlString = "UPDATE tmptableyazi SET id=0, yazib=CONCAT(yazib, ' Kopyası'), kategori='"&Request.Form("kdkate2")&"'"
Con.execute(sqlString)

    sqlString = "INSERT INTO yazilar SELECT * FROM tmptableyazi"
Con.execute(sqlString)

    sqlString = "DROP TABLE tmptableyazi"
Con.execute(sqlString)

    strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)

    'response.Write tfgid
    'response.End


'sqlString = "select * from yazilar where id="&urunidiceriksili&""
'Set mmmGenel=Con.execute(sqlString)
'if mmmGenel.eof then
'else
'Do While Not mmmGenel.EOF

'sqlString = "select * from resimd where baslik='"&mmmGenel("id")&"'"
'Set mmmYardimci=Con.execute(sqlString)
'if mmmYardimci.eof then
'else
'Do While Not mmmYardimci.EOF
'resimsili=mmmYardimci("resimid")

'mmmYardimci.MoveNext
'  loop
'end if
'close(mmmYardimci)

'mmmGenel.MoveNext
  'loop
  'end if
  'close(mmmGenel)
next
    
session("hata1")="İçerikler Kopyalandı"
session("hatam1")="red"

response.Redirect("sayfalar.asp?dkate2="&request("dkate2")&"&sek="&request("dkate2")&"")
end sub
%>

<%
     sub sayfasil2(id)
    
sqlString = "select * from yazilar where id='"&id&"'"
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF
    strkateidgnl=mmmGenel("id")
sqlString = "select * from resimd where baslik='"&strkateidgnl&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")
'set dosyasis=CreateObject("Scripting.FileSystemObject")
'if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&resimsili&"")) = true then
'dosyasis.DeleteFile(Server.MapPath(""&dbuploadgaleri&""&resimsili&""))

'set dosyasis=nothing
'else
'end if
end if
close(mmmYardimci)
silmek = "delete from ozellikler2 where kateid='"&strkateidgnl&"'"
Con.execute(silmek)
silmek = "delete from resimd where baslik='"&strkateidgnl&"'"
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&strkateidgnl&"'"
Con.execute(silmek)
mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)

silmek = "delete from yazilar where id="&id&""
Con.execute(silmek)

silmek = "delete from resimd where baslik='"&id&"'"
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&id&"'"
Con.execute(silmek)


sqlString = "select * from yazilar where bagli="&id&""
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF
    strkateidgnl=mmmGenel("id")
sqlString = "select * from resimd where baslik='"&strkateidgnl&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")
'set dosyasis=CreateObject("Scripting.FileSystemObject")
'if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&resimsili&"")) = true then
'dosyasis.DeleteFile(Server.MapPath(""&dbuploadgaleri&""&resimsili&""))

'set dosyasis=nothing
'else
'end if
end if
close(mmmYardimci)
silmek = "delete from resimd where baslik='"&strkateidgnl&"'"
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&strkateidgnl&"'"
Con.execute(silmek)
silmek = "delete from yazilar where id="&strkateidgnl&""
Con.execute(silmek)
mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)


    'sqlString = "select * from resimd where baslik='"&id&"'"
'Set mmmYardimci2=Con.execute(sqlString)
'if mmmYardimci2.eof then
'else
'resimsili=mmmYardimci2("resimid")
'dim dosyasis
'set dosyasis=CreateObject("Scripting.FileSystemObject")
'if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&resimsili&"")) = true then
'dosyasis.DeleteFile(Server.MapPath(""&dbuploadgaleri&""&resimsili&""))

'set dosyasis=nothing
'else
'end if
'end if
'close(mmmYardimci2)

    end sub

    sub sayfasil1(id)
    
sqlString = "select * from yazilar where kategori='"&id&"'"
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF
    strkateidgnl=mmmGenel("id")
silmek = "delete from ozellikler2 where kateid='"&strkateidgnl&"'"
Con.execute(silmek)
sqlString = "select * from resimd where baslik='"&strkateidgnl&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")
'set dosyasis=CreateObject("Scripting.FileSystemObject")
'if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&resimsili&"")) = true then
'dosyasis.DeleteFile(Server.MapPath(""&dbuploadgaleri&""&resimsili&""))

'set dosyasis=nothing
'else
'end if
end if
close(mmmYardimci)
silmek = "delete from resimd where baslik='"&strkateidgnl&"'"
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&strkateidgnl&"'"
Con.execute(silmek)
mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)

silmek = "delete from yazilar where kategori='"&id&"'"
Con.execute(silmek)

    'sqlString = "select * from resimd where baslik='"&id&"'"
'Set mmmYardimci2=Con.execute(sqlString)
'if mmmYardimci2.eof then
'else
'resimsili=mmmYardimci2("resimid")
'dim dosyasis
'set dosyasis=CreateObject("Scripting.FileSystemObject")
'if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&resimsili&"")) = true then
'dosyasis.DeleteFile(Server.MapPath(""&dbuploadgaleri&""&resimsili&""))

'set dosyasis=nothing
'else
'end if
'end if
'close(mmmYardimci2)
silmek = "delete from resimd where baslik='"&id&"'"
Con.execute(silmek)

silmek = "delete from kategoriayar where adres='"&id&"'"
Con.execute(silmek)

silmek = "delete from kategoriyazi where bagli="&id&""
Con.execute(silmek)
    
silmek = "delete from kategoriyazi where id="&id&""
Con.execute(silmek)
silmek = "delete from seolar where seoid='"&id&"'"
Con.execute(silmek)

    end sub

    
   sub sayfasil(id) 
sqlString = "select * from kategoriyazi where anasek='"&id&"' or id='"&id&"'"
Set mmmYardimci3=Con.execute(sqlString)
Do While Not mmmYardimci3.EOF
    strkateid=mmmYardimci3("id")

    call sayfasil1(strkateid)

  mmmYardimci3.MoveNext
  loop
  close(mmmYardimci3)
    end sub
%>

<%
sub Sil
if Request.QueryString("urunidsil")="" then
urunidsilic=Request.Form("urunidsil").count
else
urunidsilic=1
end if

For r = 1 To urunidsilic
if Request.QueryString("urunidsil")="" then
urunidsili=Request.Form("urunidsil")(r)
else
urunidsili=Request.QueryString("urunidsil")
end if

call sayfasil(urunidsili)
       
next
 call islemmessagesession("red","Sayfalar Silindi",1)
session("hata1")="Sayfalar Silindi"
session("hatam1")="red"
    if request.QueryString("modulmu")="1" then
response.Redirect("moduller.asp?dkate2="&request("dkate2")&"&sek="&request("sek")&"")
    else
response.Redirect("sayfalar.asp?dkate2="&request("dkate2")&"&sek="&request("sek")&"")
    end if
end sub
%>
<% 	
sub kopyayazi

    haber_tarihi=now
    yazibstr=csskont(request.Form("urun"))
    yazibstr1=yazibstr
        if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then 
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(yazibstr1))&""&seosonu&""
    else    
    seomlink=server.HTMLEncode(baslikkont(yazibstr1))&""&seosonu&""
    end if
    yazistr=MyOwnHTMLEncode(server.HTMLEncode(yazistr))
    rptekstr=MyOwnHTMLEncode(server.HTMLEncode(rptekstr))
    yazibstr=server.HTMLEncode(yazibstr)
else     
    seomlink=baslikkont(yazibstr1)&""&seosonu&""
end if
    zamanekleme=mysqltarihsaat(giriskont(haber_tarihi))

        sqlString = "SELECT * FROM yazilar where id="&request.form("id")&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
sqlString = "insert yazilar set yazib='"&yazibstr&"',dil='"&mmmYardimci("dil")&"',seolink='"&seomlink&"',link='"&csskont(seomlink)&"',yazi='"&replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>")&"',durum='"&mmmYardimci("durum")&"',kategori='"&mmmYardimci("kategori")&"',form='"&mmmYardimci("form")&"',urunid='"&mmmYardimci("urunid")&"',modulmu='"&mmmYardimci("modulmu")&"',bilgi1='"&mmmYardimci("bilgi1")&"',bilgi2='"&mmmYardimci("bilgi2")&"',bilgi3='"&mmmYardimci("bilgi3")&"',temp='"&mmmYardimci("temp")&"',bilgi4='"&mmmYardimci("bilgi4")&"',gtarih='"&zamanekleme&"', descri='"&mmmYardimci("descri")&"', yazicode='"&replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>")&"',tarih='"&zamanekleme&"',admin='" &uyeid&"',sira='9999'"
Con.execute(sqlString)
end if
close(mmmYardimci)
    
session("hata1")="İçerik Düzenlendi"
session("hatam1")="green"
    if request("referer")="" then
if request("modulmu")="1" then
    if request.QueryString("redirect")="1" then
    Response.redirect Request.ServerVariables("HTTP_REFERER")
    else
Response.redirect ("ortak_sayfalar_ayar.asp?dkate2="&request("sek")&"&sayfaayar=modul")
    end if
else
end if
    else  
Response.redirect ("d_dilb.asp?sek="&request.QueryString("lang")&"&filtre=1")
    end if

    end sub

sub duzenleyazi
    
    if Request("haber_tarihi")="" or isNull(Request("haber_tarihi")) then
    haber_tarihi=now
    else
    haber_tarihi=Request("haber_tarihi")
    end if

    yazistr=replace(replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>"),"&+#","&#")
    if request.Form("rpttext")="" then
    rptekstr="0"
    else
    rptekstr=replace(replace(csskont(request.Form("rpttext")),"[/textarea]","</textarea>"),"&+#","&#")
    end if
    yazibstr=csskont(request.Form("urun"))
    yazibstr1=yazibstr
        if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then 
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(yazibstr1))&""&seosonu&""
    else    
    seomlink=server.HTMLEncode(baslikkont(yazibstr1))&""&seosonu&""
    end if
    yazistr=MyOwnHTMLEncode(server.HTMLEncode(yazistr))
    rptekstr=MyOwnHTMLEncode(server.HTMLEncode(rptekstr))
    yazibstr=server.HTMLEncode(yazibstr)
else     
    seomlink=baslikkont(yazibstr1)&""&seosonu&""
end if

    if request.QueryString("islemim")="kopyayazi" then
    zamanekleme=mysqltarihsaat(giriskont(haber_tarihi))

        sqlString = "SELECT * FROM yazilar where id="&request.form("id")&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
sqlString = "insert yazilar set yazib='"&yazibstr&"',dil='"&mmmYardimci("dil")&"',seolink='"&seomlink&"',link='"&csskont(seomlink)&"',yazi='"&replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>")&"',durum='"&mmmYardimci("durum")&"',kategori='"&mmmYardimci("kategori")&"',form='"&mmmYardimci("form")&"',urunid='"&mmmYardimci("urunid")&"',modulmu='"&mmmYardimci("modulmu")&"',bilgi1='"&mmmYardimci("bilgi1")&"',bilgi2='"&mmmYardimci("bilgi2")&"',bilgi3='"&mmmYardimci("bilgi3")&"',temp='"&mmmYardimci("temp")&"',sira1='"&mmmYardimci("sira1")&"',bilgi4='"&mmmYardimci("bilgi4")&"',gtarih='"&zamanekleme&"', descri='"&mmmYardimci("descri")&"', yazicode='"&replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>")&"',tarih='"&zamanekleme&"',admin='" &uyeid&"',sira='9999'"
Con.execute(sqlString)
end if
close(mmmYardimci)
    
    strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)
    stryazigid=tfgid
    else
    stryazigid=giriskont(request.Form("id"))
    end if

    if request.QueryString("duzenletype")="yaziadvrptekle" and isNumeric(request.Form("rptcnt")) then
    for ocaree=1 to request.Form("rptcnt")
    rptekstra=rptekstra&"${rpt}"&rptekstr&"${/rpt(rpt)}"
    next

    sqlString = "SELECT yazicode FROM yazilar where id="&stryazigid&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
yazicodestr= mmmYardimci("yazicode")
end if
close(mmmYardimci)

ocadetr=ubound(split(yazicodestr, "${rpt}"))
        rptstrbfr=split(yazicodestr, "${rpt}")(0)
         
for ocar=1 to ocadetr
        'response.Write request.form("rptd")(ocar)&"-"
        rptstr=split(split(yazicodestr, "${rpt}")(ocar), "${/rpt")(0)
    if request.form("rptd")(ocar)="1" then
    rptstra=rptstra&"${rpt}"&rptstr&"${/rpt(rpt)}"
    else
    if ocar="1" then
    rptstra=""
    else
    rptstra=rptstra
    end if
    end if
           'if ocar=ocadetr then
    
            rptstrftr=split(split(yazicodestr, "${rpt}")(ocar), "${/rpt")(1)
    if ocar=ocadetr then
    rptekstrastr=rptekstra
    else
    rptekstrastr=""
    end if
  '  response.Write rptekstrastr
        if instr(rptstrftr,"${edit}") then
    rptstra=rptstra&rptekstrastr&replace(rptstrftr,"(rpt)}","")
            ocarlist="0"
    else
    rptstra=rptstra&rptekstrastr&replace(rptstrftr,"(rpt)}","")
            end if
           ' rptstrftr=split(split(yazicodestr, "${rpt}")(ocadetr), "${/rpt")(1)
           ' end if
    next
    syazicode=rptstrbfr&rptstra
   ' response.Write syazicode
    'response.End
    'syazicode=rptstrbfr&rptstra&rptekstra&replace(rptstrftr,"(rpt)}","")
    ocadet=ubound(split(syazicode, "${edit}"))
for oca=1 to ocadet
        
strocvstarta=split(syazicode, "${edit}")(oca-1)
    if instr(strocvstarta,"${/edit(") then    
    if instr(strocvstarta,"${/edit("&strocvopt&")}") then
    strocvstarta=split(strocvstarta, "${/edit("&strocvopt&")}")(1)
    end if
    end if
strocv=split(syazicode, "${edit}")(oca)
strocvopt=split(split(strocv, "${/edit(")(1),")}")(0)
strocvstr=split(strocv,"${/edit(")(0)
    if oca*1=ocadet*1 then
        strocvenda=split(strocv,"${/edit("&strocvopt&")}")(1)
    end if

'yazicodestr = Replace(yazicodestr, "${/edit("&strocv&")}","")
   'yazistr = yazistr&""&strocvstart&""&csskont(strocvstr)&strocvend
   yazistra = replace(replace(yazistra&""&strocvstarta&""&csskont(strocvstr)&strocvenda,"${rpt}",""),"${/rpt(rpt)}","")
   yazicodestra = yazicodestra&""&strocvstarta&"${edit}"&csskont(strocvstr)&"${/edit("&strocvopt&")}"&strocvenda
   
next
    yazistr=yazistra
    yazicodestr=yazicodestra
    
    yazicodeqry=", yazicode='"&replace(yazicodestr,"'","`")&"'"
    
    zamanekleme=mysqltarihsaat(giriskont(haber_tarihi))
sqlString = "update yazilar set  yazi='"&replace(yazistr,"'","`")&"', gtarih='" &zamanekleme&"'"&yazicodeqry&" where id="&request("id")&""
    response.Write sqlString
    'response.End
Con.execute(sqlString)
    
session("hata1")="Öğe(ler) Eklendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
    response.End
    end if


    if request.form("advcode")="1" then
    if instr(yazistr,"${edit}") then
    yazicodestr=replace(yazistr,"${edit}","")
    
if Instr(yazicodestr, "${/edit(") then
ocadet=ubound(split(yazicodestr, "${/edit("))
for oca=1 to ocadet
if Instr(yazicodestr, "${/edit(") then
strocv=split(split(yazicodestr, "${/edit(")(1),")}")(0)

ocvadet=ubound(split(strocv,","))
if ocvadet<3 then
else
end if
yazicodestr = Replace(yazicodestr, "${/edit("&strocv&")}","")
    end if
next
else
    yazicodestr=yazistr
end if
    else
    yazicodestr=yazistr
    end if
    yazicodeqry=", yazicode='"&csskont(yazistr)&"'"
    yazistr=replace(replace(csskont(yazicodestr),"${rpt}",""),"${/rpt(rpt)}","")
    elseif request.form("advcode")="2" then
   
sqlString = "SELECT yazicode FROM yazilar where id="&stryazigid&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
syazicode= mmmYardimci("yazicode")
end if
close(mmmYardimci)

    if instr(syazicode,"${edit}") then
        
ocadet=ubound(split(syazicode, "${edit}"))
for oca=1 to ocadet
        
strocvstart=split(syazicode, "${edit}")(oca-1)
    if instr(strocvstart,"${/edit(") then    
    if instr(strocvstart,"${/edit("&strocvopt&")}") then
    strocvstart=split(strocvstart, "${/edit("&strocvopt&")}")(1)
    end if
    end if
strocv=split(syazicode, "${edit}")(oca)
strocvopt=split(split(strocv, "${/edit(")(1),")}")(0)
'strocvstr=split(strocv,"${/edit(")(0)
    ocvadet=ubound(split(strocvopt,","))
                if ocvadet<1 then
                        ocvopttype=split(strocvopt,",")(0)
                        ocvoptinfo=""
                        ocvoptlinked=""
                else
                        ocvopttype=split(strocvopt,",")(0)
                        ocvoptinfo=""
                        ocvoptlinked=""
                        if ocvadet>0 then
                        ocvoptlinked=split(strocvopt,",")(1)
                        if instr(ocvoptlinked,"-") then
                        ocvoptlinkedcol=split(ocvoptlinked,"-")(0)
                        else
                        ocvoptlinkedcol="4"
                        end if
                        end if
                        if ocvadet>1 then
                        ocvoptinfo=split(strocvopt,",")(2)
                        end if
                end if
    advtextstr=request.form("advtext")(oca)
      if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then 
    advtextstr=MyOwnHTMLEncode(server.HTMLEncode(advtextstr))
end if
    if ocvopttype="menu" then
         strocvstr="#menucreate("&replace(request.form("ayarmenu["&oca&"]"),", ",",")&")#"
    else
    if ocvopttype="img" then
        strocvstr=replace(advtextstr ,servername,"/")
    else
        strocvstr=advtextstr
    end if
    end if
    if oca=ocadet then
        strocvend=split(strocv,"${/edit("&strocvopt&")}")(1)
    end if

'yazicodestr = Replace(yazicodestr, "${/edit("&strocv&")}","")
   yazistr = yazistr&""&strocvstart&""&csskont(strocvstr)&strocvend
   'yazistr = replace(replace(yazistr&""&strocvstart&""&csskont(strocvstr)&strocvend,"${rpt}",""),"${/rpt(rpt)}","")
   yazicodestr = yazicodestr&""&strocvstart&"${edit}"&csskont(strocvstr)&"${/edit("&strocvopt&")}"&strocvend
   
next

    end if 


            if instr(yazicodestr,"${rpt}") then
    ocadetr=ubound(split(yazicodestr, "${rpt}"))
        rptstrbfr=split(yazicodestr, "${rpt}")(0)
         
for ocar=1 to ocadetr
        'response.Write request.form("rptd")(ocar)&"-"
        rptstr=split(split(yazicodestr, "${rpt}")(ocar), "${/rpt")(0)
    if request.form("rptd")(ocar)="1" then
    rptstra=rptstra&"${rpt}"&rptstr&"${/rpt(rpt)}"
    else
    if ocar="1" then
    rptstra=""
    else
    rptstra=rptstra
    end if
    end if
          '  if ocar=ocadetr then
           ' rptstrftr=split(split(yazicodestr, "${rpt}")(ocadetr), "${/rpt")(1)
           ' end if
     rptstrftr=split(split(yazicodestr, "${rpt}")(ocar), "${/rpt")(1)

        if instr(rptstrftr,"${edit}") then
    rptstra=rptstra&replace(rptstrftr,"(rpt)}","")
            ocarlist="0"
    else
    rptstra=rptstra&replace(rptstrftr,"(rpt)}","")
            end if
           ' rptstrftr=split(split(yazicodestr, "${rpt}")(ocadetr), "${/rpt")(1)
           ' end if
    next
    syazicode=rptstrbfr&rptstra
    'syazicode=rptstrbfr&rptstra&replace(rptstrftr,"(rpt)}","")
    'response.Write syazicode

    ocadet=ubound(split(syazicode, "${edit}"))
for oca=1 to ocadet
        
strocvstarta=split(syazicode, "${edit}")(oca-1)
    if instr(strocvstarta,"${/edit(") then    
    if instr(strocvstarta,"${/edit("&strocvopt&")}") then
    strocvstarta=split(strocvstarta, "${/edit("&strocvopt&")}")(1)
    end if
    end if
strocv=split(syazicode, "${edit}")(oca)
strocvopt=split(split(strocv, "${/edit(")(1),")}")(0)
strocvstr=split(strocv,"${/edit(")(0)
    if oca*1=ocadet*1 then
        strocvenda=split(strocv,"${/edit("&strocvopt&")}")(1)
    end if

'yazicodestr = Replace(yazicodestr, "${/edit("&strocv&")}","")
   'yazistr = yazistr&""&strocvstart&""&csskont(strocvstr)&strocvend
   yazistra = replace(replace(yazistra&""&strocvstarta&""&csskont(strocvstr)&strocvenda,"${rpt}",""),"${/rpt(rpt)}","")
   yazicodestra = yazicodestra&""&strocvstarta&"${edit}"&csskont(strocvstr)&"${/edit("&strocvopt&")}"&strocvenda
   
next
    yazistr=yazistra
    yazicodestr=yazicodestra
   ' response.Write yazistra
    'response.Write rptstr

    'response.Write rptstr
    'response.End

    else          
    end if 


    yazicodeqry=", yazicode='"&replace(yazicodestr,"'","`")&"'"
    end if
    'response.Write yazicodeqry
    'response.End
sayilink = uretilensifre1
if request.Form("urun")="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("urun")
end if
'seomlink=baslikkont(strbaslikurun)&""&seosonu&""
'buraya seolinkgüncelleme gelebilir
if request.Form("link")="" or request.Form("link")="0" then
link = 0
target = 0
else
link = request.Form("link")
target = request.Form("target")
end if

if request.Form("ozeltemp")="0" then
    if request.Form("modulmu")="1" and yetkiuye="1" then
strtemptur=",temp='"&request.Form("modulbagla")&"'"
    else
strtemptur=",temp='99999'"
    end if
else
if request.Form("cssnbas")="" then
bilgi1gir=request.Form("bilgi1")
else
for ho= 1 to request.Form("cssnbas").count
if request.Form("cssnbas")(ho)="" then
else
logocssnbas="/*"&request.Form("cssnbas")(ho)&"*/"

logocssnana=""&logocssnana&""&logocssnbas&""&request.Form("logodegera"&ho&"")&""
logocss=""
logocssana=""

end if
next
bilgi1gir=logocssnana
end if
if request.form("listecss")="1" then
bilgi1gir= request.Form("csstam")
else
bilgi1gir=logocssnana
end if

if request.Form("temptur")="0" then
if uyeyetki=1 then
strtemptur=",temp='"&request.Form("temptur1")&"'"
else
strtemptur=""
end if
else    
    if request.Form("modulmu")="1" and yetkiuye="1" then
strtemptur=",temp='"&request.Form("modulbagla")&"'"
    else
strtemptur=",temp='"&request.Form("temptur")&"'"
    end if
end if
if request.Form("temptura")="0" then
if uyeyetki=1 then
strtemptur1=",i5='"&csskont(request.Form("temptura1"))&"'"
else
strtemptur1=""
end if
else
strtemptur1=",i5='"&csskont(request.Form("temptura"))&"'"
end if
end if
    'response.write yazibstr&"<br>"&yazistr
    'response.End
    zamanekleme=mysqltarihsaat(giriskont(haber_tarihi))
sqlString = "update yazilar set yazib='"&yazibstr&"', bilgi1='"&csskont(bilgi1gir)&"', bilgi2='"&csskont(request.Form("bilgi2"))&"', bilgi3='"&csskont(request.Form("bilgi3"))&"', bilgi4='"&csskont(request.Form("bilgi4"))&"', yazi='"&replace(yazistr,"'","`")&"', form='"&request.Form("form")&"'"&strtemptur&", kategori='"&csskont(request.Form("yazikategori"))&"', urunid='"&csskont(request.Form("iceriktur"))&"', sira1='"&csskont(request.Form("yayinlang"))&"', link='"&csskont(link)&"', target='"&target&"', descri='"&csskont(request.Form("descri"))&"', gtarih='" &zamanekleme&"', admin='" &uyeid&"'"&yazicodeqry&" where id="&stryazigid&""
    'response.Write sqlString
    'response.End
Con.execute(sqlString)
sqlString = "update yazilar set sira1='"&csskont(request.Form("yayinlang"))&"' where bagli='"&stryazigid&"'"
Con.execute(sqlString)
    urunidd=csskont(request.Form("iceriktur"))
    'response.Write request.QueryString("lang")&"-"&request.Form("modulmu")&"-"&urunidd
    'response.Write  (request.form("lang")<>"" or request.QueryString("lang")<>"") and (request.Form("modulmu")<>"1" and (urunidd<>"12" and urunidd<>"7" and urunidd<>"1"))
    'response.End
    if (request.form("lang")<>"" or request.QueryString("lang")<>"") and (request.Form("modulmu")<>"1" and (urunidd<>"12" and urunidd<>"7" and urunidd<>"1")) then
     sqlString = "select * from seolar where seoid='"&stryazigid&"' and seoturu='yazi'"
 Set mmmYardimci3=Con.execute(sqlString)
if mmmYardimci3.eof then
    call seourlduzenle(seomlink,stryazigid,"yazi",request.form("lang")) 
else    
        if giriskont(request.form("seolinkyenilebtn"))="1" then
    call seourlduzenle(seomlink,stryazigid,"yazi",request.form("lang")) 
    end if
    end if
    close(mmmYardimci3)
    end if

if request("formekle")="ekle" then
						formid=request.form("formice")
 'and tur<50 
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' and id<>"&request.Form("kolon1")&" and id<>"&request.Form("kolon2")&" and tur<>'7'order by sira"
Set mmmYardimci1=Con.execute(sqlString)
if mmmYardimci1.eof then
else
Do While Not mmmYardimci1.EOF
srvname=mmmYardimci1("name")
                      if mmmYardimci1("tur")=1 then
					  veri=request(srvname)

                       elseif mmmYardimci1("tur")=2 then
                        veri=request(srvname)
                        elseif mmmYardimci1("tur")=3 then
						 veri=request(srvname)
                         elseif mmmYardimci1("tur")=4 then
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci1("id")&"' order by sira"
 Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
veri=""
 veri=veri&","&request(srvname)              
mmmYardimci.MoveNext
loop
end if
close(mmmYardimci)
elseif mmmYardimci1("tur")=5 then
veri=request(srvname)		  
elseif mmmYardimci1("tur")=6 then
veri=request(srvname)
elseif mmmYardimci1("tur")=7 then
veri="0"
elseif mmmYardimci1("tur")=8 then
veri="0"
else
veri=request(srvname)
					   end if
	sqlString = "select * from ozellikler2 where ozelikid='"&mmmYardimci1("id")&"' and tur='"&request("formidtur")&"'"
	Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
			sqlString = "insert ozellikler2 set isim='"&csskont(veri)&"',formid='"&formid&"',ozelikid='"&mmmYardimci1("id")&"',onay='0',tur='"&request("formidtur")&"',oku='0',kateid='"&stryazigid&"',ip='"&Request.ServerVariables("REMOTE_ADDR")&"',ekleyen='"&uyeid&"'"
Con.execute(sqlString)
			else
	sqlString = "update ozellikler2 set isim='"&csskont(veri)&"' where ozelikid='"&mmmYardimci1("id")&"' and tur='"&request("formidtur")&"'"
	
Con.execute(sqlString)
			  end if
			  close(mmmYardimci)	  
	mmmYardimci1.MoveNext
loop
end if
close(mmmYardimci1)
else
end if

session("hata1")="İçerik Düzenlendi"
session("hatam1")="green"
    if request("referer")="" then
if request("modulmu")="1" then
    if request.QueryString("redirect")="1" then
    Response.redirect Request.ServerVariables("HTTP_REFERER")
    else
Response.redirect ("ortak_sayfalar_ayar.asp?dkate2="&request("sek")&"&sayfaayar=modul")
    end if
else
    if request.QueryString("redirect")="1" then
    Response.redirect Request.ServerVariables("HTTP_REFERER")
    else
end if
end if
    else  
Response.redirect ("d_dilb.asp?sek="&request.QueryString("lang")&"&filtre=1")
    end if
end sub
%>

<% 	
sub duzenlesayfa
sayilink = uretilensifre1
if request.Form("sektor")="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("sektor")
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
sqlString = "SELECT * FROM kategoriyazi where seolink='"&seomlink&"' and id<>"&request("urunid")&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
seolink= seomlink
else
seolink= replace(seomlink,""&seosonu&"","")&"-"&sayilink&""&seosonu&""
end if
close(mmmYardimci)
if request.Form("durum")=1 then
alt = 1
else
alt = 0
end if

sqlString = "update kategoriyazi set isim='"&csskont(request.Form("sektor"))&"',durum='"&request.Form("durum3")&"',urunid='"&request.Form("durum2")&"',anasek='"&request.Form("durum")&"',seolink='"&seolink&"',alt='"&alt&"' where id="&request("urunid")&""
Con.execute(sqlString)

session("hata1")="Sayfa Düzenlendi"
session("hatam1")="green"
end sub
  
sub sayfaekle
sayilink = uretilensifre1
if request("sektor")="" then
else

if request.Form("durum")="" or request.Form("durum")="1" or request.Form("durum")="0" then
strbaslikdurum="1"
else
strbaslikdurum=giriskont(request.Form("durum"))
end if

if request.Form("sektor")="" then
strbaslikurun=sayilink
else
strbaslikurun=giriskont(request.Form("sektor"))
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
if strbaslikdurum=1 then
alt = 1
dil = 240
else
alt = 0
end if
if request.Form("harici") = 1 then
link  = request.Form("link")
else
link  = 0
end if
if request("modulmu")="" then
modulmu= 0
else
modulmu= request("modulmu")
end if
    zamanekleme=mysqltarihsaat(now)
sqlString = "insert kategoriyazi set isim='"&csskont(request.Form("sektor"))&"',anasek='"&strbaslikdurum&"',durum='1',menugosterim='0',stura='1',orta='1',smodula='1',sayara='1',okusayi='0',sosyal1='0',sosyal2='0',facebookyorum='0',baslikd='1',alt='"&alt&"',dil='"&aktifdil&"',slider='"&request.Form("slaytt")&"',modulmu='"&modulmu&"',link='"&link&"',sayfatemp='"&strsayfatemp&"', tarih='"&zamanekleme&"', gtarih='"&zamanekleme&"',sira='99999'"
Con.execute(sqlString)

    strSQL="select @@IDENTITY as NewID from kategoriyazi"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)

    call seourlduzenle(seomlink,tfgid,"sayfa","240") 
    if request("kopyaid")="1" then
    else
        sqlString = "select * from kategoriyazi where id="&request("kopyaid")&" order by sira desc"
        Set mmmYardimci=Con.execute(sqlString)
            if mmmYardimci.eof then
            else
                Con.execute("update kategoriyazi set sayfatemp='"&mmmYardimci("sayfatemp")&"', sol='"&mmmYardimci("sol")&"',sayara='"&request("kopyaid")&"' where id="&tfgid&"")
            end if
        close(mmmYardimci)
    end if
session("hata1")="Sayfa Eklendi"
session("hatam1")="green"
response.Redirect("sayfalar.asp?dkate2="&request("sek")&"&sek="&request("sek")&"")
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end if
end sub
%>

<%
sub yetkiDuzenle

For icntt = 1 To Request.Form("yetkiadi").Count and Request.Form("urunid").Count and request.Form("kullanicilar").Count and request.Form("kullanicilars").Count and request.Form("ayarlar").Count and request.Form("ayarlars").Count and request.Form("sayarlar").Count and request.Form("sayarlars").Count and request.Form("anketler").Count and request.Form("anketlers").Count and request.Form("icerikler").Count and request.Form("iceriklers").Count and request.Form("reklamlar").Count and request.Form("reklamlars").Count and request.Form("diller").Count and request.Form("dillers").Count and request.Form("mayarlars").Count and request.Form("mayarlar").Count

sqlString = "update yetkiler set yetkiadi='"&request("yetkiadi")(icntt)&"',kullanicilar='"&request("kullanicilar")(icntt)&"',kullanicilars='"&request("kullanicilars")(icntt)&"',ayarlar='"&request.Form("ayarlar")(icntt)&"',ayarlars='"&request.Form("ayarlars")(icntt)&"',sayarlar='"&request.Form("sayarlar")(icntt)&"',sayarlars='"&request.Form("sayarlars")(icntt)&"',anketler='"&request.Form("anketler")(icntt)&"',anketlers='"&request.Form("anketlers")(icntt)&"',icerikler='"&request.Form("icerikler")(icntt)&"',iceriklers='"&request.Form("iceriklers")(icntt)&"',reklamlar='"&request.Form("reklamlar")(icntt)&"',reklamlars='"&request.Form("reklamlars")(icntt)&"',mayarlar='"&request.Form("mayarlar")(icntt)&"',mayarlars='"&request.Form("mayarlars")(icntt)&"',diller = '"&request.Form("diller")(icntt)&"',dillers = '"&request.Form("dillers")(icntt)&"' where id="&request("urunid")(icntt)&""
Con.execute(sqlString)

next

session("hata1")="Yetki Düzenlendi"
session("hatam1")="green"
end sub

sub ortakyetkiDuzenle

For icntt = 1 To Request.Form("yetkiid").Count
    Set oJSON = New aspJSON
With oJSON.data
    headercntid=request("yetkiid")(icntt)
    headercntbaslik1=request("yetkiadi")(icntt)
    headercntbaslik=headercntbaslik1
    if headercntbaslik<>"" then
    rss=cint(icntt-1)
            .Add headercntid, oJSON.Collection()      
       With .item(headercntid)
    
    for rssa=1 to Request.form("menuid").count
    menucntbaslik1=request("menuid")(rssa)
    menucntedit=request("edit"& headercntid&"")(rssa)
    menucntdelete=request("delete"& headercntid&"")(rssa)
    'if menucntyetki=request("yetkiid")(icntt) then   
            .Add menucntbaslik1, oJSON.Collection()      
       With .item(menucntbaslik1)
    .Add rssa, oJSON.Collection()
        With .item(rssa)
            .Add "edit", menucntedit
            .Add "delete", menucntdelete
        End With
        End With
    'end if
    next

      End With
    end if 
End With
yetkijson= oJSON.JSONoutput()
sqlString = "update yetkiler set yetkiadi='"&request("yetkiadi")(icntt)&"', yetkijson='"&yetkijson&"' where id="&request("yetkiid")(icntt)&""
Con.execute(sqlString)

    'response.Write sqlString&"<br>"
next

    'response.Write yetkijson
   'response.End
session("hata1")="Yetki Düzenlendi"
session("hatam1")="green"
end sub
%> 
<%
sub yetkiSil

For r = 1 To Request.Form("urunidsil").Count

silmek = "delete from yetkiler where id="&Request.Form("urunidsil")(r)&""
Con.execute(silmek)
next
session("hata1")="Yetki Silindi"
session("hatam1")="red"
end sub
%>
<% 	
sub yetkiekle
sqlString = "insert yetkiler set yetkiadi='"&request("yetkiadi")&"',kullanicilar='"&request("kullanicilar")&"',kullanicilars='"&request("kullanicilars")&"',ayarlar='"&request.Form("ayarlar")&"',ayarlars='"&request.Form("ayarlars")&"',sayarlar='"&request.Form("sayarlar")&"',sayarlars='"&request.Form("sayarlars")&"',anketler='"&request.Form("anketler")&"',anketlers='"&request.Form("anketlers")&"',icerikler='"&request.Form("icerikler")&"',iceriklers='"&request.Form("iceriklers")&"',reklamlar='"&request.Form("reklamlar")&"',reklamlars='"&request.Form("reklamlars")&"',mayarlar='"&request.Form("mayarlar")&"',mayarlars='"&request.Form("mayarlars")&"',diller = '"&request.Form("diller")&"',dillers = '"&request.Form("dillers")&"'"
Con.execute(sqlString)

session("hata1")="Yetki Eklendi"
session("hatam1")="green"
end sub
%>
<%
sub icerikekle
sayilink = uretilensifre1
formid=request.form("formice")
if request.Form("coklu")="1" and request.Form("yenikategori")="1" then
sqlString = "SELECT * FROM yazilar where kategori='"&request("dkate2")&"' and urunid='"&request.QueryString("tur")&"' "
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
if request("dkate2")=1 then
sqlString = "select * from kategoriyazi where alt = 1 order by sira desc"
else
sqlString = "select * from kategoriyazi where anasek='"&request("dkate2")&"' order by sira desc"
end if
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
siraa=1
else
siraa=int(mmmYardimci("sira"))+1
end if
close(mmmYardimci)

if request.Form("urun")="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("urun")
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""

if request("dkate2")=1 then
alt = 1
else
alt = 0
end if
if request.Form("harici") = 1 then
link  = request.Form("link")
else
link  = 0
end if
if request("modul")="" then
modulmu= 0
else
modulmu= request("modul")
end if
if request.Form("stemp")="" then
sqlString = "select * from kategoriyazi where id="&request("dkate2")&" order by sira desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
sayfatemp= mmmYardimci("sayfatemp")
sol= mmmYardimci("sol")
orta= mmmYardimci("orta")
sag= mmmYardimci("sag")
end if
close(mmmYardimci)
else
sayfatemp= request.Form("stemp")&","&request.Form("stemp1")&","&request.Form("stemp2")
sol= request.Form("sol")&","&request.Form("sol1")&","&request.Form("sol2")
orta= request.Form("orta")&","&request.Form("orta1")&","&request.Form("orta2")
sag= request.Form("sag")&","&request.Form("sag1")&","&request.Form("sag2")
end if

    
    zamanekleme=mysqltarihsaat(now)
sqlString = "insert kategoriyazi set isim='"&csskont(request("urun"))&"',dil='240',seolink='"&seolink&"',alt='"&alt&"',link='"&link&"',anasek='"&request("yazikategori")&"',durum='1',menugosterim='0',stura='1',smodula='1',sayara='1',okusayi='0',sosyal1='0',sosyal2='0',facebookyorum='0',baslikd = '1',slider = '1',modulmu='"&modulmu&"', sira='"&siraa&"', tarih='"&zamanekleme&"', gtarih='"&zamanekleme&"',sayfatemp='"&sayfatemp&"',sol='"&sol&"',orta='"&orta&"',sag='"&sag&"'"
Con.execute(sqlString)

    strSQL="select @@IDENTITY as NewID from kategoriyazi"
    set mmmGenel = Con.Execute(strSQL)
    baslik = mmmGenel.Fields("NewID")
    close(mmmGenel)
    call seourlduzenle(seomlink,baslik,"sayfa","240")

kategori=baslik

else
kategori=request.Form("yazikategori")
end if
        close(mmmGenel)
else
kategori=request.Form("yazikategori")
end if
if request.Form("urun")="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("urun")
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
if request.Form("harici") = 1 then
link  = request.Form("link")
else
link  = 0
end if

if request.Form("modul")="1" then
modull="1"
kategori=request.QueryString("dkate2")
else
modull="0"
kategori=kategori
end if
if request.Form("ozeltemp")="0" then
strtemptur=99999
else
strtemptur=request.Form("temptur")
end if
   if request.Form("haber_tarihi")="" then
    else
zamanekleme=request.Form("haber_tarihi")
    end if
sqlString = "insert yazilar set yazib='"&csskont(request("urun"))&"',dil='240',seolink='"&seolink&"',link='"&csskont(link)&"',yazi='"&replace(csskont(request.Form("myTextarea")),"[/textarea]","</textarea>")&"',durum='1',kategori='"&kategori&"',form='"&request.Form("form")&"',urunid='"&request.QueryString("tur")&"',modulmu='"&modull&"',bilgi1='"&csskont(request.Form("bilgi1"))&"',bilgi2='"&csskont(request.Form("bilgi2"))&"',bilgi3='"&csskont(request.Form("bilgi3"))&"',temp='"&strtemptur&"',bilgi4='"&csskont(request.Form("bilgi4"))&"',gtarih='"&zamanekleme&"', descri='"&csskont(request.Form("descri"))&"',tarih='"&zamanekleme&"',admin='" &uyeid&"',sira='9999'"
Con.execute(sqlString)

    strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    baslik = mmmGenel.Fields("NewID")
    baslikform = baslik
    close(mmmGenel)
    if rmodull="1" or request.QueryString("tur")="12" or request.QueryString("tur")="7" or request.QueryString("tur")="1" then
    else
    call seourlduzenle(seomlink,baslik,"yazi","240")
    end if

						if request("formekle")="ekle" then
						formid=request.form("formice")

 sqlString = "select * from formlar where id="&formid&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
gmesaj=mmmYardimci("gmesaj")
alici=mmmYardimci("froms")
smtpserver=mmmYardimci("smtpserver")
smtpport=mmmYardimci("smtpport")
formadi=mmmYardimci("formadi")
end if
close(mmmYardimci)

sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' and gonderen = '1' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
gonderen=1
emailvarmi="0"
else
gonderen=(request(mmmYardimci("name")))
emailvarmi="1"
end if
close(mmmYardimci)
						
karakterler1="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1=len(karakterler1)
for icntt = 1 to 5
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
sifreuret1 = uretilensifre1

					

if session("yonet_dil")=240 then
gmesaj=gmesaj
else
sqlString = "select * from formlar where id="&formid&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
gmesaj="-"
else
gmesaj=gmesaj
end if
close(mmmYardimci)
end if
alici=alici
smtpserver=smtpserver
smtpport=smtpport

sitename = sitename
tarih =date()
formadi=formadi
sqlString = "insert ozellikler2 set formid='"&formid&"',ozelikid='1',isim='1',kateid='"&baslikform&"',tur='"&sifreuret1&"'"
Con.execute(sqlString)

 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF

                      if mmmYardimci("tur")=1 then
					  veri=request(mmmYardimci("name"))
                       elseif mmmYardimci("tur")=2 then
                        veri=request(mmmYardimci("name"))
                        elseif mmmYardimci("tur")=3 then
						 veri=request(mmmYardimci("name"))
                         elseif mmmYardimci("tur")=4 then
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
veri=""
 veri=veri&","&request(mmmYardimci("name"))              
mmmYardimci1.movenext
loop
close(mmmYardimci1)
elseif mmmYardimci("tur")=5 then
veri=request(mmmYardimci("name"))		  
elseif mmmYardimci("tur")=6 then
veri=request(mmmYardimci("name"))
elseif mmmYardimci("tur")=7 then
veri=request(mmmYardimci("name"))
else
veri=request(mmmYardimci("name"))
					   end if
sqlString = "insert ozellikler2 set formid='"&formid&"',ozelikid='"&mmmYardimci("id")&"',isim='"&csskont(veri)&"',onay='0',tur='"&sifreuret1&"',oku='0',kateid='"&baslikform&"',ip='"&Request.ServerVariables("REMOTE_ADDR")&"',ekleyen='"&uyeid&"'"
Con.execute(sqlString)			
				  
mmmYardimci.movenext
loop
end if
close(mmmYardimci)
else
end if

session("hata1")="İçerik Eklendi"
session("hatam1")="green"
    if modull="1" then
Response.Redirect("moduller.asp?dkate2="&request("dkate2")&"&id="&Request("dkate2")&"&baslik="&Request("dkate2")&"&sek=1")
    else
    Response.Redirect("admin_uruny_duzenle.asp?duzelt=1&urunid=948&dkate2=1363&sek=1363&anaurunid=948&dil=240")
'Response.Redirect("sayfalar.asp?dkate2="&request("dkate2")&"&id="&Request("dkate2")&"&baslik="&Request("dkate2")&"&sek=1")
    end if
end sub
%>

<%
Sub sitemap() 
    
    silmek = "delete from seositemap"
Con.execute(silmek)

    for ssmapi=1 to request.form("url").count   
    'strimage=mmmSayfa("image")
    'strhreflang=mmmSayfa("hreflang")
    if request.form("urlsec")(ssmapi)="1" then
    ekle = "insert seositemap set url='"&request.form("url")(ssmapi)&"', piority='"&request.form("piority")(ssmapi)&"', freq='"&request.form("freq")(ssmapi)&"', lastchng='"&request.form("lastchng")(ssmapi)&"', contenttype='"&request.form("contenttype")(ssmapi)&"', contentid='"&request.form("contentid")(ssmapi)&"', secili='"&request.form("urlsec")(ssmapi)&"'"
    Con.execute(ekle)
    end if
    next 

Dosya_Yol=Server.MapPath("../contents/sitemap.xml" ) 
response.Write(setchar(Request("sek"),"utf8"))
Set Dosya_Sistemi=Server.CreateObject("Scripting.FileSystemObject" ) 
Set Dosya_Yaz=Dosya_Sistemi.CreateTextFile(Dosya_Yol,True, True)
	
Dosya_Yaz.WriteLine("<?xml version=""1.0"" encoding=""UTF-8""?>")
Dosya_Yaz.WriteLine("<?xml-stylesheet type=""text/xsl"" href="""&siteadres&"contents/sitemap.xsl""?>")
Dosya_Yaz.WriteLine("<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"" xmlns:xhtml=""http://www.w3.org/1999/xhtml""")
Dosya_Yaz.WriteLine("xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""")
Dosya_Yaz.WriteLine("xmlns:image=""http://www.google.com/schemas/sitemap-image/1.1""")
Dosya_Yaz.WriteLine("xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9")
Dosya_Yaz.WriteLine("http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"">")

sqlString = "select * from seositemap "
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.eof
    seolink=mmmYardimci2("url")
    piority=mmmYardimci2("piority")
    if piority="" or isNull(piority) or piority="noselect" then
    pioritystr=""
    else
    pioritystr="<priority>"&replace(piority,",",".")&"</priority>"
    end if
    freq=mmmYardimci2("freq")
    if freq="" or isNull(freq) or freq="noselect" then
    freqstr=""
    else
    freqstr="<changefreq>"&freq&"</changefreq>"
    end if
    lastchng=mmmYardimci2("lastchng")
    if lastchng="" or isNull(lastchng) or lastchng="noselect" then
    lastchngstr=""
    else
    '2015-12-02T18:43:29Z
    lastchng=mysqltarihsaatadv(lastchng,"#yy#-#mm#-#dd#T#hh1#:#mi#:#se#Z",1)
    lastchngstr="<lastmod>"&lastchng&"</lastmod>"
    end if
    image=mmmYardimci2("image")
    hreflang=mmmYardimci2("hreflang")
    contenttype=mmmYardimci2("contenttype")
    contentid=mmmYardimci2("contentid")    
     sqlString = "select seoid from seolar where id='"&contentid&"'"
set mmmGenel = Con.Execute (sqlString)
    if mmmGenel.eof then
    contentids="9999"
    else
    contentids=mmmGenel("seoid")
    end if
    close(mmmGenel)
    Dosya_Yaz.WriteLine("<url>")

     sqlString = "select id,ceviricode,nott from diller1 where alt = '1' and sira='1' order by nott desc"
set mmmGenel = Con.Execute (sqlString)

    Do While Not mmmGenel.EOF
    dilid=mmmGenel("id")
    dilnott=mmmGenel("nott")
    
    if contenttype="sayfa" then
    'sqlstring="SELECT seolar.seolink as seolarlink, lang FROM kategoriyazi,seolar where seolar.id = '"&contentid&"' and lang='"&dilid&"' and (kategoriyazi.bagli = seolar.seoid or kategoriyazi.id=seolar.seoid)"
    sqlstring="SELECT seolar.seolink as seolarlink, lang FROM kategoriyazi,seolar where (kategoriyazi.bagli = '"&contentids&"' or kategoriyazi.id = '"&contentids&"') and lang='"&dilid&"' and seoturu='"&contenttype&"' and kategoriyazi.id=seolar.seoid"
    'sqlstring=menuvericek(vdb,menubagliana,"kategoriyazi,seolar","seolar.seolink"," kategoriyazi.bagli = '"&aid&"' and dil='"&dilid&"' and kategoriyazi.id=seolar.seoid",iconn)
   ' response.Write sqlstring
    'response.End
    else
    sqlstring="SELECT * from kategoriyazi where durum='9999'"
    end if
    set mmmSayfa3 = Con.Execute (sqlstring)
if mmmSayfa3.eof then
    if contenttype<>"sayfa" then
    Dosya_Yaz.WriteLine("<loc>"&seolink&"</loc>")
    elseif xr="1" and contenttype="sayfa" then
    Dosya_Yaz.WriteLine("<loc>"&seolink&"</loc>")
    end if
    xr=xr+1
    'response.Write "asd"
else
seolarlinki=mmmSayfa3("seolarlink")
    'if langs&""<>""&dilid then
    if dilnott="1" then
    if seolarlinki="/" then
    seolarlinki=""
    end if
    Dosya_Yaz.WriteLine("<loc>"&siteadres&""&seolarlinki&"</loc>")
    Dosya_Yaz.WriteLine("<xhtml:link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang="""&mmmGenel("ceviricode")&""" ></xhtml:link>")
    else
    'hreflangcrt2=hreflangcrt2&""&_
    Dosya_Yaz.WriteLine("<xhtml:link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang="""&mmmGenel("ceviricode")&"""></xhtml:link>")
    end if
    'end if
end if
close(mmmSayfa3)
mmmGenel.movenext
loop
close(mmmGenel)
    Dosya_Yaz.WriteLine(""&lastchngstr&"")
    Dosya_Yaz.WriteLine(""&freqstr&"")
    Dosya_Yaz.WriteLine(""&pioritystr&"")
    Dosya_Yaz.WriteLine("</url>")
    xr="0"
mmmYardimci2.movenext
loop
close(mmmYardimci2)

Dosya_Yaz.WriteLine("</urlset>")
      response.Write("<span style=""color:#000000;"">Sitemap Oluşturulmuştur.</span>") 
Dosya_Yaz.Close 
session("hata1")="Site Haritası Düzenlendi"
session("hatam1")="green"
		end sub%>


<% 
sub seoduzenbaslik
    
id = Request("haberid")
For icntt = 1 To Request.Form("haberid").Count and Request.Form("title").Count  and Request.Form("desc").Count and Request.Form("key").Count

sqlString = "update kategoriyazi set title='"&Request("title")(icntt)&"',descri='"&Request("desc")(icntt)&"',keysi='"&Request("key")(icntt)&"' where id="&Request("haberid")(icntt)&""
Con.execute(sqlString)

next

session("hata1")="Seo Başlık Düzenlendi"
session("hatam1")="green"

end sub
%> 
<%
sub sayfatDuzenle
For icntt = 1 To Request.Form("sayfaadi").Count and Request.Form("durum").Count and Request.Form("okusayi").Count and  Request.Form("sosyal1").Count and  Request.Form("sosyal2").Count and Request.Form("id").Count and Request.Form("facebookyorum").Count and Request.Form("sayara").Count and Request.Form("stura").Count and Request.Form("smodula").Count and Request.Form("stemp").Count and Request.Form("sol").Count and Request.Form("orta").Count and Request.Form("sag").Count and Request.Form("stemp1").Count and Request.Form("stemp2").Count and Request.Form("sol1").Count and Request.Form("sol2").Count and Request.Form("sag1").Count and Request.Form("sag2").Count

sqlString = "update kategoriyazi set isim='"&csskont(request.Form("sayfaadi")(icntt))&"',durum='"&request.Form("durum")(icntt)&"',okusayi='"&request.Form("okusayi")(icntt)&"',sosyal1='"&request.Form("sosyal1")(icntt)&"',sosyal2='"&request.Form("sosyal2")(icntt)&"',facebookyorum='"&request.Form("facebookyorum")(icntt)&"',sayara='"&request.Form("sayara")(icntt)&"',stura='"&request.Form("stura")(icntt)&"',smodula='"&request.Form("smodula")(icntt)&"',sayfatemp='"&request.Form("stemp")(icntt)&","&request.Form("stemp1")(icntt)&","&request.Form("stemp2")(icntt)&"',sol='"&request.Form("sol")(icntt)&","&request.Form("sol1")(icntt)&","&request.Form("sol2")(icntt)&"',orta='"&request.Form("orta")(icntt)&","&request.Form("orta1")(icntt)&","&request.Form("orta2")(icntt)&"',sag='"&request.Form("sag")(icntt)&","&request.Form("sag1")(icntt)&","&request.Form("sag2")(icntt)&"' where id="&request.Form("id")(icntt)&""
Con.execute(sqlString)

next
'response.Write(request.Form("stemp"&i&""))

session("hata1")="Sayfalar Düzenlendi"
session("hatam1")="green"
end sub%> 
<% 
sub seoduzen

id = Request("haberid")
   
For icntt = 1 To Request.Form("haberid").Count and Request.Form("title").Count  and Request.Form("desc").Count and Request.Form("key").Count

sqlString = "update yazilar set title='"&Request("title")(icntt)&"',descri='"&Request("desc")(icntt)&"',keysi='"&Request("key")(icntt)&"' where id="&Request("haberid")(icntt)&""
Con.execute(sqlString)

next

session("hata1")="Seo İçerik Düzenlendi"
session("hatam1")="green"

end sub
%>

<%
    
    sub eskseolinkDuzenle

For icntt = 1 To Request.Form("eskilink").Count and Request.Form("yenilink").Count and Request.Form("urunid").Count 
sqlString = "update seolink set eskilink='"&csskont(request.Form("eskilink")(icntt))&"',yenilink='"&csskont(request.Form("yenilink")(icntt))&"' where id="&request.Form("urunid")(icntt)&""
Con.execute(sqlString)

next

session("hata1")="Form Düzenlendi"
session("hatam1")="green"
end sub
%>
<%
sub eskseolinkSil

For icntt = 1 To Request.Form("urunidsil").Count 
silmek = "delete from seolink where id="&Request.Form("urunidsil")(icntt)&""
Con.execute(silmek)
next
session("hata1")="Seolink Silindi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

sub formgDuzenle

For icntt = 1 To Request.Form("ad").Count and Request.Form("urunid").Count 
sqlString = "update ozellikler1 set isim='"&csskont(request.Form("ad")(icntt))&"' where id="&request.Form("urunid")(icntt)&""
Con1.execute(sqlString)

next

session("hata1")="Form Düzenlendi"
session("hatam1")="green"
end sub
%>
<%
sub formgsil

For icntt = 1 To Request.Form("urunidsil").Count 
silmek = "delete from ozellikler1 where id="&Request.Form("urunidsil")(icntt)&""
Con1.execute(silmek)
next
session("hata1")="Form Silindi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub
%>
<% 	
sub formgekle

sqlString = "insert ozellikler1 set isim='"&csskont(request.Form("sektor"))&"'"
Con1.execute(sqlString)

session("hata1")="Form Eklendi"
session("hatam1")="green"
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub

sub eskseolinkekle
sqlString = "insert seolink set eskilink='"&csskont(request.Form("eskilink"))&"',yenilink='"&csskont(request.Form("yenilink"))&"'"
Con.execute(sqlString)

session("hata1")="Seo Link Eklendi"
session("hatam1")="green"
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub
%> 

<%
sub formiekle
formid=request("form")
 sqlString = "select * from formlar where id="&formid&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
gmesaj=mmmYardimci("gmesaj")
alici=mmmYardimci("from")
smtpserver=mmmYardimci("smtpserver")
smtpport=mmmYardimci("smtpport")
formadi=mmmYardimci("formadi")
end if
close(mmmYardimci)

sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' and gonderen = '1' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
gonderen=1
emailvarmi="0"
else
gonderen=(request(mmmYardimci("name")))
emailvarmi="1"
end if
close(mmmYardimci)
						
karakterler1="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1=len(karakterler1)
for icntt = 1 to 5
kacincikarakter1=int((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
sifreuret1 = uretilensifre1

if session("yonet_dil")=240 then
gmesaj=gmesaj
else
sqlString = "select * from formlar where id="&formid&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
gmesaj="-"
else
gmesaj=gmesaj
end if
close(mmmYardimci)
end if
alici=alici
smtpserver=smtpserver
smtpport=smtpport

sitename = sitename
tarih =date()
formadi=formadi
sqlString = "insert ozellikler2 set formid='"&formid&"',ozelikid='1',isim='1',tur='"&sifreuret1&"'"
Con.execute(sqlString)

baslik=""&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&""

   Dim html
    html = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    html = html & "<html>"
    html = html & "<head>"
    html = html & "<title>"&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&"</title>"
    html = html & "</head>"
    html = html & "<body>"
    html = html & "<br>"
sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF

                      if mmmYardimci("tur")=1 then
					  veri=request(mmmYardimci("name"))
                       elseif mmmYardimci("tur")=2 then
                        veri=request(mmmYardimci("name"))
                        elseif mmmYardimci("tur")=3 then
						 veri=request(mmmYardimci("name"))
                         elseif mmmYardimci("tur")=4 then

 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
veri=""
 veri=veri&","&request(mmmYardimci("name"))              
mmmYardimci1.movenext
loop
close(mmmYardimci1)
elseif mmmYardimci("tur")=5 then
veri=request(mmmYardimci("name"))		  
elseif mmmYardimci("tur")=6 then
veri=request(mmmYardimci("name"))
elseif mmmYardimci("tur")=7 then
veri=request(mmmYardimci("name"))
else
veri=request(mmmYardimci("name"))
					   end if

				html = html & "<b>" & mmmYardimci("isim")&" :</b> " & veri	
				html = html & "<hr>"   
				  
sqlString = "insert ozellikler2 set formid='"&formid&"',ozelikid='"&mmmYardimci("id")&"',isim='"&csskont(veri)&"',onay='0',tur='"&sifreuret1&"',oku='0',kateid='"&baslikform&"',ip='"&Request.ServerVariables("REMOTE_ADDR")&"',ekleyen='"&uyeid&"'"
Con.execute(sqlString)			
				  
mmmYardimci.movenext
loop
end if
close(mmmYardimci)
    html = html & "</body>"
    html = html & "</html>"
    if gonderen="1" then
	else
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
		.From = gonderen
		.To = alici
		.Subject = baslik
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
session("hata1")="Form Gönderildi"
session("hatam1")="green"
end sub
%>

<%
sub formiDuzenle

Set rs = Server.CreateObject("ADODB.Recordset")
For icntt = 1 To Request.Form("onay").Count and Request.Form("urunid").Count  

sqlString = "update ozellikler2 set onay='"&request.Form("onay")(icntt)&"' where tur='"&request("urunid")(icntt)&"'"
Con.execute(sqlString)	

next

session("hata1")="Form Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formiSil

For icntt = 1 To Request.Form("sil").Count 
silmek = "delete from ozellikler2 where tur='"&Request.Form("sil")(icntt)&"'"
Con.execute(silmek)
next
session("hata1")="Form Silindi"
session("hatam1")="red"
end sub
%>

<% 	
sub formkopya

sqlString = "select * from formlar where id="&request("kopyaid")&"  order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
sqlString = "insert formlar set formadi='"&mmmYardimci("formadi")&"',temp='"&mmmYardimci("temp")&"',smtpport='"&mmmYardimci("smtpport")&"',smtpserver='"&mmmYardimci("smtpserver")&"',gmesaj='"&mmmYardimci("gmesaj")&"',onay='"&mmmYardimci("onay")&"',login='"&mmmYardimci("login")&"',password='"&mmmYardimci("password")&"',ssls='"&mmmYardimci("ssls")&"',veritabanikayit='"&mmmYardimci("veritabanikayit")&"',ciftmail='"&mmmYardimci("ciftmail")&"',froms='"&mmmYardimci("froms")&"',dil='"&mmmYardimci("dil")&"',mailtemp='"&mmmYardimci("mailtemp")&"',aktifkategori='"&mmmYardimci("aktifkategori")&"',kolonlar='"&mmmYardimci("kolonlar")&"'"
Con.execute(sqlString)	

eskiformid=mmmYardimci("id")
end if
close(mmmYardimci)

sqlString = "select * from formlar order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
kopyaform=mmmYardimci("id")
end if
close(mmmYardimci)

 sqlString = "select * from ozellikler where formid='"&eskiformid&"' order by sira desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF

sqlString = "insert ozellikler set isim='"&csskont(mmmYardimci("isim"))&"',name='"&mmmYardimci("name")&"',gerekli='"&mmmYardimci("gerekli")&"',sira='"&mmmYardimci("sira")&"',maxs='"&mmmYardimci("maxs")&"',dil='"&mmmYardimci("dil")&"',formid='"&kopyaform&"',alt='"&mmmYardimci("alt")&"',tur='"&mmmYardimci("tur")&"',anasek='"&mmmYardimci("anasek")&"',bagli='"&mmmYardimci("bagli")&"',gonderen='"&mmmYardimci("gonderen")&"',siparis='"&mmmYardimci("siparis")&"'"
Con.execute(sqlString)	

mmmYardimci.MoveNext
  loop
  
  close(mmmYardimci)

session("hata1")="Form Özelliği Kopyalandı"
session("hatam1")="green"
'response.write"<b>Kopya Yapilmistir</b><br>"
end sub
%>

<% 	
sub formekle

sqlString = "insert formlar set formadi='"&request.Form("formadi")&"',temp='"&request.Form("temp")&"',onay='"&request.Form("onay")&"',icerikid='"&request.Form("engel")&"',veritabanikayit='"&request.Form("veritabanikayit")&"',ciftmail='"&request.Form("liste")&"',dil='240'"
Con.execute(sqlString)	

session("hata1")="Form Eklendi"
session("hatam1")="green"
'response.write"<b>Form Kayit Yapilmistir</b><br>"
end sub

sub formsmtpekle

sqlString = "insert formsmtp set formadi='"&request.Form("formadi")&"',onay='"&request.Form("onay")&"'"
Con.execute(sqlString)	

session("hata1")="Smtp Ayarı Eklendi"
session("hatam1")="green"
'response.write"<b>Form Kayit Yapilmistir</b><br>"
end sub
%>

<%
sub formdanicerige
sayilink = uretilensifre1
sqlString = "SELECT * FROM ozellikler2 where tur='"&request.QueryString("tur")&"' and ozelikid='"&request.QueryString("urunadi")&"' order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
urunadi=""
seomlink=""
else
urunadi=mmmYardimci("isim")
if urunadi="" then
strbaslikurun=sayilink
else
strbaslikurun=urunadi
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
end if
close(mmmYardimci)

sqlString = "SELECT * FROM ozellikler2 where tur='"&request.QueryString("tur")&"' and ozelikid='"&request.QueryString("aciklama")&"' order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
aciklama=""
else
aciklama=mmmYardimci("isim")
end if
close(mmmYardimci)

sqlString = "SELECT * FROM ozellikler,ozellikler2 where ozellikler2.ozelikid=ozellikler.id and ozellikler2.tur='"&request.QueryString("tur")&"' and ozellikler.tur='"&request.QueryString("kategori")&"' order by ozellikler.id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
kategori=""
else
kategori=mmmYardimci("isim")
end if
close(mmmYardimci)

sqlString = "insert yazilar set yazib='"&urunadi&"',seolink='"&seomlink&"',yazi='"&aciklama&"',kategori='"&kategori&"',form='"&request.QueryString("form")&"',urunid='8',modulmu='0',bagli='0',durum='1',link='0',tarih='"&now&"',gtarih='"&now&"',dil='240'"
Con.execute(sqlString)
sqlString = "SELECT * FROM yazilar order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
yeniicerik=""
else
yeniicerik=mmmYardimci("id")
end if
close(mmmYardimci)

sqlString = "update ozellikler2 set kateid='"&yeniicerik&"' where tur='"&request.QueryString("tur")&"'"

Con.execute(sqlString)	

sqlString = "select * from ozellikler,ozellikler2 where ozellikler.tur='7' and ozellikler2.isim<>'0' and ozellikler2.ozelikid=ozellikler.id and ozellikler2.tur='"&request("tur")&"' order by ozellikler2.id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
ilkresim=""
else
Do While Not mmmYardimci.EOF
sqlString = "SELECT * FROM resimd where baslik='"&yeniicerik&"'"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
ilkresim="0"
else
ilkresim="1"
end if
close(mmmYardimci1)
sqlString = "insert resimd set resimid='"&mmmYardimci("isim")&"',firma='0',type='"&ilkresim&"',tur='"&ilkresim&"',baslik='"&yeniicerik&"',tarih='"&now&"'"
Con.execute(sqlString)

mmmYardimci.movenext
loop
end if
close(mmmYardimci)

session("hata1")="Formdan İçeriğe Eklendi"
session("hatam1")="green"
end sub

sub formDuzenle
if request.Form("sifred")="1" then
sifre=",password='"&request.Form("password")&"'"
else
sifre=""
end if
kolonlar=request.Form("kolon1")&","&request.Form("kolon2")&"-"&request.Form("kolon3")&","&request.Form("kolon4")
    seolarlinkb=request.Form("basarisayfa")
    'seolarlinkh=seolarlink(request.Form("hatasayfa"),"sayfa",lang)
sqlString = "update formlar set formadi='"&request.Form("ad")&"',temp='"&request.Form("temp")&"',csstemp='"&request.Form("csstemp")&"',smtpport='"&request.Form("smtpport")&"',smtpserver='"&request.Form("smtpserver")&"'"&sifre&",gmesaj='"&request.Form("gmesaj")&"',onay='"&request.Form("onay")&"',login='"&request.Form("login")&"',ssls='"&request.Form("ssl")&"',password='"&request.Form("password")&"',icerikid='"&request.Form("engel")&"',veritabanikayit='"&request.Form("veritabani")&"',ciftmail='"&request.Form("liste")&"',mailtemp='"&csskont(request.Form("mailtemp"))&"',froms='"&request.Form("from")&"',basarisayfa='"&seolarlinkb&"',smtpid='"&request.Form("smtpid")&"',korumazaman='"&request.Form("korumazaman")&"',ipblacklist='"&request.Form("blacklist")&"',aktifkategori='"&request.Form("aktifkategori")&"',kolonlar='"&kolonlar&"' where id="&request.Form("urunid")&""

Con.execute(sqlString)	

session("hata1")="Form Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formtDuzenle

For icntt = 1 To Request.Form("ad").Count and Request.Form("urunid").Count and Request.Form("onay").Count  and Request.Form("veritabani").Count and Request.Form("liste").Count and Request.Form("engel").Count and Request.Form("temp").Count 

sqlString = "update formlar set formadi='"&request.Form("ad")(icntt)&"',temp='"&request.Form("temp")(icntt)&"',onay='"&request.Form("onay")(icntt)&"',icerikid='"&request.Form("engel")(icntt)&"',veritabanikayit='"&request.Form("veritabani")(icntt)&"',ciftmail='"&request.Form("liste")(icntt)&"',froms='"&request.Form("froms")(icntt)&"' where id="&request.Form("urunid")(icntt)&""

Con.execute(sqlString)	
next

session("hata1")="Form Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formSil

For icntt = 1 To Request.Form("urunidsil").Count 
silmek = "delete from formlar where id="&Request.Form("urunidsil")(icntt)&""
Con.execute(silmek)
next
session("hata1")="Formlar Silindi"
session("hatam1")="red"
end sub

sub formsmtpDuzenle
if request.Form("sifred")="1" then
sifre=",password='"&request.Form("password")&"'"
else
sifre=""
end if
kolonlar=request.Form("kolon1")&","&request.Form("kolon2")&"-"&request.Form("kolon3")&","&request.Form("kolon4")

sqlString = "update formsmtp set formadi='"&request.Form("ad")&"',smtpport='"&request.Form("smtpport")&"',smtpserver='"&request.Form("smtpserver")&"'"&sifre&",onay='"&request.Form("onay")&"',login='"&request.Form("login")&"',ssls='"&request.Form("ssl")&"',smtpauth='"&request.Form("auth")&"',froms='"&request.Form("from")&"' where id="&request.Form("urunid")&""

Con.execute(sqlString)	

session("hata1")="Smtp Ayarları Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formtsmtpDuzenle

For icntt = 1 To Request.Form("ad").Count

sqlString = "update formsmtp set formadi='"&request.Form("ad")(icntt)&"',onay='"&request.Form("onay")(icntt)&"' where id="&request.Form("urunid")(icntt)&""

Con.execute(sqlString)	
next

session("hata1")="Smtp Ayarları Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formsmtpSil

For icntt = 1 To Request.Form("urunidsil").Count 
silmek = "delete from formsmtp where id="&Request.Form("urunidsil")(icntt)&""
Con.execute(silmek)
next
session("hata1")="Smtp Ayarları Silindi"
session("hatam1")="red"
end sub
%>
<%
sub formnDuzenle

For icntt = 1 To Request.Form("ad").Count  and  Request.Form("iname").Count  and  Request.Form("tur").Count and  Request.Form("gerekli").Count and Request.Form("maxs").Count and Request.Form("form").Count and Request.Form("urunid").Count and Request.Form("gonderen").Count

sqlString = "update ozellikler set isim='"&csskont(request.Form("ad")(icntt))&"', name='"&csskont(request.Form("iname")(icntt))&"',tur='"&request.Form("tur")(icntt)&"',gerekli='"&request.Form("gerekli")(icntt)&"',gonderen='"&request.Form("gonderen")(icntt)&"',maxs='"&request.Form("maxs")(icntt)&"',formid='"&request.Form("form")(icntt)&"',sira='"&icntt&"' where id="&request.Form("urunid")(icntt)&""
Con.execute(sqlString)	

next

session("hata1")="Formlar Düzenlendi"
session("hatam1")="green"
end sub
%>

<%
sub formnSil

For icntt = 1 To Request.Form("urunidsil").Count 
silmek = "delete from ozellikler where id="&Request.Form("urunidsil")(icntt)&""
Con.execute(silmek)
next
session("hata1")="Formlar Silindi"
session("hatam1")="red"
end sub
%>

<% 	
sub formnekle

if request.form("durum")=1 then
sqlString = "select * from ozellikler where alt = 1 and formid='"&request("form")&"' order by sira desc"
else
sqlString = "select * from ozellikler where anasek='"&request("durum")&"' and formid='"&request("form")&"' order by sira desc"
end if
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
siraa=1
else
siraa=int(mmmYardimci("sira"))+1
end if
close(mmmYardimci)

if request.Form("durum")=1 then
alt = 1
tur = request.Form("tur")
else
alt = 0
tur = 0
end if

sqlString = "insert ozellikler set isim='"&csskont(request.Form("ad"))&"',name='"&baslikkont(request.Form("ad"))&"',gerekli='0',sira='"&siraa&"',maxs='25',dil='240',formid='"&request.Form("form")&"',alt='"&alt&"',tur='"&tur&"',anasek='"&request.Form("durum")&"'"
Con.execute(sqlString)

session("hata1")="Form Eklendi"
session("hatam1")="green"
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub
%>

<%
sub resimekle
sayilink = uretilensifre1
 if request.QueryString("yazi")="yeni" then
 
if request.Form("urun")="" then
strbaslikurun=sayilink
else
strbaslikurun=request.Form("urun")
end if
seomlink=baslikkont(strbaslikurun)&""&seosonu&""
sqlString = "SELECT * FROM yazilar where seolink='"&seomlink&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
seolink= seomlink
else
seolink= replace(seomlink,""&seosonu&"","")&"-"&sayilink&""&seosonu&""
end if
close(mmmYardimci)
 
 sqlString = "insert yazilar set yazib='"&csskont(request.Form("urun"))&"',kategori='"&request.QueryString("dkate2")&"',seolink='"&seolink&"',urunid='3',modulmu='"&request.QueryString("modul")&"',durum='1',link='0',dil='240',tarih='"&now&"',gtarih='"&now&"'"
Con.execute(sqlString)
    
    strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    baslik = mmmGenel.Fields("NewID")
    close(mmmGenel)

else
end if

if request.QueryString("baslik")="" then
baslik = baslik
else
  baslik = request.QueryString("baslik")
  sqlString = "SELECT * FROM yazilar where id="&baslik&" order by id desc "
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
  sqlString = "SELECT * FROM kategoriyazi where id="&baslik&" order by id desc "
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
yaziisim="resim"
else
yaziisim=giriskont(csskont(baslikkont(mmmYardimci1("isim"))))
 end if
 close(mmmYardimci1)
else
yaziisim=giriskont(csskont(baslikkont(mmmYardimci("yazib"))))
 end if
 close(mmmYardimci)
  end if


resimcnt=request.form("fileimg").count

For rcnt=1 to resimcnt
    lkj=lkj-1
    strfileimg=request.form("fileimg")(rcnt)
    strfileimg1=strfileimg
    strfldr=request.form("fldr")
sqlString = "SELECT * FROM resimd where baslik='"&baslik&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
ilkresim=1
else
ilkresim=0
 end if
 close(mmmYardimci)
sqlString = "SELECT * FROM resimd where baslik='"&baslik&"' and type='1'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
bresim=1
else
bresim=0
 end if
 close(mmmYardimci)

tip = replace(replace(replace(replace(replace(replace(replace(strfileimg1,"_"," "),strfldr&"/",""),".jpg",""),".jpeg",""),".png",""),".bmp",""),".gif","")

fname=strfileimg
fnamecln=replace(strfileimg,strfldr&"/","")

lkj=lkj+1
if request.form("resimisim")="1" then
    if instr(tip,"/") then
    resad=split(tip,"/")(1)
    else
resad = tip
    end if
else
end if
sqlString = "insert resimd set resimid='"&fnamecln&"', dosyad='"&fname&"' ,firma='0',type='"&bresim&"',tur='"&ilkresim&"',baslik='"&baslik&"',resad='"&jskont(resad)&"',tarih='"&now&"'"
Con.execute(sqlString)


uretilensifre1=""
fname=""
Next
session("hata1")="Resim Eklendi"
session("hatam1")="green"
if request.QueryString("tur")="urunm" then
response.Redirect("urun_modulleri.asp?dkate2="&request.QueryString("dkate2")&"&sek="&request.QueryString("sek")&"")
else

if request.QueryString("redirect")="1" then
Response.redirect Request.ServerVariables("HTTP_REFERER")
else
response.Redirect("sayfalar.asp?dkate2="&request.QueryString("dkate2")&"&sek="&request.QueryString("sek")&"&git="&request.QueryString("git")&"")
end if
end if
end sub
%>

<%
sub Resimsil
if Request.QueryString("resimid")="" then
urunidresimidsilic=Request.Form("resimid").count
else
urunidresimidsilic=1
end if

For ig = 1 To urunidresimidsilic
if Request.QueryString("resimid")="" then
urunidresimidsili=Request.Form("resimid")(ig)
else
urunidresimidsili=Request.QueryString("resimid")
end if

if Request.QueryString("resimdosyasil")="1" then
sqlString = "SELECT * FROM resimd where fid="&urunidresimidsili&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then						
else
resimsili=mmmYardimci("dosyad")
        sqlStringc = "select count(id) as toplam5 from resimd where dosyad='"&resimsili&"'"
    set mmmYardimci2=Conemlak.execute(sqlStringc)
toplam5=mmmYardimci2("toplam5")
    if toplam5 > "1" then
    else
set dosyasis=CreateObject("Scripting.FileSystemObject")
if dosyasis.FileExists(Server.MapPath(""&imgyol&""&resimsili&"")) = true then
dosyasis.DeleteFile(Server.MapPath(""&imgyol&""&resimsili&""))

else
end if
end if

end if
close(mmmYardimci)
    end if

silmek = "delete from resimd where fid="&urunidresimidsili&""
Con.execute(silmek)
next
set dosyasis=nothing
session("hata1")="Resim Silindi"
session("hatam1")="red"
end sub
%>

<% 
sub resimDuzenle	

id = Request.QueryString("id")
hid = Request.QueryString("baslik")
For igs = 1 To Request.Form("rid").Count and Request.Form("ad2").Count and Request.Form("link").Count and Request.Form("acik").Count 

sqlString = "SELECT * FROM resimd where fid="&Request.Form("rid")(igs)&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else

'response.Write(Server.MapPath(""&dbuploadgaleri&""&rssil("resimid")&""))
if eser=1 then
set dosyasis=CreateObject("Scripting.FileSystemObject")
if dosyasis.FileExists(Server.MapPath(""&dbuploadgaleri&""&mmmYardimci("resimid")&"")) = true then
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Path = Server.MapPath(""&dbuploadgaleri&""&mmmYardimci("resimid")&"")
Jpeg.Open Path
jwidth=Jpeg.Width
jheight=Jpeg.Height
else
jwidth=0
jheight=0
end if
else
end if
con.Execute("update resimd Set resad='"&Request.Form("ad2")(igs)&"', link='"&Request.Form("link")(igs)&"', acik='"&Request.Form("acik")(igs)&"', ressize='"&jwidth&":"&jheight&"', firma='"&igs&"' where fid="&Request.Form("rid")(igs)) 
end if
next
session("hata1")="Resim Düzenlendi"
session("hatam1")="green"
end sub
%>

<% 
sub resimonay	

id = Request.QueryString("id")
hid = Request.QueryString("baslik")

if Request.QueryString("ilk")="0" then
else
con.Execute("update resimd Set tur='0' where baslik='"&hid&"'") 
end if
con.Execute("update resimd Set tur='"&Request.QueryString("ilk")&"' where fid="&Request.QueryString("id")) 
session("hata1")="Resim Onaylandı"
session("hatam1")="green"
response.Redirect("galeri.asp?baslik="&request("baslik")&"&dkate2="&request("dkate2")&"&sek="&request.QueryString("sek")&"")
end sub
%>

<% 
sub resimonay1	
id = Request.QueryString("id")
hid = Request.QueryString("baslik")
hid1 = Request.QueryString("dkate2")
if Request.QueryString("ilk")="0" then
else
con.Execute("update resimd Set firma=0 where baslik='"&hid&"'") 
end if
con.Execute("update resimd Set firma='"&hid1&"' where fid="&Request.QueryString("id")) 
session("hata1")="Resim Büyük Resim Olarak Ayarlandı"
session("hatam1")="green"
response.Redirect("galeri.asp?baslik="&request("baslik")&"&dkate2="&request("dkate2")&"")
end sub
%>

<% 
sub resimonay2
id = Request.QueryString("id")
hid = Request.QueryString("baslik")
hid1 = Request.QueryString("dkate2")
if Request.QueryString("ilk")="0" then
else
con.Execute("update resimd Set type='0' where baslik='"&hid&"'") 
end if
con.Execute("update resimd Set type='"&Request.QueryString("ilk")&"' where fid="&Request.QueryString("id")) 
session("hata1")="Resim İlk Resim Olarak Ayarlandı"
session("hatam1")="green"
response.Redirect("galeri.asp?baslik="&request("baslik")&"&dkate2="&request("dkate2")&"&sek="&request.QueryString("sek")&"")
end sub
%>

<%
sub cssduzenlemodul

sqlString = "select * from kategoriyazi where (modulmu='0' and durum='1' and anasek='1'"&sayfagosterme&" and dil='240') or (anasek in (select id from kategoriyazi where durum='1'"&sayfagosterme&" and dil='240') and durum='1') order by isim"

set mmmYardimci = Con.Execute (sqlString)
		Do While Not mmmYardimci.EOF
		colid=mmmYardimci("sayfatemp")    
		colsayfa=mmmYardimci("isim")

coloptioncount=ubound(split(colid,"{modul}"))
if coloptioncount>=1 then
coltype=split(colid,",")(0)
for modi=1 to coloptioncount
modultam=split(colid,"{modul}")(modi)
modultam=split(modultam,"{/modul}")(0)

		cdmstrtemp=split(modultam,",")(4)
		cdmstrsayfa=split(modultam,",")(2)
		cdmstrmodulid=split(modultam,",")(3)
		cdmstrbaslik=split(modultam,",")(1)
		strmsonay=split(modultam,",")(6)	
		strdahaoncevarmi="-="&cdmstrsayfa&"-"&cdmstrtemp&"-"&cdmstrmodulid&"=-"
		if instr(dahaoncevarmi,strdahaoncevarmi)="0" then		
		if strmsonay="1" then
modgoster="1"
else
modgoster="0"
end if
		'response.Write modgoster

'response.Write(strdahaoncevarmi&"<br>")

if modgoster="1" then

		if cdmstrmodulid<>"90" and cdmstrsayfa<>"979" and instr(cdmstrsayfa,"vip")="0" then
		set mmmYardimci3 = Con.Execute ("select * from yazilar where id="&replace(replace(cdmstrsayfa,"k",""),"y","")&" and modulmu='1' and durum='1' group by id ORDER BY id")
		if mmmYardimci3.eof then
else
strid=mmmYardimci3("id")
if  Request("eskirenk")="" and Request("yenirenk")="" then
strbilgi1=mmmYardimci3("bilgi1")
else
strbilgi1=mmmYardimci3("bilgi1")
if strbilgi1="" or isNull(strbilgi1) then
else
strbilgi1=replace(replace(strbilgi1,ucase(Request("eskirenk")),Request("yenirenk")),Request("eskirenk"),Request("yenirenk"))

con.Execute("update yazilar Set bilgi1='"&strbilgi1&"' where id="&strid&"")
end if
end if

stryazib=mmmYardimci3("yazib")
if instr(strbilgi1,"{") then
stylis=stylis&"/*"&baslikkont(stryazib)&"*/"&listeleme1style(strbilgi1,csstip)
stylisveri1=listeleme1style(strbilgi1,csstip)
        if instr(cssstr,stylisveri1) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylisveri1
        end if
strbilgi1=""
else
strbilgi1=""
end if
'response.Write(listeleme1style(mmmYardimci3("bilgi1"),csstip))
'response.End()

end if
close(mmmYardimci3)
csstip=""
		else
		end if		

if cdmstrsayfa="0" or instr(cdmstrsayfa,"vip") then 
i1ayar3=cdmstrtemp
else
		 i1ayar3=replace(replace(cdmstrsayfa,"k",""),"y","")
		 end if
		 'response.Write(i1ayar3&"-")
		 
	  kayar2=cdmstrtemp
	  kayar3=ayar2
	  stylevar="1"
	  
Call kategoriayar(i1ayar3,kayar2,kayar3)
if i1ayar3="0" then
	  csstip=kayar2
	  else
	  csstip=i1ayar3&""&kayar2
	  end if
	  if instr(csstipvar,csstip)<>"0" then
	  	'  response.Write csstip&"-"&colsayfa&"<br>"
else
if cdmstrtemp="0" or cdmstrtemp="" or cdmstrmodulid="90" then

	  else
	  'response.Write(csstip&""&i2&""&kayar2&""&i1ayar3)
	  'response.Write(csstip&"<br>")
jsis=jsis&""&listeleme1style(l6,csstip)
if  Request("eskirenk")="" and Request("yenirenk")="" then
i8=i8
else
i8=i8
if i8="" or isNull(i8) then
else
'response.Write(kayar2&"a")
i8=replace(replace(i8,ucase(Request("eskirenk")),Request("yenirenk")),Request("eskirenk"),Request("yenirenk"))
'response.Write(i8&"a")
con.Execute("update kategoriayar Set l10='"&i8&"', i8='"&i8&"' where id="&kayar2&"")
end if
end if
stylis=stylis&"/*"&baslikkont(cdmstrbaslik)&"*/"&listeleme1style(i8,csstip)
stylisveri1=listeleme1style(i8,csstip)
        if instr(cssstr,stylisveri1) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylisveri1
        end if
end if
kayariddd=i2
if kayariddd="0" or kayariddd="" then
stylisveri1=""
jsisveri1=""
else
Call kategoriayar(i1ayar3,kayariddd,kayar3)
jsis=jsis&""&listeleme1style(l6,csstip)
if  Request("eskirenk")="" and Request("yenirenk")="" then
i8=i8
else
i8=i8
if i8="" or isNull(i8) then
else
i8=replace(replace(i8,ucase(Request("eskirenk")),Request("yenirenk")),Request("eskirenk"),Request("yenirenk"))
con.Execute("update kategoriayar Set l10='"&i8&"', i8='"&i8&"' where id="&kayariddd&"")
end if
end if

stylis=stylis&"/*"&baslikkont(cdmstrbaslik)&"*/"&listeleme1style(i8,csstip)
stylisveri1=listeleme1style(i8,csstip)
        if instr(cssstr,stylisveri1) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylisveri1
        end if
'response.Write(stylisveri1)
'response.end
end if

end if
if i1ayar3="0" then
	  else
	  csstipvar=csstipvar&","&csstip
	  end if
	  csstip=""	  	 
	   
	
	  else
end if

else

end if

dahaoncevarmi=dahaoncevarmi&"-="&cdmstrsayfa&"-"&cdmstrtemp&"-"&cdmstrmodulid&"=-"

	  next
  

end if
  mmmYardimci.MoveNext
  loop
 close(mmmYardimci)
'response.Write(jsis)
'response.end
    
 'response.Write("<style>")
'response.Write(stylis)
 'response.Write("</style>")
  'response.Write("<script type=""text/javascript"">")
'response.Write(jsis)
'response.Write("<'/script>")
'response.End()
    call filesavebackup("../contents/css/","../contents/css/temp_element/","custom_element","css",minify(csskont1(cssstr)))
    call filesavebackup("../contents/js/","../contents/js/temp_element/","custom_element","js",minify(jskont(jsis)))
 
end sub

  function minify(nesne)  
nesne = Replace(nesne , vbCrLf , "" ) 
nesne = Replace(nesne , "     " , " " ) 
nesne = Replace(nesne , "    " , " " ) 
nesne = Replace(nesne , "   " , " " ) 
nesne = Replace(nesne , "  " , " " ) 
nesne = Replace(nesne , "`" , "'" ) 
minify = nesne 
end function
sub cssduzenle

    'response.Write Request.Totalbytes
for ho= 1 to request.Form("cssnbas").count
if request.Form("cssnbas")(ho)="" then
else
logocssnbas="/*"&request.Form("cssnbas")(ho)&"*/"

logocssnana=""&logocssnana&""&logocssnbas&""&request.Form("logodegera"&ho&"")&""
logocss=""
'logocssana=""

end if
next
for ho= 1 to request.Form("jsnbas").count
if request.Form("jsnbas")(ho)="" then
else
logojsnbas="/*"&request.Form("jsnbas")(ho)&"*/"

logojsnana=""&logojsnana&""&logojsnbas&""&request.Form("logodegerjs"&ho&"")&""
logojs=""
'logojsnana=""

end if
next
    call filesavebackup("../contents/css/","../contents/css/temp/","custom","css",minify(csskont1(logocssnana)))
    call filesavebackup("../contents/js/","../contents/js/temp/","custom","js",minify(csskont1(logojsnana)))

    
call cssduzenlemodul

session("hata1")="Tasarım Csse Aktarıldı"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

    sub filesavebackup(src,dst,file,typ,logocssnana)
    
 Dosya_Yol=Server.MapPath(""&src&""&file&"."&typ&"" )
    Temp_Yol=Server.MapPath(""&dst&""&file&"_"&baslikkont(now)&"."&typ&"")
Set Dosya_Sistemi=Server.CreateObject("Scripting.FileSystemObject" ) 
    If (Dosya_Sistemi.FileExists(Dosya_Yol))=true Then
    'response.Write Dosya_Yol&"-"&Temp_Yol
 Dosya_Sistemi.CopyFile Dosya_Yol, Temp_Yol
    end if
Set Dosya_Yaz=Dosya_Sistemi.CreateTextFile(Dosya_Yol,True)
	Dosya_Yaz.WriteLine(logocssnana)
    Dosya_Yaz.close

    Set objFiles = Dosya_Sistemi.GetFolder(Server.MapPath(""&dst&"")).Files
    lngFileCount = objFiles.Count-5
    For Each obj In objFiles
    'obj.DateLastModified
    objc=objc+1
    'response.write obj.DateLastModified&"<br>"
    if objc<=lngFileCount then
    Dosya_Sistemi.DeleteFile(Server.MapPath(""&dst&""&obj.Name&""))
    end if
    Next

    end sub
%>



<% 
sub duzenledillerformalt

id = Request("haberid")
For icntt = 1 To Request.Form("haberid").Count and Request.Form("haberb").Count  and Request.Form("sira1").Count and Request.Form("durum2").Count

            if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then  
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(Request.Form("haberb")(icntt)))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(Request.Form("haberb")(icntt)))&""&seosonu&""
    end if
baslik=server.HTMLEncode(Request.Form("haberb")(icntt))
else    
baslik=Request.Form("haberb")(icntt)
end if

if Request("haberid")(icntt)=0 then
con.Execute("insert ozellikler Set dil='"&Request("sek")&"',isim='"&giriskont(baslik)&"',bagli='"&Request("durum2")(icntt)&"',sira='"&Request("sira1")(icntt)&"'")
else
con.Execute("update ozellikler Set isim='"&giriskont(baslik)&"',sira='"&Request("sira1")(icntt)&"' where id="&Request("haberid")(icntt)&"")
end if
next

session("hata1")="Alt Form Dilleri Düzenlendi"
session("hatam1")="green"
end sub
%>

<% 
sub duzenledillerform

id = Request("haberid")

For icntt = 1 To Request.Form("haberid").Count and Request.Form("haberb").Count and Request.Form("haberb2").Count and Request.Form("durum2").Count
        if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then  
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(Request.Form("haberb")(icntt)))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(Request.Form("haberb")(icntt)))&""&seosonu&""
    end if
baslik=server.HTMLEncode(Request.Form("haberb")(icntt))
baslik2=server.HTMLEncode(Request.Form("haberb2")(icntt))
else    
baslik=Request.Form("haberb")(icntt)
baslik2=Request.Form("haberb2")(icntt)
end if

if Request("haberid")(icntt)=0 then
con.Execute("insert formlar Set dil='"&Request.QueryString("sek")&"',formadi='"&baslik&"',gmesaj='"&baslik2&"',bagli='"&Request.Form("durum2")(icntt)&"'")
else
con.Execute("update formlar Set formadi='"&baslik&"',gmesaj='"&baslik2&"' where id="&Request.Form("haberid")(icntt)&"")
end if
next

session("hata1")="Form Dilleri Düzenlendi"
session("hatam1")="green"
end sub
%>

<% 
sub duzenleicerik

id = Request("haberid")
con.Execute("update yazilar Set yazib='"&giriskont(Request("haberb"))&"',yazi='"&jskont(Request("myTextarea"))&"',bilgi1='"&Request("bilgi1")&"',bilgi2='"&Request("bilgi2")&"',bilgi3='"&Request("bilgi3")&"',bilgi4='"&Request("bilgi4")&"' where id="&Request("id")&"")

session("hata1")="İçerik Düzenlendi"
session("hatam1")="green"
end sub
%>

<% 
    
sub sildilleryazi
sqlString = "select * from yazilar where dil='"&giriskont(request.QueryString("sek"))&"'"
Set mmmYardimci1=Con.execute(sqlString)
Do While Not mmmYardimci1.EOF
    strkateid=mmmYardimci1("id")
silmek = "delete from ozellikler2 where kateid='"&strkateid&"'"
Con.execute(silmek)
sqlString = "select * from resimd where baslik='"&strkateid&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")
end if
close(mmmYardimci)
silmek = "delete from resimd where baslik='"&strkateid&"'"
Con.execute(silmek)
    
silmek = "delete from seolar where seoid='"&strkateid&"'"
Con.execute(silmek)

silmek = "delete from yazilar where id='"&strkateid&"'"
Con.execute(silmek)
mmmYardimci1.MoveNext
  loop
  close(mmmYardimci1)

    end sub

    
sub duzenledilleryazi
id = Request("haberid")
For icntt = 1 To Request.Form("haberid").Count and Request.Form("haberb").Count  and Request.Form("sira1").Count and Request.Form("durum2").Count
sayilink = sifreuret()
    

    seomlink1=server.HTMLEncode(Request.Form("seolink")(icntt))

    if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then  
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(Request.Form("haberb")(icntt)))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(Request.Form("haberb")(icntt)))&""&seosonu&""
    end if
baslik=server.HTMLEncode(Request.Form("haberb")(icntt))
else    
baslik=csskont(Request.Form("haberb")(icntt))
seomlink=csskont(baslikkont(Request("haberb")(icntt)))&""&seosonu&""
end if

    if seomlink1="" then
    seomlink=seomlink
    else
    seomlink=seomlink1
    end if
    tfgid=Request("haberid")(icntt)
sqlString = "SELECT * FROM yazilar where id="&Request.Form("durum2")(icntt)&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
'seolink= seomlink
else
urunid=mmmYardimci("urunid")
modulmu=mmmYardimci("modulmu")    
                    if urunid<>"9" and urunid<>"4" and urunid<>"5" and urunid<>"3" and modulmu="0" then
                    modulmu="1"
                    end if
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

end if
close(mmmYardimci)
if Request("haberid")(icntt)=0 then
 if Request("haberb")(icntt)="" then 
    else
con.Execute("insert yazilar Set dil='"&Request("sek")&"',yazib='"&baslik&"',bagli='"&Request("durum2")(icntt)&"',sira1='"&Request("sira1")(icntt)&"',seolink='"&seolink&"',urunid='"&urunid&"' ,modulmu='"&modulmu&"' ,bilgi1='"&bilgi1&"' ,bilgi2='"&bilgi2&"' ,bilgi3='"&bilgi3&"' ,bilgi4='"&bilgi4&"' ,durum='"&durum&"' ,ilksayfa='"&ilksayfa&"' ,form='"&form&"' ,sira='"&sira&"' ,admin='"&admin&"' ,temp='"&temp&"'")
        strSQL="select @@IDENTITY as NewID from yazilar"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)
    if modulmu="1" then
    else
    call seourlduzenle(seomlink,tfgid,"yazi",Request("sek")) 
    end if
    end if
else
con.Execute("update yazilar Set yazib='"&baslik&"',sira1='"&Request("sira1")(icntt)&"',seolink='"&seolink&"' where id="&Request("haberid")(icntt)&"")
    
    if modulmu="1" then
    else
 if Request("haberb")(icntt)="" then 
    else
    call seourlduzenle(giriskont(seomlink),Request("haberid")(icntt),"yazi",Request("sek"))
    end if
    'sqlstring="update seolar set seobaslik='"&csskont(Request.Form("seotitle")(icntt))&"',seoaciklama='"&csskont(Request.Form("seodesc")(icntt))&"' where seoid='"&Request("haberid")(icntt)&"'"
    'Con.execute(sqlstring)
end if
end if
sayilink=""
next

session("hata1")="İçerik Başlık Dilleri Değiştirildi"
session("hatam1")="green"
end sub
%>

<% 

sub sildillerkate
sqlString = "select * from kategoriyazi where dil='"&giriskont(request.QueryString("sek"))&"' and isNull(anasek)"
Set mmmYardimci1=Con.execute(sqlString)
Do While Not mmmYardimci1.EOF
    strkateid=mmmYardimci1("id")

    call sayfasil(strkateid)

  mmmYardimci1.MoveNext
  loop
  close(mmmYardimci1)
    end sub


sub duzenledillerkate

      'Dim objFSO
'Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Open the text file
'Dim objTextStream
'Set objTextStream = objFSO.OpenTextFile(Server.MapPath("../contents/lang-tr.inc"), 2, True)

id = Request("haberid")
For icntt = 1 To Request.Form("haberid").Count and Request.Form("haberb").Count and Request.Form("durum2").Count

sayilink = sifreuret()
    baslik=csskont(request.Form("haberb")(icntt))
    baslikstr=baslik
    seobaslik=csskont(request.Form("seotitle")(icntt))
    seoacik=csskont(request.Form("seodesc")(icntt))

            if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then 
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(baslikstr))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(baslikstr))&""&seosonu&""
    end if
    baslik=server.HTMLEncode(baslik)
    seobaslik=server.HTMLEncode(seobaslik)
    seoacik=server.HTMLEncode(seoacik)
else     
    seomlink=baslikkont(baslikstr)&""&seosonu&""
end if



    tfgid=Request("haberid")(icntt)
'text=Utf8ToUnicode( Request.Form("haberb")(icntt) )
'Response.CodePage = 1252 
'Response.CharSet = "windows-1252"
    
    'response.Write text
    'response.End
sqlString = "SELECT * FROM kategoriyazi where id="&Request.Form("durum2")(icntt)&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
seolink= seomlink
else
sifreli=mmmYardimci("sifreli")
modulmu=mmmYardimci("modulmu")
stura=mmmYardimci("stura")
baslikd=mmmYardimci("baslikd")
slider=mmmYardimci("slider")
smodula=mmmYardimci("smodula")
sayara=mmmYardimci("sayara")
orta=mmmYardimci("orta")
sol=mmmYardimci("sol")
sosyal1=mmmYardimci("sosyal1")
sosyal2=mmmYardimci("sosyal2")
sira=mmmYardimci("sira")
menugosterim=mmmYardimci("menugosterim")
durum=mmmYardimci("durum")
target=mmmYardimci("link")
okusayi="0"

end if
close(mmmYardimci)
if Request("haberid")(icntt)=0 then
    
 if Request("haberb")(icntt)="" then 
    else
con.Execute("insert kategoriyazi Set dil='"&Request("sek")&"',isim='"&baslik&"',bagli='"&Request("durum2")(icntt)&"',seolink='"&seolink&"', sifreli='"&sifreli&"', modulmu='"&modulmu&"', stura='"&stura&"', baslikd='"&baslikd&"', slider='"&slider&"', smodula='"&smodula&"', sayara='"&sayara&"', orta='"&orta&"', sol='"&sol&"', sosyal1='"&sosyal1&"', sosyal2='"&sosyal2&"', sira='"&sira&"', menugosterim='"&menugosterim&"', durum='"&durum&"', target='"&target&"', okusayi='"&okusayi&"'")
    strSQL="select @@IDENTITY as NewID from kategoriyazi"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)
    if modulmu="1" then
    else
    call seourlduzenle(seomlink,tfgid,"sayfa",Request("sek")) 
    end if
    end if
else
con.Execute("update kategoriyazi Set isim='"&baslik&"',seolink='"&seolink&"' where id="&Request("haberid")(icntt)&"")
    
    if modulmu="1" then
    else
    seolinki=Request.Form("seolink")(icntt)
     if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" or Request("charcode")="pl" then 
    if Request("charcode")="ru" then 
    else
    seolinki=server.HTMLEncode(Request.Form("seolink")(icntt))
    end if
    end if
    if seolinki="" then
    seolinki=seomlink
    end if
    call seourlduzenle(giriskont(seolinki),Request("haberid")(icntt),"sayfa",Request("sek"))
    sqlstring="update seolar set seobaslik='"&csskont(seobaslik)&"',seoaciklama='"&csskont(seoacik)&"' where seoid='"&Request("haberid")(icntt)&"'"
    Con.execute(sqlstring)
end if

end if
    
  '  objTextStream.WriteLine ""&baslikkont(seobaslik)&"="&seobaslik&""

sayilink=""
next
 'objTextStream.Close
'Set objTextStream = Nothing
'Set objFSO = Nothing

session("hata1")="Sayfa Dilleri Düzenlendi"
session("hatam1")="green"
end sub
%>


<%
sub dillersilu

silmek = "delete from diller1 where anasek='"&Request("id")&"'"
Con.execute(silmek)

'silmek = "delete from diller1 where id="&Request("id")&""
'Con.execute(silmek)
session("hata1")="Dil Silindi"
session("hatam1")="red"
end sub
%>

<%
sub dillersilceviri

id = Request("id")

silmek = "delete from diller1 where id="&id&""
Con.execute(silmek)
session("hata1")="Dil Çeviri Silindi"
session("hatam1")="red"
end sub
%>

<% 	
sub dillerekle

sqlString = "SELECT * FROM diller1 order by sira desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
dillersira= 0
else
dillersira= mmmYardimci("sira")+1
end if
close(mmmYardimci)

if request.Form("sek")=1 then
alt = 1
else
alt = 0
end if
    if Request("charset")="ar" or Request("charset")="cn" or Request("charset")="ru" or Request("charset")="az" then 

    baslik=server.HTMLEncode(request.Form("sek"))
else     
    baslik=request.Form("sektor")
end if
con.Execute("insert diller1 Set kate='"&baslik&"',alt='"&alt&"',anasek='"&Request.form("sek")&"',sira='"&dillersira&"'")

session("hata1")="Dil Eklendi"
session("hatam1")="green"
response.write"<b>İlan Kayit Yapilmistir</b><br>"
end sub
%>

<% 	
sub dillerduzenle
                if Request("charset")="ar" or Request("charset")="cn" or Request("charset")="ru" or Request("charset")="az" then 

    baslik=server.HTMLEncode(request.Form("sektor"))
else     
    baslik=request.Form("sektor")
end if
con.Execute("update diller1 Set kate='"&baslik&"',ceviricode='"&request.Form("charset")&"',sira='"&request.Form("buton")&"',anasek='"&Request.form("durum")&"' where id="&request("id")&"")

session("hata1")="Dil Düzenlendi"
session("hatam1")="green"
'response.write"<b>Dil Kayit Yenilendi</b><br>"
end sub

sub dilleraktif

con.Execute("update diller1 Set nott='0' where alt='1'")

con.Execute("update diller1 Set nott='1' where id="&request("id")&"")

session("hata1")="Dil Aktifleştirildi"
session("hatam1")="green"
'response.write"<b>Dil Kayit Yenilendi</b><br>"
end sub
%>

<% 
sub duzenlediller

    id = Request("haberid")
For i = 1 To Request.Form("haberid").Count and Request.Form("haberb").Count  and Request.Form("sira1").Count and Request.Form("durum").Count
    
    if Request("sek")="533" or Request("sek")="701" or Request("sek")="819" then
    sekstr=server.HTMLEncode(Request.form("haberb")(i))
    else
    sekstr=Request.form("haberb")(i)
    end if
    'response.Write sekstr
   ' response.End
if Request("haberid")(i)=0 then
    con.execute("insert diller1 set anasek='"&Request("sek")&"', ayri='1', sira1='"&csskont(Request("sira1")(i))&"', bagli='"&Request("durum")(i)&"', kate='"&csskont(sekstr)&"'")
else
    con.execute("update diller1 set sira1='"&csskont(Request("sira1")(i))&"', kate='"&csskont(sekstr)&"' where id="&Request("haberid")(i)&"")
end if

next


session("hata1")="Diller Düzenlendi"
session("hatam1")="green"
end sub

     sub islemmessagesession(tur,mesaj,url)

session("hata1")=mesaj
session("hatam1")=tur
if url="1" then
Response.Redirect Request.ServerVariables("HTTP_REFERER")
else
Response.Redirect url
end if
end sub
%>

