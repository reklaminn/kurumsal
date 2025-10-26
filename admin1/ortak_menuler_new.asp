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
	
    
    yazidil="240"
	
	islem=Request.QueryString("islem")
if islem="menuekle" then
call menuekle
elseif islem="menuserbestekle" then
call menuserbestekle
elseif islem="menuelemanekle" then
call menuelemanekle
elseif islem="menuDuzenle" then
call menuDuzenle
elseif islem="menuSil" then
call menuSil
else
end if

sub menuSil


Con.Execute ("delete FROM menuler where id="&Request.QueryString("kateid")&" or anasek='"&Request.Form("urunidsil")&"'") 

session("hata1")="Menü Silindi"
session("hatam1")="red"
end sub

sub menuDuzenle
    
    serializedestr= request.Form("serializede")
    if Request("dil")="ar" or Request("dil")="cn" or Request("dil")="ru" or Request("dil")="az" then 
    serializedestr= MyOwnHTMLEncode(server.HTMLEncode(request.Form("serializede")))
    end if
   'response.Write serializedestr
    'response.End
                           if yetkiuye=1 then
    sqlmenugosteri=", menugosterim='"&request.Form("menusilme")&"'"
    end if
Con.execute("update menuler set durum='"&request.Form("menuonay")&"', isim='"&request.Form("menuname")&"', target='"&request.Form("ustseviye")&"', sifreli='"&request.Form("menutipi")&"'"&sqlmenugosteri&", menujson='"&serializedestr&"', lang='"&request.Form("dil")&"' where id="&request.Form("anamenuid")&"")
    Con.Execute ("delete FROM menuler where alt='"&Request.Form("anamenuid")&"' and (alt<>'1' or alt<>'0')") 
    menujson=serializedestr

           
session("hata1")="Menü Düzenlendi"
session("hatam1")="green"

Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

sub menuDuzenle1
For i = 1 To Request.Form("isim").Count
    toplu=request.Form("toplu["&i&"]")
Set mmmYardimci=Con.execute("update menuler set durum='"&request.Form("onay")(i)&"',isim='"&request.Form("isim")(i)&"',seolink='"&request.Form("seolink")(i)&"',sira='"&i&"',sira1='"&toplu&"' where id="&request.Form("urunid")(i)&"")
    
next
session("hata1")="Menü Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

sub menuekle

    if request.Form("kateid")="" then
    qryek=""
    else
    kateid=giriskont(request.Form("kateid"))
sqlString = "SELECT * from menuler where id = '"&kateid&"'"
set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        kateid="99999"
        else
        kateid=mmmYardimci("id")
        kateisim=mmmYardimci("isim")
        strmenuustseviye=mmmYardimci("target")
        strsira=mmmYardimci("sira")
        strmenutipi=mmmYardimci("sifreli")
        strmenudil=mmmYardimci("lang")

        strmenugosterim=mmmYardimci("menugosterim")
        menujson=mmmYardimci("menujson")
    if menujson="" or isNull(menujson) then
    menujson="[[ ]]"
    end if
        menuonay=mmmYardimci("durum")
        end if
        close(mmmYardimci)
    qryek=", sira='3', target='"&strmenuustseviye&"', sifreli='"&strmenutipi&"', menugosterim='"&strmenugosterim&"', menujson='"&menujson&"'"
    end if

Con.execute("insert menuler set isim='"&request.Form("sektor")&"',lang='"&request.Form("dil")&"',alt='1', durum='1', sira1='m', anasek='1'"&qryek&"")

session("hata1")="Menü Eklendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")

end sub

sub menuserbestekle
    
Con.execute("update menuler set sira='0' where id="&request.Form("anamenuid")&"")

Con.execute("insert menuler set isim='"&request.Form("menuname")&"',alt='"&request.Form("anamenuid")&"', durum='1', sira1='m', anasek='"&request.Form("anamenuid")&"'")

session("hata1")="Menü Eklendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")

    end sub

sub menuelemanekle
    Con.execute("update menuler set sira='0' where id="&request.Form("anamenuid")&"")
    for mic=1 to request.Form("menuid").count
    if instr(request.Form("menuid")(mic),"][") then
    micmenuid=split(request.Form("menuid")(mic),"][")(0)
    micmenuisim=split(request.Form("menuid")(mic),"][")(1)
    micmenulink=split(request.Form("menuid")(mic),"][")(2)
    end if
Con.execute("insert menuler set isim='"&micmenuisim&"', link='"&micmenulink&"', alt='"&request.Form("anamenuid")&"', durum='1', sira1='m', anasek='"&request.Form("anamenuid")&"', target='"&micmenuid&"', lang='tr'")
    next
session("hata1")="Menü Eklendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")

    end sub


sub menuelemanekle1

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
if request.Form("toplu")="m" then
if bagliid="0" then
sonmenuid=request.Form("menudurum")
else
Con.execute("insert menuler set isim='"&request.Form("sektor")&"',alt='"&altt&"',durum='1',sira1='m',anasek='"&request.Form("menudurum")&"',bagli='"&request.Form("durum1")&"'")
sqlString = "SELECT * from menuler order by id desc"
set mmmYardimci = Con.Execute (sqlString)
sonmenuid=mmmYardimci("id")
close(mmmYardimci)
end if
if baglitur="k" then
if bagliid="0" then
sqlString = "SELECT * from kategoriyazi where alt = '1' order by sira"
else
sqlString = "SELECT * from kategoriyazi where anasek = '"&bagliid&"' order by sira"
end if
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
Do While Not mmmYardimci3.EOF
Con.execute("insert menuler set isim='"&request.Form("sektor")&"',alt='"&altt&"',durum='1',sira1='m',anasek='"&sonmenuid&"',bagli='k"&mmmYardimci3("id")&"'")

mmmYardimci3.MoveNext
loop  
end if
close(mmmYardimci3)
elseif baglitur="s" then
if bagliid="0" then
sqlString = "SELECT * from store_kategoriurun where alt = '1' order by sira"
else
sqlString = "SELECT * from store_kategoriurun where anasek = '"&bagliid&"' order by sira"
end if
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
Do While Not mmmYardimci3.EOF
Con.execute("insert menuler set isim='"&request.Form("sektor")&"',alt='"&altt&"',durum='1',sira1='m',anasek='"&sonmenuid&"',bagli='s"&mmmYardimci3("id")&"'")
mmmYardimci3.MoveNext
loop  
end if
close(mmmYardimci3)
elseif baglitur="h" then

else

end if

