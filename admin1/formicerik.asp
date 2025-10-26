<!--#Include file="admin_menu1.asp"-->
<%
formid=request("form")
if session("yonet_dil")="" then
session("yonet_dil")=240
else
end if
%>
<div class="ietisim_baslik_onay">
      <%
	  islemler=Request.QueryString("islem")
if islemler="ekle" then
call formgonderikayit(formid,0)
set mmmYardimci3 = Con.Execute ("select * from formlar where id='"&formid&"'")
if mmmYardimci3.eof then
else
fisim=mmmYardimci3("formadi")
fid=mmmYardimci3("id")
gmesaj=dilformv(fid,fisim,lang)
end if
close(mmmYardimci3)
	if session("formgonderildi")=1 then%>
      <%=gmesaj %>
      <%else%>
      Kayıt edilemedi.
      <%end if
						  else%>
      <% end if%>
    </div>
<% 	
con.Execute("update ozellikler2 Set oku='1' where formid='"&Request.QueryString("form")&"'") 
sqlString = "select * from formlar where id="&formid&""
set mmmGenel = Con.Execute (sqlString)
strfkolonlar=mmmGenel("kolonlar")
strfaktifk=mmmGenel("aktifkategori")
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
close(mmmGenel)

            	if request("usayi")="" then
    if request.form("filtrearaislem")="1" then
	KayitSayisi=3000000
    else
	KayitSayisi=30
    end if
	else
	KayitSayisi=request("usayi")
	end if
git = Request.QueryString("git")
if git="" then
git=1
end if
          link="sira="&sira&"&form="&formid&""
    sayfalink=link
%>
<div class="right_col" role="main">
<div class="x_panel">
<div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                      <div class="panel">
   <%
         if yetkiuye="1" then							
                
       %>
               <form method="post" name="Form2" id="Form2" action="?<%=link %>&git=<%=git %>" target="_self">
    <table class="table table-striped"> 
      <tr>
           <td>
        <input name="filtreara" type="text" value="" /></td>  
           <td>
        <input name="filtrearaozellik" type="text" value="" /></td>  
           <td>
        <select id="filtrearasec" name="filtrearasec" class="form-control">
    <option value="1">Tam Eşleme</option>
    <option value="3">Tam Eşlenmeyen</option>
    <option value="0" >Geniş Eşleme</option>
    <option value="2" >Geniş Eşlenmeyen</option>
  </select>
               </td> 
           <td>
        <select id="filtrearaislem" name="filtrearaislem" class="form-control">
    <option value="0">İşlem Yapma</option>
    <option value="1">Sil</option>
    <option value="2" >Onayla</option>
  </select>
               </td>  
           <td>
         <input  type="submit"  name="Submit" value="Ara" class="btn btn-success pull-right">

           </td>   
</tr>
    </table>
        </form>
                          <%else
                              end if %>
    <form method="post" name="Form1" id="Form1" action="?form=<%=request.QueryString("form")%>" target="_self">
           <%
  
             
        if request.form("filtreara")="" then
        filtreqrya="where formid='"&formid&"' and ozelikid = '1' and isim = '1'"
        else  
        if request.form("filtrearaozellik")="" then
               filtrearaozellikqry=""
               else
               filtrearaozellikqry=" and ozelikid='"&request.form("filtrearaozellik")&"'"
               end if
        if request.form("filtrearasec")="1" then
        filtreqry=" and isim='"&request.form("filtreara")&"'"
        filtreqrya="where formid='"&formid&"' and isim='"&request.form("filtreara")&"'"&filtrearaozellikqry&" "
        elseif request.form("filtrearasec")="3" then
        filtreqry=" and isim='"&request.form("filtreara")&"'"
        filtreqrya="where formid='"&formid&"' and isim<>'"&request.form("filtreara")&"'"&filtrearaozellikqry&" "
        elseif request.form("filtrearasec")="2" then
        filtreqry=" and isim='"&request.form("filtreara")&"'"
        filtreqrya="where formid='"&formid&"' and isim not like '%"&request.form("filtreara")&"%'"&filtrearaozellikqry&" "
        else
        filtreqry=" and isim like '%"&request.form("filtreara")&"%'"
        filtreqrya="where formid='"&formid&"' and isim like '%"&request.form("filtreara")&"%'"&filtrearaozellikqry&" "
        end if
        end if

