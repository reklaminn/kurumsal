<% function veriedit(veri,bas,son)
    if instr(veri,bas) then
sayfa2=split(veri,bas)
sayfa2a=split(sayfa2(1),son)
veriedit=trim(sayfa2a(0))
    else
    veriedit=""
    end if
end function
    
    sub sayfalaurun()
    if sayfalink="" then
	  sayfa=replace(link,"&git=","&gitold=")
    else
    sayfa="?"&replace(sayfalink,"&git=","&gitold=")
    end if
response.Write("<nav><ul class=""pagination"">")
If clng(toplam5) > clng(KayitSayisi) Then
intSayfaSayisix = (clng(toplam5) / clng(KayitSayisi))
if instr(intSayfaSayisix,".") <> 0 or instr(intSayfaSayisix,",") <> 0 then
intSayfaSayisi = clng(intSayfaSayisix + 1)
else
intSayfaSayisi = round(intSayfaSayisix,0)
end if
else
intSayfaSayisi = 1
End If
Aralik = 2
intSayfaAltSiniri = git - Aralik
intSayfaUstSiniri = git + Aralik
intSolGrupSayisi = 1 + Aralik
intSagAltSinir = intSayfaSayisi - Aralik
%>
<%
If (intSayfaUstSiniri >intSayfaSayisi) Then
intSayfaAltSiniri = intSayfaSayisi - (2 * Aralik)
intSayfaUstSiniri = intSayfaSayisi
End If
%>
<%
If (intSayfaAltSiniri <= 0) Then
intSayfaAltSiniri = 1
intSayfaUstSiniri = intSayfaAltSiniri + (2 * Aralik)
If intSayfaUstSiniri >= intSayfaSayisi Then intSayfaUstSiniri = intSayfaSayisi
End If
%>
<%
If intSolGrupSayisi >= intSayfaAltSiniri Then intSolGrupSayisi = intSayfaAltSiniri - 1
If intSagAltSinir <= intSayfaUstSiniri Then intSagAltSinir = intSayfaUstSiniri + 1
%>
<%
If git >1 Then %>
<li><a href="<%=sayfa%>&git=1" title="İlk Sayfa" aria-label="First">&laquo;&laquo;</a></li>
<li><a href="<%=sayfa%>&git=<%=round(git-1)%>" title="&Ouml;nceki Sayfa" aria-label="Previous">&laquo;</a></li>
<%
End If
%>
<%
For isayfa = 1 to intSolGrupSayisi
If clng(isayfa) = clng(git) Then
renk=" class=""active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li>"
End If%>
<a href="<%=sayfa%>&git=<%=round(isayfa,0)%>" title="<%=round(isayfa,0)%>. Sayfa"<%=renk%>>
<%
%>
<%=round(isayfa,0)%></a>
</li>
<%Next
%>
<%
If (intSayfaAltSiniri - intSolGrupSayisi >1 ) Then Response.Write "<li><a><b>. . .</b></a></li>"
%>
<%
For isayfa = intSayfaAltSiniri to intSayfaUstSiniri
If clng(isayfa) = clng(git) Then
renk=" class=""active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li >"
End If %>
<a href="<%=sayfa%>&git=<%=round(isayfa,0)%>" title="<%=round(isayfa,0)%>. Sayfa"<%=renk%>> <%=round(isayfa,0)%></a>
</li>
<%Next
%>
<%
If (intSagAltSinir - intSayfaUstSiniri >1) Then Response.Write "<li><a><b>. . .</b></a></li>"
%>
<%
For isayfa = intSagAltSinir to intSayfaSayisi
If clng(isayfa) = clng(git) Then
renk=" class=""active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li>"
End If %>
<a href="<%=sayfa%>&git=<%=round(isayfa,0)%>" title="<%=round(isayfa,0)%>. Sayfa"> <%=round(isayfa,0)%></a>
</li>
<%Next
%>
<%
If clng(git) <>clng(intSayfaSayisi) Then %>
<li><a href="<%=sayfa%>&git=<%=round(git+1,0)%>" title="Sonraki Sayfa" aria-label="Next">&raquo;</a></li>
<li> <a href="<%=sayfa%>&git=<%=round(intSayfaSayisi,0)%>" title="Son Sayfa" aria-label="Last">&raquo;&raquo;</a></li>
<%
End If%>
<li><a>SAYFA : <font color="#CC0033"><b><%=git%></b></font></a></li>
<li class="kayitsayisi"><a> <%=toplam5%> Kayıt.</a></li>
</ul>
</nav>
<%end sub

    sub glradd(fldr,glrurl)
    'fldr=server.URLEncode(fldr)
    'imgyol=server.URLEncode(imgyol)
    if cdnstatu="1" then 
    imgyol=""&cdnimgfldr&""&cdnsitefolder&""&imgyol&""
    else
set dosyasis=CreateObject("Scripting.FileSystemObject")
if Not dosyasis.FolderExists(Server.MapPath(""&imgyol&""&fldr&"")) then
dosyasis.CreateFolder(Server.MapPath(""&imgyol&""&fldr&""))
set dosyasis=nothing
else
end if
end if
    %>
<style>
    .modal-dialog {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

.modal-content {
  height: auto;
  min-height: 100%;
  border-radius: 0;
}
</style>
<form id="turresim_block" method="post" action="<%=glrurl %>">
    <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=1&fldr=/<%=fldr %>&relative_url=1<%=cdncross %>" data-target="#myModal" class="iframe-btn" type="button">
        <div id="turresim_block1" class="dropzone">
            <div class="dz-message needsclick" id="dropzonePreview7">
                <div class="dz-default"><span>Resim Yükleyin veya Seçin</span></div>
            </div>
            <div class="fallback hidden">
                <input class="form-control" id="fieldID1" aria-multiselectable="true" name="resimler" type="text" value="">
            </div>
        </div>
    </a>

    <div class="row">
        <div class="form-group col-md-6" style="font-size: 12px; line-height: 38px;">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="resimisim" class="flatblue" value="1">&nbsp;Resim Adını Resim Yazısı Olarak kullan.
                </label>
            </div>
        </div>
        <div class="form-group col-md-6">
            <input name="yer" type="hidden" value="<%=request.form("sayfayeri")%>" />
            <input name="fldr" type="hidden" value="<%=fldr%>" />
            <input name="imgyol" id="imgyol" type="hidden" value="<%=imgyol%>" />

            <button type="submit" id="submit_all_resim" class="btn btn-success center-block" style="margin-top: 0px;">Dosyaları Yükle</button>
        </div>
    </div>

</form>

<style>
    .modal-dialog {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

.modal-content {
  height: auto;
  min-height: 100%;
  border-radius: 0;
}
</style>
     <div class="modal fade" id="myModal">
<div class="modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"></h4>
    </div>
    
    <div class="modal-body" style="padding:0px; margin:0px; width: 100%;">
      <iframe width="100%" height="500" src="" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>
    </div>
  </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%end sub 

    sub sayfala(linkbaslangic)
sayfa=linkbaslangic
If clng(toplam5) > clng(KayitSayisi) Then
intSayfaSayisix = (clng(toplam5) / clng(KayitSayisi))
if instr(intSayfaSayisix,".") <> 0 or instr(intSayfaSayisix,",") <> 0 then
intSayfaSayisi = clng(intSayfaSayisix) + 1
else
intSayfaSayisi = round(intSayfaSayisix,0)
end if
else
intSayfaSayisi = 1
End If
Aralik = 2
intSayfaAltSiniri = git - Aralik
intSayfaUstSiniri = git + Aralik
intSolGrupSayisi = 1 + Aralik
intSagAltSinir = intSayfaSayisi - Aralik

If (intSayfaUstSiniri >intSayfaSayisi) Then
intSayfaAltSiniri = intSayfaSayisi - (2 * Aralik)
intSayfaUstSiniri = intSayfaSayisi
End If

If (intSayfaAltSiniri <= 0) Then
intSayfaAltSiniri = 1
intSayfaUstSiniri = intSayfaAltSiniri + (2 * Aralik)
If intSayfaUstSiniri >= intSayfaSayisi Then intSayfaUstSiniri = intSayfaSayisi
End If
%>
<%
If intSolGrupSayisi >= intSayfaAltSiniri Then intSolGrupSayisi = intSayfaAltSiniri - 1
If intSagAltSinir <= intSayfaUstSiniri Then intSagAltSinir = intSayfaUstSiniri + 1
%>
<%
If git >1 Then %>
<a href="<%=sayfa%>&git=1" title="İlk Sayfa" class="sayfano">&laquo;&laquo;</a> <a href="<%=sayfa%>&git=<%=round(git-1)%>" title="&Ouml;nceki Sayfa" class="sayfano">&laquo;</a>
<%
End If
%>
<%
For i = 1 to intSolGrupSayisi
If clng(i) = clng(git) Then
Response.Write " <span>"
renk=" style=""color:#c00; font-weight:bold;"""
Else 
renk=""
Response.Write " <span>"
End If%>
<a href="<%=sayfa%>&git=<%=round(i,0)%>" title="<%=round(i,0)%>. Sayfa"<%=renk%> class="sayfano">
<%
%>
<%=round(i,0)%></a></span>
<%Next
%>
<%
If (intSayfaAltSiniri - intSolGrupSayisi >1 ) Then Response.Write "<span class=""sayfano""><b>. . .</b></span>"
%>
<%
For i = intSayfaAltSiniri to intSayfaUstSiniri
If clng(i) = clng(git) Then
Response.Write " <span>"
renk=" style=""color:#c00; font-weight:bold;"""
Else 
renk=""
Response.Write " <span >"
End If %>
<a href="<%=sayfa%>&git=<%=round(i,0)%>" title="<%=round(i,0)%>. Sayfa"<%=renk%> class="sayfano"> <%=round(i,0)%></a></span>
<%Next
%>
<%
If (intSagAltSinir - intSayfaUstSiniri >1) Then Response.Write "<span class=""sayfano""><b>. . .</b></span>"
%>
<%
For i = intSagAltSinir to intSayfaSayisi
If clng(i) = clng(git) Then
Response.Write " <span>"
renk=" style=""color:#c00;  font-weight:bold;"""
Else 
renk=""
Response.Write " <span>"
End If %>
<a href="<%=sayfa%>&git=<%=round(i,0)%>" title="<%=round(i,0)%>. Sayfa"<%=renk%> class="sayfano"> <%=round(i,0)%></a></span>
<%Next
%>
<%
If clng(git) <>clng(intSayfaSayisi) Then %>
<a href="<%=sayfa%>&git=<%=round(git+1,0)%>" title="Sonraki Sayfa" class="sayfano">&raquo;</a> <a href="<%=sayfa%>&git=<%=round(intSayfaSayisi,0)%>" title="Son Sayfa" class="sayfano">&raquo;&raquo;</a>
<%
End If%>
<span class="sayfano">SAYFA : <font color="#CC0033"><b><%=git%></b></font></span> <span class="sayfano"> <%=toplam5%> Üründen, Her Sayfada
<input name="usayi1" type="text" value="<%if request("usayi")="" then%><%=KayitSayisi%><%else%><%=request("usayi")%><%end if%>" size="5" style="height:17px; width:44px; text-align:center;">
&Uuml;r&uuml;n G&ouml;r&uuml;ns&uuml;n. </span>
<%end sub

%>

<%

islem=Request.QueryString("islem")
if islem="sayaraktar" then
call sayaraktar
elseif islem="sayarguncelle" then
call sayarguncelle
elseif islem="modulguncelle" then
call modulguncelle
elseif islem="csskopya" then
call csskopya
elseif islem="cssaktif" then
call cssaktif
elseif islem="csssite" then
call csssite
elseif islem="cssdosyasil" then
call cssdosyasil
elseif islem="cssekle0" then
call cssekle0
elseif islem="csskaydet1" then
call csskaydet1
elseif islem="csskaydet" then
call csskaydet
elseif islem="modulsil" then
call modulsil
elseif islem="modulekle" then
call modulekle
elseif islem="kulekle" then
call kulekle
elseif islem="kulDuzenle" then
call kullDuzenle
elseif islem="sayfakopyala" then
call sayfakopyala
elseif islem="katecssekle" then
call katecssekle
elseif islem="katetekle" then
call katetekle
elseif islem="skyduzenle" then
call skyduzenle
elseif islem="cachepage" then
call cachepage
elseif islem="ayaral" then
call ayaral
elseif islem="KurGuncelleSite" then
call KurGuncelleSite
elseif islem="KurGuncelle" then
call KurGuncelle
elseif islem="KurGuncelletcbm" then
call KurGuncelletcbm
else
end if

Submit=Request.QueryString("Submit")
if Submit="tasarimDuzenle" then
call tasarimDuzenle
elseif Submit="tasarimSil" then
call tasarimSil
elseif Submit="sayfatumDuzenle" then
call sayfatumDuzenle
elseif Submit="DuzenleModul" then
call DuzenleModul
elseif Submit="SilModul" then
call SilModul
elseif Submit="kulDuzenle" then
call kulDuzenle
elseif Submit="kulSil" then
call kulSil
elseif Submit="katedDuzenle" then
call katedDuzenle
elseif Submit="kateSil" then
call kateSil
elseif Submit="kateDuzenle" then
call kateDuzenle
elseif Submit="katetDuzenle" then
call katetDuzenle
elseif Submit="katetSil" then
call katetSil
else
end if
    

sub KurGuncelletcbm	
 Set kurlar = Server.CreateObject("msxml2.DOMDocument" )
 kurlar.async = false
 kurlar.resolveExternals = false
 kurlar.setProperty "ServerHTTPRequest" ,true
 kurlar.load("https://www.tcmb.gov.tr/kurlar/today.xml" )
 'Set nodes = kurlar.getElementsByTagName("Currency")
 'For Each node in nodes
     'currencyCode = node.getAttribute("CurrencyCode")
     'forexBuying = node.selectSingleNode("ForexBuying").text
     'forexSelling = node.selectSingleNode("ForexSelling").text
     
     'Response.Write "Döviz Kodu: " & currencyCode & "<br>"
     'Response.Write "Alış: " & forexBuying & "<br>"
     'Response.Write "Satış: " & forexSelling & "<br><br>"
 'Next

 Set sonuc =kurlar.getElementsByTagName("Currency" )
 response.write sonuc.length 
 For i = 0 to sonuc.length -1

 curr=sonuc.item(i).Attributes.getNamedItem("CurrencyCode").Text
 'response.write curr
 'response.end

 if curr="EUR" or curr="GBP" or curr="USD" then
 alis=sonuc.item(i).childnodes.item(3).nodeTypedValue
 satis=sonuc.item(i).childnodes.item(4).nodeTypedValue 
 if curr="EUR" then
Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(satis)&"' where pb='EURO'")
else
Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(satis)&"' where pb='"&curr&"'")
end if
end if
next 