elseif request.Form("toplu")="d" then
Set mmmYardimci1=Con.execute("insert menuler set isim='"&request.Form("sektor")&"',alt='"&altt&"',durum='1',anasek='"&request.Form("menudurum")&"',bagli='"&request.Form("durum1")&"',sira1='d'")
else
Set mmmYardimci1=Con.execute("insert menuler set isim='"&request.Form("sektor")&"',alt='"&altt&"',durum='1',anasek='"&request.Form("menudurum")&"',bagli='"&request.Form("durum1")&"'")
end if

session("hata1")="Menü Eklendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")

end sub
    
    sub menuli(rowii,strid,stronay,strtoplu,menuisimana,menuseolinkana,menubagliana,deep1)    
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
          strtoplu="n"
          toplun=" selected"
          topluda=""
          toplum=""
          end if
    %>
    <li id="menuy<%=rowii%>" data-id="<%=strid%>" data-onay="<%=stronay%>" data-toplu="<%=strtoplu%>" data-name="<%=menuisimana%>" data-seolink="<%=menuseolinkana%>" data-bagli="<%=menubagliana%>">
          <div class="panel panel-default">
              <div class="panel-heading active" role="tab" id="heading<%=rowii %>">
                  <h4 class="panel-title">
                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rowii %>" aria-expanded="true" aria-controls="collapse<%=rowii %>">
                          <span class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></span><%=menuisimana%> <span class=" btn btn-xs btn-danger pull-right" onclick="divremove('menuy<%=rowii%>');"><i class="fa fa-trash"></i></span>
                      </a>
                  </h4>
              </div>
              <div id="collapse<%=rowii %>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=rowii %>">
                  <div class="panel-body">
                      <table class="table table-striped" style="margin-bottom: 0px;">

                          <tr>
                              <td>
                                  <input name="name" type="text" id="name" value="<%=menuisimana%>" onkeyup="updateserializesubmit('name', 'menuy<%=rowii%>');" class="form-control">
                                  <input name="urunid" type="hidden" id="urunid" value="<%=strid%>" /></td>
                              <td>
                                  <select name="toplu" onchange="updateserializesubmit('toplu', 'menuy<%=rowii%>');" id="toplu" class="form-control">
                                      <option value="n" <%=toplun %>>Serbest Eklenen </option>
                                      <option value="d" <%=topluda %>>Alt Kategoriler Dinamik Ekle </option>
                                      <option value="m" <%=toplum %>>Alt Kategoriler Manuel Ekle </option>
                                  </select>
                              </td>
                              <td>
                                  <%if menuseolinkana="" or menuseolinkana="#" or strtoplu="n" then %>                                  
                                  <input name="seolink" type="text" id="seolink" onkeyup="updateserializesubmit('seolink', 'menuy<%=rowii%>');" style="float: left;" class="form-control" value="<%=menuseolinkana%>" placeholder="İsteğe Bağlı Link">
                                  <%else %>
                                  <input name="seolink" type="hidden" id="seolink" value="<%=menuseolinkana%>" />
                                  <%end if %>
                              </td>
                              <td align="center" style="width: 25px;">
                                  <%if stronay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if%>
                                  <input name="onay" id="onay" type="checkbox" onclick="updateserializesubmit('onay', 'menuy<%=rowii%>');" class="flatgreen1" value="1" <%=cbccheckstr%> />
                              </td>

                          </tr>
                      </table>
                  </div>
              </div>
          </div>
          <ol>
              <%if strtoplu="d" then %>
              <li>
          <div class="panel panel-default">
              <div class="panel-heading active" role="tab" id="heading<%=rowii %>">
                  <h4 class="panel-title">Dinamik Yeni Eklenen Menüler Eklenecektir.</h4></div></div></li>
              <%end if %>
              <%  
                  if isObject(cols) then
                  set colssub = cols(colii)("children")(0)
            for each coliisub in colssub
    if colssub.count>=1 then
                                                strid=colssub(coliisub)("id")
            strtoplu=colssub(coliisub)("sira1")
            stronay=colssub(coliisub)("onay")
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
          strtoplu="n"
          toplun=" selected"
          topluda=""
          toplum=""
          end if
            menubagliana=colssub(coliisub)("bagli")
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
                   if  strsira="2" then
                                                                        if menubaglianat="t" then
                                                                        sayfaturu="turlar"
                                    if strmenudil="240" or strmenudil="" then
menuisimana=menuvericek(vdb,menubagliana,dbtkategoritur,"isim","id = '"&menubaglianaid&"'","isim")
                                    else
menuisimana=menuvericek(vdb,menubagliana,dbtdilleracenta,"kate","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","kate")
menubaglianaid=menuvericek(vdb,menubagliana,dbtdilleracenta,"id","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","id")
                                    end if
                                    elseif menubaglianat="e" then
menuisimana=menuvericek(vdb,menubagliana,dbskategoriurun,"isim","id = '"&menubaglianaid&"'","isim")
                                    elseif menubaglianat="k" then
menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","isim")                  
              sayfaturu="sayfa"
                                    elseif menubaglianat="y" then
menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","yazib") 
              sayfaturu="yazi"
                                    else
                                    menuisimana=menuisimana1
                                    end if
              menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if

                                    else
            menuseolinkana1=colssub(coliisub)("seolink")
            menuisimana1=colssub(coliisub)("name")
          'response.Write sqlString
                  
                                    if menubaglianat="t" then
                                    sayfaturu="turlar"
                                    if strmenudil="240" or strmenudil="" then
menuisimana=menuvericek(vdb,menubagliana,dbtkategoritur,"isim","id = '"&menubaglianaid&"'","isim")
                                    else
menuisimana=menuvericek(vdb,menubagliana,dbtdilleracenta,"kate","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","kate")
menubaglianaid=menuvericek(vdb,menubagliana,dbtdilleracenta,"id","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","id")
                                    end if
                                    elseif menubaglianat="e" then
menuisimana=menuvericek(vdb,menubagliana,dbskategoriurun,"isim","id = '"&menubaglianaid&"'","isim")
                                    elseif menubaglianat="k" then
menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","(id = '"&menubaglianaid&"' or bagli = '"&menubaglianaid&"') and dil='"&strmenudil&"'","isim")     
'menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","id = '"&menubaglianaid&"'","isim")        
              sayfaturu="sayfa"
                                    elseif menubaglianat="y" then
menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","(id = '"&menubaglianaid&"' or bagli = '"&menubaglianaid&"') and dil='"&strmenudil&"'","yazib") 
'menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","yazib") 
              sayfaturu="yazi"
                                    else
                                    menuisimana=menuisimana1
                                    end if
menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if
              end if
                  %>
              <li id="menuy<%=rowii%><%=coliisub%>" data-id="<%=strid%>" data-onay="<%=stronay%>" data-toplu="<%=strtoplu%>" data-name="<%=menuisimana%>" data-seolink="<%=menuseolinkana%>" data-bagli="<%=menubagliana%>">
          <div class="panel panel-default">
              <div class="panel-heading active" role="tab" id="heading<%=rowii %><%=coliisub%>">
                  <h4 class="panel-title">
                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rowii %><%=coliisub%>" aria-expanded="true" aria-controls="collapse<%=rowii %><%=coliisub%>">
                          <span class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></span><%=menuisimana%> <span class=" btn btn-xs btn-danger pull-right" onclick="divremove('menuy<%=rowii%><%=coliisub%>');"><i class="fa fa-trash"></i></span>
                      </a>
                  </h4>
              </div>
              <div id="collapse<%=rowii %><%=coliisub%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=rowii %><%=coliisub%>">
                  <div class="panel-body">
                      <table class="table table-striped" style="margin-bottom: 0px;">

                          <tr>
                              <td>
                                  <input name="name" type="text" id="name" value="<%=menuisimana%>" onkeyup="updateserializesubmit('name', 'menuy<%=rowii%><%=coliisub%>');" class="form-control">
                                  <input name="urunid" type="hidden" id="urunid" value="<%=strid%>" /></td>
                              <td>
                                  <select name="toplu" onchange="updateserializesubmit('toplu', 'menuy<%=rowii%><%=coliisub%>');" id="toplu" class="form-control">
                                      <option value="n" <%=toplun %>>Serbest Eklenen </option>
                                      <option value="d" <%=topluda %>>Alt Kategoriler Dinamik Ekle </option>
                                      <option value="m" <%=toplum %>>Alt Kategoriler Manuel Ekle </option>
                                  </select>
                              </td>
                              <td>
                                  <%if menuseolinkana="" or menuseolinkana="#" or strtoplu="n" then %>
                                  <input name="seolink" type="text" id="seolink" onkeyup="updateserializesubmit('seolink', 'menuy<%=rowii%><%=coliisub%>');" style="float: left;" class="form-control" value="<%=menuseolinkana%>" placeholder="İsteğe Bağlı Link">
                                  <%else %>
                                  <input name="seolink" type="hidden" id="seolink" value="<%=replace(menuseolinkana,"/","")%>" />
                                  <%end if %>
                              </td>
                              <td align="center" style="width: 25px;">
                                  <%if stronay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if%>
                                  <input name="onay" id="onay" type="checkbox" onclick="updateserializesubmit('onay', 'menuy<%=rowii%><%=coliisub%>');" class="flatgreen1" value="1" <%=cbccheckstr%> />
                              </td>

                          </tr>
                      </table>
                  </div>
              </div>
          </div>
          <ol> </ol>
      </li>
              <%              end if    
                                    next
              'call menuli(rowii&colii,strid,stronay,strtoplu,menuisimana,menuseolinkana,menubagliana,deep1)
                  else
      sqlString = "SELECT * from menuler where anasek = '"&strid&"' order by id"
set mmmYardimci3 = Con.Execute (sqlString)
             
Do While Not mmmYardimci3.EOF                               
colii=colii+1

            strid=mmmYardimci3("id")
            menubagliana=mmmYardimci3("target")
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
            menuseolinkana1=mmmYardimci3("link")
            menuisimana1=mmmYardimci3("isim")
            strtoplu=mmmYardimci3("sira1")
            stronay=mmmYardimci3("durum")
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
          strtoplu="n"
          toplun=" selected"
          topluda=""
          toplum=""
          end if
          'response.Write sqlString
                  
                                    if menubaglianat="t" then
                                    sayfaturu="turlar"
                                    if strmenudil="240" or strmenudil="" then
menuisimana=menuvericek(vdb,menubagliana,dbtkategoritur,"isim","id = '"&menubaglianaid&"'","isim")
                                    else
menuisimana=menuvericek(vdb,menubagliana,dbtdilleracenta,"kate","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","kate")
menubaglianaid=menuvericek(vdb,menubagliana,dbtdilleracenta,"id","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","id")
                                    end if
                                    elseif menubaglianat="e" then
menuisimana=menuvericek(vdb,menubagliana,dbskategoriurun,"isim","id = '"&menubaglianaid&"'","isim")
                                    elseif menubaglianat="k" then
menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","id = '"&menubaglianaid&"'","isim")             
              sayfaturu="sayfa"
                                    elseif menubaglianat="y" then
menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","yazib") 
              sayfaturu="yazi"
                                    else
                                    menuisimana=menuisimana1
                                    end if
menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if
                  %>
              <li id="menuy<%=rowii%><%=coliisub%>" data-id="<%=strid%>" data-onay="<%=stronay%>" data-toplu="<%=strtoplu%>" data-name="<%=menuisimana%>" data-seolink="<%=menuseolinkana%>" data-bagli="<%=menubagliana%>">
          <div class="panel panel-default">
              <div class="panel-heading active" role="tab" id="heading<%=rowii %><%=coliisub%>">
                  <h4 class="panel-title">
                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rowii %><%=coliisub%>" aria-expanded="true" aria-controls="collapse<%=rowii %><%=coliisub%>">
                          <span class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></span><%=menuisimana%> <span class=" btn btn-xs btn-danger pull-right" onclick="divremove('menuy<%=rowii%><%=coliisub%>');"><i class="fa fa-trash"></i></span>
                      </a>
                  </h4>
              </div>
              <div id="collapse<%=rowii %><%=coliisub%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=rowii %><%=coliisub%>">
                  <div class="panel-body">
                      <table class="table table-striped" style="margin-bottom: 0px;">

                          <tr>
                              <td>
                                  <input name="name" type="text" id="name" value="<%=menuisimana%>" onkeyup="updateserializesubmit('name', 'menuy<%=rowii%><%=coliisub%>');" class="form-control">
                                  <input name="urunid" type="hidden" id="urunid" value="<%=strid%>" /></td>
                              <td>
                                  <select name="toplu" onchange="updateserializesubmit('toplu', 'menuy<%=rowii%><%=coliisub%>');" id="toplu" class="form-control">
                                      <option value="n" <%=toplun %>>Serbest Eklenen </option>
                                      <option value="d" <%=topluda %>>Alt Kategoriler Dinamik Ekle </option>
                                      <option value="m" <%=toplum %>>Alt Kategoriler Manuel Ekle </option>
                                  </select>
                              </td>
                              <td>
                                  <%if menuseolinkana="" or menuseolinkana="#" or strtoplu="n" then %>
                                  <input name="seolink" type="text" id="seolink" onkeyup="updateserializesubmit('seolink', 'menuy<%=rowii%><%=coliisub%>');" style="float: left;" class="form-control" value="<%=menuseolinkana%>" placeholder="İsteğe Bağlı Link">
                                  <%else %>
                                  <input name="seolink" type="hidden" id="seolink" value="<%=replace(menuseolinkana,"/","")%>" />
                                  <%end if %>
                              </td>
                              <td align="center" style="width: 25px;">
                                  <%if stronay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if%>
                                  <input name="onay" id="onay" type="checkbox" onclick="updateserializesubmit('onay', 'menuy<%=rowii%><%=coliisub%>');" class="flatgreen1" value="1" <%=cbccheckstr%> />
                              </td>

                          </tr>
                      </table>
                  </div>
              </div>
          </div>
          <ol>
              <%
               sqlString = "SELECT * from menuler where anasek = '"&strid&"' order by id"
