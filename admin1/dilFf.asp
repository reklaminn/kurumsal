<!--#Include file="admin_menu1.asp"-->
<%
if request("sek2")="" or request("sek2")=0 then
	sek2=0
	else
	sek2=request("sek2")
	end if
	if request("sek")="" or request("sek")=0 then
	sek=0
	else
	sek=request("sek")
	end if
        if request("sek")="" then
else
    set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&request("sek")&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)
end if
%>
<%response.Write(setchar(Request("sek"),"0"))%>
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>FORM DİL DÜZENLE</h2>
<div class="clearfix"></div></div>
<table class="table table-striped">
      <form  action="?filtre=1" method="post" name="form1" id="form2">
         <tr>
           <td>FORM</td>
           <td>
             <select name="sek2" class="form-control">
               <option value="1" selected="selected"> Kendi </option>
               <%
sqlString = "select * from formlar where dil = '240'  ORDER BY id"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <OPTION value="<%=mmmGenel("id")%>"  <% if mmmGenel("id")=int(sek2) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("formadi")%></OPTION>
     
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
             </select>
           </td>
           <td>&nbsp;</td>
         </tr>
         <tr class="baslik">
          <td width="13%">DİL FİLTRESİ</td>
          <td width="81%">
            <select name="sek" class="form-control">
              <option value="1" selected="selected"> Kendi </option>
              <%
sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>"  <% if mmmGenel("id")=int(sek) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
            </select>
          </td>
          <td width="6%"><input name="Submit2" type="submit" id="Submit" value="Filtrele" class="btn btn-info pull-right"/></td>
        </tr>

      </form>
    </table>
    <table class="table table-striped">
          <thead>
            <th width="2%">id</th>
            <th width="17%">Türkçesi</th>
            <th width="29%">Form Adı Çevirisi</th>
            <th width="44%">Form Onay Mesajı Çevirisi</th>
            <th width="8%">Form Nesneleri Dil Düzenlemesi</th>
            </thead>
          <%
sqlString = "select * from formlar where dil ='240' and id="&sek2&" order by bagli"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
          <tr>
            <td colspan="5">Ürün Kaydi Yok</td>
            </tr>
          <%else%>
          <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=duzenledillerform&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>&amp;sek2=<%=request("sek2")%>" target="_self">
              <input name="charcode" type="hidden" id="charcode" value="<%=ceviridileki%>" />
            <%Do While Not mmmGenel.EOF
iok=iok+1
if request("sek")=240 then
sqlString = "select * from formlar where dil='"&request("sek")&"' and id="&mmmGenel("id")&" ORDER BY bagli"
else
sqlString = "select * from formlar where dil='"&request("sek")&"' and bagli="&mmmGenel("id")&" ORDER BY bagli"
end if
set mmmYardimci = Con.Execute (sqlString)
%>
            <input name="haberid" type="hidden" id="haberid" value="<% if mmmYardimci.eof then%>0<%else%><%=mmmYardimci("id")%><%end if%>" />

    <TR> 
              <td><%=iok%></td>
              <td>
              <%
              sqlString = "select * from formlar where dil='240' and id="&mmmGenel("id")&" "
set mmmYardimci1= Con.Execute (sqlString)
if mmmYardimci1.eof then
else
ceviri=mmmYardimci1("formadi")
cevirig=mmmYardimci1("gmesaj")
%><input name="durum2" type="hidden" value="<%=mmmYardimci1("id")%>" />
          <input type="text" name="durum21" id="durum21" value="<%=ceviri%>" class="form-control" />
              <%
			  
end if
close(mmmYardimci1)
if mmmYardimci.eof then
cevvirim=yandexdilcek(ceviridil,ceviri)
cevvirimg=yandexdilcek(ceviridil,cevirig)
else
if ceviri="-" and mmmYardimci("dil")<>"240" then
cevvirim=yandexdilcek(ceviridil,ceviri)
cevvirimg=yandexdilcek(ceviridil,cevirig)
else
cevvirim=mmmYardimci("formadi")
cevvirimg=mmmYardimci("gmesaj")
end if
end if
%>
</td>
              <td>
                <input type="text" name="haberb" id="haberb" value="<%=cevvirim%>" class="form-control"/>
              </td>
              <td><input type="text" name="haberb2" id="haberb2" value="<%=cevvirimg%>" class="form-control"/></td>
              <td><a href="dilf.asp?sek=<%=request("sek")%>&amp;sek2=<%=request("sek2")%>" class="btn btn-info pull-right">Form Nesneleri</a></td>
              <input name="sira1" type="hidden" value="<%=mmmGenel("sira")%>" />
              </tr>
            <%close(mmmYardimci)
			  mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)
  %>
            <tr>
              <td colspan="2"></td>
              <td colspan="3" align="right"><b>
                <input name="Submit" type="submit" id="Submit5" value="Duzenle" class="btn btn-info pull-right" />
              </b></td>
              </tr>
          </form>
        </table>
        
</div>
</div>
<%response.Write(setchar(Request("sek"),"0"))%>
<%call footer(1)%>