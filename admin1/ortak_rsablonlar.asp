<!--#Include file="admin_menu1.asp"-->
<%
		if request("altkate")="" or request("altkate")="0" then
	altkate=0
	else
	altkate=1
	end if
	if request("kateid")="" or request("kateid")="0" then
	kateid=0
	else
	kateid=request("kateid")
	end if
	if request("filtremi")="" or request("filtremi")="1" then
	filtremi=1
	else
	filtremi=request("filtremi")
	end if
	

	
	islem=Request.QueryString("islem")
if islem="sablonekle" then
call sablonekle
elseif islem="sablonDuzenle" then
call sablonDuzenle
elseif islem="sablonSil" then
call sablonSil
else
end if

sub sablonSil

For r = 1 To Request.Form("urunidsil").Count
set mmmYardimci1 = Con1.Execute ("delete FROM replacesablon where id="&Request.Form("urunidsil")(r)&" or ana='"&Request.Form("urunidsil")(r)&"'") 
next
session("hata1")="Şablon Silindi"
session("hatam1")="red"
end sub

sub sablonDuzenle

For i = 1 To Request.Form("onay").Count and  Request.Form("isim").Count and Request.Form("urunid").Count and Request.Form("dkate1").Count
if request.Form("dkate1")(i)="1" then
altt="1"
else
altt="0"
end if
Set mmmYardimci=Con1.execute("update replacesablon set onay='"&request.Form("onay")(i)&"',ana='"&request.Form("dkate1")(i)&"',kate1='"&request.Form("isim")(i)&"',adresd='"&request.Form("deger")(i)&"',adres='"&request.Form("aciklama")(i)&"' where id="&request("urunid")(i)&"")

next
session("hata1")="Şablon Düzenlendi"
session("hatam1")="green"
end sub

sub sablonekle

if request.Form("durum1")="0" then
altt = 1
else
altt = 0
end if

if instr(request.Form("durum1"),"k") then
bagliid=replace(request.Form("durum1"),"k","")
baglitur="k"
elseif instr(request.Form("durum1"),"s") then
bagliid=replace(request.Form("durum1"),"s","")
baglitur="s"
elseif instr(request.Form("durum1"),"h") then
bagliid=replace(request.Form("durum1"),"h","")
baglitur="h"
else
bagliid="0"
baglitur="0"
end if
if request.Form("toplu")="1" then
if bagliid="0" then
sonmenuid=request.Form("menudurum")
else
Con1.execute("insert replacesablon set kate1'"&request.Form("sektor")&"',onay='1',ana='"&request.Form("menudurum")&"'")
sqlString = "SELECT * from replacesablon order by id desc"
set mmmYardimci = Con1.Execute (sqlString)
sonmenuid=mmmYardimci("id")
close(mmmYardimci)
end if
if baglitur="k" then
if bagliid="0" then
sqlString = "SELECT * from kategoriyazi where ana = '1' order by id"
else
sqlString = "SELECT * from kategoriyazi where ana = '"&bagliid&"' order by id"
end if
set mmmYardimci3 = Con1.Execute (sqlString)
if mmmYardimci3.eof then
else
Do While Not mmmYardimci3.EOF
Con1.execute("insert replacesablon set kate1'"&request.Form("sektor")&"',onay='1',ana='"&sonmenuid&"'")

mmmYardimci3.MoveNext
loop  
end if
close(mmmYardimci3)
elseif baglitur="s" then
if bagliid="0" then
sqlString = "SELECT * from store_kategoriurun where ana = '1' order by id"
else
sqlString = "SELECT * from store_kategoriurun where ana = '"&bagliid&"' order by id"
end if
set mmmYardimci3 = Con1.Execute (sqlString)
if mmmYardimci3.eof then
else
Do While Not mmmYardimci3.EOF
Con1.execute("insert replacesablon set kate1'"&request.Form("sektor")&"',onay='1',ana='"&sonmenuid&"''")
mmmYardimci3.MoveNext
loop  
end if
close(mmmYardimci3)
elseif baglitur="h" then

else

end if

else
Set mmmYardimci1=Con1.execute("insert replacesablon set kate1='"&request.Form("sektor")&"',adresd='"&request.Form("sektor2")&"',adres='"&request.Form("sektor3")&"',onay='1',ana='"&request.Form("menudurum")&"'")
end if

session("hata1")="Şablon Eklendi"
session("hatam1")="green"