set mmmYardimci2 = Con.Execute (sqlString)
             
Do While Not mmmYardimci2.EOF                               
coliii=coliii+1

            strid=mmmYardimci2("id")
            menubagliana=mmmYardimci2("target")
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
            menuseolinkana1=mmmYardimci2("link")
            menuisimana1=mmmYardimci2("isim")
            strtoplu=mmmYardimci2("sira1")
            stronay=mmmYardimci2("durum")
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
          strtoplu="n"
          toplun=" selected"
          topluda=""
          toplum=""
          end if
          'response.Write sqlString
                  
                                    if menubaglianat="t" then
                                    sayfaturu="turlar"
                                    if strmenudil="240" or strmenudil="" then
menuisimana=menuvericek(vdb,menubagliana,dbtkategoritur,"isim","id = '"&menubaglianaid&"'","isim")
                                    else
menuisimana=menuvericek(vdb,menubagliana,dbtdilleracenta,"kate","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","kate")
menubaglianaid=menuvericek(vdb,menubagliana,dbtdilleracenta,"id","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","id")
                                    end if
                                    elseif menubaglianat="e" then
menuisimana=menuvericek(vdb,menubagliana,dbskategoriurun,"isim","id = '"&menubaglianaid&"'","isim")
                                    elseif menubaglianat="k" then
menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","id = '"&menubaglianaid&"'","isim")             
              sayfaturu="sayfa"
                                    elseif menubaglianat="y" then
menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","yazib") 
              sayfaturu="yazi"
                                    else
                                    menuisimana=menuisimana1
                                    end if
menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if
                  %>
              <li id="menuy<%=rowii%><%=colii%>" data-id="<%=strid%>" data-onay="<%=stronay%>" data-toplu="<%=strtoplu%>" data-name="<%=menuisimana%>" data-seolink="<%=menuseolinkana%>" data-bagli="<%=menubagliana%>">
          <div class="panel panel-default">
              <div class="panel-heading active" role="tab" id="heading<%=rowii %><%=colii%>">
                  <h4 class="panel-title">
                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rowii %><%=colii%>" aria-expanded="true" aria-controls="collapse<%=rowii %><%=colii%>">
                          <span class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></span><%=menuisimana%> <span class=" btn btn-xs btn-danger pull-right" onclick="divremove('menuy<%=rowii%><%=colii%>');"><i class="fa fa-trash"></i></span>
                      </a>
                  </h4>
              </div>
              <div id="collapse<%=rowii %><%=colii%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=rowii %><%=colii%>">
                  <div class="panel-body">
                      <table class="table table-striped" style="margin-bottom: 0px;">

                          <tr>
                              <td>
                                  <input name="name" type="text" id="name" value="<%=menuisimana%>" onkeyup="updateserializesubmit('name', 'menuy<%=rowii%><%=colii%>');" class="form-control">
                                  <input name="urunid" type="hidden" id="urunid" value="<%=strid%>" /></td>
                              <td>
                                  <select name="toplu" onchange="updateserializesubmit('toplu', 'menuy<%=rowii%><%=colii%>');" id="toplu" class="form-control">
                                      <option value="n" <%=toplun %>>Serbest Eklenen </option>
                                      <option value="d" <%=topluda %>>Alt Kategoriler Dinamik Ekle </option>
                                      <option value="m" <%=toplum %>>Alt Kategoriler Manuel Ekle </option>
                                  </select>
                              </td>
                              <td>
                                  <%if menuseolinkana="" or menuseolinkana="#" or strtoplu="n" then %>
                                  <input name="seolink" type="text" id="seolink" onkeyup="updateserializesubmit('seolink', 'menuy<%=rowii%><%=colii%>');" style="float: left;" class="form-control" value="<%=menuseolinkana%>" placeholder="İsteğe Bağlı Link">
                                  <%else %>
                                  <input name="seolink" type="hidden" id="seolink" value="<%=menuseolinkana%>" />
                                  <%end if %>
                              </td>
                              <td align="center" style="width: 25px;">
                                  <%if stronay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if%>
                                  <input name="onay" id="onay" type="checkbox" onclick="updateserializesubmit('onay', 'menuy<%=rowii%><%=colii%>');" class="flatgreen1" value="1" <%=cbccheckstr%> />
                              </td>

                          </tr>
                      </table>
                  </div>
              </div>
          </div>
          <ol> </ol>
      </li>
              <%
                  mmmYardimci2.MoveNext
                  Loop
                  close(mmmYardimci2)
%>
          </ol>
      </li>
              <%
                  mmmYardimci3.MoveNext
                  Loop
                  close(mmmYardimci3)
              end if
                  %>
          </ol>
      </li>
<%
    end sub
if kateid="" or kateid="0" then
sqlString = "SELECT * from menuler where alt = '1' order by id desc limit 1"
        else
sqlString = "SELECT * from menuler where id = '"&kateid&"'"
end if
set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        kateid="99999"
    strsira="3"
        else
        kateid=mmmYardimci("id")
        kateisim=mmmYardimci("isim")
        strmenuustseviye=mmmYardimci("target")
        strsira=mmmYardimci("sira")
        strmenutipi=mmmYardimci("sifreli")
        strmenudil=mmmYardimci("lang")
        strmenudil1=strmenudil
    sqlString = "select * from diller1 where ceviricode='"&strmenudil&"'"
