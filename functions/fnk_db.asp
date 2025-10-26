<!--#Include file="dbbilgi.asp"-->

<!--#Include file="md5.asp"-->

<%          



QUERYSTRING= Request.ServerVariables ("QUERY_STRING")



    if instr(aid,"?") then

    aid=split(aid,"?")(0)

    end if

        domaini=replace(replace(Request.ServerVariables("Server_Name"),".",""),"-","")

domainhttps=Request.ServerVariables("HTTPS")

if domainhttps="off" then

httpsonly=""

else

httpsonly=" Secure; HttpOnly"

end if

    

    autolang= request.ServerVariables("HTTP_ACCEPT_LANGUAGE")

    if instr(autolang,",") then

    autolang=split(autolang,",")(0)

    if instr(autolang,"-") then

    autolang=split(autolang,"-")(0)

    end if

    end if

    if vdil="1" then

    autolang="99999"

    end if

    if request.cookies("remember_dil")="" and aid="" then

    %>

<%

    if autolang="" then

    sqlstring="select id,ceviricode from diller1 where alt = '1' and nott = '1'"

    else

    sqlstring="select id,ceviricode from diller1 where alt = '1' and ceviricode = '"&autolang&"' and sira='1'"

    end if

    set mmmGenel = Con.Execute (sqlstring)

    if mmmGenel.eof then

    

    sqlstring="select id,ceviricode from diller1 where alt = '1' and nott = '1'"

    set mmmYardimci = Con.Execute (sqlstring)

    if mmmYardimci.eof then

        aktifdil=240

        ceviridilek="tr"

                response.cookies("remember_dil")=""

                response.cookies("remember_dil_code")=""

                response.cookies("remember_dil").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil")=aktifdil

                response.cookies("remember_ana_dil")=aktifdil

                response.cookies("remember_dil_code").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil_code")=ceviridilek

    Response.AddHeader "Set-Cookie", "remember_dil="&aktifdil&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

    Response.AddHeader "Set-Cookie", "remember_dil_code="&ceviridilek&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

    else

    aktifdil=mmmYardimci("id")

        ceviridilek=mmmYardimci("ceviricode")

            'if aktifdil=request.cookies("remember_dil") then

                response.cookies("remember_ana_dil")=aktifdil

            'else

                response.cookies("remember_dil")=""

                response.cookies("remember_dil_code")=""

                response.cookies("remember_dil").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil")=aktifdil

                response.cookies("remember_ana_dil")=aktifdil

                response.cookies("remember_dil_code").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil_code")=ceviridilek

    Response.AddHeader "Set-Cookie", "remember_dil="&aktifdil&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

    Response.AddHeader "Set-Cookie", "remember_dil_code="&ceviridilek&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&""

    end if

    close(mmmYardimci)



    else

        aktifdil=mmmGenel("id")

        ceviridilek=mmmGenel("ceviricode")

            'if aktifdil=request.cookies("remember_dil") then

                response.cookies("remember_ana_dil")=aktifdil

            'else

                response.cookies("remember_dil")=""

                response.cookies("remember_dil_code")=""

                response.cookies("remember_dil").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil")=aktifdil

                response.cookies("remember_ana_dil")=aktifdil

                response.cookies("remember_dil_code").Expires=dateAdd("n", 2, Now())

                response.cookies("remember_dil_code")=ceviridilek

    Response.AddHeader "Set-Cookie", "remember_dil="&aktifdil&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

    Response.AddHeader "Set-Cookie", "remember_dil_code="&ceviridilek&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

            'end if

    end if

    close(mmmGenel)

    %>

<%

else    

