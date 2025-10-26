<!--#Include file="admin_menu1.asp"-->
<%
if request.form("durum")="" or request.form("durum")=0 then
	durum=0
	else
	durum=request.form("durum")
	end if
if request("dkate2")="" or request("dkate2")=0 then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
	if request("altsecim")="" or request("altsecim")=0 then
	altsecim=0
	else
	altsecim=request("altsecim")
	end if
%>
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>Form Nesnesi Ekle</h2>
<div class="clearfix"></div></div>
<table class="table table-striped">
  <form  action="?islem=formnekle" method="post" name="form1" id="form1">
  
   <%if request("form")="" then%>
  <input name="form" type="hidden" value="11111111" />
  <%else%>
  <input name="form" type="hidden" value="<%=request("form")%>" />
  <%end if%>
    <TR> 
      <td width="31%">Ana Nesne</td>
      <td width="69%"><select name="durum" class="form-control" id="durum">
          <option value="1"> Ana Nesne </option>
          <%
sqlString = "select * from ozellikler where alt = '1' and formid='"&request("form")&"' ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
          <option value="<%=mmmGenel("id")%>" <%if mmmGenel("id")=int(durum) then%>selected<%else%><%end if%>><%=mmmGenel("isim")%></option>
          <%
sqlString = "select * from ozellikler where anasek = '"&mmmGenel("id")&"' and formid='"&request("form")&"' ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
          <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(durum) then%>selected<%else%><%end if%>>&nbsp;&nbsp;<%=mmmYardimci("isim")%></option>
          <%
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
          <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
        </select>
      </td>
    </tr>
    <TR> 
      <td>Bağlı Olduğu Nesne</td>
      <td><select name="bagli" class="form-control" id="bagli">
        <option value="0">Bağlı Olduğu Nesne</option>
 <%
sqlString = "select * from kategoriyazi where alt = '1' order by isim desc"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
        <option value="<%=mmmGenel("id")%>" <%if mmmGenel("id")=int(bagli) then%>selected<%else%><%end if%>><%=mmmGenel("isim")%></option>
  <%
sqlString = "select * from kategoriyazi where anasek='"&mmmGenel("id")&"' order by isim desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
        <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(bagli) then%>selected<%else%><%end if%>>&nbsp;&nbsp;<%=mmmYardimci("isim")%></option>
        <%mmmYardimci.MoveNext
  loop
  mmmYardimci.close%>
  
        <%mmmGenel.movenext
loop
close(mmmGenel)%>
      </select></td>
    </tr>
    <TR>
      <td>Nesne Adı</td>
      <td><input name="ad" type="text" id="ad" class="form-control"/></td>
    </tr>
    <TR> 
      <td>Nesne Türü</td>
      <td><select name="tur" class="form-control" id="tur">
          <%
sqlString = "select * from ozellikler1  ORDER BY isim desc"
set mmmGenel = Con1.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
          <option value="<%=mmmGenel("id")%>"><%=mmmGenel("isim")%></option>
          <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
<option value="0" disabled="disabled">Siparişler İçin</option>
 <%
sqlString = "SELECT * from kategoriyazi where alt = '1'   order by isim desc"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
        <option value="<%=mmmGenel("id")%>"><%=mmmGenel("isim")%></option>
  
        <%mmmGenel.MoveNext
  loop
  close(mmmGenel)%>
        </select>
        </td>
    </tr>
    <TR> 
      <td></td>
      <td>
        <input name="submit" type="submit" value="Ekle" class="btn btn-success pull-right"></td>
    </tr>
  </form>
</table>
<div class="x_title"><h2>Form Nesneleri</h2>
<div class="clearfix"></div></div>
  <%
if request("altsecim")="1" then
sqlString = "select * from ozellikler where formid='"&request("form")&"' and anasek = '"&request("anasek")&"' and dil = '240' order by sira"
else
 sqlString = "select * from ozellikler where formid='"&request("form")&"' and alt = '1' and dil = '240' order by sira"
end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else%>
  <div class="icerik<%=collor%> icerik">
  <div class="col-md-8">
<div class="col-md-1"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
            </span></div>
<div class="col-md-3">Form Nesnesi Adı</div>
<div class="col-md-3">Form Nesnesi Adı</div>
<div class="col-md-2">Ana Form Nesnesi</div>
<div class="col-md-3">Form Nesnesi Türü</div>
</div>
<div class="col-md-4">
<div class="col-md-2"></div>
<div class="col-md-2"></div>
<div class="col-md-4">Maksimum Karakter Girişi</div>
<div class="col-md-2">Alt Nesneler</div>
<div class="col-md-2"></div></div></div>
  <form method="post" Name="custlist" id="Form1" action="?form=<%=request("form")%>&usayi=<%=request("usayi")%>&anasek=<%=request("anasek")%>&altsecim=<%=altsecim%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
  <div class="sortpage">
    <ol class="ui-sortable1 vertical">
    <%
