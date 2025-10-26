<!--#Include file="admin_menu1.asp"-->

<%
	if request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
%>
<div class="right_col" role="main">
<div class="x_panel">
  <%if dkate2="" then
   altsayfaekle="?rinn=web"
else
if dkate2="0" or request("sek")="0" then
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek=1"
else
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek="&request("sek")&""
end if
end if
modulmuagac=" and modulmu = '1'"%>
  <div class="input-group">
  <div class="input-group-addon">
    <%if dkate2="" or dkate2="0" then
else%>
<div class="input-group-btn">      
      <div class="dropdown">
        <a class="btn btn-danger" style="padding:1px 6px;" type="button" href="admin_uruny_duzenle.asp?modulv=1&yazi=yeni&modul=0&dkate2=<%=dkate2%>&dkate=<%=dkate2%>&coklu=1&iceriktur=1<%=formicev%>&titlee=<%=server.urlencode(strisim) %>"><em class="fa fa-plus" style="font-size:11px; color:#FFF;"></em></a>
      </div>      
    </div>
	<%end if%>
    <div class="input-group-btn">
  
         <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Sayfa Ekle" style="display:table;">
      <a href="baslik.asp<%=altsayfaekle%>&modulmu=1" class="btn btn-success dropdown-toggle btn-xs" data-toggle="modal" data-target="#baslikmodal"><em class="fa fa-clipboard" style="font-size:11px;"></em></a>
      </div>
   
    </div>
  </div>
      <%if eser="1" then %>
<div class="btn-group">
  <button type="button" class="btn btn-default btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Action <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" style="overflow-y:scroll; height:500px;">
      <% response.Write kategoriyaziliste("1","<li><a href=""?id=#kylid#&baslik=#kylid#&sek=#kylanasek#&dkate2=#kylid#"">#kylico##kylisim#</a></li>#kylsub{(,,,,"&sayfagosterme&", &nbsp;&nbsp;-&nbsp;,240)}#","",dkate2,sayfagosterme&" and modulmu='1'","","240") %>  
  </ul>
</div>
      <%end if %>
    <select name="dkate2" class="form-control" onchange="MM_jumpMenu('parent',this,0)" id="dkate" style="width:100%;">        
      <option value="?"> TÜM MODÜLLER </option>
   <% response.Write kategoriyaziliste("1","<option value=""?id=#kylid#&baslik=#kylid#&sek=#kylanasek#&dkate2=#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&" and modulmu='1', &nbsp;&nbsp;-&nbsp;,240)}#","",dkate2,sayfagosterme&" and modulmu='1'","","240") %>     
    </select>
  </div>
</div>

    <%
        kategorimodullistesi= kategoriyaziliste("1","<option value=""#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&" and modulmu='1', &nbsp;&nbsp;-&nbsp;,240)}#","",dkate2,sayfagosterme&" and modulmu='1'","","240")
if dkate2="" or dkate2=0 then
sqlString = "select * from kategoriyazi where alt = '1'"&modulmuagac&""&sayfagosterme&" order by sira"
else
  sqlString = "select * from kategoriyazi where anasek='"&dkate2&"'"&modulmuagac&""&sayfagosterme&"  order by sira"
  end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else%>
    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>" target="_self">
  <div class="x_panel">
    <div>
            <div class="icerik1 icerik">
      <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit(); formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil');">
      <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit(); formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenle');">
    </div>           
    </div>
    <div style="clear:both;"></div>
    <div class="sortpage">
    <ol class="ui-sortable1 vertical">  <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strsifreli=mmmGenel("sifreli")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
smidseolink=mmmGenel("seolink")
if sid="" or isNull(sid) or sid="835" then
sida=strid
else
sida=sid
end if
%>
      <li class="ui-state-default">
        <%
        


