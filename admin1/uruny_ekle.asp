<!--#Include File="admin_menu1.asp"-->

<%
dim so(14),sou(14),sl(14),slu(14)
formid=request("formice")%>
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>İçerik Ekle&nbsp;</h2> 
               <div class="clearfix"></div></div>
             <FORM name="myForm" action="?id=<%=Request("dkate2")%>&baslik=<%=Request("dkate2")%>&sek=1&islem=icerikekle&dkate2=<%=Request("dkate2")%>&tur=<%=Request("iceriktur")%>&modulv=<%=Request("modulv")%>&yer=<%=Request("sayfayeri")%>" method="post"> 
              <table class="table table-striped">
              <TR>
                <TD>
                <table class="table table-striped">
                      <TBODY>
                      <input name="coklu" type="hidden" value="<%=request("coklu")%>">
                        <%if request.QueryString("res")=1 then%>
                        <input type="hidden" name="sayi" value="<%=Request.QueryString("sayi")%>">
                        <%else%>
                        <input type="hidden" name="sayi" value="<%=Sayilar%>">
                        <input type="hidden" name="res" value="1">
                        <%end if%>
                        <input type="hidden" name="sayi1" value="<% = Request.QueryString("sayi1")%>">
                        <input type="hidden" name="sayi2" value="<% = Request.QueryString("sayi2")%>">
                        <input name="modul" type="hidden" value="<%=request("modul")%>">
                        <input name="goster" type="hidden" value="2">
                        <input name="kategoriyeni" type="hidden" value="<%=request("kategoriyeni")%>">

                        <TR>
                          <TD></TD>
                          <TD><input type="submit" value="Ekle" name="submit" class="btn btn-success pull-right" /></TD>
                        </TR>
                        <TR> 
                          <TD width="20%" rowspan="2">Başlık :</TD>
                          <TD> <INPUT type="text" size="25" name="urun" class="form-control" value="<%=request.querystring("titlee") %>"></TD>
                  </TR>
                        <TR>
                          <TD><div class="col-md-2"><label><input name="harici" type="checkbox" id="harici"  value="1" onclick="javascript:toggleDiv('block', this.checked);" />
                Harici Linke Git</label></div>
                <div id="block" class="col-md-10" style="display: none;">
                <div class="col-md-8">
                  <input name="link" type="text" size="25" class="form-control" />
                  </div>
                  <div class="col-md-4">
                  <select id="target" size="1" name="target" class="form-control">
                    <option value="0">Sayfa Açılma</option>
                    <option value="_blank">Boş Sayfada Aç</option>
                    <option value="_parent">Kendi İçinde Aç</option>
                  </select>
                  </div>
                </div></TD>
                        </TR>
<script language="javascript">
function toggleDiv(id, show)
{
   document.getElementById(id).style.display = show ? 'block' : 'none';
   document.getElementById(id).style.display = show ? 'block1' : 'none';
}
</script>
                        <%
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
          <%if bilgi1=1 or request("iceriktur")="112"  then%> <TR>
            <TD><%=bilgi1i%> :</TD>
            <TD><textarea name="bilgi1" cols="25" id="bilgi1" class="form-control"></textarea></TD>
          </TR>
          <%else%><%end if%>
          <%if bilgi2=1 or request("iceriktur")="112" or request("iceriktur")="11" then%>
          <TR>
            <TD><%if request("iceriktur")="11" then%>Koordinat<%else%><%=bilgi2i%><%end if%> :</TD>
            <TD><INPUT type="text" name="bilgi2" id="bilgi2"  value="" size="25" class="form-control"></TD>
          </TR>
          <%else%><%end if%>
          <%' or request("iceriktur")="4"
		  if bilgi3=1 or request("iceriktur")="14" or request("iceriktur")="11" then%>
          <TR>
            <TD><%if request("iceriktur")="11" then%>Adres<%elseif request("iceriktur")="8" or request("iceriktur")="4" then%>Fiyatı<%else%><%=bilgi3i%><%end if%> :</TD>
            <TD><INPUT type="text" name="bilgi3" id="bilgi3"  value="" size="25" class="form-control"></TD>
          </TR>
          <%else%><%end if%>
          <%if bilgi4=1 then%>
          <TR>
            <TD><%=bilgi4i%> :</TD>
            <TD><INPUT type="text" name="bilgi4" id="bilgi4"  value="" size="25" class="form-control"></TD>
          </TR>
          <%else%><%end if%>
                        
					<%if formid="1" or formid="" then
					else%>
                        <TR>
                          <TD colspan="2">
                          <table class="table table-striped">

 <SCRIPT LANGUAGE=JavaScript>