set mmmGenel = Con.Execute (sqlString)
    if mmmGenel.eof then
    strmenudil="240"
    else
    strmenudil=mmmGenel("id")
    end if
    close(mmmGenel)
        strmenugosterim=mmmYardimci("menugosterim")
        menujson=mmmYardimci("menujson")
    if menujson="" or isNull(menujson) then
    menujson="[[ ]]"
    end if
        menuonay=mmmYardimci("durum")
        end if
        close(mmmYardimci)
%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>
<style>

#menu-source ol, #menu-target ol {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    #menu-source li, #menu-target li {
        background: white;
        border: 1px solid #ddd;
        display: flex;
        flex-direction: column;
    }
 /* Sol ve sağ menülerin yan yana düzgün görünmesi için */
#menu-source, #menu-target {
display: flex;
flex-direction: column;
gap: 10px;
        padding: 0;
        margin: 0;
}

/* Genel panel stili */
#menu-source .panel, #menu-target .panel {
align-items: center;
justify-content: space-between;
min-width: 300px;
margin-bottom:0px;
}

/* Ana menü elemanları sola hizalanır */
#menu-source li, #menu-target li[data-id]  {
margin-left: 0px; /* Ana menü düz hizalı */
padding:5px;
}

/* Alt menüler içe doğru kaydırılır */
#menu-source li[data-id] ol li, #menu-target li[data-id] ol li {
margin-left: 20px; /* 1. seviye alt menü */
margin-bottom:3px;
}

#menu-source li[data-id] ol li ol li, #menu-target li[data-id] ol li ol li {
margin-left: 40px; /* 2. seviye alt menü */
margin-bottom:3px;
}

#menu-source li[data-id] ol li ol li ol li, #menu-target li[data-id] ol li ol li ol li  {
margin-left: 60px; /* 3. seviye alt menü */
margin-bottom:3px;
}

/* Panel başlıkları (sadece ana menü için düz hizalı) */
#menu-source .panel-heading, #menu-target .panel-heading {
cursor: pointer;
padding: 3px;
display: flex;
justify-content: space-between;
align-items: center;
}

/* Handle (Sürükleme İkonu) */
#menu-source .handle, #menu-target .handle {
cursor: grab;
margin-right: 10px;
}

/* Menü başlığı (text hizalaması) */
#menu-source .panel-heading span, #menu-target .panel-heading span {
flex-grow: 1;
text-align: left;
}

/* İkonların hizalanması */
#menu-source .panel-heading i, #menu-target .panel-heading i {
margin-left: 8px;
cursor: pointer;
}

#menu-source .panel-heading i i, #menu-target .panel-heading i i, #menu-source .panel-heading button i, #menu-target .panel-heading button i {
margin-left: 0px;
}
/* Sil butonu sağda dursun */
#menu-source  .delete-btn, #menu-target .delete-btn {
background-color: #dc3545;
border: none;
color: white;
margin-left: 8px;
padding: 5px;
border-radius: 3px;
cursor: pointer;
}

#menu-source .panel-body, #menu-target .panel-body {
        display: none;
        padding: 10px;
    }
    #menu-source .panel-body input, #menu-target .panel-body input, #menu-source .panel-body select, #menu-target .panel-body select {
        width: 100%;
        margin-bottom: 5px;
    }
    .delete-btn:hover {
        background: darkred;
    }

    /* Seçilen öğeye özel stil */
    #menu-source .sortable-chosen, #menu-target .sortable-chosen {
opacity: 0.5;
background-color: #f0f0f0;
}

/* Placeholder (Boş Yer Tutucu) */
#menu-source .sortable-ghost, #menu-target .sortable-ghost {
background: rgba(0, 0, 255, 0.2);
border: 2px dashed blue;
height: 40px;
list-style: none;
}

#menu-source .add-menu-btn, #menu-target .add-menu-btn {
display: block;
margin: 10px auto;
padding: 10px 15px;
background: #28a745;
color: white;
border: none;
cursor: pointer;
border-radius: 5px;
}

#menu-source .add-menu-btn:hover, #menu-target .add-menu-btn:hover {
background: #218838;
}

#menu-source .fa-edit, #menu-source .delete-btn{display:none;}
</style>
<div class="right_col" role="main">
    <div class="x_panel">
        <div class="x_title">
            <h2>Menüler</h2>
            <div class="clearfix"></div>
        </div>
        <div style="clear: left;"></div>
        <div class="accordion" id="accordion1" role="tablist" aria-multiselectable="true">
            <div class="panel">
                <form name="form1" method="post" action="?filtret=menu">
                    <div class="col-md-7">
                        <div class="input-group input-group-sm">
                            <div class="input-group-btn">
                                <button name="submit2" type="button" class="btn btn-default">Düzenlemek için bir menü seçin:</button>>
                            </div>
                            <select name="kateid" class="form-control" id="durum2">
                                <%
sqlString = "SELECT * from menuler where alt = '1' order by isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                                %>
                                <option value="<%=mmmYardimci("id")%>" <% if mmmYardimci("id")=int(kateid) then%> selected="selected" <%else%> <%end if%>><%=mmmYardimci("isim")%></option>
                                <%
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                            </select>
                            <div class="input-group-btn">
                                <button name="submit2" type="submit" class="btn btn-success">Seç</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="input-group input-group-sm">
                            veya <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapsesecekle" aria-expanded="true" aria-controls="collapsesecekle">yeni menü oluştur.</a> Değişiklikleri kayıt etmeyi unutmayın!
                        </div>
                    </div>
                </form>
                <div class="clearfix"></div>

                <div id="collapsesecekle" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingsecekle">
                    <div class="panel-body">
                        <form name="form1" method="post" action="?islem=menuekle&filtret=menu&kateid=<%=kateid %>">
                            <div class="input-group input-group-sm">
                                <div class="input-group-btn">
                                    <button name="submit2" type="button" class="btn btn-default">Menü İsim</button>
                                </div>
                                <div class="input-group-btn">
                            <select name="kateid" class="form-control" id="durum2" style="width:100px;">
                                <option value="">Yeni</option>
                                <%
sqlString = "SELECT * from menuler where alt = '1' order by isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                                %>
                                <option value="<%=mmmYardimci("id")%>"><%=mmmYardimci("isim")%> Kopyası</option>
                                <%
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                            </select>
                                    </div>
                                <div class="input-group-btn">                                    
                                  <select name="dil" id="dil" class="form-control" style="width:100px;">
                                                    <%