ozellik=replace(replace(session("ozellikki"),", -0",""),"-0, ","")
 
 oiddadet=ubound(split(ozellik,","))           
Set mmmYardimci4 = Server.CreateObject("Adodb.Recordset")
 sqlString = "select * from ozellikler2 "&filtreqrya&" order by id desc limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
            set mmmYardimci4 = Con.Execute (sqlString)
          set mmmYardimci2=Con.execute("select count(id) as toplam5 from ozellikler2 "&filtreqrya&"")
          
toplam5=mmmYardimci2("toplam5")
close(mmmYardimci2)
               %>
  <table class="table table-striped"> 
      <tr>
           <td colspan="3"><%call sayfalaurun()%></td>

   
    <td width="5%" align="center"><a href="formexcel.asp?form=<%=formid%>" target="_blank" class="btn btn-success">Excel Aktar</a> <input type="checkbox" name="resimid1" class="flatred" id="checkAll"></td>
</tr>
<%
if mmmYardimci4.eof then%>
  <%else
 Do While Not mmmYardimci4.EOF
 fgtur=mmmYardimci4("tur")%>
  

<%if request.QueryString("filtre")="1" then
			for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if
    
Set mmmYardimci5 = Server.CreateObject("Adodb.Recordset")
sqlString = "select * from ozellikler2 where kateid='"&mmmYardimci4("kateid")&"' and isim = '"&agacoidd&"'"
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
yv=yv+0
yy=yy+1
else
yv=yv+1
yy=yy+0
end if
close(mmmYardimci5)
next
else
yy="0"
end if

yyana=yyana+yy

if yy<>"0" then
e=e+1
else
ifi=ifi+1%>

    <tr>
    <%
        
        strfitarih=mmmYardimci4("tarih")
        strfikateid=mmmYardimci4("kateid")
        strfiip=mmmYardimci4("ip")
        strfiformid=mmmYardimci4("formid")
        strfitur=mmmYardimci4("tur")
stronay=mmmYardimci4("onay")
if formid="107" then
foid="3313"
 sqlString = "select * from ozellikler2 where ozelikid='"&foid&"' and tur='"&mmmYardimci4("tur")&"' order by id"
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
baslikformid="0"
else
baslikformid=mmmYardimci5("isim")
end if
close(mmmYardimci5)
elseif formid="103" then
foid=mmmYardimci4("kateid")
 sqlString = "select * from yazilar where id="&foid&""
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
baslikformid="0"
else
baslikformid=mmmYardimci5("yazib")
end if
close(mmmYardimci5)
else
baslikformid=mmmYardimci4("id")
end if

        
        if request.form("filtreara")="" then
        filtrearastr="1"
        else
 sqlString = "select * from ozellikler2 where formid='"&formid&"' and ozelikid = '1' and isim = '1' and tur ='"&strfitur&"' order by id"
        'response.Write sqlString
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
filtrearastr="0"
else
filtrearastr="1"
        strfitarih=mmmYardimci5("tarih")
        strfikateid=mmmYardimci5("kateid")
        strfiip=mmmYardimci5("ip")
        strfiformid=mmmYardimci5("formid")
        strfitur=mmmYardimci5("tur")
stronay=mmmYardimci5("onay")
baslikformid=mmmYardimci5("id")


end if
close(mmmYardimci5)
        end if

formcount=formcount+1
        if request.form("filtrearaislem")="1" then
        silmek = "delete from ozellikler2 where tur='"&strfitur&"'"
        Con.execute(silmek)
        else
        end if
        'if filtrearastr="1" then

        