<!--
/*
Script validates form field entries
Only the first three ones are checked
If you need the others to be checked, just follow the same code examples
(change field name and number of characters if needed
*/
function validate(theForm){
                        <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' and gerekli = '1' order by sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
  <%else
  for ya = 0 to 100
if mmmGenel.eof then exit for
if emailvarmi="1" then%>
	if (theForm.<%=mmmGenel("name")%>.value.indexOf('@',1)== -1 || theForm.<%=mmmGenel("name")%>.value.indexOf('.',2)==-1){
		alert("<%=mmmGenel("isim")%> Doğru Doldurunuz.");
		theForm.<%=mmmGenel("name")%>.focus();
		return false;
	}
	<%else%>
	if (theForm.<%=mmmGenel("name")%>.value == "" || theForm.<%=mmmGenel("name")%>.value.length < 1){
		alert("<%=mmmGenel("isim")%> Doldurunuz.");
		theForm.<%=mmmGenel("name")%>.focus();
		return false;
	}
	<%end if
	mmmGenel.movenext
Next
end if
close(mmmGenel)%>

return true;
}
//-->
</SCRIPT>
					  <tr>
                        <td colspan="2" class="baslik_onay"><%if islemler="ekle" then%>
                          <div align="center"><%=gmesaj %></div>
                          <%else%>
                         
                          <%end if%>
                        </td>
                      </tr>
                      <input name="formice" type="hidden" value="<%=formid%>" />
                      <input name="formekle" type="hidden" value="ekle" />
                  
                        <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira"
set mmmGenel = Con.Execute (sqlString) 
if mmmGenel.eof then%>
  <%else
  for iks = 0 to 100
