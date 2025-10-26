<script runat="server" language="javascript" src="../contents/config.inc"></script>
<%
recaptcha3sitekey=recaptcha3sitekey
recaptcha3secretkey=recaptcha3secretkey
    if recaptcha3secretkey="" or isNull(recaptcha3secretkey) then
    else
    recaptchvar="1"
    end if
    'response.Write web_fonts&"<br><br>"
web_fonts=MyOwnHTMLEncode(web_fonts)
   ' response.Write web_fonts
vendor_css=MyOwnHTMLEncode(vendor_css)
theme_css=MyOwnHTMLEncode(theme_css)
current_page_css=MyOwnHTMLEncode(current_page_css)
current_template_css=MyOwnHTMLEncode(current_template_css)
skin_css=MyOwnHTMLEncode(skin_css)
theme_custom_css=MyOwnHTMLEncode(theme_custom_css)
vendor_js=MyOwnHTMLEncode(vendor_js)
theme_base_components_settings=MyOwnHTMLEncode(theme_base_components_settings)
current_page_vendor_views=MyOwnHTMLEncode(current_page_vendor_views)
current_theme_js=MyOwnHTMLEncode(current_theme_js)
theme_custom_js=MyOwnHTMLEncode(theme_custom_js)
admin_css=MyOwnHTMLEncode(admin_css)
admin_js=MyOwnHTMLEncode(admin_js)
html_tag=MyOwnHTMLEncode(html_tag)

ganalytics=MyOwnHTMLEncode(ganalytics)
gvmvar=MyOwnHTMLEncode(gvmvar)
zopim=MyOwnHTMLEncode(zopim)
googletag=MyOwnHTMLEncode(googletag)
googletagbody=MyOwnHTMLEncode(googletagbody)
fmcode=MyOwnHTMLEncode(fmcode)
head_whatsapp=MyOwnHTMLEncode(head_whatsapp)
    head_whatsapptel=replace(head_whatsapp," ","")
recomended_tripadvisor=MyOwnHTMLEncode(recomended_tripadvisor)
tursab_belgesi=MyOwnHTMLEncode(tursab_belgesi)
body_attr=MyOwnHTMLEncode(body_attr)
head_oncesi_veri=MyOwnHTMLEncode(head_oncesi_veri)
head_oncesi_son_veri=MyOwnHTMLEncode(head_oncesi_son_veri)
body_sonrasi_veri=MyOwnHTMLEncode(body_sonrasi_veri)
send_pulse_link=MyOwnHTMLEncode(send_pulse_link)
   
imggaleriyol="/contents/img/galeri/"
imgyol="/contents/img/"
imgurunyol=imgyol&"/urun/"
imgtemp="/contents/img/temp/"
imgcssc="/contents/css/"
imgyolboot="/contents/vendor/"
imgyol1="/contents/img/"
    searchjsonpath="contents/json/"
jsyol="/contents/js/"
pathim="/"
    

if cdnstatu="1" then
cdnsitefolder=replace(Request.ServerVariables("Server_Name"),"-","")
cdnsitefolder1=cdnsitefolder
cdnsitefolder=""
'    cdncross ="&crossdomain=1&dkey="&md5(cdnsitefolder1)&""
cdncross ="&crossdomain=1&dkey="
'cdnimgfldr="https://img.cloudgrafike.com/"
cdnimgfldr=ekcontentspath
cdntinyfldr=siteadres
'cdntinyfldr="https://cdn2.cloudgrafike.com/"
else
cdntinyfldr=siteadres
end if


Sub WriteJSONToFile(filePath, dict)
    Dim fso, file, key, content
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    Set file = fso.CreateTextFile(Server.MapPath(filePath), True)
    content = "{" & vbCrLf
    For Each key In dict

        If IsNull(dict(key)) Or IsEmpty(dict(key)) Then
            val = ""
        Else
            val = Replace(dict(key), """", "\\""")
        End If
        content = content & """" & key & """: """ & val & """," & vbCrLf

    Next
    If Len(content) > 2 Then content = Left(content, Len(content) - 3) & vbCrLf ' Son virgülü kes
    content = content & vbCrLf & "}"
    file.Write content
    file.Close
End Sub

' JSON okuma
Function ReadTextFile(filePath)
    Dim fso, file
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    Set file = fso.OpenTextFile(filePath, 1)
    ReadTextFile = file.ReadAll
    file.Close
End Function

' JSON yükleyici
Function LoadLangJson(group, lang)
    Dim filepath, jsonText, jsonParser
    filepath = Server.MapPath("/contents/cache/" & group & "-" & lang & ".json")
    If FileExists(filepath) Then
        jsonText = ReadTextFile(filepath)
        Set jsonParser = New aspJSON
        Call jsonParser.LoadJSON(jsonText)
        Set LoadLangJson = jsonParser.data
    Else
        Set LoadLangJson = Server.CreateObject("Scripting.Dictionary")
    End If
End Function

' Dosya var mı?
Function FileExists(filePath)
    Dim fso
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    FileExists = fso.FileExists(filePath)
End Function

' Ana çeviri çağırıcı
Function GetLang(group, lang, key, defaultval)
  
    If IsEmpty(langCache) Then
        Set langCache = Server.CreateObject("Scripting.Dictionary")
    End If

    Dim cacheKey
    cacheKey = group & "-" & lang

    If Not langCache.Exists(cacheKey) Then
        Set langCache(cacheKey) = LoadLangJson(group, lang)
    End If

    If langCache(cacheKey).Exists(key) Then
        GetLang = langCache(cacheKey)(key)
    Else
        GetLang = defaultval
    End If
End Function

' Admin panelden çağrılır: çevirileri JSON olarak kaydet
Sub WriteLangJson(group, lang)
    Dim sql, rs, j
    sql = "SELECT bagli, alanadi, ceviri FROM diller_tablosu WHERE grup = '" & group & "' AND anasek = '" & lang & "'"
    Set rs = Con.Execute(sql)
    Set j = Server.CreateObject("Scripting.Dictionary")
    Do Until rs.EOF
        j.Add rs("alanadi") & "_" & rs("bagli"), rs("ceviri")
        rs.MoveNext
    Loop
    Call WriteJSONToFile("/contents/cache/" & group & "-" & lang & ".json", j)
    rs.Close: Set rs = Nothing
End Sub


Sub WriteKurToJson()
    Dim rs, jsonText, fso, file
    Set rs = Con.Execute("SELECT pb, kur FROM " & dbsparabirimi)

    jsonText = "{" 
    Do While Not rs.EOF
        jsonText = jsonText & """" & rs("pb") & """:""" & rs("kur") & ""","
        rs.MoveNext
    Loop
    rs.Close
    If Right(jsonText, 1) = "," Then jsonText = Left(jsonText, Len(jsonText) - 1)
    jsonText = jsonText & "}"

    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    Set file = fso.CreateTextFile(Server.MapPath("/contents/cache/kurlar.json"), True)
    file.Write jsonText
    file.Close
    Set file = Nothing
    Set fso = Nothing
End Sub

Function KurCacheGuncelMi()
    Dim fso, file
    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    If fso.FileExists(Server.MapPath("/contents/cache/kurlar.json")) Then
        Set file = fso.GetFile(Server.MapPath("/contents/cache/kurlar.json"))
        If DateDiff("d", file.DateLastModified, Now()) = 0 Then
            KurCacheGuncelMi = True
        Else
            KurCacheGuncelMi = False
        End If
    Else
        KurCacheGuncelMi = False
    End If

    Set fso = Nothing
End Function

Function LoadKurlarFromJson()
    Dim fso, file, jsonText, o
    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    If fso.FileExists(Server.MapPath("/contents/cache/kurlar.json")) Then
        Set file = fso.OpenTextFile(Server.MapPath("/contents/cache/kurlar.json"), 1)
        jsonText = file.ReadAll
        file.Close
        Set file = Nothing

        Set o = New aspJSON
        o.loadJSON jsonText
        Set LoadKurlarFromJson = o.data
    Else
        Set LoadKurlarFromJson = Nothing
    End If

    Set fso = Nothing
End Function

Sub InitKurCache()
    If Not KurCacheGuncelMi() Then
        Call WriteKurToJson()
    End If
End Sub

