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

            Set oJSON = New aspJSON
    oJSON.loadJSON(menujson)
        if instr(menujson,"[") then

            set rows = oJSON.data(0)
            for each rowii in rows

    if isObject(rows(rowii)("children")) then
            strid=rows(rowii)("id")
            menubagliana=rows(rowii)("bagli")  
            menuseolinkana1=rows(rowii)("seolink")
            menuisimana1=rows(rowii)("name")
    baslik=menuisimana1
    if Request("dil")="ar" or Request("dil")="cn" or Request("dil")="ru" or Request("dil")="az" then 
    menuisimana1=server.HTMLEncode(baslik)
end if
            strturu=rows(rowii)("turu")
            strtoplu=rows(rowii)("toplu")
            stronay=rows(rowii)("onay")
    Con.execute("insert menuler set alt='"&request.Form("anamenuid")&"', isim='"&menuisimana1&"', link='"&menuseolinkana1&"', target='"&menubagliana&"', durum='"&stronay&"', menugosterim='"&strturu&"', anasek='"&request.Form("anamenuid")&"', lang='"&request.Form("dil")&"', sira1='"&strtoplu&"'")
    
    strSQL="select @@IDENTITY as NewID from menuler"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)
                       set cols = rows(rowii)("children")(0)
            for each colii in cols
    if cols.count>=1 then
                                                stridalt=cols(colii)("id")
            menubagliana=cols(colii)("bagli")
            menuseolinkana1=cols(colii)("seolink")
            menuisimana1=cols(colii)("name")
    baslik=menuisimana1
    if Request("dil")="ar" or Request("dil")="cn" or Request("dil")="ru" or Request("dil")="az" then 
    menuisimana1=server.HTMLEncode(baslik)
end if
            strturu=rows(rowii)("turu")
            strtoplu=rows(rowii)("toplu")
            stronay=cols(colii)("onay")
    Con.execute("insert menuler set alt='"&request.Form("anamenuid")&"', isim='"&menuisimana1&"', link='"&menuseolinkana1&"', target='"&menubagliana&"', durum='"&stronay&"', menugosterim='"&strturu&"', anasek='"&tfgid&"', lang='"&request.Form("dil")&"', sira1='"&strtoplu&"'")
    strSQL="select @@IDENTITY as NewID from menuler"
    set mmmGenel = Con.Execute(strSQL)
    tfgidd = mmmGenel.Fields("NewID")
    close(mmmGenel)
              end if
     set colssub = cols(colii)("children")(0)
            for each coliisub in colssub
    if colssub.count>=1 then
                                                stridalt=colssub(coliisub)("id")
            menubagliana=colssub(coliisub)("bagli")
            menuseolinkana1=colssub(coliisub)("seolink")
            menuisimana1=colssub(coliisub)("name")
    baslik=menuisimana1
    if Request("dil")="ar" or Request("dil")="cn" or Request("dil")="ru" or Request("dil")="az" then 
    menuisimana1=server.HTMLEncode(baslik)
end if
            strturu=rows(rowii)("turu")
            strtoplu=rows(rowii)("toplu")
            stronay=colssub(coliisub)("onay")
    Con.execute("insert menuler set alt='"&request.Form("anamenuid")&"', isim='"&menuisimana1&"', link='"&menuseolinkana1&"', target='"&menubagliana&"', durum='"&stronay&"', menugosterim='"&strturu&"', anasek='"&tfgidd&"', lang='"&request.Form("dil")&"', sira1='"&strtoplu&"'")
              end if
                                    next
                                    next
    end if
    
       next
                            end if
session("hata1")="Menü Düzenlendi"
session("hatam1")="green"
end sub

sub menuDuzenle1
For i = 1 To Request.Form("isim").Count
    toplu=request.Form("toplu["&i&"]")
Set mmmYardimci=Con.execute("update menuler set durum='"&request.Form("onay")(i)&"',isim='"&request.Form("isim")(i)&"',seolink='"&request.Form("seolink")(i)&"',sira='"&i&"',sira1='"&toplu&"' where id="&request.Form("urunid")(i)&"")
    