end if

   

    'if  request.cookies("remember_dil_code")="ar" then

    'dirtag="  dir=""rtl"""

    aid=server.HTMLEncode(aid)

    seolinkim=server.HTMLEncode(aid)

   'else

    'end if

   

    if aid="" and seolinkim="" then

    if request.cookies("remember_dil")="240" or request.cookies("remember_dil")="" then

        sqlstring="select * from seolar where seoid='835'"

    else

        sqlstring="select * from seolar where seoid in (select id from kategoriyazi where dil='"&request.cookies("remember_dil")&"' and bagli ='835')"

    end if

    else

        sqlstring="select * from seolar where seolink='"&aid&"'"

    end if

    set mmmYardimci1 = Con.Execute (sqlstring)

        if mmmYardimci1.eof then 

   'if seoektur="" or isNUll(seoektur) then

            sseoid="0"

            eskiseolinkk=aid



            sqlString = "select yenilink from seolink where eskilink = '"&aid&"' and (yenilink<>'' and yenilink<>'0')"    

                

            set mmmGenel = Con.Execute (sqlString)

            if mmmGenel.eof then  

    call eskiseolink(aid)

        else

            yeniseolink=mmmGenel("yenilink")

            if yeniseolink="" or isNull(yeniseolink) or yeniseolink="0" then

            else

            call RedirectPermanently(yeniseolink)   

            end if

            end if

            close(mmmGenel)







   ' else

    'end if

            'response.cookies("remember_dil")=request.cookies("remember_dil") and lang<>'"&request.cookies("remember_dil")&"'

       else

     sseoid=mmmYardimci1("seoid")

            slang=mmmYardimci1("lang")

            smidtitle=mmmYardimci1("seobaslik")

            smiddescri=mmmYardimci1("seoaciklama")

            smidpcss=hdrcntrplc(mmmYardimci1("seoanahtar"),contentspath,cloudpath,versionjscss)

            smidpjs=mmmYardimci1("seohtml")

            smiddescri=mmmYardimci1("seoaciklama")

            smidkeysi=mmmYardimci1("seotag")

            seotur=mmmYardimci1("seoturu")

            smidseoh1=mmmYardimci1("seoh1")

            smidseolink=mmmYardimci1("seolink")

            smidcanoncial=mmmYardimci1("canoncial")

            smidseolinkek=mmmYardimci1("seolinkek")

            smidhraflang=mmmYardimci1("hraflang")

            smidstructredstatu=mmmYardimci1("structredstatu")

            smidstructred=mmmYardimci1("structred")

            smidnoindex=mmmYardimci1("noindex")

    

            if slang<>request.cookies("remember_dil") and request("dil")<>"" then

            response.cookies("remember_dil")=slang

            end if

    

            if aid="" then

            else

                'response.cookies("remember_dil")=""

'response.cookies("remember_dil").Expires = Date() - 1

    Response.AddHeader "Set-Cookie", "remember_dil="&slang&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

                        response.cookies("remember_dil").Expires=dateAdd("n", 2, Now())

                        response.cookies("remember_dil")=slang

    

                set mmmGenel = Con.Execute ("select id,ceviricode from diller1 where id = '"&request.cookies("remember_dil")&"'")

                if mmmGenel.eof then



                else

                'response.cookies("remember_dil_code")=""

'response.cookies("remember_dil_code").Expires = Date() - 1

                    aktifdil=mmmGenel("id")

                    ceviridilek=mmmGenel("ceviricode")

    Response.AddHeader "Set-Cookie", "remember_dil_code="&ceviridilek&"; expires="&dateAdd("n", 2, Now())&"; path=/;"&httpsonly&"" 

                        response.cookies("remember_dil_code").Expires=dateAdd("n", 2, Now())

                            response.cookies("remember_dil_code")=ceviridilek

                end if

                close(mmmGenel)



            end if

        end if

       close(mmmYardimci1)

        

    if aid="" and seolinkim="" then

    aid1="835"

    else

    aid1=aid

    end if

    

ceviridilekaktif=request.cookies("remember_dil_code")

%>

<!--#Include file="../fnk.asp"-->

<!--#Include file="../uyelik/fnk_uyelik.asp"-->

<!--#Include file="fnk_db_ek.asp"-->



<%    

    if seotur="yazi" then

    if request.cookies("remember_dil")="240" then

    sqlstring="select kategori,urunid,id,yazib from yazilar where id = "&sseoid&""

    else

    sqlstring="select kategori,urunid,id,yazib from yazilar where id=(select bagli from yazilar where id='"&sseoid&"')"

    end if

            Set mmmYardimci3 = Con.Execute (sqlstring)

            if mmmYardimci3.eof then 

            else

                ektempid= mmmYardimci3("kategori")

                urunidtipi= mmmYardimci3("urunid") 

                yaziid= mmmYardimci3("id") 

        yaziisim1=mmmYardimci3("yazib") 

        heading_banner_yazi=dilyazib(yaziid,yaziisim1,lang)

        yazibreadcrbm=" / "& heading_banner_yazi

            end if

            close(mmmYardimci3)



    end if



