<!--#Include file="admin_menu1.asp"--> 
<div class="right_col" role="main">
<div class="x_panel">
 <%
	if request("dkate2")="" or request("dkate2")=0 then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
	if request("ara1")="" or request("ara1")=0 then
	ara1=0
	else
	ara1=request("ara1")
	end if
%>
  <form method="post" name=Form1 id=Form1 action="?usayi=<%=request("usayi")%>&islem=kulekle&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&git=<%=request("git")%>" target="_self">
      <table class="table table-striped">
  <thead>
  <tr>
    <th>Ad&#305; Soyadı</th>
    <th>Yetki</th>
    <th>Admin</th>
    <th>Şifre</th>
    <th>Email</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    </tr>
  </thead>
  <tr class="icerik1 icerik">
    <td height="50"><input name="adsoyad" type="text" id="adsoyad" class="form-control"/></td>
    <td><select name="yetki" class="form-control" id="yetki">
      <option value="2">Yetki Se&ccedil; </option>
      <%
sqlString = "select * from yetkiler  ORDER BY id"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
 if mmmGenel("id")=1 and uyeyetki<>1 then
 else
%>
      <option value="<%=mmmGenel("id")%>"><%=mmmGenel("yetkiadi")%></option>
      <%end if
mmmGenel.movenext
loop
close(mmmGenel)
%>
    </select></td>
    <td><input name="admin" type="text" id="admin" class="form-control"/></td>
    <td><input name="sifre" type="password" id="sifre" class="form-control"/></td>
    <td><input name="email" type="text" id="email" class="form-control"/></td>
    <td><input name="Submit2" type="submit" id="Submit" value="Ekle" class="btn btn-success pull-right"/></td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
          </table>

  </form>
    
    <form method="post" Name="custlist" id=Form1 action="?usayi=<%=request("usayi")%>&islem=kap&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&git=<%=request("git")%>">
    <table class="table table-striped">
  <thead> 
  <tr>
    <th height="40">Ad&#305; Soyadı</th>
    <th>Yetki</th>
    <th>Admin</th>
    <th>En Son Giriş Zamanı ve İpsi</th>
    <th>&nbsp;</th>
    <th>En Son İşlem Zamanı ve İpsi</th>
    <th width="4%" align="center">Durumu</th>
    <th width="3%" align="center">Değiştir</th>
    <th width="3%" align="center">Sil</th>
    </tr>
  </thead>
  <%
if uyeyetki=1 then
sqlString = "select * from yonetici order by yetki desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
else
sqlString = "select * from yonetici where yetki <> 1 order by id desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
 %>  
    <%
Do While Not mmmGenel.EOF
 iks=iks+1%><input name="urunid" type="hidden" value="<%=mmmGenel("id")%>">
    <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
                        <%collor="1"%>
                        <%else%>
                        <%collor="2"%>
<%end if%>
    <TR class="icerik<%=collor%> icerik">
      <td><input name="adsoyad" type="text" id="adsoyad" value="<%=mmmGenel("adsoyad")%>" class="form-control"></td>
      <td><select name="yetki" class="form-control" id="durum">
        <option value="2">Kategori Se&ccedil; </option>
        <%
sqlString = "select * from yetkiler  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
 if mmmYardimci("id")=1 and uyeyetki<>1 then
 else
%>
        <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=mmmGenel("yetki")  then%>selected<%else%><%end if%>><%=mmmYardimci("yetkiadi")%></option>
        <%end if
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
      </select></td>
      <td><input name="admin" type="text" id="admin" value="<%=mmmGenel("admin")%>" class="form-control"/></td>
      <td align="center"><%=mmmGenel("ensonislem")%><br />
        <%=mmmGenel("ipson")%><td>
          <input name="email" type="text" id="email" value="<%=mmmGenel("email")%>" class="form-control"/></td>
      <td align="center">
        <%=mmmGenel("sayfa")%></td>
      <td align="center">
      <%if mmmGenel("durum") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("durum","Onay",iks,cbcdisstr,cbccheckstr,"info"))%>
         
      </td>
      <td align="center"><a href="ortak_kulduzenle.asp?urunid=<%=mmmGenel("id")%>" class="btn btn-info pull-right" style="color:#FFF;">Değiştir</a></td>
                          <td align="center">
                          <div class="checkbox">
        <input name="urunidsil" type="checkbox" class="flatred" id="urunidsil<%=iks%>" value="<%=mmmGenel("id")%>" />
      </div>
         
         </td>
    </tr>

    <%mmmGenel.MoveNext
  loop
%>
    <tr> 
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td align="center"><input name="Submit3" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&git=<%=request("git")%>&Submit=kulDuzenle');"/></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&git=<%=request("git")%>&Submit=kulSil');"></td>
    </tr><% close(mmmGenel)
end if
%>
<SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
</table>
  </form>
</div>
</div>

<%call footer(1)%>