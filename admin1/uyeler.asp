<!--#Include file="admin_menu1.asp"-->
        <div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>&Uuml;yeler</h2>
               <div class="clearfix"></div></div>
  <form action="?islem=uyeekle" method="post">
  <table class="table table-striped"> 
  <tr class="icerik1 icerik">
    <td>Yeni Kayıt Ekle</td>
    <td><input type="text" name="adsoyad" id="adsoyad" class="form-control"></td>
    <td><input type="text" name="sehir" id="sehir" class="form-control"></td>
    <td><input type="text" name="email" id="email" class="form-control"></td>
    <td><input type="password" name="sifre" id="sifre" class="form-control"></td>
    <td><input type="submit" name="button" id="button" value="Ekle" class="btn btn-success pull-right" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  
  </table></form>
  <table class="table table-striped">
  <thead>
   <tr> 
    <th>Üye Kodu</th>
    <th>Adı Soyadı</th>
    <th>Şehiri</th>
    <th>E-mail Adresi</th>
    <th>Şifre</th>
    <th>Kayıt Tarihi</th>
    <th>En Son Giriş Tarihi</th>
    <th align="center">Sil</th>
  </tr>
  </thead>
  <%
sqlString = "select * from uyeler order by tarih desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
  <tr> 
    <td>&Uuml;ye Kayd&#305; Yok</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%else
  Do While Not mmmGenel.EOF
iy=i+1
%>
  <%if right(iy,1)=1 or right(iy,1)=3 or right(iy,1)=5 or right(iy,1)=7 or right(iy,1)=9 then%>
                         <%collor="1"%>
                        <%else%>
                        <%collor="2"%>
<%end if%>
    <TR class="icerik<%=collor%> icerik"> 
    <td><%=mmmGenel("yid")%></td>
    <td><%=mmmGenel("ad")%></td>
    <td><%=mmmGenel("il")%> </td>
    <td>  <%=mmmGenel("email")%></td>
    <td>&nbsp;</td>
    <td><%=mmmGenel("tarih")%></td>
    <td><%=mmmGenel("son_tarih")%></td>
    <td><a href="uyeler.asp?islem=uyesil&id=<%=mmmGenel("yid")%>" class="btn btn-danger pull-right" style="color:#FFF;">Sil</a></td>
  </tr>
  <%mmmGenel.MoveNext
  loop
  end if
  %>

</table>
<% 

Close(mmmGenel)
%>
</div>
</div>
<%call footer(1)%>