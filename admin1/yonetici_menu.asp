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
if islem="ymenuekle" then
call ymenuekle
elseif islem="ymenuDuzenle" then
call ymenuDuzenle
elseif islem="ymenuSil" then
call ymenuSil
else
end if

sub ymenuSil

For r = 1 To Request.Form("urunidsil").Count
set mmmYardimci1 = Con1.Execute ("delete FROM yonetici_menu where id="&Request.Form("urunidsil")(r)&" or anasek='"&Request.Form("urunidsil")(r)&"'") 
next
session("hata1")="Menü Silindi"
session("hatam1")="red"
end sub

sub ymenuDuzenle

For i = 1 To Request.Form("onay").Count and  Request.Form("isim").Count and Request.Form("urunid").Count and Request.Form("dkate1").Count and Request.Form("seolink").Count
if request.Form("dkate1")(i)="0" then
altt="1"
else
altt="0"
end if
Set mmmYardimci=Con1.execute("update yonetici_menu set durum='"&request.Form("onay")(i)&"', anasek='"&request.Form("dkate1")(i)&"', alt='"&altt&"', isim='"&request.Form("isim")(i)&"', stura='"&request.Form("icon")(i)&"',seolink='"&request.Form("seolink")(i)&"', modulmu='"&request.Form("yetki1")(i)&"', sira='"&i&"' where id="&request("urunid")(i)&"")

next
session("hata1")="Menü Düzenlendi"
session("hatam1")="green"
end sub

sub ymenuekle

if request.Form("menudurum")="0" then
altt = 1
else
altt = 0
end if


Set mmmYardimci1=Con1.execute("insert yonetici_menu set isim='"&request.Form("sektor")&"', alt='"&altt&"', durum='1', anasek='"&request.Form("menudurum")&"', modulmu='"&request.Form("yetki1")&"', seolink='"&request.Form("seolink")&"'")


session("hata1")="Menü Eklendi"
session("hatam1")="green"

end sub
%>

<div class="right_col" role="main">
  <div class="x_panel">
  <div class="x_title">
    <h2>Menüler</h2>
    <div class="clearfix"></div>
  </div>
  <div style="clear:left;"></div>

  <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel"> 
      <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
        <form name="form1" method="post"  action="?islem=ymenuekle&filtret=menu">
        <table class="table table-striped">          
            <tr>
              <td>&nbsp;</td>
              <td><strong>Menü Durumu</strong></td>
              <td>&nbsp;</td>
              <td><strong>Menü İsim</strong></td>
              <td>&nbsp;</td>
              <td><strong>Menü Link</strong></td>
              <td>&nbsp;</td>
              <td><strong>Menü Türü</strong></td>
            </tr>
            <tr>
            <td>&nbsp;</td>
              <td>
                  <select name="menudurum" class="form-control" id="durum2" >
                  <option value="0"> Ana Menü </option>
                  <%
sqlString = "SELECT * from yonetici_menu where alt = '1' order by modulmu, sira"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                  <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("isim")%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con1.Execute (sqlString)
Do While Not mmmYardimci1.EOF
menuisim=mmmYardimci1("isim")
if mmmYardimci1("id")=int(request("menudurum")) then
sonkate=1

else
end if
%>
                  <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci1("id")&"' order by sira"
