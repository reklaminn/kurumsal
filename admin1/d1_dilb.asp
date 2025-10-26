<%if request("dilresim")="" then%>
<%else%>
<!--#Include file="dbb.asp"-->
<%response.Write(setchar(Request("sek"),"0"))%>
<table class="table table-striped">
  <form action="?islem=dilduzenle1&dilresim1=1&sek=<%=request.QueryString("sek")%>" method="post" enctype="multipart/form-data"  name="form">
    <input name="yazarid" type="hidden" value="<%=request.QueryString("yazarid")%>">
    <thead>
    <th colspan="3">Resim EKLE</th>
    </thead>
    
    <tr>
      <td colspan="2"><div align="center"><strong>Dosya</strong></div></td>
      <td valign="top"><input type="file" name="file"></td>
    </tr>
    <tr>
      <td height="15" colspan="2"></td>
      <td width="289"></td>
    </tr>
    <tr>
      <td width="14" height="23"></td>
      <td width="87"></td>
      <td valign="top"><input type="submit" name="Submit" value="Ekle" ></td>
    </tr>
    <tr>
      <td height="17"></td>
      <td></td>
      <td></td>
    </tr>
  </form>
</table>
<%
	response.end
	end if
	%>

<!--#Include file="admin_menu1.asp"-->

<%
    dilsek=giriskont(request("sek"))
    if dilsek="" or isNull(dilsek) then
    dilsek=request.cookies("remember_dil")
    end if
    response.Write(setchar(Request("sek"),"0"))%>
<div class="right_col" role="main">
  <div class="x_panel">
      <%if yetkiuye="1" then %>
    <div class="x_title">
      <h2>DİL EKLE</h2>
      <div class="clearfix"></div>
    </div>
      <form  action="?islem=dillerekle" method="post" name="form1" id="form1">
     <table class="table table-striped">
        <tr>
          <td width="13%">DİL ADI
            <input name="durum4" type="hidden" id="durum7" value="1" />
            <input name="durum5" type="hidden" id="durum6" value="0" /></td>
          <td><div class="col-md-3">
              <select name="sek" id="sek" class="form-control">
                <option value="1" selected="selected"> Kendi </option>
                <%
sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
                <option value="<%=mmmGenel("id")%>"  <% if mmmGenel("id")=int(request("sek")) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
                <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
              </select>
            </div>
            <div class="col-md-9">
              <input name="sektor2" type="text" id="sektor2" class="form-control" />
            </div></td>
          <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right" style="float:left !important;" /></td>
        </tr>
    </table>
      </form>
      <%end if%>
    <form  action="?filtre=1" method="post" name="form1" id="form2">
      <table class="table table-striped">
        <thead>
        <th width="13%">DİL SEÇ</th>
          <th width="81%"><div class="row">
                  <span class="col-md-6"> <select name="sek" id="durum5" class="form-control">
              <option value="1" selected="selected"> Kendi </option>
              <%
sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>"  <% if mmmGenel("id")=int(request("sek")) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
            </select>
                      </span>
                      <span class="col-md-6">
            <select name="yeri" class="form-control" id="yeri">
              <option value="9999"> Tümü </option>            
              <option value="site" selected="selected"> Site </option>            
              <option value="panel" > Panel </option>            
            </select>
                          </span>
                          </div>
          </th>
          <th width="6%"><input name="Submit2" type="submit" id="Submit" value="Filtrele" class="btn btn-info pull-right"/></th>
          </thead>
      </table>
    </form>
    <div class="x_title">
      <h2>DİL D&Uuml;ZENLE</h2>
      <div class="clearfix"></div>
    </div>
    <table class="table table-striped">
      <%
sqlString = "select * from diller1 where id ="&int(request("sek"))&" ORDER BY kate"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
strdilkate=mmmGenel("kate")
strdilid=mmmGenel("id")
strdilnot=mmmGenel("nott")
strdilsira=mmmGenel("sira")
strceviricode=mmmGenel("ceviricode")
          ceviridil=ceviridilek&"-"&strceviricode