end sub
%>

<div class="right_col" role="main">
  <div class="x_panel">
  <div class="x_title">
    <h2>Şablon Değerleri</h2>
    <div class="clearfix"></div>
  </div>
  <div style="clear:left;"></div>
  <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel"> <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
      <h4 class="panel-title pull-right"><div class="btn btn-success">Yeni</div></h4>
      <div class="clearfix"></div>
      </a>
      <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
        <form name="form1" method="post"  action="?islem=sablonekle&filtret=menu">
        <table class="table table-striped">          
            <tr>
              <td>&nbsp;</td>
              <td><strong>Şablon Durumu</strong></td>
              <td>&nbsp;</td>
              <td><strong>Şablon İsim</strong></td>
              <td><strong>Şablon Değer</strong></td>
              <td><strong>Şablon Açıklama</strong></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
            <td>&nbsp;</td>
              <td><select name="menudurum" class="form-control" id="durum2" >
                  <option value="0"> Ana Şablon </option>
                  <%
sqlString = "SELECT * from replacesablon where ana = '0' order by kate1"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                  <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("kate1")%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci("id")&"' order by id"
set mmmYardimci1 = Con1.Execute (sqlString)
Do While Not mmmYardimci1.EOF
menuisim=mmmYardimci1("kate1")
if mmmYardimci1("id")=int(request("menudurum")) then
sonkate=1

else
end if
%>
                  <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci1("id")&"' order by id"
set mmmYardimci2 = Con1.Execute (sqlString)
Do While Not mmmYardimci2.EOF
menuisim=mmmYardimci2("kate1")
%>
                  <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci2("id")&"' order by id"