sqlString = "select * from diller1 where alt = '1' and (sira='1' or nott='1') ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("ceviricode")%>"  <% if mmmGenel("ceviricode")&""=strmenudil1&"" then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
                                  </select>
                                </div>
                                <input name="sektor" type="text" id="sektor" class="form-control">
                                <div class="input-group-btn">
                                    <button name="submit2" type="submit" class="btn btn-success pull-right">Ekle</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <h2>Menü Öğeleri Ekle</h2>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <button onclick="addNewMenuItem()" class="add-menu-btn">Serbest Ekle</button>
                </div>
                <button onclick="toggleAllVisibleSubMenus('menu-source')" type="button" class="btn btn-warning toggle-source-btn">Mevcut Menü Aç/Kapat</button>
                <ol id="menu-source"></ol>
                <%
                sourcemenujson= kategoriyazilistejson("1","{ ""bagli"": ""k/*/#kylid#][#kylisim#][#kyllink#"", ""seolink"": ""#kyllink#"", ""name"": ""#kylisim#"", ""toplu"": ""n"", ""onay"": 1, ""id"": ""k/*/#kylid#"", ""children"":  [#kylsub#]  }"," and durum='1' and modulmu='0'"&sayfagosterme,strmenudil) 
                
                if instr(sistem_site_turu,"*cicek*") then
                 response.Write cicekkategoriliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""c/*/#kylid#"" value=""c/*/#kylid#][#kylisim#""> #kylisim#</label>#kylsub(,,,,"&sayfagosterme&", style='margin-left:10px;')#</li>","","",sayfagosterme,strmenudil) 
                end if 
                
                if instr(sistem_site_turu,"*tur*") then        
                            'limanlar
                            'turkategorileri
                            sourcemenujson= sourcemenujson&","&turdestinasyonlistejson("1","{ ""bagli"": ""t/*/#kylid#][#kylisim#][#kyllink#"", ""seolink"": ""#kyllink#"", ""name"": ""#kylisim#"", ""toplu"": ""n"", ""onay"": 1, ""id"": ""t/*/#kylid#"", ""children"":  [#kylsub#]  }"," and onay='1' and id<>'2580'",strmenudil) 
                            'gemifirmalari                           
                            sourcemenujson= sourcemenujson&", { ""bagli"": ""k/*/1108][Gemi Şirketleri][gemi-firmalari.html"", ""seolink"": ""gemi-firmalari.html"", ""name"": ""Gemi Firmaları"", ""toplu"": ""n"", ""onay"": 1, ""id"": ""k/*/1108"", ""children"": ["&shiplistejson("1","{ ""bagli"": ""g/*/#kylid#][#kylisim#][#kyllink#"", ""seolink"": ""#kyllink#"", ""name"": ""#kylisim#"", ""toplu"": ""n"", ""onay"": 1, ""id"": ""g/*/#kylid#"", ""children"":  [#kylsub#]  }"," and ustmenu='1'",strmenudil)&"] }"
                end if 
                
                if instr(sistem_site_turu,"*eticaret*") then%>
                    
                                <% response.Write eticaretkategoriliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""e/*/#kylid#/*/#kyllink#"" value=""e/*/#kylid#][#kylisim#][#kyllink#""> #kylisim#</label>#kylsub{(,,,,"&sayfagosterme&", style='margin-left:10px;')}#</li>","","",sayfagosterme,"")
                                    %>
                    <%end if %>
               
            </div>
        </div>
        <div class="col-md-8">
            <h2>Menü Yapısı</h2>
            <form method="post" name="custlist" id="Form1" action="?usayi=<%=request("usayi")%>&altkate=<%=altkate%>&islem=kap&filtremi=<%=request("filtremi")%>&sira=<%=request("sira")%>&kateid=<%=request("kateid")%>&git=<%=request("git")%>" target="_self">

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <div class="input-group input-group-sm">
                                <div class="input-group-btn">
                                    <button name="submit2" type="button" class="btn btn-default">Menü ismi</button>
                                </div>
                                <div class="input-group-btn">                             
                          <%if menuonay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("menuonay","Menu Yayınlansın",iks,cbcdisstr,cbccheckstr,"success"))%>
                                </div>
                                <input name="anamenuid" type="hidden" value="<%=kateid%>">
                                <input type="text" name="menuname" class="form-control" value="<%=kateisim %>" />
                                <div class="input-group-addon">
                                    <%=kateid %>
                                    </div>
                                <div class="input-group-btn">
                                    <button name="submit2" type="submit" class="btn btn-primary pull-right" onclick="this.form.submit(); formla('?islem=menuDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');">Menüyü Kaydet</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <p>Her ögeyi tercih ettiğiniz sıraya taşıyın. Ögenin sağında yer alan ok tuşuna basarak daha fazla seçenek ortaya çıkartabilirsiniz.</p>
                        <div class="input-group-btn">
<button onclick="toggleAllVisibleSubMenus('menu-target')" type="button" class=" btn btn-warning toggle-target-btn pull-right">Oluşturulan Menü Aç/Kapat</button>
</div>
                        <div class="sortpage">
                            <ol id="menu-target"></ol>
                            <input name="serializede" type="hidden" value="" id="jsonOutput" />
                        </div>
                        <hr />
                        <h2>Menü Ayarları</h2> 
                            <%if yetkiuye=1 then%>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">
                                <input type="checkbox" name="ustseviye" class="flatgreen" id="ustseviye" <%if strmenuustseviye="1" then %>checked<% end if%> value="1" />
                            </div>
                            <label for="ustseviye" class="btn btn-default" style="margin: 0;">Üst seviye sayfaları bu menüye otomatik olarak ekle</label>
                        </div>
                        <%else %>
                            <input name="ustseviye" type="hidden" value="<%if strmenuustseviye="1" then %>1<%else %>0<% end if%>" />
                        <%end if %>
                        <div class="row">
                        <div class="col-md-6">
                        <div class="input-group">
                            <div class="input-group-btn">
                            <label for="menutipi" class="btn btn-default" style="margin: 0;">Menü Tipi</label>
                            </div>
                                  <select name="menutipi" id="menutipi" class="form-control">
                                      <option value="" <%if strmenutipi="" then%>selected<%end if %> >Menü Tipi Seçiniz </option>
                                      <option value="ust" <%if strmenutipi="ust" then%>selected<%end if %> >Üst menü </option>
                                      <option value="mobil" <%if strmenutipi="mobil" then%>selected<%end if %>>Mobil Menü (Her Temada Çalışmayabilir) </option>
                                      <option value="alt" <%if strmenutipi="alt" then%>selected<%end if %>>Alt Menü </option>
                                  </select>
                        </div>
                        </div>
                            
                        <div class="col-md-6">
                        <div class="input-group">
                            <div class="input-group-btn">
                            <label for="menutipi" class="btn btn-default" style="margin: 0;">Dil Seçimi</label>
                            </div>
                                  <select name="dil" id="dil" class="form-control">
                                      <option value="" <%if strmenudil="" then%>selected<%end if %> >Menü Dili Seçiniz </option>
                                                    <%