Call InitKurCache()


        function recaptch3cek(sk,rckod,ipsi)
        recaptcha3json=verial("https://www.google.com/recaptcha/api/siteverify?secret="&sk&"&response="&rckod&"&remoteip="&ipsi&"")
        if instr(recaptcha3json,"success") then
        recaptch3cek=split(split(recaptcha3json,"success"": ")(1),",")(0)
    else
    recaptch3cek="false"
        end if
        end function
    
    Function MyOwnHTMLEncode(str)
    if isNull(str) then
    else
    str = Replace(str, "`", "'")
    str = Replace(str, "&amp;", "&")
    str = Replace(str, "&lt;", "<")
    str = Replace(str, "&gt;", ">")
    str = Replace(str, "&quot;", """")
    str = Replace(str, "%2C", ",")
    end if
    MyOwnHTMLEncode = str
End Function
   Function URLDecode(ByVal s)
    Dim i, c, out, hi2, hexVal

    If IsNull(s) Or Len(s) = 0 Then
        URLDecode = ""
        Exit Function
    End If

    out = ""
    i = 1
    Do While i <= Len(s)
        c = Mid(s, i, 1)

        If c = "%" Then
            If i + 2 <= Len(s) Then
                hi2 = Mid(s, i + 1, 2)
                If IsHexPair(hi2) Then
                    hexVal = "&H" & hi2
                    out = out & Chr(CLng(hexVal))
                    i = i + 3
                Else
                    out = out & "%"
                    i = i + 1
                End If
            Else
                out = out & "%"
                i = i + 1
            End If
        ElseIf c = "+" Then
            out = out & " "
            i = i + 1
        Else
            out = out & c
            i = i + 1
        End If
    Loop

    URLDecode = out
End Function

Function IsHexPair(ByVal twoChars)
    If Len(twoChars) <> 2 Then
        IsHexPair = False
    Else
        IsHexPair = IsHex(Mid(twoChars,1,1)) And IsHex(Mid(twoChars,2,1))
    End If
End Function

Function IsHex(ch)
    Dim o
    o = AscW(ch)
    IsHex = ((o >= 48 And o <= 57) Or (o >= 65 And o <= 70) Or (o >= 97 And o <= 102))
End Function


    Function pbirimsimge(Str)  
    if Str="" or isNull(Str) then
    Str = "€"
    else
Str = Replace(Str , "TL" , "&#x20BA;" ) 
Str = Replace(Str , "tl" , "&#x20BA;" ) 
Str = Replace(Str , "Tl" , "&#x20BA;" ) 
Str = Replace(Str , "TRY" , "&#x20BA;" ) 
Str = Replace(Str , "USD" , "$" ) 
Str = Replace(Str , "EURO" , "€" ) 
Str = Replace(Str , "usd" , "$" ) 
Str = Replace(Str , "euro" , "€" ) 
Str = Replace(Str , "EUR" , "€" ) 
Str = Replace(Str , "Usd" , "$" ) 
Str = Replace(Str , "Euro" , "€" ) 
Str = Replace(Str , "Gbp" , "£" ) 
Str = Replace(Str , "GBP" , "£" ) 
Str = Replace(Str , "POUND" , "£" ) 
    end if
pbirimsimge = Str 
End Function 

    Function EmailDuzelt(Str)  
Str = Replace(Str , "<" , "" ) 
Str = Replace(Str , ">" , "" ) 
Str = Replace(Str , "'" , "" ) 
Str = Replace(Str , "%" , "" ) 
Str = Replace(Str , "*" , "" ) 
Str = Replace(Str , "http://www.youtube.com/watch?v=" , "" ) 
Str = Replace(Str , "https://www.youtube.com/watch?v=" , "" ) 
Str = Replace(Str , ", 0" , "" ) 
EmailDuzelt = Str 
End Function 
    
    
               function kategoribreadcrumbs(anasek,temp,ilkid,data)
                  vbstr="mmmYardimci"&vb
                  sqlString = "SELECT * from kategoriyazi where id="&anasek&" order by modulmu, sira"
                  set vbstr = Con.Execute (sqlString)
                       if vbstr.eof then
                       else
                                sid=vbstr("id")
                                sanasek=vbstr("anasek")
    if sanasek="" or isNull(sanasek) then
    sanasek="0"
    end if
    if sanasek="1" and vbstr("orta")<>"1" then
    else
                                sayfaisim=vbstr("isim")
                                sayfaa=dilkate(sid,sayfaisim,lang)
                                sayfa=sayfaa&" / "
                                sayara=vbstr("sayara")
                                smodula=vbstr("smodula")
                                stura=vbstr("stura")
                  seolink=seolarlink(sid,"sayfa",lang)
                           if anasek<>"1" and ilkid="0" and heading_banner<>sayfaa then
    strbreadcrumbs2="<li class=""breadcrumb-item"" aria-current=""page""><a href="""&seolink&""" title="""& sayfaa&""">"& sayfaa&"</a></li>"

                           else        
    if heading_banner<>sayfaa then
    if seotur<>"sayfa" or seotur<>"yazi" then
    else
                                    strbreadcrumbs2="<li class=""breadcrumb-item"" aria-current=""page""><a href="""&seolink&""" title="""& sayfaa&""">"& sayfaa&"</a></li>"
                                    end if
                                    strbreadcrumbs2="<li class=""breadcrumb-item active"" aria-current=""page"">"& heading_banner&"</li>"
    else
                                    strbreadcrumbs2="<li class=""breadcrumb-item active"" aria-current=""page"">"& sayfaa&"</li>"
    end if
                                if Instr(temp, "#kylsub#") then
                                    strbreadcrumbs2=kategoribreadcrumbs(sanasek,"#kylsub#","0",strbreadcrumbs2)&""&strbreadcrumbs2
                                else
                                end if
                                end if
                           end if

                       end if
                  close(vbstr)
                        kategoribreadcrumbs=strbreadcrumbs2
               end function
     
Function LoadCriticalCss(ekad)

    If ekad="" Then
        LoadCriticalCss = ""        
    End If

    desktopCssPath = Server.MapPath("/contents/css/critical/" & ekad & "-critical-desktop.css")
    mobileCssPath  = Server.MapPath("/contents/css/critical/" & ekad & "-critical-mobile.css")

    desktopCssPath835 = Server.MapPath("/contents/css/critical/835-critical-desktop.css")
    mobileCssPath835  = Server.MapPath("/contents/css/critical/835-critical-mobile.css")

    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    If fso.FileExists(desktopCssPath) or fso.FileExists( desktopCssPath835) Then
    If fso.FileExists(desktopCssPath) then
    else 
    desktopCssPath=desktopCssPath835
    end if
        Set desktopCssFile = fso.OpenTextFile(desktopCssPath, 1)
        desktopCss = desktopCssFile.ReadAll
        desktopCssFile.Close
    Else
        desktopCss = ""
    End If

    If fso.FileExists(mobileCssPath) or fso.FileExists(mobileCssPath835) Then
    If fso.FileExists(mobileCssPath) then
    else 
    mobileCssPath=mobileCssPath835
    end if
        Set mobileCssFile = fso.OpenTextFile(mobileCssPath, 1)
        mobileCss = mobileCssFile.ReadAll
        mobileCssFile.Close
    Else
        mobileCss = ""
    End If

    Set fso = Nothing

    output = ""
    output = output & "<style id=""critical-css-desktop"">" & vbCrLf
    output = output & "@media (min-width: 768px) {" & vbCrLf & desktopCss & vbCrLf & "}" & vbCrLf
    output = output & "</style>" & vbCrLf

    output = output & "<style id=""critical-css-mobile"">" & vbCrLf
    output = output & "@media (max-width: 767px) {" & vbCrLf & mobileCss & vbCrLf & "}" & vbCrLf
    output = output & "</style>" & vbCrLf

    LoadCriticalCss = output
End Function
    
    function isnullchck(strid,val)
    if strid="" or isNull(strid) then
    isnullchck=""&val&""
    else
    isnullchck=strid
    end if
    end function


    Function kategoriyazilistejson(anasek, temp, qry, lang)
    Dim jsonArray, firstItem
    jsonArray = ""
    firstItem = True

    ' SQL sorgusu
    if anasek="1" then
    sqlString = "SELECT * from kategoriyazi where alt = '1'"&qry&" order by durum desc, menugosterim, modulmu, sira"
    else
    sqlString = "SELECT * from kategoriyazi where anasek='"&anasek&"'"&qry&" order by durum desc, menugosterim, sira"
    end if

    ' Verileri çek
    Set vbstr = Con.Execute(sqlString)

    ' JSON oluştur
    If Not vbstr.EOF Then
        Do While Not vbstr.EOF
            Dim kylid, kylisim, kyllink, childrenJson

            kylid=vbstr("id")
            kylid1=kylid
            kylisim=dilkate(kylid1,vbstr("isim"),lang)
            kylanasek=vbstr("anasek")
            kyllink=seolarlink(kylid1,"sayfa",lang)
            kylicon=iconn
            childrenJson = getkategoriyazilistejson(kylid,temp,lang) ' Alt kategorileri al

            ' JSON Template ile değişkenleri değiştir
            If Not firstItem Then jsonArray = jsonArray & ","
            jsonArray = jsonArray & replace(replace(replace(replace(replace(temp,"#kylid#",kylid),"#kylisim#",kylisim),"#kylico#",kylicon),"#kyllink#",kyllink),"#kylsub#",childrenJson)

            firstItem = False
            vbstr.MoveNext
        Loop
    End If

    jsonArray = jsonArray & ""
    kategoriyazilistejson = jsonArray
End Function

' Alt kategorileri almak için fonksiyon (Recursive)
Function getkategoriyazilistejson(parentID,temp,lang)
    Dim subSql, subRs, subArray, firstItem
    subArray = ""
    firstItem = True

    subSql = "SELECT * from kategoriyazi where anasek='"&parentID&"' and durum='1' order by durum desc, menugosterim, sira"
    Set subRs = Con.Execute(subSql)

    If Not subRs.EOF Then
        Do While Not subRs.EOF
            Dim subid, subname, sublink, childrenJson

            subid = subRs("id")
            subid1 = subid
            subname1 = subRs("isim")
            subname = dilkate(subid1,subname1,lang)
            sublink = seolarlink(subid1, "sayfa", lang)
            childrenJson = getkategoriyazilistejson(subid1, temp, lang) ' Alt kategorileri tekrar al (recursive çağrı)

            ' JSON Template ile değişkenleri değiştir
            If Not firstItem Then subArray = subArray & ","
            subArray = subArray & replace(replace(replace(replace(replace(temp,"#kylid#",subid),"#kylisim#",subname),"#kylico#",kylicon),"#kyllink#",sublink),"#kylsub#",childrenJson)
            firstItem = False
            subRs.MoveNext
        Loop
    End If

    subArray = subArray & ""
    getkategoriyazilistejson = subArray
End Function


              function kategoriyaziliste(anasek,temp,vb,selected,qry,iconn,lang)
    if instr(qry,"modulmu") then
    qry=qry
    else
    qry=" and modulmu='0'"&qry
    end if
                  vbstr="mmmYardimci"&vb
                  if anasek="1" then
                  sqlString = "SELECT * from kategoriyazi where alt = '1'"&qry&" order by durum desc, modulmu, sira"
                  else
                  sqlString = "SELECT * from kategoriyazi where anasek='"&anasek&"'"&qry&" order by durum desc, sira"
                  end if
                  set vbstr = Con.Execute (sqlString)
                          if vbstr.eof then
                  kyl=""
                          else
                Do While Not vbstr.EOF
                  kylid=vbstr("id")
                  kylid1=kylid
                  kylisim=dilkate(kylid1,vbstr("isim"),lang)
                  kylanasek=vbstr("anasek")
                  kyllink=seolarlink(kylid1,"sayfa",lang)
                  kylicon=iconn
                  kyl1=""&replace(replace(replace(replace(replace(temp,"#kylid#",kylid),"#kylisim#",kylisim),"#kylico#",kylicon),"#kyllink#",kyllink),"#kylanasek#",kylanasek)
                        if selected<>"" then
                      kyl1=""&replace(replace(kyl1,"value="""&selected&"""","value="""&selected&""" selected"),"="&selected&"""","="&selected&""" selected")
                        end if
                  if Instr(kyl1, "#kylsub{(") then
                    kyveri=split(split(kyl1,"#kylsub{(")(1),")}#")(0)
                    kyveri1=split(kyveri,",")(0)
                        if kyveri1<>"" then
                        anasek=kyveri1
                        end if
                    kyveri2=split(kyveri,",")(1)
                        if kyveri2<>"" then
                        temps=kyveri2
                        else
                        temps=temp
                        end if
                    kyveri4=split(kyveri,",")(2)
                        if kyveri4<>"" then
                        selecteds=kyveri4
                        else
                        selecteds=selected
                        end if
                    kyveri5=split(kyveri,",")(4)
                        if kyveri5<>"" then
                        qry=kyveri5
                        end if
                    kyveri6=split(kyveri,",")(5)
                        if kyveri6<>"" then
                        iconns=kyveri6
                        else
                        iconns=iconn
                        end if
                    kyveri7=split(kyveri,",")(6)
                        if kyveri7<>"" then
                        langs=kyveri7
                        else
                        langs=lang
                        end if
                   kyl1=""&Replace(kyl1, "#kylsub{("&kyveri1&","&kyveri2&","&kyveri3&","&kyveri4&","&kyveri5&","&kyveri6&","&kyveri7&")}#",kategoriyaziliste(kylid,temps,"1",selecteds,qry,iconns,langs))
                    else
                    end if
                  kyl=kyl&""&kyl1
                  vbstr.MoveNext
                loop
                  end if
                  close(vbstr)
                  kategoriyaziliste=kyl
              end function
    
              function yaziliste(anasek,temp,vb,selected,qry,iconn,lang,limitt,orderby)
    if orderby="" then
    orderbyqry=" order by id, sira"
    else
    orderbyqry=" order by "&replace(orderby,"-",",")&""
    'limit page içerirse sayfalama yap
    end if
    if limitt="" then
    limitqry=""
    else
    limitqry=" limit "&limitt&""
    'limit page içerirse sayfalama yap
    end if
                  vbstr="mmmYardimci"&vb
                  if anasek="1" then
                  sqlString = "SELECT * from yazilar where modulmu='0'"&qry&""&orderbyqry&""&limitqry&""
                  else
                  sqlString = "SELECT * from yazilar where modulmu='0' and kategori='"&anasek&"'"&qry&""&orderbyqry&""&limitqry&""
                  end if
                  set vbstr = Con.Execute (sqlString)
                          if vbstr.eof then
                  kyl=""
                          else
                Do While Not vbstr.EOF
                  kylid=vbstr("id")
                  kylid1=kylid
                  kylisim=dilyazib(kylid1,vbstr("yazib"),lang)
                  kyllink=seolarlink(kylid,"yazi",lang)
    
set mmmYardimci1 = Con.Execute ("select * from resimd where baslik='"&kylid1&"' order by tur desc")
if mmmYardimci1.eof then
kylimg=imgyol&"temp/resimyok.jpg"
en1=en+en/2
boy=en
else
kylimg=imgyol&""&mmmYardimci1("dosyad")
end if
close(mmmYardimci1)

                  kylicon=iconn
                  kyl1=""&replace(replace(replace(replace(replace(temp,"#kylid#",kylid),"#kylisim#",kylisim),"#kylico#",kylicon),"#kyllink#",kyllink),"#kylimg#",kylimg)
                    if selected<>"" then
                  kyl1=""&replace(replace(kyl1,"value="""&selected&"""","value="""&selected&""" selected"),"="&selected&"""","="&selected&""" selected")
                    end if
                  if Instr(kyl1, "#kylsub(") then
                    kyveri=split(split(kyl1,"#kylsub(")(1),")#")(0)
                    kyveri1=split(kyveri,",")(0)
                    if kyveri1<>"" then
                    anasek=kyveri1
                    end if
                    kyveri2=split(kyveri,",")(1)
                    if kyveri2<>"" then
                    temps=kyveri2
    else
    temps=temp
                    end if
                    kyveri4=split(kyveri,",")(2)
                    if kyveri4<>"" then
                    selecteds=kyveri4
                    else
                    selecteds=selected
                    end if
                    kyveri5=split(kyveri,",")(4)
                    if kyveri5<>"" then
                    qry=kyveri5
                    end if
                    kyveri6=split(kyveri,",")(5)
                    if kyveri6<>"" then
                    iconns=kyveri6
    else
    iconns=iconn
                    end if
                    kyveri7=split(kyveri,",")(6)
                        if kyveri7<>"" then
                        langs=kyveri7
                        else
                        langs=lang
                        end if
                   kyl1=""&Replace(kyl1, "#kylsub("&kyveri1&","&kyveri2&","&kyveri3&","&kyveri4&","&kyveri5&","&kyveri6&","&kyveri7&")#",yaziliste(kylid,temps,"1",selecteds,qry,iconns,langs,limitt,orderby))
                    else
                    end if
                  kyl=kyl&""&kyl1
                  vbstr.MoveNext
                loop
                  end if
                  close(vbstr)
                  yaziliste=kyl
              end function
    
    
              function menuvericek(vdb,vid,vb,vtbl,qry,iconn)    
                                    if instr(vid,"/*/") then
                                    menubaglianat=split(vid,"/*/")(0)
                                    menubaglianaid=split(vid,"/*/")(1)
                                    end if
                                    '/*/
                  vbstr="mmmYardimci"&vdb
                  sqlString = "SELECT "&vtbl&" from "&vb&" where "&qry&""
    'response.Write sqlString
                  set vbstr = Con.Execute (sqlString)
                          if vbstr.eof then
                  menuvericek=""
                          else
    menuvericek=vbstr(iconn)
    end if
    close(vbstr)
    end function

              function vericekdb(anasek,temp,vb,selected,qry,iconn,vtbl)
                  vbstr="mmmYardimci"&vb
                 ' if anasek="1" then
                  sqlString = ""&qry&""
                  'else
                  'sqlString = "SELECT * from "&vtbl&" where modulmu='0' and kategori='"&anasek&"'"&qry&" order by sira"
                  'end if
                  set vbstr = Con.Execute (sqlString)
                          if vbstr.eof then
                  kyl=""
                          else
                Do While Not vbstr.EOF
                  kylid=vbstr("iddb")
                  kylisim=vbstr("baslikdb")
                  'kyllink=seolarlink(kylid,"yazi",lang)
                  kylicon=iconn
                  kyl1=""&replace(replace(replace(replace(temp,"#kylid#",kylid),"#kylisim#",kylisim),"#kylico#",kylicon),"#kyllink#",kyllink)
                    if selected<>"" then
                  kyl1=""&replace(replace(kyl1,"value="""&selected&"""","value="""&selected&""" selected"),"="&selected&"""","="&selected&""" selected")
                    end if
                  if Instr(kyl1, "#kylsub(") then
                    kyveri=split(split(kyl1,"#kylsub(")(1),")#")(0)
                    kyveri1=split(kyveri,",")(0)
                    if kyveri1<>"" then
                    anasek=kyveri1
                    end if
                    kyveri2=split(kyveri,",")(1)
                    if kyveri2<>"" then
                    temps=kyveri2
    else
    temps=temp
                    end if
                    kyveri4=split(kyveri,",")(2)
                    if kyveri4<>"" then
                    selecteds=kyveri4
                    else
                    selecteds=selected
                    end if
                    kyveri5=split(kyveri,",")(4)
                    if kyveri5<>"" then
                    qry=kyveri5
                    end if
                    kyveri6=split(kyveri,",")(5)
                    if kyveri6<>"" then
                    iconns=kyveri6
    else
    iconns=iconn
                    end if
                   kyl1=""&Replace(kyl1, "#kylsub("&kyveri1&","&kyveri2&","&kyveri3&","&kyveri4&","&kyveri5&","&kyveri6&")#",yaziliste(kylid,temps,"1",selecteds,qry,iconns,langs,limitt,orderby))
                    else
                    end if
                  kyl=kyl&""&kyl1
                  vbstr.MoveNext
                loop
                  end if
                  close(vbstr)
                  vericekdb=kyl
              end function


     function rndsifreuretv1(tur,uzunluk)
    if tur="sayi" or tur="tarih" then
    karakterler1a="01234567890123456789"
    elseif tur="yazi" then
    karakterler1a="abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
    else
    karakterler1a="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
    end if
randomize
karakterboyu1a=len(karakterler1a)
for gh = 1 to uzunluk
kacincikarakter1a=cint((karakterboyu1a*rnd)+1)
gkodusifreuret1a=gkodusifreuret1a&mid(karakterler1a,kacincikarakter1a,1)
next
  
   if len(gkodusifreuret1a)<uzunluk then
    gkodusifreuret1a=left(gkodusifreuret1a&""&gkodusifreuret1a&""&gkodusifreuret1a&""&gkodusifreuret1a,uzunluk)
    end if
gkodusifreuret = gkodusifreuret1a
    if tur="tarih" then
    rndsifreuretv1=replace(replace(date(),".",""),"/","")&gkodusifreuret
    else
    rndsifreuretv1=gkodusifreuret
    end if
'session("uye_kodu1") = gkodusifreuret
    end function

    function rndsifreuret()
    karakterler1a="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1a=len(karakterler1a)
for gh = 1 to 5
kacincikarakter1a=cint((karakterboyu1a*rnd)+1)
gkodusifreuret1a=gkodusifreuret1a&mid(karakterler1a,kacincikarakter1a,1)
next
gkodusifreuret = gkodusifreuret1a

    rndsifreuret=gkodusifreuret

'session("uye_kodu1") = gkodusifreuret
    end function
    
    
    function esser(dilsira,str)
    set mmmSayfa3 = Con.Execute ("select kate from diller1 where anasek = '"&request.cookies("remember_dil")&"' and sira1='"&str&"'")

if mmmSayfa3.Eof then
    
    set mmmSayfa = Con.Execute ("select kate from diller1 where anasek = '240' and sira1='"&str&"'")
if mmmSayfa.Eof then
    Con.execute("insert diller1 set anasek='240', alt='0', ayri='"&dilsira&"', sira1='"&str&"', kate='"&str&"'")
    else
    end if
close(mmmSayfa)
    esser=str
    else
esser=mmmSayfa3("kate")
end if
close(mmmSayfa3)
    end function
    

    function storeesser1(str,dilsira)
    set mmmSayfa3 = Con.Execute ("select kate from "&dbsdiller1&" where anasek = '"&request.cookies("remember_dil")&"' and sira1='"&str&"'")

if mmmSayfa3.Eof then
    
    set mmmSayfa = Con.Execute ("select kate from "&dbsdiller1&" where anasek = '240' and sira1='"&str&"'")
if mmmSayfa.Eof then
    Con.execute("insert "&dbsdiller1&" set anasek='240', alt='0', ayri='"&dilsira&"', sira1='"&str&"', kate='"&str&"'")
    else
    end if
close(mmmSayfa)
    storeesser1=str
    else
storeesser1=mmmSayfa3("kate")
end if
close(mmmSayfa3)
    end function

        function storeesser(dilsira)
    set mmmSayfa3 = Con.Execute ("select kate,sira1 from "&dbsdiller1&" where anasek = '"&request.cookies("remember_dil")&"' and sira1='"&dilsira&"' ORDER BY bagli")

if mmmSayfa3.Eof then
    else
storeesser=mmmSayfa3("kate")
end if
close(mmmSayfa3)
    end function

function urundetaybutoncek(btur,bdeger,byazi,brenk)
	urundetaybutoncek=""
      urundetaybutoncek=urundetaybutoncek&"<span class="""&btur&" product-label label-"&brenk&" stok_but"">"&storelng("store",byazi)&"</span>"
    'urundetaybutoncek=urundetaybutoncek&"</a>"
	end function
	
    
    'yeni
              function menuvericek1(vdb,vid,vb,vtbl,qry,iconn)    
                                    if instr(vid,"/*/") then
                                    menubaglianat=split(vid,"/*/")(0)
                                    menubaglianaid=split(vid,"/*/")(1)
                                    end if
                  vbstr="mmmYardimci"&vdb
                  sqlString = "SELECT "&vtbl&" from "&vb&" where "&qry&""
                  set vbstr = Con.Execute (sqlString)
                          if vbstr.eof then
                  menuvericek=""
                          else
    menuvericek=vbstr(vtbl)
    end if
    close(vbstr)
    end function

	Function menuisimcek(bagliid,cekmetur)
    menuisimcek=""

    sqlString = "SELECT * from menuler where id = "&bagliid&""
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
    bagliid=mmmYardimci3("bagli")
if cekmetur="isim" then
'menuisimcek=diller1(mmmYardimci3("isim"),bagliid,request.cookies("remember_dil"),"01")
menuisimcek=mmmYardimci3("isim")
elseif cekmetur="seolink" then
menuisimcek=mmmYardimci3("seolink")
elseif cekmetur="id" then
menuisimcek=mmmYardimci3("id")
end if
end if
close(mmmYardimci3)

if instr(bagliid,"k") then
bagliid=replace(bagliid,"k","")
baglitur="k"
elseif instr(bagliid,"dest") then
bagliid=replace(bagliid,"dest","")
baglitur="dest"
elseif instr(bagliid,"s") then
bagliid=replace(bagliid,"s","")
elseif instr(bagliid,"gemif") then
bagliid=replace(bagliid,"gemif","")
baglitur="gemif"
    elseif instr(bagliid,"gemi") then
bagliid=replace(bagliid,"gemi","")
baglitur="gemi"
elseif instr(bagliid,"h") then
bagliid=replace(bagliid,"h","")
baglitur="h"
else
bagliid="0"
baglitur="0"
end if
if baglitur="k" then
sqlString = "SELECT * from kategoriyazi where id = "&bagliid&""
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
if cekmetur="isim" then
menuisimcek=dilkate(bagliid,mmmYardimci3("isim"),lang)
elseif cekmetur="seolink" then
    yazilink=mmmYardimci3("link")
		if yazilink = "" or yazilink = "0" or isNull(yazilink) Then
		menuisimcek=""&seokate(bagliid,mmmYardimci3("seolink"))
		else
		menuisimcek=""&yazilink&""" target="""&mmmYardimci3("target")&""
		end if
'menuisimcek=""&seokate(bagliid,mmmYardimci3("seolink"))
elseif cekmetur="id" then
menuisimcek=bagliid
end if
end if
close(mmmYardimci3)

            if cekmetur="liste" then
    sqlString = "SELECT * from kategoriyazi where anasek = '"&bagliid&"' and menugosterim='1' order by sira,isim"
set mmmSayfa = Con.Execute (sqlString)
    Do While Not mmmSayfa.EOF
    destmenuceklisteid=mmmSayfa("id")
    destmenuceklisteanasek=mmmSayfa("anasek")

    link="""/"&mmmSayfa("seolink")&""""&linkkapat&""
    menuisimcek=menuisimcek&"<li class=""dropdown""><a class=""dropdown-toggle"" href="&link&">"&mmmSayfa("isim")&"</a></li>"
    mmmSayfa.movenext
loop
close(mmmSayfa)
    end if
elseif baglitur="s" then
sqlString = "SELECT * from "&dbskategoriurun&" where id = "&bagliid&""
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
if cekmetur="isim" then
menuisimcek=diller1(mmmYardimci3("isim"),bagliid,request.cookies("remember_dil"),"01")
elseif cekmetur="seolink" then
menuisimcek="k/"&bagliid&"-"&mmmYardimci3("seolink")
elseif cekmetur="id" then
menuisimcek=bagliid
end if
end if
close(mmmYardimci3)

elseif baglitur="dest" then
sqlString = "SELECT * from "&dbtkategoritur&" where id = "&bagliid&" order by sira,isim"
set mmmYardimci3 = Contur.Execute (sqlString)
if mmmYardimci3.eof then
else
    destmenucekid=mmmYardimci3("id")
    destmenucekisim=mmmYardimci3("isim")
    destmenucekseolink=mmmYardimci3("seolink")
    destmenucekanasek=mmmYardimci3("anasek")
    if destmenucekid="2579" or destmenucekanasek="2579" then
    if destmenucekid="2579" and destmenucekanasek="1" then
destseo=turdestinasyonseolink
    else
destseo=turlisteseolink
    end if
    elseif destmenucekanasek="3328" or destmenucekid="3328" then
    destseo=turkampanyalarseolink
    elseif destmenucekanasek="3758" or destmenucekid="3758" then
    destseo=geziturlisteseolink
    elseif destmenucekanasek="3757" or destmenucekid="3757" or destmenucekanasek="3756" or destmenucekid="3756" then    
    if (destmenucekid="3757" and destmenucekanasek="1") or (destmenucekid="3756" and destmenucekanasek="1") then
destseo=geziturlisteseolink
    else
destseo=geziturlisteseolink
    end if    
    elseif destmenucekanasek="3801" or destmenucekid="3801" then    
    if (destmenucekid="3801" and destmenucekanasek="1") then
destseo=feribotturlisteseolink
    else
destseo=feribotturlisteseolink
    end if
    else
    destseo=turlimanseolink
    end if
if cekmetur="isim" then
'menuisimcek=diller1(destmenucekid,bagliid,request.cookies("remember_dil"),"01")
menuisimcek=destmenucekisim
elseif cekmetur="seolink" then
    if destmenucekanasek="2579" or destmenucekid="2579" then
    if destmenucekid="2579" and destmenucekanasek="1" then
menuisimcek=""&destseo&"/hepsi"&seosonu&""
    else
menuisimcek=""&destseo&"/"&destmenucekseolink
    end if
    elseif destmenucekanasek="3328" or destmenucekid="3328" then
    if destmenucekid="3328" and destmenucekanasek="1" then
menuisimcek=""&destseo&"/hepsi"&seosonu&""
    else
menuisimcek=""&destseo&"/"&destmenucekseolink
    end if
    elseif destmenucekanasek="3758" or destmenucekid="3758" then
    if destmenucekid="3758" and destmenucekanasek="1" then
menuisimcek=""&destseo&"/hepsi"&seosonu&""
    else
menuisimcek=""&destseo&"/"&destmenucekseolink
    end if
    elseif destmenucekanasek="3801" or destmenucekid="3801" then
    if destmenucekid="3801" and destmenucekanasek="1" then
menuisimcek=""&destseo&"/hepsi"&seosonu&""
    else
menuisimcek=""&destseo&"/"&destmenucekseolink
    end if
    elseif (destmenucekanasek="3757" or destmenucekid="3757") or (destmenucekanasek="3756" or destmenucekid="3756") then    
    if (destmenucekid="3757" and destmenucekanasek="1") or (destmenucekid="3756" and destmenucekanasek="1") then
menuisimcek=""&destseo&"/hepsi"&seosonu&""
    else
menuisimcek=""&destseo&"/"&destmenucekseolink
    end if

    else
    menuisimcek=""&destseo&"/"&destmenucekseolink
    end if
elseif cekmetur="id" then
menuisimcek=bagliid
        elseif cekmetur="liste" then
    sqlString = "SELECT * from "&dbtkategoritur&" where anasek = '"&bagliid&"' and ustmenu='1' order by sira,isim"
set mmmSayfa = Contur.Execute (sqlString)
    Do While Not mmmSayfa.EOF
    destmenuceklisteid=mmmSayfa("id")
    destmenuceklisteanasek=mmmSayfa("anasek")
    if destmenuceklisteid="2579" or destmenuceklisteanasek="2579" then
    if destmenuceklisteid="2579" and destmenuceklisteanasek="1" then
destseo=turdestinasyonseolink
    else
destseo=turlisteseolink
    end if
    elseif destmenuceklisteanasek="3328" or destmenuceklisteid="3328" then
    destseo=turkampanyalarseolink
    elseif destmenuceklisteanasek="3758" or destmenuceklisteid="3758" then
    destseo=geziturlisteseolink
    elseif destmenucekanasek="3757" or destmenucekid="3757" or destmenucekanasek="3756" or destmenucekid="3756" then    
    if (destmenucekid="3757" and destmenucekanasek="1") or (destmenucekid="3756" and destmenucekanasek="1") then
destseo=geziturlisteseolink
    else
destseo=geziturlisteseolink
    end if
     elseif destmenucekanasek="3801" or destmenucekid="3801" then    
    if destmenucekid="3801" and destmenucekanasek="1" then
destseo=feribotturlisteseolink
    else
destseo=feribotturlisteseolink
    end if
    else
    destseo=turlimanseolink
    end if
    link="""/"&destseo&"/"&mmmSayfa("seolink")&""""&linkkapat&""
    menuisimcek=menuisimcek&"<li class=""dropdown""><a class=""dropdown-toggle"" href="&link&">"&mmmSayfa("isim")&"</a></li>"
    mmmSayfa.movenext
loop
close(mmmSayfa)
end if
end if
close(mmmYardimci3)

    elseif baglitur="gemif" then
sqlString = "SELECT * from "&dbtgemifirmalar&" where id = "&bagliid&""
set mmmYardimci3 = Contur.Execute (sqlString)
if mmmYardimci3.eof then
else
if cekmetur="isim" then
'menuisimcek=diller1(mmmYardimci3("isim"),bagliid,request.cookies("remember_dil"),"01")
menuisimcek=mmmYardimci3("isim")
elseif cekmetur="seolink" then
menuisimcek=""&turgemifirmaseolink&"/"&mmmYardimci3("seolink")
elseif cekmetur="id" then
menuisimcek=bagliid
    elseif cekmetur="liste" then
    sqlString = "SELECT * from "&dbtgemiler&" where gemi_firmasi = '"&bagliid&"' and onay='1' and ustmenu='1'"
set mmmSayfa = Contur.Execute (sqlString)
    Do While Not mmmSayfa.EOF
    link="""/"&turgemiseolink&"/"&mmmSayfa("seolink")&""""&linkkapat&""
    menuisimcek=menuisimcek&"<li class=""dropdown""><a class=""dropdown-toggle"" href="&link&">"&mmmSayfa("isim")&"</a></li>"
    mmmSayfa.movenext
loop
close(mmmSayfa)
end if
end if
close(mmmYardimci3)

        elseif baglitur="gemi" then
sqlString = "SELECT * from "&dbtgemiler&" where id = "&bagliid&""
set mmmYardimci3 = Contur.Execute (sqlString)
if mmmYardimci3.eof then
else
if cekmetur="isim" then
'menuisimcek=diller1(mmmYardimci3("isim"),bagliid,request.cookies("remember_dil"),"01")
menuisimcek=mmmYardimci3("isim")
elseif cekmetur="seolink" then
menuisimcek=""&turgemiseolink&"/"&mmmYardimci3("seolink")
elseif cekmetur="id" then
menuisimcek=bagliid
elseif cekmetur="ul" then
end if
end if
close(mmmYardimci3)

elseif baglitur="h" then

else
menuisimcek=menuisimcek
end if


 End Function

    
Private  function fiyaturun(fiyatu1,fiyatu2,fiyatu3,fiyatu4,fiyatu5,fiyatu6,fiyatu7,fiyatu8) %>
<%

	  fiyatu6a=1+(fiyatu6/100)
      strpbirimi=fiyatu2
    if strpbirimi="TL" then
    strpbirimi="TRY"
    fiyatu2="TRY"
    end if
        if fiyatu1="" or isNull(fiyatu1) or isNumeric(fiyatu1)=False then
    fiyatu1="0"
    else
    end if
    if fiyatu5="" or isNull(fiyatu5) or isNumeric(fiyatu5)=False then
    fiyatu5="0"
    else
    end if
  if session("fiyat")=1 then
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  elseif session("fiyat")=2 then
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  elseif session("fiyat")=3 then
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  elseif session("fiyat")=4 then
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  elseif session("fiyat")=5 then
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  else
	  fiyatti=fiyatu1+(fiyatu1/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  fiyattin=fiyatu5+(fiyatu5/100*session("bindirme")-(fiyatu1/100*session("bindirme"))/100*session("indirim"))
	  end if
      if fiyatu2="EURO" then
      ekpb="EUR"
      end if
	  set mmmYardimci3 = Con.Execute ("SELECT * from "&dbsparabirimi&" where pb = '"&fiyatu2&"' or pb = '"&ekpb&"'")
	  if mmmYardimci3.eof then
	  else
	  kur1s=mmmYardimci3("kur")
	  pbirim=request.cookies("remember"&domaini&"pb")
	  pbirim2=pbirimsimge(request.cookies("remember"&domaini&"pb"))
	  pbirim1=pbirimsimge(strpbirimi)
	  pbirim3=pbirimsimge("TRY")
	  
	  if fiyatu7="1" then
					pbirim1=" "&pbirim1
					pbirim2=" "&pbirim2
					artikdvg=" "&storeesser(295)
                    pbirim3=" "&pbirim3
					else
					pbirim1=""
					pbirim2=""
					pbirim3=""
					artikdvg=""
					end if
					
	  
    
	  

				  if pbirim=fiyatu2 then

    set mmmYardimci2 = Con.Execute ("SELECT * from "&dbsparabirimi&" where pb  = 'TRY' and kur<>'1'")
                    if mmmYardimci2.eof then
                    kur3s=kur1s
    else
					kur3s=mmmYardimci2("kur")
                 
    end if
						   close(mmmYardimci2)

				  if d23="0" then
				  fiyatti1=formatnumber(fiyatti,2)
				  fiyattikdv1=formatnumber((fiyatti*fiyatu6a),2)
				  fiyatti2=formatnumber(fiyattin,2)
				  fiyattikdv2=formatnumber((fiyattin*fiyatu6a),2)

					fiyatti1try=formatnumber((fiyatti*kur3s/fiyatu6a),2)
	 				fiyattikdv1try=formatnumber(fiyatti*kur3s,2)
	  				fiyatti2try=formatnumber((fiyattin*kur3s/fiyatu6a),2)
	 				fiyattikdv2try=formatnumber(fiyattin*kur3s,2)

    fiyatti1doviz=fiyatti1
    fiyattikdv1doviz=fiyattikdv1
    fiyatti2doviz=fiyatti2
    fiyattikdv2doviz=fiyattikdv2
				  else
				  fiyatti1=formatnumber((fiyatti/fiyatu6a),2)
				  fiyattikdv1=formatnumber(fiyatti,2)
				  fiyatti2=formatnumber((fiyattin/fiyatu6a),2)
				  fiyattikdv2=formatnumber(fiyattin,2)

					fiyatti1try=formatnumber((fiyatti*kur3s/fiyatu6a),2)
	 				fiyattikdv1try=formatnumber(fiyatti*kur3s,2)
	  				fiyatti2try=formatnumber((fiyattin*kur3s/fiyatu6a),2)
	 				fiyattikdv2try=formatnumber(fiyattin*kur3s,2)
                    
    fiyatti1doviz=fiyatti1
    fiyattikdv1doviz=fiyattikdv1
    fiyatti2doviz=fiyatti2
    fiyattikdv2doviz=fiyattikdv2
				  end if

					else

					set mmmYardimci2 = Con.Execute ("SELECT * from "&dbsparabirimi&" where pb  = '"&pbirim&"'")
                    if mmmYardimci2.eof then
    else
					kur2s=mmmYardimci2("kur")
    end if
						   close(mmmYardimci2)
    
    set mmmYardimci2 = Con.Execute ("SELECT * from "&dbsparabirimi&" where pb  = 'TRY' and kur<>'1'")
                    if mmmYardimci2.eof then
                    kur3s=kur1s
    else
					kur3s=mmmYardimci2("kur")
                 
    end if
						   close(mmmYardimci2)
                           if pricedotstr="0" then
                           pricedot="0"
                           else
                            pricedot=2
                            end if
					if d23="0" then
					fiyatti1doviz=formatnumber(fiyatti,pricedot)
	  				fiyattikdv1doviz=formatnumber((fiyatti*fiyatu6a),pricedot)
	  				fiyatti2doviz=formatnumber(fiyattin,pricedot)
	  				fiyattikdv2doviz=formatnumber((fiyattin*fiyatu6a),pricedot)

					fiyatti1try=formatnumber((fiyatti*kur3s/fiyatu6a),pricedot)
	 				fiyattikdv1try=formatnumber(fiyatti*kur3s,pricedot)
	  				fiyatti2try=formatnumber((fiyattin*kur3s/fiyatu6a),pricedot)
	 				fiyattikdv2try=formatnumber(fiyattin*kur3s,pricedot)

					fiyatti1=formatnumber((fiyatti*kur1s)/kur2s,pricedot)
					fiyattikdv1=formatnumber((((fiyatti*kur1s)/kur2s)*fiyatu6a),pricedot)
					fiyatti2=formatnumber((fiyattin*kur1s)/kur2s,pricedot)
					fiyattikdv2=formatnumber((((fiyattin*kur1s)/kur2s)*fiyatu6a),pricedot)
					else
					fiyatti1doviz=formatnumber((fiyatti/fiyatu6a),pricedot)
	 				fiyattikdv1doviz=formatnumber(fiyatti,pricedot)
	  				fiyatti2doviz=formatnumber((fiyattin/fiyatu6a),pricedot)
	 				fiyattikdv2doviz=formatnumber(fiyattin,pricedot)

					fiyatti1try=formatnumber((fiyatti*kur3s/fiyatu6a),pricedot)
	 				fiyattikdv1try=formatnumber(fiyatti*kur3s,pricedot)
	  				fiyatti2try=formatnumber((fiyattin*kur3s/fiyatu6a),pricedot)
	 				fiyattikdv2try=formatnumber(fiyattin*kur3s,pricedot)
	  
					fiyatti1=formatnumber((((fiyatti*kur1s)/kur2s)/fiyatu6a),pricedot)
					fiyattikdv1=formatnumber((fiyatti*kur1s)/kur2s,pricedot)
					fiyatti2=formatnumber((((fiyattin*kur1s)/kur2s)/fiyatu6a),pricedot)
					fiyattikdv2=formatnumber((fiyattin*kur1s)/kur2s,pricedot)
					end if
						   end if

						   end if
							close(mmmYardimci3)
		Select Case fiyatu8
			Case 1
			'doviz kdvsiz fiyat + kdv
				fiyaturun=fiyatti1doviz&""&pbirim1&""&artikdvg
			Case 2
			'doviz kdvli fiyat
				fiyaturun=fiyattikdv1doviz&""&pbirim1&""
			Case 3
			'indirimli doviz kdvsiz fiyat + kdv
				fiyaturun=fiyatti2doviz&""&pbirim1&""&artikdvg
			Case 4
			'indirimli doviz kdvli fiyat
				fiyaturun=fiyattikdv2doviz&""&pbirim1&""
			Case 5
			'tl kdvsiz fiyat + kdv
				fiyaturun=fiyatti1&""&pbirim2&""&artikdvg
			Case 6
			'tl kdvli fiyat
				fiyaturun=fiyattikdv1&""&pbirim2&""
			Case 7
			'indirimli tl kdvsiz fiyat + kdv
				fiyaturun=fiyatti2&""&pbirim2&""&artikdvg
			Case 8
			'indirimli tl kdvli fiyat
				fiyaturun=fiyattikdv2&""&pbirim2&""
			Case 9
			'indirimli tl kdvsiz fiyat + kdv
    if fiyatu2="TRY" then
				fiyaturun=""
    else
				fiyaturun=fiyattikdv1try&""&pbirim3&""
    end if
			Case 10
			'indirimli tl kdvli fiyat
    if fiyatu2="TRY" then
				fiyaturun=""
    else
				fiyaturun=fiyattikdv2try&""&pbirim3&""
    end if
			Case Else
				fiyaturun=""
		End Select		
						   %>
<%End function

Function GetKur(pb)
    If IsEmpty(kurlar) Then
        Set kurlar = LoadKurlarFromJson()
    End If

    If Not kurlar Is Nothing Then
        If kurlar.Exists(pb) Then
            Dim val
            val = kurlar(pb)
            If IsNumeric(val) Then
                ' Nokta varsa CDbl hatalı çalışabilir, bu yüzden önce Replace kontrolü
                val = Replace(val, ".", ",")
                GetKur = CDbl(val)
            Else
                GetKur = 1
            End If
        Else
            GetKur = 1
        End If
    Else
        GetKur = 1
    End If
End Function

Function fiyaturun25(fiyatAna, paraBirim, siteUSD, siteEURO, fiyatIndirimli, dummy6, dummy5, fiyatTipi)

Set fiyaturun25sonuc = Server.CreateObject("Scripting.Dictionary")

    If IsNull(fiyatAna) Or fiyatAna = "" Or Not isNumeric(fiyatAna) Then fiyatAna = 0
    If IsNull(fiyatIndirimli) Or fiyatIndirimli = "" Or Not isNumeric(fiyatIndirimli) Then fiyatIndirimli = 0

    Dim KDV, bindirme, indirim, pbirimSecili, pbirimSimgeSecili
    Dim fiyatKDVli, fiyatKDVliIndirimli, fiyatKDVsiz, fiyatKDVsizIndirimli
    Dim kurOranGelen, kurOranSecili, kurOranTRY
    Dim fiyatOut, simge
    Dim secilenParaBirim

    KDV = 1 + (dummy6 / 100)
    bindirme = Session("bindirme")
    indirim = Session("indirim")
    secilenParaBirim = Request.Cookies("remember" & domaini & "pb")
    secilenParaBirim1 = secilenParaBirim
    pbirimSimgeSecili = pbirimsimge(secilenParaBirim1)
    paraBirim1 = paraBirim
    simge = pbirimsimge(paraBirim1)

	pbirim3=pbirimsimge("TRY")

	  if dummy5="1" then
					pbirim1=" "&simge
					pbirim2=" "&secilenParaBirim1
					artikdvg=" "&storeesser(295)
                    pbirim3=" "&pbirim3
					else
					pbirim1=""
					pbirim2=""
					pbirim3=" "&pbirim3
					artikdvg=""
					end if

    ' Fiyat hesapla
    fiyatKDVsiz = fiyatAna + ((fiyatAna * bindirme / 100) - ((fiyatAna * bindirme / 100) * indirim / 100))
    fiyatKDVsizIndirimli = fiyatIndirimli + ((fiyatIndirimli * bindirme / 100) - ((fiyatAna * bindirme / 100) * indirim / 100))
    fiyatKDVli = fiyatKDVsiz * KDV
    fiyatKDVliIndirimli = fiyatKDVsizIndirimli * KDV

    ' Kur oranları
    kurOranGelen = GetKur(paraBirim)
    kurOranSecili = GetKur(secilenParaBirim)
    kurOranTRY = GetKur("TRY")

    ' TL bazlı dönüşüm yapılacaksa

       if instr(fiyatTipi,"1") then ' Döviz KDV'siz
       strfdkdvsizpb = FormatNumber(fiyatKDVsiz, 2) & pbirim1
       strfdkdvsiz = FormatNumber(fiyatKDVsiz, 2)
            fiyaturun25sonuc.Add "fdkdvsizpb", strfdkdvsizpb
            fiyaturun25sonuc.Add "fdkdvsiz", strfdkdvsiz
        end if 
       'if instr(fiyatTipi,"2") then ' Döviz KDV'li
       strfdkdvlipb = FormatNumber(fiyatKDVli, 2) & pbirim1
       strfdkdvli = FormatNumber(fiyatKDVli, 2)
            fiyaturun25sonuc.Add "fdkdvlipb", strfdkdvlipb
            fiyaturun25sonuc.Add "fdkdvli", strfdkdvli
        'end if 
        if instr(fiyatTipi,"3") then ' Döviz indirimli KDV'siz
        strfidkdvsiz = FormatNumber(fiyatKDVsizIndirimli, 2)
        strfidkdvsizpb = FormatNumber(fiyatKDVsizIndirimli, 2) & pbirim1
            fiyaturun25sonuc.Add "fidkdvsizpb", strfidkdvsizpb
            fiyaturun25sonuc.Add "fidkdvsiz", strfidkdvsiz
        end if 
        'if instr(fiyatTipi,"4") then ' Döviz indirimli KDV'li
        strfidkdvlipb = FormatNumber(fiyatKDVliIndirimli, 2) & pbirim1
        strfidkdvli = FormatNumber(fiyatKDVliIndirimli, 2)
            fiyaturun25sonuc.Add "fidkdvlipb", strfidkdvlipb
            fiyaturun25sonuc.Add "fidkdvli", strfidkdvli
        'end if 
        if instr(fiyatTipi,"5") then ' TL KDV'siz
        strfkdvsizpb = FormatNumber(fiyatKDVsiz * kurOranGelen / kurOranSecili, 2) & pbirim2
        strfkdvsiz = FormatNumber(fiyatKDVsiz * kurOranGelen / kurOranSecili, 2)
            fiyaturun25sonuc.Add "fkdvsizpb", strfkdvsizpb
            fiyaturun25sonuc.Add "fkdvsiz", strfkdvsiz
        end if 
        if instr(fiyatTipi,"6") then ' TL KDV'li
        strfkdvlipb = FormatNumber(fiyatKDVli * kurOranGelen / kurOranSecili, 2) & pbirim2
        strfkdvli = FormatNumber(fiyatKDVli * kurOranGelen / kurOranSecili, 2)
            fiyaturun25sonuc.Add "fkdvlipb", strfkdvlipb
            fiyaturun25sonuc.Add "fkdvli", strfkdvli
        end if 
        if instr(fiyatTipi,"7") then ' TL İndirimli KDV'siz
        strfikdvsizpb = FormatNumber(fiyatKDVsizIndirimli * kurOranGelen / kurOranSecili, 2) & pbirim2
        strfikdvsiz = FormatNumber(fiyatKDVsizIndirimli * kurOranGelen / kurOranSecili, 2)
            fiyaturun25sonuc.Add "fikdvsizpb", strfikdvsizpb
            fiyaturun25sonuc.Add "fikdvsiz", strfikdvsiz
        end if 
        if instr(fiyatTipi,"8") then ' TL İndirimli KDV'li
        strfikdvlipb = FormatNumber(fiyatKDVliIndirimli * kurOranGelen / kurOranSecili, 2) & pbirim2
        strfikdvli = FormatNumber(fiyatKDVliIndirimli * kurOranGelen / kurOranSecili, 2)
            fiyaturun25sonuc.Add "fikdvlipb", strfikdvlipb
            fiyaturun25sonuc.Add "fikdvli", strfikdvli
        end if 
        if instr(fiyatTipi,"9") then ' TL indirimli TRY simgesi (kullanılmadıysa boş)
            If UCase(paraBirim) = "TRY" Then
                fiyaturun25sonuc.Add "trykdvlipb", ""
                fiyaturun25sonuc.Add "trykdvli", ""
            Else
            strtrykdvlipb = FormatNumber(fiyatKDVli * kurOranGelen, 2) & pbirim3
            strtrykdvli = FormatNumber(fiyatKDVli * kurOranGelen, 2)
            'strtrykdvli = fiyatKDVli &"-"& kurOranGelen &"-"& pbirim3
                fiyaturun25sonuc.Add "trykdvlipb", strtrykdvlipb
                fiyaturun25sonuc.Add "trykdvli", strtrykdvli
            End If
        end if 
        if instr(fiyatTipi,"0") then ' TL indirimli TRY simgesi (kdvli)
            If UCase(paraBirim) = "TRY" Then
                fiyaturun25sonuc.Add "tryikdvlipb", ""
                fiyaturun25sonuc.Add "tryikdvli", ""
            Else
            strtryikdvlipb = FormatNumber(fiyatKDVliIndirimli * kurOranGelen, 2) & pbirim3
            strtryikdvli = FormatNumber(fiyatKDVliIndirimli * kurOranGelen, 2)
            'strtryikdvli = fiyatKDVliIndirimli &"-"& kurOranGelen &"-"& pbirim3
                fiyaturun25sonuc.Add "tryikdvlipb", strtryikdvlipb
                fiyaturun25sonuc.Add "tryikdvli", strtryikdvli
            End If
        end if
'fiyaturun25sonuc.Add "trypbirim", paraBirim

    Set fiyaturun25 = fiyaturun25sonuc
    ' &"-"&kurOranGelen&"-"&kurOranSecili&"-"&kurOranTRY&"-"&paraBirim&"-"&secilenParaBirim
End Function

    function adminbuttonsf(sayfabutton,d42,gturu)

            if request.cookies("remember"&domaini&"rinn4")="" or request.cookies("remember"&domaini&"rinnsecure")="" Then
    adminbuttonsf=""
    else
if isNull(d42) or d42="" or d42="0" then
else
adminbrand="<a class=""navbar-brand"" href=""#""> <img alt=""Brand"" src="""&siteadres&""&d42&""" width=""50""> </a>"
end if
    ' class=""collapse navbar-collapse"" id=""bs-example-navbar-collapse-1""
    adminbuttonsf="<div id=""styleSwitcher"" class=""style-switcher d-none d-sm-block""><a id=""adminSwitcherOpen"" class=""style-switcher-open"" href=""#""><i style=""line-height:40px"" class=""fas fa-cogs""></i></a><div class=""style-switcher-wrap""><ul class=""nav nav-list flex-column mb-5"">"&adminbrand&""&sayfabutton&"</ul><div class=""clear""></div></div></div>"
    end if
    end function

    function galeriresimcek(secim,gfid,gturu)
    if secim="ilk" then
    agacsecim=" and tur='1'"
    else
    agacsecim=" and type='1'"
    end if
    sqlString = "select * from resimd where baslik='"&gfid&"'"&agacsecim&" order by fid limit 1"
set mmmSayfa2 = Con.Execute (sqlString)
    if mmmSayfa2.eof then
    if secim="ilk" then
    galeriresimcek=imgtemp&"notfound.png"
    else
    galeriresimcek=""
    end if
    else
    galeriresimcek=imgyol&""&mmmSayfa2("dosyad")
    end if
    close(mmmSayfa2)
    end function
    
    sub eskiseolink(seolink)
    Response.Status="301 Moved Permanently"

     'sqlString = "select * from seolink where eskilink like '%"&seolink&"%'  order by id desc"
     sqlString = "select * from seolink where (eskilink = '"&seolink&"' or eskilink = '/"&seolink&"') and (yenilink<>'' and yenilink<>'0') order by id desc"
set mmmSayfa = Con.Execute (sqlString)
if mmmSayfa.eof then    
    aramakelime=replace(replace(seolink,"-"," "),".html","")

    sqlString = "select eskilink from seolink where eskilink='"&seolink&"'"
set mmmSayfa1 = Con.Execute (sqlString)
if mmmSayfa1.eof then
    sqlstring="insert seolink set eskilink='"&seolink&"', yenilink='0'"
        Con.execute(sqlstring)

         set mmmYardimci = Contur.Execute ("select count(id) as toplam3 from seolink where yenilink='0' or yenilink='' or isNull(yenilink)")
        toplam5=mmmYardimci("toplam3")
        
        If cint(toplam5)>200 Then
limitdel=cint(toplam5)-150
    sqlstring="delete from seolink where yenilink='0' or yenilink='' or isNull(yenilink) ORDER BY id ASC LIMIT "&limitdel&""
        Con.execute(sqlstring)
       end if
    else
    end if
    close(mmmSayfa1)

        if request.cookies("remember_dil")="240" or request.cookies("remember_dil")="" then
    dortdortstr="404"&seosonu&""
    else
    sqlstring="select seolink from seolar where seoturu='sayfa' and seoid in (select id from kategoriyazi where dil='"&request.cookies("remember_dil")&"' and bagli in(select seoid from seolar where seolink='404.html' and seoturu='sayfa'));"
        set mmmYardimci = Con.Execute (sqlstring)
            if mmmYardimci.eof then 
    dortdortstr="404"&seosonu&""
            else
    dortdortstr=mmmYardimci("seolink")
    end if
    close(mmmYardimci)
    end if
    if seolink="" or isNull(seolink) then
    else
            Response.AddHeader "Location","/"&dortdortstr&"?brokenlink="&server.URLEncode(seolink)&""
            response.End
    end if

    'Response.AddHeader "Location",sitelink&"error/error"&seosonu&"?brokenlink="&seolink&""
else
    aramakelime="0"
    yeniseolink=mmmSayfa("yenilink")
    
    Response.AddHeader "Location",yeniseolink

    Response.End   
    end if
    close(mmmSayfa)
    end sub

function formdetayg(formid,formicerikid,fid)
formdetayg="<div class=""form_detay_ana"">"

set mmmYardimci2 = Con.Execute ("select *, ozellikler2.tur as o2tur from ozellikler2,ozellikler where ozellikler.formid=ozellikler2.formid and ozellikler2.kateid = "&formicerikid&" and ozellikler2.ozelikid ='1' and ozellikler.tur<>'7' and ozellikler.tur<50 order by ozellikler.sira")

Do While Not mmmYardimci2.EOF
ys=ys+1
if right(ys,1)=1 or right(ys,1)=3 or right(ys,1)=5 or right(ys,1)=7 or right(ys,1)=9 then
collor="form_list1"
else
collor="form_list2"
end if
formid=mmmYardimci2("formid")
formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
formdetayg=formdetayg&"<div class="""&collor&"""><div class=""form_isim_detay"">"&formisim&"</div>"

set mmmYardimci = Con.Execute ("select * from ozellikler2 where ozelikid='"&mmmYardimci2("id")&"' and tur='"&mmmYardimci2("o2tur")&"' order by id")
formdetayg=formdetayg&"<div class=""form_giris_detay"">"&mmmYardimci("isim")&"</div></div>"
mmmYardimci2.movenext
loop
close(mmmYardimci2)
formdetayg=formdetayg&"<div class=""clearfix""></div>"
 set mmmYardimci2 = Con.Execute ("select * from ozellikler2 where kateid = '"&formicerikid&"' and ozelikid='1' order by id")

Do While Not mmmYardimci2.EOF
ys=ys+1
if right(ys,1)=1 or right(ys,1)=3 or right(ys,1)=5 or right(ys,1)=7 or right(ys,1)=9 then
collor="form_list1"
else
collor="form_list2"
end if

 set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' and ozellikler.tur<>'7' and ozellikler.tur<50 order by sira")
Do While Not mmmYardimci3.EOF

 set mmmYardimci = Con.Execute ("select * from ozellikler2 where ozelikid='"&mmmYardimci3("id")&"' and tur='"&mmmYardimci2("tur")&"' order by id")
'formdetayg=formdetayg&"<div class=""form_giris_detay "&collor&""">"&mmmYardimci("isim")&"</div>"

  close(mmmYardimci)
mmmYardimci3.movenext
loop
close(mmmYardimci3)

mmmYardimci2.movenext
loop
close(mmmYardimci2)
formdetayg=formdetayg&"</div>"
end function

function formolustur(fgtur,gtur,fid,fovalue)
    if gtur="2" then
    else
     formolustur=formolustur&"<div class=""form-row"">"
	 formolustur=formolustur&"<div class=""form-group col"">"
    end if
 set mmmSayfa3 = Con.Execute ("select * from ozellikler where id="&fid&" order by sira")
fname=mmmSayfa3("name")
fisim=mmmSayfa3("isim")
fid=mmmSayfa3("id")
ftur=mmmSayfa3("tur")
fmaxs=mmmSayfa3("maxs")
formmid=mmmSayfa3("formid")
formisim=dilformv(fid,fisim,lang)

    if gtur="2" then
    else
if ftur=8 then
      formolustur=formolustur&"<div class=""form_baslik_grup"">"&formisim&"</div>"
     elseif ftur=2 then   
    formolustur=formolustur&"<label class=""font-weight-bold text-dark text-2"">"&formisim&"</label>"
    else
    formolustur=formolustur&"<label class=""font-weight-bold text-dark text-2"">"&formisim&"</label>"
    'formolustur=formolustur&"<div class=""form_giris  custom-placeholder"">"
     end if
     end if
	 if gtur="0" or gtur="2" then
	 valuefo=ozellikcek(formmid," and (id="&fid&")",fgtur,csstip)
	  formolustur=formolustur&""&valuefo
	 else	 
      if ftur=1 then
      formolustur=formolustur&"<input type=""text"" id="""&fname&""" name="""&fname&""" class=""form-control"" value="""&fovalue&"""/>"
      elseif ftur=2 then
      formolustur=formolustur&"<input name="""&fname&""" type=""hidden"" value="""&fovalue&"""/>"
      elseif ftur=3 or ftur=13 then
	  if ftur=13 then
	  zengini="class=""normal1 form-control"""
	  else
	   zengini="class=""form-control"""
	  end if
      formolustur=formolustur&"<textarea name="""&fname&""" rows=""6"" id="""&fname&""" "&zengini&">"&giriskont(request.QueryString("text"))&"</textarea>"
      elseif ftur=4 then
 set mmmSayfa2 = Con.Execute ("select * from ozellikler where anasek='"&fid&"' order by sira")

Do While Not mmmSayfa2.EOF
form4=mmmSayfa2("name")
formisimm4=mmmSayfa2("isim")
formid4=mmmSayfa2("id")
formisim=dilformv(formid4,formisimm4,lang)

      formolustur=formolustur&"<label><input name="""&form4&""" type=""checkbox"" value="""&formisim&""" class=""form-check-input""/>"&formisim&"&nbsp;&nbsp;</label>"
      
	  fname4=""
mmmSayfa2.movenext
loop
close(mmmSayfa2)

elseif ftur=5 then

 set mmmSayfa2 = Con.Execute ("select * from ozellikler where anasek='"&fid&"' order by sira")

Do While Not mmmSayfa2.EOF
fname5=mmmSayfa2("name")
formisimm5=mmmSayfa2("isim")
formid5=mmmSayfa2("id")
formisim5=dilformv(formid5,formisimm5,lang)

     formolustur=formolustur&" <label><input name="""&fname&""" type=""radio"" value="""&formisim5&""" class=""form-check-input""/>&nbsp;"&formisim5&"&nbsp;&nbsp;</label>"
     
	fname5=""						  
mmmSayfa2.movenext
loop
close(mmmSayfa2)

elseif ftur=6 then
     formolustur=formolustur&"<SELECT id=""select4"" size=""1"" name="""&fname&""" class=""form-control"">"
 

 set mmmSayfa2 = Con.Execute ("select * from ozellikler where anasek='"&fid&"' order by sira")

Do While Not mmmSayfa2.EOF
fname6=mmmSayfa2("name")
formisimm6=mmmSayfa2("isim")
formid6=mmmSayfa2("id")
formisim6=dilformv(formid6,formisimm6,lang)

        formolustur=formolustur&"<OPTION value="""&fname6&""" >"&formisim6&"</OPTION>"
     set mmmSayfa1 = Con.Execute ("select * from ozellikler where anasek='"&formid6&"' order by sira")

Do While Not mmmSayfa1.EOF
fname6a=mmmSayfa1("name")
formisimm6a=mmmSayfa1("isim")
formid6a=mmmSayfa1("id")
formisim6a=dilformv(formid6a,formisimm6a,lang)

        formolustur=formolustur&"<OPTION value="""&fname6a&""" >&nbsp;&nbsp;>"&formisim6a&"</OPTION>"
      
		fname6a=""
mmmSayfa1.movenext
loop
close(mmmSayfa1)
      
		fname6=""
mmmSayfa2.movenext
loop
close(mmmSayfa2)

      formolustur=formolustur&"</SELECT>"
      elseif ftur=7 then
      formolustur=formolustur&"<input name="""&fname&""" type=""file""  class=""subfile"" />"
	  elseif ftur=10 then
	  formolustur=formolustur&""&formisim&" :<input type=""text"" id="""&fname&""" name="""&fname&""" size="""&fmaxs&""" class=""form-control""/>"
formolustur=formolustur&"<select size=""1"" name="""&fname&""" class=""form-control"">"
                                    formolustur=formolustur&"<option value=""TL"" >TL</option>"
                                    formolustur=formolustur&"<option value=""-"" >Boş</option>"
                                    formolustur=formolustur&"<option value=""USD"" >USD</option>"
                                    formolustur=formolustur&"<option value=""EURO"" >EURO</option>"
                                    formolustur=formolustur&"<option value=""POUND"">POUND</option>"
                                  formolustur=formolustur&"</select><br />"
	  elseif ftur=11 then
	   formolustur=formolustur&"<script>"
  formolustur=formolustur&"$(function() {"
    formolustur=formolustur&"$( ""#"&fname&""" ).datepicker();"
   formolustur=formolustur&"});"
  formolustur=formolustur&"</script>"
      formolustur=formolustur&"<input type=""text"" id="""&fname&""" name="""&fname&""" class=""form-control""/>"
	  elseif ftur=12 then
	  formolustur=formolustur&"<input type=""text"" id="""&rsform("name")&""" name="""&rsform("name")&""" class=""form-control""/>"
	  elseif ftur>50 then
	   formolustur=formolustur&"<select id="""&fname&""" name="""&fname&""" class=""form-control"">"
 formolustur=formolustur&"<option value=""0"">Seçiniz</option>"

sqlString = "SELECT * from kategoriyazi where anasek = '"&ftur&"'   order by isim desc"
set mmmSayfa2 = Con.Execute (sqlString)
Do While Not mmmSayfa2.EOF

         formolustur=formolustur&"<option value="""&mmmSayfa2("id")&""">"&mmmSayfa2("isim")&"</option>"
  
        mmmSayfa2.MoveNext
  loop
  close(mmmSayfa2)
         formolustur=formolustur&"</select>"
      else
					   end if
					   
					   end if
                       if ftur=8 then
     elseif ftur=2 then   
    formolustur=formolustur&""
      else
    'formolustur=formolustur&"</div>"
    
	end if
		fname=""				  
close(mmmSayfa3)
    
    if gtur="2" then
    else
    formolustur=formolustur&"</div>"
    formolustur=formolustur&"</div>"
    end if
end function

function mysqltarihsaat(varDate)
if day(varDate) < 10 then
dd = "0" & day(varDate)
else
dd = day(varDate)
end if

if month(varDate) < 10 then
mm = "0" & month(varDate)
else
mm = month(varDate)
end if

if right(varDate,2)="PM" or right(varDate,2)="Pm" or right(varDate,2)="pm" then
hh1 = hour(varDate)+12
else
if hour(varDate) < 10 then
hh1 = "0" & hour(varDate)
else
hh1 = hour(varDate)
end if
end if

if minute(varDate) < 10 then
mi = "0" & minute(varDate)
else
mi = minute(varDate)
end if

if second(varDate) < 10 then
se = "0" & second(varDate)
else
se = second(varDate)
end if

mysqltarihsaat = year(varDate)&"-"& mm &"-"& dd &" "& hh1 &":"& mi &":"& se
end Function

function mysqltarihsaatadv(varDate,varType,varTime)
if day(varDate) < 10 then
dd = "0" & day(varDate)
else
dd = day(varDate)
end if

if month(varDate) < 10 then
mm = "0" & month(varDate)
else
mm = month(varDate)
end if

if right(varDate,2)="PM" or right(varDate,2)="Pm" or right(varDate,2)="pm" then
hh1 = hour(varDate)+12
else
if hour(varDate) < 10 then
hh1 = "0" & hour(varDate)
else
hh1 = hour(varDate)
end if
end if

if minute(varDate) < 10 then
mi = "0" & minute(varDate)
else
mi = minute(varDate)
end if

if second(varDate) < 10 then
se = "0" & second(varDate)
else
se = second(varDate)
end if

    if varTime="1" then
    mysqltarihsaatadv=replace(varType,"#dd#",dd)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#ddwn#",WeekdayName(weekday(varDate),True))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#mm#",mm)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#mmt#",MonthName(mm))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#yy#",year(varDate))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#yyk#",right(year(varDate),2))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#hh1#",hh1)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#mi#",mi)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#se#",se)
    else
    mysqltarihsaatadv=replace(varType,"#dd#",dd)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#ddwn#",WeekdayName(weekday(varDate),True))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#mm#",mm)
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#mmt#",MonthName(mm))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#yy#",year(varDate))
    mysqltarihsaatadv=replace(mysqltarihsaatadv,"#yyk#",right(year(varDate),2))
    end if
end Function

'MYSQL tarih ve saat formatlama
function mysqltarih(varDate)
if day(varDate) < 10 then
dd = "0" & day(varDate)
else
dd = day(varDate)
end if

if month(varDate) < 10 then
mm = "0" & month(varDate)
else
mm = month(varDate)
end if

mysqltarih = year(varDate)&"-"& mm &"-"& dd
end function

response.Write(l1)
 response.Write(l2)
 response.Write(l3)
 response.Write(l4)
 response.Write(l5)
 response.Write(l6)
 response.Write(l7)
 response.Write(l8)
 response.Write(l9)
 response.Write(l10)
 
 response.Write(r1)
 response.Write(r2)
 response.Write(r3)
 response.Write(r4)
 response.Write(r5)
 response.Write(r6)
 
 response.Write(i1)
 response.Write(i2)
 response.Write(i3)
 response.Write(i4)
 response.Write(i5)
 response.Write(i6)
 response.Write(i7)
 response.Write(i8)
 response.Write(adres)
 response.Write(bilgi1)
 response.Write(bilgi2)
 response.Write(bilgi3)
 response.Write(bilgi4)
  response.Write(kayarid)
sub kategoriayar(kayar1,kayar2,kayar3)
if kayar1="0" then
if stura="1" then
adres=aid
set mmmSayfa1 = Con.Execute ("select * from kategoriayar where adres = '"&sid&"' order by id")
else
if id="" then
adres=aid
set mmmSayfa1 = Con.Execute ("select * from kategoriayar where adres = '"&aid&"' order by id")
else
adres=id
set mmmSayfa1 = Con.Execute ("select * from kategoriayar where adres = '"&id&"' order by id")
end if
end if
else
adres=kayar1
kayar2=kayar2*1
set mmmSayfa1 = Con.Execute ("select * from kategoriayar where id = "&kayar2&" order by id")
end if
if mmmSayfa1.eof then
else
kayarid= mmmSayfa1("id")
bilgi1= mmmSayfa1("bilgi1i")
bilgi2= mmmSayfa1("bilgi2i")
bilgi3= mmmSayfa1("bilgi3i")
bilgi4= mmmSayfa1("bilgi4i")
l1= mmmSayfa1("l1")
l2= mmmSayfa1("l2")
l3= mmmSayfa1("l3")
l4= mmmSayfa1("l4")
l5= mmmSayfa1("l5")
l6= mmmSayfa1("l6")
l7= mmmSayfa1("l7")
l8= mmmSayfa1("l8")
l9= mmmSayfa1("l9")
l10= mmmSayfa1("l10")

r1= mmmSayfa1("r1")
r2= mmmSayfa1("r2")
r3= mmmSayfa1("r3")
r4= mmmSayfa1("r4")
r5= mmmSayfa1("r5")
r6= mmmSayfa1("r6")

i1= mmmSayfa1("i1")
i2= mmmSayfa1("i2")
i3= mmmSayfa1("i3")
i4= mmmSayfa1("i4")
i5= mmmSayfa1("i5")
i6= mmmSayfa1("i6")
i7= mmmSayfa1("i7")
i8= mmmSayfa1("i8")

end if
close(mmmSayfa1)
end sub

function giriskont(veri)
Veri=Veri&""
Veri = Replace(Veri, "&#601;","&#601;")
Veri = Replace(Veri, "&601;","&#601;")
Veri = Replace(Veri, "&091;","")
Veri = Replace(Veri, "&093;","")
Veri = Replace(Veri, "&amp;8200;","")
Veri = Replace(Veri, "&amp;8242;","")
Veri = Replace(Veri, "&amp;8217;","")
Veri = Replace(Veri, "&#8221;","")
Veri = Replace(Veri, "&#8220;","")
Veri = Replace(Veri, "&#8217;","")
Veri = Replace(Veri, "&#8230;","..")
Veri = Replace(Veri, "&amp;8230;","..")
Veri = Replace(Veri, "&#8216;","")
veri= Replace (veri,"&#8216;"," ",1,-1,1) 
veri= Replace (veri,"&#8217;"," ",1,-1,1)
veri= Replace (veri, "&#8220;","",1,-1,1)
veri= Replace (veri, "&#8221;","",1,-1,1)
veri= Replace (veri, "&amp;8211;","",1,-1,1)
veri= Replace (veri,"--","",1,-1,1) 
veri= Replace (veri,"Chr(33)","",1,-1,1) 
veri= Replace (veri,"Chr(34)","",1,-1,1) 
veri= Replace (veri,"Chr(35)","",1,-1,1) 
veri= Replace (veri,"Chr(36)","",1,-1,1) 
veri= Replace (veri,"Chr(37)","",1,-1,1) 
veri= Replace (veri,"Chr(38)","",1,-1,1) 
veri= Replace (veri,"Chr(39)","",1,-1,1) 
veri= Replace (veri,"Chr(40)","",1,-1,1) 
veri= Replace (veri,"Chr(41)","",1,-1,1) 
veri= Replace (veri,"Chr(42)","",1,-1,1) 
veri= Replace (veri,"Chr(43)","",1,-1,1) 
veri= Replace (veri,"Chr(44)","",1,-1,1) 
veri= Replace (veri,"Chr(47)","",1,-1,1) 
veri= Replace (veri,"Chr(58)","",1,-1,1) 
veri= Replace (veri,"Chr(59)","",1,-1,1) 
veri= Replace (veri,"Chr(60)","",1,-1,1) 
veri= Replace (veri,"Chr(61)","",1,-1,1) 
veri= Replace (veri,"Chr(62)","",1,-1,1) 
veri= Replace (veri,"Chr(63)","",1,-1,1) 
veri= Replace (veri,"Chr(91)","",1,-1,1) 
veri= Replace (veri,"Chr(92)","",1,-1,1) 
veri= Replace (veri,"Chr(93)","",1,-1,1)
veri= Replace (veri,"Chr(94)","",1,-1,1) 
veri= Replace (veri,"Chr(96)","",1,-1,1) 
veri= Replace (veri,"Chr(123)","",1,-1,1)
'veri= Replace (veri,"select","selec-t",1,-1,1) 
veri= Replace (veri,"join","jo-in",1,-1,1) 
veri= Replace (veri,"where","whe-re",1,-1,1) 
veri= Replace (veri,"insert","inser-t",1,-1,1) 
veri= Replace (veri,"delete","dele-te",1,-1,1) 
veri= Replace (veri, "union", "uni-on", 1, -1, 1)
veri= Replace (veri,"update","updat-e",1,-1,1) 
veri= Replace (veri,"like ","li-ke",1,-1,1) 
veri= Replace (veri,"drop ","dro-p ",1,-1,1) 
veri= Replace (veri,"create","creat-e",1,-1,1) 
veri= Replace (veri,"modify","modi-fy",1,-1,1) 
veri= Replace (veri,"rename","rena-me",1,-1,1) 
veri= Replace (veri,"alter","alt-er",1,-1,1) 
veri= Replace (veri,"cast","cas-t",1,-1,1) 
veri= Replace (veri," order by","or-derby",1,-1,1) 
veri= Replace (veri," And '","",1,-1,1 ) 
veri= Replace (veri,"' And ","",1,-1,1 ) 
veri= Replace (veri,"union","uni-on",1,-1,1 ) 
veri= Replace (veri,"xp_","",1,-1,1 ) 
veri= Replace (veri,"<SCRIPT>","",1,-1,1 ) 
veri= Replace (veri,"<META","",1,-1,1 ) 
veri= Replace (veri,"'or'","")
veri= Replace (veri,"""","",1,-1,1 ) 
veri= Replace (veri,"' or '","") 
veri= Replace (veri,"'or'","")
veri= Replace (veri,"' or","")
veri= Replace (veri,"or '","")
veri= Replace (veri,"unhex","")
'veri= Replace (veri,"""","",1,-1,1 ) 
veri= Replace (veri,"'","`",1,-1,1 )
veri= Replace (veri,"%'","",1,-1,1 )
veri= Replace (veri,"'%","",1,-1,1 )
veri= Replace (veri,"*/","",1,-1,1 )
veri= Replace (veri,"/*","",1,-1,1 ) 
veri= Replace (veri,"--","",1,-1,1 )
veri= Replace (veri,"*//*","",1,-1,1 )
veri= Replace (veri,"''","",1,-1,1 )
giriskont=veri
end Function

function icerikkont(veri)
Veri=Veri&""
Veri = Replace(Veri, "&#601;","&#601;")
Veri = Replace(Veri, "&601;","&#601;")
Veri = Replace(Veri, "&091;","")
Veri = Replace(Veri, "&093;","")
Veri = Replace(Veri, "&amp;8200;","")
Veri = Replace(Veri, "&amp;8242;","")
Veri = Replace(Veri, "&amp;8217;","")
Veri = Replace(Veri, "&#8221;","")
Veri = Replace(Veri, "&#8220;","")
Veri = Replace(Veri, "&#8217;","")
Veri = Replace(Veri, "&#8230;","..")
Veri = Replace(Veri, "&amp;8230;","..")
Veri = Replace(Veri, "&#8216;","")
veri= Replace (veri,"&#8216;"," ",1,-1,1) 
veri= Replace (veri,"&#8217;"," ",1,-1,1)
veri= Replace (veri, "&#8220;","",1,-1,1)
veri= Replace (veri, "&#8221;","",1,-1,1)
veri= Replace (veri, "&amp;8211;","",1,-1,1)
veri= Replace (veri,"Chr(33)","",1,-1,1) 
veri= Replace (veri,"Chr(34)","",1,-1,1) 
veri= Replace (veri,"Chr(35)","",1,-1,1) 
veri= Replace (veri,"Chr(36)","",1,-1,1) 
veri= Replace (veri,"Chr(37)","",1,-1,1) 
veri= Replace (veri,"Chr(38)","",1,-1,1) 
veri= Replace (veri,"Chr(39)","",1,-1,1) 
veri= Replace (veri,"Chr(40)","",1,-1,1) 
veri= Replace (veri,"Chr(41)","",1,-1,1) 
veri= Replace (veri,"Chr(42)","",1,-1,1) 
veri= Replace (veri,"Chr(43)","",1,-1,1) 
veri= Replace (veri,"Chr(44)","",1,-1,1) 
veri= Replace (veri,"Chr(47)","",1,-1,1) 
veri= Replace (veri,"Chr(58)","",1,-1,1) 
veri= Replace (veri,"Chr(59)","",1,-1,1) 
veri= Replace (veri,"Chr(60)","",1,-1,1) 
veri= Replace (veri,"Chr(61)","",1,-1,1) 
veri= Replace (veri,"Chr(62)","",1,-1,1) 
veri= Replace (veri,"Chr(63)","",1,-1,1) 
veri= Replace (veri,"Chr(91)","",1,-1,1) 
veri= Replace (veri,"Chr(92)","",1,-1,1) 
veri= Replace (veri,"Chr(93)","",1,-1,1)
veri= Replace (veri,"Chr(94)","",1,-1,1) 
veri= Replace (veri,"Chr(96)","",1,-1,1) 
veri= Replace (veri,"Chr(123)","",1,-1,1)
veri= Replace (veri,"'","`",1,-1,1 )
veri= Replace (veri,"<!DOCTYPE html>","",1,-1,1 )
veri= Replace (veri,"<html>","",1,-1,1 )
veri= Replace (veri,"<head>","",1,-1,1 )
veri= Replace (veri,"</head>","",1,-1,1 )
veri= Replace (veri,"<body>","",1,-1,1 )
veri= Replace (veri,"</body>","",1,-1,1 )
veri= Replace (veri,"</html>","",1,-1,1 )
veri= Replace (veri,"selec-t","select",1,-1,1) 
veri= Replace (veri,"jo-in","join",1,-1,1) 
veri= Replace (veri,"whe-re","where",1,-1,1) 
veri= Replace (veri,"inser-t","insert",1,-1,1) 
veri= Replace (veri,"dele-te","delete",1,-1,1) 
veri= Replace (veri, "uni-on", "union", 1, -1, 1)
veri= Replace (veri,"updat-e","update",1,-1,1) 
veri= Replace (veri,"li-ke ","like",1,-1,1) 
veri= Replace (veri,"dro-p ","drop ",1,-1,1) 
veri= Replace (veri,"creat-e","create",1,-1,1) 
veri= Replace (veri,"modi-fy","modify",1,-1,1) 
veri= Replace (veri,"rena-me","rename",1,-1,1) 
veri= Replace (veri,"alter","alt-er",1,-1,1) 
veri= Replace (veri,"cas-t","cast",1,-1,1) 
veri= Replace (veri," or-derby","order by",1,-1,1) 
icerikkont=veri
end Function

function csskont(veri)
csskont=veri&""
csskont= Replace (csskont,"\'","/`")
csskont= Replace (csskont,"'","`")
csskont=csskont
end Function

function configkont(veri)
configkont=veri&""
configkont= Replace (configkont,"\'","/`")
configkont= Replace (configkont,"\","/--/")
configkont= Replace (configkont,"'","`")
configkont= Replace (configkont,",","%2C")
configkont= Replace (configkont,"""&#","""-&&-")
    configkont = Replace(configkont, "&", "&amp;")
    configkont = Replace(configkont, "<", "&lt;")
    configkont = Replace(configkont, ">", "&gt;")
    configkont = Replace(configkont, """", "&quot;")
    configkont = Replace(configkont, "  ", "")
configkont=configkont
end Function

function hdrcntrplc(veri,contentspath,cloudpath,versionjscss)
hdrcntrplc=veri&""
'hdrcntrplc= Replace (hdrcntrplc,"``","""")
hdrcntrplc= Replace (hdrcntrplc,"/`","\'")
hdrcntrplc= Replace (hdrcntrplc,"/'","\'")
hdrcntrplc= Replace (hdrcntrplc,"/`","\'")
hdrcntrplc= Replace (hdrcntrplc,"/--/","\")
hdrcntrplc= Replace (hdrcntrplc,"/--/","\")
hdrcntrplc= Replace (hdrcntrplc,"""-&&-","""&#")
hdrcntrplc= Replace (hdrcntrplc,"`","'")
'hdrcntrplc= Replace (hdrcntrplc,"!","%21")
hdrcntrplc= Replace (hdrcntrplc,"#contentspath#",""&contentspath&"")
hdrcntrplc= Replace (hdrcntrplc,"#cloudpath#",""&cloudpath&"")
hdrcntrplc= Replace (hdrcntrplc,"#versionjscss#",""&versionjscss&"")
if versionjscss="" then
hdrcntrplc= Replace (hdrcntrplc,"#faster2#"," type=""text/javascript""")
hdrcntrplc= Replace (hdrcntrplc,"#faster1#"," type=""text/javascript""")
else
hdrcntrplc= Replace (hdrcntrplc,"#faster2#","type=""fasterlazyloadscript"" data-delay-type=""interaction"" data-faster-type=""text/javascript""")
hdrcntrplc= Replace (hdrcntrplc,"#faster1#","type=""fasterlazyloadscript"" data-faster-type=""text/javascript""")
end if
hdrcntrplc = Replace(hdrcntrplc, "#grafikeconsent#","<script language=""javascript"""&strasync&" src=""//cdn2.cloudgrafike.com/template/consent/consent.js""></script>")
hdrcntrplc = Replace(hdrcntrplc, "#grafikeconsentv2#","<script language=""javascript"""&strasync&" src=""//cdn2.cloudgrafike.com/template/consent/consentv2.js""></script>")
hdrcntrplc=hdrcntrplc
end Function

function sosyalpaylas1(sitelink,modultitle,facebooktag)
sosyalpaylas1="<div class=""sharefollow"">"
sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-2 col-xs-6""><a href=""//www.facebook.com/sharer.php?u="&sitelink&""" target=""_blank"" class=""sharebuton shareface""><span class=""fa fa-facebook""></span></a></div>"
    sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-2 col-xs-6""><a href=""//twitter.com/share?url="&sitelink&"&text="&modultitle&" "&"&hashtags="&facebooktag&""" target=""_blank"" class=""sharebuton sharetwitter""><span class=""fa fa-twitter""></span></a></div>"
    sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-2 col-xs-6""><a href=""https://plus.google.com/share?url="&sitelink&"&t="&modultitle&" "&""" target=""_blank"" class=""sharebuton sharegoogle""><span class=""fa fa-google-plus""></span></a></div>"
   sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-2 col-xs-6""><a href=""//pinterest.com/pin/create/button/?url="&sitelink&"&description="&modultitle&" "&""" target=""_blank"" class=""sharebuton sharepinterest""><span class=""fa fa-pinterest-p""></span></a></div>"
  'sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-3 col-xs-6""><a href="""" class=""sharebuton shareprinter""> <span class=""fa fa-print""></span></a></div>"
    'sosyalpaylas1=sosyalpaylas1&"<div class=""col-md-3 col-xs-6""><a href=""#"" class=""sharebuton shareemail""><span class=""fa fa-envelope-o""></span></a></div>"
sosyalpaylas1=sosyalpaylas1&"</div>"
end Function

function facebokyorum(sitelink,modultitle,facebooktag)
facebokyorum="<div class=""faceyorum"">"
          facebokyorum=facebokyorum&"<div class=""faceyorumbaslik"">"&esser("s","Facebook Yorumu")&"</div>"
          facebokyorum=facebokyorum&"<div id=""fb-root""></div>"
          facebokyorum=facebokyorum&"<script>(function(d, s, id) {"
 facebokyorum=facebokyorum&" var js, fjs = d.getElementsByTagName(s)[0];"
  facebokyorum=facebokyorum&"if (d.getElementById(id)) {return;}"
  facebokyorum=facebokyorum&"js = d.createElement(s); js.id = id;"
  facebokyorum=facebokyorum&"js.src = ""//connect.facebook.net/tr_TR/all.js#xfbml=1"";"
 facebokyorum=facebokyorum&" fjs.parentNode.insertBefore(js, fjs);"
facebokyorum=facebokyorum&"}(document, 'script', 'facebook-jssdk'));</script>"
         facebokyorum=facebokyorum&"<div class=""fb-comments"" data-href="""&sitelink&""" data-num-posts=""5"" data-width=""100%""></div>"
       facebokyorum=facebokyorum&" </div>"
end Function

function csskont1(veri)
csskont1=veri&""
csskont1 = Replace(csskont1, "-//-","{")
csskont1 = Replace(csskont1, "/--/","}")
csskont1= Replace (csskont1,"`","'",1,-1,1 )
csskont1 = Replace(csskont1, "//-//","\")
csskont1=csskont1
end Function

function jskont(veri)
Veri=Veri&""
veri= Replace (veri,"'","`")
jskont=veri
end Function

function jskont1(veri)
Veri=Veri&""
veri= Replace (veri,"`","'")
jskont1=veri
end Function

function baslikkont(veri1)
Veri1=Veri1&""
Veri1 = Replace(Veri1, "+","")
Veri1 = Replace(Veri1, "|","")
Veri1 = Replace(Veri1, "<s>","")
Veri1 = Replace(Veri1, "</s>","")
Veri1 = Replace(Veri1, "/ ","")
Veri1 = Replace(Veri1, ":","")
Veri1 = Replace(Veri1, "!","")
Veri1 = Replace(Veri1, "?","")
Veri1 = Replace(Veri1, "“","")
Veri1 = Replace(Veri1, "”","")
Veri1 = Replace(Veri1, "/","")
Veri1 = Replace(Veri1, "$","")
Veri1 = Replace(Veri1, "&","")
Veri1 = Replace(Veri1, "% ","")
Veri1 = Replace(Veri1, "%","")
Veri1 = Replace(Veri1, "*","")
Veri1 = Replace(Veri1, "  "," ")
Veri1 = Replace(Veri1, " - "," ")
Veri1 = Replace(Veri1, "- ","")
Veri1 = Replace(Veri1, "-.",".")
Veri1 = Replace(Veri1, "İ","i")
Veri1 = Replace(Veri1, " ","-")
Veri1 = Replace(Veri1, "I","i")
Veri1 = Replace(Veri1, "Ş","s")
Veri1 = Replace(Veri1, "Ğ","g")
Veri1 = Replace(Veri1, "Ç","c")
Veri1 = Replace(Veri1, "Ü","u")
Veri1 = Replace(Veri1, "Ö","o")
Veri1 = Replace(Veri1, "?","")
Veri1 = Replace(Veri1, "`","")
Veri1 = Replace(Veri1, "'","")
Veri1 = Replace(Veri1, "'","")
Veri1 = Replace(Veri1, "ı","i")
Veri1 = Replace(Veri1, "ş","s")
Veri1 = Replace(Veri1, "ğ","g")
Veri1 = Replace(Veri1, "ç","c")
Veri1 = Replace(Veri1, "ü","u")
Veri1 = Replace(Veri1, "ö","o")
Veri1 = Replace(Veri1, "!","")
Veri1 = Replace(Veri1, ",","")
Veri1 = Replace(Veri1, ".html","")
Veri1 = Replace(Veri1, "-.html",".html")
Veri1 = Replace(Veri1, ".","")
Veri1 = Replace(Veri1, ")","")
Veri1 = Replace(Veri1, "(","")
Veri1 = Replace(Veri1, "®","")
Veri1 = Replace(Veri1, "&","")
Veri1 = Replace(Veri1, """","")
Veri1 = Replace(Veri1, " ","")
Veri1 = Replace(Veri1, "--","-")
Veri1 = Replace(Veri1, "-–-","-")
Veri1 = Replace(Veri1, "’","-")
    'ispanyolca
Veri1 = Replace(Veri1, "¿","")
Veri1 = Replace(Veri1, "¡","")
Veri1 = Replace(Veri1, "ñ","ny")
Veri1 = Replace(Veri1, "Ñ","ny")
Veri1 = Replace(Veri1, "á","a")
Veri1 = Replace(Veri1, "Á","a")
Veri1 = Replace(Veri1, "é","e")
Veri1 = Replace(Veri1, "É","e")
Veri1 = Replace(Veri1, "í","i")
Veri1 = Replace(Veri1, "Í","i")
Veri1 = Replace(Veri1, "ó","0")
Veri1 = Replace(Veri1, "Ó","o")
Veri1 = Replace(Veri1, "ú","u")
Veri1 = Replace(Veri1, "Ú","u")
    'almanca
Veri1 = Replace(Veri1, "Ä","a")
Veri1 = Replace(Veri1, "ä","ae")
Veri1 = Replace(Veri1, "ß","es")
    'fransızca
Veri1 = Replace(Veri1, "è","a")
Veri1 = Replace(Veri1, "ô","o")
Veri1 = Replace(Veri1, "â","a")
Veri1 = Replace(Veri1, "á","a")
Veri1 = Replace(Veri1, "à","a")
Veri1 = Replace(Veri1, "ê","e")
Veri1 = Replace(Veri1, "é","e")
Veri1 = Replace(Veri1, "è","e")
Veri1 = Replace(Veri1, "ë","e")
Veri1 = Replace(Veri1, "î","i")
Veri1 = Replace(Veri1, "í","i")
Veri1 = Replace(Veri1, "ì","i")
Veri1 = Replace(Veri1, "ï","i")
Veri1 = Replace(Veri1, "ô","o")
Veri1 = Replace(Veri1, "ó","o")
Veri1 = Replace(Veri1, "ò","o")
Veri1 = Replace(Veri1, "û","u")
Veri1 = Replace(Veri1, "ú","u")
Veri1 = Replace(Veri1, "ù","u")
Veri1 = Replace(Veri1, "æ","ae")
Veri1 = Replace(Veri1, "œ","oe")
Veri1 = Replace(Veri1, "ə","e")

Veri1 = LTrim(Veri1)
Veri1 = RTrim(Veri1)
Veri1 = Trim(Veri1)
Veri1 = lcase(Veri1)
baslikkont=veri1
end Function

function yandexdilcek(ceviridil,ceviri)

kaynagim="https://translate.yandex.net/api/v1.5/tr/translate?key=trnsl.1.1.20151001T063527Z.be49267a974872fb.46bcc8321da7ffaba54cf63973101f1d3de896d8&lang="&ceviridil&"&text="&ceviri&""
kaynak = VeriAL(kaynagim) 
if instr(kaynak,"<text>")=0 then
else
sayfa2=split(kaynak,"<text>")
sayfa2a=split(sayfa2(1),"</text>")
yandexdilcek=sayfa2a(0)
end if
end function

function hreflangcrt(aid,dilchar,seoturu,langs)
    sqlString = "select id,nott,ceviricode from diller1 where alt = '1' and sira='1' order by nott desc"
set mmmGenel = Con.Execute (sqlString)

    Do While Not mmmGenel.EOF
    dilid=mmmGenel("id")
    vdil=mmmGenel("nott")
    
    if seoturu="sayfa" then
    sqlstring="SELECT seolar.seolink as seolarlink, seolar.id as seolarid, lang FROM kategoriyazi,seolar where (kategoriyazi.bagli = '"&aid&"' or kategoriyazi.id = '"&aid&"') and lang='"&dilid&"' and seoturu='"&seoturu&"' and kategoriyazi.id=seolar.seoid"

    'sqlstring=menuvericek(vdb,menubagliana,"kategoriyazi,seolar","seolar.seolink"," kategoriyazi.bagli = '"&aid&"' and dil='"&dilid&"' and kategoriyazi.id=seolar.seoid",iconn)
    else
    sqlstring="SELECT * from kategoriyazi where durum='9999'"
    end if
    set mmmSayfa3 = Con.Execute (sqlstring)
if mmmSayfa3.eof then
    seolarlinki="#"
else
    seisi=seisi+1
    if seisi="1" then
    seisiayrac=""
    else
    seisiayrac=","
    end if
seolarid=seolarid&""&seisiayrac&""&mmmSayfa3("seolarid")
seolarlinki=mmmSayfa3("seolarlink")
    if seolarlinki="/" then
    seolarlinki=""
    end if
    if vdil="1" then
    if aid="" and seolinkim="" then
    hreflangcrt2=hreflangcrt2&"<link rel=""alternate"" href="""&siteadres&""" hreflang=""x-default"" />"
    else 
    hreflangcrt2=hreflangcrt2&"<link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang=""x-default"" />"
    end if
    end if
    'if langs&""<>""&dilid then
    'if request.cookies("remember_dil")&""=""&dilid then
    'hreflangcrt2=hreflangcrt2&"<link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang=""x-default"" />"
    'hreflangcrt2=hreflangcrt2&"<link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang="""&mmmGenel("ceviricode")&""" />"
    'else
    hreflangcrt2=hreflangcrt2&""&_
    "<link rel=""alternate"" href="""&siteadres&""&seolarlinki&""" hreflang="""&mmmGenel("ceviricode")&""" />"
    'end if
end if
close(mmmSayfa3)
mmmGenel.movenext
loop
close(mmmGenel)
    hreflangcrt=hreflangcrt2
    if instr(seolarid,",") then
    for sesii=0 to ubound(split(seolarid,","))
    Con.execute("update seolar set hraflang='"&hreflangcrt&"' where id="&split(seolarid,",")(sesii)&"")
    next
    else    
    if seolarid="" then
    else
    'Con.execute("update seolar set hraflang='"&hreflangcrt&"' where id="&seolarid&"")
    end if
    hreflangcrt=""
    end if
    end function

function setchar(dilsek,dilchar)    
    Response.AddHeader "Access-Control-Allow-Origin","*"
     Response.addHeader "Cache-Control", "max-age=0, no-store, must-revalidate"
            Response.addHeader "Pragma", "no-cache"
            Response.addHeader "Expires", "0"
if dilchar="0" then
if dilsek="533a" then
Response.CodePage = 1252 
Response.CharSet = "windows-1252"  
Response.AddHeader "Content-Type", "text/html;charset=windows-1252"
'response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=windows-1252"">")
else
Response.ContentType = "text/html" 
Response.Charset = "UTF-8" 
Response.Codepage = 65001
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
'response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"">")
end if
elseif dilchar="1252" then
Response.CodePage = 1252 
Response.CharSet = "windows-1252"  
Response.AddHeader "Content-Type", "text/html;charset=windows-1252"
'response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=windows-1252"">")
else
Response.ContentType = "text/html" 
Response.Charset = "UTF-8" 
Response.Codepage = 65001 
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
'response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"">")
end if
end function

Function Utf8ToUnicode(strText)
   With CreateObject("ADODB.Stream")

      .Open
      .Charset = "utf-8"

      .WriteText strText

      .Position = 0
      .Type = 2 ' adTypeText
      .Charset = "UTF-8"

      Utf8ToUnicode = .ReadText(-1) 'adReadAll

      .Close
   End With
End Function

function verialjson(endpoint,apiKey,HashData,ekurl,strCtype,method)
Set http = Server.CreateObject("Microsoft.XMLHTTP")
http.Open ""&method&"", endpoint&""&ekurl, False
'http.setTimeouts 5000, 5000, 10000, 10000 'ms - resolve, connect, send, receive'
http.setRequestHeader "Accept", ""&strCtype&""
http.setRequestHeader "Accept-Encoding", "gzip"
http.setRequestHeader "Content-Type", ""&strCtype&"; charset=utf-8"
    if apiKey<>"" then
http.setRequestHeader "Api-key", apiKey
    end if
    if HashData<>"" then
http.setRequestHeader "X-Signature", HashData
    end if
http.Send   
    verialjson = http.responseText
    Set http = nothing 
    end function

Public Function VeriAl(strGelen) 
Set objVeriAl = Server.CreateObject("Msxml2.ServerXMLHTTP" ) 
objVeriAl.Open "GET" , strGelen, FALSE
objVeriAl.sEnd 
VeriAl = objVeriAl.Responsetext 
SET objVeriAl = Nothing
End Function 

    Public Function VeriPost(strUrl,strData,strCtype) 
    Set objVeriPost=Server.CreateObject("Msxml2.ServerXMLHTTP")
objVeriPost.Open "POST", strUrl, False
objVeriPost.setRequestHeader "Content-Type", strCtype
objVeriPost.Send strData
VeriPost = objVeriPost.Responsetext 
SET objVeriPost = Nothing
End Function 

%>
<%

function listeleme1style(listeleme1veri,csstipp)
listeleme1veri=listeleme1veri&""
listeleme1veri = Replace(listeleme1veri, "s-item","s-item"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "single-item","single-item"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "m-items","m-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "multiple-items","multiple-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "r-items","r-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "responsive-items","responsive-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "v-width","v-width"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "variable-width","variable-width"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "o-time","o-time"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "one-time","one-time"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "d-items","d-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "data-mode","data-mode"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "center-mode","center-mode"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "c-mode","c-mode"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "l-loading","l-loading"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "lazy-load","lazy-load"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "a-items","a-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "auto-play","auto-play"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "fade-items","fade-items"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "fad-item","fad-item"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "s-for","s-for"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "slider-for","slider-for"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "s-nav","s-nav"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "slider-nav","slider-nav"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "s-i-rtl","s-i-rtl"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "singl-ite-rtl","singl-ite-rtl"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "s-mode","s-mode"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "sf-mode","sf-mode"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "`","'")
listeleme1veri = Replace(listeleme1veri, ".liste_cercevem",".liste_cercevem"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".box-content",".box-content"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".baslik",".baslik"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".filtre_menu",".filtre_menu"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "//-//","\")
listeleme1veri = Replace(listeleme1veri, ".htmlicerikresim",".htmlicerikresim"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".toggler_blocks",".toggler_blocks"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".top-menu",".top-menu"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".box-product",".box-product"&csstipp&"")

listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_ilk",".liste_cerceve_ilk"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_ic",".liste_cerceve_ic"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_resim",".liste_cerceve_resim"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_yazi",".liste_cerceve_yazi"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_fi",".liste_cerceve_fi"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_incele",".liste_cerceve_incele"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".liste_cerceve_fyat",".liste_cerceve_fyat"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".single",".single"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".list_carouana",".list_carouana"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".list_carousel",".list_carousel"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "a.prev1","a.prev1"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "a.next1","a.next1"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".pagination",".pagination"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".timer",".timer"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".yanlisteul",".yanlisteul"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#altfot_prev","#altfot_prev"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#altfot_next","#altfot_next"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#altfoto","#altfoto"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#altfot_pag","#altfot_pag"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".list_baslik",".list_baslik"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".imglitmask",".imglitmask"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".imglist",".imglist"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".basliklist",".basliklist"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".detaybuton",".detaybuton"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#slideer_nav","#slideer_nav"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#slider","#slider"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#slideshow","#slideshow"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".slider-item",".slider-item"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#slideer-img","#slideer-img"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".pattern_overlay",".pattern_overlay"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#shadow","#shadow"&csstipp&"")

listeleme1veri = Replace(listeleme1veri, ".controls-center",".controls-center"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#slideer_controls","#slideer_controls"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".prev2",".prev2"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".next2",".next2"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#container","#container"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#carousel","#carousel"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#ui-carousel-next","#ui-carousel-next"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#ui-carousel-prev","#ui-carousel-prev"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".demo1",".demo1"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".col-xs-12",".col-xs-12"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".panel",".panel"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".news-item",".news-item"&csstipp&"")
'listeleme1veri = Replace(listeleme1veri, ".panel-footer",".panel-footer"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, ".dik1_baslik",".dik1_baslik"&csstipp&"")
listeleme1veri = Replace(listeleme1veri, "#container","#container"&csstipp&"")

listeleme1style=listeleme1veri
end Function

function diller1(isim,id,dil,tur)
if dil="240" or dil="" or isNull(dil)="" then
dildeger=isim
else
katebagli=tur&""&id
set mmmSayfa3 = Con.Execute ("select * from "&dbsdiller1&" where anasek='"&dil&"' and bagli="&katebagli&"")
if mmmSayfa3.eof then
    dildeger=isim
else
dildeger=mmmSayfa3("kate")
end if
close(mmmSayfa3)
end if
diller1=dildeger
end Function 

function dilkate(katedilid,katedil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilkate=katedil
else
set mmmSayfa3 = Con.Execute ("select isim from kategoriyazi where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa3.eof then
    dilkate=katedil
else
dilkate=mmmSayfa3("isim")
end if
close(mmmSayfa3)
end if
end Function

function dilozellikcek(katedilid,katedil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilozellikcek=katedil
else
set mmmSayfa63 = Con.Execute ("select isim from ozellikler where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa63.eof then
dilozellikcek=katedil
else
dilozellikcek=mmmSayfa3("isim")
end if
close(mmmSayfa63)
end if
end Function

function seokate(katedilid,katesdil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
seokate=katesdil
else
set mmmSayfa3 = Con.Execute ("select seolink from kategoriyazi where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa3.eof then
    seokate=katesdil
else
seokate=mmmSayfa3("seolink")
end if
close(mmmSayfa3)
end if
end Function

function dilyazib(yazibdilid,yazibdil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilyazib=yazibdil
else
    'response.Write ("select yazib from yazilar where dil='"&lang&"' and bagli="&yazibdilid&"")
set mmmSayfa3 = Con.Execute ("select yazib from yazilar where dil='"&lang&"' and bagli="&yazibdilid&"")
if mmmSayfa3.eof then
    dilyazib=yazibdil
else
dilyazib=mmmSayfa3("yazib")
end if
close(mmmSayfa3)
end if
   ' response.Write dilyazib
end Function

function dilyazi(yazidilid,yazidil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilyazi=yazidil
else    
set mmmSayfa3 = Con.Execute ("select yazi from yazilar where dil='"&lang&"' and bagli="&yazidilid&"")
if mmmSayfa3.eof then
    dilyazi=yazidil
else
dilyazi=mmmSayfa3("yazi")
end if
close(mmmSayfa3)
end if
end Function

function dilyazibi(yazidilid,yazidil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilyazibi=yazidil
else
set mmmSayfa3 = Con.Execute ("select descri from yazilar where dil='"&lang&"' and bagli="&yazidilid&"")
if mmmSayfa3.eof then
    dilyazibi=yazidil
else
dilyazibi=mmmSayfa3("descri")
end if
close(mmmSayfa3)
end if
end Function

function dilicerikcek(yazidilid,yazidil,lang,tablei,bossa)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilicerikcek=yazidil
else
set mmmSayfa3 = Con.Execute ("select "&tablei&" from yazilar where dil='"&lang&"' and bagli="&yazidilid&"")
if mmmSayfa3.eof then
    dilicerikcek=yazidil
else
dilicerikcek=mmmSayfa3(""&tablei&"")
    if dilicerikcek="" or isNull(dilicerikcek) then
    dilicerikcek=yazidil
    end if
end if
close(mmmSayfa3)
end if
end Function

function seoyazi(yazidilid,yazidil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
seoyazi=yazidil
else
set mmmSayfa3 = Con.Execute ("select seolink from yazilar where dil='"&lang&"' and bagli="&yazidilid&"")
if mmmSayfa3.eof then
    seoyazi=yazidil
else
seoyazi=mmmSayfa3("seolink")
end if
close(mmmSayfa3)
end if
end Function
    
function seolarlink(yazidilid,yazidil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if

    if yazidil="sayfa" or yazidil="yazi" then
          if lang="240" or lang="" or isNull(lang) then
    dilqry=" and seoturu='"&yazidil&"'"
            else
                dilqry=" and seoturu='"&yazidil&"'"
            ' response.Write ("select id from kategoriyazi where dil='"&request.cookies("remember_dil")&"' and bagli="&yazidilid&"")
                            if yazidil="yazi" then
                        sqlstring="select id from yazilar where dil='"&lang&"' and bagli="&yazidilid&""
                            else
                        sqlstring="select id from kategoriyazi where dil='"&lang&"' and bagli="&yazidilid&""
                            end if
                            set mmmSayfa3 = Con.Execute (sqlstring)
                        if mmmSayfa3.eof then
                            yazidilid="0"
                        else
                        yazidilid=mmmSayfa3("id")
                        end if
                        close(mmmSayfa3)
            end if
            else
            dilqry=" and seoturu='"&yazidil&"'"
end if
    
set mmmSayfa3 = Con.Execute ("select seolink from seolar where seoid='"&yazidilid&"'"&dilqry&" and lang='"&lang&"'")
if mmmSayfa3.eof then
    seolarlink="#"
else
seolarlink=mmmSayfa3("seolink")
end if
close(mmmSayfa3)

end Function

function dilresimb(katedilid,katedil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilresimb=katedil
else
set mmmSayfa3 = Con.Execute ("select resad from resimd where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa3.eof then
   dilresimb =katedil
else
dilresimb=mmmSayfa3("resad")
end if
close(mmmSayfa3)
end if
end Function

function dilresim(katedilid,katesdil,lang)
if yazidilid="" then
yazidilid="0" 
end if
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilresim=katesdil
else
set mmmSayfa3 = Con.Execute ("select acik from resimd where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa3.eof then
    dilresim=katesdil
else
dilresim=mmmSayfa3("acik")
end if
close(mmmSayfa3)
end if
end Function

function dilform(katedilid,katesdil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilform=katesdil
else
set mmmSayfa3 = Con.Execute ("select gmesaj from formlar where dil='"&lang&"' and bagli="&katedilid&"")
if mmmSayfa3.eof then
dilform=katesdil
else
dilform=mmmSayfa3("gmesaj")
end if
close(mmmSayfa3)
end if
end Function

function dilformv(katedilid,katesdil,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if
    if lang="240" or lang="" or isNull(lang) then
dilformv=katesdil
else
set mmmSayfa = Con.Execute ("select isim from ozellikler where dil='"&lang&"' and bagli='"&katedilid&"'")
if mmmSayfa.eof then
dilformv=katesdil
else
dilformv=mmmSayfa("isim")
end if
close(mmmSayfa)
end if
end Function

    function uyelikli()
    if request.cookies("remember"&domaini&"rinnacc4")="" and request.cookies("remember"&domaini&"rinntur4")="" then
    else
    response.Redirect("/")
    end if
    end function

function veriguncelle(Veri2)
Veri2=Veri2&""

    if Instr(Veri2,""&rsablonstr&"#uyelikli#") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikli#"&rsablonstri&"",uyelikli())
    end if
Veri2 = Replace(Veri2, "/--/","\")
Veri2 = Replace(Veri2, ""&rsablonstr&"#siteemail#"&rsablonstri&"",""&siteemail&"")
'Veri2 = Replace(Veri2, "@", "<svg xmlns=""http://www.w3.org/2000/svg"" fill=""currentColor"" viewBox=""0 0 24 24"" style=""height:16px;""><path d=""M12,2a10,10,0,1,0,5,18.66,1,1,0,1,0-1-1.73A8,8,0,1,1,20,12v.75a1.75,1.75,0,0,1-3.5,0V8.5a1,1,0,0,0-1-1,1,1,0,0,0-1,.79A4.45,4.45,0,0,0,12,7.5,4.5,4.5,0,1,0,15.3,15,3.74,3.74,0,0,0,22,12.75V12A10,10,0,0,0,12,2Zm0,12.5A2.5,2.5,0,1,1,14.5,12,2.5,2.5,0,0,1,12,14.5Z""/></svg>")
'Veri2 = Replace(Veri2, "@", "%40")
Veri2 = Replace(Veri2, ""&rsablonstr&"#aid#"&rsablonstri&"",""&aid&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#seolink#"&rsablonstri&"",""&siteadres&seolinkim&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sitesahip#"&rsablonstri&"",""&sitesahip&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#adres#"&rsablonstri&"",""&siteadress&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#pathim#"&rsablonstri&"",""&ekcontentspath&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sitelogo#"&rsablonstri&"",""&d2&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#tel#"&rsablonstri&"",""&sitetel&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#faceadres#"&rsablonstri&"",""&faceadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#facefan#"&rsablonstri&"",""&facefan&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#facekid#"&rsablonstri&"",""&facekid&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#instagramkadi#"&rsablonstri&"",""&instagramkadi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#youtube_kanali#"&rsablonstri&"",""&youtube_kanali&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#tik_tok_kullanici_adi#"&rsablonstri&"",""&tik_tok_kullanici_adi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#pinterestkadi#"&rsablonstri&"",""&pinterestkadi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#linkedinkadi#"&rsablonstri&"",""&linkedinkadi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#twitteradres#"&rsablonstri&"",""&twitteradres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sitetel#"&rsablonstri&"",""&sitetel&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#fax#"&rsablonstri&"",""&sitefax&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#website#"&rsablonstri&"",""&webadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#tarih#"&rsablonstri&"",""&year(date)&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#head_whatsapp#"&rsablonstri&"",""& head_whatsapp&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#head_whatsapptel#"&rsablonstri&"",""& head_whatsapptel&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#iframerequest#"&rsablonstri&"",""& iframerequest&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#yazilink#"&rsablonstr&"", siteadres&seolinkim)
Veri2 = Replace(Veri2, ""&rsablonstr&"#httpreferer#"&rsablonstr&"", Request.ServerVariables ("HTTP_REFERER"))
Veri2 = Replace(Veri2, ""&rsablonstr&"#qrystr#"&rsablonstri&"",""& request.QueryString("qrystr")&"")

if instr(send_pulse_link,"events.sendpulse") then
Veri2 = Replace(Veri2, "</form>","<input type=""hidden"" name=""g-send-pulse"" id=""g-send-pulse"" value=""1""><input type=""hidden"" name=""g-send-pulse-link"" id=""g-send-pulse-link"" value="""&send_pulse_link&"""></form>")
    end if

    if instr(request.QueryString,"?") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#qrystr1#"&rsablonstri&"","&"& split(request.QueryString,"?")(1)&"")
    end if
Veri2 = Replace(Veri2, ""&rsablonstr&"-&&-"&rsablonstri&"","&#")
Veri2 = Replace(Veri2, ""&rsablonstr&"/?"&rsablonstri&"","?")

'Veri2 = Replace(Veri2, ""&rsablonstr&"#altmenu#"&rsablonstri&"",""&altmenu1(veri1,veri2)&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#rinnlogo#"&rsablonstri&"","<script language=""javascript"""&strasync&" src=""//www.reklaminn.com/images/logo.js""></script>")
Veri2 = Replace(Veri2, ""&rsablonstr&"#rinnlogo1#"&rsablonstri&"","<script language=""javascript"""&strasync&" src=""//www.reklaminn.com/images/logo1.js""></script>")
Veri2 = Replace(Veri2, ""&rsablonstr&"#grafikelogo#"&rsablonstri&"","<script language=""javascript"""&strasync&" src=""//www.grafikeweb.com/images/logo.js""></script>")
Veri2 = Replace(Veri2, ""&rsablonstr&"#grafikelogo1#"&rsablonstri&"","<script language=""javascript"""&strasync&" src=""//www.grafikeweb.com/images/logo1.js""></script>")
Veri2 = Replace(Veri2, ""&rsablonstr&"#grafikeconsent#"&rsablonstri&"","<script language=""javascript"""&strasync&" src=""//cdn2.cloudgrafike.com/template/consent/consent.js""></script>")
if Instr(Veri2,""&rsablonstr&"#gkodu#"&rsablonstri&"") then
session("uye_kodu2") = rndsifreuretv1("1","5")
Veri2 = Replace(Veri2, ""&rsablonstr&"#gkodu#"&rsablonstri&"",""&session("uye_kodu2")&"")
else
end if
if Instr(Veri2,""&rsablonstr&"#esser(") then
dvadet=ubound(split(Veri2,""&rsablonstr&"#esser("))
for dv=1 to dvadet
if Instr(Veri2,""&rsablonstr&"#esser(") then
dilveri=split(split(Veri2,""&rsablonstr&"#esser(")(1),")#"&rsablonstri&"")(0)
dilveri1=split(dilveri,",")(0)
dilveri2=split(dilveri,",")(1)
Veri2 = Replace(Veri2, ""&rsablonstr&"#esser("&dilveri1&","&dilveri2&")#"&rsablonstri&"",esser(dilveri1,dilveri2)) 
else
end if
next
else
end if
if Instr(Veri2,""&rsablonstr&"#storeesser1(") then
dvadet=ubound(split(Veri2,""&rsablonstr&"#storeesser1("))
for dv=1 to dvadet
if Instr(Veri2,""&rsablonstr&"#storeesser1(") then
dilveri=split(split(Veri2,""&rsablonstr&"#storeesser1(")(1),")#"&rsablonstri&"")(0)
dilveri1=split(dilveri,",")(0)
dilveri2=split(dilveri,",")(1)
Veri2 = Replace(Veri2, ""&rsablonstr&"#storeesser1("&dilveri1&","&dilveri2&")#"&rsablonstri&"",storeesser1(dilveri1,dilveri2)) 
else
end if
next
else
end if
if Instr(Veri2,""&rsablonstr&"#storeesser(") then
dvaadet=ubound(split(Veri2,""&rsablonstr&"#storeesser("))
for dva=1 to dvaadet
if Instr(Veri2,""&rsablonstr&"#storeesser(") then
dilveri=split(split(Veri2,""&rsablonstr&"#storeesser(")(1),")#"&rsablonstri&"")(0)
Veri2 = Replace(Veri2, ""&rsablonstr&"#storeesser("&dilveri&")#"&rsablonstri&"",storeesser(dilveri))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#qryform(") then
dvaadet=ubound(split(Veri2,""&rsablonstr&"#qryform("))
for dva=1 to dvaadet
if Instr(Veri2,""&rsablonstr&"#qryform(") then
dilveri=split(split(Veri2,""&rsablonstr&"#qryform(")(1),")#"&rsablonstri&"")(0)
Veri2 = Replace(Veri2, ""&rsablonstr&"#qryform("&dilveri&")#"&rsablonstri&"",request.Form(dilveri))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#qrycookie(") then
dvaadet=ubound(split(Veri2,""&rsablonstr&"#qrycookie("))
for dva=1 to dvaadet
if Instr(Veri2,""&rsablonstr&"#qrycookie(") then
dilveri=split(split(Veri2,""&rsablonstr&"#qrycookie(")(1),")#"&rsablonstri&"")(0)
Veri2 = Replace(Veri2, ""&rsablonstr&"#qrycookie("&dilveri&")#"&rsablonstri&"",request.Cookies(dilveri))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#rehberesser(") then
dvaadet=ubound(split(Veri2,""&rsablonstr&"#rehberesser("))
for dva=1 to dvaadet
if Instr(Veri2,""&rsablonstr&"#rehberesser(") then
dilveri=split(split(Veri2,""&rsablonstr&"#rehberesser(")(1),")#"&rsablonstri&"")(0)
Veri2 = Replace(Veri2, ""&rsablonstr&"#rehberesser("&dilveri&")#"&rsablonstri&"",rehberesser(dilveri))
else
end if
next
else
end if
if Instr(Veri2,""&rsablonstr&"#urunustsecilimenu#"&rsablonstri&"") then
strmenuverisayi=ubound(split(Veri2, ""&rsablonstr&"#urunustsecilimenu#"&rsablonstri&""))
for imenu=1 to strmenuverisayi
strmenuveri=split(split(Veri2, ""&rsablonstr&"#urunustsecilimenu#"&rsablonstri&"")(1),""&rsablonstr&"#/urunustsecilimenu#"&rsablonstri&"")(0)
Veri2 = Replace(Veri2, ""&rsablonstr&"#urunustsecilimenu#"&rsablonstri&""&strmenuveri&""&rsablonstr&"#/urunustsecilimenu#"&rsablonstri&"",urunustmenu(2,menusiraadet,strmenuveri))
next
else
end if


if Instr(Veri2,""&rsablonstr&"#menuolustur(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#menuolustur("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#menuolustur(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#menuolustur(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=split(strmenuveri, ",")(1)
    if strmenuverisayib="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#menuolustur("&strmenuveri&")#"&rsablonstri&"",menuolustur(strmenuveri1,strmenuveri2,strmenuveri3))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#menucreate(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#menucreate("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#menucreate(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#menucreate(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=split(strmenuveri, ",")(1)
    if strmenuverisayib>="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
    if strmenuverisayib>="3" then
strmenuveri4=split(strmenuveri, ",")(3)
    else
    strmenuveri4="ust"
    end if
    if strmenuverisayib>="4" then
strmenuveri5=split(strmenuveri, ",")(4)
    else
    strmenuveri5="0"
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#menucreate("&strmenuveri&")#"&rsablonstri&"",menucreate(strmenuveri1,strmenuveri2,strmenuveri3,strmenuveri4,strmenuveri5))
else
end if
next
else
end if


if Instr(Veri2,""&rsablonstr&"#menucreate25(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#menucreate25("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#menucreate25(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#menucreate25(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=split(strmenuveri, ",")(1)
    if strmenuverisayib>="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
    if strmenuverisayib>="3" then
strmenuveri4=split(strmenuveri, ",")(3)
    else
    strmenuveri4="ust"
    end if
    if strmenuverisayib>="4" then
strmenuveri5=split(strmenuveri, ",")(4)
    else
    strmenuveri5="0"
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#menucreate25("&strmenuveri&")#"&rsablonstri&"",menucreate25(strmenuveri1,strmenuveri2,strmenuveri3,strmenuveri4,strmenuveri5))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#kategoriyaziliste(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#kategoriyaziliste("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#kategoriyaziliste(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#kategoriyaziliste(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=replace(split(strmenuveri, ",")(1),"$",",")
    if strmenuverisayib>="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
    if strmenuverisayib>="3" then
strmenuveri4=split(strmenuveri, ",")(3)
    else
    strmenuveri4="ust"
    end if
    if strmenuverisayib>="4" then
strmenuveri5=split(strmenuveri, ",")(4)
    else
    strmenuveri5=""
    end if
    if strmenuverisayib>="5" then
strmenuveri6=split(strmenuveri, ",")(5)
    else
    strmenuveri6="0"
    end if
    if strmenuverisayib>="6" then
strmenuveri7=split(strmenuveri, ",")(6)
    else
    strmenuveri7="0"
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#kategoriyaziliste("&strmenuveri&")#"&rsablonstri&"",kategoriyaziliste(strmenuveri1,strmenuveri2,strmenuveri3,strmenuveri4,strmenuveri5,strmenuveri6,strmenuveri7))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#eticaretkategoriliste(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#eticaretkategoriliste("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#eticaretkategoriliste(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#eticaretkategoriliste(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=replace(split(strmenuveri, ",")(1),"$",",")
    if strmenuverisayib>="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
    if strmenuverisayib>="3" then
strmenuveri4=split(strmenuveri, ",")(3)
    else
    strmenuveri4="ust"
    end if
    if strmenuverisayib>="4" then
strmenuveri5=split(strmenuveri, ",")(4)
    else
    strmenuveri5=""
    end if
    if strmenuverisayib>="5" then
strmenuveri6=split(strmenuveri, ",")(5)
    else
    strmenuveri6="0"
    end if
    if strmenuverisayib>="6" then
strmenuveri7=split(strmenuveri, ",")(6)
    else
    strmenuveri7="0"
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#eticaretkategoriliste("&strmenuveri&")#"&rsablonstri&"",eticaretkategoriliste(strmenuveri1,strmenuveri2,strmenuveri3,strmenuveri4,strmenuveri5,strmenuveri6,strmenuveri7))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#yaziliste(") then
strmenuverisayi=ubound(split(Veri2,""&rsablonstr&"#yaziliste("))
for itmenu=1 to strmenuverisayi
if Instr(Veri2,""&rsablonstr&"#yaziliste(") then
strmenuveri=split(split(Veri2,""&rsablonstr&"#yaziliste(")(1),")#"&rsablonstri&"")(0)
strmenuverisayib=ubound(split(strmenuveri,","))
if Instr(strmenuveri,",") then
strmenuveri1=split(strmenuveri, ",")(0)
strmenuveri2=replace(split(strmenuveri, ",")(1),"$",",")
    if strmenuverisayib>="2" then
strmenuveri3=split(strmenuveri, ",")(2)
    else
    strmenuveri3="1"
    end if
    if strmenuverisayib>="3" then
strmenuveri4=split(strmenuveri, ",")(3)
    else
    strmenuveri4="ust"
    end if
    if strmenuverisayib>="4" then
strmenuveri5=split(strmenuveri, ",")(4)
    else
    strmenuveri5=""
    end if
    if strmenuverisayib>="5" then
strmenuveri6=split(strmenuveri, ",")(5)
    else
    strmenuveri6="0"
    end if
    if strmenuverisayib>="6" then
strmenuveri7=split(strmenuveri, ",")(6)
    else
    strmenuveri7="0"
    end if
    if strmenuverisayib>="7" then
strmenuveri8=split(strmenuveri, ",")(7)
    else
    strmenuveri8=""
    end if
    if strmenuverisayib>="8" then
strmenuveri9=split(strmenuveri, ",")(8)
    else
    strmenuveri9=""
    end if
else
end if
Veri2 = Replace(Veri2, ""&rsablonstr&"#yaziliste("&strmenuveri&")#"&rsablonstri&"",yaziliste(strmenuveri1,strmenuveri2,strmenuveri3,strmenuveri4,strmenuveri5,strmenuveri6,strmenuveri7,strmenuveri8,strmenuveri9))
else
end if
next
else
end if

if Instr(Veri2,""&rsablonstr&"#ustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#ustmenu#"&rsablonstri&"",ustmenu(2,0,0))
else
end if
if Instr(Veri2,""&rsablonstr&"#urunustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#urunustmenu#"&rsablonstri&"",urunustmenu(2,menusiraadet))
else
end if
if Instr(Veri2,""&rsablonstr&"#rehberustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#rehberustmenu#"&rsablonstri&"",rehberustmenu(2,menusiraadet))
else
end if
    if Instr(Veri2,""&rsablonstr&"#turustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#turustmenu#"&rsablonstri&"",turustmenu(2,menusiraadet))
else
end if
if Instr(Veri2,""&rsablonstr&"#ustmenu1#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#ustmenu1#"&rsablonstri&"",ustmenu(1,0,0))
else
end if
if Instr(Veri2,""&rsablonstr&"#habermenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#habermenu#"&rsablonstri&"",haberkategorimenu())
else
end if
if Instr(Veri2,""&rsablonstr&"#aramaastore#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#aramaastore#"&rsablonstri&"",aramaastore(veri1,veri2))
else
end if
if Instr(Veri2,""&rsablonstr&"#aramaahaber#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#aramaahaber#"&rsablonstri&"",aramaahaber(veri1,veri2))
else
end if
if Instr(Veri2,""&rsablonstr&"#uyelikustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikustmenu#"&rsablonstri&"",uyelikustmenu(veri1))
else
end if
if Instr(Veri2,""&rsablonstr&"#uyelikrehberustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikrehberustmenu#"&rsablonstri&"",uyelikrehberustmenu(veri1))
else
end if
        if Instr(Veri2,""&rsablonstr&"#uyelikkuponustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikkuponustmenu#"&rsablonstri&"",uyelikkuponustmenu(veri1))
else
end if
    if Instr(Veri2,""&rsablonstr&"#uyelikturustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikturustmenu#"&rsablonstri&"",uyelikturustmenu(veri1))
else
end if
    if Instr(Veri2,""&rsablonstr&"#uyelikceustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#uyelikceustmenu#"&rsablonstri&"",uyelikceustmenu(veri1))
else
end if
if Instr(Veri2,""&rsablonstr&"#pbirimustmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#pbirimustmenu#"&rsablonstri&"",pbirimustmenu(veri1))
else
end if
if Instr(Veri2,""&rsablonstr&"#sepetimm#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#sepetimm#"&rsablonstri&"",sepetimm(2,0))
else
end if

if Instr(Veri2,""&rsablonstr&"#logomenu") then
if Instr(Veri2,""&rsablonstr&"#logomenu(") then
dilveri=split(split(Veri2,""&rsablonstr&"#logomenu(")(1),")#"&rsablonstri&"")(0)
dilveri1=split(dilveri,",")(0)
dilveri2=split(dilveri,",")(1)
Veri2 = Replace(Veri2, ""&rsablonstr&"#logomenu("&dilveri1&","&dilveri2&")#"&rsablonstri&"",logomenu(dilveri1,dilveri2)) 
else
Veri2 = Replace(Veri2, ""&rsablonstr&"#logomenu#"&rsablonstri&"",logomenu(2,0))
end if
else
end if

if Instr(Veri2,""&rsablonstr&"#aramakurumsal#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#aramakurumsal#"&rsablonstri&"",aramakurumsal(2,0))
else
end if

if Instr(Veri2,""&rsablonstr&"#dilmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#dilmenu#"&rsablonstri&"",dilmenu(2,0))
else
end if

if Instr(Veri2,""&rsablonstr&"#destekmenu#"&rsablonstri&"") then
Veri2 = Replace(Veri2, ""&rsablonstr&"#destekmenu#"&rsablonstri&"",destekmenu(2,0))
else
end if

Veri2 = Replace(Veri2, ""&rsablonstr&"#rinnlogo#"&rsablonstri&"","<script language=""javascript"" src=""//www.reklaminn.com/images/logo.js""></script>")
Veri2 = Replace(Veri2, ""&rsablonstr&"#facebookfan#"&rsablonstri&"",facebookfan)

Veri2 = Replace(Veri2, ""&rsablonstr&"#tkisi#"&rsablonstri&"",""&tkisi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#tadres#"&rsablonstri&"",""&tadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#telno#"&rsablonstri&"",""&ttel&"")

Veri2 = Replace(Veri2, ""&rsablonstr&"#AdSoyad#"&rsablonstri&"",""&akisi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#Adres#"&rsablonstri&"",""&aadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#Telefon#"&rsablonstri&"",""&atel&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#Email#"&rsablonstri&"",""&aemail&"")

Veri2 = Replace(Veri2, ""&rsablonstr&"#sAdSoyad#"&rsablonstri&"",""&sitesahip&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sAdres#"&rsablonstri&"",""&siteadress&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sTelefon#"&rsablonstri&"",""&sitetel&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#sFax#"&rsablonstri&"",""&sitefax&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#swebsite#"&rsablonstri&"",""&webadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#odemetip#"&rsablonstri&"",""&odemetipi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#fatura#"&rsablonstri&"",""&fkisi&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#fadres#"&rsablonstri&"",""&fadres&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#vdaire#"&rsablonstri&"",""&fvdaire&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#vno#"&rsablonstri&"",""&fvno&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#vtc#"&rsablonstri&"",""&ftc&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#Tarih#"&rsablonstri&"",""&date&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#toplamtutar#"&rsablonstri&"",""&toplamfiyat&" "&session("pb")&"")
Veri2 = Replace(Veri2, "`", "'")

Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_primary#"&rsablonstri&"",""& heading_banner&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_desc#"&rsablonstri&"",""& heading_desc&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_desci#"&rsablonstri&"",""& heading_desci&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_kisadesc#"&rsablonstri&"",""& heading_kisadesc&"")
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_image#"&rsablonstri&"",""& heading_image&"")
    if heading_image="" then
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_image1#"&rsablonstri&"","")
    else
Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_image1#"&rsablonstri&"",""" style=""background-image: url('"& heading_image&"');")
    end if
'Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_breadcrumbs#"&rsablonstri&"",""&urunlerim&"")

    if Instr(Veri2,""&rsablonstr&"#heading_breadcrumbs#"&rsablonstri&"") then
strmenuverisayi=ubound(split(Veri2, ""&rsablonstr&"#heading_breadcrumbs#"&rsablonstri&""))
for ibcumbs=1 to strmenuverisayi

Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_breadcrumbs#"&rsablonstri&"",breadcrumbs(strbreadcrumbs))
next
else
end if
    if Instr(Veri2,""&rsablonstr&"#heading_breadcrumbs_new#"&rsablonstri&"") then
strmenuverisayi=ubound(split(Veri2, ""&rsablonstr&"#heading_breadcrumbs_new#"&rsablonstri&""))
for ibcumbs=1 to strmenuverisayi

Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_breadcrumbs_new#"&rsablonstri&"",kategoribreadcrumbs(id,"#kylsub#","1",heading_banner))
next
else
end if
    if Instr(Veri2,""&rsablonstr&"#heading_breadcrumbs_store#"&rsablonstri&"") then
strmenuverisayi=ubound(split(Veri2, ""&rsablonstr&"#heading_breadcrumbs_store#"&rsablonstri&""))
for ibcumbs=1 to strmenuverisayi

Veri2 = Replace(Veri2, ""&rsablonstr&"#heading_breadcrumbs_store#"&rsablonstri&"",storebreadcrumbs())
next
else
end if
    
    if cdnstatu="1" then
    if instr(Veri2,"""/contents/img/") then
Veri2 = Replace(Veri2, """/contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Veri2 = Replace(Veri2, """contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Veri2 = Replace(Veri2, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    else
Veri2 = Replace(Veri2, "=/contents/img/","="&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Veri2 = Replace(Veri2, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    end if
    end if

veriguncelle=Veri2
end Function

    function breadcrumbs(fncbreadcrumbs)
   ' breadcrumbs="<div class=""breadcrumbs-wrapper"">"
    breadcrumbs=""
    'breadcrumbs=breadcrumbs&"<ul class=""phys-breadcrumb"">"
    breadcrumbs=breadcrumbs&"<li><a href="""&siteadres&""" class=""home"">"&esser("s","Anasayfa")&"</a></li>"
    breadcrumbs=breadcrumbs&""&fncbreadcrumbs
    'breadcrumbs=breadcrumbs&"</ul>"
    'breadcrumbs=breadcrumbs&"</div>"
    end function

function aramakurumsal(veri1,veri2)
aramakurumsal="<div class=""arama""><form action=""/urun-arama"&seosonu&""" method=""post"" ><input value="""&esser("s","Arama Kelimesi")&""" id=""searchBox"" name=""ara"" class=""ara"" onfocus=""if (this.value == '"&esser("s","Arama Kelimesi")&"'){this.value ='' }""/><input name=""ara1"" type=""submit"" value="">"" class=""arabuton"" /></form></div>"
end function
    
function logomenu(deger1,deger2)
 logomenu="<a href=""/"" aria-label="""&sitesahip&""">"
    logomenu=logomenu&"<div id=""logo""></div>"
    logomenu=logomenu&"</a>"
    if deger2="1" then    
logomenu=logomenu&"<button type=""button"" class=""navbar-toggle collapsed logomenumobil"" id=""logomenumobil"" data-toggle=""collapse"" data-target=""#navbarlogo"" aria-expanded=""false"" aria-controls=""navbar"">"
logomenu=logomenu&"<div class=""sr-only"">Kategoriler</div>"
logomenu=logomenu&"<div class=""sr-icon-button"">"
logomenu=logomenu&"<span class=""icon-bar""></span>"
logomenu=logomenu&"<span class=""icon-bar""></span>"
logomenu=logomenu&"<span class=""icon-bar""></span>"
logomenu=logomenu&"</div>"
logomenu=logomenu&"</button>"
    logomenu=logomenu&"<div class=""logo-block-menu-top logomenu""><ul id=""navbarlogo"" class=""navbar-nav nav navbar-collapse""><li></li></ul></div>"
    end if
    end Function
	
	
function dilmenu(deger1,deger2)
	dilmenu="<div class=""ustdil"">"
set mmmGenel = Con.Execute ("select * from diller1 where alt = '1' and sira = '1' ORDER BY kate desc")
Do While Not mmmGenel.EOF
dilmenu=dilmenu&"<div class=""follinks dil"&mmmGenel("id")&"""><a href=""?dildegis=1&dil="&mmmGenel("id")&""">"&mmmGenel("kate")&"</a></div>"
mmmGenel.movenext
loop
close(mmmGenel)
dilmenu=dilmenu&"</div>"
end Function
function destekmenu(deger1,deger2)
	destekmenu="<span>"&esser("s","Destek Tel:")&"</span> "&sitetel&""
	end Function
	

%>

<%function ozellikbaslikcek(formid,gorozel)
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1'"&gorozel&" order by sira"
 set mmmYardimci3 = Con.Execute (sqlString)
Do While Not mmmYardimci3.EOF
formisim=mmmYardimci3("isim")
if request.cookies("remember_dil")="240" then
formisim=formisim
else
sqlString = "select * from ozellikler where bagli="&mmmYardimci3("id")&" and dil='"&request.cookies("remember_dil")&"'"
set mmmSayfa1 = Con.Execute (sqlString)
if mmmSayfa1.eof then
formisim=formisim
else
formisim=mmmSayfa1("isim")
end if
close(mmmSayfa1)
end if
 
ozellikbaslikcek=formisim
						  
mmmYardimci3.movenext
loop
close(mmmYardimci3)
end function

    function siteformvalidatescriptd(formidd,rules)
          siteformvalidatescript="var validatorsiteform = $(""#siteForm"&formidd&""").validate({"
         siteformvalidatescript= siteformvalidatescript&""&rules
				siteformvalidatescript= siteformvalidatescript&"errorElement: ""em"","
				siteformvalidatescript= siteformvalidatescript&"errorPlacement: function( error, element ) {"
					siteformvalidatescript= siteformvalidatescript&"error.addClass( ""help-block"" );"

					siteformvalidatescript= siteformvalidatescript&"if ( element.is( "":radio"" ) ) {"
						siteformvalidatescript= siteformvalidatescript&"error.appendTo( element.parent().parent().find( ""label:first"" ) );"
                                      siteformvalidatescript= siteformvalidatescript&"} else if (element.is("":checkbox"")) {"
                                    siteformvalidatescript= siteformvalidatescript&"error.appendTo( element.parent().parent().find( ""label:first"" ) );"
					siteformvalidatescript= siteformvalidatescript&"} else {"					
						siteformvalidatescript= siteformvalidatescript&"error.insertAfter( element );"
					siteformvalidatescript= siteformvalidatescript&"}"
				siteformvalidatescript= siteformvalidatescript&"},"
				siteformvalidatescript= siteformvalidatescript&"highlight: function ( element, errorClass, validClass ) {"
					siteformvalidatescript= siteformvalidatescript&"$( element ).parents( "".custom-placeholder"" ).addClass( ""has-error"" ).removeClass( ""has-success"" );"
				siteformvalidatescript= siteformvalidatescript&"},"
				siteformvalidatescript= siteformvalidatescript&"unhighlight: function (element, errorClass, validClass) {"
					siteformvalidatescript= siteformvalidatescript&"$( element ).parents( "".custom-placeholder"" ).addClass( ""has-success"" ).removeClass( ""has-error"" );"
				siteformvalidatescript= siteformvalidatescript&"}"
     siteformvalidatescriptd= siteformvalidatescript&" });"
    end function

%>
<%function ozellikcek(formid,gorozel,formidtur,csstip)
 sqlString = "select * from ozellikler where formid='"&formid&"'"&gorozel&" order by sira"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
rsformtur=mmmYardimci("tur")
rsformid=mmmYardimci("id")
 sqlString = "select * from ozellikler2 where ozelikid='"&rsformid&"' and tur='"&formidtur&"' order by id"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
valuefo="0"
else
valuefo=mmmYardimci3("isim")
end if
close(mmmYardimci3)

if rsformtur=1 or rsformtur=3 or rsformtur=12 or rsformtur=13 or rsformtur=10 or rsformtur=11 then
ozellikcek=valuefo
                    elseif rsformtur=2 then
    ozellikcek=valuefo
    elseif rsformtur=7 then
veri=valuefo
ozellikcek="<a href="""&imggaleriyol&""&veri&""" target=""_blank"">"&veri&"</a>"
		  elseif rsformtur=4 then

sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&rsformid&"' order by sira"
set mmmYardimci3 = Con.Execute (sqlString)
'ozellikcek=ozellikcek&""&sqlString
Do While Not mmmYardimci3.EOF
formisim=dilozellikcek(mmmYardimci3("id"),mmmYardimci3("isim"),lang)
if instr(valuefo,formisim) then
ozellikcek=ozellikcek&"<div class=""list_li"&csstip&""">"&formisim&"</div>"
else
end if
mmmYardimci3.movenext
loop
close(mmmYardimci3)

elseif rsformtur=5 or rsformtur=6 then			
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&rsformid&"' and name='"&valuefo&"' order by sira"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
formisim=dilozellikcek(mmmYardimci3("id"),mmmYardimci3("isim"),lang)
ozellikcek=formisim
end if
close(mmmYardimci3)

elseif rsformtur=8 then

 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&rsformid&"' order by sira"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
Do While Not mmmYardimci3.Eof
RSaltisim=mmmYardimci3("isim")
RSalttur=mmmYardimci3("tur")
rsaltid=mmmYardimci3("id")

 sqlString = "select * from ozellikler2 where ozelikid='"&rsaltid&"' and tur='"&formidtur&"' order by id"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
valuefo=""
else
rsform2isim=mmmYardimci1("isim")
if instr(rsform2isim,", TL") then
pb="TL"
elseif instr(rsform2isim,", USD") then
pb="USD"
elseif instr(rsform2isim,", EURO") then
pb="EURO"
elseif instr(rsform2isim,", -") then
pb=""
else
pb="TL"
end if
if instr(rsform2isim,",") then
valuefo=replace(rsform2isim,", TL","")
else
valuefo=rsform2isim
end if
end if
close(mmmYardimci1)

formisim=dilozellikcek(rsaltid,RSaltisim)
if RSalttur=1 then
ozellikcek=formisim&" : "&valuefo&"<br />"
elseif RSalttur=4 then
					   
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&RSaltid&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
Do While Not mmmYardimci1.Eof
formisim=dilozellikcek(mmmYardimci1("id"),mmmYardimci1("isim"))
if instr(valuefo,formisim) then
ozellikcek=ozellikcek&""&formisim
else
end if
mmmYardimci1.movenext
loop
end if
close(mmmYardimci1)
                               elseif RSalttur=8 then
							   ozellikcek=ozellikcek&"<div class=""list_table_tab2"&csstip&""">"
                        ozellikcek=ozellikcek&"<div class=""list_table_tab_anabaslik"&csstip&""">"&formisim&"</div>"

qlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&RSaltid&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
else
Do While Not mmmYardimci2.Eof
rsalt1id=mmmYardimci2("id")
 sqlString = "select * from ozellikler2 where ozelikid='"&rsalt1id&"' and tur='"&formidtur&"' order by id"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
valuefo=""
else
rsform2isim=mmmYardimci1("isim")
if instr(rsform2isim,", TL") then
pb="TL"
elseif instr(rsform2isim,", USD") then
pb="USD"
elseif instr(rsform2isim,", EURO") then
pb="EURO"
elseif instr(rsform2isim,", -") then
pb=""
else
pb="TL"
end if
if instr(rsform2isim,",") then
valuefo=replace(rsform2isim,", TL","")
else
valuefo=rsform2isim
end if
end if
close(mmmYardimci1)

formisim=mmmYardimci2("isim")
RSalt1tur=mmmYardimci2("tur")
if instr(valuefo,"#1#") and valuefo<>"" then

if RSalt1tur=1 then

ozellikcek=ozellikcek&"<div class=""list_table_tab_icerik"&csstip&""">"&formisim&"  "&replace(valuefo,"#1#","")&"</div>"
                       elseif RSalt1tur=4 then
					   
sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&rsalt1id&"' order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
Do While Not mmmYardimci1.Eof
formisim=dilozellikcek(mmmYardimci1("id"),mmmYardimci1("isim"))
if instr(valuefo,formisim) then
ozellikcek=ozellikcek&""&formisim
else
end if
mmmYardimci1.movenext
loop
end if
close(mmmYardimci1)
                         elseif RSalt1tur=8 then
							  else
							  end if
							  else
							  end if
							  
mmmYardimci2.movenext
loop
end if
ozellikcek=ozellikcek&"</div>"
close(mmmYardimci2)
elseif RSalttur=10 then
if instr(valuefo,"#1#") and valuefo<>"" then
if instr(valuefo,",") then
valuefo=split(valuefo,",")(0)
else
end if
ozellikcek=ozellikcek&"<div class=""list_table_tab1"&csstip&""">"
ozellikcek=ozellikcek&""&formisim&" : "&replace(valuefo,"#1#","")&" "&pb&""
ozellikcek=ozellikcek&"</div>"
 else
							  end if
							  else
							  end if
							  'ozellikcek=ozellikcek&"</div>"
							  
 mmmYardimci3.movenext
loop  
end if
close(mmmYardimci3)


elseif rsformtur=9 then
if instr(valuefo,">") then
tur9adet=ubound(split(valuefo,">"))
for o = 0 to tur9adet
valuefo1=split(valuefo,">")(o)
if valuefo1="" then
valuefo1="0"
else
end if

 sqlString = "select * from ozellikler where id="&valuefo1&" order by sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
if o=0 then
oayrac=""
else
oayrac=" - "
end if
formisim=formisim&""&oayrac&""&RSalt("isim")
end if
close(mmmYardimci1)

                                 session("valuefo")=valuefo
								 next
								 ozellikcek=formisim
								 else
								 end if

      elseif rsformtur>50 then    
	  ozellikcek= valuefo                 
else
if valuefo="" or isNull(valuefo) then
valuefo="0"
else
valuefo=valuefo
end if	
sqlString = "select * from kategoriyazi where anasek='"&rsformtur&"' and id="&valuefo&" order by sira"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
else
formisim=dilozellikcek(mmmYardimci3("id"),mmmYardimci3("isim"))
ozellikcek=formisim
end if
close(mmmYardimci3)

end if
					  
mmmYardimci.movenext
loop
close(mmmYardimci)
end function

    function emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,gonderen,alici,baslik1,HTML,basarisayfa,hatasayfa)
    if smtpserver="" then
        donusmesaj=""
        if basarisayfa="" or isNull(basarisayfa) or basarisayfa="0" or basarisayfa="#" then
        emailgonderikodu="{""response"":""success""}"
        else
        emailgonderikodu="{""response"":""success"",""successMessage"":"""&server.HTMLEncode(donusmesaj)&""",""selfLink"":"""&pathim&""&basarisayfa&"""}"
        end if
    else


	     Set objMail = Server.CreateObject("CDO.Message")
	    Set objConf = Server.CreateObject("CDO.Configuration") 
	    Set objFields = objConf.Fields
	
            Sch = "http://schemas.microsoft.com/cdo/configuration/" 
	                With objFields
                        .Item(Sch & "sendusing")                       = 2
                        .Item(Sch & "smtpserver")                    = smtpserver
                        .Item(Sch & "smtpconnectiontimeout")                    = 10
                        .Item(Sch & "smtpserverport")                = smtpport
            if smtpauth="1" then
                .Item(Sch & "smtpauthenticate") = smtpauth
            if smtpssl="1" then
                .Item(Sch & "smtpusessl") = smtpssl
    end if
                .Item(Sch & "sendusername") = smtplogin
                .Item(Sch & "sendpassword")  = smtppassword
		    else
		    end if

		    .Update 
	    End With

	    With objMail
		    Set .Configuration = objConf
		    .bodyPart.Charset = "UTF-8"
		    .From = gonderen
		    .To = alici
		    .Subject = baslik1
		    .HtmlBody = HTML
	    End With
    
        Err.Clear 
	    on error resume next

        objMail.Send
	    if len(Err.Description) = 0 then
            mes = " The message was sent to " + sTo
            mes = mes + " "
            IsSuccess = true
        donusmesaj=""
        if basarisayfa="" or isNull(basarisayfa) or basarisayfa="0" or basarisayfa="#" then
        emailgonderikodu="{""response"":""success""}"
        else
        emailgonderikodu="{""response"":""success"",""successMessage"":"""&server.HTMLEncode(donusmesaj)&""",""selfLink"":"""&pathim&""&basarisayfa&"""}"
        end if
        else
		    mes = " " + Err.Description + " The mail sending test failed."
        emailgonderikodu="{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(mes)&"""}"
	    end if
          'response.Write mes
        'response.Write "1"
	    Set objFields = Nothing
	    Set objConf = Nothing
	    Set objMail = Nothing
    end if

Con.Execute "INSERT INTO form_logs (uyeid, sipid, mkate, mesajb, mesajt, cevap, tarih, ip, alici_email) VALUES (" & _
            uyeid & ", " & sipid & ", " & formid & ", '" & Replace(baslik1, "'", "''") & "', '" & Replace(HTML, "'", "''") & "', '" & Replace(emailgonderim, "'", "''") & "', NOW(), '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & Replace(alici, "'", "''") & "')"
    end function

    islem=request.QueryString("islem")
    if islem="" and request.form("islem")<>"" then
    islem=request.form("islem")
    end if
    formid=giriskont(request.QueryString("formid"))
if islem="formgonder" then																	
call formgonderikayit(formid,1)
elseif islem="contentajaxload" then	
    strmstemp=request.QueryString("strtemp")	
    response.Write yanliste(strmssayfa,strmstemp,strmsbaslik,12,ayar3)
response.End
elseif islem="sitereviewsekle" then			
    formid=giriskont(request.Form("formid"))
call formgonderikayit(formid,1)
else
end if

    sub reviewgonderikayit(formidm,egonder)
    Response.AddHeader "Content-Type", "application/json"
    'response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(request.Form("egitim"))&"asd""}"
    'response.End
    if formidm<>"" or (isNull(formidm)=false and isNumeric(formidm)=true)  then	
    else
    response.Write "{""response"":""error"",""errorMessage"":""-9999("&formidm&")""}"
    response.End
    end if
    if request.Form="" then response.End
     set mmmYardimci2 = Con.Execute ("select * from formlar where id="&formidm&"")
		if mmmYardimci2.eof then
		else			
gmesaj=dilform(mmmYardimci2("id"),mmmYardimci2("gmesaj"),lang)
alici=mmmYardimci2("froms")
smtpbasarisayfa1=mmmYardimci2("basarisayfa")
   smtpbasarisayfa= seolarlink(smtpbasarisayfa1,"sayfa",lang)
smtphatasayfa=mmmYardimci2("hatasayfa")
smtpsmtpid=mmmYardimci2("smtpid")
sitename = siteadres
tarih =date()
formadi=mmmYardimci2("formadi")
baslik1=""&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&""
    ipblacklist=mmmYardimci2("ipblacklist")
    korumazaman=mmmYardimci2("korumazaman")
    if korumazaman="" then
    korumazaman="5"
    end if

     set mmmYardimci1 = Con.Execute ("select * from formsmtp where id="&smtpsmtpid&"")
		if mmmYardimci1.eof then
		else			
smtpserver=mmmYardimci1("smtpserver")
smtpport=mmmYardimci1("smtpport")
smtplogin=mmmYardimci1("login")
smtppassword=mmmYardimci1("password")
smtpssl=mmmYardimci1("ssls")
smtpauth=mmmYardimci1("smtpauth")
end if
close(mmmYardimci1)

end if
close(mmmYardimci2)
    if session(formidm)="" then
						session(formidm)=1
						session(formidm&"zaman")=Now
						fgonder=1
						else
						if DateDiff("n",session(formidm&"zaman"),Now)<korumazaman*1 then
						fgonder=0
						else
						session(formidm&"zaman")=Now
						fgonder=1
						end if
						end if
						fgonder=1
						if fgonder=1 then
'Set Upload = Server.CreateObject("Persits.Upload.1") 

    
    'response.Write session("uye_kodu1")&"-"&gkodu
   ' response.End(session("uye_kodu1")=gkodu and)  or (session("uye_kodu2")=gkodu)

 '   Upload.IgnoreNoPost = True
'Upload.CodePage = 65001
'Upload.OverwriteFiles = false
'Count = Upload.SaveToMemory 
'gkodu=upload.form("sifre2")
gkodu="1"
    'response.Write session("uye_kodu1")&"="&gkodu and session("uye_kodu1")=gkodu
if gkodu<>"" then 
    else  
    session(formidm)=""   
     'response.Redirect("?form=gonder&fgondergkodu=3")
    response.Write "3]["&mgd
     response.End
end if

    
if recaptchvar="" then
        else
    recaptcha3kod=request.form("g-recaptcha-response")
        if recaptcha3kod="" and isNull(recaptcha3kod) then
    session(formidm)=""
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("s","Google Güvenlik Doğrulamasından Geçemediniz. (-1)"))&"""}"
    response.End
        else
        recaptcha3jsonsuc=recaptch3cek(recaptcha3secretkey,recaptcha3kod,ipadresiniz)
        if recaptcha3jsonsuc="true" then 
        recaptcha3hata="1"
        else
    session(formidm)=""
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("s","Google Güvenlik Doğrulamasından Geçemediniz. (-2)"))&"""}"
    response.End
        end if
	end if
	end if

    o=0
     Contur.execute("insert "&dbreviews&" set mesajturu='reviews', gelenid='"&request.Form("email")&"', itemid='"&request.Form("reviewswonid")&"', message='"&request.Form("message")&"', subject='"&request.Form("namesurname")&"', stared='"&request.Form("rated")&"', onay='0', tarih='"&now&"'")
        ' Bu araya revies kayıt sokalım
'egonder basla
if egonder="1" then
'email gönderme basla
Dim html
    html = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    html = html & "<html>"
    html = html & "<head>"
    html = html & "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">"
    html = html & "<title>"&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&"</title>"
    html = html & "</head>"
    html = html & "<body>"
    html = html & "<br>"
	html = html & ""&mesajhtml
    html = html & "</body>"
    html = html & "</html>"

    if gonderen="1" then
	else
    baslik2=" Mesajı Gönderdiniz."

    mgd=emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,smtplogin&","&gonderen,alici&"",baslik1,HTML,smtpbasarisayfa,smtphatasayfa)
    'response.Write "success"
    response.Write mgd
    'response.Write emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,alici,gonderen,baslik1&" "&baslik2,HTML)
end if
   ' response.Write "1a"
'email gönderme bitis
else
end if
    'response.Write "1b"
'egonder sonu

   ' response.Write "2"
    'response.Redirect("?form=gonder&fgondergkodu=1&message="&mgd&"")
    response.End
else
     'response.Redirect("?form=gonder&fgondergkodu=2&message="&mgd&"")
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("a","Gönderilerinizi 5dk içinde sadece bir kere yapabilrsiniz. Daha sonra tekrar deneyiniz."))&"""}"
    response.End
end if
    end sub

response.Write(fgondergkodu)
response.Write(gmesaj)
sub formgonderikayit(formidm,egonder)
    Response.AddHeader "Content-Type", "application/json"
    'response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(request.Form("egitim"))&"asd""}"
    'response.End
    if formid<>"" or (isNull(formid)=false and isNumeric(formid)=true)  then	
    else
    response.Write "{""response"":""error"",""errorMessage"":""-9999""}"
    response.End
    end if
    
    if request.Form="" then response.End
     set mmmYardimci2 = Con.Execute ("select * from formlar where id="&formidm&"")
		if mmmYardimci2.eof then
		else			
gmesaj=dilform(mmmYardimci2("id"),mmmYardimci2("gmesaj"),lang)
alici=mmmYardimci2("froms")
smtpbasarisayfa1=mmmYardimci2("basarisayfa")
   smtpbasarisayfa= seolarlink(smtpbasarisayfa1,"sayfa",lang)
smtphatasayfa=mmmYardimci2("hatasayfa")
smtpsmtpid=mmmYardimci2("smtpid")
smtpsmtpport=mmmYardimci2("smtpport")
smtpsmtplogin=mmmYardimci2("login")
sitename = siteadres
tarih =date()
formadi=mmmYardimci2("formadi")
musteriemailbaslik=esser("sm",""&mmmYardimci2("password")&"")
    if musteriemailbaslik="" or isNull(musteriemailbaslik) then
musteriemailbaslik=""&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&""
    end if
baslik1=esser("sm",""&mmmYardimci2("ssls")&"")
    if baslik1="" or isNull(baslik1) then
baslik1=""&sitename&" Sitenizin "&tarih&" Tarihli "&formadi&""
    end if
    ipblacklist=mmmYardimci2("ipblacklist")
    korumazaman=mmmYardimci2("korumazaman")
    if korumazaman="" then
    korumazaman="5"
    end if

     set mmmYardimci1 = Con.Execute ("select * from formsmtp where id="&smtpsmtpid&"")
		if mmmYardimci1.eof then
		else			
smtpserver=mmmYardimci1("smtpserver")
smtpport=mmmYardimci1("smtpport")
smtplogin=mmmYardimci1("login")
smtppassword=mmmYardimci1("password")
smtpssl=mmmYardimci1("ssls")
smtpauth=mmmYardimci1("smtpauth")
end if
close(mmmYardimci1)

end if
close(mmmYardimci2)
    if session(formidm)="" then
						session(formidm)=1
						session(formidm&"zaman")=Now
						fgonder=1
						else
						if DateDiff("n",session(formidm&"zaman"),Now)<korumazaman*1 then
						fgonder=0
						else
						session(formidm&"zaman")=Now
						fgonder=1
						end if
						end if
						fgonder=1
						if fgonder=1 then
'Set Upload = Server.CreateObject("Persits.Upload.1") 

    
    'response.Write session("uye_kodu1")&"-"&gkodu
   ' response.End(session("uye_kodu1")=gkodu and)  or (session("uye_kodu2")=gkodu)

 '   Upload.IgnoreNoPost = True
'Upload.CodePage = 65001
'Upload.OverwriteFiles = false
'Count = Upload.SaveToMemory 
'gkodu=upload.form("sifre2")
gkodu="1"
    'response.Write session("uye_kodu1")&"="&gkodu and session("uye_kodu1")=gkodu
if gkodu<>"" then 
    else  
    session(formidm)=""   
     'response.Redirect("?form=gonder&fgondergkodu=3")
    response.Write "3]["&mgd
     response.End
end if

    
if recaptchvar="" then
        else
    recaptcha3kod=request.form("g-recaptcha-response")
        if recaptcha3kod="" and isNull(recaptcha3kod) then
    session(formidm)=""
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("s","Google Güvenlik Doğrulamasından Geçemediniz. (-1)"))&"""}"
    response.End
        else
        recaptcha3jsonsuc=recaptch3cek(recaptcha3secretkey,recaptcha3kod,ipadresiniz)
        if recaptcha3jsonsuc="true" then 
        recaptcha3hata="1"
        else
    session(formidm)=""
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("s","Google Güvenlik Doğrulamasından Geçemediniz. (-2)"))&"""}"
    response.End
        end if
	end if
	end if

    o=0
'For Each File in Upload.Files
    
'Set File1 = Upload.Files(1)

'ressize=File.Size
'resw=File.ImageWidth
'resh=File.ImageHeight
'rest=File.ImageType
 '   dost=File.Ext
    if rest="UNKNOWN" THEN
    fname=""&baslikkont(Replace(now, "." , "", 1, -1, 1))&""&dost&""
    ELSE
    'fname=""&Replace(date, "." , "", 1, -1, 1)&""&baslikkont(replace(File.Filename,dost,""))&""&dost&""
    end if
If rest="exe" or rest="gif" then
Response.Write"<center><b>Dikkat ! Exe Dosya Formatı Yükleyemessiniz.<br><br><a href=""javascript:history.back(-1)"">Yenile</a></b></center><td height=15></td>"
Response.end
end if

'Path = (Server.MapPath(imggaleriyol&""&fname&""))

'File.SaveAs Path

o=o+1
if o=1 then
fname1=fname
else
fname1=fname&","&fname1
end if
'Next					

set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formidm&"' and alt = '1' and gonderen = '1' order by sira")
if mmmYardimci2.eof then
'gonderen=1
gonderen=alici
emailvarmiki="0"
else
'gonderen=giriskont(upload.form(""&mmmYardimci2("name")&""))
gonderen=giriskont(request.form(""&mmmYardimci2("name")&""))
emailvarmiki="1"
end if
close(mmmYardimci2)
karakterler1="0123456789abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ"
randomize
karakterboyu1=len(karakterler1)
for ilk = 1 to 5
kacincikarakter1=cint((karakterboyu1*rnd)+1)
uretilensifre1=uretilensifre1&mid(karakterler1,kacincikarakter1,1)
next
sifreuret1 = uretilensifre1

     set mmmYardimci2 = Con.Execute ("select gerekli,name from ozellikler where formid='"&formidm&"' and alt = '1' order by sira")
  Do While Not mmmYardimci2.EOF    
  checgereklig=mmmYardimci2("gerekli")
    checnameg=mmmYardimci2("name")
    verig=giriskont(request.form(""&checnameg&""))
        if checgereklig="1" and verig="" then    
    session(formidm)=""   
     'response.Redirect("?form=gonder&fgondergkodu=3")
    checgerekligs= checgerekligs&"-"&checnameg
    'response.Write "4]["&mgd
    else
    checgerekligs= checgerekligs
    end if
mmmYardimci2.movenext
loop
close(mmmYardimci2)

    if len(checgerekligs)>"3" then
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("a","Giriş Zorunlu Alanlar Var. Tekrar Deneyiniz. (-1)"))&"-"&checnameg&"""}"
     response.End
    end if

Con.execute("insert ozellikler2 set formid='"&formidm&"',ozelikid='1',isim='1',tur='"&sifreuret1&"',oku='0',ip='"&ip&"',kateid='"&kateid&"',tarih='"&now&"'")

 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formidm&"' and alt = '1' order by sira")
  Do While Not mmmYardimci2.EOF    
  checgerekli=mmmYardimci2("gerekli")
    checname=mmmYardimci2("name")
    chectur=mmmYardimci2("tur")
    fid=mmmYardimci2("id")
    fisim=mmmYardimci2("isim")
    formisim=dilformv(fid,fisim,lang)
                      if chectur=4 then
						 veri=""
set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formidm&"' and anasek='"&mmmYardimci2("id")&"' order by sira")
  Do While Not mmmYardimci3.EOF
  checname3=mmmYardimci3("name")
'if giriskont(upload.form(""&checname3&""))="" then
if giriskont(request.form(""&checname3&""))="" then
else
 veri1=veri1&","&giriskont(request.form(""&checname3&""))              
 'veri1=veri1&","&giriskont(upload.form(""&checname3&""))              
 end if
mmmYardimci3.movenext
loop
close(mmmYardimci3)
veri=veri1
'response.Write(veri)
'response.End()
elseif chectur=7 then
if isNull(fname1) or o=0 then
veri="0"
else
ty=ty+1
fname1adet=ubound(split(fname1,","))
if ty=1 then
veri=split(fname1,",")(0)
elseif ty=2 and fname1adet>=1 then
veri=split(fname1,",")(1)
elseif ty=3 and fname1adet>=2 then
veri=split(fname1,",")(2)
elseif ty=4 and fname1adet>=3 then
veri=split(fname1,",")(3)
elseif ty=5 and fname1adet>=4 then
veri=split(fname1,",")(4)
else
veri="0"
end if
end if
veri=veri
veri3="<a href="""&sitename&""&imggaleriyol&""&veri&""" target=""_blank"">"&sitename&""&imggaleriyol&""&veri&"</a>"
elseif chectur=8 then
veri=""
set mmmYardimci1 = Con.Execute ("select * from ozellikler where formid='"&formidm&"' and anasek='"&mmmYardimci2("id")&"' order by sira")
  Do While Not mmmYardimci1.EOF
    fid=mmmYardimci1("id")
    fisim=mmmYardimci1("isim")
    formisim=dilformv(fid,fisim,lang)
                        if mmmYardimci1("tur")=4 then
						 veri2=""
set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formidm&"' and anasek='"&fid&"' order by sira")
  Do While Not mmmYardimci3.EOF
  checname3=mmmYardimci3("name")
'if giriskont(upload.form(""&checname3&""))="" then
if giriskont(request.form(""&checname3&""))="" then
else
 veri1=veri1&","&giriskont(request.form(""&checname3&""))              
 'veri1=veri1&","&giriskont(upload.form(""&checname3&""))              
 end if
mmmYardimci3.movenext
loop
close(mmmYardimci3)
veri2=veri1
'response.Write(veri)
'response.End()
elseif mmmYardimci1("tur")=7 then
if isNull(fname1) or o=0 then
veri2="0"
else
ty=ty+1
fname1adet=ubound(split(fname1,","))
if ty=1 then
veri=split(fname1,",")(0)
elseif ty=2 and fname1adet>=1 then
veri=split(fname1,",")(1)
elseif ty=3 and fname1adet>=2 then
veri=split(fname1,",")(2)
elseif ty=4 and fname1adet>=3 then
veri=split(fname1,",")(3)
elseif ty=5 and fname1adet>=4 then
veri=split(fname1,",")(4)
else
veri2="0"
end if
end if
veri2=veri
veri4="<a href="""&sitename&""&imggaleriyol&""&veri&""" target=""_blank"">"&sitename&""&imggaleriyol&""&veri&"</a>"
elseif mmmYardimci1("tur")=8 then
veri2=""
else
'veri2=giriskont(upload.form(""&mmmYardimci1("name")&""))
veri2=giriskont(request.form(""&mmmYardimci1("name")&""))
					   end if
					   if mmmYardimci1("tur")=7 then
					   mesajhtml = mesajhtml & "<b>" & fisim&" :</b> " & veri4	
					   else
					   mesajhtml = mesajhtml & "<b>" & fisim&" :</b> " & veri
					   end if
				mesajhtml = mesajhtml & "<hr>" 
					   
					   Con.execute("insert ozellikler2 set formid='"&formidm&"',ozelikid='"&fid&"',isim='"&veri2&"',tur='"&sifreuret1&"',kateid='"&kateid&"',oku='0',onay='0',tarih='"&now&"'")
				
  mmmYardimci1.movenext
loop
close(mmmYardimci1)
else
'veri=giriskont(upload.form(""&checname&""))
veri=server.HTMLEncode(giriskont(request.form(""&checname&"")))
					   end if

				if chectur=7 then
					   mesajhtml = mesajhtml & "<b>" & fisim&" :</b> " & veri3	
					   else
					   mesajhtml = mesajhtml & "<b>" & fisim&" :</b> " & veri
					   end if
				mesajhtml = mesajhtml & "<hr>" 
			
	Con.execute("insert ozellikler2 set formid='"&formidm&"',ozelikid='"&mmmYardimci2("id")&"',isim='"&veri&"',tur='"&sifreuret1&"',oku='0',onay='0',tarih='"&now&"'")
			 

mmmYardimci2.movenext
loop
close(mmmYardimci2)
    if islem="sitereviewsekle" then
    Contur.execute("insert "&dbreviews&" set mesajturu='reviews', gelenid='"&request.Form("email")&"', itemid='"&request.Form("reviewswonid")&"', message='"&request.Form("message")&"', subject='"&request.Form("namesurname")&"', stared='"&request.Form("rated")&"', onay='0', tarih='"&now&"'")
    end if
'egonder basla
if egonder="1" then
'email gönderme basla
Dim html
    html = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    html = html & "<html>"
    html = html & "<head>"
    html = html & "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">"
    html = html & "<title>"&baslik1&"</title>"
    html = html & "</head>"
    html = html & "<body>"
    html = html & "<br>"
	html = html & ""&mesajhtml
    html = html & "</body>"
    html = html & "</html>"

    if gonderen="1" then
	else
    baslik2=" Mesajı Gönderdiniz."

    mgd=emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,smtplogin&","&gonderen,alici&"",baslik1,HTML,smtpbasarisayfa,smtphatasayfa)
    responsemsg=mgd
    'response.Write "success"
    'response.Write emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,alici,gonderen,baslik1&" "&baslik2,HTML)
end if
    if smtpsmtpport="1" then
    baslik2=" Mesajı Gönderdiniz."
    
    html = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    html = html & "<html>"
    html = html & "<head>"
    html = html & "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">"
    html = html & "<title>"&musteriemailbaslik&"</title>"
    html = html & "</head>"
    html = html & "<body>"
    html = html & ""&smtpsmtplogin
    html = html & "<br>"
	html = html & ""&mesajhtml
    html = html & "</body>"
    html = html & "</html>"

    mgd=emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,smtplogin&"",""&gonderen,musteriemailbaslik,HTML,smtpbasarisayfa,smtphatasayfa)
    'response.Write "success"
    responsemsg=responsemsg&"<br>"&mgd
    response.Write mgd
    'response.Write emailgonderikodu(smtpserver,smtpport,smtpssl,smtpauth,smtplogin,smtppassword,alici,gonderen,baslik1&" "&baslik2,HTML)
	else
    response.Write mgd
end if
Con.execute("update ozellikler2 set response='"&responsemsg&"' where formid='"&formidm&"' and ozelikid='1' and isim='1' and tur='"&sifreuret1&"'")
   ' response.Write "1a"
'email gönderme bitis
else
end if
    'response.Write "1b"
'egonder sonu
    'Ek Talep Kodu 
    'accountpost = VeriPost(strUrl,strData,strCtype) 
   ' response.Write "2"
    'response.Redirect("?form=gonder&fgondergkodu=1&message="&mgd&"")
    response.End
else
     'response.Redirect("?form=gonder&fgondergkodu=2&message="&mgd&"")
    response.Write "{""response"":""error"",""errorMessage"":"""&server.HTMLEncode(esser("a","Gönderilerinizi 5dk içinde sadece bir kere yapabilrsiniz. Daha sonra tekrar deneyiniz."))&"""}"
    response.End
end if
end sub

    function emailbodytemp(formid,bodystr)
    dim ebtstr(100)
    	set mmmSayfa1 = Con.Execute ("select * from formlar where id="&formid&"")
if mmmSayfa1.eof then
else
emailbodytemp=veriguncelle(mmmSayfa1("mailtemp"))
end if
close(mmmSayfa1)
    if instr(bodystr,"#-#") then
    bodystrcount=ubound(split(bodystr,"#-#"))
    for bodystri=0 to bodystrcount
    bodystrii=bodystri+1
    if instr(emailbodytemp,"#ebtstr("&bodystri&")#") then
    ebtstr(bodystri)=split(bodystr,"#-#")(bodystri)
    emailbodytemp=replace(emailbodytemp,"#ebtstr("&bodystri&")#",ebtstr(bodystri))
    else
    end if
    next
    emailbodytemp1=emailbodytemp1&"<html><head><link href=""https://stackpath.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"" rel=""stylesheet"" type=""text/css"" /><title>"&acik&"</title></head><body><table border=""0"" width=""100%"" cellspacing=""1"" cellpadding=""10""><tbody><tr><td bgcolor=""#FFFFFF"">"
    emailbodytemp1=emailbodytemp1&""&emailbodytemp
    emailbodytemp=emailbodytemp1&"</td></tr></tbody></table><table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0""><tbody><tr><td align=""center"" height=""40"">"&webadres&"<br />"&siteemail&"<br />"&sitetel&"</td></tr></tbody></table></body></html>"
    else
    end if
	end function

     function emailgonderim(efrom,talepmail,baslik1,HTML,formid)
        	set mmmSayfa1 = Con.Execute ("select * from formlar where id="&formid&"")
if mmmSayfa1.eof then
    emailgonderim="Form Seçilmedi"
else
smtplogin=mmmSayfa1("login")
sitealici=mmmSayfa1("froms")
from=""&sitesahip&"<"&sitealici&">"
if efrom="2" then
alici=talepmail
    else
if efrom="0" then
alici=sitealici
else
alici=sitealici&","&talepmail
end if
    end if
smtpserver=mmmSayfa1("smtpserver")
smtpport=mmmSayfa1("smtpport")

smtppassword=mmmSayfa1("password")
smtpssl=mmmSayfa1("ssls")
sitename = siteadres
tarih =date()
formadi=mmmSayfa1("formadi")
    smtpbasarisayfa1=mmmSayfa1("basarisayfa")
   'smtpbasarisayfa= seolarlink(smtpbasarisayfa1,"sayfa",lang)
smtphatasayfa=mmmSayfa1("hatasayfa")
smtpsmtpid=mmmSayfa1("smtpid")
    if smtpsmtpid="" or isNull(smtpsmtpid) then
    smtpsmtpid="0"
    end if
    ipblacklist=mmmSayfa1("ipblacklist")
    korumazaman=mmmSayfa1("korumazaman")
    if korumazaman="" then
    korumazaman="5"
    end if

    set mmmYardimci1 = Con.Execute ("select * from formsmtp where id="&smtpsmtpid&"")
		if mmmYardimci1.eof then
		else			
smtpserver=mmmYardimci1("smtpserver")
smtpport=mmmYardimci1("smtpport")
smtplogin=mmmYardimci1("login")
smtppassword=mmmYardimci1("password")
smtpssl=mmmYardimci1("ssls")
smtpauth=mmmYardimci1("smtpauth")
end if
close(mmmYardimci1)
    if sitealici=alici then
    from=smtplogin
    else
    if efrom="2" then
    from=smtplogin
    end if
    end if

    Set objMail = Server.CreateObject("CDO.Message")
	    Set objConf = Server.CreateObject("CDO.Configuration") 
	    Set objFields = objConf.Fields
	
            Sch = "http://schemas.microsoft.com/cdo/configuration/" 
	                With objFields
                        .Item(Sch & "sendusing")                       = 2
                        .Item(Sch & "smtpserver")                    = smtpserver
                        .Item(Sch & "smtpconnectiontimeout")                    = 10
                        .Item(Sch & "smtpserverport")                = smtpport
            if smtpauth="1" then
                .Item(Sch & "smtpauthenticate") = smtpauth
            if smtpssl="1" then
                .Item(Sch & "smtpusessl") = smtpssl
    end if
                .Item(Sch & "sendusername") = smtplogin
                .Item(Sch & "sendpassword")  = smtppassword
		    else
		    end if

		    .Update 
	    End With

	    With objMail
		    Set .Configuration = objConf
		    .bodyPart.Charset = "UTF-8"
		    .From = from
		    .To = alici
		    .Subject = baslik1
		    .HtmlBody = HTML
	    End With
    
        Err.Clear 
	    on error resume next

        objMail.Send

	if len(Err.Description) = 0 then
        emailgonderim = " The message was sent to " + alici
        emailgonderim = emailgonderim + " "
        IsSuccess = true
    else
		emailgonderim = " " + Err.Description + " ("&from&" > "&alici&") The mail sending test failed."
	end if
	'response.Write(emailgonderim)
Set iMsg=Nothing:Set iConf=Nothing:Set Flds=Nothing
    
end if
close(mmmSayfa1)
	end function

    function countrycek(qry1,qry2,qry3,qry4,qry5)
     countrycek="<option value=""""> "&qry2&" </option>"

set mmmYardimci = Con1.Execute ("SELECT * FROM "&dbmcountry&" where statu = '"&qry1&"' ORDER BY name") 
Do While Not mmmYardimci.eof 
countrycek=countrycek&"<option value="""&mmmYardimci("id")&""">"&mmmYardimci("name")&"</option>"
mmmYardimci.movenext
loop
close(mmmYardimci)
countrycek=countrycek
    end function

    function statecek(qry1,qry2,qry3,qry4,qry5)
     statecek="<option value=""""> "&qry2&" </option>"

set mmmYardimci = Con1.Execute ("SELECT * FROM "&dbmstate&" where country_id = '"&qry1&"' ORDER BY name") 
Do While Not mmmYardimci.eof 
statecek=statecek&"<option value="""&mmmYardimci("id")&""">"&mmmYardimci("name")&"</option>"
mmmYardimci.movenext
loop
close(mmmYardimci)
statecek=statecek
    end function

sub hatam
	if session("hatam")="" then
	else
	if session("hatam")="green" then
	csses="success"
	elseif session("hatam")="red" then
	csses="danger"
	elseif session("hatam")="blue" then
	csses="warning"
	else
	end if
	%>
<script type="text/javascript">
    setTimeout(function () { $('#mydiv').hide().fadeOut(1000); }, 5000); /*1000 milisaniye = 1 saniye*/
   </script>
<div id="mydiv" class="container" role="alert">
    <div class="d-flex sticky-top w-100 justify-content-center align-items-center" style="z-index:1041;">
    <div class="w-100 mb-1 text-center alert alert-<%=csses%>">
        <h4 class="alert-heading mb-0"><%=session("hata")%></h4>
    </div></div>
    <div class="modal-backdrop fade show"></div>
</div>
<%
session("hatam")=""
Response.Buffer = True
if session("hatamm")="2" then
    session("hatamm")="1"
	else

	session("hatamm")=session("hatamm")+1
	'if instr(Request.ServerVariables("HTTP_REFERER"),"&islem=")=0 then
	'referrer=Request.ServerVariables("HTTP_REFERER")
	'else
	'referrer=split(Request.ServerVariables("HTTP_REFERER"),"&islem=")(0)
	'end if
		'response.Write(referrer)
	'response.Redirect referrer

	
	end if
end if
    End Sub 

    sub islemmessagesession(tur,mesaj,url)

session("hata")=mesaj
session("hatam")=tur
    call hatam1
if url="1" then
Response.Redirect Request.ServerVariables("HTTP_REFERER")
else
Response.Redirect url
end if
end sub

        
function sitereviews(hdrturid,temp)
  if ayar2="ana" then
    csstip=""
    else
if ayar2="" then
			csstip=yaziid&""&ayar
			else
			csstip=ayar2&""&ayar2
			end if
    end if
    if temp="" or isNull(temp) then
    temp="0"
    end if
    sqlstring="select * from kategoriayar where id="&temp&" ORDER BY id"
			set mmmYardimci = Con.Execute (sqlstring)
if mmmYardimci.eof then
else
menuisimyazi1=mmmYardimci("i5")
cssurun=mmmYardimci("i8")
i1=mmmYardimci("i1")
i2=mmmYardimci("i2")
i3=mmmYardimci("i3")
bilgi1=mmmYardimci("bilgi1i")
i6=mmmYardimci("i6")
i5=menuisimyazi1
kakate1=mmmYardimci("kate1")
    if ayar3="resim" then
i5=mmmYardimci("r2")
i3=mmmYardimci("r6")
    end if
end if
				close(mmmYardimci)
if bilgi1="" then
bilgi1=15
else
bilgi1=bilgi1
end if

    if request("usayi")="" then
	KayitSayisi=bilgi1
	else
	KayitSayisi=request("usayi")
	end if
	git=giriskont(request("git"))
	if git="" or isnumeric(git)=false then
	git=""
	else
	git=git
	end if

if request.QueryString("aramagoster")="1" then
aramastr=giriskont(request("ara"))
else
aramastr=giriskont(request.Form("ara"))
end if

if aramastr="" or isNull(aramastr) then
aramastr="0"
else
aramastr=aramastr
end if

			i1=i1
			colmdstr=i6


    if recaptchvar="" then
    recaptchstr=""
               formekname="contact-form"
                     else
        recaptchstr="<div class=""form-row d-none""><div class=""form-group col""><div class=""g-recaptcha1"" data-sitekey="""&recaptcha3sitekey &"""><input type=""hidden"" name=""g-recaptcha-response"" class=""g-recaptcha-response"" value="""" /></div></div></div>"
               formekname="contact-form-recaptcha-v3"
end if 
    if hdrturid="" then
    sqlString = "select * from "&dbreviews&" where onay='1'"
    else
    sqlString = "select * from "&dbreviews&" where itemid='"& hdrturid&"' and onay='1'"
    end if
set mmmGenel=Contur.execute(sqlString)
set mmmYardimci =Con.execute("select count(id) as toplam from "&dbreviews&" where itemid='"& hdrturid&"'")
toplam5=mmmYardimci("toplam")
    
    if instr(i3,"#repeatlist#") then
sitereviews=(split(replace(replace(veriguncelle(i3),"``",""""),"`","'"),"#repeatlist#")(0))
    else
    sitereviews="<div id=""comments"" class=""post-block mt-5 post-comments""><h4 class=""mb-3"">"&esser("s","Yorumlar")&" ("&toplam5&")</h4><ul class=""comments"">"
    end if
			if mmmGenel.eof then
    sitereviews=sitereviews&"<li>"
													sitereviews=sitereviews&"<div class=""comment"">"
														sitereviews=sitereviews&"<div class=""img-thumbnail img-thumbnail-no-borders d-none d-sm-block"">"
															sitereviews=sitereviews&"<i class=""icon-bubble icons text-8 mt-2 ml-2""></i>"
														sitereviews=sitereviews&"</div>"
														sitereviews=sitereviews&"<div class=""comment-block"">"
															sitereviews=sitereviews&"<div class=""comment-arrow""></div>"

													sitereviews=sitereviews&"<p>"&esser("s","Yorum Yok")&"</p>"
													sitereviews=sitereviews&"</div>"
												sitereviews=sitereviews&"</li>"
    else
Do While Not mmmGenel.EOF

mmmid=mmmGenel("id")
strsubject=mmmGenel("subject")
strsubject1=strsubject
strsubject1=baslikkont(strsubject1)&"-"&mmmid
strmessage=mmmGenel("message")
strstared=mmmGenel("stared")
strtarih=mmmGenel("tarih")
    if isNull(strtarih) or strtarih="" then
    else
    strtarih=day(strtarih)&" "&month(strtarih)&" "&year(strtarih)
    end if
strpic=mmmGenel("pic")
    strpicl=imgyol&""&strpic
stritemid=replace(mmmGenel("itemid"),"tour-","")

     if instr(i3,"#repeatlist#") then
    else
											sitereviews=sitereviews&"<li>"
													sitereviews=sitereviews&"<div class=""comment"">"
														sitereviews=sitereviews&"<div class=""img-thumbnail img-thumbnail-no-borders d-none d-sm-block"">"
    if strpic="" or isNull(strpic) then
															sitereviews=sitereviews&"<i class=""icon-bubble icons text-8 mt-2 ml-2""></i>"
    else
    sitereviews=sitereviews&"<img class=""avatar"" alt="""&strsubject&""" src="""&strpicl&""">"
    end if
														sitereviews=sitereviews&"</div>"
														sitereviews=sitereviews&"<div class=""comment-block"">"
															sitereviews=sitereviews&"<div class=""comment-arrow""></div>"
															sitereviews=sitereviews&"<span class=""comment-by""><strong>"&strsubject&"</strong></span>"
															sitereviews=sitereviews&""&strmessage&""
    sitereviews=sitereviews&"<div class=""form-group rating-form"">"
													sitereviews=sitereviews&"<label for=""rating"">Your rating</label>"
    sitereviews=sitereviews&"<input type=""text"" class=""rating-invisible"" name=""rated"" value="""&strstared&""" title="""" data-plugin-star-rating data-plugin-options=""{'color': 'secondary', 'size':'xs'}""></div>"
															sitereviews=sitereviews&"<span class=""date float-right"">"&strtarih&"</span>"
														sitereviews=sitereviews&"</div>"
													sitereviews=sitereviews&"</div>"
												sitereviews=sitereviews&"</li>"
    end if
    Verii5=hdrcntrplc(i5,contentspath,cloudpath,versionjscss)


Verii5 = Replace(Verii5, ""&rsablonstr&"#csstip#"&rsablonstr&"", csstip)
Verii5 = Replace(Verii5, ""&rsablonstr&"#colmdstr#"&rsablonstr&"", colmdstr)
Verii5 = Replace(Verii5, ""&rsablonstr&"#strmodalid#"&rsablonstr&"", strsubject1)
Verii5 = Replace(Verii5, ""&rsablonstr&"#rewpic#"&rsablonstr&"", ""&strpicl&"")
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim1#"&rsablonstr&"", "("&resimim&")")
Verii5 = Replace(Verii5, ""&rsablonstr&"#rewtitle#"&rsablonstr&"", strsubject)
Verii5 = Replace(Verii5, ""&rsablonstr&"#rewmessage#"&rsablonstr&"", strmessage)
Verii5 = Replace(Verii5, ""&rsablonstr&"#rewdate#"&rsablonstr&"", strtarih)
Verii5 = Replace(Verii5, ""&rsablonstr&"#rewrate#"&rsablonstr&"", strstared)
Verii5 = Replace(Verii5, ""&rsablonstr&"#yaziid#"&rsablonstr&"", strlisteid)
Verii5 = Replace(Verii5, ""&rsablonstr&"#str_bilgi3#"&rsablonstr&"", str_fi)
Verii5 = Replace(Verii5, ""&rsablonstr&"#link#"&rsablonstr&"", link)
    
listelemegetir=Verii5
'yanliste=yanliste&"<div"&colmdstyle&">"

sitereviews=sitereviews&""&listelemegetir

	mmmGenel.MoveNext
  loop
    end if

     if instr(i3,"#repeatlist#") then
sitereviews=sitereviews&(split(replace(replace(replace(i3,"``",""""),"`","'"),"#kayitsayisi#",intSayfaSayisi),"#repeatlist#")(1))
    else
											sitereviews=sitereviews&"</ul></div>"
    

sitereviews=sitereviews&"<div class=""post-block mt-5 post-leave-comment"">"
											sitereviews=sitereviews&"<form method=""post"" action=""?sayfa=uyelik"" class="""&formekname&" p-4 rounded bg-color-grey"" name=""sitereviews"" id=""sitereviews"">"
        
            sitereviews=sitereviews&"<input type=""hidden"" value=""sitereviewsekle"" name=""islem"" />"
            sitereviews=sitereviews&"<input type=""hidden"" value=""99"" name=""formid"" />"
            sitereviews=sitereviews&"<input type=""hidden"" value="""& hdrturid&""" name=""reviewswonid"" />"
												sitereviews=sitereviews&"<h4 class=""review-title"">"&esser("s","Yorum Ekle")&"</h4>"

              sitereviews=sitereviews&"<div class=""contact-form-success alert alert-success d-none mt-4"" id=""contactSuccess"">"
    sitereviews=sitereviews&"<strong>"&esser("s","Başarılı!")&"</strong>  "&esser("s","Yorumunuz Gönderildi")&"</div>"
  sitereviews=sitereviews&"<div class=""contact-form-error alert alert-danger d-none mt-4"" id=""contactError"">"
    sitereviews=sitereviews&"<strong>"&esser("s","Error!")&"</strong>  "&esser("s","Yorum Gönderilirken Hata Oluştu.")&"<span class=""mail-error-message text-1 d-block"" id=""mailErrorMessage""></span></div>"
												sitereviews=sitereviews&"<div class=""form-group rating-form"">"
													sitereviews=sitereviews&"<label for=""rating"">"&esser("s","Puanlamanız")&"</label>"
    sitereviews=sitereviews&"<input type=""text"" class=""rating-invisible"" name=""rated"" value=""0"" title="""" data-plugin-star-rating data-plugin-options=""{'color': 'secondary', 'size':'xs'}"">"
												'	sitereviews=sitereviews&"<span class=""rating-stars"">"
												'		sitereviews=sitereviews&"<a class=""star-1"" href=""#"">1</a>"
												'		sitereviews=sitereviews&"<a class=""star-2"" href=""#"">2</a>"
												'		sitereviews=sitereviews&"<a class=""star-3"" href=""#"">3</a>"
												'		sitereviews=sitereviews&"<a class=""star-4"" href=""#"">4</a>"
												'		sitereviews=sitereviews&"<a class=""star-5"" href=""#"">5</a>"
												'	sitereviews=sitereviews&"</span>"

												'	sitereviews=sitereviews&"<select name=""rating"" id=""rating"" required="" style=""display: none;"">"
												'		sitereviews=sitereviews&"<option value="">Rate…</option>"
												'		sitereviews=sitereviews&"<option value=""5"">Perfect</option>"
												'		sitereviews=sitereviews&"<option value=""4"">Good</option>"
												'		sitereviews=sitereviews&"<option value=""3"">Average</option>"
												'		sitereviews=sitereviews&"<option value=""2"">Not that bad</option>"
												'		sitereviews=sitereviews&"<option value=""1"">Very poor</option>"
												'	sitereviews=sitereviews&"</select>"
												sitereviews=sitereviews&"</div>"

												sitereviews=sitereviews&"<div class=""form-group"">"
													sitereviews=sitereviews&"<label>"&esser("s","Yorumunuz")&"</label>"
													sitereviews=sitereviews&"<textarea cols=""5"" rows=""6"" name=""message"" class=""form-control form-control-sm"" required="""" data-msg-required="""&esser("s","Doldurulması Zorunlu Alan")&"""></textarea>"
												sitereviews=sitereviews&"</div><!-- End .form-group -->"


												sitereviews=sitereviews&"<div class=""row"">"
													sitereviews=sitereviews&"<div class=""col-md-6 col-xl-12"">"
														sitereviews=sitereviews&"<div class=""form-group"">"
															sitereviews=sitereviews&"<label>"&esser("s","Adınız")&"</label>"
															sitereviews=sitereviews&"<input type=""text"" class=""form-control form-control-sm"" name=""namesurname"" required="""" data-msg-required="""&esser("s","Doldurulması Zorunlu Alan")&""">"
														sitereviews=sitereviews&"</div><!-- End .form-group -->"
													sitereviews=sitereviews&"</div>"

													sitereviews=sitereviews&"<div class=""col-md-6 col-xl-12"">"
														sitereviews=sitereviews&"<div class=""form-group"">"
															sitereviews=sitereviews&"<label>"&esser("s","Email Adresiniz")&"</label>"
															sitereviews=sitereviews&"<input type=""text"" class=""form-control form-control-sm""  name=""email""required="""" data-msg-required="""&esser("s","Doldurulması Zorunlu Alan")&""">"
														sitereviews=sitereviews&"</div><!-- End .form-group -->"
													sitereviews=sitereviews&"</div>"
												sitereviews=sitereviews&"</div>"

												sitereviews=sitereviews&""&recaptchstr&"<input type=""submit"" class=""btn btn-dark ls-n-15"" value="""&esser("s","Kaydet")&""">"
											sitereviews=sitereviews&"</form>"
										sitereviews=sitereviews&"</div>"

        sitereviews=sitereviews&"<div class=""form-divider""></div>"
 end if

end function
	%> 