Do While Not mmmGenel.EOF
iks=iks+1
%>
<li class="ui-state-default">
<%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
      <%collor="1"%>
      <%else%>
      <%collor="2"%>
      <%end if%>
    <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>" />
     <%if request("form")="" then%>
  <input name="form" type="hidden" value="11111111" />
  <%else%>
  <input name="form" type="hidden" value="<%=request("form")%>" />
  <%end if%>
  <div class="icerik<%=collor%> icerik">
  <div class="col-md-8">
<div class="col-md-1"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
            </span></div>
      <%if mmmGenel("tur")="8" then %>
<div class="col-md-3"><textarea name="ad" type="text" id="sayfaadi" class="form-control" ><%=mmmGenel("isim")%></textarea></div>
      <%else %>
<div class="col-md-3"><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("isim")%>" class="form-control" /></div>
      <%end if %>
<div class="col-md-3"><input name="iname" type="text" id="iname" value="<%=mmmGenel("name")%>" class="form-control" /></div>
<div class="col-md-2"><select name="bagli" class="form-control" id="bagli">
        <option value="0">Bağlı Olduğu Nesne</option>
 <%
sqlString = "select * from kategoriyazi where alt = '1' order by isim desc"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
%>
        <option value="<%=mmmGenel("id")%>" <%if mmmYardimci1("id")=int(mmmGenel("bagli")) then%>selected<%else%><%end if%>><%=mmmYardimci1("isim")%></option>
  <%
sqlString = "select * from kategoriyazi where anasek='"&mmmYardimci1("id")&"' order by isim desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
        <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(mmmGenel("bagli")) then%>selected<%else%><%end if%>>&nbsp;&nbsp;<%=mmmYardimci("isim")%></option>
        <%mmmYardimci.MoveNext
  loop
  mmmYardimci.close%>
  
        <%mmmYardimci1.movenext
loop
close(mmmYardimci1)%>
      </select></div>
<div class="col-md-3"><select name="tur" class="form-control" id="tur">
          <%
sqlString = "select * from ozellikler1  ORDER BY isim"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
          <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(mmmGenel("tur")) then%>selected<%else%><%end if%>><%=mmmYardimci("isim")%></option>
          <%
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
<option value="0" disabled="disabled">Siparişler İçin</option>
 <%
sqlString = "SELECT * from kategoriyazi where alt = '1'   order by isim desc"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
        <option value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(mmmGenel("tur")) then%>selected<%else%><%end if%>><%=mmmYardimci("isim")%></option>
  
        <%mmmYardimci.MoveNext
  loop
 close(mmmYardimci)%>
      </select></div></div>
      <div class="col-md-4">
<div class="col-md-2"><%if mmmGenel("gonderen") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("gonderen","Gönderen Emaili Durumu",iks,cbcdisstr,cbccheckstr,"primary"))%></div>
<div class="col-md-2"><%if mmmGenel("gerekli") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("gerekli","Giriş Zorunluluğu Durumu",iks,cbcdisstr,cbccheckstr,"info"))%></div>
<div class="col-md-4"><input name="maxs" type="text" id="maxs" value="<%=mmmGenel("maxs")%>" class="form-control" /></div>
<div class="col-md-2">
<%
sqlString = "select * from ozellikler where formid='"&request("form")&"' and anasek = '"&mmmGenel("id")&"' and dil = '240' order by sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
%>
<a href="?form=<%=request("form")%>&anasek=<%=mmmGenel("id")%>&altsecim=1"><em class="fas fa-file" style="font-size:18px;"></em></a><%end if
			close(mmmYardimci)%></div>
<div class="col-md-2"><div class="form-group" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil İçin Seçiniz" style="display:table;">
              <div class="checkbox">
                <input type="checkbox" name="urunidsil" class="flatred" id="urunidsil<%=iks%>" value="<%=mmmGenel("id")%>">
              </div>
            </div>
            </div></div></div>

</li>
    <%
	mmmGenel.MoveNext
  loop
  %>
  </ol>
  </div>
  <table class="table table-striped">
    <tr>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td width="1" align="center"><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?form=<%=request("form")%>&usayi=<%=request("usayi")%>&anasek=<%=request("anasek")%>&altsecim=<%=altsecim%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formnDuzenle');"/></td>
      <td width="10">&nbsp;</td>
      <td width="1" align="center"><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?form=<%=request("form")%>&usayi=<%=request("usayi")%>&anasek=<%=request("anasek")%>&altsecim=<%=altsecim%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formnSil');"/></td>
    </tr>
 
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
</table> </form>
</div>
</div>
<%call footer(1)%>
        <script>
	var oldContainer;
$("ol.ui-sortable1").sortable({
//placeholder: 'yerTutucu',
  handle: 'i.fa-arrows',  
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {
    container.el.removeClass("active");
    _super($item, container);
  }
});

$('ul.nav-pills li.dropdown-toggle').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(500);
}, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(500);
});
</script>