'Set mmmYardimci3=Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(EURS)&"' where id='3'")

call islemmessagesession("green","Kurlar Güncellendi.",1)
 end sub

 Function EditCurrency(strCurrency)
 EditCurrency = Replace(strCurrency, "." , "," , 1, -1, 1)
 End Function 

sub KurGuncelle	
 Set kurlar = Server.CreateObject("msxml2.DOMDocument" )
 kurlar.async = false
 kurlar.resolveExternals = false
 kurlar.setProperty "ServerHTTPRequest" ,true
 kurlar.load("http://www.tcmb.gov.tr/kurlar/today.xml" )
 Set sonuc =kurlar.getElementsByTagName("Currency" )
 USDA=sonuc.item(0).childnodes.item(3).nodeTypedValue
 USDS=sonuc.item(0).childnodes.item(4).nodeTypedValue
 EURA=sonuc.item(3).childnodes.item(3).nodeTypedValue
 EURS=sonuc.item(3).childnodes.item(4).nodeTypedValue 
 
Set mmmYardimci3=Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(USDS)&"' where id='2'")
Set mmmYardimci3=Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(EURS)&"' where id='3'")
session("hata1")="Kurlar Güncellendi."
session("hatam1")="green"
 end sub

 sub KurGuncelleSite	

 ' MSXML nesnesini oluşturuyoruz
Set kurlar = Server.CreateObject("msxml2.DOMDocument" )
kurlar.async = false
kurlar.resolveExternals = false
kurlar.setProperty "ServerHTTPRequest", true

' ECB'nin döviz kuru XML dosyasını yüklüyoruz
kurlar.load("https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")

' EUR/TRY kurlarını almak için "Cube/Cube" öğesini seçiyoruz
Set oNode = kurlar.selectSingleNode("//Cube/Cube")

' Döviz kuru listesine ulaşmak için "Cube" etiketlerini seçiyoruz
Set sonuc = oNode.getElementsByTagName("Cube")
 
 eurToTry = 1 ' Euro, her zaman 1 kabul ediliyor

 For i = 0 To sonuc.length - 1
 strCurrency = sonuc(i).Attributes.getNamedItem("currency").Text
 strRate = replace((sonuc(i).Attributes.getNamedItem("rate").Text),".",",")
 
 ' EUR/TRY'nin kuru
 If strCurrency = "TRY" Then
     eurToTry = strRate
 End If
Next

For i = 0 To sonuc.length - 1
 strCurrency = sonuc(i).Attributes.getNamedItem("currency").Text
 strRate = replace((sonuc(i).Attributes.getNamedItem("rate").Text),".",",")
 
 ' USD'yi Türk Lirasına çevir
 If strCurrency = "USD" Then
     usdToTry = round(eurToTry / strRate,4) ' USD/TRY = USD/EUR * EUR/TRY
 End If
 
 ' GBP'yi Türk Lirasına çevir
 If strCurrency = "GBP" Then
     gbpToTry = round(eurToTry / strRate,4) ' GBP/TRY = GBP/EUR * EUR/TRY
 End If
Next

Con.execute("update "&dbsparabirimi&" set kur='1' where pb='TRY'")
Con.execute("update "&dbsparabirimi&" set kur='"&eurToTry&"' where pb='EURO'")
Con.execute("update "&dbsparabirimi&" set kur='"&usdToTry&"' where pb='USD'")
Con.execute("update "&dbsparabirimi&" set kur='"&gbpToTry&"' where pb='GBP'")

set kurlar = nothing 
'response.end
call islemmessagesession("green","EURBank Kurlar Güncellendi.",1)

end sub


    sub KurGuncelleSite1
    
     Set kurlar = Server.CreateObject("msxml2.DOMDocument" )
 kurlar.async = false
 kurlar.resolveExternals = false
 kurlar.setProperty "ServerHTTPRequest" ,true
 'kurlar.load("http://www.tcmb.gov.tr/kurlar/today.xml")
 kurlar.load("https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml" )
    Set oNode = kurlar.selectSingleNode("//Cube/Cube")
    'response.write oNode.Attributes.getNamedItem("currency").Text
 Set sonuc =oNode.getElementsByTagName("Cube")
    For i = 0 to sonuc.length -1
    strcurrency= sonuc(i).Attributes.getNamedItem("currency").Text
    strrate= sonuc(i).Attributes.getNamedItem("rate").Text
    response.write ("select id from "&dbsparabirimi&" where pb='"&strcurrency&"'<br>")
    set mmmGenel = Con.Execute ("select id from "&dbsparabirimi&" where pb='"&strcurrency&"'")
if mmmGenel.eof then
Con.execute("insert into "&dbsparabirimi&" set kur='"&EditCurrency(strrate)&"', pb='"&strcurrency&"', dovizad='"&strcurrency&"', vpb='0', onay='0', tarih='"&now&"'")
    else
    if strcurrency="EURO" then
    Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(strrate)&"' where pb='TRY' and id='"&mmmGenel("id")&"'")
    response.write (EditCurrency(strrate)&"-1-<br><br><br>")
    elseif strcurrency="TRY" then
    Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(strrate)&"' where pb='EURO' and id='"&mmmGenel("id")&"'")
    response.write (EditCurrency(strrate)&"-2-<br><br><br>")
    else
    Con.execute("update "&dbsparabirimi&" set kur='"&EditCurrency(strrate)&"' where (pb<>'TRY' or pb='EURO') and id='"&mmmGenel("id")&"'")
    response.write (EditCurrency(strrate)&"-3-<br><br><br>")
    end if
    end if
    close(mmmGenel)
    next 

set kurlar = nothing 
response.end
call islemmessagesession("green","EURBank Kurlar Güncellendi.",1)

 end sub

    sub turayaral
        Dim objFSO
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Open the text file
Dim objTextStream
Set objTextStream = objFSO.OpenTextFile(Server.MapPath("../contents/configtour.inc"), 2, True)

'Display the contents of the text file

set mmmGenel = Con.Execute ("select tourjson from tasarim where aktif = '1'" )
if mmmGenel.eof then
else
strtourcnt=mmmGenel("tourjson")
    
        if instr(strtourcnt,"{") then
    Set oJSON = New aspJSON
    oJSON.loadJSON(strtourcnt)
      set kbstr = oJSON.data
             for each odail in kbstr
                Set this = kbstr(odail)(0)
             strtourcntcode=this("Code")
             strtourcntbaslik=this("Title")
             strtourcntdeger=this("Value")
    
objTextStream.WriteLine ""&strtourcntcode&"='"&strtourcntdeger&"'"
    next
    end if
    end if
    close(mmmGenel)
    
    end sub

sub ayaral
        Dim objFSO
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Open the text file
Dim objTextStream
Set objTextStream = objFSO.OpenTextFile(Server.MapPath("../contents/config.inc"), 2, True)

'Display the contents of the text file


objTextStream.WriteLine "internetadresi='"&Request.ServerVariables("SERVER_NAME")&"'"
if Request.ServerVariables ("HTTPS")="on" then
objTextStream.WriteLine "siteadres='https://"&Request.ServerVariables("SERVER_NAME")&"/'"
else
objTextStream.WriteLine "siteadres='http://"&Request.ServerVariables("SERVER_NAME")&"/'"
end if
objTextStream.WriteLine "ipadresiniz='"&Request.ServerVariables("REMOTE_ADDR")&"'"
objTextStream.WriteLine "sitelink='"&siteadres&"'"
    set mmmGenel = Con.Execute ("select * from tasarim where aktif = '1'" )
if mmmGenel.eof then
else
objTextStream.WriteLine "pager='"&mmmGenel("d1")&"'"
objTextStream.WriteLine "d2='"&mmmGenel("d2")&"'"
objTextStream.WriteLine "haberd7='"&mmmGenel("d7")&"'"
objTextStream.WriteLine "rehberd8='"&mmmGenel("d8")&"'"
objTextStream.WriteLine "d5='"&mmmGenel("d5")&"'"
'objTextStream.WriteLine "d6='"&mmmGenel("d6")&"'"
objTextStream.WriteLine "d42='"&mmmGenel("d42")&"'"
objTextStream.WriteLine "imgyazaryol='"&mmmGenel("d54")&"'"
objTextStream.WriteLine "imghaberyol='"&mmmGenel("d28")&"'"
objTextStream.WriteLine "alttur='"&mmmGenel("d43")&"'"
objTextStream.WriteLine "usttur='"&mmmGenel("d3")&"'"
objTextStream.WriteLine "slidetur='"&mmmGenel("d51")&"'"
objTextStream.WriteLine "slidehiz='"&mmmGenel("d53")&"'"
objTextStream.WriteLine "ekcontentspath='"&mmmGenel("d11")&"'"
ekcontentspath=mmmGenel("d11")
objTextStream.WriteLine "vdil='"&mmmGenel("d58")&"'"
objTextStream.WriteLine "syenile='"&mmmGenel("d59")&"'"
objTextStream.WriteLine "versiontag='"&mmmGenel("d60")&"'"
objTextStream.WriteLine "ortatur='"&mmmGenel("anauadet")&"'"
strheadercnt=mmmGenel("headercnt")
strsocialcnt=mmmGenel("havale")

objTextStream.WriteLine "webadres='"&mmmGenel("icq")&"'"
objTextStream.WriteLine "sitetel='"&mmmGenel("tel")&"'"
objTextStream.WriteLine "siteemail='"&mmmGenel("info")&"'"
objTextStream.WriteLine "sitefax='"&mmmGenel("fax")&"'"
objTextStream.WriteLine "title='"&server.HTMLEncode(mmmGenel("title"))&"'"
objTextStream.WriteLine "desc='"&server.HTMLEncode(mmmGenel("aciklama"))&"'"
objTextStream.WriteLine "sitesahip='"&server.HTMLEncode(mmmGenel("sahip"))&"'"
    objTextStream.WriteLine "versionjscss='"&versiontag&"'"
ekcloudpath=mmmGenel("usttur")
    if ekcloudpath="" or isNull(ekcloudpath) or instr(ekcloudpath,"://")="0" then
cloudpath="https://cloudgrafike.cubecdn.net/"
    else
    cloudpath=ekcloudpath
    end if
'cloudpath="https://cdn.cloudgrafike.com/"
objTextStream.WriteLine "cloudpath='"&cloudpath&"'"
contentspath=ekcontentspath&"/contents/"
objTextStream.WriteLine "contentspath='"&ekcontentspath&"/contents/'"
    'header_json=hdrcntrplc(csskont1(verial(siteadres&""&contentspath&"json/settings/header.json?version="&versionjscss&"")),contentspath,cloudpath,versionjscss)
    header_json=hdrcntrplc(strheadercnt,contentspath,cloudpath,versionjscss)
    'response.Write header_json
        if instr(header_json,"{") then
    Set oJSON = New aspJSON
    oJSON.loadJSON(header_json)
      objTextStream.WriteLine "web_fonts='"&server.HTMLEncode(csskont(oJSON.data("web-fonts")(0)("Value")))&"'"
objTextStream.WriteLine "vendor_css='"&server.HTMLEncode(csskont(oJSON.data("vendor-css")(0)("Value")))&"'"
objTextStream.WriteLine "theme_css='"&server.HTMLEncode(csskont(oJSON.data("theme-css")(0)("Value")))&"'"
objTextStream.WriteLine "current_page_css='"&server.HTMLEncode(csskont(oJSON.data("current-page-css")(0)("Value")))&"'"
objTextStream.WriteLine "current_template_css='"&server.HTMLEncode(csskont(oJSON.data("current-temp-css")(0)("Value")))&"'"
objTextStream.WriteLine "skin_css='"&server.HTMLEncode(csskont(oJSON.data("skin-css")(0)("Value")))&"'"
objTextStream.WriteLine "theme_custom_css='"&server.HTMLEncode(csskont(oJSON.data("theme-custom-css")(0)("Value")))&"'"
objTextStream.WriteLine "vendor_js='"&server.HTMLEncode(csskont(oJSON.data("vendor-js")(0)("Value")))&"'"
objTextStream.WriteLine "theme_base_components_settings='"&server.HTMLEncode(csskont(oJSON.data("theme-base-components-and-settings")(0)("Value")))&"'"
objTextStream.WriteLine "current_page_vendor_views='"&server.HTMLEncode(csskont(oJSON.data("current-page-vendor-and-views")(0)("Value")))&"'"
objTextStream.WriteLine "current_theme_js='"&server.HTMLEncode(csskont(oJSON.data("current-temp-js")(0)("Value")))&"'"
objTextStream.WriteLine "theme_custom_js='"&server.HTMLEncode(csskont(oJSON.data("theme-custom-js")(0)("Value")))&"'"
objTextStream.WriteLine "admin_css='"&server.HTMLEncode(csskont(oJSON.data("admin-css")(0)("Value")))&"'"
objTextStream.WriteLine "admin_js='"&server.HTMLEncode(csskont(oJSON.data("admin-js")(0)("Value")))&"'"
    if isobject(oJSON.data("html_tag")) then
