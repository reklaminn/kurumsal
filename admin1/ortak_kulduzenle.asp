<!--#Include file="admin_menu1.asp"--> 
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>KULLANICI DÜZENLE</h2>
<div class="clearfix"></div></div>
<table class="table table-striped">
  <tr>
    <td> 
    <td>
      <table class="table table-striped">
        <%
sqlString = "SELECT * from yonetici where id="&request("urunid")&""
set mmmGenel = Con.Execute (sqlString)%>
        <form name="myForm1" method="post" onSubmit="return validate(this);" action="?islem=kulDuzenle">
          <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>">
          <tr>
            <td width="20%">Ad Soyad :</td>
            <td><input name="adsoyad" type="text" id="ad" value="<%=mmmGenel("adsoyad")%>" class="form-control"></td>
          </tr>
          <TR>
            <TD>Email :</TD>
            <TD><input name="email" type="text" id="email" value="<%=mmmGenel("email")%>" class="form-control"/></TD>
          </TR>
          <TR>
            <TD>&nbsp;</TD>
            <TD> <div class="checkbox1"><input name="sifred" type="checkbox" id="sifred" value="1">
              Şifre Değiştirmek 
              İstiyorsanız Yandaki Düğmeye Tıklayın ve Yeni Şifrenizi Yazın.</div></TD>
          </TR>
          <TR>
            <TD>Kullanıcı Adınız:</TD>
            <TD><INPUT type="text" id=art value="<%=mmmGenel("admin")%>" name="admin" class="form-control"></TD>
          </TR>
          <TR>
            <TD>Yeni Kullanıcı Adınız:</TD>
            <TD>
              <INPUT type="text" name="yenkulad" id="kulad"  value="<%=mmmGenel("admin")%>" class="form-control">
            </TD>
          </TR>
          <TR>
            <TD>Eski Şifreniz:</TD>
            <TD><INPUT name=sifre type="password" id="art2" class="form-control"></TD>
          </TR>
          <TR>
            <TD>Yeni Şifreniz:</TD>
            <TD>
              <INPUT name=yensifre type="password" id="art3" class="form-control">
            </TD>
          </TR>
        <%if yetkiuye="1" then%>  <tr>
            <td>Yetki :</td>
            <td><select name="yetki" class="form-control" id="durum">
              <option value="2">Kategori Se&ccedil; </option>
              <%
sqlString = "select * from yetkiler  ORDER BY id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
 if mmmYardimci("id")=1 and yetkiuye<>1 then
 else
%>
              <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=mmmGenel("yetki")  then%>selected<%else%><%end if%>><%=mmmYardimci("yetkiadi")%></option>
              <%end if
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
            </select></td>
          </tr><%else%>
          <input name="yetki" type="hidden" value="2" />
		  <%end if%>
          <tr>
            <td valign="top">Durum :</td>
            <td valign="top"><p>
              <label>
                <input type="radio" name="durum" value="1" class="flatgreen" id="Durum_0" <%if mmmGenel("durum")="1" then%>checked<%else%><%end if%>/>
                Aktif</label>
              <label>
                <input type="radio" name="durum" value="0" class="flatgreen" id="Durum_1" <%if mmmGenel("durum")="0" then%>checked<%else%><%end if%>/>
                Pasif</label>
              <br />
            </p></td>
          </tr>
          <tr>
            <td valign="top">&nbsp;</td>
            <td valign="top"><input type="submit" name="Submit" value="Düzenle" class="btn btn-info pull-right">
            </td>
          </tr>
        </form>
    </table></td>
  </tr>
  <%close(mmmGenel)%>
</table>
</div>
</div>

<%call footer(1)%>