Set mmmYardimci6 = Server.CreateObject("Adodb.Recordset")
set mmmYardimci6 = Con.Execute ("select * from ozellikler,ozellikler2 where gonderen='1' and ozelikid = ozellikler.id and ozellikler2.tur='"&strfitur&"'")
if mmmYardimci6.eof then
formisims="0"
else
formisims=mmmYardimci6("isim")
end if
close(mmmYardimci6)
%>
        <td>
    <a class="dropdown-toggle" data-toggle="modal" data-target="#moduladd" style="cursor: pointer;" id="heading<%=formcount%>" href="db.asp?islem=formcall&formid=<%=formid %>&fgtur=<%=fgtur %>">
                          <h4 class="panel-title"><%=baslikformid%>-<%=formisims%> <small>No</small> <%=strfitarih%> <small>Tarihli Kayıt</small></h4>
                        </a></td>

    <td ><select id="onay" name="onay" class="form-control">
    <option value="0">Yeni Başvuru</option>
    <option value="1" <%if stronay&""="1" or stronay&""="" then %>selected<%else %><%end if %> >Okundu İşlem Bekliyor</option>
    <option value="3" <%if stronay&""="3" then %>selected<%else %><%end if %>>Onaylı Başvuru</option>
    <option value="2" <%if stronay&""="2" then %>selected<%else %><%end if %>>Evrak Bekliyor</option>
    <option value="4" <%if stronay&""="4" then %>selected<%else %><%end if %>>Potansiyel Müşteri</option>
    <option value="5" <%if stronay&""="5" then %>selected<%else %><%end if %>>Sonuç Alınamadı</option>
  </select>
                         </td>
    <td width="15%" align="center">
        <%if strfaktifk<>"0" and (isNull(strfikateid)=False or strfikateid<>"") then
Set mmmYardimci6 = Server.CreateObject("Adodb.Recordset")
	set mmmYardimci6 = Con.Execute ("select * from yazilar where id="&strfikateid&"")
 if mmmYardimci6.eof then
 kategori="0"
else
kategori=mmmYardimci6("kategori")
end if
close(mmmYardimci6)
	%><a href="admin_uruny_duzenle.asp?duzelt1=8&urunid=<%=strfikateid%>&baslik=<%=strfikateid%>&sek=<%=kategori%>&dkate2=<%=kategori%>">Form Detayı</a><a href="galeri.asp?baslik=<%=strfikateid%>&dkate2=<%=kategori%>">Form Resimleri</a><%else%> IP: <%=strfiip%><br />
<%if strfaktifk="0" then
else%>
<a href="?islem=formdanicerige&form=<%=strfiformid%>&kategori=<%=strfaktifk%>&urunadi=<%=strfkolonlar2%>&aciklama=<%=strfkolonlar4%>&tur=<%=strfitur%>&Fiyat1=<%=Fiyat1%>">Formu Onayla</a>
<%end if%><%end if%>
</td>
    <input name="urunid" type="hidden" value="<%=strfitur%>" />
    <td width="5%" align="center"><input name="sil" class="flatred" type="checkbox"  value="<%=strfitur%>" /></td>
 
</tr>
 

      <% 
	end if
	yv=0
yy=0					  
mmmYardimci4.movenext
loop
end if

close(mmmYardimci4)
%>
</table>
  <table width="100%">
  <tr>
  <td width="80%"><%call sayfalaurun()%></td>
  <td align="right"><input name="Submit3" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?form=<%=request.QueryString("form")%>&Submit=formiDuzenle');"/></td>
      <td align="center"><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?form=<%=request.QueryString("form")%>&Submit=formiSil');"/></td>
  </tr>
  </table>
  </form>
  <SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.Form1.action=gelen;
	document.Form1.submit();
	}
  //-->
  </SCRIPT>
</div>

<hr style="width:100%;">
<div class="x_title"><h2>YENİ EKLE</h2>
<div class="clearfix"></div></div>
 