set mmmSayfa = Con1.Execute (sqlString)
Do While Not mmmSayfa.EOF
menuisim=mmmSayfa("kate1")
%>
                  <option value="<%=mmmSayfa("id")%>" <% if mmmSayfa("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%mmmSayfa.MoveNext
loop
 close(mmmSayfa)
 mmmYardimci2.MoveNext
loop
close(mmmYardimci2)
  mmmYardimci1.MoveNext
loop
  close(mmmYardimci1)
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                </select></td>
              <td>&nbsp;</td>
              <td><input name="sektor" type="text" id="sektor" style="float:left;" class="form-control">
              </td>
              <td><input name="sektor2" type="text" id="sektor2" style="float:left;" class="form-control" /></td>
              <td><input name="sektor3" type="text" id="sektor3" style="float:left;" class="form-control" /></td>
              <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-left"></td>
            </tr>          
        </table>
        </form>
      </div>
    </div>
  </div>
  <table class="table table-striped">
    <tr>
      <td width="15%"><a href="store.asp?storesayfagit=urunmenu">
        <div class="btn btn-primary">Şablonlar Anasayfa</div>
      </a></td>
      <td width="15%"><a href="?tur=ustmenu">
        <div class="btn btn-warning">&Uuml;st Men&uuml; Şablonları</div>
      </a></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <form method="post" name="custlist" id=Form1 action="?usayi=<%=request("usayi")%>&altkate=<%=altkate%>&islem=kap&filtremi=<%=request("filtremi")%>&sira=<%=request("sira")%>&kateid=<%=request("kateid")%>&git=<%=request("git")%>" target="_self">
    <table class="table table-striped">
      <%

      if request("usayi")="" then
	KayitSayisi=60
	else
	KayitSayisi=request("usayi")
	end if
	
	git = Request.QueryString("git")
if git="" then 
git=1
end if

if altkate=1 then
  sqlString = "select * FROM replacesablon where ana='"&kateid&"'"
else
 sqlString = "select * FROM replacesablon where ana='0'"
end if
set mmmGenel=Con1.execute(sqlString&" order by id limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&"")%>
      <tr>
        <td width="30" >&nbsp;</td>
        <td width="8%" align="right"><input name="button" type="button" id="button2" value="D&uuml;zenle" class="btn btn-primary pull-right" ONCLICK="this.form.submit();formla('?islem=sablonDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
        <td width="3%"><input name="button" type="button" id="button2" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?islem=sablonSil&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
      </tr>
    </table>
    <%if mmmGenel.eof then%>
    <table class="table table-striped">
      <tr>
        <td><strong>Ürün Kaydi Yok</strong></td>
      </tr>
    </table>
    <%else%>
    <div class="sortpage">
    <ol class="ui-sortable1 vertical">
      <%
Do While Not mmmGenel.EOF
menuisimana=mmmGenel("kate1")
menuisimdeger=mmmGenel("adresd")
menuisimacik=mmmGenel("adres")
ikss=ikss+1
if right(ikss,1)=1 or right(ikss,1)=3 or right(ikss,1)=5 or right(ikss,1)=7 or right(ikss,1)=9 then%>
          <%collor="1"%>
          <%else%>
          <%collor="2"%>
          <%end if%>
      <li class="ui-state-default">
      <div class="icerik<%=collor%> icerik">
        <table class="table table-striped" style="margin-bottom:0px;">
          <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>">          
          <TR>
            <td width="4%"><span class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></span></td>
            <td width="2%"><%=mmmGenel("id")%></td>
            <td width="22%">
                <select name="dkate1" class="form-control" id="durum2" >
                  <option value="0"> Ana Şablon </option>
                  <%
sqlString = "SELECT * from replacesablon where ana = '0' order by kate1"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                  <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(mmmGenel("ana")) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("kate1")%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci("id")&"' order by id"
set mmmYardimci1 = Con1.Execute (sqlString)
Do While Not mmmYardimci1.EOF
menuisim=mmmYardimci1("kate1")
if mmmYardimci1("id")=int(mmmGenel("ana")) then
sonkate=1

else
end if
%>
                  <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(mmmGenel("ana")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci1("id")&"' order by id"
set mmmYardimci2 = Con1.Execute (sqlString)
Do While Not mmmYardimci2.EOF
menuisim=mmmYardimci2("kate1")
%>
                  <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(mmmGenel("ana")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from replacesablon where ana='"&mmmYardimci2("id")&"' order by id"
set mmmSayfa = Con1.Execute (sqlString)
Do While Not mmmSayfa.EOF
menuisim=mmmSayfa("kate1")
%>
                  <option value="<%=mmmSayfa("id")%>" <% if mmmSayfa("id")=int(mmmGenel("ana")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%mmmSayfa.MoveNext
loop
 close(mmmSayfa)
 mmmYardimci2.MoveNext
loop
close(mmmYardimci2)
  mmmYardimci1.MoveNext
loop
  close(mmmYardimci1)
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                </select></td>
            <td width="22%"><input name="isim" type="text" class="form-control" id="urunfiyat2" value="<%=menuisimana%>"></td>
            <td width="22%" align="center"><input name="deger" type="text" id="deger" value="<%=menuisimdeger%>" class="form-control" /></td>
            <td width="22%" align="center"><input name="aciklama" type="text" id="aciklama" value="<%=menuisimacik%>" class="form-control" /></td>
            <td width="2%" align="center">
              <%if mmmGenel("onay") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Onay Durumu",ikss,cbcdisstr,cbccheckstr,"success"))%>
            </td>
            <%
set mmmYardimci=Con1.execute("select * FROM replacesablon where ana='"&mmmGenel("id")&"' ORDER BY kate1")
%>
            <td width="2%" align="center"><%if mmmYardimci.eof then%>
              <a class="btn btn-danger dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Şablon Eklenmemiş"><em class="fas fa-file" style="font-size:11px;"></em></a>
              <%else%>
              <a href="?kateid=<%=mmmGenel("id")%>&altkate=1" class="btn btn-success dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Şablonları Düzenle"><em class="fas fa-file" style="font-size:11px;"></em></a>
              <%end if%></td>
            <td width="2%" align="center"><input name="urunidsil" type="checkbox" id="sira2" value="<%=mmmGenel("id")%>"></td>
          </tr>
        </table>
        </div>
      </li>
      <%close(mmmYardimci)
	mmmGenel.MoveNext
  loop
  %>
    </ol>
    </div>
    <table class="table table-striped">
      <tr>
        <td colspan="7">&nbsp;</td>
        <td>&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="2%" align="right" bgcolor="#FFFFFF"><input name="button" type="button" id="button2" value="D&uuml;zenle"  class="btn btn-primary pull-right" ONCLICK="this.form.submit();formla('?islem=sablonDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
        <td width="3%"><input name="button" type="button" id="button2" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?islem=sablonSil&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
      </tr>
    </table>
  </form>
  <SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT> 
</div  >
<%end if%>
</div  >
<%call footer(1)%>
        <script>
	var oldContainer;
$("ol.ui-sortable1").sortable({
  group: 'nested', 
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

</script>