objTextStream.WriteLine "html_tag='"&oJSON.data("html-tag")(0)("Value")&"'"
    end if
    if isobject(oJSON.data("cdnstatu")) then
objTextStream.WriteLine "cdnstatu='"&oJSON.data("cdnstatu")(0)("Value")&"'"
    end if
    else
    end if

    sqlstring="select id,ceviricode from diller1 where alt = '1' and nott = '1'"
    Set mmmYardimci=Con.execute(sqlstring)
    if mmmYardimci.eof then
    
        aktifdil=240
        ceviridilek="tr"
        objTextStream.WriteLine "default_lang='"&aktifdil&"-"&ceviridilek&"'"
    else
        aktifdil=mmmYardimci("id")
        ceviridilek=mmmYardimci("ceviricode")

        objTextStream.WriteLine "default_lang='"&aktifdil&"-"&ceviridilek&"'"

    end if
    Close(mmmYardimci)
    
    'social_api_json=hdrcntrplc(csskont1(verial(siteadres&""&contentspath&"json/settings/social_api.json?version="&versionjscss&"")),contentspath,cloudpath,versionjscss)
    social_api_json=hdrcntrplc(strsocialcnt,contentspath,cloudpath,versionjscss)
    if instr(social_api_json,"{") then
    Set oJSON = New aspJSON
    oJSON.loadJSON(social_api_json)
       objTextStream.WriteLine "faceid='"&server.HTMLEncode(csskont(oJSON.data("facebook-app-id")(0)("Value")))&"'"
    objTextStream.WriteLine "facesecret='"&server.HTMLEncode(csskont(oJSON.data("facebook-app-secret")(0)("Value")))&"'"
    objTextStream.WriteLine "facefan='"&server.HTMLEncode(csskont(oJSON.data("facebook-fan")(0)("Value")))&"'"
    objTextStream.WriteLine "facekid='"&server.HTMLEncode(csskont(oJSON.data("facebook-kullanici-adi")(0)("Value")))&"'"
    objTextStream.WriteLine "twitterid='"&server.HTMLEncode(csskont(oJSON.data("twitter-app-id")(0)("Value")))&"'"
    objTextStream.WriteLine "twitterfan='"&server.HTMLEncode(csskont(oJSON.data("twitter-fan")(0)("Value")))&"'"
    objTextStream.WriteLine "twitterkadi='"&server.HTMLEncode(csskont(oJSON.data("twitter-kullanici-adi")(0)("Value")))&"'"
    objTextStream.WriteLine "instagramkadi='"&server.HTMLEncode(csskont(oJSON.data("instagram-kullanici-adi")(0)("Value")))&"'"
    objTextStream.WriteLine "pinterestkadi='"&server.HTMLEncode(csskont(oJSON.data("pinterest-kullanici-adi")(0)("Value")))&"'"
    objTextStream.WriteLine "linkedinkadi='"&server.HTMLEncode(csskont(oJSON.data("linkedin-kullanici-adi")(0)("Value")))&"'"
    objTextStream.WriteLine "ganalytics='"&server.HTMLEncode(csskont(oJSON.data("google-analytics")(0)("Value")))&"'"
    objTextStream.WriteLine "gvmvar='"&server.HTMLEncode(csskont(oJSON.data("google-vm-araclari")(0)("Value")))&"'"
    objTextStream.WriteLine "zopim='"&server.HTMLEncode(csskont(oJSON.data("zopim")(0)("Value")))&"'"
    objTextStream.WriteLine "googletag='"&server.HTMLEncode(csskont(oJSON.data("google-tag-head")(0)("Value")))&"'"
    objTextStream.WriteLine "googletagbody='"&server.HTMLEncode(csskont(oJSON.data("google-tag-body")(0)("Value")))&"'"
    objTextStream.WriteLine "fmcode='"&server.HTMLEncode(csskont(oJSON.data("facebook-messanger")(0)("Value")))&"'"
    objTextStream.WriteLine "head_whatsapp='"&server.HTMLEncode(csskont(oJSON.data("whatsapp")(0)("Value")))&"'"
    if isobject(oJSON.data("youtube-kanali")) then
    objTextStream.WriteLine "youtube_kanali='"&server.HTMLEncode(csskont(oJSON.data("youtube-kanali")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("tik-tok-kullanici-adi")) then
    objTextStream.WriteLine "tik_tok_kullanici_adi='"&server.HTMLEncode(csskont(oJSON.data("tik-tok-kullanici-adi")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("tripadvisor-oneri")) then
    objTextStream.WriteLine "recomended_tripadvisor='"&server.HTMLEncode(csskont(oJSON.data("tripadvisor-oneri")(0)("Value")))&"'"
    'objTextStream.WriteLine "recomended_tripadvisor='"&server.HTMLEncode(csskont(oJSON.data("tripadvisor-oneri")(0)("Value")))&"'"
    end if    
    if isobject(oJSON.data("tursab")) then
    objTextStream.WriteLine "tursab_belgesi='"&server.HTMLEncode(csskont(oJSON.data("tursab")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("body-attr")) then
    objTextStream.WriteLine "body_attr='"&server.HTMLEncode(csskont(oJSON.data("body-attr")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("head-oncesi-veri")) then
    'objTextStream.WriteLine "head_oncesi_veri='"&server.HTMLEncode(configkont(oJSON.data("head-oncesi-veri")(0)("Value")))&"'"
    objTextStream.WriteLine "head_oncesi_veri='"&server.HTMLEncode(csskont(oJSON.data("head-oncesi-veri")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("head-son-oncesi-veri")) then
    'objTextStream.WriteLine "head_oncesi_son_veri='"&server.HTMLEncode(configkont(oJSON.data("head-son-oncesi-veri")(0)("Value")))&"'"
    objTextStream.WriteLine "head_oncesi_son_veri='"&server.HTMLEncode(csskont(oJSON.data("head-son-oncesi-veri")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("recaptcha3-secretkey")) then
    objTextStream.WriteLine "recaptcha3secretkey='"&server.HTMLEncode(configkont(oJSON.data("recaptcha3-secretkey")(0)("Value")))&"'"
    'objTextStream.WriteLine "recaptcha3secretkey=""6LfTiuMZAAAAAK-4eMa1maG-yJsq0iFKKAP5ud6h"""    
    end if
    if isobject(oJSON.data("recaptcha3-sitekey")) then
    objTextStream.WriteLine "recaptcha3sitekey='"&server.HTMLEncode(configkont(oJSON.data("recaptcha3-sitekey")(0)("Value")))&"'"
    'objTextStream.WriteLine "recaptcha3secretkey=""6LfTiuMZAAAAAK-4eMa1maG-yJsq0iFKKAP5ud6h"""    
    end if
    if isobject(oJSON.data("body-sonrasi-veri")) then
    objTextStream.WriteLine "body_sonrasi_veri='"&server.HTMLEncode(csskont(oJSON.data("body-sonrasi-veri")(0)("Value")))&"'"
    'objTextStream.WriteLine "body_sonrasi_veri='"&server.HTMLEncode(configkont(oJSON.data("body-sonrasi-veri")(0)("Value")))&"'"
    end if
    if isobject(oJSON.data("html-tag")) then
    objTextStream.WriteLine "html_tag='"&configkont(oJSON.data("html-tag")(0)("Value"))&"'"
    end if
    if isobject(oJSON.data("send-pulse-link")) then
    objTextStream.WriteLine "send_pulse_link='"&configkont(oJSON.data("send-pulse-link")(0)("Value"))&"'"
    end if
    if isobject(oJSON.data("cdnstatu")) then
    objTextStream.WriteLine "cdnstatu='"&configkont(oJSON.data("cdnstatu")(0)("Value"))&"'"
    end if
    
    else
    end if

    
end if
close(mmmGenel)

objTextStream.WriteLine "imggaleriyol='/contents/img/galeri/'"
objTextStream.WriteLine "imgyol='/contents/img/'"
imgyol="/contents/img/"
objTextStream.WriteLine "imgurunyol='"&imgyol&"/urun/'"
objTextStream.WriteLine "imgtemp='/contents/img/temp/'"
objTextStream.WriteLine "imgcssc='/contents/css/'"
objTextStream.WriteLine "imgyolboot='/contents/vendor/'"
objTextStream.WriteLine "imgyol1='contents/img/'"
    objTextStream.WriteLine "searchjsonpath='contents/json/'"
objTextStream.WriteLine "jsyol='/contents/js/'"
objTextStream.WriteLine "pathim='/'"

objTextStream.WriteLine "anasayfaid=835"

    
'Close the file and clean up
objTextStream.Close
Set objTextStream = Nothing
Set objFSO = Nothing
    end sub

sub ayaral1
        Dim objFSO
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Open the text file
Dim objTextStream
Set objTextStream = objFSO.OpenTextFile(Server.MapPath("../contents/config.inc"), 2, True)

'Display the contents of the text file


objTextStream.WriteLine "internetadresi='"&Request.ServerVariables("SERVER_NAME")&"';"
if Request.ServerVariables ("HTTPS")="on" then
objTextStream.WriteLine "siteadres='https://"&internetadresi&"/'"
else
objTextStream.WriteLine "siteadres='http://"&internetadresi&"/'"
end if
objTextStream.WriteLine "ipadresiniz='"&Request.ServerVariables("REMOTE_ADDR")&"';"
objTextStream.WriteLine "sitelink='"&siteadres&"';"
    set mmmGenel = Con.Execute ("select * from tasarim where aktif = '1'" )
if mmmGenel.eof then
else
objTextStream.WriteLine "pager='"&mmmGenel("d1")&"';"
objTextStream.WriteLine "d2='"&mmmGenel("d2")&"';"
objTextStream.WriteLine "haberd7='"&mmmGenel("d7")&"';"
objTextStream.WriteLine "rehberd8='"&mmmGenel("d8")&"';"
objTextStream.WriteLine "d5='"&mmmGenel("d5")&"';"
'objTextStream.WriteLine "d6='"&mmmGenel("d6")&"';"
objTextStream.WriteLine "d42='"&mmmGenel("d42")&"';"
objTextStream.WriteLine "imgyazaryol='"&mmmGenel("d54")&"';"
objTextStream.WriteLine "imghaberyol='"&mmmGenel("d28")&"';"
objTextStream.WriteLine "alttur='"&mmmGenel("d43")&"';"
objTextStream.WriteLine "usttur='"&mmmGenel("d3")&"';"
objTextStream.WriteLine "slidetur='"&mmmGenel("d51")&"';"
objTextStream.WriteLine "slidehiz='"&mmmGenel("d53")&"';"
objTextStream.WriteLine "ekcontentspath='"&mmmGenel("d11")&"';"
ekcontentspath=mmmGenel("d11")
objTextStream.WriteLine "syenile='"&mmmGenel("d59")&"';"
objTextStream.WriteLine "versiontag='"&mmmGenel("d60")&"';"
objTextStream.WriteLine "ortatur='"&mmmGenel("anauadet")&"';"
strheadercnt=mmmGenel("headercnt")
strsocialcnt=mmmGenel("havale")

objTextStream.WriteLine "webadres='"&mmmGenel("icq")&"';"
objTextStream.WriteLine "sitetel='"&mmmGenel("tel")&"';"
objTextStream.WriteLine "siteemail='"&mmmGenel("info")&"';"
objTextStream.WriteLine "sitefax='"&mmmGenel("fax")&"';"
objTextStream.WriteLine "title='"&mmmGenel("title")&"';"
objTextStream.WriteLine "desc='"&mmmGenel("aciklama")&"';"
objTextStream.WriteLine "sitesahip='"&mmmGenel("sahip")&"';"
        objTextStream.WriteLine "recaptcha3secretkey='6LfTiuMZAAAAAK-4eMa1maG-yJsq0iFKKAP5ud6h';"
    objTextStream.WriteLine "versionjscss='"&versiontag&"';"
cloudpath="https://cloudgrafike.cubecdn.net/"
objTextStream.WriteLine "cloudpath='https://cloudgrafike.cubecdn.net/';"
'cloudpath="https://cdn.cloudgrafike.com/"
contentspath=ekcontentspath&"/contents/"
objTextStream.WriteLine "contentspath='"&ekcontentspath&"/contents/';"
    'header_json=hdrcntrplc(csskont1(verial(siteadres&""&contentspath&"json/settings/header.json?version="&versionjscss&"")),contentspath,cloudpath,versionjscss)
    header_json=hdrcntrplc(strheadercnt,contentspath,cloudpath,versionjscss)
    'response.Write header_json
        if instr(header_json,"{") then
    Set oJSON = New aspJSON
    oJSON.loadJSON(header_json)
      objTextStream.WriteLine "web_fonts='"&server.HTMLEncode(configkont(oJSON.data("web-fonts")(0)("Value")))&"'"
objTextStream.WriteLine "vendor_css='"&server.HTMLEncode(configkont(oJSON.data("vendor-css")(0)("Value")))&"'"
objTextStream.WriteLine "theme_css='"&server.HTMLEncode(configkont(oJSON.data("theme-css")(0)("Value")))&"'"
objTextStream.WriteLine "current_page_css='"&server.HTMLEncode(configkont(oJSON.data("current-page-css")(0)("Value")))&"'"
objTextStream.WriteLine "current_template_css='"&server.HTMLEncode(configkont(oJSON.data("current-temp-css")(0)("Value")))&"'"
objTextStream.WriteLine "skin_css='"&server.HTMLEncode(configkont(oJSON.data("skin-css")(0)("Value")))&"'"
objTextStream.WriteLine "theme_custom_css='"&server.HTMLEncode(configkont(oJSON.data("theme-custom-css")(0)("Value")))&"'"
objTextStream.WriteLine "vendor_js='"&server.HTMLEncode(configkont(oJSON.data("vendor-js")(0)("Value")))&"'"
objTextStream.WriteLine "theme_base_components_settings='"&server.HTMLEncode(configkont(oJSON.data("theme-base-components-and-settings")(0)("Value")))&"'"
objTextStream.WriteLine "current_page_vendor_views='"&server.HTMLEncode(configkont(oJSON.data("current-page-vendor-and-views")(0)("Value")))&"'"
objTextStream.WriteLine "current_theme_js='"&server.HTMLEncode(configkont(oJSON.data("current-temp-js")(0)("Value")))&"'"
objTextStream.WriteLine "theme_custom_js='"&server.HTMLEncode(configkont(oJSON.data("theme-custom-js")(0)("Value")))&"'"
objTextStream.WriteLine "admin_css='"&server.HTMLEncode(configkont(oJSON.data("admin-css")(0)("Value")))&"'"
objTextStream.WriteLine "admin_js='"&server.HTMLEncode(configkont(oJSON.data("admin-js")(0)("Value")))&"'"
    if isobject(oJSON.data("html-tag")) then
objTextStream.WriteLine "html_tag='"&oJSON.data("html-tag")(0)("Value")&"';"
    end if
    else
    end if
    
    'social_api_json=hdrcntrplc(csskont1(verial(siteadres&""&contentspath&"json/settings/social_api.json?version="&versionjscss&"")),contentspath,cloudpath,versionjscss)
    social_api_json=hdrcntrplc(strsocialcnt,contentspath,cloudpath,versionjscss)
    if instr(social_api_json,"{") then
    Set oJSON = New aspJSON
    oJSON.loadJSON(social_api_json)
       objTextStream.WriteLine "faceid='"&oJSON.data("facebook-app-id")(0)("Value")&"';"
    objTextStream.WriteLine "facesecret='"&oJSON.data("facebook-app-secret")(0)("Value")&"';"
    objTextStream.WriteLine "facefan='"&oJSON.data("facebook-fan")(0)("Value")&"';"
    objTextStream.WriteLine "facekid='"&oJSON.data("facebook-kullanici-adi")(0)("Value")&"';"
    objTextStream.WriteLine "twitterid='"&oJSON.data("twitter-app-id")(0)("Value")&"';"
    objTextStream.WriteLine "twitterfan='"&oJSON.data("twitter-fan")(0)("Value")&"';"
    objTextStream.WriteLine "twitterkadi='"&oJSON.data("twitter-kullanici-adi")(0)("Value")&"';"
    objTextStream.WriteLine "instagramkadi='"&oJSON.data("instagram-kullanici-adi")(0)("Value")&"';"
    objTextStream.WriteLine "pinterestkadi='"&oJSON.data("pinterest-kullanici-adi")(0)("Value")&"';"
    objTextStream.WriteLine "linkedinkadi='"&oJSON.data("linkedin-kullanici-adi")(0)("Value")&"';"
    objTextStream.WriteLine "ganalytics='"&oJSON.data("google-analytics")(0)("Value")&"';"
    objTextStream.WriteLine "gvmvar='"&oJSON.data("google-vm-araclari")(0)("Value")&"';"
    objTextStream.WriteLine "zopim='"&oJSON.data("zopim")(0)("Value")&"';"
    objTextStream.WriteLine "googletag='"&oJSON.data("google-tag-head")(0)("Value")&"';"
    objTextStream.WriteLine "googletagbody='"&oJSON.data("google-tag-body")(0)("Value")&"';"
    objTextStream.WriteLine "fmcode='"&oJSON.data("facebook-messanger")(0)("Value")&"';"
    objTextStream.WriteLine "head_whatsapp='"&oJSON.data("whatsapp")(0)("Value")&"';"
    if isobject(oJSON.data("tripadvisor-oneri")) then
    objTextStream.WriteLine "recomended_tripadvisor='"&oJSON.data("tripadvisor-oneri")(0)("Value")&"';"
    'objTextStream.WriteLine "recomended_tripadvisor='"&server.HTMLEncode(csskont(oJSON.data("tripadvisor-oneri")(0)("Value")))&"';"
    end if    
    if isobject(oJSON.data("tursab")) then
    objTextStream.WriteLine "tursab_belgesi='"&oJSON.data("tursab")(0)("Value")&"';"
    end if
    if isobject(oJSON.data("body-attr")) then
    objTextStream.WriteLine "body_attr='"&server.HTMLEncode(configkont(oJSON.data("body-attr")(0)("Value")))&"';"
    end if
    if isobject(oJSON.data("head-oncesi-veri")) then
    objTextStream.WriteLine "head_oncesi_veri='"&oJSON.data("head-oncesi-veri")(0)("Value")&"';"
    'objTextStream.WriteLine "head_oncesi_veri='"&server.HTMLEncode(csskont(oJSON.data("head-oncesi-veri")(0)("Value")))&"';"
    end if
    if isobject(oJSON.data("head-son-oncesi-veri")) then
    objTextStream.WriteLine "head_oncesi_son_veri='"&oJSON.data("head-son-oncesi-veri")(0)("Value")&"';"
    'objTextStream.WriteLine "head_oncesi_son_veri='"&server.HTMLEncode(csskont(oJSON.data("head-son-oncesi-veri")(0)("Value")))&"';"
    end if
    if isobject(oJSON.data("body-sonrasi-veri")) then
    'objTextStream.WriteLine "body_sonrasi_veri='"&server.HTMLEncode(csskont(oJSON.data("body-sonrasi-veri")(0)("Value")))&"';"
    objTextStream.WriteLine "body_sonrasi_veri='"&oJSON.data("body-sonrasi-veri")(0)("Value")&"';"
    end if
    if isobject(oJSON.data("send-pulse-link")) then
    'objTextStream.WriteLine "body_sonrasi_veri='"&server.HTMLEncode(csskont(oJSON.data("body-sonrasi-veri")(0)("Value")))&"';"
    objTextStream.WriteLine "send_pulse_link='"&oJSON.data("send-pulse-link")(0)("Value")&"';"
    end if
    if isobject(oJSON.data("cdnstatu")) then
    objTextStream.WriteLine "cdnstatu='"&configkont(oJSON.data("cdnstatu")(0)("Value"))&"'"
    end if
    
    else
    end if

    
end if
close(mmmGenel)

objTextStream.WriteLine "imggaleriyol='/contents/img/galeri/';"
objTextStream.WriteLine "imgyol='/contents/img/';"
imgyol="/contents/img/"
objTextStream.WriteLine "imgurunyol='"&imgyol&"/urun/';"
objTextStream.WriteLine "imgtemp='/contents/img/temp/';"
objTextStream.WriteLine "imgcssc='/contents/css/';"
objTextStream.WriteLine "imgyolboot='/contents/vendor/';"
objTextStream.WriteLine "imgyol1='contents/img/';"
    objTextStream.WriteLine "searchjsonpath='contents/json/';"
objTextStream.WriteLine "jsyol='/contents/js/';"
objTextStream.WriteLine "pathim='/';"

objTextStream.WriteLine "anasayfaid='835'"

    
'Close the file and clean up
objTextStream.Close
Set objTextStream = Nothing
Set objFSO = Nothing
    end sub


sub cachepage
    Response.ContentType = "text/html" 
Response.Charset = "UTF-8" 
Response.Codepage = 65001 
%>
<meta charset="utf-8" />
<%
   ' response.Write ((""&imgyol&""&replace(request.QueryString("seolink"),siteadres,"")&""))
    'response.Write ((""&imgyol&""&replace(request.QueryString("seolink"),siteadres,"")&""))
    cachepageveri=verial(request.QueryString("seolink")&"?yeni="&now&"&cachesiz=1")
    'response.Write cachepageveri
    Dim objFSO
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Open the text file
   ' response.Write imgyol&""&replace(request.QueryString("seolink"),siteadres,"")
    'response.End
Dim objTextStream
Set objTextStream = objFSO.OpenTextFile(Server.MapPath(""&imgyol&""&replace(request.QueryString("seolink"),siteadres,"")&""), 2, True)

'Display the contents of the text file
objTextStream.WriteLine cachepageveri

'Close the file and clean up
objTextStream.Close
Set objTextStream = Nothing
Set objFSO = Nothing

    'response.End
    cachepageveri=replace(cachepageveri,"'","`")
    sqlString = "select * from cachepage where pageid="&request.QueryString("aid")&""
Set mmmGenel=Con.execute(sqlString)
    if mmmGenel.eof then
    sqlstring="insert cachepage set cachepage='"&cachepageveri&"', pageid='"&request.QueryString("aid")&"', seolink='"&request.QueryString("seolinkim")&"', date='"&now()&"'"
    else
    sqlstring="update cachepage set cachepage='"&cachepageveri&"', seolink='"&request.QueryString("seolinkim")&"', date=now() where pageid='"&request.QueryString("aid")&"'"
    end if
    close(mmmGenel)
    Con.execute(sqlstring)
    
session("hatam1")="green"
session("hata1")="Sayfa Cache Alındı"
    end sub

sub skyduzenle
if request.QueryString("sky")="2" then
if request.QueryString("islemtur")="sayfasil" then
sqlString = "select * from kategoriyazi where id="&request.QueryString("skyid")&""
Set mmmGenel=Con.execute(sqlString)
Do While Not mmmGenel.EOF

sqlString = "select * from kategoriyazi where anasek='"&mmmGenel("id")&"'"
Set mmmYardimci=Con.execute(sqlString)
Do While Not mmmYardimci.EOF


silmek = "delete from kategoriayar where adres='"&mmmYardimci("id")&"'"
Con.execute(silmek)

silmek = "delete from kategoriyazi where bagli="&mmmYardimci("id")&""
Con.execute(silmek)

sqlString = "select * from yazilar where kategori='"&mmmYardimci("id")&"'"
Set mmmYardimci1=Con.execute(sqlString)
Do While Not mmmYardimci1.EOF


silmek = "delete from ozellikler2 where kateid='"&mmmYardimci1("id")&"'"
Con.execute(silmek)
sqlString = "select * from resimd where baslik='"&mmmYardimci1("id")&"'"
Set mmmYardimci2=Con.execute(sqlString)
if mmmYardimci2.eof then
else
resimsili=mmmYardimci2("resimid")
end if
close(mmmYardimci2)
silmek = "delete from resimd where baslik='"&mmmYardimci1("id")&"'"
Con.execute(silmek)
  
silmek = "delete from yazilar where bagli="&mmmYardimci1("id")&""
Con.execute(silmek)
mmmYardimci1.MoveNext
  loop
  close(mmmYardimci1)
  
silmek = "delete from yazilar where kategori='"&mmmYardimci("id")&"'"
Con.execute(silmek)

  mmmYardimci.MoveNext
  loop
  close(mmmYardimci)

silmek = "delete from kategoriyazi where anasek='"&mmmGenel("id")&"'"
Con.execute(silmek)
mmmGenel.MoveNext
  loop
  close(mmmGenel)

silmek = "delete from kategoriyazi where id="&request.QueryString("skyid")&""
Con.execute(silmek)


sqlString = "select * from yazilar where kategori='"&request.QueryString("skyid")&"'"
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF

sqlString = "select * from resimd where baslik='"&mmmGenel("id")&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")
end if
close(mmmYardimci)
silmek = "delete from resimd where baslik='"&mmmGenel("id")&"'"
Con.execute(silmek)

mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)

silmek = "delete from yazilar where kategori='"&request.QueryString("skyid")&"'"
Con.execute(silmek)

silmek = "delete from kategoriayar where adres='"&request.QueryString("skyid")&"'"
Con.execute(silmek)

silmek = "delete from kategoriyazi where bagli="&request.QueryString("skyid")&""
Con.execute(silmek)


session("hata1")="Sayfa Silindi"
elseif request.QueryString("islemtur")="yazisil" then
sqlString = "select * from yazilar where id="&request.QueryString("skyid")&""
Set mmmGenel=Con.execute(sqlString)
if mmmGenel.eof then
else
Do While Not mmmGenel.EOF

sqlString = "select * from resimd where baslik='"&mmmGenel("id")&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
resimsili=mmmYardimci("resimid")

end if
close(mmmYardimci)
silmek = "delete from resimd where baslik='"&mmmGenel("id")&"'"
Con.execute(silmek)

mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)
  
silmek = "delete from yazilar where id="&Request.QueryString("skyid")&""
Con.execute(silmek)

silmek = "delete from resimd where baslik='"&Request.QueryString("skyid")&"'"
Con.execute(silmek)

silmek = "delete from ozellikler2 where kateid='"&Request.QueryString("skyid")&"'"
Con.execute(silmek)
session("hata1")="Yazı Silindi"
else
end if
else
if request.QueryString("islemtur")="sky" then
skytablo="kategoriyazi"
skyagac="habertemp='"&Request.QueryString("sky")&"'"
session("hata1")="Sık Kullanılar Düzenlendi"
elseif request.QueryString("islemtur")="onaysayfa" then
skytablo="kategoriyazi"
skyagac="durum='"&Request.QueryString("sky")&"'"
session("hata1")="Sayfa Onayı Düzenlendi"
elseif request.QueryString("islemtur")="ustmenu" then
skytablo="kategoriyazi"
skyagac="menugosterim='"&Request.QueryString("sky")&"'"
session("hata1")="Üst Menu Gösterimi Düzenlendi"
elseif request.QueryString("islemtur")="onayyazi" then
skytablo="yazilar"
skyagac="durum='"&Request.QueryString("sky")&"'"
session("hata1")="Yazı Onayı Düzenlendi"
else
end if

Con.execute("update "&skytablo&" set "&skyagac&" where id="&request.QueryString("skyid")&"")
end if
session("hatam1")="green"
end sub
	  sub sayfakopyala
	  if request("kopyatur")="" then
	  sqlString = "select * from kategoriyazi where id="&request("kopyaid")&" order by sira desc"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
	  sqlString = "insert kategoriyazi set alt='"&mmmYardimci("alt")&"',anasek='"&mmmYardimci("anasek")&"',isim='"&mmmYardimci("isim")&" Kopya',link='"&mmmYardimci("link")&"',target='"&mmmYardimci("target")&"',durum='"&mmmYardimci("durum")&"',menugosterim='"&mmmYardimci("menugosterim")&"',sira='"&mmmYardimci("sira")&"',sira1='"&mmmYardimci("sira")&"',bagli='"&mmmYardimci("bagli")&"',dil='"&mmmYardimci("dil")&"',urunid='"&mmmYardimci("urunid")&"',facebookyorum='"&mmmYardimci("facebookyorum")&"',okusayi='"&mmmYardimci("okusayi")&"',yorum='"&mmmYardimci("yorum")&"',sosyal1='"&mmmYardimci("sosyal1")&"',sosyal2='"&mmmYardimci("sosyal2")&"',sitenekle='"&mmmYardimci("sitenekle")&"',habertemp='"&mmmYardimci("habertemp")&"',sayfatemp='"&mmmYardimci("sayfatemp")&"',sol='"&mmmYardimci("sol")&"',orta='"&mmmYardimci("orta")&"',sag='"&mmmYardimci("sag")&"',sayara='"&mmmYardimci("sayara")&"',smodula='"&mmmYardimci("smodula")&"',slider='"&mmmYardimci("slider")&"',baslikd='"&mmmYardimci("baslikd")&"',stura='"&mmmYardimci("stura")&"',modulmu='"&mmmYardimci("modulmu")&"',seolink='kopya-"&mmmYardimci("seolink")&"',title='"&mmmYardimci("title")&"',descri='"&mmmYardimci("descri")&"',keysi='"&mmmYardimci("keysi")&"',etiket='"&mmmYardimci("etiket")&"',sifreli='"&mmmYardimci("sifreli")&"',admin='"&mmmYardimci("admin")&"',tarih='"&now&"', seoanahtar='"&mmmYardimci("seoanahtar")&"', seohtml='"&mmmYardimci("seohtml")&"'"
Con.execute(sqlString)
end if
close(mmmYardimci)
else
end if
if request("kopyaeskisil")="1" then
kcek=request("dkate2")
anak=request.Form("kopyaid")
else
kcek=request.Form("kopyaid")
anak=request("dkate2")
end if
	  sqlString = "select * from kategoriyazi where id="&anak&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else
if request("kopyatur")="" then
sqlString = "kategoriyazi order by id desc"
Set mmmYardimci1=Con.execute(sqlString)
if mmmYardimci1.eof then
kidd="835"
else
kidd=mmmYardimci1("id")
end if
close(mmmYardimci1)
else
kidd=request("kopyaid")
dkate2=request("dkate2")
end if
Con.execute("update kategoriyazi set sayfatemp='"&mmmYardimci("sayfatemp")&"', sol='"&mmmYardimci("sol")&"' where id="&kcek&"")
end if
close(mmmYardimci)

session("hatam1")="green"
session("hata1")="Sayfa Kopyalandı"
	  end sub 	

sub kullDuzenle

if Request.Form("yetki")="" then
yetki = 0
else
yetki = Request.Form("yetki")
end if
sqlString = "update yonetici set adsoyad='"&Request.Form("adsoyad")&"',yetki= "&yetki&",email='"&Request.Form("email")&"',djid='"&Request.Form("urunid")&"',tarih='"&date&"' where id="&REQUEST("urunid")&""
Con.execute(sqlString)

if request("sifred")="1" then
sqlString = "SELECT * FROM yonetici where id="&request.Form("urunid")&" and sifre = '"&md5(request.Form("sifre"))&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
session("hata1")="Kullanıcı Adınız ve Şifrenizi Kontrol Edin."
session("hatam1")="red"
else
sqlString = "update yonetici set admin='"&request.form("yenkulad")&"',sifre= '"&md5(request.form("yensifre"))&"' where id="&REQUEST.Form("urunid")&""
Con.execute(sqlString)    
session("hata1")="Kullanıcı Düzenlendi ve şifre Bilgisi Güncellendi"
session("hatam1")="green"
end if
close(mmmYardimci)
'response.Write("<center><font color=""#CC0000""><strong>"&request("ad")&" Adlı Kişinin Bilgileri Yenilendi</strong></font></center")
else
session("hata1")="Kullanıcı Düzenlendi."
session("hatam1")="green"
end if
end sub

sub kulekle
sqlString = "insert yonetici set adsoyad='"&Request.Form("adsoyad")&"',admin='"&Request.Form("admin")&"',sifre='"&md5(Request.Form("sifre"))&"',yetki='"&Request.Form("yetki")&"',email='"&Request.Form("email")&"',tarih='"&date&"',durum='1'"
Con.execute(sqlString)

session("hata1")="Kullanıcı Eklendi"
session("hatam1")="green"
'response.Write("<center><font color=""#CC0000""><strong>"&request("ad")&" Adlı Kişi Kullanıcılar Listesine Eklendi</strong></font></center>")
end sub

sub kulDuzenle

For icntt = 1 To Request.Form("adsoyad").Count and Request.Form("urunid").Count and request.Form("admin").Count and request.Form("yetki").Count  and request.Form("durum").Count  and request.Form("email").Count 

sqlString = "update yonetici set adsoyad='"&Request.Form("adsoyad")(icntt)&"',admin='"&Request.Form("admin")(icntt)&"',yetki='"&Request.Form("yetki")(icntt)&"',durum='"&Request.Form("durum")(icntt)&"',email='"&Request.Form("email")(icntt)&"' where id="&request("urunid")(icntt)&""
Con.execute(sqlString)

next
if request("sifred")="1" then
sqlString = "SELECT * FROM yonetici where id="&request.Form("urunid")&" and sifre ='"&md5(request("sifre"))&"'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
response.write("Kullanıcı Adınız ve Şifrenizi Kontrol Edin.asd")
else
sqlString = "update yonetici set admin="&request.form("yenkulad")&",sifre="&md5(request.form("yensifre"))&" where id="&mmmYardimci("id")&""
end if
close(mmmYardimci)
'response.Write("<center><font color=""#CC0000""><strong>"&request("ad")&" Adlı Kişinin Bilgileri Yenilendi</strong></font></center")
else
end if
session("hata1")="Kullanıcılar Düzenlendi"
session("hatam1")="green"
end sub

sub kulSil

For r = 1 To Request.Form("urunidsil").Count

silmek = "delete from yonetici where id="&Request.Form("urunidsil")(r)&""
Con.execute(silmek)

next
session("hata1")="Kullanıcılar Silindi"
session("hatam1")="red"
end sub

sub modulsil
id = Request("id")

silmek = "delete from moduller where id="&id&""
Con1.execute(silmek)
session("hata1")="Modül Silindi"
session("hatam1")="red"
end sub

sub modulekle

sqlString = "insert moduller set moduladi='"&Request.Form("ad")&"',durum='"&Request.Form("yetki")&"',temp='"&Request.Form("yetki1")&"',tarih='"&date&"'"
Con1.execute(sqlString)

session("hata1")="Modül Eklendi"
session("hatam1")="green"
'response.Write("<center><font color=""#CC0000""><strong>"&request("ad")&" Adlı Sayfa Eklendi</strong></font></center>")
end sub

sub SilModul

For icntt = 1 To Request.Form("iceriksil").Count

silmek = "delete from moduller where id="&Request.Form("iceriksil")(icntt)&""
Con1.execute(silmek)
next
session("hata1")="Modüller Silindi"
session("hatam1")="red"
end sub

sub DuzenleModul

For icntt = 1 To Request.Form("onay").Count and Request.Form("moduladi").Count and Request.Form("urunid").Count and Request.Form("temp").Count
    sqlString = "update moduller set durum='"&request.Form("onay")(icntt)&"',moduladi= '"&request.Form("moduladi")(icntt)&"',temp='"&Request.Form("temp")(icntt)&"' where id="&request.Form("urunid")(icntt)&""
Con1.execute(sqlString)

next

session("hata1")="Modüller Düzenlendi"
session("hatam1")="green"
end sub

sub sayfatumDuzenle   
    if request.Form("seoturu")="yazi" then
    seostrid=request("urunid")
    strseotur="yazi"
    else
    seostrid=request("dkate2")
    strseotur="sayfa"
    end if
    
    yazibstr=csskont(request.Form("urun"))
    yazibstr1=yazibstr
    
    seomh1=csskont(Request.Form("seoh1"))
    seomtitle=csskont(Request.Form("title"))
    seomdesc=csskont(Request.Form("desc"))
    seomkey=csskont(Request.Form("key"))

    
    seomcanoncial=csskont(Request.Form("seocanoncial"))
    seomhraflang=csskont(Request.Form("seohraflang"))
    smidpdatastatu=csskont(Request.Form("smidpstatu"))
    smidpdata=csskont(Request.Form("smidpdata"))

        if giriskont(request.form("seolinkyenile"))="1" then
    
        if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" then 
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(yazibstr))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(yazibstr))&""&seosonu&""
    end if
    yazibstr=server.HTMLEncode(yazibstr)
    seomh1=server.HTMLEncode(seomh1)
    seomtitle=server.HTMLEncode(seomtitle)
    seomdesc=server.HTMLEncode(seomdesc)
    seomkey=server.HTMLEncode(seomkey)
else     
    seomlink=baslikkont(yazibstr)&""&seosonu&""
end if

    ' call seourlduzenle(baslikkont(Request.Form("sayfaadi"))&""&seosonu&"",request("dkate2"),"sayfa","240")
    else
            if Request("charcode")="ar" or Request("charcode")="cn" or Request("charcode")="ru" or Request("charcode")="az" then 
    if Request("charcode")="ru" then 
    seomlink=baslikkont(ruscyrltolat(Request.Form("seourl")))&""&seosonu&""
    else
    seomlink=server.HTMLEncode(baslikkont(Request.Form("seourl")))&""&seosonu&""
    end if
    yazibstr=server.HTMLEncode(yazibstr)
    seomh1=server.HTMLEncode(seomh1)
    seomtitle=server.HTMLEncode(seomtitle)
    seomdesc=server.HTMLEncode(seomdesc)
    seomkey=server.HTMLEncode(seomkey)
else     
    seomlink=baslikkont(Request.Form("seourl"))&""&seosonu&""
end if

    end if
    
    'response.Write seomlink
   ' response.End

    call seourlduzenle(seomlink,seostrid,strseotur,Request.Form("lang")) 
    
    'if Request.Form("seolar")="1" then
    sqlstring="update seolar set seoh1='"&seomh1&"',seobaslik='"&seomtitle&"',seoaciklama='"&seomdesc&"',seotag='"&seomkey&"', lang='"&csskont(Request.Form("lang"))&"', noindex='"&csskont(Request.Form("seonoindex"))&"', seoanahtar='"&(Request.Form("smidpcss"))&"', seohtml='"&(Request.Form("smidpjs"))&"', hraflang='"&seomhraflang&"', canoncial='"&seomcanoncial&"', structredstatu='"&smidpdatastatu&"', structred='"&smidpdata&"' where seoid='"&seostrid&"' and seoturu='"&strseotur&"'"

    Con.execute(sqlstring)
    'else
    'sqlstring="insert seolar set seoturu='"&strseotur&"', onay='1', seoid='"&giriskont(seostrid)&"', seobaslik='"&csskont(Request.Form("title"))&"',seoaciklama='"&csskont(Request.Form("desc"))&"',seotag='"&configkont(Request.Form("key"))&"', seoanahtar='"&configkont(Request.Form("smidpcss"))&"', seohtml='"&csskont(Request.Form("smidpjs"))&"', seolink='"&seomlink&""&seosonu&"', lang='"&giriskont(Request.Form("lang"))&"'"
    'Con.execute(sqlString)
    'end if

'call cssduzenlemodul sayfaekle
session("hata1")="Sayfa Seo Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub    

sub seourlduzenle(seourl,dkate2,seoturu,seolang) 
    if Request.Form("seourl")="" or giriskont(request.form("seolinkyenile"))="1" or giriskont(request.form("seolinkyenilebtn"))="1" then
    seomlink=baslikkont(seourl)
    else
    seomlink=Request.Form("seourl")
    end if
    if Request("urunid")="" then
    if Request("dkate2")="" or seoturu<>"sayfa" then
    dkate2=dkate2
    else
    dkate2=Request("dkate2")
    end if
    else    
    dkate2=Request("urunid")
    end if
    if Request("seoturu")="" then
    seoturu=seoturu
    else
    seoturu=Request("seoturu")
    end if
    

    sqlString = "SELECT * FROM seolar where seolink='"&seomlink&"' and seoid<>'"&dkate2&"' and seoturu='"&seoturu&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
seomlink= seomlink
else
seomlink= replace(seomlink,""&seosonu&"","")&"-"&dkate2&""&seosonu&""
end if
close(mmmYardimci)
    
    sqlString = "SELECT * FROM seolar where seoid='"&dkate2&"' and seoturu='"&seoturu&"'"
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
    sqlstring="insert seolar set seoturu='"&seoturu&"', onay='1', seoid='"&dkate2&"', seolink='"&seomlink&"', lang='"&seolang&"'"
    else
    sqlstring="update seolar set seoturu='"&seoturu&"', seolink='"&seomlink&"' where seoid='"&dkate2&"' and seoturu='"&seoturu&"'"
    end if
close(mmmYardimci)
Con.execute(sqlstring)

'call cssduzenlemodul sayfaekle
session("hata1")="Seo Düzenlendi"
session("hatam1")="green"
end sub


sub csskaydet1

con.Execute("update tasarim Set logocss='"&csskont(request.form("csstam"))&"' where id="&request("id")&"") 

session("hata1")="Tasarım Düzenlendi"
session("hatam1")="green"
Response.Redirect ("ortak_cssduzenle.asp?urunid="&request("id")&"&filtre=1")
end sub

sub csskaydet

if request("sonuc")="ekle1" then
    
con.Execute("update tasarim Set d1='"&request.form("d1")&"',d2='"&request.form("d2")&"',d3='"&request.form("d3")&"',d4='"&request.form("d4")&"',d5='"&request.form("d5")&"',d7='"&request.form("d7")&"',d25='"&request.form("d25")&"',d26='"&request.form("d26")&"',d27='"&request.form("d27")&"',d28='"&request.form("d28")&"',d59='"&request.form("d59")&"',d60='"&request.form("d60")&"',d42='"&request.form("d42")&"',d43='"&request.form("d43")&"',d51='"&request.form("d51")&"', d58='"&request.form("d58")&"', d53='"&request.form("d53")&"',d54='"&request.form("d54")&"',usttur='"&request.form("usttur")&"',anauadet='"&request.form("anauadet")&"',kateuadet='"&request.form("kateuadet")&"', info='"&request.form("info")&"', sahip='"&giriskont(request.form("unvan"))&"',adres='"&giriskont(request.form("adres"))&"',tel='"&request.form("tel")&"',fax='"&request.form("fax")&"',icq='"&request.form("icq")&"', title='"&giriskont(request.form("title"))&"', aciklama='"&giriskont(request.form("acik"))&"',d11='"&request.form("d11")&"' where id="&request("id")&"")
    
if request.form("tempsil")="1" then

Set Dosya_Sistemi=Server.CreateObject("Scripting.FileSystemObject" ) 
dst="../contents/css/temp_element/"
Set objFiles = Dosya_Sistemi.GetFolder(Server.MapPath(""&dst&"")).Files
For Each obj In objFiles
Dosya_Sistemi.DeleteFile(Server.MapPath(""&dst&""&obj.Name&""))
Next
dst="../contents/js/temp_element/"
Set objFiles = Dosya_Sistemi.GetFolder(Server.MapPath(""&dst&"")).Files
For Each obj In objFiles
Dosya_Sistemi.DeleteFile(Server.MapPath(""&dst&""&obj.Name&""))
Next
dst="../contents/css/temp/"
Set objFiles = Dosya_Sistemi.GetFolder(Server.MapPath(""&dst&"")).Files
For Each obj In objFiles
Dosya_Sistemi.DeleteFile(Server.MapPath(""&dst&""&obj.Name&""))
Next
dst="../contents/js/temp/"
Set objFiles = Dosya_Sistemi.GetFolder(Server.MapPath(""&dst&"")).Files
For Each obj In objFiles
Dosya_Sistemi.DeleteFile(Server.MapPath(""&dst&""&obj.Name&""))
Next
If (Dosya_Sistemi.FileExists(Server.MapPath("../contents/sitemap.xml")))=true Then
Dosya_Sistemi.DeleteFile(Server.MapPath("../contents/sitemap.xml"))
end if 
end if

if request.form("formsil")="1" then

silmek = "delete from ozellikler2"
Con.execute(silmek)

con.Execute("update formsmtp Set login='', password=''")

con.Execute("update formlar Set froms=''")
end if

if request.form("seolinksil")="1" then
silmek = "delete from seolink"
Con.execute(silmek)
end if 


if request.form("seolinktemizle")="1" then

sqlString = "select seolink,seoturu,seoid,id from seolar order by seoturu desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else   
Do While Not mmmGenel.EOF
strseoturu=mmmGenel("seoturu")
strseoid=mmmGenel("seoid")
strid=mmmGenel("id")

if strseoturu="sayfa" then
sqlString = "select id from kategoriyazi where id="&strseoid&""
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
silmek = "delete from seolar where id="&strid&""
Con.execute(silmek)
else
end if
close(mmmYardimci1)

elseif strseoturu="yazi" then  
sqlString = "select id from yazilar where id="&strseoid&""
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
silmek = "delete from seolar where id="&strid&""
Con.execute(silmek)
else
end if
close(mmmYardimci1)

else
end if
mmmGenel.MoveNext
       loop
       end if
       close(mmmGenel)

end if 

if request.form("hraflangsil")="1" then
con.Execute("update seolar Set hraflang=''")
end if 

if request.form("micerikduzelt")="1" then
con.Execute("update yazilar Set kategori='979' where kategori='' or isNull(kategori)")
end if

if instr(sistem_site_turu,"*tur*") then
if request.form("turlarsil")="1" then
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtturlar&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtgeziturlartarih&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtgeziturlarfiyat&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtturresim&" where resimturu='turgeziresim'")
set mmmYardimci2 = Con.Execute  ("delete from seolar where seoturu='tur-detay' or seoturu='transfer-detay' or seoturu='gulet-detay' or seoturu='hotel-detay' or seoturu='kirala-arac-detay'")
end if 

if request.form("turrezsil")="1" then
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtsiparis&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtsiparismesaj&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtsiparisfatura&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtsiparis_passenger&"")
end if 