if seotur="sayfa" or seotur="" or ektempid<>"" then



    'bu kodda seolink i ye göre anasayfa title desc bilgileri kapak ve ana resim bilgileri, ayrıca site ağacı oluşturma ve ayarlar alanları oluşturuluyor. 



          '  if seotur="" then

    'if aid="" then

    'aid="835"

    'end if

'ekagacseotur=" or id="&aid&""

    'end if

    'response.Write ektempid

    'response.End

    if ektempid<>"" then

sqlstring="select * from kategoriyazi where id="&ektempid&""&ekagacseotur&""

    else    

	if sseoid="" or isNull(sseoid) then

	sseoid="0"

	end if

sqlstring="select * from kategoriyazi where id="&sseoid&""&ekagacseotur&""

    end if



    set mmmGenel = Con.Execute (sqlstring)

if mmmGenel.eof then

'burda eskide 404 link bulma vardı'

else



        sid=mmmGenel("id")

        sayfaanasek=mmmGenel("anasek")

        sayfaisim1=mmmGenel("isim")

        heading_banner=dilkate(sid,sayfaisim1,lang)

        sayfa1=" / "& heading_banner

        sayfatitle=smidtitle

        sayfadesc=smiddescri

     

    if request.cookies("remember_dil")="240" or ektempid<>"" or sseoid="835" then

        sifreli= mmmGenel("sifreli")

        slider= mmmGenel("slider")

        okunma=mmmGenel("okusayi")

        sosyal1=mmmGenel("sosyal1")

        sosyal2=mmmGenel("sosyal2")

        fyorum=mmmGenel("facebookyorum")

        syorum=mmmGenel("yorum")

        sekle=mmmGenel("sitenekle")

        baslikd=mmmGenel("baslikd")

        rowtemp=mmmGenel("sayfatemp")

        strrowtempyeni=mmmGenel("sol")

        urunid=sid

        sayara=mmmGenel("sayara")

    if sayara="1" or sayara="" or sid=sayara then

        anaid=sid

        aid=sid

        id=sid

    else

            Set mmmYardimci3 = Con.Execute ("select * from kategoriyazi where id = "&sayara&"")

            if mmmYardimci3.eof then 

            else

                sifreli= mmmYardimci3("sifreli")

                slider= mmmYardimci3("slider")

                okunma=mmmYardimci3("okusayi")

                sosyal1=mmmYardimci3("sosyal1")

                sosyal2=mmmYardimci3("sosyal2")

                fyorum=mmmYardimci3("facebookyorum")

                syorum=mmmYardimci3("yorum")

                sekle=mmmYardimci3("sitenekle")

                baslikd=mmmYardimci3("baslikd")

                rowtemp=mmmYardimci3("sayfatemp")

                strrowtempyeni=mmmYardimci3("sol")



                sayara= mmmYardimci3("sayara")

                    'Sayfa Blok DÜzeni Aynı

                smodula= mmmYardimci3("smodula")

                    'Listelemede Listeli Açılma İlk Listeleme içeriği Çıksın

                smodula= mmmYardimci3("stura")

                    'Alt Sayfalarda Sayfa Formları aynı

            end if

            close(mmmYardimci3)

        anaid=sayara

        aid=sayara

        id=sid

    end if

    smodula=mmmGenel("smodula")



    stura=mmmGenel("stura")

    else

    ayarseoid=mmmGenel("bagli")

    end if

    ayarseoid1=ayarseoid

    if ayarseoid="" or isNull(ayarseoid) then

    ayarseoid=sid

    ayarseoid1=sid

    end if

    seolink1=smidseolink

    sitelink=siteadres&""&seolink1&""

    if modultitle="" or isNull(modultitle) then

    if sayfatitle="" or isNull(sayfatitle) then

    if heading_banner_yazi="" or isNull(heading_banner_yazi) then

    title=heading_banner

    modultitle=heading_banner

    else

    title=heading_banner_yazi&" - "& heading_banner

    modultitle=heading_banner_yazi&" - "& heading_banner

    heading_banner=heading_banner_yazi

    ayarseoid1=yaziid

    end if

    else

    title=sayfatitle

    modultitle=sayfatitle

    end if

    if sayfadesc="" or isNull(sayfadesc) then

    desc=heading_banner_yazi&" - "& heading_banner&" -"&desc

    else

    desc=sayfadesc

    end if

    keyword=keyword

    else

    modultitle=modultitle

    title=modultitle

    desc=moduldesc

    keyword=modulkey

    end if

    

    heading_resim=galeriresimcek("ilk",ayarseoid,"galeriresim")

    heading_image=galeriresimcek("kapak",ayarseoid1,"galeriresim")

    

    if heading_resimektemp<>"" then

    heading_resim=heading_resimektemp

    end if

    if heading_imageektemp<>"" then

    heading_image=heading_imageektemp

    end if

    if heading_bannerektemp<>"" then

    heading_banner=heading_bannerektemp

    end if

    if heading_descektemp<>"" then

    heading_desc=heading_descektemp

    end if

    if smidseoh1<>"" then

    heading_banner=smidseoh1

    end if

    

    'if instr(request.QueryString,"?") then