if mmmGenel.eof then exit for
formname=mmmGenel("name")
if session("yonet_dil")=240 then
formisim=mmmGenel("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmGenel("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
formisim="-"
else
formisim=mmmYardimci("isim")
end if
close(mmmYardimci)
end if%>
<%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
                        <%collor="1"%>
                        <%else%>
                        <%collor="2"%>
<%end if%>
                      <tr class="icerik<%=collor%> icerik">
                        <td width="30%" align="right" class="data"><%=formisim%> :</td>
                        <td width="63%"><%if mmmGenel("tur")=1 then%>
                        <input type="text" id="<%=formname%>" name="<%=formname%>" class="form-control"/>
                        <%elseif mmmGenel("tur")=2 then%>
                        <input name="<%=formname%>" type="hidden" value="<%=formname%>" class="form-control"/>
                        <%elseif mmmGenel("tur")=3 then%>
                        <textarea name="<%=formname%>" rows="6" id="<%=formname%>"  class="normal form-control"></textarea>
                         <%elseif mmmGenel("tur")=4 then%>
                        
                                 <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmGenel("id")&"' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then%>
  <%else
  for t = 0 to 100
if mmmYardimci.eof then exit for
if session("yonet_dil")=240 then
formisim=mmmYardimci("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmYardimci("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
formisim="-"
else
formisim=mmmYardimci1("isim")
end if
close(mmmYardimci1)
end if
%><div style="width:49%; float:left;"><input name="<%=formname%>" type="checkbox" value="<%=formisim%>" /><%=formisim%>&nbsp;&nbsp;</div>
                       
                              <%
mmmYardimci.movenext
Next
end if
close(mmmYardimci)
%>
<%elseif mmmGenel("tur")=5 then%>
                        
                                 <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmGenel("id")&"' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then%>
  <%else
  for p = 0 to 100
if mmmYardimci.eof then exit for
if session("yonet_dil")=240 then
formisim=mmmYardimci("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmYardimci("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
formisim="-"
else
formisim=mmmYardimci1("isim")
end if
close(mmmYardimci1)
end if%><input name="<%=formname%>" type="radio" value="<%=formisim%>" /><%=formisim%>&nbsp;&nbsp;
                       
                              <%
							  
mmmYardimci.movenext
Next
end if
close(mmmYardimci)
%>
              
                        <%elseif mmmGenel("tur")=6 then
						if mmmGenel("id")="94" then%>
                        <div id="sonuc"></div>
                        <%else%>
                        <SELECT id=select4 size=1 class="form-control" name=<%=formname%>>
                                 <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&mmmGenel("id")&"' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then%>
  <%else
  for s = 0 to 100
if mmmYardimci.eof then exit for
if session("yonet_dil")=240 then
formisim=mmmYardimci("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmYardimci("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
formisim="-"
else
formisim=mmmYardimci1("isim")
end if
close(mmmYardimci1)
end if%>
                          <OPTION value="<%=mmmYardimci("name")%>" ><%=formisim%></OPTION>
                              <%
mmmYardimci.movenext
Next
end if
close(mmmYardimci)
%>
               </SELECT>
               <%end if%>
                <%elseif mmmGenel("tur")=7 then%>
               İçerik Girildikten Sonra Resim Ekleyebilirsiniz.
                       <%else%>
								  <select id="Select12" size="1" onchange="return kategoriSec()" class="form-control" name=<%=formname%>>
                                    <%
 sqlString = "select * from kategoriyazi where anasek='"&mmmGenel("tur")&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then%>
                                    <%else
  for s = 0 to 100
if mmmYardimci1.eof then exit for
if session("yonet_dil")=240 then
formisim=mmmYardimci1("isim")
else
sqlString = "select * from ozellikler where bagli="&mmmYardimci1("id")&" and dil='"&session("yonet_dil")&"'"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
formisim="-"
else
formisim=mmmYardimci2("isim")
end if
close(mmmYardimci2)
end if
%>
                                    <option value="<%=mmmYardimci1("id")%>" <%if  int(mmmYardimci1("id"))=int(request("dkate2")) then%>selected<%else%><%end if%> ><%=formisim%></option>
                                    <%
mmmYardimci1.movenext
Next
end if
close(mmmYardimci1)
%>
                                  </select>

					   <%
					   end if%>
                        </td>
                      </tr>
                           <%
						  
mmmGenel.movenext
Next
end if
close(mmmGenel)
%>  
                  </table></TD>
                        </TR>
                        <%end if%>
                           <%if request("iceriktur")=5 then%>
                        <TR>
                          <TD>Youtube Vide Linki :</TD>
                          <TD colSpan=3><INPUT type="text" name="form" id="form"  value="" class="form-control"></TD>
                        </TR>   <%else%><%end if%>
                        <%if request("iceriktur")=7 then%>
                        <TR>
                          <TD>Form Se&ccedil; :</TD>
                          <TD><SELECT id="form" size="1" name="form" class="form-control">
                            <%
sqlString = "select * from formlar  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
%>
                            <%
for a = 0 to 100
if mmmYardimci.eof then exit for
%>
                            <OPTION value="<%=mmmYardimci("id")%>"><%=mmmYardimci("formadi")%></OPTION>
                            <%
mmmYardimci.movenext
Next
close(mmmYardimci)
%>
                          </SELECT></TD>
                        </TR>   <%else%><%end if%>
                         <%if request("dkate2")="" then%>
                        <TR> 
                          <TD width="30%">Kategori 
                            :</TD>
                          <TD> <SELECT size="1" name="kategori" class="form-control">
                              <%
sqlString = "select * from kategoriyazi where alt = '1' ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
for i = 0 to 100
if mmmYardimci.eof then exit for
%>
                              <OPTION value=<%=mmmYardimci("id")%>><%=mmmYardimci("isim")%></OPTION>
                              <%
sqlString = "select * from kategoriyazi where anasek='"&mmmYardimci("id")&"' ORDER BY isim"
set mmmYardimci1 = Con.Execute (sqlString)
for a = 0 to 100
if mmmYardimci1.eof then exit for
%>
                <OPTION value="<%=mmmYardimci1("id")%>">&nbsp;&nbsp;><%=mmmYardimci1("isim")%></OPTION>
                <%
mmmYardimci1.movenext
Next
close(mmmYardimci1)
mmmYardimci.movenext
Next
close(mmmYardimci)
%>
                            </SELECT><a href="kategori.asp" target="_self">Yeni Kategori Ekle</a></TD>
                        </TR><input name="urunid" type="hidden" value="<%=request("iceriktur")%>">
                        <%else%>
                        <input name="kateana" type="hidden" value="<%=request("kateana")%>">
                        <input name="kategoria" type="hidden" value="<%=request("dkate2")%>">
                        <input name="urunid" type="hidden" value="<%=request("iceriktur")%>">
                        <%end if
if request("modul")="1" then
else
%>
                        
                  <script language="javascript">

function disable_ilksayfa1(checked)
{
	
document.getElementById("ilksayfa1").disabled = checked;
}
</script>
            <tr>
              <td colspan="2"><label>
              <input name="ozeltemp" type="hidden" value="0" id="ilksayfa1">
  <INPUT name="ozeltemp" type=checkbox id="ilksayfaa1" value="1" onClick="disable_ilksayfa1(this.checked);toggleDiv('accordion', this.checked);">Özel Temp Oluştur</label>
  <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true" style="display:none;">
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
              </div></TD>
                  </TR>
                        <%end if%>
                        <TR> 
                          <TD colspan="2">
                          <textarea name="myTextarea" id="myTextarea" style="width:100%;" class="normal form-control"></textarea></TD>
                        </TR>
                        <TR>
                          <TD>&nbsp;</TD>
                          <TD><input type="submit" value="Ekle" name="submit" class="btn btn-success pull-right" /></TD>
                        </TR>
          
                      
                </TABLE>
                
                </td>
                  </tr>
                 
       </table>
</FORM>
                </div>
</div>
<%call footer(1)%>