if request.form("turmussil")="1" then
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtmember&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtclientm&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbtclientp&"")
end if 

if request.form("turyorsil")="1" then
set mmmYardimci2 = Contur.Execute  ("delete from "&dbreviews&"")
end if 

if request.form("tahsil")="1" then
set mmmYardimci2 = Contur.Execute  ("delete from "&dbktahsilatlar&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbphavale&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbshavale&"")
set mmmYardimci2 = Contur.Execute  ("delete from "&dbthavale&"")
end if 
end if 

else
end if

if request("sonuc")="header" then
  
    if request.form("headercnt").count=>1 then
    strheadercnt=""  
    Set oJSON = New aspJSON
With oJSON.data
    for rs=1 to Request.form("headercnt").count
    headercntbaslik1=request.form("headercntbaslik")(rs)
    headercntbaslik=headercntbaslik1
    if headercntbaslik<>"" then
    rss=cint(rs-1)
            .Add baslikkont(headercntbaslik), oJSON.Collection()      
       With .item(baslikkont(headercntbaslik))
    rssa=0
    .Add rssa, oJSON.Collection()
        With .item(rssa)
            .Add "Code", baslikkont(headercntbaslik)
            .Add "Title", Server.HTMLEncode(headercntbaslik1)
           ' .Add "Value", csskont(replace(request.form("headercnt")(rs),"``",""""))
            .Add "Value", configkont(request.form("headercnt")(rs))
        End With
      End With
    end if
    next 