if smidcanoncial="" or smidcanoncial=""&siteadres&""&seolink1&"" then
smidcanoncial=""
else
    smidcanoncial="<link rel=""canonical"" href="""&smidcanoncial&""">"
end if

    if aid="" and seolinkim="" then

    heading_canonical="<link rel=""canonical"" href="""&siteadres&""">"&smidcanoncial

else

if seolinkim="" then
    heading_canonical="<link rel=""canonical"" href="""&siteadres&""">"
    else    
    heading_canonical="<link rel=""canonical"" href="""&siteadres&""&seolink1&""">"&smidcanoncial
    end if
    

	end if

        'end if



    if instr(heading_image,"notfound") or heading_image="" then

    pager=d2

    else

    pager=heading_image

    end if

    

sayfabreadcrbms= "<nav aria-label=""breadcrumb""><ol class=""breadcrumb""><li class=""breadcrumb-item"" aria-current=""page""><a href=""/"" title="""& esser("s","Anasayfa")&""">"&esser("s","Anasayfa")&"</a></li>"&kategoribreadcrumbs(sseoid,"#kylsub#","1","0")&""&yazibreadcrbm&"</ol></nav>"



end if

close(mmmGenel)

    

   'bu alan varsayılan dil harici dillerde sayfa düzenini almak için gerekli kodlar

        if request.cookies("remember_dil")="240" or ektempid<>"" or sseoid="835" then

    else

    if ayarseoid="" then

    ayarseoid="0"

    end if 

set mmmGenel = Con.Execute ("select * from kategoriyazi where id="&ayarseoid&"")

if mmmGenel.eof then

else

    sid=ayarseoid

     sifreli= mmmGenel("sifreli")

        slider= mmmGenel("slider")

        okunma=mmmGenel("okusayi")

        sosyal1=mmmGenel("sosyal1")

        sosyal2=mmmGenel("sosyal2")

        fyorum=mmmGenel("facebookyorum")

        syorum=mmmGenel("yorum")

        sekle=mmmGenel("sitenekle")

        baslikd=mmmGenel("baslikd")

        rowtemp=mmmGenel("sayfatemp")

        strrowtempyeni=mmmGenel("sol")

        urunid=sid

        sayara=mmmGenel("sayara")

    if sayara="1" or sayara="" or sid=sayara then

        anaid=sid

        aid=sid

        id=sid

    else

            Set mmmYardimci3 = Con.Execute ("select * from kategoriyazi where id = "&sayara&"")

            if mmmYardimci3.eof then 

            else

                sifreli= mmmYardimci3("sifreli")

                slider= mmmYardimci3("slider")

                okunma=mmmYardimci3("okusayi")

                sosyal1=mmmYardimci3("sosyal1")

                sosyal2=mmmYardimci3("sosyal2")

                fyorum=mmmYardimci3("facebookyorum")

                syorum=mmmYardimci3("yorum")

                sekle=mmmYardimci3("sitenekle")

                baslikd=mmmYardimci3("baslikd")

                rowtemp=mmmYardimci3("sayfatemp")

                strrowtempyeni=mmmYardimci3("sol")



                sayara= mmmYardimci3("sayara")

                    'Sayfa Blok DÜzeni Aynı

                smodula= mmmYardimci3("smodula")

                    'Listelemede Listeli Açılma İlk Listeleme içeriği Çıksın

                smodula= mmmYardimci3("stura")

                    'Alt Sayfalarda Sayfa Formları aynı

            end if

            close(mmmYardimci3)

        anaid=sayara

        aid=sayara

        id=sid

    end if

    smodula=mmmGenel("smodula")



    stura=mmmGenel("stura")

end if

close(mmmGenel)

end if



end if

%>