sqlString = "select * from diller1 where alt = '1' and (sira='1' or nott='1') ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("ceviricode")%>"  <% if mmmGenel("ceviricode")&""=strmenudil1&"" then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
                                  </select>
                        </div>
                        </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                        <div class="input-group input-group-sm pull-left" style="width:5%;">
                            <%if yetkiuye=1 or strmenugosterim<>"1" or isNull(strmenugosterim) then%>
                            <label for="ustseviye1" class="btn btn-danger btn-sm" style="margin: 0;" onclick="formla('?islem=menuSil&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');">Menüyü Sil</label>
                            <%end if %>
                            <%if yetkiuye=1 then%>
                            <div class="input-group-addon">
                                <input type="checkbox" name="menusilme" class="flatred" id="menusilme" title="Menüyü Silme" value="1" <%if strmenugosterim="1" then %>checked<%else %><%end if %> />
                            </div>
                            <%end if %>
                        </div>
                            <label class="btn btn-primary btn-sm pull-right" onclick="formla('?islem=menuDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');">Menüyü Kaydet</label>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>

    <script language="JavaScript">

        function formla(gelen) {
            document.custlist.action = gelen;
            document.custlist.submit();
        }
  //-->
    </script>
</div>
</div  >
<%call footer(1)%>

<script>
    function makeSortable(el) {
    new Sortable(el, {
        group: {
            name: "shared",
            pull: true,
            put: true
        },
        animation: 150,
        fallbackOnBody: true,
        swapThreshold: 0.65,
        handle: ".handle", // Sadece sürükleme simgesinden sürükleyebilme
        ghostClass: "sortable-ghost", // Sürüklenen öğeye özel sınıf
        chosenClass: "sortable-chosen", // Seçilen öğeye özel sınıf
        dragClass: "sortable-drag", // Sürükleme sırasında geçici sınıf
        onEnd: function (evt) {
            let item = evt.item;
            let parent = item.parentElement.closest("li");

            if (parent) {
                item.dataset.parent = parent.dataset.id;
            } else {
                delete item.dataset.parent;
            }

            updateSerialize();
        }
    });
}

// Tüm iç içe listeleri sortable hale getir
function initializeSortables() {
    document.querySelectorAll("ol").forEach(makeSortable);
}

// Alt menü aç/kapa butonu işlevi
function toggleSubMenu(btn) {
    let li = btn.closest("li");
    let subMenu = btn.closest("li").querySelector("ol");

    if (subMenu && subMenu.children.length > 0) {
        if (subMenu.style.display === "none") {
            subMenu.style.display = "block";
            btn.classList.remove("fa-eye-slash");
            btn.classList.add("fa-eye");
        } else {
            subMenu.style.display = "none";
            btn.classList.remove("fa-eye");
            btn.classList.add("fa-eye-slash");
        }
    }
}

function toggleSubMenu1(btn) {
    let panelBody = btn.closest(".panel").querySelector(".panel-body");

    if (panelBody.style.display === "none" || panelBody.style.display === "") {
        panelBody.style.display = "block";
    } else {
        panelBody.style.display = "none";
    }
}

// Silme işlemi
function removeMenuItem(btn) {
    btn.closest("li").remove();
    updateSerialize();
}

// Menü yapısını JSON olarak oluşturma
function updateSerialize() {
    function serializeMenu(el) {
        let items = el.children;
        let menuData = [];

        for (let i = 0; i < items.length; i++) {
            let item = items[i];

            let name = item.querySelector("input[name='name']").value;
            let seolink = item.querySelector("input[name='seolink']").value;
            let bagli = item.querySelector("input[name='bagli']").value;
            let toplu = item.querySelector("select[name='toplu']").value;
            let onay = item.querySelector("input[name='onay']").checked ? 1 : 0;
            let subMenu = item.querySelector("ol");

            menuData.push({
                id: item.dataset.id,
                name: name,
                bagli: bagli,
                seolink: seolink,
                toplu: toplu,
                onay: onay,
                children: subMenu && subMenu.children.length > 0 ? serializeMenu(subMenu) : []
            });
        }

        return menuData;
    }

    let menuStructure = {
        menutipi: "",
        ustseviye: "",
        menuisim: "Kurumsal Menü",
        children: serializeMenu(document.getElementById("menu-target"))
    };

    let jsonOutput = JSON.stringify(menuStructure, null, 2);
    
    // JSON çıktısını textarea'ya yazdır
    document.getElementById("jsonOutput").value = jsonOutput;
}



// Tüm listeleri sortable yap
initializeSortables();

function addNewMenuItem() {
    let newId = "menu" + Math.floor(Math.random() * 10000); // Rastgele ID oluştur

    let item = {
        id: newId,
        name: "Yeni Menü",
        bagli: "",
        seolink: "yeni-menu.html",
        toplu: "n",
        onay: 1,
        children: [] // Yeni eklenen öğe alt menü içermeyecek
    };

    let newItem = document.createElement("li");
    newItem.setAttribute("data-id", item.id);
    newItem.setAttribute("data-name", item.name);
    newItem.setAttribute("data-bagli", item.bagli);
    newItem.setAttribute("data-toplu", item.toplu);
    newItem.setAttribute("data-seolink", item.seolink);
    newItem.setAttribute("data-onay", item.onay);

    newItem.innerHTML = getMenuItemHTML(item,'0');

    document.getElementById("menu-source").appendChild(newItem);
    makeSortable(newItem.querySelector("ol")); // Yeni eklenen öğeyi sürüklenebilir yap
}


function jsonToMenu(jsonData, parentElement, statu) {
    jsonData.forEach(item => {
        let newItem = document.createElement("li");

        newItem.setAttribute("data-id", item.id);
        newItem.setAttribute("data-name", item.name);
        newItem.setAttribute("data-bagli", item.bagli);
        newItem.setAttribute("data-toplu", item.toplu);
        newItem.setAttribute("data-seolink", item.seolink);
        newItem.setAttribute("data-onay", item.onay);
        if (!item.onay) return;
        newItem.innerHTML = getMenuItemHTML(item, statu);

        parentElement.appendChild(newItem);

        // Eğer children varsa, iç içe ekle
        if (item.children && item.children.length > 0) {
            jsonToMenu(item.children, newItem.querySelector("ol"));
        }

        // Yeni eklenen öğeyi sürüklenebilir yap
        makeSortable(newItem.querySelector("ol"));
    });
}

