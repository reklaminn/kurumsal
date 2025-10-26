<!--#Include file="admin_menu1.asp"-->
<!-- page content -->
        <div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>Form Giriş T&uuml;rü Ekle</h2>
               <div class="clearfix"></div></div>
  <table class="table table-striped">
  <form name="form1" method="post"  action="?islem=formgekle">
  <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>
	    <thead> 
      <th >Giriş Türü Adı</th>
    </thead>
    <tr> 
      <td><input name="sektor" type="text" id="sektor" class="form-control"></td>
    </tr>
    <tr> 
      <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"></td>
    </tr>
  </form>
</table>
</div>
<div class="x_panel">
               <div class="x_title"><h2>Form Giriş T&uuml;rleri</h2>
               <div class="clearfix"></div></div>
  <table class="table table-striped">
  <%
 sqlString = "select * from ozellikler1  order by id desc"
set mmmGenel = Con1.Execute (sqlString)
if mmmGenel.eof then
else%>
  <thead>
    <th height="40">Listeleme Adı</th>
    <th width="1%">&nbsp;</th>
    <th width="3%" align="center">Sil</th>
  </thead>
  <form method="post"  Name="custlist" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">

    <%
Do While Not mmmGenel.EOF
iks=iks+1
%>
    <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>" />
     <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>

    <TR> 
      <td><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("isim")%>" class="form-control"/></td>
      <td>&nbsp;</td>
      <td><input name="urunidsil" type="checkbox" id="sira2" value="<%=mmmGenel("id")%>" /></td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
    <tr>
      <td></td>
      <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formgDuzenle');"></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formgSil');"></td>
    </tr>
  </form>
  <% 
end if
close(mmmGenel)
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
</div>
</div>
<%call footer(1)%>