sqlString = "select * from diller1 where kate ='"&request("sek")&"' ORDER BY kate"
set mmmYardimci = Con.Execute (sqlString)
%>
      <tr>
        <td width="1%" height="40">&nbsp;</td>
        <td><form name="form1" method="post"  action="?islem=dillerduzenle&sek=<%=request("sek")%>&yeri=<%=request("yeri")%>">
            <div class="col-md-1"><%=strdilkate%></div>
            <div class="col-md-1">
              <%if strdilnot="1" then%>
              Aktif Dil
              <%else%>
              <a href="?islem=dilleraktif&amp;id=<%=strdilid%>&amp;sek=<%=request("sek")%>&yeri=<%=request("yeri")%>&yazarid=<%=strdilid%>">Aktif Dil Yap</a>
              <%end if%>
            </div>
            <div class="col-md-6">
              <input name="sektor" type="text" id="sektor" value="<%=strdilkate%>" class="form-control" />
            </div>
            <div class="col-md-1">
              <input name="charset" type="text" id="charset" value="<%=strceviricode%>" class="form-control" />
                </div>
            <div class="col-md-1">
              <input name="id" type="hidden"  value="<%=strdilid%>" size="40" />
              <input name="durum" type="hidden" id="durum" value="1" />
              <input name="durum2" type="hidden" id="durum" value="<%=strdilid%>" />
              <%if strdilsira = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("buton","Aktiflik Durumu",iok,cbcdisstr,cbccheckstr,"info"))%>
              
            </div>
            <div class="col-md-1">
              <input name="submit" type="submit" id="submit" value="Güncelle" class="btn btn-info pull-right"/>
            </div>
            <div class="col-md-1">
              <%if mmmYardimci.eof then%>
              <a href="?islem=dillersilu&amp;id=<%=mmmGenel("id")%>&amp;sek=<%=request("sek")%>&yeri=<%=request("yeri")%>" onClick="return confirm('Silmek İçin Eminmisiniz.')" class="btn btn-danger pull-right">Sil</a>
              <%else%>
              <%end if%>
            </div>
            <%close(mmmYardimci)%>
          </form></td>
      </tr>
      <%end if
			close(mmmGenel)%>
    </table>
      <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=duzenlediller&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>&yeri=<%=request("yeri")%>" target="_self">
    <table class="table table-striped">
      <thead>
        <th width="20%">T&uuml;rk&ccedil;esi</th>
        <th>Çevirisi</th>
        <th width="20%">Kodu</th>
        <th width="5%">Sil</th>
		<%
		if request("yeri")="9999" then
		yeri=""  
              yerqry=""
		elseif request("yeri")="panel" then
		yeri=" and ayri ='sa'"
              yerqry="&yeri=panel"
              else
              yeri=" and ayri <>'sa'"
              yerqry="&yeri=site"
		end if
sqlString = "select * from diller1 where anasek ='240'"&yeri&" order by bagli"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
      <tr>
        <td colspan="2">Ürün Kaydi Yok</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <%else%>

        <%Do While Not mmmGenel.EOF
iok=iok+1
                            dilmgid=mmmGenel("id")
                dilmgkate=mmmGenel("kate")
                dilmgsira1=mmmGenel("sira1")
if dilsek=240 then
sqlString = "select * from diller1 where anasek='"&dilsek&"' and id="&dilmgid&" ORDER BY bagli"
else
sqlString = "select * from diller1 where anasek='"&dilsek&"' and bagli="&dilmgid&" ORDER BY bagli"
end if
set mmmYardimci = Con.Execute (sqlString)
                if mmmYardimci.eof then
                dilmyid="0"
                dilmybtn="-"

                kaynagim="https://translate.yandex.net/api/v1.5/tr/translate?key=trnsl.1.1.20151001T063527Z.be49267a974872fb.46bcc8321da7ffaba54cf63973101f1d3de896d8&lang="&ceviridil&"&text="&dilmgkate&""
'kaynak = VeriAL(kaynagim) 
if instr(kaynak,"<text>")=0 then
else
sayfa2=split(kaynak,"<text>")
sayfa2a=split(sayfa2(1),"</text>")
cevvirim=sayfa2a(0)
end if

                else
                dilmyid=mmmYardimci("id")
                dilmykate=mmmYardimci("kate")
                dilmyanasek=mmmYardimci("anasek")
                dilmybtn="<a href=""?islem=tursdilbsil&amp;id="&dilmyid&"&amp;sek="&dilsek&""" class=""btn btn-danger"" style=""color:#fff;"">Sil</a>"
                if dilmykate="-" and dilmyanasek<>"240" then
kaynagim="https://translate.yandex.net/api/v1.5/tr/translate?key=trnsl.1.1.20151001T063527Z.be49267a974872fb.46bcc8321da7ffaba54cf63973101f1d3de896d8&lang="&ceviridil&"&text="&dilmykate&""
'kaynak = VeriAL(kaynagim) 
if instr(kaynak,"<text>")=0 then
else
sayfa2=split(kaynak,"<text>")
sayfa2a=split(sayfa2(1),"</text>")
cevvirim=sayfa2a(0)
end if
else
cevvirim=dilmykate
end if
                end if
                close(mmmYardimci)

%>
         <input name="haberid" type="hidden" id="haberid" value="<%=dilmyid%>" />
        <%if right(iok,1)=1 or right(iok,1)=3 or right(iok,1)=5 or right(iok,1)=7 or right(iok,1)=9 then%>
        <%collor="1"%>
        <%else%>
        <%collor="2"%>
        <%end if%>
        <TR class="icerik<%=collor%> icerik">
          <td> 
                  <input name="durum" type="hidden" value="<%=dilmgid%>" />
                <input type="text" name="durum21" id="durum21" value="<%=dilmgkate%>" class="form-control" />
</td>
              <td><input type="text" name="haberb" id="haberb" value="<%=cevvirim%>" class="form-control"/></td>
              <td><%if dilsek=240 then%>
                <input type="text" name="sira1" id="sira" value="<%=dilmgsira1%>" class="form-control"/>
                <%else%>
                <input name="sira1" type="hidden" value="<%=dilmgsira1%>" />
                <%end if%></td>
              <td align="center">
                <%=dilmybtn%>
              </td>
        </tr>
        <%
			  mmmGenel.MoveNext
  loop
  %>
        <tr>
          <td colspan="2"></td>
          <td>&nbsp;</td>
          <td align="center"><input name="Submit3" type="submit" id="Submit5" value="Duzenle" class="btn btn-info pull-right"/></td>
        </tr>
      <%
end if
close(mmmGenel)
%>
    </table>
      </form>
<%response.Write(setchar(Request("sek"),"0"))%>
  </div>
</div>
<%call footer(1)%>