// JSON'u HTML menüye çevirmek için çağır
// function loadJsonToMenu(jsonData) {
//     let menuContainer = document.getElementById("menu-target");
//     menuContainer.innerHTML = ""; // Önceki menüyü temizle
//     jsonToMenu(jsonData, menuContainer);
// }

function loadJsonToMenu(jsonData) {
    if (!jsonData || jsonData.length === 0) return;

    // Ana menü bilgilerini al
    let mainMenu = jsonData[0]; // İlk öğe "Kurumsal Menü"
    
    // İlk children dizisini menüye gönder
    let menuContainer = document.getElementById("menu-target");
    menuContainer.innerHTML = ""; // Önceki menüyü temizle
    jsonToMenu(mainMenu.children, menuContainer,'1');
}
let jsonData;
try {
    jsonData = [<%= menujson %>];

    // Eğer JSON tamamen boşsa veya geçersizse, yükleme yapma
    if (!jsonData || jsonData.length === 0 || !jsonData[0].children || jsonData[0].children.length === 0) {
        console.warn("Boş veya geçersiz JSON verisi, yükleme yapılmadı.");
    } else {
        loadJsonToMenu(jsonData);
    }
} catch (e) {
    console.error("Geçersiz JSON verisi, yükleme yapılmadı:", e);
}


function loadJsonToMenuSource(jsonData) {
    
    // İlk children dizisini menüye gönder
    let menuContainer = document.getElementById("menu-source");
    menuContainer.innerHTML = ""; // Önceki menüyü temizle
    jsonToMenu(jsonData, menuContainer,'0');
}


let jsonData1 = [<%=sourcemenujson%>];


// JSON'dan menüye çevir
loadJsonToMenuSource(jsonData1);

function getMenuItemHTML(item, statu) {
    if (!item.onay) return ''; // Eğer item.onay yoksa öğeyi oluşturma

    let hasChildren = item.children && item.children.length > 0;
    let eyeIcon = hasChildren ? `<i class="fa fa-eye toggle-submenu" onclick="toggleSubMenu(this)"></i>` : "";
if (statu==='1'){
    return `
        <div class="panel">
            <div class="panel-heading">
                <i class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></i>
                <span class="menu-title">${item.name}</span>
                ${eyeIcon}
                <i class="fa fa-edit toggle-submenu" onclick="toggleSubMenu1(this)"></i>
                <button class="delete-btn" onclick="removeMenuItem(this)"><i class="fa fa-trash"></i></button>
            </div>
            <div class="panel-body">
                <label>Adı:</label>
                <input name="name" type="text" value="${item.name}">
                
                <label>SEO Link:</label>
                <input name="seolink" type="text" value="${item.seolink}" placeholder="SEO Link">

                <label>Bağlı:</label>
                <input name="bagli" type="text" value="${item.bagli}" placeholder="Bağlı Kategori">
                
                <label>Toplu:</label>
                <select name="toplu">
                    <option value="n" ${item.toplu === 'n' ? 'selected' : ''}>Serbest Eklenen</option>
                    <option value="d" ${item.toplu === 'd' ? 'selected' : ''}>Alt Kategoriler Dinamik Ekle</option>
                    <option value="m" ${item.toplu === 'm' ? 'selected' : ''}>Alt Kategoriler Manuel Ekle</option>
                </select>

                <label>Onay:</label>
                <input name="onay" type="checkbox" ${item.onay === 1 ? 'checked' : ''}>
            </div>
        </div>
        <ol ></ol>
    `;
}else{
    return `
        <div class="panel">
            <div class="panel-heading">
                <i class="handle ui-sortable-handle"><i class="fa fa-arrows"></i></i>
                <span class="menu-title">${item.name}</span>
                ${eyeIcon}
                <i class="fa fa-edit toggle-submenu" onclick="toggleSubMenu1(this)"></i>
                <button class="delete-btn" onclick="removeMenuItem(this)"><i class="fa fa-trash"></i></button>
            </div>
            <div class="panel-body">
               <label>Adı:</label>
                <input name="name" type="text" value="${item.name}">
                
                <label>SEO Link:</label>
                <input name="seolink" type="text" value="${item.seolink}" placeholder="SEO Link">

                <label>Bağlı:</label>
                <input name="bagli" type="text" value="${item.bagli}" placeholder="Bağlı Kategori">
                
                <label>Toplu:</label>
                <select name="toplu">
                    <option value="n" ${item.toplu === 'n' ? 'selected' : ''}>Serbest Eklenen</option>
                    <option value="d" ${item.toplu === 'd' ? 'selected' : ''}>Alt Kategoriler Dinamik Ekle</option>
                    <option value="m" ${item.toplu === 'm' ? 'selected' : ''}>Alt Kategoriler Manuel Ekle</option>
                </select>

                <label>Onay:</label>
                <input name="onay" type="checkbox" ${item.onay === 1 ? 'checked' : ''}>
            </div>
        </div>
        <ol style="display:none;"></ol>
    `;
}

}

let allSubMenusOpen = {}; // Her menü için durum tut

function toggleAllVisibleSubMenus(menuId) {
    let menuContainer = document.getElementById(menuId);
    if (!menuContainer) return; // Eğer menü bulunamazsa çık

    // Eğer menü için durum yoksa başlat (default olarak kapalı olacak)
    if (allSubMenusOpen[menuId] === undefined) {
        allSubMenusOpen[menuId] = false;
    }

    allSubMenusOpen[menuId] = !allSubMenusOpen[menuId]; // Aç/Kapat durumunu değiştir

    let toggleIcons = menuContainer.querySelectorAll(".toggle-submenu.fa-eye-slash, .toggle-submenu.fa-eye"); // Sadece göz ikonları olanları seç

    toggleIcons.forEach(icon => {
        let panel = icon.closest(".panel"); // En yakın paneli bul
        let panelBody = panel.nextElementSibling; // Panel gövdesini bul (panelden sonra gelen öğe)
        let subMenu = panel.parentElement.querySelector("ol"); // Alt menüyü bul
        
        if (panelBody) {
            panelBody.style.display = allSubMenusOpen[menuId] ? "block" : "none"; // Aç veya kapa
        }

        if (subMenu) {
            subMenu.style.display = allSubMenusOpen[menuId] ? "block" : "none"; // Aç veya kapa
        }

        // İkonu değiştir
        if (allSubMenusOpen[menuId]) {
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        } else {
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        }
    });
}

    </script>