End With
strheadercnt= oJSON.JSONoutput()
    end if
    
con.Execute("update tasarim Set headercnt='"&strheadercnt&"' where id="&request("id")&"")

else
end if

if request("sonuc")="social" then
  
    if request.form("socialcnt").count=>1 then
    strsocialcnt=""  
    Set oJSON = New aspJSON
With oJSON.data
    for rs=1 to Request.form("socialcnt").count
   'response.Write configkont(request.form("socialcnt")(rs))
    if request.form("socialcntbaslik")(rs)<>"" then
    rss=cint(rs-1)
            .Add baslikkont(request.form("socialcntbaslik")(rs)), oJSON.Collection()      
       With .item(baslikkont(request.form("socialcntbaslik")(rs)))
    rssa=0
    .Add rssa, oJSON.Collection()
        With .item(rssa)
            .Add "Code", baslikkont(request.form("socialcntbaslik")(rs))
            .Add "Title", Server.HTMLEncode(request.form("socialcntbaslik")(rs))
            '.Add "Value", csskont(replace(request.form("socialcnt")(rs),"``",""""))
            .Add "Value", configkont(request.form("socialcnt")(rs))
        End With
      End With
    end if
    next 

End With
strsocialcnt= oJSON.JSONoutput() 
    end if
    'response.End
