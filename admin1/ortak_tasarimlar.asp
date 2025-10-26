<!--#Include file="admin_menu1.asp"--> 
<%
	if request("dkate2")="" or request("dkate2")=0 then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
%>
<!-- page content -->
        <div class="right_col" role="main">
        <div class="x_panel">
        <%if request.QueryString("sayfa")="tamyedek" then%>
         <div class="x_title"><h2>Tam Yedek</h2>
               <div class="clearfix"></div></div>
        <%else%>
               <div class="x_title"><h2>Tasarımlar</h2>
               <div class="clearfix"></div></div>
  <table class="table table-striped">
    <%
sqlString = "select * from tasarim  order by id"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>

  <%else%>
  <thead> 
    <th height="40">Tasarım Adı</th>
    <th width="10%">Tasarım İşlemleri</th>
    <th width="10%">Aktif Durumu</th>
    <th width="7%">
    <th width="10%">
    <th width="3%">&nbsp;</th>
    <th width="3%">Sil</th>
  </thead>

  <form method="post" name="custlist" id=Form1 action="?dkate2=<% =dkate2%>" target="_self">
    <%
Do While Not mmmGenel.EOF
iok=iok+1
%><input name="urunid" type="hidden" value="<%=mmmGenel("id")%>">
    <TR> 
      <td><input name="sayfaadi" type="text" id="sayfaadi" value="<%=mmmGenel("baslik")%>" size="45" class="form-control"/></td>
      <td><div class="btn-group">
                  <ul class="nav-pills" role="tablist">
          <li class="btn" role="presentation" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçerik Ekle"><button class="btn btn-success dropdown-toggle btn-xs" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">Tasarım İşlemleri <span class="caret"></span></button>
                      <ul id="menu6" class="dropdown-menu animated fadeInDown" role="menu">
              <li role="presentation"><a role="menuitem" tabindex="-1" href="ortak_tasarimlar.asp?islem=csskopya&kopya=<%=mmmGenel("id")%>">Tasarımdan Kopya Oluştur</a></li>
              <li role="presentation"><a role="menuitem" tabindex="-1" href="?islem=sayarguncelle&id=<%=mmmGenel("id")%>">Tüm Sayfa Ayarlarını Tasarımdan Güncelle</a></li>
              <li role="presentation"><a role="menuitem" tabindex="-1" href="?islem=sayaraktar&id=<%=mmmGenel("id")%>">Tüm Sayfa Ayarlarını Tasarıma Aktar</a></li>
              <li role="presentation"><a role="menuitem" tabindex="-1" href="?islem=modulguncelle&id=<%=mmmGenel("id")%>">Tüm Sayfa Modüllerini Tasarımdan Güncelle</a></li>
              <li role="presentation"><a role="menuitem" tabindex="-1" href="?islem=modulaktar&id=<%=mmmGenel("id")%>">Tüm Sayfa Modüllerini Tasarıma Aktar</a></li>
              <li role="presentation"><a role="menuitem" tabindex="-1" href="?sayfa=tamyedek&id=<%=mmmGenel("id")%>">Yeni Tam Yedekle</a></li>
              
              </ul></li>
          </ul>
      </div></td>
      <td>
        <%if mmmGenel("aktif")=1 then%>
        Aktif
        <%else%>
        <a href="?islem=cssaktif&amp;id=<%=mmmGenel("id")%>&amp;ilk=1">Aktifleştir</a>
        <%end if%>
      </td>
      <td colspan="4">
      <div class="row">
              <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=2"><em class="fa fa-cog" style="font-size:18px;"></em></a></div>
              <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=1"><em class="fab fa-css3" style="font-size:18px;"></em></a></div>
           <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=5"><em class="fa fa-desktop" style="font-size:18px;"></em></a></div>
              <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=3"><em class="fa fa-camera" style="font-size:18px;"></em></a></div>
              <div class="col-md-2"><a href="ortak_sayfalar_ayar.asp?sayfaayar=modul&dkate2=0"><em class="fa fa-th-large" style="font-size:18px;"></em></a></div>
      </div>
          </td>
      <td><%if mmmGenel("d56")="1" then%>
        <div class="checkboxx checkboxFour">
          <input name="urunidsil" type="checkbox" id="urunidsil<%=i%>" style="border:0px; width:1em;" value="<%=mmmGenel("id")%>" />
          <label for="urunidsil<%=i%>" class="c_siyah"> </label></div>
        <%else
  end if%></td>
    </tr>

    <%mmmGenel.MoveNext
  loop
%>
    <tr> 
      <td colspan="5"></td>
      <td>&nbsp;</td>
      <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" onclick="this.form.submit();formla('?dkate2=<% =dkate2%>&Submit=tasarimDuzenle');" /></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?dkate2=<% =dkate2%>&Submit=tasarimSil');"></td>
    </tr>
  </form><% 
end if
Close(mmmGenel)
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
<%end if%>
</div>
</div>
<%call footer(1)%>