next
session("hata1")="Menü Düzenlendi"
session("hatam1")="green"
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

end sub

sub menuserbestekle
    
Con.execute("update menuler set sira='0' where id="&request.Form("anamenuid")&"")

Con.execute("insert menuler set isim='"&request.Form("menuname")&"',alt='"&request.Form("anamenuid")&"', durum='1', sira1='m', anasek='"&request.Form("anamenuid")&"'")

session("hata1")="Menü Eklendi"
session("hatam1")="green"

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
<style>

    .panel-title > a, .panel-title > a:active {
        display: block;
        color: #555;
        font-size: 16px;
        font-weight: bold;
        letter-spacing: 1px;
        word-spacing: 3px;
        text-decoration: none;
    }

    .panel-heading a:before {
        font-family: 'Glyphicons Halflings';
        content: "\e114";
        float: right;
        transition: all 0.5s;
    }

    .panel-heading.active a:before {
        -webkit-transform: rotate(180deg);
        -moz-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .overflow-auto {
        overflow: auto;
    }
.highlighter {
    text-align: center;
    cursor: move;
    border-radius: 5px;
    width: 200px;
    height: 40px;
    display: inline-block;
    margin: 0px 10px 14px 10px;
    padding: 0;
    border: 1px dashed #000;
    background:#FFFF91;
}

    
/* line 10, /Users/jonasvonandrian/jquery-sortable/source/css/jquery-sortable.css.sass */
.sortpage ol.vertical {
  margin: 0 0 9px 0;
  min-height: 10px;
  padding:0px; }
  /* line 13, /Users/jonasvonandrian/jquery-sortable/source/css/jquery-sortable.css.sass */
  .sortpage ol.vertical li {
    display: block;
    margin: 5px 0px;
    color: #0088cc;
    background: #eeeeee; }
  /* line 20, /Users/jonasvonandrian/jquery-sortable/source/css/jquery-sortable.css.sass */
 .sortpage  ol.vertical li.placeholder {
    position: relative;
    margin: 0;
    padding: 0;
    border: none; }
    /* line 25, /Users/jonasvonandrian/jquery-sortable/source/css/jquery-sortable.css.sass */
    .sortpage ol.vertical li.placeholder:before {
      position: absolute;
      content: "";
      width: 0;
      height: 0;
      margin-top: -5px;
      left: -5px;
      top: -4px;
      border: 5px solid transparent;
      border-left-color: red;
      border-right: none; }

/* line 32, /Users/jonasvonandrian/jquery-sortable/source/css/application.css.sass */
.sortpage ol {
  list-style-type: none; }
  /* line 34, /Users/jonasvonandrian/jquery-sortable/source/css/application.css.sass */
  .sortpage ol i.icon-move {
    cursor: pointer; }
  /* line 36, /Users/jonasvonandrian/jquery-sortable/source/css/application.css.sass */
  .sortpage ol li.highlight {
    background: #333333;
    color: #999999; }
    /* line 39, /Users/jonasvonandrian/jquery-sortable/source/css/application.css.sass */
    .sortpage ol li.highlight i.icon-move {
      background-image: url("../img/glyphicons-halflings-white.png"); }


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
                    <form name="form1" method="post" action="?islem=menuserbestekle&filtret=menu&kateid=<%=kateid %>">
                        <h4 class="panel-title">
                            <div class="input-group input-group-sm" style="margin: 0;">
                                <input name="anamenuid" type="hidden" value="<%=kateid%>">
                                <input name="menuname" type="text" id="menuname" class="form-control" placeholder="Serbest Menü Ekle">
                                <div class="input-group-btn">
                                    <button name="submit2" type="submit" class="btn btn-success pull-right">Ekle</button>
                                </div>
                            </div>
                        </h4>
                    </form>
                </div>

                <form name="form1" method="post" action="?islem=menuelemanekle&filtret=menu&kateid=<%=kateid %>">
                    <input name="anamenuid" type="hidden" value="<%=kateid%>">
                    <div class="panel-heading" role="tab" id="headingsayfalar">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapsesayfalar" aria-expanded="true" aria-controls="collapsesayfalar">Sayfa Başlıkları
                            </a>
                        </h4>
                    </div>
                    <div id="collapsesayfalar" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingsayfalar">
                        <div class="panel-body">
                            <h4 class="list-group-item-heading">Kategoriler</h4>
                            <ul class="list-group overflow-auto" style="max-height: 200px;">
                                <% response.Write kategoriyaziliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""k/*/#kylid#/*/#kyllink#"" value=""k/*/#kylid#][#kylisim#][#kyllink#""> #kylisim#</label>#kylsub{(,,,,"&sayfagosterme&", style='margin-left:10px;',240)}#</li>","","",sayfagosterme,"","240")
                                    ',"0" %>
                            </ul>
                            <button name="submit2" type="submit" class="btn btn-primary btn-xs pull-right">Menüyü Kaydet</button>
                            <div class="clear"></div>
                            <h4 class="list-group-item-heading">Yazılar</h4>
                            <ul class="list-group overflow-auto" style="max-height: 200px;">
                                <% response.Write yaziliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""y/*/#kylid#/*/#kyllink#"" value=""y/*/#kylid#][#kylisim#][#kyllink#""> #kylisim#</label>","",""," and kategori in (SELECT id from kategoriyazi where modulmu='0'"&sayfagosterme&") and urunid<>'1'","","240","","") %>
                            </ul>
                            <button name="submit2" type="submit" class="btn btn-primary btn-xs pull-right">Menüyü Kaydet</button>
                        </div>
                    </div>
                    <%if instr(sistem_site_turu,"*cicek*") then%>
                    <div class="panel-heading" role="tab" id="headingcicek">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapsecicek" aria-expanded="true" aria-controls="collapsecicek">Çiçek Başlıkları
                            </a>
                        </h4>
                    </div>
                    <div id="collapsecicek" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingcicek">
                        <div class="panel-body">
                            <h4 class="list-group-item-heading">Çiçek Kategorileri</h4>
                            <ul class="list-group overflow-auto" style="max-height: 200px;">
                                <% response.Write cicekkategoriliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""c/*/#kylid#"" value=""c/*/#kylid#][#kylisim#""> #kylisim#</label>#kylsub(,,,,"&sayfagosterme&", style='margin-left:10px;')#</li>","","",sayfagosterme,"") %>
                            </ul>
                            <button name="submit2" type="submit" class="btn btn-primary btn-xs pull-right">Menüyü Kaydet</button>
                        </div>
                    </div>
                    <%end if %>
                    <%if instr(sistem_site_turu,"*tur*") then%>
                    <div class="panel-heading" role="tab" id="headingtur">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapsetur" aria-expanded="true" aria-controls="collapsetur">Acente Başlıkları
                            </a>
                        </h4>
                    </div>
                    <div id="collapsetur" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingtur">
                        <div class="panel-body">
                            <h4 class="list-group-item-heading">Diğer</h4>
                            <ul class="list-group overflow-auto" style="max-height:200px;">
                                <li><label><input name="menuid" type="checkbox" class="flatgreen" aria-label="acd/*/gemifirma][Gemi Firmaları][#" value="acd/*/gemifirma][Gemi Firmaları][#"> Gemi Firmaları</label></li>
                                <li><label><input name="menuid" type="checkbox" class="flatgreen" aria-label="acd/*/limanlar][Limanlar][#" value="acd/*/limanlar][Limanlar][#"> Limanlar</label></li>
                                </ul>
                            <button name="submit2" type="submit" class="btn btn-primary btn-xs pull-right">Menüyü Kaydet</button><div class="clear"></div>
                            <%
                'response.Write turdestinasyonliste("1","<h4 class=""list-group-item-heading"">#kylisim#</h4><ul class=""list-group overflow-auto"" style=""max-height:200px;""><li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""k#kylid#"" value=""k#kylid#][#kylisim#""> #kylisim#</label>#kylsub(,,,,, style='margin-left:10px;')#</li></ul><button name=""submit2"" type=""submit"" class=""btn btn-primary btn-xs pull-right"">Menüyü Kaydet</button><div class=""clear""></div>","","","","")
                response.Write turdestinasyonliste("1","<h4 class=""list-group-item-heading"">#kylisim#</h4><ul class=""list-group overflow-auto"" style=""max-height:200px;"">#kylsub(,<li#kylico1# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""t/*/#kylid1#/*/#kyllink1#"" value=""t/*/#kylid1#][#kylisim1#][#kyllink1#""> #kylisim1#</label>#kylsub1([][][][][] style='margin-left:20px;')]#</li>,,,, style='margin-left:10px;')#</ul><button name=""submit2"" type=""submit"" class=""btn btn-primary btn-xs pull-right"">Menüyü Kaydet</button><div class=""clear""></div>","",""," and onay='1' and id<>'2580'","") %>
                        </div>
                    </div>
                    <%end if %>
                    <%if instr(sistem_site_turu,"*eticaret*") then%>
                    <div class="panel-heading" role="tab" id="headingeticaret">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapseeticaret" aria-expanded="true" aria-controls="collapseeticaret">Eticaret Başlıkları
                            </a>
                        </h4>
                    </div>
                    <div id="collapseeticaret" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingeticaret">
                        <div class="panel-body">
                            <h4 class="list-group-item-heading">Eticaret Kategorileri</h4>
                            <ul class="list-group overflow-auto" style="max-height: 200px;">

                                <% response.Write eticaretkategoriliste("1","<li#kylico# ><label><input name=""menuid"" type=""checkbox"" class=""flatgreen"" aria-label=""e/*/#kylid#/*/#kyllink#"" value=""e/*/#kylid#][#kylisim#][#kyllink#""> #kylisim#</label>#kylsub{(,,,,"&sayfagosterme&", style='margin-left:10px;')}#</li>","","",sayfagosterme,"")
                                    %>
                            </ul>
                            <button name="submit2" type="submit" class="btn btn-primary btn-xs pull-right">Menüyü Kaydet</button>
                        </div>
                    </div>
                    <%end if %>
                </form>
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
                        <div class="sortpage">
                            <%
          sablon=strrowtempyeni
                                if strsira="0" OR strsira="3" then
                                
Con.execute("update menuler set sira='1' where id="&kateid&"")
                                %>
                            <ol class="ui-sortable2 vertical panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <li data-menuisim="<%=kateisim %>" data-ustseviye="<%=strmenuustseviye %>" data-menutipi="<%=strmenutipi %>"></li>
                                <%

      sqlString = "SELECT * from menuler where anasek = '"&kateid&"' order by id"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF

                                    
            strid=mmmYardimci("id")
            menubagliana=mmmYardimci("target")  
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
            menuseolinkana1=mmmYardimci("link")
            menuisimana1=mmmYardimci("isim")
            strtoplu=mmmYardimci("sira1")
            stronay=mmmYardimci("durum")
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
yazidil="turlar"

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
menuseolinkana=seolarlink(menubaglianaid,yazidil,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if                                   
rowii=rowii+1

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

          <ol><% 
      sqlString = "SELECT * from menuler where anasek = '"&strid&"' order by id"
set mmmYardimci1 = Con.Execute (sqlString)
                                    if mmmYardimci1.eof then
                                    else
             
Do While Not mmmYardimci1.EOF                               
colii=colii+1

            strid=mmmYardimci1("id")
            menubagliana=mmmYardimci1("target")
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
            menuseolinkana1=mmmYardimci1("link")
            menuisimana1=mmmYardimci1("isim")
            strtoplu=mmmYardimci1("sira1")
            stronay=mmmYardimci1("durum")
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
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
              call menuli(rowii&colii,strid,stronay,strtoplu,menuisimana,menuseolinkana,menubagliana,deep1)
          
                                     mmmYardimci1.MoveNext
loop
  close(mmmYardimci1)
              end if
              %></ol>
      </li>
       <%           
            mmmYardimci.MoveNext
loop
  close(mmmYardimci)%>
                            </ol>
                            <%
                                else
                                if  strsira="2" then
'Con.execute("update menuler set sira='1' where id="&kateid&"")
                                end if
            Set oJSON = New aspJSON
    oJSON.loadJSON(menujson)
        if instr(menujson,"[")then%>
                            <ol class="ui-sortable2 vertical panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <li data-menuisim="<%=kateisim %>" data-ustseviye="<%=strmenuustseviye %>" data-menutipi="<%=strmenutipi %>"></li>
                                <%

            set rows = oJSON.data(0)
            for each rowii in rows
                                    
            strid=rows(rowii)("id")
            strtoplu=rows(rowii)("sira1")
            stronay=rows(rowii)("onay")
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
            menubagliana=rows(rowii)("bagli")  
                                    if instr(menubagliana,"/*/") then
                                    menubaglianat=split(menubagliana,"/*/")(0)
                                    menubaglianaid=split(menubagliana,"/*/")(1)
                                    else
                                    menubaglianat=""
                                    menubaglianaid=""
                                    end if
                                    if menubaglianaid="" or isNull(menubaglianaid) then
                                    menubaglianaid="0"
                                    end if
                                    'response.Write strsira
                                    if  strsira="2" then
                                                                        if menubaglianat="t" then
                                                                        sayfaturu="turlar"
                                    if strmenudil="240" or strmenudil="" then
menuisimana=menuvericek(vdb,menubagliana,dbtkategoritur,"isim","id = '"&menubaglianaid&"'","isim")
                                    else
menuisimana=menuvericek(vdb,menubagliana,dbtdilleracenta,"kate","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","kate")
menubaglianaid=menuvericek(vdb,menubagliana,dbtdilleracenta,"id","(bagli = '3"&menubaglianaid&"') and anasek='"&strmenudil&"'","id")
                                    end if
                                    sayfaturu="t"
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

              'menuseolinkana=seolarlink(menubaglianaid,yazidil)
                                    'menuseolinkana1=seolarlink(menubaglianaid,strmenudil)
                                   ' menuisimana1=""
                                    else
            menuseolinkana1=rows(rowii)("seolink")
            menuisimana1=rows(rowii)("name")
             
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
if menuisimana="" or isNull(menuisimana) then
menuisimana=menuisimana1
              end if 
              'menuseolinkdb=seolarlink(menubaglianaid,yazidil)
                                    menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  

                                    if strtoplu<>"n" then
menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
                                    end if
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  

                                    end if
                                  
ikss=ikss+1
              if isObject(rows(rowii)("children")) then
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
          <ol><% 
                       set cols = rows(rowii)("children")(0)
            for each colii in cols
    if cols.count>=1 then
                                                strid=cols(colii)("id")  
              strtoplu=cols(colii)("sira1")
            stronay=cols(colii)("onay")
          if strtoplu="m" then
          toplum=" selected"
          topluda=""
          toplun=""
          elseif strtoplu="d" then
          topluda=" selected"
          toplum=""
          toplun=""
          else
          toplun=" selected"
          topluda=""
          toplum=""
          end if

            menubagliana=cols(colii)("bagli")
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
            menuseolinkana1=cols(colii)("seolink")
            menuisimana1=cols(colii)("name")
         
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
menuisimana=menuvericek(vdb,menubagliana,"kategoriyazi","isim","(id = '"&menubaglianaid&"' or bagli = '"&menubaglianaid&"') and dil='"&strmenudil&"'","isim")      
              sayfaturu="sayfa"
                                    elseif menubaglianat="y" then
menuisimana=menuvericek(vdb,menubagliana,"yazilar","yazib","bagli = '"&menubaglianaid&"' and dil='"&strmenudil&"'","yazib") 
              sayfaturu="yazi"
                                    else
                                    menuisimana=menuisimana1
                                    end if

'response.write menubaglianaid&sayfaturu&strmenudil
menuseolinkana=seolarlink(menubaglianaid,sayfaturu,strmenudil)
'response.write menuseolinkana
                                    'response.Write menubaglianaid&"-"&yazidil
if menuseolinkana="" or menuseolinkana="#" then
menuseolinkana=menuseolinkana1
              end if  
if menuisimana="" then
menuisimana=menuisimana1
              end if
              end if
              call menuli(rowii&colii,strid,stronay,strtoplu,menuisimana,menuseolinkana,menubagliana,deep1)
              end if
                                    next
              %></ol>
      </li>
       <%    menuseolinkana=""   
           menuisimana=""
              end if    
              
           next%>
                            </ol>
                            <%end if%>
                            <%end if%>
                            <input name="serializede" type="hidden" value="" id="serialize_outputhidden" />
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
            function updateserializesubmit(nm,chck){
            if (nm=='toplu'){
            var nptval=$( '#'+chck+' *[name=toplu]' ).find(":selected").val();
            }else{
            var nptval=$( '#'+chck+' input[name='+nm+']' ).val();
            }
            $('#'+chck+'').attr('data-'+nm+'', nptval).data(''+nm+'', nptval);
            console.log('data-'+nm+'');
    updateserialize();
}

 var group = $("ol.yeni_menu").sortable({
  group: 'no-drop',
            onDrop: function  ($item, container, _super) {

            updateserialize();
             _super($item, container);
  },
  onDragStart: function ($item, container, _super) {
    
    if(!container.options.drop)
      $item.clone().insertAfter($item);
    _super($item, container);
  }
});
$("ol.ekle_menu").sortable({
  group: 'no-drop'
});


function divremove(checked)
	{
		var data3=document.getElementById(checked);
		data3.remove();
		updateserialize();
	}


function updateserialize(){
             var groups = $("ol.ui-sortable2").sortable("refresh");
	var data = groups.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

	document.getElementById("serialize_outputhidden").value = jsonString;
	}
 $(document).ready(function () {
updateserialize();
    });


var jMenuContainer = $(".sortpagea");
var jNLevelEmbeddedSortableList = jMenuContainer.find("ol");
var embedLevel =2; // N-level-deep embedding; default 1

var sortableMenu = jNLevelEmbeddedSortableList.sortable({ 
  axis: 'y',
  handle: 'i.fa-arrows',
  opacity: 1,
  nested: true,
  receive: function (event, ui) {

    var jUiItem = $(ui.item);

    // cancel sorting if the list-item-to-move already has more than N parents OR N-1 existing children (nested items)
    if (jUiItem.parents("li").length > embedLevel || jUiItem.find("li").length > (embedLevel - 1)) {
      $(ui.sender).sortable("cancel");
    }
  if (container.el.parents("li").length > embedLevel || container.el.find("li").length > (embedLevel - 1)) {
                                console.log($item.parent("li")[0]);
                                return $item.parent("li")[0] == container.el[0];
    }

  }
});

var group = $("ol.ui-sortable2").sortable({
  handle: 'i.fa-arrows',
  nested: true,
  delay: 200,
		animation: 150,
		swapThreshold: 0.65,
  group: 'ui-sortable2', 
  onDragStart: function ($item, container, _super) {

			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {  
                                
  if ($("ol.ui-sortable2 > li > ol > li > ol").parents("li").length > 0) {
                                //console.log($("ol.ui-sortable2 > li > ol > li > ol").find("li").length);
                                 //$("ol.ui-sortable2").sortable("destroy");
	container.el.addClass("no-drop");
    }
	container.el.removeClass("active");
         updateserialize();
    _super($item, container);
  }
});


 $('.panel-collapse').on('show.bs.collapse', function () {
    $(this).siblings('.panel-heading').removeClass('active');
  });

  $('.panel-collapse').on('hide.bs.collapse', function () {
    $(this).siblings('.panel-heading').addClass('active');
  });
                                <%if strsira="0" then %>
                                $(document).ready(function () {
                                formla('?islem=menuDuzenle&filtret=menu&kateid=<%=kateid%>&altkate=<%=altkate%>');
                                });
                          <%end if %>


</script>