<form name="theForm" id="theForm" onSubmit="return validate(this);" method="post"  enctype="multipart/form-data" action="?islem=ekle&form=<%=formid%>">

    
    
    <%
	gorozel1=" and (id <> 424 and id <> 429 and id <> 422 and id <> 421 and id <> 320 and id <> 317 and id <> 423 and id <> 312)"

	 set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"'"&gorozel1&" and alt = '1' order by sira")

Do While Not mmmYardimci3.EOF
fname=mmmYardimci3("name")
fisim=mmmYardimci3("isim")
fid=mmmYardimci3("id")
ftur=mmmYardimci3("tur")
formisim=dilformv(fid,fisim,lang)
if ftur=8 then%>
<div class="grupanabaslik"><%=formisim%></div><div class="grupform1">
<%
 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid&"' order by sira")
Do While Not mmmYardimci2.EOF
fid1=mmmYardimci2("id")
fisim1=mmmYardimci2("isim")
ftur1=mmmYardimci2("tur")
formisim1=dilformv(fid,fisim,lang)
if ftur1=8 then
%>
<div class="grupanabaslik"><%=formisim1%></div><div class="grupform1">
<%
 set mmmYardimci1 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid1&"' order by sira")
Do While Not mmmYardimci1.EOF
fid3=mmmYardimci1("id")
ftur3=mmmYardimci1("tur")
response.Write(formolustur(fgtur,1,fid3,fovalue))
		fname3=""				  
mmmYardimci1.movenext
loop
close(mmmYardimci1)
%>
</div>
<%
else
response.Write(formolustur(fgtur,1,fid1,fovalue))
end if

		fname1=""				  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
</div>
<%
elseif ftur=9 then
%>
<select id="Select12" size="1" onChange="return kategoriSec()" name="<%=fname%>">
                                   <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&fid&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
fname2=mmmYardimci2("name")
fisim2=mmmYardimci2("isim")
fid2=mmmYardimci2("id")
ftur2=mmmYardimci2("tur")
formisim2=dilformv(fid2,fisim2,lang)%>
                          <OPTION value="<%=fid2%>" ><%=formisim2%></OPTION>
                              <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
                                  </select>
                                  <div id="sonuc"></div>
                                  <SCRIPT type=text/javascript>



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
   if ( !http && typeof XMLHttpRequest != 'undefined' ) {
	   
     try{
        http = new XMLHttpRequest();
     }catch(e) {    
        http = false;
     }

   }

   // Diger
   if ( !http && window.createRequest ) {
     
	 try{
        http = window.createRequest();
     }catch(e) {  
        http = false;
     }

   }


function kategoriSec() {

     var kategori = document.getElementById('Select12').value;
     if(kategori!=0) {
          http.open('get', '/sehirsec1.asp?Kategori=' + kategori);
          http.onreadystatechange = function() {
               document.getElementById('sonuc').innerHTML = "Bekleyiniz...";
               if (http.readyState == 4) {
                    document.getElementById('sonuc').innerHTML = http.responseText; }
          };
          http.send(null);
     };
}

window.onload = kategoriSec;
</SCRIPT>
<%
else
response.Write(formolustur(fgtur,1,fid,fovalue))
end if
		fname=""				  
mmmYardimci3.movenext
loop
close(mmmYardimci3)
session("uye_kodu1")="1"
%>
<input name="sifre2" type="hidden" value="1" />
    <div class="form_button">
    
      <input  type="submit"  name="Submit" value="Gönder" class="btn btn-success pull-right">
      
    </div>
                         </form>
           
</div>
</div>
<%call footer(1)%>

<div id="moduladd" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Yükleniyor</h4>
                        </div>

						<div class="modal-body with-padding" style="padding: 0px; margin: 0px; width: 100%;">
							
						</div>

						<div class="modal-footer">
							<button class="btn btn-warning" data-dismiss="modal">Close</button>
							<button class="btn btn-primary">Save</button>
						</div>
					</div>
				</div>
			</div>