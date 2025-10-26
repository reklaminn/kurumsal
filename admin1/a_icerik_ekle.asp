<!--#Include file="../functions/aspJSON1.17.asp"-->
<!--#Include file="dbb.asp"-->
<div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                        </div>
<%if request.QueryString("dkate2")="" then
else
set mmmGenel = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&request.QueryString("dkate2")&" order by id")
if mmmGenel.eof then
else
dkate2=mmmGenel("id")
sayfa1=mmmGenel("isim")&" / "
sayara=mmmGenel("sayara")
smodula=mmmGenel("smodula")
stura=mmmGenel("stura")
sid=mmmGenel("id")
linked="alt1="&sid&"&"
set mmmYardimci = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmGenel("anasek")&" order by id")
if mmmYardimci.eof then
else
dkate2=mmmYardimci("id")
sayfa2=mmmYardimci("isim")&" / "
sayara2=mmmYardimci("sayara")
smodula2=mmmYardimci("smodula")
stura2=mmmYardimci("stura")
sid2=mmmYardimci("id")
linked=""&linked&"alt2="&sid2&"&"
set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci("anasek")&" order by id")
if mmmYardimci1.eof then
else
dkate2=mmmYardimci1("id")
sayfa3=mmmYardimci1("isim")&" / "
sayara3=mmmYardimci1("sayara")
smodula3=mmmYardimci1("smodula")
stura3=mmmYardimci1("stura")
sid3=mmmYardimci1("id")
linked=""&linked&"alt3="&sid3&"&"
set mmmYardimci2 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci1("anasek")&" order by id")
if mmmYardimci2.eof then
else
dkate2=mmmYardimci2("id")
sayfa4=mmmYardimci2("isim")&" / "
sayara4=mmmYardimci2("sayara")
smodula4=mmmYardimci2("smodula")
stura4=mmmYardimci2("stura")
sid4=mmmYardimci2("id")
linked=""&linked&"alt4="&sid4&"&"
set mmmYardimci3 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci2("anasek")&" order by id")
if mmmYardimci3.eof then
else
dkate2=mmmYardimci3("id")
sayfa5=mmmYardimci3("isim")&" / "
sayara5=mmmYardimci3("sayara")
smodula5=mmmYardimci3("smodula")
stura5=mmmYardimci3("stura")
sid5=mmmYardimci3("id")
linked=""&linked&"alt5="&sid5&"&"
end if
close(mmmYardimci3)
end if
close(mmmYardimci2)
end if
close(mmmYardimci1)
end if
close(mmmYardimci)
end if
close(mmmGenel)
end if
%>

<%Response.Buffer=True %>
<%Server.ScriptTimeout=10000 %>

 <%function duzelt(nesne)  
nesne = Replace(nesne , ".jpg" , "" ) 
nesne = Replace(nesne , ".JPG" , "" ) 
nesne = Replace(nesne , ".GIF" , "" ) 
nesne = Replace(nesne , ".gif" , "" ) 
nesne = Replace(nesne , ".BMP" , "" ) 
nesne = Replace(nesne , ".bmp" , "" ) 
nesne = Replace(nesne , ".PNG" , "" ) 
nesne = Replace(nesne , ".png" , "" ) 
duzelt = nesne 
end function%>
  <% 
  if request("dkate")="" or isNull(request("dkate")) then
  dkate="0"
  else
  dkate=request("dkate")
  end if
  
  if sayara2=1 or sayara3=1 or sayara4=1 or sayara5=1 then
  dkate3=dkate2
  else
  dkate3=dkate
  end if
set mmmGenel = Con.Execute ("select * from kategoriyazi where id="&dkate3&" order by id desc ")
if mmmGenel.eof then
else
katead=""
kateid=""
end if
close(mmmGenel)
if request("modul")="0" then
%> <%
if request("iceriktur")="114" or request("iceriktur")="3" then
path="galeri.asp?modulv=yeni&yazi=yeni&dkate2="&dkate&""
else
path="admin_uruny_duzenle.asp?modulv=yeni&yazi=yeni&dkate2="&dkate&""
end if
%>
 <form action="<%=path%>" method="post" name="form1" target="_parent" id="form1">
<table class="table table-striped">
 

   <input name="kateana" type="hidden" value="<%=dkate2%>">
                        <input name="coklu" type="hidden" value="<%=request("coklu")%>">
                        <input name="iceriktur" type="hidden" value="<%=request("iceriktur")%>">
                        <input name="modul" type="hidden" value="<%=request("modul")%>">
    <tr>
      <td><select name="dkate2" class="form-control" id="dkate">
                     
                    <%
if dkate="0" then
sqlString = "select * from kategoriyazi where durum = '1' ORDER BY id"
else
sqlString = "select * from kategoriyazi where durum = '1' and id="&dkate&" ORDER BY id"
end if
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
                    <option value="<%=mmmGenel("id")%>" <%if mmmGenel("id")=int(dkate) then%>selected<%else%><%end if%> ><%=mmmGenel("isim")%></option>
          <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
                  </select></td>
    </tr>
    <%if request("iceriktur")="8" or request("iceriktur")="9" then%>
    <tr class="icerik1 icerik">
      <td>&Ouml;zellik Formu Ekle
        <select id="formice" size="1" name="formice" class="form-control">
        <option value="0">Özellik Formu Yok</option>
        <%
sqlString = "select * from formlar where dil ='240'  ORDER BY id"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
        <option value="<%=mmmGenel("id")%>"><%=mmmGenel("formadi")%></option>
        <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
      </select> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yeni Alt Kategoriye Ekle
        <input name="yenikategori" type="checkbox" id="yenikategori" value="1"/></td>
    </tr>
     <%else
  end if%>
  <tr>
    <td><input name="icerikturid" type="hidden" id="sira2" value="0" />
<input name="turu" type="hidden" id="sira2" value="90" /><input type="submit" name="button" id="button" value="İ&ccedil;erik Ekle" class="btn btn-success pull-right"/></td>
  </tr>
  
</table>
</form>
<%else%>

<%end if%>