set mmmYardimci2 = Con1.Execute (sqlString)
Do While Not mmmYardimci2.EOF
menuisim=mmmYardimci2("isim")
%>
                  <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(request("menudurum")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci2("id")&"' order by sira"
set mmmSayfa = Con1.Execute (sqlString)
Do While Not mmmSayfa.EOF
menuisim=mmmSayfa("isim")
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
              <td><input name="sektor" type="text" id="sektor" class="form-control" value=""></td>
              <td>&nbsp;</td>
              <td><input name="seolink" type="text" id="seolink" class="form-control" value="" placeholder="İsteğe Bağlı Link"> </td>
              <td>&nbsp;</td>
              <td><select name="yetki1" class="form-control" id="moduller2">
                             <%
sqlString = "select * from moduller where"&modulgosterme&" and temp='99999'  order by temp desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
set mmmGenel = Con1.Execute (sqlString)
                              Do While Not mmmGenel.EOF
                              %>
                        <option value="<%=mmmGenel("id")%>">
                          <%=mmmGenel("moduladi")%>
                          </option>
       <%
		mmmGenel.MoveNext
  loop
           close(mmmGenel)
  %>
                      
                        </select> </td>
              <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-left"></td>
            </tr>          
        </table>
        </form>
      </div>
    </div>
  </div>
  <form method="post" name="custlist" id=Form1 action="?usayi=<%=request("usayi")%>&altkate=<%=altkate%>&islem=kap&filtremi=<%=request("filtremi")%>&sira=<%=request("sira")%>&kateid=<%=request("kateid")%>&git=<%=request("git")%>" target="_self">
    <table class="table table-striped">
      <%

      if request("usayi")="" then
	KayitSayisi=30
	else
	KayitSayisi=request("usayi")
	end if
	
	git = Request.QueryString("git")
if git="" then 
git=1
end if

if altkate=1 then
  sqlString = "select * FROM yonetici_menu where anasek='"&kateid&"'"
else
 sqlString = "select * FROM yonetici_menu where alt='1'"
end if
set mmmGenel=Con1.execute(sqlString&" order by sira limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&"")%>
      <tr>
        <td width="30" align="right"><a href="yonetici_menu.asp">
        <div class="btn btn-primary">Menüler Anasayfa</div>
      </a></td>
        <td width="8%" align="right"><input name="button" type="button" id="button2a" value="D&uuml;zenle" class="btn btn-primary pull-right" ONCLICK="this.form.submit();formla('?islem=ymenuDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
        <td width="3%"><input name="button" type="button" id="button2" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?islem=ymenuSil&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
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
          strtoplu=mmmGenel("sira1")
          menuseolinkana=mmmGenel("seolink")
          menutempiana=mmmGenel("modulmu")
          menuiconana=mmmGenel("stura")
          'response.Write sqlString
menuisimana=mmmGenel("isim")
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
            <td width="4%"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
                      </span></td>
            <td><input name="icon" type="text" value="<%=menuiconana%>" size="30" class="form-control"></td>
            <td>
                <select name="dkate1" class="form-control" id="durum2" >
                  <option value="0"> Ana Menü </option>
                  <%
sqlString = "SELECT * from yonetici_menu where alt = '1' order by modulmu, sira"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
                  <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("isim")%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci("id")&"' order by sira"
set mmmYardimci1 = Con1.Execute (sqlString)
Do While Not mmmYardimci1.EOF
menuisim=mmmYardimci1("isim")
if mmmYardimci1("id")=int(mmmGenel("anasek")) then
sonkate=1

else
end if
%>
                  <option value="<%=mmmYardimci1("id")%>" <% if mmmYardimci1("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci1("id")&"' order by sira"
set mmmYardimci2 = Con1.Execute (sqlString)
Do While Not mmmYardimci2.EOF
menuisim=mmmYardimci2("isim")
%>
                  <option value="<%=mmmYardimci2("id")%>" <% if mmmYardimci2("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
                  <%
sqlString = "SELECT * from yonetici_menu where anasek='"&mmmYardimci2("id")&"' order by sira"
set mmmSayfa = Con1.Execute (sqlString)
Do While Not mmmSayfa.EOF
menuisim=mmmSayfa("isim")
%>
                  <option value="<%=mmmSayfa("id")%>" <% if mmmSayfa("id")=int(mmmGenel("anasek")) then%> selected="selected" <%else%> <%end if%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=menuisim%></option>
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
            <td><input name="isim" type="text" id="urunfiyat2" value="<%=menuisimana%>" size="30" class="form-control"></td>
            <%sira1=sira1+int(mmmGenel("sira"))
		%>

               <td><input name="seolink" type="text" id="seolink" style="float:left;" class="form-control" value="<%=menuseolinkana%>" placeholder="İsteğe Bağlı Link">
                </td>
              <td>
                  <select name="yetki1" class="form-control">
                             <%
sqlString = "select * from moduller where"&modulgosterme&" and temp='99999'  order by temp desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
set mmmyardimci = Con1.Execute (sqlString)
                              Do While Not mmmyardimci.EOF
                                 tempiid=mmmyardimci("id")
                              %>
                        <option value="<%=tempiid%>" <%if menutempiana&""=tempiid&"" then %>selected<%else %><%end if %> >
                          <%=mmmyardimci("moduladi")%>
                          </option>
       <%
		mmmyardimci.MoveNext
  loop
           close(mmmyardimci)
  %>
                      
                        </select> 
              </td>
            <td align="center" style="width:25px;">
              <%if mmmGenel("durum") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Onay Durumu",ikss,cbcdisstr,cbccheckstr,"success"))%>
            </td>
            <%
set mmmYardimci=Con1.execute("select * FROM yonetici_menu where anasek='"&mmmGenel("id")&"' ORDER BY isim")
%>
            <td width="2%" align="center"><%if mmmYardimci.eof then%>
              <a class="btn btn-danger dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Menü Eklenmemiş"><em class="fas fa-edit" style="font-size:11px;"></em></a>
              <%else%>
              <a href="?kateid=<%=mmmGenel("id")%>&altkate=1" class="btn btn-success dropdown-toggle btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Menüleri Düzenle"><em class="fas fa-edit" style="font-size:11px;"></em></a>
              <%end if
                  close(mmmYardimci)%></td>
              
            <td width="2%" align="center"><input name="urunidsil" class="flatred" type="checkbox" id="sira2" value="<%=mmmGenel("id")%>"></td>
          </tr>
        </table>
        </div>
      </li>
      <%
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
        <td width="2%" align="right" bgcolor="#FFFFFF"><input name="button" type="button" id="button2" value="D&uuml;zenle"  class="btn btn-primary pull-right" ONCLICK="this.form.submit();formla('?islem=ymenuDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
        <td width="3%"><input name="button" type="button" id="button2" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?islem=ymenuSil&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');"></td>
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

 var group = $("ol.yeni_menu").sortable({
  group: 'no-drop',
            onDrop: function  ($item, container, _super) {

            updateserialize();
             _super($item, container);
  },
  onDragStart: function ($item, container, _super) {
    // Duplicate items of the no drop area
    if(!container.options.drop)
      $item.clone().insertAfter($item);
    _super($item, container);
  }
});
$("ol.ekle_menu").sortable({
  group: 'no-drop'
});




function updateserialize(){
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

	document.getElementById("serialize_outputhidden").value = jsonString;
	}

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