sqlString = "select * from resimd where baslik='"&strid&"'  order by fid desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
resim=""
else
resim="<img src="""&dbuploadgaleri&""&mmmYardimci("resimid")&""" width=""190"" border=""0""><br />"
end if
close(mmmYardimci)
	  lojik4=con.execute("select count(id) as toplam4 from yazilar where kategori='"&strid&"' ")
toplam4=lojik4("toplam4")
  lojik5=con.execute("select count(id) as toplam4 from kategoriyazi where anasek='"&strid&"' ")
toplam5=lojik5("toplam4")
 lojik6=con.execute("select count(fid) as toplam4 from resimd where baslik='"&strid&"' ")
toplam6=lojik6("toplam4")
            
%>
        <input name="urunid" type="hidden" value="<%=strid%>">
        <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
        <%collor="1"%>
        <%else%>
        <%collor="2"%>
        <%end if%>
        <div class="icerik<%=collor%> icerik">
          <div>
          
          <div class="col-md-12">
           
              <div class="col-md-11 col-xs-9"> 
                          

              <input name="sayfalama" type="hidden" value="<%=stranasek%>" />
              
              <div class="col-md-12">
              <div class="input-group"> 
              <div class="input-group-btn">   
                 <div style="min-width:30px; font-size:initial;">
                     <span class="handle ui-sortable-handle">
                        <i class="fas fa-arrows-alt"></i>
                     </span>
              </div>
              </div>               
                <div class="input-group-btn">
                  <ul class="nav-pills" role="tablist" style="padding:0px;">
                    <%

sqlString = "SELECT * from kategori where id='1' order by id"
srvyid="0"

set mmmYardimci1 = Con1.Execute (sqlString)
if mmmYardimci1.eof then
iceriklink="admin_uruny_duzenle.asp?duzelt1=1&urunid="&srvyid&"&baslik="&srvyid&"&sek="&strid&"&dkate2="&strid&""
else
iceriklink="?"&linked&"dkate2="&strid&"&sek="&dkate2*1&""
                        %>
                    <li role="presentation" class="btn-danger dropdown-toggle btn-xs" style="padding:8px 5px;"><a id="drop4" href="admin_uruny_duzenle.asp?modulv=1&yazi=yeni&modul=0&dkate2=<%=strid%>&dkate=<%=strid%>&coklu=1&iceriktur=1<%=formicev%>&titlee=<%=server.urlencode(strisim) %>"><em class="fa fa-plus" style="font-size:14px; color:#FFF;"></em></a>
                    </li>
                    <%
  end if
  close(mmmYardimci1)
  %>
                  </ul>
                </div>
                <input name="sayfaadi" type="text" class="form-control" id="sayfaadi" value="<%=strisim%>">
                
                </div>
              </div>
            
            
            <div class="col-md-12 islevler">
              <div class="islevler1" style="padding-left:30px;">                

                <%if toplam4="0" then%>
                <%else%>
                <a href="<%=iceriklink%>" class="btn btn-warning dropdown-toggle btn-xs"><em class="fa fas fa-clone" style="font-size:11px;"></em> İçerikler</a>
                <%end if%>

                  <%if strid="835" then%>
                <%else%>
                <a href="galeri.asp?baslik=<%=strid%>&amp;dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" class="btn btn-default dropdown-toggle btn-xs"><em class="fa fa-camera" style="font-size:16px;"></em> Resim Ekle (<%=toplam6%>) </a>
                  <%end if %>    
                 <input name="sifreli" type="hidden" value="<%=strsifreli %>" />          

              <%if strdurum = "1" Then
                cbcdisstr="disabled"
				cbccheckstr="checked"
				 else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Durum",iks,cbcdisstr,cbccheckstr,"info"))%>
                
              <%                 		 
                  if yetkiuye="1" then
                  if strmenugosterim = "1" Then
              cbcdisstr="disabled"
			  cbccheckstr="checked"
			  else
			  cbcdisstr=""
			  cbccheckstr=""
			  end if
		response.Write(checkboxcreat("menugosterim","Silinmesin",iks,cbcdisstr,cbccheckstr,"success"))								
                else
                  %>
                 <input name="menugosterim" type="hidden" value="<%=strmenugosterim %>" />
                 <% end if %>
			  
              </div>
              </div>
               </div>
               
		<div class="col-md-1 col-xs-3">
            <div class="col-md-6 col-xs-6">
     
              </div>
              <div class="col-md-6 col-xs-6">
                 <%
              if silinmiyecekler="1" or strmenugosterim = "1" then		   
              else
              %>
                    <label>
                      <input type="checkbox" name="urunidsil" class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>">
                    </label>
      		  <%end if%>
                </div>
              </div>
              
          </div>
          </div>
        </div>
      </li>
  <%
  mmmGenel.MoveNext
  loop
  %>
  </ol>
    </div>
    <div style="clear:both;"></div>
    <div class="icerik1 icerik">
      <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit(); formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil&modulmu=1');">
      <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit(); formla16('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenle&modulmu=1');">
    </div>
    <SCRIPT LANGUAGE="JavaScript">


        function formla16(gelen16) {
            document.custlist16.action = gelen16;
            document.custlist16.submit();
        }
  //-->
  </SCRIPT>
    <div style="clear:both;"></div>

  </div>
</form>
    <%
end if
close(mmmGenel)
%>
<%
  if request("usayi")="" then
	KayitSayisi=200
	else
	KayitSayisi=request("usayi")
	end if
	
  git = Request.QueryString("git")
if git="" then
git=1
end if
if dkate2="" or dkate2=0 then
sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&" order by sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
else
  sqlString = "select * from yazilar where kategori='"&dkate2&"'"&modulmuagac&"  order by sira, id desc  limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
  end if
  set mmmYardimci2=con.execute("select count(id) as toplam5 from yazilar where kategori='"&dkate2&"'"&modulmuagac&"")
toplam5=mmmYardimci2("toplam5")
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
<%else
 linkbaslangic="?alt1="&request("alt1")&"&dkate2="&request("dkate2")&"&sek="&request("sek")&""%>
<form method="post" name="custlist2" id=Form2 action="<%=altsayfaekle%>" target="_self">
<div class="x_panel">
  <div>
  <div class="icerik1 icerik">
  <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit(); formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik&modulmu=1');">
      <div class="btn-group pull-right" style="margin-right:5px;">
  <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
    Kopyala  <span class="caret"></span>
  </button>
  <div class="dropdown-menu keep-inside-clicks-open dropdown-menu-right" style="padding:15px;">

    <div class="form-group">
      <label for="exampleDropdownFormEmail1">Kopyalanacak Kategori</label>
      
    <select name="kdkate2" class="form-control" id="kdkate" style="width:100%;">

   <% response.Write kategorimodullistesi %>

    </select>
    </div>
    <button type="submit" class="btn btn-warning" ONCLICK="this.form.submit();formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Kopyalaicerikt&modulmu=1');">Seçili Olanları Kopyala</button>

  </div>
</div>
  <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit(); formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenleicerikt&modulmu=1');">
</div>    
  </div>
  <div style="clear:both;"></div>
<div class="sortpage">
    <ol class="ui-sortable1 vertical">
    <%
Do While Not mmmGenel.EOF
iksss=iksss+1
stryid=mmmGenel("id")
stryilksayfa = mmmGenel("ilksayfa")
strydurum = mmmGenel("durum")
strykategori=mmmGenel("kategori")
strysifreli  =mmmGenel("sifreli")
%>
    <li class="ui-state-default">
      <%
      sqlString = "select id from kategoriyazi where instr(sol,'"&stryid&"')"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
blokk="danger"
else
blokk="warning"
end if
close(mmmYardimci) 

urunidd=mmmGenel("urunid")
          if urunidd="" or isNull(urunidd) then
          urunidd="1"
          end if
sqlString = "select * from resimd where baslik='"&stryid&"'  order by fid desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
resim=""
else
resim="<img src="""&dbuploadgaleri&""&mmmYardimci("resimid")&""" width=""190"" border=""0""><br />"
end if
close(mmmYardimci)
lojik4=con.execute("select count(fid) as toplam4 from resimd where baslik='"&stryid&"' ")
toplam4=lojik4("toplam4")
%>
      <input name="urunid" type="hidden" value="<%=stryid%>">
      <%if right(iksss,1)=1 or right(iksss,1)=3 or right(iksss,1)=5 or right(iksss,1)=7 or right(iksss,1)=9 then%>
      <%collor="1"%>
      <%else%>
      <%collor="2"%>
      <%end if%>
      <div class="icerik<%=collor%> icerik">
                      
            <div class="col-md-9 col-xs-7">
            <div class="col-md-12">
                 
            <div class="input-group" style="margin-bottom:0px;"> 
            <div class="input-group-btn">   
                 <div style="min-width:30px; font-size:initial;">
                     <span class="handle ui-sortable-handle">
                        <i class="fas fa-arrows-alt"></i>
                     </span>
              </div>
              </div>
            <div class="input-group-btn"> 
              <select name="sayfalama"  class="form-control" id="sayfalama" style="min-width:180px;">
                <option value="1"> Ana Sayfa </option>              
                <%response.Write replace(kategorimodullistesi,"value="""&strykategori&"""","value="""&strykategori&""" selected")%>
              </select>
    </div>
                 <input name="iceriktur" type="hidden" value="<%=urunidd %>" />
    
            <input name="icerikadi" type="text" class="form-control" id="icerikadi" value="<%=mmmGenel("yazib")%>" style="margin-top:1px;<%if instr(request("id"),stryid) and request("islem")="duzenleyazi" then%>border-color:#CC0000;<%else%><%end if%>">
            
    
           <div class="input-group-btn"> 
                        <%
sqlString = "SELECT * from kategori where id="&urunidd&" order by id"
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
%>
            <a href="<%=mmmYardimci("adresd")%>duzelt1=<%=mmmYardimci("id")%>&urunid=<%=stryid%>&baslik=<%=stryid%>&sek=<%=strykategori%>&dkate2=<%=strykategori%>" style="padding:7px 5px;" class="btn btn-<%=blokk%> dropdown-toggle btn-xs"><em class="fa fas fa-clone" style="font-size:11px;"></em></a>
            <%
end if
close(mmmYardimci)%>
</div>
<div class="input-group-btn"> 
<a href="galeri.asp?baslik=<%=stryid%>&dkate2=<%=dkate2%>&sek=<%=dkate2*1%>" style="padding:7px 5px;" class="btn btn-default dropdown-toggle btn-xs"><em class="fa fa-camera" style="font-size:16px;"></em> (<%=toplam4%>) </a>
</div>
            </div>
          </div>
        </div>

<div class="col-md-3 col-xs-5">

<div class="col-md-6 col-xs-8">
                <%=mmmGenel("gtarih")%>
              </div>
              <div class="col-md-4">  
                 <input name="sifreli" type="hidden" value="<%=strysifreli %>" />

          <div class="col-md-3"> 
           <%if strydurum = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onayi","Durum",iksss,cbcdisstr,cbccheckstr,"info"))%>
                        </div>
          <div class="col-md-3"> 
          <%if stryilksayfa = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("ilksayfa","Silinmesin",iksss,cbcdisstr,cbccheckstr,"success"))%>
                         </div>
          
        </div>
            
              <div class="col-md-2 col-xs-2">
                 <%
              if instr(silinmiyecekler,"s"&stryid) or stryilksayfa = "1" then		   
              else
              %>
                    <label>
                      <input type="checkbox" name="iceriksil" class="flatred" id="iceriksila<%=iksss%>" value="<%=stryid%>">
                    </label>
      		  <%end if%>
                </div>
              </div>
              
      </div>
  </li>
  <%mmmGenel.MoveNext
  loop
  %>
  </ol>
</div>
<div style="clear:both;"></div>
<div class="icerik1 icerik">
  <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit(); formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik&modulmu=1');">
  <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-success pull-right" ONCLICK="this.form.submit(); formla('<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Duzenleicerikt&modulmu=1');">
</div>
</div>
</form>
<SCRIPT LANGUAGE="JavaScript">

    function formla(gelen) {
        document.custlist2.action = gelen;
        document.custlist2.submit();
    }
  //-->
  </SCRIPT>
<div style="clear:both;"></div>
<%
end if
close(mmmGenel)
%>
</div>
<%call footer(1)%>
        <script>
                 $(document).on('click.bs.dropdown.data-api', '.dropdown-menu.keep-inside-clicks-open', function (e) {
  e.stopPropagation();
});
		
	var oldContainer;
$("ol.ui-sortable1").sortable({
  group: 'nested', 
  handle: 'i.fa-arrows-alt',  
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