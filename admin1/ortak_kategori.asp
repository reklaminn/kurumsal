<!--#Include file="admin_menu1.asp"-->
<!-- page content -->
        <div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>Sayfa Türü Ekle</h2>
               <div class="clearfix"></div></div>
  <table class="table table-striped">
  <form name="form1" method="post"  action="?islem=katetekle">
	    <thead> 
        <tr>
      <th>Kategori Adı</th>
      </tr>
    </thead>
    <TR> 
      <td><input name="sektor" type="text" id="sektor" class="form-control"></td>
    </tr>
    <tr> 
      <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"></td>
    </tr>
  </form>
</table>
</div>
<div class="x_panel">
<div class="x_title"><h2>Sayfa T&uuml;rleri</h2>
               <div class="clearfix"></div></div>
<table class="table table-striped">
  <%
sqlString = "select * from kategori order by ana desc"
set mmmGenel = Con1.Execute (sqlString)
if mmmGenel.eof then
else%>
  <thead>
  <tr>
    <th height="30%">Sayfa T&uuml;r&uuml; Adı</th>
    <th>İcon</th>
    <th>Adres D&uuml;zenle</th>
    <th>Adres Ekle</th>
    <th width="2%"></th>
    <th width="2%">Sil</th>
    </tr>
  </thead>
  <form method="post" name="custlist" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
    <%
	
Do While Not mmmGenel.EOF
iks=iks+1
%>
    <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>" />
    <TR> 
      <td><input name="sayfaadi" type="text" id="sayfaadi" value="<%=mmmGenel("kate")%>" class="form-control"/></td>
      <td><input name="resim" type="text" id="resim" value="<%=mmmGenel("resim")%>" class="form-control"/></td>
      <td><input name="adresd" type="text" id="adresd" value="<%=mmmGenel("adresd")%>" class="form-control"/></td>
      <td><input name="adres" type="text" id="adres" value="<%=mmmGenel("adres")%>" class="form-control"/></td>
      <td>
      <%if mmmGenel("ikincii") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("ikincii","İkinci İçerik İzni",iks,cbcdisstr,cbccheckstr,"danger"))%>
        </td>
      <td>
      <%if mmmGenel("ana") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Gösterilsin",iks,cbcdisstr,cbccheckstr,"danger"))%>
        </td>
      <td>
      <div class="form-group">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="urunidsil" class="flatred" id="urunidsila<%=iks%>" value="<%=mmmGenel("id")%>">
                    </label>
                  </div>
                </div></td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
    <tr>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><input name="Submit" type="submit" id="Submit5" value="Duzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=katetDuzenle');"/></td>
      <td>&nbsp;</td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=katetSil');"/></td>
    </tr>
  </form>
  <%close(mmmGenel)
end if
%>
</table>
<SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
</div>
</div>
<%call footer(1)%>