con.Execute("update tasarim Set havale='"&strsocialcnt&"' where id="&request("id")&"")

else
end if

if request("sonuc")="ekle2" then
con.Execute("update tasarim Set d4='"&request.form("d4")&"',d5='"&request.form("d5")&"',d6='"&request.form("d6")&"',d7='"&request.form("d7")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle3" then
con.Execute("update tasarim Set d8='"&request.form("d8")&"',d9='"&request.form("d9")&"',d10='"&request.form("d10")&"',d19='"&request.form("d19")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle4" then
con.Execute("update tasarim Set d12='"&request.form("d12")&"',d38='"&request.form("d38")&"',d13='"&request.form("d13")&"',d14='"&request.form("d14")&"',d15='"&request.form("d15")&"',d16='"&request.form("d16")&"',d17='"&request.form("d17")&"',d18='"&request.form("d18")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle7" then

con.Execute("update tasarim Set d6='"&request.form("onay")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle8" then
con.Execute("update tasarim Set d25='"&request.form("d25")&"',d26='"&request.form("d26")&"',d27='"&request.form("d27")&"',d28='"&request.form("d28")&"',d29='"&request.form("d29")&"',d30='"&request.form("d30")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle9" then
con.Execute("update tasarim Set d31='"&request.form("d31")&"',d32='"&request.form("d32")&"',d33='"&request.form("d33")&"',d34='"&request.form("d34")&"',d35='"&request.form("d35")&"',d36='"&request.form("d36")&"',d37='"&request.form("d37")&"',d56='"&request.form("d56")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="ekle10" then
con.Execute("update tasarim Set d39='"&request.form("d39")&"',d40='"&request.form("d40")&"',d41='"&request.form("d41")&"',d42='"&request.form("d42")&"',d43='"&request.form("d43")&"',d44='"&request.form("d44")&"',d45='"&request.form("d45")&"',d46='"&request.form("d46")&"',d47='"&request.form("d47")&"',d48='"&request.form("d48")&"',d49='"&request.form("d49")&"',d50='"&request.form("d50")&"' where id="&request("id")&"")
else
end if

if request("sonuc")="languageupd" then
    For icntt = 1 To  Request.Form("charset").Count and Request.Form("sektor").Count
                if Request("charset")(icntt)="ar" or Request("charset")(icntt)="cn" or Request("charset")(icntt)="ru" or Request("charset")(icntt)="az" then 

    baslik=server.HTMLEncode(request.Form("sektor")(icntt))
else     
    baslik=request.Form("sektor")(icntt)
end if

con.Execute("update diller1 Set kate='"&baslik&"', nott='"&request.Form("buton1")(icntt)&"', ceviricode='"&request.Form("charset")(icntt)&"',sira='"&request.Form("buton")(icntt)&"',anasek='"&Request.form("durum")(icntt)&"' where id="&request.Form("id")(icntt)&"")
    next

session("hata1")="Diller Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
'response.write"<b>Dil Kayit Yenilendi</b><br>"

    end if

if request("sonuc")="currencyupd" then
    For icntt = 1 To  Request.Form("dovizad").Count and Request.Form("kur").Count
                
con.Execute("update "&dbsparabirimi&" Set dovizad='"&Request.Form("dovizad")(icntt)&"', pb='"&request.Form("pb")(icntt)&"', kur='"&request.Form("kur")(icntt)&"', vpb='"&Request.form("vpb")(icntt)&"', onay='"&Request.form("onay")(icntt)&"' where id="&request.Form("id")(icntt)&"")
    next

session("hata1")="Para Birimleri Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
'response.write"<b>Dil Kayit Yenilendi</b><br>"

    end if

if request("sonuc")="ekle11" then
     if request.form("tourcnt").count=>1 then
    strtourcnt=""  
    Set oJSON = New aspJSON
With oJSON.data
    for rs=1 to Request.form("tourcnt").count
    if request.form("tourcntbaslik")(rs)<>"" then
    rss=cint(rs-1)
            .Add baslikkont(request.form("tourcntbaslik")(rs)), oJSON.Collection()      
       With .item(baslikkont(request.form("tourcntbaslik")(rs)))
    rssa=0
    .Add rssa, oJSON.Collection()
        With .item(rssa)
            .Add "Code", baslikkont(request.form("tourcntbaslik")(rs))
            .Add "Title", Server.HTMLEncode(request.form("tourcntbaslik")(rs))
            '.Add "Value", csskont(replace(request.form("tourcnt")(rs),"``",""""))
            .Add "Value", csskont(request.form("tourcnt")(rs))
        End With
      End With
    end if
    next 

End With
strtourcnt= oJSON.JSONoutput() 
    end if

con.Execute("update tasarim Set tourjson='"&strtourcnt&"' where id="&request("id")&"")

    call turayaral
else
end if

    call ayaral

session("hata1")="Tasarım Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub

sub cssekle0

imgtempyol="../images/temp/"&request.QueryString("urunid")&"/"
Set Upload = Server.CreateObject("Persits.Upload.1") 
Upload.OverwriteFiles = true
Count = Upload.SaveToMemory 
For Each File in Upload.Files
If File.ImageType="UNKNOWN" then
Response.Write"<center><b>Dikkat ! Resim Formatı Haricinde Dosya Yükleyemessiniz.<br><br><a href=""javascript:history.back(-1)"">Yenile</a></b></center><td height=15></td>"
Response.end
end if
Min = 1
Max = 99999
Randomize
Sayilarresim = Int((Max - Min + 1) * Rnd + Min)	
Set File1 = Upload.Files(1)
Path = (Server.MapPath(""&imgtempyol&""&Replace(date, "." , "", 1, -1, 1)&""&Sayilarresim&"."&file.ImageType&""))

File.SaveAs Path

tip = trim(file.Filename) 

fname=""&Replace(date, "." , "", 1, -1, 1)&""&Sayilarresim&"."&file.ImageType&""
ressize=File.Size
resw=File.ImageWidth
resh=File.ImageHeight
rest=File.ImageType
Next	
session("hata1")="Tasarım Resmi Eklendi"
session("hatam1")="green"
Response.Redirect ("ortak_cssduzenle.asp?filtre=3&urunid="&request.QueryString("urunid")&"")
end sub

sub cssdosyasil
resim=request("isim")
Set FSO = CreateObject("Scripting.FileSystemObject" ) 
ResimPath1 = Server.MapPath("../images/temp/"&request.QueryString("urunid")&"/" & request.QueryString("isim") ) 
if FSO.FolderExists(ResimPath1) = true then
else
Set Dosya = FSO.GetFile(ResimPath1) 
Dosya.Delete 
end if
session("hata1")="Tasarım Resmi Silindi"
session("hatam1")="red"
end sub

sub csssite

sqlString = "SELECT * FROM tasarim where id="&request.QueryString("id")&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else

if request.QueryString("tur")="logocss" then

elseif request.QueryString("tur")="umenubuton2" then
con.Execute("update tasarim Set arkazeminrenk="&request.form("arkazeminrenk")&",menuzeminrenk="&request.form("menuzeminrenk")&",sliderzeminrenk="&request.form("sliderzeminrenk")&",baslikzeminrenk="&request.form("baslikzeminrenk")&",icerikzeminrenk="&request.form("icerikzeminrenk")&",altzeminrenk="&request.form("altzeminrenk")&",yazifont="&request.form("yazifont")&",umazemin="&request.form("umazemin")&",yanmenurenk="&request.form("yanmenurenk")&",yanmenurenk2="&request.form("yanmenurenk2")&",yazirengi="&request.form("yazirengi")&",yazilrengi="&request.form("yazilrengi")&",ifzeminrengi="&request.form("ifzeminrengi")&",ifyazirengi="&request.form("ifyazirengi")&" where id="&request.QueryString("id")&"")
else
end if
end if
close(mmmYardimci)
session("hata1")="Tasarım Düzenlendi"
session("hatam1")="green"
Response.Redirect Request.ServerVariables("HTTP_REFERER")
end sub


sub tasarimDuzenle

For icntt = 1 To  Request.Form("sayfaadi").Count and Request.Form("urunid").Count
sqlString = "update tasarim set baslik='"&request.Form("sayfaadi")(icntt)&"' where id="&request("urunid")(icntt)&""
Con.execute(sqlString)
next

session("hata1")="Tasarım Düzenlendi"
session("hatam1")="green"
end sub

sub tasarimSil

For r = 1 To Request.Form("urunidsil").Count

silmek = "delete from tasarim where id="&Request.Form("urunidsil")(r)&""
Con.execute(silmek)

next
session("hata1")="Tasarım Silindi"
session("hatam1")="red"
end sub

	
sub csskopya

if request("kopya")="" then
rs("baslik") = request.Form("sektor")
rs("d56") = 1
sqlString = "insert tasarim set baslik='"&request.Form("sektor")&"',d56='1'"
Con.execute(sqlString)
else
sqlString = "select * from tasarim where id="&request("kopya")&" order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
baslik=mmmGenel("baslik")&" Kopyası"
sqlString = "insert tasarim set baslik= '"&baslik&"', d6='"&mmmGenel("d6")&"',d8='"&mmmGenel("d8")&"',d19='"&mmmGenel("d19")&"',d20='"&mmmGenel("d20")&"',d21='"&mmmGenel("d21")&"',d22='"&mmmGenel("d22")&"',d23='"&mmmGenel("d23")&"',d24='"&mmmGenel("d24")&"',d57='"&mmmGenel("d57")&"',d1='"&mmmGenel("d1")&"',d54='"&mmmGenel("d54")&"',anauadet='"&mmmGenel("anauadet")&"',kateuadeet='"&mmmGenel("kateuadeet")&"',usttur='"&mmmGenel("usttur")&"',alttur='"&mmmGenel("alttur")&"',urundur='"&mmmGenel("urundur")&"',logocss='"&csskont(mmmGenel("logocss"))&"',havale='"&csskont(mmmGenel("havale"))&"',d56='1'"
Con.execute(sqlString)
sqlString = "select * from tasarim order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
set fs=Server.CreateObject("Scripting.FileSystemObject")
if fs.FolderExists(Server.MapPath("../images/temp/"&mmmYardimci("id")&"")) = true then
else
set f=fs.CreateFolder(Server.MapPath("../images/temp/"&mmmYardimci("id")&""))
set f=nothing
end if
set fs=nothing
end if
close(mmmYardimci)
end if
close(mmmGenel)

end if
session("hata1")="Tasarım Kopyalandı"
session("hatam1")="green"
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub

sub cssaktif
id = Request.QueryString("id")
sqlString = "update tasarim set aktif='0' where aktif = '1'"
Con.execute(sqlString)

sqlString = "update tasarim set aktif='1' where id="&id&""
Con.execute(sqlString)

session("hata1")="Tasarım Aktifleştirildi"
session("hatam1")="green"
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub



sub sayaraktar


Set mmmYardimci2=Con.execute("SELECT * FROM kategoriyazi where urunid<>'2'")
Do While Not mmmYardimci2.EOF
sai=sai+1
if sai=1 then
saara=""
else
saara="//"
end if
sayfaaktars=sayfaaktars&""&saara&""&mmmYardimci2("id")&"_"&mmmYardimci2("sayfatemp")&"_"&mmmYardimci2("orta")&"_"&mmmYardimci2("sag")&"_"&mmmYardimci2("sol")&""
response.Write(sayfaaktars&"as")
mmmYardimci2.MoveNext
  loop
close(mmmYardimci2)

Set mmmYardimci3=Con.execute("update tasarim set sayfaayar='"&sayfaaktars&"' where id="&request("id")&"")

session("hata1")="Modül Düzenleri Tasarıma Aktarıldı."
session("hatam1")="green"
end sub

sub sayarguncelle
set mmmGenel = Con.Execute ("select * from tasarim where id="&request("id")&"")
sveri=mmmGenel("sayfaayar")
if instr(sveri,"//") then
sadet1=ubound(split(sveri,"//"))
for i=0 to sadet1
sveri1=split(sveri,"//")(i)
Set mmmYardimci3=Con.execute("update sayfalar set sayfatemp='"&split(sveri1,"_")(1)&"',orta='"&split(sveri1,"_")(2)&"',sag='"&split(sveri1,"_")(3)&"',sol='"&split(sveri1,"_")(4)&"' where id="&split(sveri1,"_")(0)&"")
next
session("hata1")="Modül Düzenleri Tasarıma Aktarıldı."
session("hatam1")="green"
else
end if
end sub
%>

<%
sub katetDuzenle

For icntt = 1 To Request.Form("sayfaadi").Count and Request.Form("urunid").Count and Request.Form("ikincii").Count and Request.Form("adres").Count and Request.Form("resim").Count and Request.Form("adresd").Count

sqlString = "update kategori set kate='"&Request.Form("sayfaadi")(icntt)&"', ana='"&Request.Form("onay")(icntt)&"', adres='"&Request.Form("adres")(icntt)&"', ikincii='"&Request.Form("ikincii")(icntt)&"', resim='"&Request.Form("resim")(icntt)&"', adresd='"&Request.Form("adresd")(icntt)&"' where id="&request.Form("urunid")(icntt)&""
Con1.execute(sqlString)

next

session("hata1")="Sayfa Tanımlamaları Düzenlendi"
session("hatam1")="green"
end sub
%> 

<%
sub katetSil

For r = 1 To Request.Form("urunidsil").Count

silmek = "delete from kategori where id="&Request.Form("urunidsil")(r)&""
Con1.execute(silmek)

next

session("hata1")="Sayfa Tanımlamaları Silindi"
session("hatam1")="red"
end sub
%>

<% 	
sub katetekle

sqlString = "insert kategori set kate='"&Request.Form("sektor")&"'"
Con1.execute(sqlString)

session("hata1")="Sayfa Tanımlaması Eklendi"
session("hatam1")="green"
end sub
%>

<% 	
sub katecssekle
 sqlString = "select * from kategoriayar where id="&request("turu")&" order by id desc"
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
sqlString = "select * from kategoriayar where id="&request("turu")&" order by id desc"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
sqlString = "insert kategoriayar set kate1='"&mmmYardimci1("kate1")&"',kate='"&request("sektor")&"',adres='"&request("sek")&"',bilgi1='"&mmmYardimci1("bilgi1")&"',bilgi2='"&mmmYardimci1("bilgi2")&"',bilgi3='"&mmmYardimci1("bilgi3")&"',bilgi4='"&mmmYardimci1("bilgi4")&"',bilgi1i='"&mmmYardimci1("bilgi1i")&"',bilgi2i='"&mmmYardimci1("bilgi2i")&"',bilgi3i='"&mmmYardimci1("bilgi3i")&"',bilgi4i='"&mmmYardimci1("bilgi4i")&"',l1='"&mmmYardimci1("l1")&"',l2='"&mmmYardimci1("l2")&"',l3='"&mmmYardimci1("l3")&"',l4='"&mmmYardimci1("l4")&"',l5='"&mmmYardimci1("l5")&"',l6='"&mmmYardimci1("l6")&"',l7='"&mmmYardimci1("l7")&"',l8='"&mmmYardimci1("l8")&"',l9='"&mmmYardimci1("l9")&"',l10='"&csskont(mmmYardimci1("l10"))&"',r1='"&mmmYardimci1("r1")&"',r2='"&mmmYardimci1("r2")&"',r3='"&mmmYardimci1("r3")&"',r4='"&mmmYardimci1("r4")&"',r5='"&mmmYardimci1("r5")&"',r6='"&csskont(mmmYardimci1("r6"))&"',i1='"&mmmYardimci1("i1")&"',i2='"&mmmYardimci1("i2")&"',i3='"&mmmYardimci1("i3")&"',i4='"&mmmYardimci1("i4")&"',i5='"&mmmYardimci1("i5")&"',i6='"&mmmYardimci1("i6")&"',i7='"&mmmYardimci1("i7")&"',i8='"&csskont(mmmYardimci1("i8"))&"'"
end if
close(mmmYardimci1)
'sqlString = "update kategoriayar set kate='"&request.Form("sektor")&"',kate1='"&request.Form("iceriktur")&"',adres='"&request.Form("sek")&"',bilgi1='0',bilgi2='0',bilgi3='0',bilgi4='0',bilgi1i='"&request.Form("bilgi1i")&"',bilgi2i='"&request.Form("bilgi2i")&"',bilgi3i='"&request.Form("bilgi3i")&"',bilgi4i='"&request.Form("bilgi4i")&"',l1='"&request.Form("l1")&"',l2='"&request.Form("l2")&"',l3='"&request.Form("l3")&"',l4='"&request.Form("l4")&"',l5='"&request.Form("l5")&"',l6='"&request.Form("l6")&"',l7='"&request.Form("l7")&"',l8='"&request.Form("l8")&"',l9='"&request.Form("l9")&"',l10='"&request.Form("l10")&"',r1='"&request.Form("r1")&"',r2='"&request.Form("r2")&"',r3='"&request.Form("r3")&"',r4='"&request.Form("r4")&"',r5='"&request.Form("r5")&"',r6='"&request.Form("r6")&"',i1='"&request.Form("i1")&"',i2='"&request.Form("i2")&"',i3='"&request.Form("i3")&"',i4='"&request.Form("i4")&"',i5='"&request.Form("i5")&"',i6='"&request.Form("i6")&"',i7='"&request.Form("i7")&"',i8='"&request.Form("i8")&"' where id="&request("turu")&""
else
sqlString = "insert kategoriayar set kate1='"&mmmYardimci("kate1")&"',kate='"&request("sektor")&"',adres='"&request("sek")&"',bilgi1='"&mmmYardimci("bilgi1")&"',bilgi2='"&mmmYardimci("bilgi2")&"',bilgi3='"&mmmYardimci("bilgi3")&"',bilgi4='"&mmmYardimci("bilgi4")&"',bilgi1i='"&mmmYardimci("bilgi1i")&"',bilgi2i='"&mmmYardimci("bilgi2i")&"',bilgi3i='"&mmmYardimci("bilgi3i")&"',bilgi4i='"&mmmYardimci("bilgi4i")&"',l1='"&mmmYardimci("l1")&"',l2='"&mmmYardimci("l2")&"',l3='"&mmmYardimci("l3")&"',l4='"&mmmYardimci("l4")&"',l5='"&mmmYardimci("l5")&"',l6='"&mmmYardimci("l6")&"',l7='"&mmmYardimci("l7")&"',l8='"&mmmYardimci("l8")&"',l9='"&mmmYardimci("l9")&"',l10='"&csskont(mmmYardimci("l10"))&"',r1='"&mmmYardimci("r1")&"',r2='"&mmmYardimci("r2")&"',r3='"&mmmYardimci("r3")&"',r4='"&mmmYardimci("r4")&"',r5='"&mmmYardimci("r5")&"',r6='"&csskont(mmmYardimci("r6"))&"',i1='"&mmmYardimci("i1")&"',i2='"&mmmYardimci("i2")&"',i3='"&mmmYardimci("i3")&"',i4='"&mmmYardimci("i4")&"',i5='"&mmmYardimci("i5")&"',i6='"&mmmYardimci("i6")&"',i7='"&mmmYardimci("i7")&"',i8='"&csskont(mmmYardimci("i8"))&"'"
end if
Con.execute(sqlString)
close(mmmYardimci)
 sqlString = "select * from kategoriayar order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
sonkateid=mmmYardimci("id")
end if
close(mmmYardimci)
session("hata1")="Sayfa Türü Ayarı Eklendi"
session("hatam1")="green"
if request("cssyeni")="1" then
 sqlString = "select * from kategoriyazi where id="&request("dkate2")&" order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
sonkatesmodul=""
else
sonkateamodul=replace(mmmYardimci("sayfatemp")," ","*-")
sonkateamodul1=replace(request("yer"),"*0*",sonkateid)
sonkatemodull=replace(replace(trim(sonkateamodul),replace(request("yer"),"*0*","0"),trim(sonkateamodul1)),"*-"," ")

end if
close(mmmYardimci)
Con.execute("update kategoriyazi set sayfatemp='"&sonkatemodull&"' where id="&request("dkate2")&"")
response.Redirect("ortak_kategoriayard.asp?turduzen=1&urunid="&sonkateid&"&adres="&request("sek")&"&sek="&request("dkate2")&"")
else
end if
'response.write"<b>Kategori Kayit Yapilmistir</b><br>"
end sub
%>

<%
sub kateSil

For r = 1 To Request.Form("iceriksil").Count

silmek = "delete from kategoriayar where id="&Request.Form("iceriksil")(r)&""
Con.execute(silmek)

next

session("hata1")="Sayfa Türü Ayarı Silindi"
session("hatam1")="red"
end sub
%>

<%
sub kateDuzenle

For icntt = 1 To Request.Form("icerikadi").Count and Request.Form("urunid").Count and Request.Form("iceriktur").Count and Request.Form("onay").Count

sqlString = "update kategoriayar set kate='"&Request.Form("icerikadi")(icntt)&"',kate1="&Request.Form("iceriktur")(icntt)&",durum="&Request.Form("onay")(icntt)&" where id="&request("urunid")(icntt)&""
Con.execute(sqlString)

next

session("hata1")="Sayfa Türü Ayarları Düzenlendi"
session("hatam1")="green"

end sub
%>

<%
sub katedDuzenle

for ho= 1 to request.Form("cssnbas").count
if request.Form("cssnbas")(ho)="" then
else
logocssnbas="/*"&request.Form("cssnbas")(ho)&"*/"

logocssnana=""&logocssnana&""&logocssnbas&""&request.Form("logodegera"&ho&"")&""
logocss=""
logocssana=""

end if
next

if request.form("listecss")="1" then
i8= request.Form("csstam")
else
i8=logocssnana
end if
if request.Form("tempturi3")="0" then
strtemptur=",i1='"&csskont(request.Form("temptur1"))&"'"
else
strtemptur=",i1='"&csskont(request.Form("temptur"))&"'"
end if
if request.Form("temptur")="0" then
strtemptur=",i1='"&csskont(request.Form("temptur1"))&"'"
else
strtemptur=",i1='"&csskont(request.Form("temptur"))&"'"
end if
if request.Form("temptura")="0" then
strtemptur1=",i5='"&csskont(request.Form("temptura1"))&"'"
else
strtemptur1=",i5='"&csskont(request.Form("temptura"))&"'"
end if
    strlistelemetekrar=",i3='"&csskont(request.Form("i3"))&"'"
    strresimtekrar=",r2='"&csskont(request.Form("r2"))&"'"
    strresimana=",r6='"&csskont(request.Form("r6"))&"'"

sqlString = "update kategoriayar set kate='"&request.Form("ad")&"',adres='"&request.Form("adres")&"',kate1='"&request.Form("iceriktur")&"',bilgi1='"&request.Form("bilgi1")&"',bilgi2 = '"&request.Form("bilgi2")&"',bilgi3='"&request.Form("bilgi3")&"',bilgi4='"&request.Form("bilgi4")&"',bilgi1i='"&request.Form("bilgi1i")&"',bilgi2i='"&request.Form("bilgi2i")&"',bilgi3i='"&request.Form("bilgi3i")&"',bilgi4i='"&request.Form("bilgi4i")&"'"&strtemptur&",i2='"&request.Form("i2")&"'"&strlistelemetekrar&""&strresimtekrar&""&strresimana&",i4 = '"&request.Form("i4")&"'"&strtemptur1&",i6='"&request.Form("i6")&"',i7='"&request.Form("i7")&"',i8='"&csskont(i8)&"',l6='"&jskont(request.Form("l6"))&"',l10='"&csskont(i8)&"' where id="&request("urunid")&""

   ' response.Write sqlString
    'response.End
Con.execute(sqlString)
session("hata1")="Sayfa Türü Ayarı Düzenlendi"
session("hatam1")="green"
if request("sek")="" then
response.Redirect("?urunid="&request("urunid")&"")
else
Response.Redirect ("ortak_sayfalar_ayar.asp?sek="&request("sek")&"&dkate2="&request("sek")&"&urunid=&sayfaayar=modul")
end if
end sub%> 

<%function geteditstr(rptstr,ocar)
    
                if instr(rptstr,"${edit}") then
        geteditstrtxt=""
ocadet=ubound(split(rptstr, "${edit}"))
for oca=1 to ocadet
strocv=split(rptstr, "${edit}")(oca)
strocvopt=split(split(strocv, "${/edit(")(1),")}")(0)
strocvstr=split(strocv,"${/edit(")(0)
ocvadet=ubound(split(strocvopt,","))
if ocvadet<1 then
        ocvopttype=split(strocvopt,",")(0)
else        
        ocvopttype=split(strocvopt,",")(0)
        ocvoptinfo=""
        ocvoptlinked=""
        if ocvadet>0 then
        ocvoptlinked=split(strocvopt,",")(1)
        if instr(ocvoptlinked,"-") then
        ocvoptlinkedcol=split(ocvoptlinked,"-")(0)
        else
        ocvoptlinkedcol="4"
        end if
        end if
        if ocvadet>1 then
        ocvoptinfo=split(strocvopt,",")(2)
        end if
end if
          if ocvopttype="text" or ocvopttype="link" or ocvopttype="img" or ocvopttype="textarea" then
        if ocvopttype="link" then
        fasicon="fas fa-link"
        elseif ocvopttype="img" then
        fasicon="fas fa-camera-alt"
        else
        fasicon="fas fa-file-alt"
        end if
        if ocvoptlinkedb=ocvoptlinked and ocvoptlinked<>"" then
        if ocvoptlinked="" then
        linkedclass= "form-group col-md-12"
        else
        linkedclass= "form-group col-md-"&ocvoptlinkedcol&""
        end if
        else
        if ocvoptlinked="" then
        linkedclass= "form-group col-md-12"
        else
        linkedclass= "form-group col-md-"&ocvoptlinkedcol&""
        end if
        end if
        
    geteditstrtxt=geteditstrtxt&"<div class="""&linkedclass &" mb-2"" style=""margin-bottom:5px;"">"     
    geteditstrtxt=geteditstrtxt&"<div class=""input-group"">"
        geteditstrtxt=geteditstrtxt&"<div class=""input-group-addon"">"
            if fasicon="fas fa-camera-alt" then 
            geteditstrtxt=geteditstrtxt&"<a href="""&strocvstr &""" target=""_blank""><span class="""&fasicon &""" data-toggle=""tooltip"" data-placement=""right"" data-html=""true"" title="""&ocvopttype &"""></span></a>"
            else 
            geteditstrtxt=geteditstrtxt&"<span class="""&fasicon &""" data-toggle=""tooltip"" data-placement=""right"" data-html=""true"" title="""&ocvopttype &"""></span>"
            end if 
        geteditstrtxt=geteditstrtxt&"</div>"
        if ocvopttype="img" then 
                geteditstrtxt=geteditstrtxt&"<div class=""input-group-btn"">"
                    geteditstrtxt=geteditstrtxt&"<a data-toggle=""modal"" href=""#"" data-href=""../"&strocvstr &""" data-target=""#myModal"" class=""btn btn-success iframe-btn"" type=""button"" style=""margin:0px 2px;"">Resim Gör</a>"
                geteditstrtxt=geteditstrtxt&"</div>"
                geteditstrtxt=geteditstrtxt&"<div class=""input-group-btn"">"
                    geteditstrtxt=geteditstrtxt&"<a data-toggle=""modal"" href=""#"" data-href="""&cdntinyfldr &"admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID"&ocar &""&oca &"&multiple=0"&cdncross&""" data-target=""#myModal"" class=""btn btn-warning iframe-btn"" type=""button"" style=""margin:0;"">Resim Seç</a>"
                geteditstrtxt=geteditstrtxt&"</div>"
        geteditstrtxt=geteditstrtxt&"<input class=""form-control"" id=""fieldID"&ocar &""&oca &""" aria-multiselectable=""true"" name=""advtext"" type=""text"" value="""&strocvstr &""">"
        elseif ocvopttype="textarea" then 
                        geteditstrtxt=geteditstrtxt&"<textarea name=""advtext"" class=""form-control shortn"">"&strocvstr &"</textarea>"
        else 
                        geteditstrtxt=geteditstrtxt&"<input type=""text"" name=""advtext"" class=""form-control"" value="""&strocvstr &""" />"
        end if 
        if ocvoptinfo="" then 
            else 
geteditstrtxt=geteditstrtxt&"<div class=""input-group-addon""><span class=""fas fa-info"" data-toggle=""tooltip"" data-placement=""left"" data-html=""true"" title="""&ocvoptinfo &"""></span></div>"
end if
    geteditstrtxt=geteditstrtxt&"</div></div>"
    elseif ocvopttype="menu" then 
       if instr(strocvstr,"#menucreate(") then
        menucntu=ubound(split(strocvstr,","))
        if menucntu=4 then
        menumobilgor=replace(split(strocvstr,",")(0),"#menucreate(","")
        menumobilid=split(strocvstr,",")(1)
        menumobilbut=split(strocvstr,",")(2)
        menumobiltype=split(strocvstr,",")(3)
        menumobilusts=replace(split(strocvstr,",")(4),")#","")
        end if
        end if
 
    
                        geteditstrtxt=geteditstrtxt&"<input type=""hidden"" name=""advtext"" class=""form-control"" value="""&oca&""" />"
    geteditstrtxt=geteditstrtxt&"<div class=""form-group col-md-12 mb-2"" style=""margin-bottom:5px;"">"
        
    geteditstrtxt=geteditstrtxt&"<div class=""input-group"">"
        geteditstrtxt=geteditstrtxt&"<div class=""input-group-addon""><span class=""fas fa-sitemap""></span></div>"
        geteditstrtxt=geteditstrtxt&"<div class=""col-md-2 p-0"" style=""padding: 0px;"">"
        if menumobilgor="0" then
menumobilgorslcta="selected"
menumobilgorslcta=""
        elseif menumobilgor="1" then
menumobilgorslcta=""
menumobilgorslcta="selected"
            end if
                                  geteditstrtxt=geteditstrtxt&"<select name=""ayarmenu["&oca &"]"" id=""menutipi"" class=""form-control"">"
                                      geteditstrtxt=geteditstrtxt&"<option value=""0"" "&menumobilgorslct&" >Mobil Butonu Durumu Seçme </option>"
                                      geteditstrtxt=geteditstrtxt&"<option value=""1"" "&menumobilgorslcta&" >Mobil Butonu Göster </option>"
                                      geteditstrtxt=geteditstrtxt&"<option value=""0"" "&menumobilgorslct&" >Mobil Butonu Gösterme </option>"
                                  geteditstrtxt=geteditstrtxt&"</select>"
           geteditstrtxt=geteditstrtxt&"</div>"
              
        geteditstrtxt=geteditstrtxt&"<div class=""col-md-5 p-0"" style=""padding: 0px;"">"
    geteditstrtxt=geteditstrtxt&"<div class=""input-group"">"
        if menumobilid="1" then
menumobilida="selected"
menumobilidb=""
        elseif menumobilid="ust" then
menumobilida=""
menumobilidb="selected"
        else
menumobilida=""
menumobilidb=""
            end if
                                  geteditstrtxt=geteditstrtxt&"<select name=""ayarmenu["&oca &"]"" id=""menutipi1"" class=""form-control"">"
                                      geteditstrtxt=geteditstrtxt&"<option value=""0"" "&menumobilida&" >Menü Seçme </option> "
                                      geteditstrtxt=geteditstrtxt&"<option value=""ust"" "&menumobilidb&" ><-Hazır Üst veya Yan Menü-> </option> "
                 
sqlString = "SELECT * from menuler where alt = '1' order by isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                              if mmmYardimci("id")&""=""&menumobilid then
                                          menumobilidc="selected=""selected"""
                                          else
                                          menumobilidc=""
                                          end if
                                geteditstrtxt=geteditstrtxt&"<option value="""&mmmYardimci("id")&""" "&menumobilidc&">"&mmmYardimci("isim")&"</option>"
                              
  mmmYardimci.MoveNext
loop
  close(mmmYardimci)
                                   
                                  geteditstrtxt=geteditstrtxt&"</select>"
        geteditstrtxt=geteditstrtxt&"<div class=""input-group-btn"">"
            geteditstrtxt=geteditstrtxt&"<a href=""ortak_menuler.asp?filtret=menu&kateid="&menumobilid&""" class=""btn btn-primary"" style=""margin:0;"">Menüyü Düzenle</a></div></div></div>"
        
        geteditstrtxt=geteditstrtxt&"<input type=""hidden"" name=""ayarmenu["&oca &"]"" value="""&server.HTMLEncode(menumobilbut) &""" />"
              
       geteditstrtxt=geteditstrtxt&" <div class=""col-md-3 p-0"" style=""padding: 0px;"">"
                                 geteditstrtxt=geteditstrtxt& "<select name=""ayarmenu["&oca &"]"" id=""menutipi2"" class=""form-control "">"
        if menumobiltype="ust" then
menumobilida=""
menumobilidb="selected"
menumobilidc=""
menumobilidd=""
        elseif menumobiltype="mobil" then
menumobilida=""
menumobilidb=""
menumobilidc="selected"
menumobilidd=""
        elseif menumobiltype="alt" then
menumobilida=""
menumobilidb=""
menumobilidc=""
menumobilidd="selected"
        else
menumobilida="selected"
menumobilidb=""
menumobilidc=""
menumobilidd=""
            end if
                                      geteditstrtxt=geteditstrtxt&"<option value=""0"" "&menumobilida&" >Menü Tipi Seçiniz </option>"
                                      geteditstrtxt=geteditstrtxt&"<option value=""ust"" "&menumobilidb&" >Üst menü </option>"
                                      geteditstrtxt=geteditstrtxt&"<option value=""mobil"" "&menumobilidc&">Mobil Menü (Her Temada Çalışmayabilir) </option>"
                                      geteditstrtxt=geteditstrtxt&"<option value=""alt"" "&menumobilidd&">Alt Menü </option>"
                                  geteditstrtxt=geteditstrtxt&"</select></div>"
        geteditstrtxt=geteditstrtxt&"<div class=""col-md-2 p-0"" style=""padding: 0px;""><input type=""text"" class=""form-control"" name=""ayarmenu["&oca &"]"" placeholder=""ID"" value="""&menumobilusts &""" /></div></div></div>"

    end if
next
        end if
    geteditstr=geteditstrtxt
    end function
    %>