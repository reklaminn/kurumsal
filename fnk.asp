<!--#Include file="functions/function.asp"-->
<!--#Include file="functions/moduller.asp"-->
<%    
    function ucbirurlc(url,servername)
    str=url
    str=replace(str,"404;","")
    str=replace(str,":443","")
    str=replace(str,servername,"")
    str=replace(str,"https://","")
    str=replace(str,"http://","")
    str=replace(str,"/404"&seosonu&"?brokenlink=","")
    ucbirurlc=str
    end function

    sub RedirectPermanently(yenilink)
    Response.Status="301 Moved Permanently"
    Response.AddHeader "Location",yenilink
    Response.End    
    end sub

function menuolustur(deger1,menuid,mobilbuton)

if menuid="" or menuid="0" then
			csstip=""
			else
			csstip=menuid&""&menuid
			end if
if deger1="1" then
menuolustur="<button class=""btn header-btn-collapse-nav ml-0 ml-sm-3 anamenumobil"" data-toggle=""collapse"" data-target="".header-nav-main nav"&csstip&"""><i class=""fas fa-bars""></i></button>"
else
    end if

menuolustur=menuolustur&"<nav class=""collapse"">"
  menuolustur=menuolustur&"<ul class=""nav nav-pills"" id=""mainNav"&csstip&""">"
  sqlstring="select * from menuler where anasek='"&menuid&"' and durum = '1' ORDER BY sira "
set mmmGenel = Con.Execute (sqlstring)
Do While Not mmmGenel.EOF
e=e+1
menuisim=menuisimcek(mmmGenel("id"),"isim")
menuisim1=menuisimcek(mmmGenel("id"),"seolink")
if mmmGenel("sira1")="d" then
menuul="<ul class=""dropdown-menu"">"&menuisimcek(mmmGenel("id"),"liste")&"</ul>"
    else
    menuul=""
    end if
set mmmYardimci = Con.Execute ("select * from menuler where anasek='"&mmmGenel("id")&"' and durum = '1' ORDER BY sira ")
    if instr(menuisim1,"http") then
		link=""""&menuisim1&""""
    else
		link="""/"&menuisim1&""""
    end if

if menuisimcek(mmmGenel("id"),"id")=cint(aid) then 
styli=" active"
else
styli=""
end if
menuolustur=menuolustur&"<li class=""nav-item "&styli&"""><a href="&link&" class=""nav-link"""&linkkapat&">"&menuisim&"</a>"&menuul&""
if mmmYardimci.eof then
else

      menuolustur=menuolustur&"<ul class=""dropdown-menu"">"
Do While Not mmmYardimci.EOF
menuisimalt=menuisimcek(mmmYardimci("id"),"isim")
menuisimalt1=menuisimcek(mmmYardimci("id"),"seolink")
if mmmYardimci("sira1")="d" then
menuul="<ul class=""dropdown-menu"">"&menuisimcek(mmmYardimci("id"),"liste")&"</ul>"
    else
    menuul=""
    end if
set mmmYardimci1 = Con.Execute ("select * from menuler where anasek='"&mmmYardimci("id")&"' and durum = '1' ORDER BY sira ")

link="""/"&menuisimalt1&""""&linkkapat&""

menuolustur=menuolustur&"<li class=""dropdown""><a class=""dropdown-toggle"" href="&link&""&linkkapat&">"&menuisimalt&"</a>"&menuul&""
if mmmYardimci1.eof then
else
menuolustur=menuolustur&"<ul class=""dropdown-menu"">"

Do While Not mmmYardimci1.EOF
menuisimalt=menuisimcek(mmmYardimci1("id"),"isim")
menuisimalt1=menuisimcek(mmmYardimci1("id"),"seolink")

link="""/"&menuisimalt1&""""&linkkapat&""

menuolustur=menuolustur&"<li class=""dropdown""><a href="&link&">"&menuisimalt&"</a>"
 
            menuolustur=menuolustur&"</li>"
       
mmmYardimci1.movenext
loop
menuolustur=menuolustur&"</ul>"
         end if
		  close(mmmYardimci1)
       menuolustur=menuolustur&" </li>"
 
mmmYardimci.movenext
loop
menuolustur=menuolustur&" </ul>"
      end if
	  close(mmmYardimci)
	  menuolustur=menuolustur&"</li>"

mmmGenel.movenext
loop
close(mmmGenel)
menuolustur=menuolustur&"</ul>"
menuolustur=menuolustur&"</nav>"


end function
    
function menucreate(deger1,menuid,mobilbuton,menutipi,ustseviye)
if menuid="" or menuid="0" then
			csstip=""
			else
			csstip=menuid&""&menuid
			end if
if menutipi="" or menutipi="0" then
			menutipistr=" and id="&menuid&""
			else
			menutipistr=" and sifreli='"&menutipi&"'"
			end if
if deger1="1" then
menucreate="<button class=""btn header-btn-collapse-nav ml-0 ml-sm-3 anamenumobil"" data-toggle=""collapse"" data-target="".header-nav-main nav"&csstip&"""><i class=""fas fa-bars""></i></button>"
else
    end if
    if instr(mobilbuton,"#menulist#") or instr(mobilbuton,"#menulist1#") or instr(mobilbuton,"#menulist2#") or instr(mobilbuton,"#menulistek{") then
    if instr(mobilbuton,"#menulist1#") then
    menucreate=menucreate&""&split(mobilbuton,"#menulist1#")(0)
    elseif instr(mobilbuton,"#menulist2#") then
    menucreate=menucreate&""&split(mobilbuton,"#menulist2#")(0)
    elseif instr(mobilbuton,"#menulistek{") then
    menucreate=menucreate&""&split(mobilbuton,"#menulistek{")(0)
    else
    menucreate=menucreate&""&split(mobilbuton,"#menulist#")(0)
    end if
    else
menucreate=menucreate&"<nav class=""collapse"">"
  menucreate=menucreate&"<ul class=""nav nav-pills"" id=""mainNav"&csstip&""">"
    end if
    
    if instr(mobilbuton,"#menulist2#") then
    ulclass=""
    liclass=""
    elseif instr(mobilbuton,"#menulistek{") then
    ekmenustr=split(split(mobilbuton,"#menulistek{")(1),"}#")(0)

    if ubound(split(ekmenustr,"*"))="6" then
    lionehasclass=" "&split(ekmenustr,"*")(0)&" "
    lioneclass=" "&split(ekmenustr,"*")(6)&" "
    lioneaktifclass=" "&split(ekmenustr,"*")(1)&" "
    liaoneclass=" "&split(ekmenustr,"*")(2)&""
    ultwoclass=" class="""&split(ekmenustr,"*")(3)&""""
    ullitwoclass=" "&split(ekmenustr,"*")(4)&" "
    ulliatwoclass=" "&split(ekmenustr,"*")(5)&" "
    else
    ulclass=""
    liclass=""
    menusubclass1=""
    menusubclass2=""
    end if

    'menucreate=menucreate&lioneclass
    else
    ulclass="dropdown"
    liclass=" class=""dropdown-menu"""
    end if
    
    if menuid="urunustmenu" then
    menucreate=menucreate&""&urunustmenu(mobilbuton,deger2)
    elseif menuid="ust" or menuid="yan" then
    
    if instr(mobilbuton,"#menulist1#") then
    menusubclass1=" class=""dropdown-submenu"
    menusubclass2=" dropdown-item dropdown-toggle"
    elseif instr(mobilbuton,"#menulist2#") then
    menusubclass1=""
    menusubclass2=""
    elseif instr(mobilbuton,"#menulistek{") then
    else
    menusubclass1a=""
    menusubclass2a=""
    end if
    if menuid="ust" then
    mgstr=" and menugosterim = '1'"
    else
    mgstr=""
    if ustseviye="" or ustseviye="0" then
    ustseviye=aid
    end if
    end if
    if ustseviye="0" or ustseviye="" then
  sqlstring="select * from kategoriyazi where alt = '1' and durum = '1'"&mgstr&" and modulmu='0' ORDER BY sira "
    else
  sqlstring="select * from kategoriyazi where anasek = '"&ustseviye&"' and durum = '1'"&mgstr&" and modulmu='0' ORDER BY sira "
    end if
set mmmGenel = Con.Execute (sqlstring)
    ' menucreate=menucreate&aid
Do While Not mmmGenel.EOF
e=e+1
    mmmGid=mmmGenel("id")
    mmmGid1=mmmGid
    mmmGisim=mmmGenel("isim")
    menuisim=dilkate(mmmGid1,mmmGisim,lang)
    menuisim1=seolarlink(mmmGid1,"sayfa",lang)
    mmmGlink=mmmGenel("link")
    mmmGtarget=mmmGenel("target")
        if mmmGlink = "" or mmmGlink = "0" or isNull(mmmGlink) Then
	    link=""""&siteadres&""&menuisim1&""""&linkkapat&""
	    else
	    link=""""&mmmGlink&""" target="""&mmmGtarget&""""
	    end if
        if mmmGid=cint(aid) then 
    if instr(mobilbuton,"#menulistek{") then
        styli=" "&lioneaktifclass&""""
    else
        styli=" active"""
    end if
        else
        styli=""""
        end if
    
   ' response.Write ("select * from kategoriyazi where anasek='"&mmmGid&"' and durum = '1' and menugosterim = '1' ORDER BY sira ")
set mmmYardimci = Con.Execute ("select * from kategoriyazi where anasek='"&mmmGid&"' and durum = '1' and menugosterim = '1' ORDER BY sira ")
if mmmYardimci.eof then
            set mmmYardimci2 = Con.Execute ("select * from yazilar where kategori='"&mmmGid&"' and durum = '1' and ilksayfa='1' and urunid<>'1' ORDER BY id ")
            if mmmYardimci2.eof then
    if instr(mobilbuton,"#menulistek{") then
                menucreate=menucreate&"<li class="""&lioneclass&""&styli&"><a href="&link&" class="""&liaoneclass&""""&linkkapat&">"&menuisim&"</a>"
    else
                menucreate=menucreate&"<li class="""&styli&"><a href="&link&" class=""nav-link"""&linkkapat&">"&menuisim&"</a>"
    end if
            else
    if instr(mobilbuton,"#menulistek{") then
    
           menucreate=menucreate&"<li class="""&lionehasclass&""&lioneclass&""&styli&"><a href="&link&" class="""&liaoneclass&""""&linkkapat&">"&menuisim&"</a>"

           ' menucreate=menucreate&" <ul class="""&ultwoclass&""">"
    else
        menucreate=menucreate&"<li class="""&ulclass&""&styli&"><a href="&link&" class=""dropdown-item nav-link"""&linkkapat&">"&menuisim&"</a>"
       ' menucreate=menucreate&"<li class="""&ulclass&""&styli&"><a href="&link&" class=""dropdown-item nav-link dropdown-toggle"""&linkkapat&">"&menuisim&"</a>"

           ' menucreate=menucreate&" <ul"&liclass&">"
    end if
    
    if esergor="1" then
            Do While Not mmmYardimci2.EOF
                mmmY2id=mmmYardimci2("id")
                mmmY2isim=mmmYardimci2("yazib")
                menuisimyazi=dilyazib(mmmY2id,mmmY2isim,lang)
                menuisimyazi1=seolarlink(mmmY2id,"yazi",lang)
                mmmY2link=mmmYardimci2("link")
                mmmY2target=mmmYardimci2("target")
                    if mmmY2link = "" or mmmY2link = "0" or isNull(mmmY2link) Then
	                link=""""&siteadres&""&menuisimyazi1&""""&linkkapat&""
	                else
	                link=""""&mmmY2link&""" target="""&mmmY2target&""""
	                end if
    
    if instr(mobilbuton,"#menulistek{") then
            menucreate=menucreate&"<li class="""&ullitwoclass&""&styli&"><a class="""&ulliatwoclass&""" href="&link&" >"&menuisimyazi&"</a></li>"
    else
            menucreate=menucreate&"<li><a class=""nav-link"" href="&link&" >"&menuisimyazi&"</a></li>"
    end if

            mmmYardimci2.movenext
            loop
            menucreate=menucreate&" </ul>"
    end if
                         end if
			              close(mmmYardimci2)
else
    if instr(mobilbuton,"#menulistek{") then
    menucreate=menucreate&"<li class="""&lionehasclass&""&lioneclass&""&styli&"><a href="&link&" class="""&liaoneclass&""""&linkkapat&">"&menuisim&"</a>"
      menucreate=menucreate&"<ul"&ultwoclass&">"
    else
    menucreate=menucreate&"<li class="""&ulclass&""&styli&"><a href="&link&" class=""dropdown-item nav-link dropdown-toggle"""&linkkapat&">"&menuisim&"</a>"
      menucreate=menucreate&"<ul"&liclass&">"
    end if
Do While Not mmmYardimci.EOF    
    mmmYid=mmmYardimci("id")
    mmmYisim=mmmYardimci("isim")
    menuisimalt=dilkate(mmmYid,mmmYisim,lang)
    menuisimalt1=seolarlink(mmmYid,"sayfa",lang)
    mmmYlink=mmmYardimci("link")
    mmmYtarget=mmmYardimci("target")
        if mmmYlink = "" or mmmYlink = "0" or isNull(mmmYlink) Then
	    link=""""&siteadres&""&menuisimalt1&""""&linkkapat&""
	    else
	    link=""""&mmmYlink&""" target="""&mmmYtarget&""""
	    end if

set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where anasek='"&mmmYid&"' and durum = '1' and menugosterim = '1' ORDER BY sira ")
    
if mmmYardimci1.eof then
    
            set mmmYardimci2 = Con.Execute ("select * from yazilar where kategori='"&mmmYid&"' and durum = '1' and ilksayfa='1' and urunid<>'1' ORDER BY id ")
            if mmmYardimci2.eof then
    
    if instr(mobilbuton,"#menulistek{") then
                menucreate=menucreate&"<li class="""&ullitwoclass&""&styli&"><a href="&link&" class="""&ulliatwoclass&""""&linkkapat&">"&menuisimalt&"</a>"
    else
                menucreate=menucreate&"<li class="""&styli&"><a href="&link&" class=""nav-link"""&linkkapat&">"&menuisimalt&"</a>"
    end if
            else
    if instr(mobilbuton,"#menulistek{") then
    
           menucreate=menucreate&"<li class="""&lioneclass&""&styli&"><a href="&link&" class="""&liaoneclass&""""&linkkapat&">"&menuisimalt&"</a>"

            menucreate=menucreate&" <ul class="""&ultwoclass&""">"

    else
                menucreate=menucreate&"<li "&menusubclass1&""&styli&"><a href="&link&" class=""dropdown-item nav-link dropdown-toggle"""&linkkapat&">"&menuisimalt&"</a>"

            menucreate=menucreate&" <ul"&liclass&">"
    end if

            Do While Not mmmYardimci2.EOF
                mmmY2id=mmmYardimci2("id")
                mmmY2isim=mmmYardimci2("yazib")
                menuisimyazi=dilyazib(mmmY2id,mmmY2isim,lang)
                menuisimyazi1=seolarlink(mmmY2id,"yazi",lang)
                mmmY2link=mmmYardimci2("link")
                mmmY2target=mmmYardimci2("target")
                    if mmmY2link = "" or mmmY2link = "0" or isNull(mmmY2link) Then
	                link=""""&siteadres&""&menuisimyazi1&""""&linkkapat&""
	                else
	                link=""""&mmmY2link&""" target="""&mmmY2target&""""
	                end if

            menucreate=menucreate&"<li><a class=""nav-link"" href="&link&" >"&menuisimyazi&"</a></li>"

            mmmYardimci2.movenext
            loop
            menucreate=menucreate&" </ul>"
                         end if
			              close(mmmYardimci2)

else
    menucreate=menucreate&"<li "&menusubclass1&""&styli&"><a class=""nav-link"&menusubclass2&""" href="&link&""&linkkapat&">"&menuisimalt&"</a>"
menucreate=menucreate&"<ul"&liclass&">"

Do While Not mmmYardimci1.EOF 
    mmmY1id=mmmYardimci1("id")
    mmmY1isim=mmmYardimci1("isim")
    menuisimalt=dilkate(mmmY1id,mmmYardimci1("isim"),lang)
    menuisimalt1=seolarlink(mmmY1id,"sayfa",lang)
    mmmY1link=mmmYardimci1("link")
    mmmY1target=mmmYardimci1("target")
        if mmmY1link = "" or mmmY1link = "0" or isNull(mmmY1link) Then
	    link=""""&siteadres&""&menuisimalt1&""""&linkkapat&""
	    else
	    link=""""&mmmY1link&""" target="""&mmmY1target&""""
	    end if

                    set mmmYardimci2 = Con.Execute ("select * from yazilar where kategori='"&mmmY1id&"' and durum = '1' and ilksayfa='1' and urunid<>'1' ORDER BY id ")
                    if mmmYardimci2.eof then
                        menucreate=menucreate&"<li class="""&styli&"><a href="&link&" class=""nav-link"""&linkkapat&">"&menuisimalt&"</a>"
                    else
                        menucreate=menucreate&"<li "&menusubclass1&""&styli&"><a href="&link&" class=""dropdown-item nav-link dropdown-toggle"""&linkkapat&">"&menuisimalt&"</a>"

                    menucreate=menucreate&" <ul"&liclass&">"

                    Do While Not mmmYardimci2.EOF
                        mmmY2id=mmmYardimci2("id")
                        mmmY2isim=mmmYardimci2("yazib")
                        mmmY2isim1=mmmY2isim
                        menuisimyazi=dilyazib(mmmY2id,mmmY2isim1,lang)
                        menuisimyazi1=seolarlink(mmmY2id,"yazi",lang)
                        mmmY2link=mmmYardimci2("link")
                        mmmY2target=mmmYardimci2("target")
                            if mmmY2link = "" or mmmY2link = "0" or isNull(mmmY2link) Then
	                        link=""""&siteadres&""&menuisimyazi1&""""&linkkapat&""
	                        else
	                        link=""""&mmmY2link&""" target="""&mmmY2target&""""
	                        end if

                    menucreate=menucreate&"<li><a class=""nav-link"" href="&link&" >"&menuisimyazi&"</a></li>"

                    mmmYardimci2.movenext
                    loop
                    menucreate=menucreate&" </ul>"
                                 end if
			                      close(mmmYardimci2)
            menucreate=menucreate&"</li>"
       
mmmYardimci1.movenext
loop
menucreate=menucreate&"</ul>"
         end if
		  close(mmmYardimci1)
       menucreate=menucreate&" </li>"
 
mmmYardimci.movenext
loop
menucreate=menucreate&" </ul>"
      end if
	  close(mmmYardimci)
	  menucreate=menucreate&"</li>"

mmmGenel.movenext
loop
close(mmmGenel)

    else 

    sqlstring="select id, menujson, menugosterim from menuler where durum = '1'"&menutipistr&" "
    set mmmGenel = Con.Execute (sqlstring)
    if mmmGenel.EOF then
        else
    e=e+1
        
            kateid=mmmGenel("id")
            menujson=mmmGenel("menujson")
        if menujson="" or isNull(menujson) then
        menujson="[[ ]]"
        end if
        
        Set oJSONmenu = New aspJSON
        oJSONmenu.loadJSON(menujson)
            if instr(menujson,"[")then
        set rowsm = oJSONmenu.data(0)
                for each rowiim in rowsm
    
                strid=rowsm(rowiim)("id")
                menubagliana=rowsm(rowiim)("bagli")  
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=rowsm(rowiim)("seolink")
                menuisimana1=rowsm(rowiim)("name")
                strtoplu=rowsm(rowiim)("turu")
                stronay=rowsm(rowiim)("onay")
    
    
        if isObject(rowsm(rowiim)("children")) then
    
    
    'if menubaglianaid=cint(aid) then 
    if menuseolinkana1=aid1 then 
         if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
    
    
        set colsm = rowsm(rowiim)("children")(0)
        menusubclass1=""
        menusubclass2=""
    
       'menucreate=menucreate&colsm.count
    
        if colsm.count>=1 Then
    
        if instr(mobilbuton,"#menulist2#") then
        ulclass=""
        liclass=""
        elseif instr(mobilbuton,"#menulistek{") then
        ekmenustr=split(split(mobilbuton,"#menulistek{")(1),"}#")(0)
        if ubound(split(ekmenustr,"*"))>="6" then
        lionehasclass=" "&split(ekmenustr,"*")(0)&" "
        lioneclass=" "&split(ekmenustr,"*")(6)&" "
        lioneaktifclass=" "&split(ekmenustr,"*")(1)&" "
        liaoneclass=" "&split(ekmenustr,"*")(2)&""
        ultwoclass=" class="""&split(ekmenustr,"*")(3)&""""
        ullitwoclass=" "&split(ekmenustr,"*")(4)&" "
        ulliatwoclass=" "&split(ekmenustr,"*")(5)&" "
        if ubound(split(ekmenustr,"*"))>"6" then
        liaonehasclass=" "&split(ekmenustr,"*")(7)&" "
        end if
        else
        ulclass=""
        liclass=""
        menusubclass1=""
        menusubclass2=""
        end if
        
        'menucreate=menucreate&lioneclass
        else
        ulclass="dropdown"
        liclass=" class=""dropdown-menu"""
        end if
        
        if instr(mobilbuton,"#menulist1#") then
        menusubclass1=" class=""dropdown"""
        menusubclass2="dropdown-item nav-link dropdown-toggle"
        elseif instr(mobilbuton,"#menulist2#") then
        menusubclass1=""
        menusubclass2=""
        else
        menusubclass1=lioneclass
        menusubclass2=liaoneclass
        end if
    
        end if 
        
        if colsm.count>=1 then
        lionehasclass=lionehasclass
        liaonehasclass=liaonehasclass
        else
        lionehasclass=""
        liaonehasclass=""
        end if
    menucreate=menucreate&"<li class="""&lioneclass&""&lionehasclass&"""><a href="""&siteadres&""&menuseolinkana1&""" class="""&liaonehasclass&""&liaoneclass&""&styli&""""&linkkapat&">"&menuisimana1&"</a>"
        if colsm.count>=1 then
        'class=""dropdown-menu""
        
        if instr(mobilbuton,"#menulist1#") then 
        menucreate=menucreate&"<ul class=""dropdown-menu"">"
        elseif instr(mobilbuton,"#menulist2#") then
        menucreate=menucreate&"<ul>"
        else
        menucreate=menucreate&"<ul"&ultwoclass&">"
        end if
        end if
                for each coliim in colsm
        if colsm.count>=1 then
                                                    strid=colsm(coliim)("id")
                menubagliana=colsm(coliim)("bagli")
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=colsm(coliim)("seolink")
                menuisimana1=colsm(coliim)("name")
                strtoplu=colsm(coliim)("turu")
                stronay=colsm(coliim)("onay")
         
    'if menubaglianaid=cint(aid) then 
    if menuseolinkana1=aid1 then 
    'styli=" active current-page-active"
     if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
        
        set colssubm = colsm(coliim)("children")(0)
        menusubclass1a=""
        menusubclass2a=""
        if colssubm.count>=1 then
        if instr(mobilbuton,"#menulist1#") then
        menusubclass1a=" class=""dropdown-submenu"""
        menusubclass2a=" dropdown-item"
        elseif instr(mobilbuton,"#menulist2#") then
        menusubclass1=""
        menusubclass2=""
        else
        menusubclass1a=ullitwoclass
        menusubclass2a=ulliatwoclass
        end if
        end if
        
        if colssubm.count>=1 then
        lionehasclass=lionehasclass
        liaonehasclass=liaonehasclass
        else
        lionehasclass=""
        liaonehasclass=""
        end if
        menucreate=menucreate&"<li class="""&ullitwoclass&""&lionehasclass&"""><a href="""&siteadres&""&menuseolinkana1&""" class="""&ulliatwoclass&""&styli&""""&linkkapat&">"&menuisimana1&"</a>"
        if colssubm.count>=1 then
        if instr(mobilbuton,"#menulist1#") then
        menucreate=menucreate&"<ul class=""dropdown-menu"">"
        elseif instr(mobilbuton,"#menulist2#") then
        menucreate=menucreate&"<ul>"
        else
        menucreate=menucreate&"<ul"&ultwoclass&">"
        end if
        end if
                for each coliisubm in colssubm
        if colssubm.count>=1 then
                                                    strid=colssubm(coliisubm)("id")
                menubagliana=colssubm(coliisubm)("bagli")
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=colssubm(coliisubm)("seolink")
                menuisimana1=colssubm(coliisubm)("name")
                strtoplu=colssubm(coliisubm)("turu")
                stronay=colssubm(coliisubm)("onay")
         
    'if menubaglianaid=cint(aid) then 
    if menuseolinkana1=aid1 then 
    'styli=" active current-page-active"
     if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
        menucreate=menucreate&"<li><a href="""&siteadres&""&menuseolinkana1&""" class="""&styli&""""&linkkapat&">"&menuisimana1&"</a></li>"
        end if
                                        next
        if colssubm.count>=1 then
        menucreate=menucreate&"</ul>"
        end if
        menucreate=menucreate&"</li>"
        end if
                                        next
        if colsm.count>=1 then
        menucreate=menucreate&"</ul>"
        end if
        menucreate=menucreate&"</li>"
        end if
    
    
        next
        end if
        
        end if
           close(mmmGenel)
        
        end if
        if instr(mobilbuton,"#menulist#") or instr(mobilbuton,"#menulist1#") or instr(mobilbuton,"#menulistek{") then
        if instr(mobilbuton,"#menulist1#") then
        menucreate=menucreate&""&split(mobilbuton,"#menulist1#")(1)    
        elseif instr(mobilbuton,"#menulistek{") then
        menucreate=menucreate&""&split(mobilbuton,"}#")(1)    
        else
        menucreate=menucreate&""&split(mobilbuton,"#menulist#")(1)
        end if
        else
    menucreate=menucreate&"</ul>"
    menucreate=menucreate&"</nav>"
        end if
end function




 
function menucreate25(deger1,menuid,mobilbuton,menutipi,ustseviye)
if menuid="" or menuid="0" then
			csstip=""
			else
			csstip=menuid&""&menuid
			end if
if menutipi="" or menutipi="0" then
			menutipistr=" and id="&menuid&""
			else
			menutipistr=" and sifreli='"&menutipi&"'"
			end if
if deger1="1" then
menucreate25="<button class=""btn header-btn-collapse-nav ml-0 ml-sm-3 anamenumobil"" data-toggle=""collapse"" data-target="".header-nav-main nav"&csstip&"""><i class=""fas fa-bars""></i></button>"
else
    end if
    if instr(mobilbuton,"#menulist#") or instr(mobilbuton,"#menulist1#") or instr(mobilbuton,"#menulist2#") or instr(mobilbuton,"#menulistek{") then
    if instr(mobilbuton,"#menulist1#") then
    menucreate25=menucreate25&""&split(mobilbuton,"#menulist1#")(0)
    elseif instr(mobilbuton,"#menulist2#") then
    menucreate25=menucreate25&""&split(mobilbuton,"#menulist2#")(0)
    elseif instr(mobilbuton,"#menulistek{") then
    menucreate25=menucreate25&""&split(mobilbuton,"#menulistek{")(0)
    else
    menucreate25=menucreate25&""&split(mobilbuton,"#menulist#")(0)
    end if
    else
menucreate25=menucreate25&"<nav class=""collapse"">"
  menucreate25=menucreate25&"<ul class=""nav nav-pills"" id=""mainNav"&csstip&""">"
    end if
    
    if instr(mobilbuton,"#menulist2#") then
    ulclass=""
    liclass=""
    elseif instr(mobilbuton,"#menulistek{") then
    ekmenustr=split(split(mobilbuton,"#menulistek{")(1),"}#")(0)

    if ubound(split(ekmenustr,"*"))="6" then
    lionehasclass=" "&split(ekmenustr,"*")(0)&" "
    lioneclass=" "&split(ekmenustr,"*")(6)&" "
    lioneaktifclass=" "&split(ekmenustr,"*")(1)&" "
    liaoneclass=" "&split(ekmenustr,"*")(2)&""
    ultwoclass=" class="""&split(ekmenustr,"*")(3)&""""
    ullitwoclass=" "&split(ekmenustr,"*")(4)&" "
    ulliatwoclass=" "&split(ekmenustr,"*")(5)&" "
    else
    ulclass=""
    liclass=""
    menusubclass1=""
    menusubclass2=""
    end if

    'menucreate25=menucreate25&lioneclass
    else
    ulclass="dropdown"
    liclass=" class=""dropdown-menu"""
    end if
    
    sqlstring="select id, menujson, menugosterim from menuler where durum = '1'"&menutipistr&" "
    set mmmGenel = Con.Execute (sqlstring)
    if mmmGenel.EOF then
        else
    e=e+1
        
            kateid=mmmGenel("id")
            menujson=mmmGenel("menujson")
        if menujson="" or isNull(menujson) then
        menujson="[[ ]]"
        end if
        Set oJSONmenu = New aspJSON
        oJSONmenu.loadJSON(menujson)

        'response.write menujson

            if instr(menujson,"[")then
        set rowsm = oJSONmenu.data("children")
                for each rowiim in rowsm
 

                strid=rowsm(rowiim)("id")
                menubagliana=rowsm(rowiim)("bagli")  
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=rowsm(rowiim)("seolink")
                if instr(menuseolinkana1,"http") then
                menuseolinkana1=menuseolinkana1
                else
                menuseolinkana1="/"&menuseolinkana1
                end if

                menuisimana1=rowsm(rowiim)("name")
                strtoplu=rowsm(rowiim)("turu")
                stronay=rowsm(rowiim)("onay")
    
    
        if isObject(rowsm(rowiim)("children")) then
    
    
    'if menubaglianaid=cint(aid) then 
    if menuseolinkana1=aid1 then 
         if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
    
    
        set colsm = rowsm(rowiim)("children")
        menusubclass1=""
        menusubclass2=""
    
       'menucreate25=menucreate25&colsm.count
    
        ekmenustr=split(split(mobilbuton,"#menulistek{")(1),"}#")(0)
            
        if ubound(split(split(split(mobilbuton,"#menulistek{")(1),"}#")(0),"*"))>12 then
        lioneaktifclass=" "&split(ekmenustr,"*")(0)&" "
        liaoneaktifclass=" "&split(ekmenustr,"*")(1)&" "

        lionehasclass=" "&split(ekmenustr,"*")(2)&" "
        liaonehasclass=" "&split(ekmenustr,"*")(3)&" "

        lioneclass=" "&split(ekmenustr,"*")(4)&" "
        liaoneclass=" "&split(ekmenustr,"*")(5)&""

        ultwoclass=" class="""&split(ekmenustr,"*")(6)&""""

        ullihastwoclass=" "&split(ekmenustr,"*")(7)&" "
        ulliahastwoclass=" "&split(ekmenustr,"*")(8)&" "

        ullitwoclass=" "&split(ekmenustr,"*")(9)&" "
        ulliatwoclass=" "&split(ekmenustr,"*")(10)&" "
        
        ultwosubclass=" class="""&split(ekmenustr,"*")(11)&""""
        ullitwosubclass=" "&split(ekmenustr,"*")(12)&" "
        ulliatwosubclass=" "&split(ekmenustr,"*")(13)&" "
        end if

        if colsm.count>=1 Then
        if instr(mobilbuton,"#menulist1#") then
        menusubclass1=" class=""dropdown"""
        menusubclass2="dropdown-item nav-link dropdown-toggle"
        elseif instr(mobilbuton,"#menulist2#") then
        menusubclass1=""
        menusubclass2=""
        else
        menusubclass1=lioneclass
        menusubclass2=liaoneclass
        end if
    
        end if 
        
        if colsm.count>=1 then
        lionehasclass=lionehasclass
        liaonehasclass=liaonehasclass
        else
        lionehasclass=""
        liaonehasclass=""
        end if
        'Birinci li
        
    menucreate25=menucreate25&"<li class="""&lioneclass&""&lionehasclass&"""><a href="""&menuseolinkana1&""" class="""&liaonehasclass&""&liaoneclass&""&styli&""""&linkkapat&">"&menuisimana1&"</a>"
        if colsm.count>=1 then        
        
        if instr(mobilbuton,"#menulist1#") then 
        menucreate25=menucreate25&"<ul class=""dropdown-menu"">"
        elseif instr(mobilbuton,"#menulist2#") then
        menucreate25=menucreate25&"<ul>"
        else
        menucreate25=menucreate25&"<ul"&ultwoclass&">"
        end if
        end if
                for each coliim in colsm
        if colsm.count>=1 then
                                                    strid=colsm(coliim)("id")
                menubagliana=colsm(coliim)("bagli")
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=colsm(coliim)("seolink")
                if instr(menuseolinkana1,"http") then
                menuseolinkana1=menuseolinkana1
                else
                menuseolinkana1="/"&menuseolinkana1
                end if
                menuisimana1=colsm(coliim)("name")
                strtoplu=colsm(coliim)("turu")
                stronay=colsm(coliim)("onay")
         
    if menuseolinkana1=aid1 then 
     if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
        
        set colssubm = colsm(coliim)("children")
        menusubclass1a=""
        menusubclass2a=""
        if colssubm.count>=1 then
        if instr(mobilbuton,"#menulist1#") then
        menusubclass1a=" class=""dropdown-submenu"""
        menusubclass2a=" dropdown-item"
        elseif instr(mobilbuton,"#menulist2#") then
        menusubclass1=""
        menusubclass2=""
        else
        menusubclass1a=ullitwoclass
        menusubclass2a=ulliatwoclass
        end if
        lionehasclass=lionehasclass
        liaonehasclass=liaonehasclass
        ullihastwoclassstr=ullihastwoclass
        ulliahastwoclass=ulliahastwoclass
        else
        lionehasclass=""
        liaonehasclass=""
        ullihastwoclassstr=""
        ulliahastwoclass=""
        end if
        
        'ikinci li
        menucreate25=menucreate25&"<li class="""&ullitwoclass&""&lionehasclass&""&ullihastwoclassstr&"""><a href="""&menuseolinkana1&""" class="""&ulliatwoclass&""&styli&""""&linkkapat&">"&menuisimana1&"</a>"
        if colssubm.count>=1 then
        if instr(mobilbuton,"#menulist1#") then
        menucreate25=menucreate25&"<ul class=""dropdown-menu"">"
        elseif instr(mobilbuton,"#menulist2#") then
        menucreate25=menucreate25&"<ul>"
        else
        menucreate25=menucreate25&"<ul"&ultwosubclass&">"
        end if
        end if
                for each coliisubm in colssubm
        if colssubm.count>=1 then
                                                    strid=colssubm(coliisubm)("id")
                menubagliana=colssubm(coliisubm)("bagli")
                                        if instr(menubagliana,"/*/") then
                                        menubaglianat=split(menubagliana,"/*/")(0)
                                        menubaglianaid=split(menubagliana,"/*/")(1)
                                        end if
                menuseolinkana1=colssubm(coliisubm)("seolink")
                menuisimana1=colssubm(coliisubm)("name")
                strtoplu=colssubm(coliisubm)("turu")
                stronay=colssubm(coliisubm)("onay")
         
    if menuseolinkana1=aid1 then 
     if instr(mobilbuton,"#menulistek{") then
            styli=" "&lioneaktifclass&""
        else
            styli=" active"
        end if
    else
    styli=""
    end if
        menucreate25=menucreate25&"<li class="""&ullitwosubclass&"""><a href="""&menuseolinkana1&""" class="""&ulliatwosubclass&""&styli&""""&linkkapat&">"&menuisimana1&"</a></li>"
        end if
                                        next
        if colssubm.count>=1 then
        menucreate25=menucreate25&"</ul>"
        end if
        menucreate25=menucreate25&"</li>"
        end if
                                        next
        if colsm.count>=1 then
        menucreate25=menucreate25&"</ul>"
        end if
        menucreate25=menucreate25&"</li>"
        end if
    
    
        next
        end if
        
        end if
           close(mmmGenel)
       
        if instr(mobilbuton,"#menulist#") or instr(mobilbuton,"#menulist1#") or instr(mobilbuton,"#menulistek{") then
        if instr(mobilbuton,"#menulist1#") then
        menucreate25=menucreate25&""&split(mobilbuton,"#menulist1#")(1)    
        elseif instr(mobilbuton,"#menulistek{") then
        menucreate25=menucreate25&""&split(mobilbuton,"}#")(1)    
        else
        menucreate25=menucreate25&""&split(mobilbuton,"#menulist#")(1)
        end if
        else
    menucreate25=menucreate25&"</ul>"
    menucreate25=menucreate25&"</nav>"
    end if
end function



function ozellikbaslikcek(formid,gorozel)
sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1'"&gorozel&" order by sira"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
formisim=dilozellikcek(mmmYardimci("id"),mmmYardimci("isim"))

ozellikbaslikcek=formisim
						  
mmmYardimci.movenext
loop
close(mmmYardimci)
end function
%>
<%function ozellikcek(formid,gorozel,formidtur,csstip)
 sqlString = "select * from ozellikler where formid='"&formid&"' and alt = '1'"&gorozel&" order by sira"
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

if rsformtur=1 or rsformtur=3 or rsformtur=12 then
ozellikcek=valuefo
          elseif rsformtur=2 or rsformtur=7 then
		  elseif rsformtur=4 then

sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&rsformid&"' order by sira"
set mmmYardimci3 = Con.Execute (sqlString)
Do While Not mmmYardimci3.EOF
formisim=dilozellikcek(mmmYardimci3("id"),mmmYardimci3("isim"))
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
formisim=dilozellikcek(mmmYardimci3("id"),mmmYardimci3("isim"))
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

                            
else
								
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
end function%>
<%
 dim resimkat(1000)
Submit=Request.QueryString("islem")
if Submit="sifregiris" then
call sifregiris
elseif Submit="locationchs" then
call locationchs
elseif Submit="ilcesec" then
call ilcesec
elseif Submit="statecek" then
call stateceksub
else
end if

    sub formajaxmessage(sucmes, errmes)
              if sucmes="" then
              sucmes="Başarılı!"
              end if
              if errmes="" then
              errmes="Hata!"
              end if
              %>
<div class="contact-form-success alert alert-success d-none mt-4" id="contactSuccess">
    <strong>Başarılı!
    </strong>
    <span class="mail-success-message text-3 d-block" id="mailSuccessMessage">
    </span>
</div>
<div class="contact-form-error alert alert-danger d-none mt-4" id="contactError">
    <strong>Hata!
    </strong>
    <span class="mail-error-message text-3 d-block" id="mailErrorMessage">
    </span>
</div>
<%end sub

    sub stateceksub

 if request("qry1")="" then
qry1=session("il")
else
qry1=request("qry1")
end if

 if request("qry2")="" then
qry2=session("ilcevar")
else
qry2=request("qry2")
end if
    
 if request("name")="" then
name=esser("s","Seçiniz")
else
name=request("name")
end if
response.write replace(statecek(qry1,name,qry2,1,qry5),"value="""&qry2&"""","value="""&qry2&""" selected")
    response.End
 end sub

 sub locationchs

 if request("ulke")="" then
ulkeidd=session("ulke")
else
ulkeidd=request("ulke")
end if

 if request("sehir")="" then
ilidd=session("il")
else
ilidd=request("sehir")
end if

 if request("ilcevar")="" then
ilceidd=session("ilcevar")
else
    if isNumeric(request("ilcevar"))=True then
ilceidd=request("ilcevar")
    else
    ilceidd="0"
    end if
end if
    'response.Write ilceidd&"-"& ilidd
 if request("sbtur")="" then
sbtur="teslim_adres_sehir"
else
sbtur=request("sbtur")
end if
           if request.QueryString("typelct")="state" then    
sqlString = "select * from "&dbmstate&" where statu = '1' and country_id='"&ulkeidd&"' ORDER BY name"
               onlocstr=" onchange=""return locationsec('cities',1,"&ilidd &")"""
               else
sqlString = "select * from "&dbmcity&" where statu = '1' and state_id='"&ilidd&"' ORDER BY name"
               onlocstr=""
               end if
set mmmYardimci = Con.Execute (sqlString)
               if mmmYardimci.eof then
               %>
<input type="text" class="form-control" required data-msg-required="<%=storelng("store","Doldurulması Zorunlu Alan")%>" value="" id="<%=sbtur%>" name="<%=sbtur%>" />
<%else%>
<select id="<%=sbtur%>" name="<%=sbtur%>" class="mb2 input-half form-control" <%=onlocstr %>>
    <option value="" selected="selected"><%=storelng("store","Seçiniz")%></option>
    <%
Do While Not mmmYardimci.Eof
      ilcestring=mmmYardimci("name")
      if ilcestring="" then
      else
if ilceidd*1=mmmYardimci("id")*1 then
ilceselect=" selected"
else
ilceselect=""
end if
%>
    <option value="<%=mmmYardimci("id")%>" <%=ilceselect%>>
        <%= UCase(Left(ilcestring,1)) & LCase(Right(ilcestring, Len(ilcestring) - 1))%>
    </option>
    <%end if
      mmmYardimci.MoveNext
  loop
  %>
</select>
<%
    end if
  close(mmmYardimci)
    response.End
 end sub

 sub ilcesec

 if request("kategori")="" then
ilidd=session("il")
else
ilidd=request("kategori")
end if

 if request("ilcevar")="" then
ilceidd=session("ilcevar")
else
    if isNumeric(request("ilcevar"))=True then
ilceidd=request("ilcevar")
    else
    ilceidd="0"
    end if
end if
    'response.Write ilceidd&"-"& ilidd
 if request("sbtur")="" then
sbtur="teslim_adres_sehir"
else
sbtur=request("sbtur")
end if
%>
<select id="<%=sbtur%>" name="<%=sbtur%>" class="mb2 input-half form-control">
    <option value="" selected="selected">Bölge Seçiniz</option>
    <%
sqlString = "select * from "&dbcilce&" where ulke = '90' and aktifilce = '-1' and il='"&ilidd&"' ORDER BY ilce"
set mmmYardimci = Con1.Execute (sqlString)
Do While Not mmmYardimci.Eof
      ilcestring=mmmYardimci("ilce")
      if ilcestring="" then
      else
if ilceidd*1=mmmYardimci("id")*1 then
ilceselect=" selected"
else
ilceselect=""
end if
%>
    <option value="<%=mmmYardimci("id")%>" <%=ilceselect%>>
        <%= UCase(Left(ilcestring,1)) & LCase(Right(ilcestring, Len(ilcestring) - 1))%>
    </option>
    <%end if
      mmmYardimci.MoveNext
  loop
  close(mmmYardimci)
  %>
</select>
<%
    response.End
 end sub
 
 
Sub sifregiris
'response.Write(session("rinn_sifre"))
if giriskont(request.form("sifre"))="" or request.form="" then
session("hatamesaj")=""&esser("s","Girdiğiniz Şifre Boş")&""
else
sifre=giriskont(request.form("sifre"))
set mmmYardimci = Con.Execute ("select * from uyeler where sifre='"&sifre&"'")
if mmmYardimci.eof then
session("hatamesaj")=""&esser("s","Girdiğiniz Şifre Yanlış")&""
else
session("rinn_sifre")="dogru"
session("hatamesaj")=""&esser("s","Giriş Başarılı")&""
end if
close(mmmYardimci)
end if
end sub%>
<%
function yazicek(id,dbek,deger,deger1)
dbekcon="mmmYardimci"&dbek&""
if dbek="" then
dbek2="1"
else
dbek2=dbek
end if
  sqlString = "select * from yazilar where kategori='"&id&"' and ilksayfa='1' order by sira, id desc"
   
set dbekcon = Con.Execute (sqlString)
if dbekcon.eof then
'yazicek="0"
else
if deger="2" then
yazicek="<ul id=""navbaryan"" class=""toggler_blocks"&deger1&""">"
else
yazicek="<ul id="""&id&""" class=""panel-collapse"">"
end if
Do While Not dbekcon.EOF
dbek2=dbek2+1 
yaziid=dbekcon("id")
yaziisimm=dbekcon("yazib")
yaziseolink=dbekcon("seolink")
yazilink=dbekcon("link")
		 yaziisim=dilyazib(yaziid,yaziisimm,lang)
yaziisim1=seoyazi(yaziid,yaziseolink,lang)
		if yazilink = "" or yazilink = "0" or isNull(yazilink) Then
		link=""""&siteadres&""&yaziisim1&""""&linkkapat&""
		else
		link=""""&yazilink&""" target="""&dbekcon("target")&""""
		end if
yazicek=yazicek&"<li id="""&yaziid&"""><a href="&link&"> "&yaziisim&"</a></li>"

dbekcon.MoveNext
  loop
  yazicek=yazicek&"</ul>"
end if
close(dbekcon)
end function

function kategoricek(id,dbek,deger)
dbekcon="mmmYardimci"&dbek&""
if dbek="" then
dbek1="1"
else
dbek1=dbek
end if
  sqlString = "select * from kategoriyazi where anasek='"&id&"' and menugosterim='1' order by sira, id desc"
set dbekcon = Con.Execute (sqlString)
if dbekcon.eof then
kategoricek=yazicek(id,"","1",csstip)
else
kategoricek="<ul id="""&id&""" class=""panel-collapse"">"
Do While Not dbekcon.EOF
dbek1=dbek1+1
    baslikid1=dbekcon("id")
		katelink=dbekcon("link")
		kateisim=dbekcon("isim")
		kateseolink=dbekcon("seolink")
baslikisim1=seokate(baslikid1,kateseolink)
    		 strisim=dilkate(baslikid1,kateisim)
    if katelink = "" or katelink = "0" or isNull(katelink) Then
		katelink=""""&siteadres&""&baslikisim1&""""
		else
		katelink=""""&katelink&""" target="""&mmmGenel("target")&""""
		end if
    kategoriceki=kategoricek(baslikid1,dbek1,"1")
if kategoriceki="0" or kategoriceki="" then
katelinki=katelink
kategoriceki=""
else
katelinki="""#"&baslikid1&""" data-toggle=""collapse"" data-parent=""#sidemenu"""
end if
    'katelinki="""#"&baslikid1&""" data-toggle=""collapse"" data-parent=""#sidemenu"""

kategoricek=kategoricek&"<li id="""&id&"""><a href="&katelinki&">"&strisim&"</a></li>"

kategoricek=kategoricek&""&kategoricek(baslikid1,dbek1,"1")
kategoricek=kategoricek&""&yazicek(dbekcon("id"),dbek1,"1",csstip)

dbekcon.MoveNext
  loop
  kategoricek=kategoricek&"</ul>"
end if
close(dbekcon)
end function

 Sub yanmenu(lns,ayar)
 Call kategoriayar(lns,ayar,kayar3)
if (lns="" or lns="0") or ayar="0" or lns="9999" then
			csstip=ayar&""&ayar
			else
			csstip=lns&""&ayar
			end if
			
 		set mmmGenel = Con.Execute ("select * from kategoriyazi where id= "&anaid&" and durum = '1' and modulmu='0'")
        Do While not mmmGenel.Eof
		yma=1
		  
		set mmmYardimci = Con.Execute ("select * from kategoriyazi where anasek = '"&mmmGenel("id")&"' and durum = '1' and modulmu='0' ORDER BY sira")
        Do While not mmmYardimci.Eof
		ymb=1
		set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where anasek = '"&mmmYardimci("id")&"' and durum = '1' and modulmu='0' ORDER BY sira")
        Do While not mmmYardimci1.Eof
		ymc=1
		mmmYardimci1.movenext
loop
close(mmmYardimci1)
		mmmYardimci.movenext
loop
close(mmmYardimci)
		mmmGenel.movenext
loop
close(mmmGenel)
if anaid=aid then
ymenuid=id
else
ymenuid=aid
end if


			
					 Set mmmGenel = Server.CreateObject("ADODB.Recordset")
		 if lns="0" then
if yma="1" then
	
set mmmGenel = Con.Execute ("select * from kategoriyazi where alt = '0' and anasek = '"&anaid&"' and durum = '1' and modulmu='0' ORDER BY sira")
else
set mmmGenel = Con.Execute ("select * from kategoriyazi where alt = '1' and id = "&anaid&" and durum = '1' and modulmu='0' ORDER BY sira")

		end if
		elseif lns="9999" then
		anaid=id
		set mmmGenel = Con.Execute ("select * from kategoriyazi where anasek = "&anaid&" and durum = '1' and modulmu='0' ORDER BY sira")
		else
		anaid=lns
   sqlstring="select * from kategoriyazi where anasek = "&anaid&" and durum = '1' and modulmu='0' ORDER BY sira"
    'response.Write sqlstring
		set mmmGenel = Con.Execute (sqlstring)
		end if
		response.Write("<button type=""button"" class=""navbar-toggle collapsed yanmenumobil"" data-toggle=""collapse"" data-target=""#navbaryan"" aria-expanded=""false"" aria-controls=""navbar""><div class=""sr-only"">Kategoriler</div><div class=""sr-icon-button""><span class=""icon-bar""></span><span class=""icon-bar""></span><span class=""icon-bar""></span></div></button><nav class="" sidebar"" id=""sidemenu"" aria-multiselectable=""false"">")
		if mmmGenel.eof then
		kategoriceki=yazicek(anaid,"","2",csstip)
    
		if kategoriceki="0" then
kategoriceki=""
else
end if
response.Write(kategoriceki)

		else
		response.Write("<ul id=""navbaryan"" class=""toggler_blocks"&csstip&""">")
		Do While not mmmGenel.Eof
		baslikid=mmmGenel("id")
		katelink=mmmGenel("link")
		baslikisim=dilkate(baslikid,mmmGenel("isim"))
baslikisim1=seokate(baslikid,mmmGenel("seolink"))
		if katelink = "" or katelink = "0" or isNull(katelink) Then
		katelink=""""&siteadres&""&baslikisim1&""""
		else
		katelink=""""&katelink&""" target="""&mmmGenel("target")&""""
		end if
		
kategoriceki=kategoricek(baslikid,"","")
if kategoriceki="0" or kategoriceki="" then
katelinki=katelink
kategoriceki=""
else
katelinki="""#"&baslikid&""" data-toggle=""collapse"" data-parent=""#sidemenu"""
end if
response.Write("<li><a href="&katelinki&">"&baslikisim&"</a>"&kategoriceki&"</li>")
mmmGenel.movenext
loop
response.Write("</ul>")
end if
close(mmmGenel)
response.Write("</nav>")
 
 End Sub%>
<% Sub video() %>
<% 
						'if rid="" then
						if id=aid then
galerikategori=aid
else
galerikategori=id
end if

'else
'galerikategori=rid
'end if
 if galerikategori="" or galerikategori="0" then
  set mmmGenel = Con.Execute ("SELECT * from yazilar order by tarih desc")
  else
   set mmmGenel = Con.Execute ("SELECT * from yazilar where kategori='"&galerikategori&"' order by id desc ")
  end if
if mmmGenel.eof then

else
    response.Write "<div class=""col mt-4"" style=""min-height: 250px;"">"
    response.Write "<div class=""row portfolio-list lightbox"" data-plugin-options=""{'delegate': 'a.lightbox-portfolio', 'type': 'image', 'gallery': {'enabled': true}}"">"
		Do While Not mmmGenel.Eof
		
					did=EmailDuzelt(mmmGenel("form"))
					ad=mmmGenel("yazib")
                    adalt=ad
                    if adalt="" then
                    adalt=heading_banner&" img"
                    end if
				belge=mmmGenel("form")
				midd=mmmGenel("id")
				set mmmYardimci1 = Con.Execute ("select * from resimd where baslik='"&midd&"' order by fid")
if mmmYardimci1.eof then
if instr(belge,"youtube") then
resim="https://i2.ytimg.com/vi/"&did&"/hqdefault.jpg"
else
resim=imgyol&"temp/resimyok.jpg"
end if
dtype=""
else
resim=imggaleriyol&""&mmmYardimci1("resimid")
dtype=" data-type=""video"""
end if
close(mmmYardimci1)	
    i5="<div class=""col-6 col-sm-4 col-lg-3 appear-animation"" data-appear-animation=""expandIn"" data-appear-animation-delay=""200"">"&_
          "<div class=""portfolio-item"">"&_
            "<a href=""https://www.youtube.com/embed/"&did&""" data-video=""https://www.youtube.com/embed/"&did&""" class=""video-modal"" data-target=""#videoModal"" data-toggle=""modal"" data-gallery=""multiimages"&galerikategori&""" data-title="""&ad&""" data-footer="""&resimacik&""""&dtype&" title="""&ad&""">"&_
              "<span class=""thumb-info thumb-info-lighten thumb-info-centered-icons border-radius-0"">"&_
                "<span class=""thumb-info-wrapper border-radius-0"">"&_
                  "<img src="""&resim&""" class=""img-fluid border-radius-0"" alt="""&adalt&""">"&_
                  "<span class=""thumb-info-action"">"&_
                    "<span class=""thumb-info-action-icon thumb-info-action-icon-light"">"&_
                      "<i class=""fas fa-search text-dark"">"&_
                      "</i>"&_
                    "</span>"&_
                  "</span>"&_
                "</span>"&_
              "</span>"&_
              "<h4 class=""card-title font-weight-bold line-height-3 text-4 mb-0"">"&ad&"</h4>"&_
            "</a>"&_
          "</div>"&_
        "</div>"
      response.Write i5
				%>

<%
mmmGenel.movenext
			loop  			
      response.Write "</div>"
      response.Write "</div>"
end if
close(mmmGenel)
%>
<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <div>
                    <iframe width="100%" height="350" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<%
 End Sub
 
 Sub listeleme(listeayar1,listeayar2,listeayar3,listeayar4)

colmdstr=i6
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

if liste1ayar1="0" then
 if listeid="1" then
 laid=aid
 else
 laid=id
 end if
 elseif liste1ayar1="" then
 laid=istrid
 else
 laid=liste1ayar1
 end if
  csstip=laid
if request("filtre")="1" then
if id=aid then
anaidd=aid
    anakate="2"
else
    anakate="0"
anaidd=id
end if
 ozellik=replace(replace(replace(request("ozellik"),", 0",""),"0, ",""),", -0","")
 
 oiddadet=ubound(split(ozellik,","))

for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if
if oidddd<1 then
ayrac=""
else
ayrac="or"
end if
agacfiltre=""&agacfiltre&" "&ayrac&" isim='"&agacoidd&"'"
next
ozellikagac=" and instr('"&ozellik&"',isim)"
    if anakate="1" then
 sqlstring="select distinct kategori, * from ozellikler2,yazilar where yazilar.id = ozellikler2.kateid "
 else
    if id=aid then
 sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.id = '"&anaidd&"' and yazilar.kategori = kategoriyazi.id order by yazilar.id"
    else
sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.anasek = "&anaidd&" and yazilar.kategori = kategoriyazi.id order by yazilar.id"
end if
 end if

    else
if liste1ayar4="kate"  then
set mmmGenel = Con.Execute ("select * from kategoriyazi where anasek = '"&laid&"' and durum='1' ORDER BY sira, id desc ")
else 
if listeayar4="1" then
csstip=""
sqlstring="select * from yazilar where (yazi like '%"&aramastr&"%' or yazib like '%"&aramastr&"%' or bilgi3 like '%"&aramastr&"%') and durum='1' and modulmu='0' order by sira, id desc"
else
csstip=listeayar3&""&listeayar2
sqlstring="select * from yazilar where kategori = '"&listeayar4&"' and durum='1' order by sira,id desc"
end if
end if
    end if
set mmmGenel = Con.Execute (sqlstring)
    if instr(i3,"#repeatlist#") then
response.Write(split(replace(replace(i3,"``",""""),"`","'"),"#repeatlist#")(0))
    else
    end if
if mmmGenel.eof then
response.Write("<div class=""icerikyok"">"&esser("s","İçerik Bulunmuyor..")&"</div>")
else
			Do While not mmmGenel.Eof
strlisteid=mmmGenel("id")

    if instr(yaziolan,strlisteid) then
			else
			yaziolan=yaziolan&","&strlisteid			
			 if request("filtre")="1" then
			 
			for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if

set mmmYardimci = Con.Execute ("select * from ozellikler2 where kateid='"&mmmGenel("id")&"' and isim = '"&agacoidd&"'")
if mmmYardimci.eof then
yv=yv+0
yy=yy+1
else
yv=yv+1
yy=yy+0
end if
    close(mmmYardimci)
next
else
yy="0"
end if

yyana=yyana+yy
if yy<>"0" then
if yyana="0" then
Response.Write("Kayıtlı Yok")
else
end if
else	
set mmmYardimci = Con.Execute ("select * from resimd where baslik='"&mmmGenel("id")&"' and tur='1'")
if mmmYardimci.eof then
resimim="'"&imgyol&"temp/resimyok.jpg'"
else
resimim="'"&imggaleriyol&""&mmmYardimci("resimid")&"'"
end if
close(mmmYardimci)
strlisteyazib=mmmGenel("yazib")
strlisteseolink=mmmGenel("seolink")
strlistelink=mmmGenel("link")
strurunidyan=mmmGenel("urunid")
strbelgeyan=mmmGenel("form")
baslikisim=dilyazib(strlisteid,strlisteyazib,lang)
baslikisim1=seoyazi(strlisteid,strlisteseolink)
    seolarlinki=seolarlink(strlisteid,"sayfa",lang)

if strurunidyan="5" then
strbelgeyan1=strbelgeyan
did=EmailDuzelt(strbelgeyan)
midd=strlisteid
					ad=strlisteyazib
				belge=strbelgeyan1
					resimim="('http://i2.ytimg.com/vi/"&did&"/hqdefault.jpg')"
					link=""&belge&""" data-toggle=""lightbox"" data-gallery=""multiimages"&laid&""" data-title="""&baslikisim&""" data-footer="""&resacik&""
else
if strlistelink = "" or strlistelink = "0" or isNull(strlistelink) Then
		link=""&siteadres&""&baslikisim1&""
		else
		link=strlistelink&""" target="""&mmmGenel("target")
		end if
end if
		sqlString = "select * from ozellikler2 where kateid='"&strlisteid&"' and ozelikid = '1'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
formid="1"
else
formid=mmmYardimci("formid")
formidtur=mmmYardimci("tur")
end if
close(mmmYardimci)
		str_bilgi1=mmmGenel("bilgi1")
		str_bilgi2=mmmGenel("bilgi2")
		str_bilgi3=mmmGenel("bilgi3")
		str_bilgi4=mmmGenel("bilgi4")
Verii5=i5&""
Verii5 = Replace(Verii5, ""&rsablonstr&"#csstip#"&rsablonstr&"", csstip)
Verii5 = Replace(Verii5, ""&rsablonstr&"#colmdstr#"&rsablonstr&"", colmdstr)
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim#"&rsablonstr&"", ""&resimim&"")
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim1#"&rsablonstr&"", "("&resimim&")")
Verii5 = Replace(Verii5, ""&rsablonstr&"#baslikisim#"&rsablonstr&"", baslikisim)
Verii5 = Replace(Verii5, ""&rsablonstr&"#yaziid#"&rsablonstr&"", strlisteid)
Verii5 = Replace(Verii5, ""&rsablonstr&"#str_bilgi3#"&rsablonstr&"", str_fi)
Verii5 = Replace(Verii5, ""&rsablonstr&"#link#"&rsablonstr&"", link)
    
    if cdnstatu="1" then
    if instr(Verii5,"""/contents/img/") then
Verii5 = Replace(Verii5, """/contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    else
Verii5 = Replace(Verii5, "=/contents/img/","="&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    end if
    end if

if Instr(Verii5, ""&rsablonstr&"#ozellikcek(") then
ocadet=ubound(split(Verii5, ""&rsablonstr&"#ozellikcek("))
for oca=1 to ocadet
strocv=split(split(Verii5, ""&rsablonstr&"#ozellikcek(")(1),")#"&rsablonstr&"")(0)

ocvadet=ubound(split(strocv,","))
if ocvadet<3 then
else
gorozel=split(strocv,",")(1)
csstip=split(strocv,",")(3)
Verii5 = Replace(Verii5, ""&rsablonstr&"#ozellikcek("&rsablonstr&"#formid#"&rsablonstri&","&gorozel&","&rsablonstr&"#formidtur#"&rsablonstri&","&csstip&")#"&rsablonstr&"",ozellikcek(formid,gorozel,formidtur,csstip))
end if
next
else
end if

if Instr(Verii5,""&rsablonstr&"#hesapla(") then
ocadet=ubound(split(Verii5,""&rsablonstr&"#hesapla("))
for oca=1 to ocadet
strocv=split(split(Verii5,""&rsablonstr&"#hesapla(")(1),")#"&rsablonstr&"")(0)
ocvadet=ubound(split(strocv,","))
if ocvadet<2 then
else
value1=split(strocv,",")(0)
islemi=split(strocv,",")(1)
value2=split(strocv,",")(2)
if isNumeric(value1)=false or isNumeric(value2)=false then
valuem="0"
else
if islemi="%" then
valuem=round(((cint(value1)-cint(value2))/cint(value1))*100,0)
else
end if
end if
Verii5 = Replace(Verii5, ""&rsablonstr&"#hesapla("&value1&","&islemi&","&value2&")#"&rsablonstr&"",valuem)
end if
next
else
end if
listelemegetir=Verii5
response.Write(listelemegetir)
str_fi=""
    end if
    end if
						  mmmGenel.movenext
			loop  
			end if
			
    if instr(i3,"#repeatlist#") then
response.Write(split(replace(replace(i3,"``",""""),"`","'"),"#repeatlist#")(1))
    else
    end if	
						close(mmmGenel)
%>
<% End Sub%>
<% Sub listelemeform(listeayar1,listeayar2,listeayar3,listeayar4) 
Call kategoriayar(listeayar1,listeayar2,kayar3)
if ayar2="" then
			csstip=""
			else
			csstip=listeayar1&""&listeayar2
			end if
			colmdstr=i6
			%>
<div class="altbaslik<%=csstip%>"><%=kateisim%></div>
<%
if id=aid then
anaidd=aid
    anakate="2"
else
    anakate="0"
anaidd=id
end if
 ozellik=replace(replace(replace(request("ozellik"),", 0",""),"0, ",""),", -0","")
 
 oiddadet=ubound(split(ozellik,","))

for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if
if oidddd<1 then
ayrac=""
else
ayrac="or"
end if
agacfiltre=""&agacfiltre&" "&ayrac&" isim='"&agacoidd&"'"
next
ozellikagac=" and instr('"&ozellik&"',isim)"
 if request("filtre")="1" then
 if anakate="1" then
 sqlstring="select distinct kategori, * from ozellikler2,yazilar where yazilar.id = ozellikler2.kateid "
 else
    if id=aid then
 sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.id = '"&anaidd&"' and yazilar.kategori = kategoriyazi.id order by yazilar.id"
    else
sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.anasek = "&anaidd&" and yazilar.kategori = kategoriyazi.id order by yazilar.id"
end if
 end if
else
 if anakate="1" then
 sqlstring="select distinct kategori, * from ozellikler2,yazilar where yazilar.id = ozellikler2.kateid "

else
if id=aid then
sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.id = '"&anaidd&"' and yazilar.kategori = kategoriyazi.id order by yazilar.id"
else
sqlstring="select * from kategoriyazi,yazilar where kategoriyazi.anasek = "&anaidd&" and yazilar.kategori = kategoriyazi.id order by yazilar.id"
end if

end if
end if
    
    set mmmGenel = Con.Execute (sqlstring)
response.Write("<div class=""s-mode"&csstip&""">")
			Do While not mmmGenel.Eof
strlisteid=mmmGenel("id")
			if instr(yaziolan,strlisteid) then
			else
			yaziolan=yaziolan&","&strlisteid			
			 if request("filtre")="1" then
			 
			for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if

set mmmYardimci = Con.Execute ("select * from ozellikler2 where kateid='"&mmmGenel("id")&"' and isim = '"&agacoidd&"'")
if mmmYardimci.eof then
yv=yv+0
yy=yy+1
else
yv=yv+1
yy=yy+0
end if
next
close(mmmYardimci)
else
yy="0"
end if

yyana=yyana+yy
if yy<>"0" then
if yyana="0" then
Response.Write("Kayıtlı Yok")
else
end if
else	
					
        set mmmYardimci = Con.Execute ("select * from resimd where baslik='"&strlisteid&"' and type='1'")
if mmmYardimci.eof then
resimim="'"&imgyol&"temp/resimyok.jpg'"
else
resimim="'"&imggaleriyol&""&mmmYardimci("resimid")&"'"
end if
close(mmmYardimci)
strlisteyazib=mmmGenel("yazib")
strlisteseolink=mmmGenel("seolink")
strlistelink=mmmGenel("link")
strurunidyan=mmmGenel("urunid")
strbelgeyan=mmmGenel("form")
baslikisim=dilyazib(strlisteid,strlisteyazib,lang)
baslikisim1=seoyazi(strlisteid,strlisteseolink)


if strlistelink = "" or strlistelink = "0" or isNull(strlistelink) Then
		link="/"&baslikisim1&""
		else
		link=""""&strlistelink&""" target="""&mmmGenel("target")&""""
		end if
%>
<%
sqlString = "select * from ozellikler2 where kateid='"&strlisteid&"' and ozelikid = '1'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
formid="1"
else
formid=mmmYardimci("formid")
formidtur=mmmYardimci("tur")
end if
close(mmmYardimci)
'function listelemegetir(veri),
Verii5=i5&""
Verii5 = Replace(Verii5, ""&rsablonstr&"#csstip#"&rsablonstr&"", csstip)
Verii5 = Replace(Verii5, ""&rsablonstr&"#colmdstr#"&rsablonstr&"", colmdstr)
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim#"&rsablonstr&"", resimim)
Verii5 = Replace(Verii5, ""&rsablonstr&"#baslikisim#"&rsablonstr&"", baslikisim)
Verii5 = Replace(Verii5, ""&rsablonstr&"#str_bilgi3#"&rsablonstr&"", str_bilgi3)
Verii5 = Replace(Verii5, ""&rsablonstr&"#link#"&rsablonstr&"", link)
    
    if cdnstatu="1" then
    if instr(Verii5,"""/contents/img/") then
Verii5 = Replace(Verii5, """/contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    else
Verii5 = Replace(Verii5, "=/contents/img/","="&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    end if
    end if
if Instr(Verii5, ""&rsablonstr&"#ozellikcek(") then
ocadet=ubound(split(Verii5, ""&rsablonstr&"#ozellikcek("))
for oca=1 to ocadet
strocv=split(split(Verii5, ""&rsablonstr&"#ozellikcek(")(1),")#"&rsablonstr&"")(0)

ocvadet=ubound(split(strocv,","))
if ocvadet<3 then
else
gorozel=split(strocv,",")(1)
csstip=split(strocv,",")(3)
Verii5 = Replace(Verii5, ""&rsablonstr&"#ozellikcek("&rsablonstr&"#formid#"&rsablonstri&","&gorozel&","&rsablonstr&"#formidtur#"&rsablonstri&","&csstip&")#"&rsablonstr&"",ozellikcek(formid,gorozel,formidtur,csstip))
end if
next
else
end if

listelemegetir=Verii5
'end Function
response.Write(listelemegetir)
%>
<%if eserre=1 then%>
<div class="listef_cerceve<%=csstip%> col-md-12"><a href=<%=link%>>
        <div class="listef_cerceve_ic<%=csstip%> col-md-3">
            <div style="height:<%=boy%>px; background:url(<%=imggaleriyol%><%=resimim%>) no-repeat #ffffff; background-size:<%=en1%>px; background-position:center; width:<%=en1%>px;<%=styleoval%>" class="listef_cerceve_resim<%=csstip%>"></div>
        </div>
        <div class="listf_ozellikler col-md-9">
            <div class="listef_cerceve_yazi<%=csstip%> col-md-12"><%=baslikisim%></div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=93)")%></div>
                <div class="list_yazi1<%=csstip%>  col-md-7"><%=ozellikcek(formid," and (id=93)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=94)")%></div>
                <div class="list_yazi1<%=csstip%>  col-md-7"><%=ozellikcek(formid," and (id=94)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=95)")%></div>
                <div class="list_yazi1<%=csstip%>  col-md-7"><%=ozellikcek(formid," and (id=95)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=96)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=96)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=97)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=97)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=98)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=98)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=99)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=99)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=316)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=316)",formidtur,csstip)%></div>
            </div>
            <div class="list_right<%=csstip%> col-md-6">
                <div class="listf_baslik1<%=csstip%> col-md-5"><%=ozellikbaslikcek(formid," and (id=443)")%></div>
                <div class="list_yazi1<%=csstip%> col-md-7"><%=ozellikcek(formid," and (id=443)",formidtur,csstip)%></div>
            </div>
        </div>
    </a></div>
<%
else
end if

end if
yv=0
yy=0
end if
						  mmmGenel.movenext
			loop  
			response.Write("</div>")
						close(mmmGenel)
%>
<% End Sub%>
<% Sub iletisimform(formid) %>
<div class="iletisimana">
    <%


 set mmmSayfa1 = Con.Execute ("select * from formlar where id="&formid&"")
      if mmmSayfa1.eof then
      else
strciftm=mmmSayfa1("ciftmail")
stricerikid=mmmSayfa1("icerikid")
      gmesaj=dilform(mmmSayfa1("id"),mmmSayfa1("gmesaj"),lang)
      end if
close(mmmSayfa1)
if stricerikid=0 then
      fgondergkodu=request.QueryString("fgondergkodu")
%>

    <%
    siteformvalidaterules= "rules: {"                                           
 set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' and gerekli = '1' order by sira")
  Do While Not mmmYardimci3.EOF
if mmmYardimci3("gonderen") = "1" then
emailtrue=", email: true"
        else
end if
        siteformvalidaterules= siteformvalidaterules&""&mmmYardimci3("name")&": {"
        siteformvalidaterules= siteformvalidaterules&"required: true "&emailtrue&""
					siteformvalidaterules= siteformvalidaterules&"},"
	mmmYardimci3.movenext
loop
close(mmmYardimci3)
					siteformvalidaterules= siteformvalidaterules&"sifre2: {"
						siteformvalidaterules= siteformvalidaterules&"required: true,"
						siteformvalidaterules= siteformvalidaterules&"minlength: 5,"
						siteformvalidaterules= siteformvalidaterules&"equalTo: ""#gkodu"""
					siteformvalidaterules= siteformvalidaterules&"}"
     siteformvalidaterules= siteformvalidaterules&" },"
    session("siteformvalidate")= siteformvalidatescriptd(formid,siteformvalidaterules)  
    'response.Write siteformvalidate
        %>
    <form name="siteForm<%=formid%>" id="siteForm<%=formid%>" class="contact-form" enctype="multipart/form-data" method="post" action="?form=gonder&islem=formgonder&formid=<%=formid%>">

        <div class="contact-form-success alert alert-success d-none mt-4" id="contactSuccess">
            <strong>Success!</strong> <%=gmesaj %>
        </div>

        <div class="contact-form-error alert alert-danger d-none mt-4" id="contactError">
            <strong>Error!</strong> <%=esser("s","Kayıtlarınızı 5 dk Arayla Yapabilirsiniz. Yada Güvenlik Kodunu Yanlış Girdiniz. Lütfen Tekrar Deneyiniz.")%>
            <span class="mail-error-message text-1 d-block" id="mailErrorMessage"></span>
        </div>


        <%'if islem="formgonder" then novalidate="novalidate"<div class="ietisim_baslik_onay">
						if fgondergkodu="1" then%>
        <div class="alert alert-success" role="alert"><span><%=gmesaj %></span></div>
        <%elseif fgondergkodu="3" then
	  session(formid)=""%>
        <div class="alert alert-success" role="alert"><span><%=esser("s","Kayıtlarınızı 5 dk Arayla Yapabilirsiniz. Yada Güvenlik Kodunu Yanlış Girdiniz. Lütfen Tekrar Deneyiniz.")%></span></div>
        <%elseif fgondergkodu="2" then
	  session(formid)=""%>
        <div class="alert alert-success" role="alert"><span><%=esser("s","Kayıtlarınızı 5 dk Arayla Yapabilirsiniz. Yada Güvenlik Kodunu Yanlış Girdiniz. Lütfen Tekrar Deneyiniz.")%></span></div>
        <%else
          end if
						  'else</div>
                              'end if%>

        <%
	if islem="formgonder" then
	else

	 set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira")

Do While Not mmmYardimci3.EOF
fname=mmmYardimci3("name")
fisim=mmmYardimci3("isim")
fid=mmmYardimci3("id")
ftur=mmmYardimci3("tur")
formisim=dilformv(fid,fisim,lang)
if ftur=8 then%>
        <div class="grupanabaslik"><%=formisim%></div>
        <div class="grupform1">
            <%
 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid&"' order by sira")
Do While Not mmmYardimci2.EOF
fid1=mmmYardimci2("id")
fisim1=mmmYardimci2("isim")
ftur1=mmmYardimci2("tur")
formisim1=dilformv(fid,fisim,lang)
if ftur1=8 then
%>
            <div class="grupanabaslik"><%=formisim1%></div>
            <div class="grupform1">
                <%
 set mmmYardimci1 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid1&"' order by sira")
Do While Not mmmYardimci1.EOF
fid3=mmmYardimci1("id")
ftur3=mmmYardimci1("tur")
response.Write(formolustur(fgtur,1,fid3,fovalue))
		fname3=""				  
mmmYardimci1.movenext
loop
close(mmmYardimci1)
%>
            </div>
            <%
else
response.Write(formolustur(fgtur,1,fid1,fovalue))
end if

		fname1=""				  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
        </div>
        <%
elseif ftur=9 then
%>
        <select id="Select12" size="1" onChange="return kategoriSec()" name="<%=fname%>" class="form-control">
            <%
 sqlString = "select * from ozellikler where formid='"&formid&"' and anasek='"&fid&"' order by sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
fname2=mmmYardimci2("name")
fisim2=mmmYardimci2("isim")
fid2=mmmYardimci2("id")
ftur2=mmmYardimci2("tur")
formisim2=dilformv(fid2,fisim2,lang)%>
            <OPTION value="<%=fid2%>"><%=formisim2%></OPTION>
            <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
        </select>
        <div id="sonuc"></div>
        <SCRIPT type=text/javascript> // Internet Explorer (5.0+) try { http=new ActiveXObject("Msxml2.XMLHTTP"); // yeni versiyon xmlhttp } catch (e) { try { http=new ActiveXObject("Microsoft.XMLHTTP"); // eski versiyon xmlhttp } catch (e) { http=false; } } // Mozilla ve Safari if ( !http && typeof XMLHttpRequest !='undefined' ) { try{ http=new XMLHttpRequest(); }catch(e) { http=false; } } // Diger if ( !http && window.createRequest ) { try{ http=window.createRequest(); }catch(e) { http=false; } } function kategoriSec() { var kategori=document.getElementById('Select12').value; if(kategori!=0) { http.open('get', '/sehirsec1.asp?Kategori=' + kategori); http.onreadystatechange=function() { document.getElementById('sonuc').innerHTML="Bekleyiniz..." ; if (http.readyState==4) { document.getElementById('sonuc').innerHTML=http.responseText; } }; http.send(null); }; } window.onload=kategoriSec; </SCRIPT> <%
else
response.Write(formolustur(fgtur,1,fid,fovalue))
end if
		fname=""				  
mmmYardimci3.movenext
loop
close(mmmYardimci3)


session("uye_kodu1") = rndsifreuretv1("1","5")
%> <div class="form-row">
            <div class="form-group col">
    <label class="font-weight-bold text-dark text-2"><%=esser("s","Güvenlik Kodu")%></label>
      <input name="gkodu" id="gkodu" type="hidden" value="<%=session("uye_kodu1")%>"/>
      <div class="input-group">
        <div class="input-group-btn">
          <button value="<%=session("uye_kodu1")%>" class="form-control gkodu" type="button"><%=session("uye_kodu1")%></button>
        </div>
        <input type="text" id="sifre2" name="sifre2" tabindex="997" class="form-control" autocomplete="off" />
      </div>
    </div>
    </div>

    <div class="form-row">
    <div class="form-group col">
      <input type="submit" name="Submit" id="contactFormSubmit" value="<%=esser("s","Gönder")%>" tabindex="998" class="btn btn-primary btn-modern pull-right" data-loading-text="Loading...">
    </div>
    </div>
  </form>
    <SCRIPT language="JavaScript">

	function formla16(gelen16, elidd)
    {
	document.getElementById(''+elidd+'').action=gelen16;
	if ($('#'+elidd+'').valid())
                {
                  document.getElementById(''+elidd+'').submit();
                }	else
				{
					validatorsiteform.focusInvalid();
					return false;
                }
	}
  </SCRIPT>
        <%end if
else
				  end if
				  %>
</div>
<%if strciftm="1" then%>
<div class="form_detay_ana">
    <%

set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira")

Do While Not mmmYardimci2.EOF
formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
%>
    <div class="form_isim_detay"><%=formisim%></div>
    <%
						  
mmmYardimci2.movenext
loop
close(mmmYardimci2)

 set mmmYardimci2 = Con.Execute ("select * from ozellikler2 where formid='"&formid&"' and ozelikid = '1' and isim = '1' and onay = '1' order by id")

Do While Not mmmYardimci2.EOF
if right(ys,1)=1 or right(ys,1)=3 or right(ys,1)=5 or right(ys,1)=7 or right(ys,1)=9 then%>
    <%collor="form_list1"%>
    <%else%>
    <%collor="form_list2"%>
    <%end if%>
    <%
 set mmmYardimci3 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' order by sira")
Do While Not mmmYardimci3.EOF
 set mmmYardimci = Con.Execute ("select * from ozellikler2 where ozelikid='"&fid&"' and tur='"&mmmYardimci2("tur")&"' order by id")
%>
    <div class="form_giris_detay <%=collor%>"><%=mmmYardimci("isim")%></div>
    <%
  close(mmmYardimci)
mmmYardimci3.movenext
loop
close(mmmYardimci3)
						  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
</div>
<%else
end if
%>
<% End Sub%>
<% Sub googleanaly(kod,site)
if kod="" or kod="-" then
else%>
<script src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js" <%=strasync%>></script>
<script<%=strasync%>>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', '<%=kod%>', '<%=replace(replace(site,"http://www.",""),"/","")%>');
    ga('send', 'pageview');

    </script>
    <%end if
End Sub %>
    <% Sub googletagmanager(kod,site,tur)
if kod="" or kod="-" or isNull(kod) then
else
        if tur="1" then%>
    <!-- Google Tag Manager -->
    <script>
        (function(w, d, s, l, i) {
            w[l] = w[l] || [];
            w[l].push({
                'gtm.start': new Date().getTime(),
                event: 'gtm.js'
            });
            var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s),
                dl = l != 'dataLayer' ? '&l=' + l : '';
            j.async = true;
            j.src =
                'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
            f.parentNode.insertBefore(j, f);
        })(window, document, 'script', 'dataLayer', '<%=kod%>');
    </script>
    <!-- End Google Tag Manager -->
    <%else %>
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=<%=kod%>" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
    <%end if
    end if
End Sub %>
    <% Sub zopimkod(zopim,site)  
if zopim="" or zopim="-" or isNull(zopim) then
else%>
    <!--Start of Zopim Live Chat Script-->
    <script type="text/javascript" <%=strasync%>>
        window.$zopim || (function(d, s) {
            var z = $zopim = function(c) {
                    z._.push(c)
                },
                $ = z.s =
                d.createElement(s),
                e = d.getElementsByTagName(s)[0];
            z.set = function(o) {
                z.set.
                _.push(o)
            };
            z._ = [];
            z.set._ = [];
            $.async = !0;
            $.setAttribute('charset', 'utf-8');
            $.src = '//v2.zopim.com/?<%=zopim%>';
            z.t = +new Date;
            $.
            type = 'text/javascript';
            e.parentNode.insertBefore($, e)
        })(document, 'script');
    </script>
    <!--End of Zopim Live Chat Script-->
    <%end if
End Sub %>
    <% Sub facemessenger(fmcode,site)  
if fmcode="" or fmcode="-" or isNull(fmcode) then
else
    if instr(fmcode,",") then
    fmcode1=split(fmcode,",")(0)
    theme_color=split(fmcode,",")(1)
    messege=split(fmcode,",")(2)
    else    
    fmcode1=fmcode
    theme_color="#325286"
    messege="Merhaba! size nasıl yardımcı olabiliriz?"
    end if%>

    <!-- Load Facebook SDK for JavaScript -->
    <div id="fb-root"></div>
    <script>
        window.fbAsyncInit = function() {
            FB.init({
                xfbml: true,
                version: 'v5.0'
            });
        };

        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s);
            js.id = id;
            js.src = 'https://connect.facebook.net/tr_TR/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>

    <!-- Your customer chat code -->
    <div class="fb-customerchat" attribution="setup_tool" page_id="<%=fmcode1 %>" theme_color="<%=theme_color %>" logged_in_greeting="<%=messege %>" logged_out_greeting="<%=messege %>"></div>
    <%end if
End Sub %>
    <% Sub harita(haid,i1ayar3,koor,ayar1) 
		paid=haid
		csstip=paid
		%>
    <script src="https://maps.google.com/maps?file=api&amp;v=2.x&amp;key=AIzaSyDcce3b9WW1-rvcBaekQf4DpmBXoIb5Bj4" type="text/javascript" <%=strasync%>></script>
    <style type="text/css">
        @import url("//www.google.com/uds/css/gsearch.css");
        @import url("//www.google.com/uds/solutions/localsearch/gmlocalsearch.css");
    </style>
    <script src="https://www.google.com/uds/api?file=uds.js&amp;v=1.0" type="text/javascript" <%=strasync%>></script>
    <script src="https://www.google.com/uds/solutions/localsearch/gmlocalsearch.js" type="text/javascript" <%=strasync%>></script>

    <body onLoad="initialize()" onUnload="GUnload()">
        <script type="text/javascript" <%=strasync%>>
            function initialize() {
                var map = new GMap(document.getElementById("map"));

                if (GBrowserIsCompatible()) {
                    function createMarker(point, html) {
                        var icon = new GIcon(G_DEFAULT_ICON);
                        icon.image = "<%=imgtemp%>3/282201746487.PNG";
                        //icon.shadow = "<'%=imgyol%>temp/3/272201742004.png";
                        //icon.printImage = "print image";
                        //icon.printShadow = "print shadow";
                        icon.transparent = "";
                        icon.iconSize = new GSize(36, 45);
                        icon.shadowSize = new GSize(30, 25);
                        icon.iconAnchor = new GPoint(8, 25);
                        icon.infoWindowAnchor = new GPoint(8, 0);
                        icon.imageMap = [0, 0, 17, 0, 17, 25, 0, 25];

                        var marker = new GMarker(point, icon);
                        GEvent.addListener(marker, "click", function() {
                            marker.openInfoWindowHtml(html);
                        });

                        return marker;
                    }

                    map.setCenter(new GLatLng( < %= i4 % > 37.582874, 36.873518), 13); <
                    %
                    set mmmYardimci = Con.Execute("select * from yazilar where kategori = '" & paid & "' order by id")
                    if mmmYardimci.eof then
                    set mmmGenel = Con.Execute("SELECT * from kategoriyazi,yazilar where anasek = '" & paid & "' and kategori = kategoriyazi.id")
                    else
                        set mmmGenel = Con.Execute("select * from yazilar where kategori = '" & paid & "' order by id")
                    end
                    if
                    close(mmmYardimci)

                    Do While Not mmmGenel.EOF
                    ihar = ihar + 1
                    baslikisimm = dilyazib(mmmGenel("id"), mmmGenel("yazib"), lang)
                    strbilgi1 = mmmGenel("bilgi1")
                    strbilgi2 = mmmGenel("bilgi2") %
                        >
                        var konum < %= ihar % > = new GLatLng( < %= strbilgi2 % > );
                    var isaret < %= ihar % > = createMarker(konum < %= ihar % > , '<div style="width:190px; color: #000;"><b><%=baslikisimm%></b><br><br><%=strbilgi1%></div>');
                    map.addOverlay(isaret < %= ihar % > );
                    //GEvent.trigger(isaret1, 'click');
                    <
                    % mmmGenel.movenext
                    loop
                    close(mmmGenel) %
                        >

                }

                map.enableContinuousZoom();
                map.enableDoubleClickZoom();
                map.addControl(new GOverviewMapControl());
                map.addControl(new GScaleControl());
                map.addControl(new GLargeMapControl());
                map.addControl(new GMapTypeControl());
                map.setMapType(G_NORMAL_MAP);
            }
        </script>
        <div class="mapscontainer">
            <div class="maptitle"><%=ayar1%></div>
            <div id="map" class="maps"></div>
        </div>
        <%
		
  ' <div class="altbaslik"><%=kateisim%'></div>Call listeleme(turu,adet,en,c1renk,c1en,c2renk,c2en,sid,boy1,suo,sauo,sao,saao,cliste,cliste1,adresd,id)%>
        <% End Sub
		sub sayfala(sayfa,git,KayitSayisi,toplam5)
	  sayfa=sayfa%>
        <div class="col">
            <ul class="pagination">
                <%If CInt(toplam5) > CInt(KayitSayisi) Then
intSayfaSayisix = (CInt(toplam5) / CInt(KayitSayisi))
if Cint(intSayfaSayisix) < intSayfaSayisix then
intSayfaSayisi = CInt(intSayfaSayisix) + 1
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
                <li class="page-item"><a href="<%=sayfa%>&git=1" class="page-link" title="<%=esser("s","İlk Sayfa") %>" aria-label="First">&laquo;&laquo;</a></li>
                <li class="page-item"><a href="<%=sayfa%>&git=<%=round(git-1)%>" class="page-link" title="<%=esser("s","&Ouml;nceki Sayfa") %>" aria-label="Previous">&laquo;</a></li>
                <%
End If
%>
                <%
For isayfa = 1 to intSolGrupSayisi
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li class=""page-item"">"
End If%>
                <a href="<%=sayfa%>&git=<%=round(isayfa,0)%>" class="page-link" title="<%=round(isayfa,0)%>. <%=esser("s","Sayfa") %>" <%=renk%>>
                    <%
%>
<%=round(isayfa,0)%></a>
                </li>
                <%Next
%>
                <%
If (intSayfaAltSiniri - intSolGrupSayisi >1 ) Then Response.Write "<li class=""page-item""><a class=""page-link""><b>. . .</b></a></li>"
%>
                <%
For isayfa = intSayfaAltSiniri to intSayfaUstSiniri
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li class=""page-item"">"
End If
    If intSolGrupSayisi<2 Then
    strhrefi="#"
    else
    strhrefi=sayfa&"&git="&round(isayfa,0)
    end if
    %>
                <a href="<%=strhrefi%>" class="page-link" title="<%=round(isayfa,0)%>. <%=esser("s","Sayfa") %>" <%=renk%>> <%=round(isayfa,0)%></a>
                </li>
                <%Next
%>
                <%
If (intSagAltSinir - intSayfaUstSiniri >1) Then Response.Write "<li class=""page-item""><a class=""page-link""><b>. . .</b></a></li>"
%>
                <%
For isayfa = intSagAltSinir to intSayfaSayisi
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
Response.Write " <li "&renk&">"
Else 
renk=""
Response.Write " <li class=""page-item"">"
End If %>
                <a href="<%=sayfa%>&git=<%=round(isayfa,0)%>" class="page-link" title="<%=round(isayfa,0)%>. <%=esser("s","Sayfa") %>"> <%=round(isayfa,0)%></a>
                </li>
                <%Next
%>
                <%
If CInt(git) <>CInt(intSayfaSayisi) Then %>
                <li class="page-item"><a href="<%=sayfa%>&git=<%=round(git+1,0)%>" class="page-link" title="Sonraki <%=esser("s","Sonraki Sayfa") %>" aria-label="Next">&raquo;</a></li>
                <li class="page-item"> <a href="<%=sayfa%>&git=<%=round(intSayfaSayisi,0)%>" class="page-link" title=" <%=esser("s","Son Sayfa") %>" aria-label="Last">&raquo;&raquo;</a></li>
                <%
End If%>
                <li class="page-item"><a class="page-link"><%=esser("s","Sayfa") %> : <b><%=git%></b></a></li>
                <li class="page-item kayitsayisi"><a class="page-link"> <%=toplam5%> <%=esser("s","Kayıt") %>.</a></li>
            </ul>
        </div>
        <%end sub%>
        <%function pagination(sayfa,git,KayitSayisi,toplam5)
	  sayfa=sayfa
	  pagination="<div class=""col""><ul class=""pagination"">"
If CInt(toplam5) > CInt(KayitSayisi) Then
intSayfaSayisix = (CInt(toplam5) / CInt(KayitSayisi))
if Cint(intSayfaSayisix) < intSayfaSayisix then
intSayfaSayisi = CInt(intSayfaSayisix) + 1
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

If intSolGrupSayisi >= intSayfaAltSiniri Then intSolGrupSayisi = intSayfaAltSiniri - 1
If intSagAltSinir <= intSayfaUstSiniri Then intSagAltSinir = intSayfaUstSiniri + 1

If git >1 Then
pagination=pagination&"<li class=""page-item""><a href="""&sayfa&"&git=1"" class=""page-link"" title="""&esser("s","İlk Sayfa") &""" aria-label=""First"">&laquo;&laquo;</a></li>"
pagination=pagination&"<li class=""page-item""><a href="""&sayfa&"&git="&round(git-1)&""" class=""page-link"" title="""&esser("s","&Ouml;nceki Sayfa") &""" aria-label=""Previous"">&laquo;</a></li>"

End If

For isayfa = 1 to intSolGrupSayisi
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
pagination=pagination&" <li "&renk&">"
Else 
renk=""
pagination=pagination&"<li class=""page-item"">"
End If
pagination=pagination&"<a href="""&sayfa&"&git="&round(isayfa,0)&""" class=""page-link"" title="""&round(isayfa,0)&". "&esser("s","Sayfa") &""""&renk&">"&round(isayfa,0)&"</a></li>"

Next
If (intSayfaAltSiniri - intSolGrupSayisi >1 ) Then pagination=pagination&"<li class=""page-item""><a class=""page-link""><b>. . .</b></a></li>"

For isayfa = intSayfaAltSiniri to intSayfaUstSiniri
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
pagination=pagination&" <li "&renk&">"
Else 
renk=""
pagination=pagination&" <li class=""page-item"">"
End If 
    If git=round(isayfa,0) Then
    strhrefi="#"
    else
    strhrefi=sayfa&"&git="&round(isayfa,0)
    end if
pagination=pagination&"<a href="""&strhrefi&""" class=""page-link"" title="""&round(isayfa,0)&". "&esser("s","Sayfa") &""""&renk&"> "&round(isayfa,0)&"</a></li>"
Next

If (intSagAltSinir - intSayfaUstSiniri >1) Then pagination=pagination&"<li class=""page-item""><a class=""page-link""><b>. . .</b></a></li>"

For isayfa = intSagAltSinir to intSayfaSayisi
If CInt(isayfa) = CInt(git) Then
renk=" class=""page-item active"""
pagination=pagination&" <li "&renk&">"
Else 
renk=""
pagination=pagination&"<li class=""page-item"">"
End If 
pagination=pagination&"<a href="""&sayfa&"&git="&round(isayfa,0)&""" class=""page-link"" title="""&round(isayfa,0)&". "&esser("s","Sayfa") &"""> "&round(isayfa,0)&"</a></li>"
Next

If CInt(git) <>CInt(intSayfaSayisi) Then 
pagination=pagination&"<li class=""page-item""><a href="""&sayfa&"&git="&round(git+1,0)&""" class=""page-link"" title="""&esser("s","Sonraki Sayfa") &""" aria-label=""Next"">&raquo;</a></li>"
pagination=pagination&"<li class=""page-item""> <a href="""&sayfa&"&git="&round(intSayfaSayisi,0)&""" class=""page-link"" title="""&esser("s","Son Sayfa") &""" aria-label=""Last"">&raquo;&raquo;</a></li>"

End If
pagination=pagination&"<li class=""page-item""><a class=""page-link"">"&esser("s","Sayfa") &" : <b>"&git&"</b></a></li>"
pagination=pagination&"<li class=""page-item kayitsayisi""><a class=""page-link""> "&toplam5&" "&esser("s","Kayıt") &".</a></li></ul></div>"
end function
            %>
        <% 
Sub sayfaayar(sayfaid,deger1,deger2)
response.Write(okunma)
response.Write(sosyal1)
response.Write(sosyal2)
response.Write(fyorum)
response.Write(syorum)
response.Write(sekle)
response.Write(digerh)
response.Write(baslikd)
 set mmmYardimci = Con.Execute ( "select * from kategoriyazi where id="&sayfaid&" and durum = '1' ")
	 if mmmYardimci.eof then
else

okunma=mmmYardimci("okusayi")
sosyal1=mmmYardimci("sosyal1")
sosyal2=mmmYardimci("sosyal2")
fyorum=mmmYardimci("facebookyorum")
syorum=mmmYardimci("yorum")
sekle=mmmYardimci("sitenekle")
baslikd=mmmYardimci("baslikd")

end if
close(mmmYardimci)	

End Sub %>
        <%Sub baslik(ldh1,ldh2)%>
        <div class="baslikback">
            <div class="basliklar"><%=heading_banner%></div>
        </div>
        <%end sub%>
        <%Sub sifrelisayfa(ldh1,ldh2,ldh3)%>
        <div class="sifresana my-5">
            <%if Submit="sifregiris" then%>
            <div class="sifreshata"><%=session("hatamesaj")%></div>
            <%else
  end if%>
            <form action="?a=1&islem=sifregiris" method="post" class="contact-form-no custom-form-style-1">
                <div class="form-row">
                    <div class="form-group col">
                        <input type="password" value="" data-msg-required="<%=esser(5,"Lütfen Şifrenizi Yazınız.")%>" maxlength="100" class="form-control" name="sifre" placeholder="<%=esser(5,"Şifre")%>" required="">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <button name="gonder" type="submit" class="btn btn-success" data-loading-text="Loading..."><%=esser("s","Giriş Yap")%>
                        </button>
                    </div>
                </div>

            </form>
        </div>
        <%end sub%>
        <%
function yanliste(yaziid,ayar,ayar1,ayar2,ayar3)
ayarc=ayar   
    if ayar3="kate" or ayar3="kate1" then
    if ayar3="kate1" then
    ilkgosters=""
    else
    ilkgosters=" and menugosterim='1'"
    end if
    ayar3="kate"
    end if
    if ayar3="yazi" or ayar3="yazi1" then
    if ayar3="yazi1" then
    ilkgoster=""
    else
    ilkgoster=" and ilksayfa='1'"
    end if
    ayar3="yazi"
    end if
'Call kategoriayar(yaziid,ayar,kayar3)
    if ayar2="ana" then
    csstip=""
    else
if ayar2="" then
			csstip=yaziid&""&ayar
			else
			csstip=ayar2&""&ayar2
			end if
    end if
    sqlstring="select * from kategoriayar where id="&ayar&" ORDER BY id"
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
     if colmdstr="4" then
    colmdstrxs=" col-sm-6 col-xs-4"
    elseif colmdstr="3" then
    colmdstrxs=" col-sm-6 col-xs-4"
    elseif colmdstr="6" then
    colmdstrxs=" col-sm-4 col-xs-4"
    elseif colmdstr="2" then
    colmdstrxs="  col-sm-4 col-xs-4"
    else
    colmdstrxs=" col-xs-6"
    end if
			if i1="slider-nav" then
        yanliste=yanliste&"<div class=""slider sf-mode"&sstip&" slider-for"&csstip&""">"
				  yanliste=yanliste&"<div><h3>1</h3></div>"
					yanliste=yanliste&"<div><h3>2</h3></div>"
					yanliste=yanliste&"<div><h3>3</h3></div>"
					yanliste=yanliste&"<div><h3>4</h3></div>"
					yanliste=yanliste&"<div><h3>5</h3></div>"
				yanliste=yanliste&"</div>"
                else
                end if
    if strmsmodulid=90 then
    bilgi1="9999"
    end if
if request.QueryString("aramagoster")="1" and (ayar3="kate" or ayar3="") then				
csstip=""
ayar3="yazi"

    sqlstring="select * from yazilar where (yazi like '%"&aramastr&"%' or yazib like '%"&aramastr&"%' or bilgi3 like '%"&aramastr&"%') and durum='1' and modulmu='0' order by sira, id desc"
set mmmSayfa2 = Con.Execute (sqlstring)
     lojik5=con.execute("select count(id) as toplam5 from yazilar where (yazi like '%"&aramastr&"%' or yazib like '%"&aramastr&"%' or bilgi3 like '%"&aramastr&"%') and durum='1' and modulmu='0'")
toplam5=lojik5("toplam5")
else
if ayar3="resim" then
    sqlstring="SELECT * from resimd where baslik = '"&yaziid&"' and type<>'1' order by firma limit "&bilgi1&""
set mmmSayfa2 = Con.Execute (sqlstring)
elseif ayar3="yazi" then
    sqlstring="SELECT * from kategoriyazi,yazilar where (anasek in (SELECT id from kategoriyazi where anasek = '"&yaziid&"' and kategoriyazi.durum='1') or anasek = '"&yaziid&"' or kategoriyazi.id = '"&yaziid&"') and kategori = kategoriyazi.id"&ilkgoster&" and yazilar.durum='1' and (yazilar.sira1='' or isNull(yazilar.sira1) or instr(yazilar.sira1,'"&lang&"')) order by kategoriyazi.id desc limit "&bilgi1&""
    'yazilar.sira, kategoriyazi.sira, 
     lojik5=con.execute("select count(yazilar.id) as toplam5 from kategoriyazi,yazilar where (anasek in (SELECT id from kategoriyazi where anasek = '"&yaziid&"' and kategoriyazi.durum='1') or anasek = '"&yaziid&"' or kategoriyazi.id = '"&yaziid&"') and kategori = kategoriyazi.id"&ilkgoster&" and yazilar.durum='1' and (yazilar.sira1='' or isNull(yazilar.sira1) or instr(yazilar.sira1,'"&lang&"'))")
toplam5=lojik5("toplam5")
set mmmSayfa2 = Con.Execute (sqlstring)
     'lojik5=con.execute("select count(yazilar.id) as toplam5 from kategoriyazi,yazilar where (anasek in (SELECT id from kategoriyazi where anasek = '"&yaziid&"' and kategoriyazi.durum='1') or anasek = '"&yaziid&"' or kategoriyazi.id = '"&yaziid&"') and kategori = kategoriyazi.id"&ilkgoster&" and yazilar.durum='1'")
'toplam5=lojik5("toplam5")
elseif ayar3="kate" then
    sqlstring="SELECT * from kategoriyazi where anasek = '"&yaziid&"' and durum='1'"&ilkgosters&" order by sira limit "&bilgi1&""
set mmmSayfa2 = Con.Execute (sqlstring)
     lojik5=con.execute("select count(id) as toplam5 from kategoriyazi where anasek = '"&yaziid&"' and durum='1'"&ilkgosters&"")
toplam5=lojik5("toplam5")
else
    sqlstring="SELECT * from kategoriyazi,yazilar where (anasek in (SELECT id from kategoriyazi where anasek = '"&yaziid&"' and kategoriyazi.durum='1') or anasek = '"&yaziid&"' or kategoriyazi.id = '"&yaziid&"') and kategori = kategoriyazi.id"&ilkgoster&" and yazilar.durum='1' order by kategoriyazi.id desc limit "&bilgi1&""
    'yazilar.sira, kategoriyazi.sira, 
    lojik5=con.execute("select count(yazilar.id) as toplam5 from kategoriyazi,yazilar where (anasek in (SELECT id from kategoriyazi where anasek = '"&yaziid&"' and kategoriyazi.durum='1') or anasek = '"&yaziid&"' or kategoriyazi.id = '"&yaziid&"') and kategori = kategoriyazi.id"&ilkgoster&" and yazilar.durum='1'")

set mmmSayfa2 = Con.Execute (sqlstring)
toplam5=lojik5("toplam5")
end if
end if
    'response.Write sqlstring

    If CInt(toplam5) > CInt(KayitSayisi) Then
intSayfaSayisix = (CInt(toplam5) / CInt(KayitSayisi))
if Cint(intSayfaSayisix) < intSayfaSayisix then
intSayfaSayisi = CInt(intSayfaSayisix) + 1
else
intSayfaSayisi = round(intSayfaSayisix,0)
end if
else
intSayfaSayisi = 1
End If
    'response.Write sqlstring&""&ayar3
if mmmSayfa2.eof then
    if request.QueryString("aramagoster")="1" then		
     response.Write " <div>İçerik Bulunmuyor..</div>"
    else
    end if
      else
if len(i1)>20 then
		'yanliste=yanliste&"<div class=""fullsection""><div class=""slider s-mode"&csstip&""">"
		else
		'yanliste=yanliste&"<div class=""fullsection""><div class=""baslik"&csstip&"""><h3>"&ayar1&"</h3></div>"
'yanliste=yanliste&"<div class="""&i1&""&csstip&" slider s-mode"&csstip&" lazy"">"
    	

end if
     if request.QueryString("ajaxload")<>"1" then
    if instr(i3,"#repeatlist#") then

    if Instr(i3,""&rsablonstr&"#esser(") then
dvadet=ubound(split(i3,""&rsablonstr&"#esser("))
for dv=1 to dvadet
if Instr(i3,""&rsablonstr&"#esser(") then
dilveri=split(split(i3,""&rsablonstr&"#esser(")(1),")#"&rsablonstri&"")(0)
dilveri1=split(dilveri,",")(0)
dilveri2=split(dilveri,",")(1)
i3 = Replace(i3, ""&rsablonstr&"#esser("&dilveri1&","&dilveri2&")#"&rsablonstri&"",esser(dilveri1,dilveri2)) 
else
end if
next
else
end if


yanliste=(split(replace(replace(veriguncelle(i3),"``",""""),"`","'"),"#repeatlist#")(0))
    else
    end if
    end if

   if (i5="" or i5="1" or i5="<p>1") or ((i5="" or i5="1" or i5="<p>1") and ayar3="resim") then
    if ayar3="kate" or ayar3="yazi" or ayar3="resim" then
    baslikivar="<h4 class=""card-title font-weight-bold line-height-3 text-4 mb-0"">#baslikisim#</h4>"
    end if
     yanliste="<div class=""col mt-4"" style=""min-height: 250px;"">"
  yanliste=yanliste&"<div class=""row portfolio-list lightbox"" data-plugin-options=""{'delegate': 'a.lightbox-portfolio', 'type': 'image', 'gallery': {'enabled': true}}"">"
    i5yok="1"
    i5="<div class=""col-6 col-sm-4 col-lg-3 appear-animation"" data-appear-animation=""expandIn"" data-appear-animation-delay=""200"">"&_
          "<div class=""portfolio-item"">"&_
            "<a href=#link# title=""#baslikisim#"">"&_
              "<span class=""thumb-info thumb-info-lighten thumb-info-centered-icons border-radius-0"">"&_
                "<span class=""thumb-info-wrapper border-radius-0"">"&_
                  "<img src=#resimim# class=""img-fluid border-radius-0"" alt=""#baslikisim# #strkategori# img"">"&_
                  "<span class=""thumb-info-action"">"&_
                    "<span class=""thumb-info-action-icon thumb-info-action-icon-light"">"&_
                      "<i class=""fas fa-search text-dark"">"&_
                      "</i>"&_
                    "</span>"&_
                  "</span>"&_
                "</span>"&_
              "</span>"&_
              ""&baslikivar&""&_
            "</a>"&_
          "</div>"&_
        "</div>"
    end if

	 if ayar3="resim" then 
    if instr(yanliste," class=") then
    'yanliste=replace(yanliste," class="""," data-plugin-options=""{'delegate': 'a', 'type': 'image', 'gallery': {'enabled': true}, 'mainClass': 'mfp-with-zoom', 'zoom': {'enabled': true, 'duration': 300}}"" class=""lightbox ")
    else
    'yanliste=replace(yanliste," class="""," data-plugin-options=""{'delegate': 'a', 'type': 'image', 'gallery': {'enabled': true}, 'mainClass': 'mfp-with-zoom', 'zoom': {'enabled': true, 'duration': 300}}"" class=""lightbox""")
    end if
    end if

	  Do While Not mmmSayfa2.EOF
	  if ayar3="" or isNull(ayar3) or i2="0" or i2="" then
      colmdstyle=" class=""slick-slide col-md-"&colmdstr&""&colmdstrxs&""""
      i1=""
      else
      end if
      'Resim Başlangıç
	 if ayar3="resim" then 
	 strfidyan=mmmSayfa2("fid")
	  strlinkyan=mmmSayfa2("link")
	 ' strtarget=mmmSayfa2("target")
    if strtarget="" then
    strtarget=""
    else
    strtarget=" target="""&strtarget&""""
    end if
set mmmYardimci1 = Con.Execute ("select * from resimd where fid="&strfidyan&" order by fid")
if mmmYardimci1.eof then
resimim=imgyol&"temp/resimyok.jpg"
en1=en+en/2
boy=en
else
resimim=imgyol&""&mmmYardimci1("dosyad")
rid=mmmYardimci1("fid")
stryazibyan=mmmYardimci1("resad")
resacik=mmmYardimci1("acik")
end if
close(mmmYardimci1)
if isNull(strlinkyan) or strlinkyan="" then
linkyl=""""&resimim&""" class=""lightbox-portfolio"" data-toggle=""lightbox"" data-gallery=""multiimages"&yaziid&""" data-title="""&resadd&""""
else
linkyl=""&strlinkyan&""""&strtarget&""
end if
    %>
        <%
'Yazı Başlangıç
elseif ayar3="yazi" or ayar3="0" or ayar3="" or isNull(ayar3) then
	  strlinkyan=mmmSayfa2("link")
	  stridyan=mmmSayfa2("id")
	  stryazibyan=mmmSayfa2("yazib")
	  straciklama=mmmSayfa2("yazi")
	  strkategori=mmmSayfa2("kategori")
	  strozet=mmmSayfa2("descri")
	  strtarih=mmmSayfa2("tarih")
	  strgtarih=mmmSayfa2("gtarih")
	  strseoyan=mmmSayfa2("seolink")
	  strbelgeyan=mmmSayfa2("form")
	  strurunidyan=mmmSayfa2("urunid")
	  strtarget=mmmSayfa2("target")
    if strtarget="" then
    strtarget=""
    else
    strtarget=" target="""&strtarget&""""
    end if
str_bilgi3=mmmSayfa2("bilgi3")
		sqlString = "select * from ozellikler2 where kateid='"&stridyan&"' and ozelikid = '1'"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
formid="1"
else
formid=mmmYardimci1("formid")
formidtur=mmmYardimci1("tur")
end if
close(mmmYardimci1)
set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where id="&strkategori&"")
if mmmYardimci1.eof then
else
aidyazi=mmmYardimci1("anasek")
aidyaziisim=dilkate(mmmYardimci1("id"),mmmYardimci1("isim"),request.cookies("remember_dil"))
end if
close(mmmYardimci1)
    if mmmSayfa2("admin")="" or isNull(mmmSayfa2("admin")) then
        stradmin="0"
        else
        stradmin=mmmSayfa2("admin")
        end if
set mmmYardimci1 = Con.Execute ("select id,adsoyad from yonetici where id="&stradmin&"")
if mmmYardimci1.eof then
else
adminid=mmmYardimci1("id")
adminisim=mmmYardimci1("adsoyad")
end if
close(mmmYardimci1)

set mmmYardimci1 = Con.Execute ("select * from resimd where baslik='"&stridyan&"' order by tur desc")
if mmmYardimci1.eof then
resimim=imgyol&"temp/resimyok.jpg"
en1=en+en/2
boy=en
else
resimim=imgyol&""&mmmYardimci1("dosyad")
end if
close(mmmYardimci1)
stryazibyan=dilyazib(stridyan,stryazibyan,lang)
'strozet=dilyazibi(stridyan,strozet,lang)
strozet=dilicerikcek(stridyan,strozet,lang,"descri","1")
baslikadd1=seolarlink(stridyan,"yazi",lang)
if strurunidyan="5" then
strbelgeyan1=strbelgeyan
did=EmailDuzelt(strbelgeyan)
midd=stridyan
					ad=stryazibyan
				belge=strbelgeyan1
					resimim="http://i2.ytimg.com/vi/"&did&"/hqdefault.jpg"
					linkyl=""&belge&""" data-toggle=""lightbox"" data-gallery=""multiimages"&stridyan&""" data-title="""&ad&""""
else
if isNull(strlinkyan) or strlinkyan="" or strlinkyan="0" then
linkyl="/"&baslikadd1&""
else
linkyl=""&strlinkyan&""""&strtarget&""
end if
end if

    %>
        <%
'Sayfa Başlangıç
elseif ayar3="kate" then
	  strlinkyan=mmmSayfa2("link")
	  stridyan=mmmSayfa2("id")
	  strisimyan=mmmSayfa2("isim")
	  stryazibyan=strisimyan
	  strseoyan=mmmSayfa2("seolink")
	  strtarget=mmmSayfa2("target")
    strozet=""
	  
set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where id="&yaziid&"")
if mmmYardimci1.eof then
    aidyaziisim=""
else
aidyazi=mmmYardimci1("anasek")
aidyaziisim=dilkate(mmmYardimci1("id"),mmmYardimci1("isim"),lang)
end if
close(mmmYardimci1)
set mmmYardimci1 = Con.Execute ("select * from resimd where baslik='"&stridyan&"' order by fid")
if mmmYardimci1.eof then
resimim=imgyol&"temp/resimyok.jpg"
en1=en+en/2
boy=en
else
resimim=imgyol&""&mmmYardimci1("dosyad")
end if
close(mmmYardimci1)
stryazibyan=dilkate(stridyan,strisimyan,lang)
menuisimalt1=seokate(stridyan,strseoyan,lang)
    if lang="" or isNull(lang) then
    lang=request.cookies("remember_dil")
    end if

    seolarlinki=seolarlink(stridyan,"sayfa",lang)
		
if isNull(strlinkyan) or strlinkyan="" or strlinkyan="0" then
linkyl=""&siteadres&""&seolarlinki&""
else
linkyl=strlinkyan&""" target="""&strtarget&""
end if
	
else

end if

SetLocale ceviridilekaktif
Verii5=hdrcntrplc(i5,contentspath,cloudpath,versionjscss)
'Verii5=replace(i5,"/`","\'")&""
'Verii5=replace(i5,"`","'")&""
'Verii5=replace(i5,"/'","\'")&""
 '   response.Write Verii5&"<br>"
Verii5 = Replace(Verii5, ""&rsablonstr&"#csstip#"&rsablonstr&"", csstip)
Verii5 = Replace(Verii5, ""&rsablonstr&"#colmdstr#"&rsablonstr&"", colmdstr&""&colmdstrxs)
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim#"&rsablonstr&"", ""&resimim&"")
Verii5 = Replace(Verii5, ""&rsablonstr&"#resimim1#"&rsablonstr&"", "("&resimim&")")
Verii5 = Replace(Verii5, ""&rsablonstr&"#baslikid#"&rsablonstr&"", stridyan)
Verii5 = Replace(Verii5, ""&rsablonstr&"#baslikisim#"&rsablonstr&"", stryazibyan)
Verii5 = Replace(Verii5, ""&rsablonstr&"#strozet#"&rsablonstr&"", strozet&" ")
Verii5 = Replace(Verii5, ""&rsablonstr&"#straciklama#"&rsablonstr&"", straciklama&" ")
Verii5 = Replace(Verii5, ""&rsablonstr&"#strkategori#"&rsablonstr&"", aidyaziisim)
Verii5 = Replace(Verii5, ""&rsablonstr&"#stradmin#"&rsablonstr&"", adminisim)
Verii5 = Replace(Verii5, ""&rsablonstr&"#strtarih#"&rsablonstr&"", strtarih)
Verii5 = Replace(Verii5, ""&rsablonstr&"#strtarihday#"&rsablonstr&"", day(strtarih))
Verii5 = Replace(Verii5, ""&rsablonstr&"#strtarihmonth#"&rsablonstr&"", month(strtarih))
Verii5 = Replace(Verii5, ""&rsablonstr&"#strtarihmonthname#"&rsablonstr&"", MonthName(month(strtarih),True))
Verii5 = Replace(Verii5, ""&rsablonstr&"#strtarihyear#"&rsablonstr&"", year(strtarih))
Verii5 = Replace(Verii5, ""&rsablonstr&"#strgtarih#"&rsablonstr&"", strgtarih)
Verii5 = Replace(Verii5, ""&rsablonstr&"#str_bilgi3#"&rsablonstr&"", str_fi)
Verii5 = Replace(Verii5, ""&rsablonstr&"#link#"&rsablonstr&"", linkyl)
Veri2 = Replace(Veri2, ""&rsablonstr&"#kayitsayisi#"&rsablonstri&"",""&intSayfaSayisi&"")
    
    if cdnstatu="1" then
    if instr(Verii5,"""/contents/img/") then
Verii5 = Replace(Verii5, """/contents/img/",""""&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    else
Verii5 = Replace(Verii5, "=/contents/img/","="&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
Verii5 = Replace(Verii5, "(/contents/img/","("&cdnimgfldr&""&cdnsitefolder&"/contents/img/")
    end if
    end if
if Instr(Verii5, ""&rsablonstr&"#ozellikcek(") then
ocadet=ubound(split(Verii5, ""&rsablonstr&"#ozellikcek("))
for oca=1 to ocadet
strocv=split(split(Verii5, ""&rsablonstr&"#ozellikcek(")(1),")#"&rsablonstr&"")(0)

ocvadet=ubound(split(strocv,","))
if ocvadet<3 then
else
gorozel=split(strocv,",")(1)
csstip=split(strocv,",")(3)
Verii5 = Replace(Verii5, ""&rsablonstr&"#ozellikcek("&rsablonstr&"#formid#"&rsablonstri&","&gorozel&","&rsablonstr&"#formidtur#"&rsablonstri&","&csstip&")#"&rsablonstr&"",ozellikcek(formid,gorozel,formidtur,csstip))
end if
next
else
end if
    if Instr(Verii5,""&rsablonstr&"#esser(") then
dvadet=ubound(split(Verii5,""&rsablonstr&"#esser("))
for dv=1 to dvadet
if Instr(Verii5,""&rsablonstr&"#esser(") then
dilveri=split(split(Verii5,""&rsablonstr&"#esser(")(1),")#"&rsablonstri&"")(0)
dilveri1=split(dilveri,",")(0)
dilveri2=split(dilveri,",")(1)
Verii5 = Replace(Verii5, ""&rsablonstr&"#esser("&dilveri1&","&dilveri2&")#"&rsablonstri&"",esser(dilveri1,dilveri2)) 
else
end if
next
else
end if

if Instr(Verii5,""&rsablonstr&"#hesapla(") then
ocadet=ubound(split(Verii5,""&rsablonstr&"#hesapla("))
for oca=1 to ocadet
strocv=split(split(Verii5,""&rsablonstr&"#hesapla(")(1),")#"&rsablonstr&"")(0)
ocvadet=ubound(split(strocv,","))
if ocvadet<2 then
else
value1=split(strocv,",")(0)
islemi=split(strocv,",")(1)
value2=split(strocv,",")(2)
if isNumeric(value1)=false or isNumeric(value2)=false then
valuem="0"
else
if islemi="%" then
valuem=round(((cint(value1)-cint(value2))/cint(value1))*100,0)
else
end if
end if
Verii5 = Replace(Verii5, ""&rsablonstr&"#hesapla("&value1&","&islemi&","&value2&")#"&rsablonstr&"",valuem)
end if
next
else
end if
listelemegetir=Verii5
'yanliste=yanliste&"<div"&colmdstyle&">"

yanliste=yanliste&""&listelemegetir

	  str_fi=""
      mmmSayfa2.MoveNext
  loop
  ' yanliste=yanliste&"</div></div><div style=""clear:both; float:none;""></div>"
    	 if i5yok="1" then
             yanliste=yanliste&"</div></div>"
         end if

    if request.QueryString("ajaxload")<>"1" then
    if instr(i3,"#repeatlist#") then

yanliste=yanliste&(split(replace(replace(replace(i3,"``",""""),"`","'"),"#kayitsayisi#",intSayfaSayisi),"#repeatlist#")(1))
'yanliste=yanliste&(split(replace(replace(i3,"``",""""),"`","'"),"#repeatlist#")(1))
   ' if (ayar3="kate" or ayar3="yazi") and (bilgi1="" or bilgi1="0") then
   ' yanliste=yanliste&pagination(sayfa,git,KayitSayisi,toplam5)
   ' end if
    else
    end if
    end if
	  
  end if
  close(mmmSayfa2)
    
end function
						   
	 sub tamicerik(yaziid,ayar,ayar1,ayar2)
	
			csstip=yaziid&""&ayar
set mmmSayfa2 = Con.Execute ("SELECT * from yazilar where id ="&yaziid&" and durum='1' order by id desc")
if mmmSayfa2.eof then
else
icerikid=mmmSayfa2("id")
if mmmSayfa2("urunid")="3" then
htmlresim="<div class=""htmlicerikresim"&csstip&""">"
  set mmmSayfa3 = Con.Execute ("select * from resimd where baslik='"&icerikid&"' order by firma, fid")

Do While Not mmmSayfa3.EOF
resimisimm=mmmSayfa3("resad")
rid=mmmSayfa3("fid")
ridlink=mmmSayfa3("link")
resimim=imggaleriyol&""&mmmSayfa3("resimid")
'style=""background-image:url("&resimim&");""
htmlresim=htmlresim&"<a href="""&linkyl&""" target=""_blank""  title="""&resimisimm&"""><div class=""resimhtml"" ><img src="""&resimim&""" style=""width:100%; margin:5px 0px;""></div></a>"
mmmSayfa3.movenext
			loop  				
			close(mmmSayfa3)
			htmlresim=htmlresim&"</div>"
			response.Write(htmlresim)
			else
			end if
icisim=dilyazib(mmmSayfa2("id"),mmmSayfa2("yazib"),lang)
icyazi=dilyazi(mmmSayfa2("id"),mmmSayfa2("yazi"),lang)
baslikbilgi=dilyazibi(mmmSayfa2("id"),mmmSayfa2("bilgi1"),lang)
%>
        <%=replace(veriguncelle(icyazi),"-&&-","&#")%>
        <%

end if
close(mmmSayfa2)
end sub

sub filtremenu(yaziid,formid,ayar1,ayar2)
csstip=ayar1&""&ayar1
set mmmYardimci = Con.Execute ("select * from kategoriyazi where id="&aid&"")
seolinkimf=mmmYardimci("seolink")
close(mmmYardimci)%>
        <div class="filtre_menu<%=csstip%>">
            <FORM name="myForm" action="/<%=seolinkimf%>?rinn=web&filtre=1" method="post">
                <%

set mmmYardimci = Con.Execute ("select * from formlar where id="&formid&"")

set mmmYardimci1 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and alt = '1' and gerekli = '1' order by sira")
if mmmYardimci1.eof then%>
                <%else
  Do While Not mmmYardimci1.EOF
  filtname=mmmYardimci1("name")
  formisim=dilformv(mmmYardimci1("id"),mmmYardimci1("isim"),lang)
%>
                <div class="filtre_menu<%=csstip%>_label">
                    <div class="filtre_menu<%=csstip%>_baslik"><%=formisim%></div>
                    <div class="filtre_menu<%=csstip%>_deger">
                        <%if mmmYardimci1("tur")=1 then%>
                        <input type="text" id="<%=filtname%>" name="<%=filtname%>" class="form-control" />
                        <%elseif mmmYardimci1("tur")=2 then%>
                        <input name="<%=filtname%>" type="hidden" value="<%=filtname%>" />
                        <%elseif mmmYardimci1("tur")=3 then%>
                        <textarea name="<%=filtname%>" rows="6" id="<%=filtname%>" class="form-control"></textarea>
                        <%elseif mmmYardimci1("tur")=4 then%>
                        <%
 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci1("id")&"' order by sira")

  Do While Not mmmYardimci2.EOF
   formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
%>
                        <input name="ozellik" type="checkbox" value="<%=formisim%>" class="flatgray" />
                        <%=formisim%>&nbsp;&nbsp;
                        <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
                        <%elseif mmmYardimci1("tur")=5 then%>
                        <%

 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci1("id")&"' order by sira")

Do While Not mmmYardimci2.EOF
formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
%>
                        <input name="ozellik" type="radio" value="<%=formisim%>" class="flatgray" />
                        <%=formisim%>&nbsp;&nbsp;
                        <%			  
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
                        <%elseif mmmYardimci1("tur")=6 then
                        if mmmYardimci1("id")="94" then%>
                        <div id="sonuc" class="fmenujselect">
                            <select id="Select12" size="1" onChange="return kategoriSec()" name="ozellik">
                                <option value=""><%=esser("s","Seçiniz")%></option>
                            </select>
                        </div>
                        <%else%>
                        <div class="fmenujselect">
                            <SELECT id=select4 size=1 name="ozellik" class="form-control">
                                <OPTION value="0"><%=mmmYardimci1("isim")%> Seciniz</OPTION>
                                <%

 set mmmYardimci2 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek='"&mmmYardimci1("id")&"' order by sira")
Do While Not mmmYardimci2.EOF
formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
filtname6=mmmYardimci2("name")
%>
                                <OPTION value="<%=filtname6%>" <%if instr(request("ozellik"),filtname6) then%>selected style="color:#000; background:#F90; font-weight:bold;" <%else%><%end if%>><%=formisim%></OPTION>
                                <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
                            </SELECT>
                        </div>
                        <%END iF%>
                        <%elseif mmmYardimci1("tur")=7 then%>
                        <input name="<%=mmmYardimci1("isim")%>" type="file" size="<%=mmmYardimci1("maxs")%>" class="subfile" />
                        <%else%>
                        <div class="fmenujselect">
                            <SELECT id="Select12" size="1" name="ozellik" onChange="return kategoriSec()" class="form-control">
                                <OPTION value="0"><%=mmmYardimci1("isim")%> Seciniz</OPTION>
                                <%
  set mmmYardimci2 = Con.Execute ("select * from kategoriyazi where anasek='"&mmmYardimci1("tur")&"' order by sira")
Do While Not mmmYardimci2.EOF
formisim=dilformv(mmmYardimci2("id"),mmmYardimci2("isim"),lang)
filtnameid=mmmYardimci2("id")
%>
                                <OPTION value="<%=filtnameid%>" <%if instr(request("ozellik"),filtnameid) then%>selected style="color:#000; background:#F90 !important; font-weight:bold !important;" <%else%><%end if%>><%=formisim%></OPTION>
                                <%
mmmYardimci2.movenext
loop
close(mmmYardimci2)
%>
                            </select>
                        </div>
                        <SCRIPT type=text/javascript> // Internet Explorer (5.0+) try { http=new ActiveXObject("Msxml2.XMLHTTP"); // yeni versiyon xmlhttp } catch (e) { try { http=new ActiveXObject("Microsoft.XMLHTTP"); // eski versiyon xmlhttp } catch (e) { http=false; } } // Mozilla ve Safari if ( !http && typeof XMLHttpRequest !='undefined' ) { try{ http=new XMLHttpRequest(); }catch(e) { http=false; } } // Diger if ( !http && window.createRequest ) { try{ http=window.createRequest(); }catch(e) { http=false; } } function kategoriSec() { var kategori=document.getElementById('Select12').value; if(kategori!=0) { http.open('get', '/yonetici/sehirsec.asp?Kategori=' + kategori); http.onreadystatechange=function() { document.getElementById('sonuc').innerHTML="Bekleyiniz..." ; if (http.readyState==4) { document.getElementById('sonuc').innerHTML=http.responseText; } }; http.send(null); }; } window.onload=kategoriSec; </SCRIPT> <%
					   end if%> </div> </div> <%
						  
mmmYardimci1.movenext
loop
end if
close(mmmYardimci1)
close(mmmYardimci)
%> <input name="a" type="submit" value="Ara" class="btn btn-primary">
                            </form>
</div>
<%end sub%>
<% Sub ekatalog(icerikid,tur) 
jsekyol="../scripts/ekatalog/"
%>

<div id="canvas">
  <div id="kapat" style="display:none;" onClick="kapat()">KAPAT</div>
  <a id="fulls" href="javascript:buyut();">
  <div class="fulls">Zoom</div>
  </a> 
  
  <!-- Thumbnails -->
  <div class="fade-items<%=icerikid%><%=tur%> slider s-mode<%=icerikid%><%=tur%>">
    <%
	
sqlString = "select * from resimd where baslik='"&icerikid&"' order by firma, fid"
set mmmYardimci = Con.Execute (sqlString)
lojik5=con.execute("select count(fid) as toplam5 from resimd where baslik='"&icerikid&"'")
toplameks=lojik5("toplam5")
Do While Not mmmYardimci.EOF
ekat=ekat+1

sqlString = "select * from resimd where fid="&mmmYardimci("fid")&" order by fid"
set mmmYardimci1 = Con.Execute (sqlString)

if mmmYardimci1.eof then
resimim="resimyok.jpg"
en1=re3
boy=re4
else
ressize=mmmYardimci1("ressize")
resimim=mmmYardimci1("resimid")
en1=re3
if re4=0 then
if instr(ressize,":") and len(ressize)>1 then
ressizebir=split(ressize,":")(1)
ressizeiki=split(ressize,":")(0)
boy=round(ressizebir*re3/ressizeiki,0)
else
boy=re4
end if
else
boy=re4
end if
resim1path=imggaleriyol
resimkat1=resimim
resimkat(ekat)=resimkat1
if ekat=1 then
ayrac=""
set dosyasis=CreateObject("Scripting.FileSystemObject")
if dosyasis.FileExists(Server.MapPath(""&resim1path&""&resimkat(1)&"")) = true then
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Path = Server.MapPath(""&resim1path&""&resimkat(1)&"")
Jpeg.Open Path
jwidth=Jpeg.Width
jheight=Jpeg.Height
else
jwidth=0
jheight=0
end if
yuzde=int(jheight)/450
katalogh="450"
katalogw=round((jwidth/yuzde)*2,0)
else
ayrac=","
end if

end if
close(mmmYardimci1)
resimss=resimss&""&ayrac&""""&resimkat(ekat)&""""
resimsayi=resimsayi&""&ayrac&""""&ekat&""""
mmmYardimci.movenext
			loop  		
			close(mmmYardimci)
			session("resarray")=resimkat

			%>
    <div class="slick-slide">
      <div class="firstpage">
        <div class="gradient"></div>
        <div class="image"> <img id="zoom_05a" src="<%=resim1path&""&session("resarray")(1)%>"  class="page-1 lazy" data-original="<%=resim1path&""&session("resarray")(1)%>" data-zoom-image="<%=resim1path&""&session("resarray")(1)%>"> </div>
      </div>
      <div class="imglitmask">1</div>
    </div>
    <%
			toplameksorta=cint(toplameks)-1
			for eks=2 to toplameksorta
			if right(eks,1)=1 or right(eks,1)=3 or right(eks,1)=5 or right(eks,1)=7 or right(eks,1)=9 then
			else
			%>
    <div class="slick-slide">
      <div class="firstdiv">
        <div class="gradient"></div>
        <div class="image"> <img id="zoom_<%=eks%>a" src="<%=resim1path&""&session("resarray")(eks)%>"  class="page-<%=eks%> lazy" data-original="<%=resim1path&""&session("resarray")(eks)%>" data-zoom-image="<%=resim1path&""&session("resarray")(eks)%>"> </div>
      </div>
      <div class="seconddiv">
        <div class="gradient"></div>
        <div class="image"> <img id="zoom_<%=eks+1%>a" src="<%=resim1path&""&session("resarray")(eks+1)%>"  class="page-<%=eks+1%> lazy" data-original="<%=resim1path&""&session("resarray")(eks+1)%>" data-zoom-image="<%=resim1path&""&session("resarray")(eks+1)%>"> </div>
      </div>
      <div class="imglitmask"><%=eks%>-<%=eks+1%></div>
    </div>
    <%
			end if
			next%>
    <div class="slick-slide">
      <div class="lastpage">
        <div class="gradient"></div>
        <div class="image lazy"> <img src="<%=resim1path&""&session("resarray")(toplameks)%>"  class="page-<%=toplameks%>" data-original="<%=resim1path&""&session("resarray")(toplameks)%>"> </div>
      </div>
      <div class="imglitmask"><%=toplameks%></div>
    </div>
  </div>
</div>

<%
end sub
%>
<% Sub ekatalog1(icerikid,tur) 
jsekyol="../scripts/ekatalog/"
%>
<script>
function buyut() {

        $('#canvas').css({
            
            width: $(window).width(), //pencere genişliği
            height: $(window).height() // pencere yuksekliği
			
        }).addClass("bigger");
		
		var witd = $(window).height()*(640/480);
		// monitorler dikdortgen oldugu için yuksekliği tam yapıp genişliği ona gore orantıladık
		$('#canvas').attr('width',witd).attr('height',$(window).height()+200); // degerlerimizi verdik
		$('#kapat').show();
    }
	function kapat() { // içerik eski css bilgilerine döndürülüyor.
			$('#kapat').hide();
			$('#canvas').css({
            width: "100%",
            height: "100%"
        }).removeClass("bigger").addClass("icerik2");
		$('#canvas').attr('width',"100%").attr('height',"100%");
	}
$(document).ready(function(){
katalogyukle();
 });
</script>
                        <script type="text/javascript" src="<%=jsekyol%>modernizr.2.5.3.min.js" <%=strasync%>></script>
                        <script type="text/javascript" src="<%=jsekyol%>hash.js" <%=strasync%>></script>
                        <div id="canvas">
                            <div id="kapat" style="display:none;" onClick="kapat()">KAPAT</div>
                            <a href="javascript:buyut();">
                                <div class="fulls">Zoom</div>
                            </a>
                            <div class="zoom-icon zoom-icon-in"></div>
                            <div class="magazine-viewport">
                                <div class="container">
                                    <div class="magazine">
                                        <!-- Next button -->
                                        <div ignore="1" class="next-button"></div>
                                        <!-- Previous button -->
                                        <div ignore="1" class="previous-button"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Thumbnails -->
                            <div class="ethumbnails">
                                <ul>
                                    <%
	
sqlString = "select * from resimd where baslik='"&icerikid&"' order by firma, fid"
set mmmYardimci = Con.Execute (sqlString)
lojik5=con.execute("select count(fid) as toplam5 from resimd where baslik='"&icerikid&"'")
toplameks=lojik5("toplam5")
Do While Not mmmYardimci.EOF
ekat=ekat+1


sqlString = "select * from resimd where fid="&mmmYardimci("fid")&" order by fid"
set mmmYardimci1 = Con.Execute (sqlString)

if mmmYardimci1.eof then
resimim="resimyok.jpg"
en1=re3
boy=re4
else
ressize=mmmYardimci1("ressize")
resimim=mmmYardimci1("resimid")
en1=re3
if re4=0 then
if instr(ressize,":") and len(ressize)>1 then
ressizebir=split(ressize,":")(1)
ressizeiki=split(ressize,":")(0)
boy=round(ressizebir*re3/ressizeiki,0)
else
boy=re4
end if
else
boy=re4
end if
resim1path=imggaleriyol
resimkat1=resimim
resimkat(ekat)=resimkat1
if ekat=1 then
ayrac=""
set dosyasis=CreateObject("Scripting.FileSystemObject")
if dosyasis.FileExists(Server.MapPath(""&resim1path&""&resimkat(1)&"")) = true then
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Path = Server.MapPath(""&resim1path&""&resimkat(1)&"")
Jpeg.Open Path
jwidth=Jpeg.Width
jheight=Jpeg.Height
else
jwidth=0
jheight=0
end if
yuzde=int(jheight)/450
katalogh="450"
katalogw=round((jwidth/yuzde)*2,0)
else
ayrac=","
end if

end if
close(mmmYardimci1)
resimss=resimss&""&ayrac&""""&resimkat(ekat)&""""
resimsayi=resimsayi&""&ayrac&""""&ekat&""""
mmmYardimci.movenext
			loop  		
			close(mmmYardimci)
			session("resarray")=resimkat
			%>
                                    <li class="i"> <img src="<%=resim1path&""&session("resarray")(1)%>" width="76" height="100" class="page-1"> <span>1</span> </li>
                                    <%
			toplameksorta=cint(toplameks)-1
			for eks=2 to toplameksorta
			if right(eks,1)=1 or right(eks,1)=3 or right(eks,1)=5 or right(eks,1)=7 or right(eks,1)=9 then
			else
			%>
                                    <li class="d"> <img src="<%=resim1path&""&session("resarray")(eks)%>" width="76" height="100" class="page-<%=eks%>"> <img src="<%=resim1path&""&session("resarray")(eks+1)%>" width="76" height="100" class="page-<%=eks+1%>"> <span><%=eks%>-<%=eks+1%></span> </li>
                                    <%
			end if
			next%>
                                    <li class="i"> <img src="<%=resim1path&""&session("resarray")(toplameks)%>" width="76" height="100" class="page-<%=toplameks%>"> <span><%=toplameks%></span> </li>
                                </ul>
                            </div>
                        </div>
                        <script type="text/javascript">
                            function katalogyukle() {
                                function loadApp() {

                                    $('#canvas').fadeIn(1000);

                                    var flipbook = $('.magazine');

                                    // Check if the CSS was already loaded

                                    if (flipbook.width() == 0 || flipbook.height() == 0) {
                                        setTimeout(loadApp, 10);
                                        return;
                                    }

                                    // Create the flipbook

                                    flipbook.turn({

                                        // Magazine width

                                        width: < %= katalogw % > ,

                                        // Magazine height

                                        height: < %= katalogh % > ,

                                        // Duration in millisecond

                                        duration: 1000,

                                        // Hardware acceleration

                                        acceleration: !isChrome(),

                                        // Enables gradients

                                        gradients: true,

                                        // Auto center this flipbook

                                        autoCenter: true,

                                        // Elevation from the edge of the flipbook when turning a page

                                        elevation: 50,

                                        // The number of pages

                                        pages: < %= toplameks % > ,

                                        // Events

                                        when: {
                                            turning: function(event, page, view) {

                                                var book = $(this),
                                                    currentPage = book.turn('page'),

                                                    pages = book.turn('pages');

                                                // Update the current URI

                                                Hash.go('page/' + page).update();

                                                // Show and hide navigation buttons

                                                disableControls(page);


                                                $('.ethumbnails .page-' + currentPage).
                                                parent().
                                                removeClass('current');

                                                $('.ethumbnails .page-' + page).
                                                parent().
                                                addClass('current');



                                            },

                                            turned: function(event, page, view) {

                                                disableControls(page);

                                                $(this).turn('center');

                                                if (page == 1) {
                                                    $(this).turn('peel', 'br');
                                                }

                                            },

                                            missing: function(event, pages) {
                                                //document.getElementById("demo").innerHTML = '' +  pages.length + '';
                                                // Add pages that aren't in the magazine
                                                var resim1path = '<%=resim1path%>';
                                                var resimler = [ < %= resimss % > ];


                                                for (var i = 0; i < pages.length; i++)
                                                    addPage(pages[i], $(this), resim1path, resimler);

                                            }
                                        }

                                    });

                                    // Zoom.js

                                    $('.magazine-viewport').zoom({
                                        flipbook: $('.magazine'),

                                        max: function() {

                                            return largeMagazineWidth() / $('.magazine').width();

                                        },

                                        when: {

                                            swipeLeft: function() {

                                                $(this).zoom('flipbook').turn('next');

                                            },

                                            swipeRight: function() {

                                                $(this).zoom('flipbook').turn('previous');

                                            },

                                            resize: function(event, scale, page, pageElement, resim1path) {
                                                var resim1path = '<%=resim1path%>';
                                                var resimler = [ < %= resimss % > ];
                                                if (scale == 1)
                                                    loadSmallPage(page, pageElement, resim1path, resimler);
                                                else
                                                    var page1 = '<%=resim1path%>';
                                                loadLargePage(page, pageElement, resim1path, resimler);

                                            },

                                            zoomIn: function() {

                                                $('.ethumbnails').hide();
                                                $('.made').hide();
                                                $('.magazine').removeClass('animated').addClass('zoom-in');
                                                $('.zoom-icon').removeClass('zoom-icon-in').addClass('zoom-icon-out');

                                                if (!window.escTip && !$.isTouch) {
                                                    escTip = true;

                                                    $('<div />', {
                                                        'class': 'exit-message'
                                                    }).
                                                    html('<div>Kucultmek icin Esc veya Sag Ustteki Oklara Basiniz.</div>').
                                                    appendTo($('body')).
                                                    delay(2000).
                                                    animate({
                                                        opacity: 0
                                                    }, 500, function() {
                                                        $(this).remove();
                                                    });
                                                }
                                            },

                                            zoomOut: function() {

                                                $('.exit-message').hide();
                                                $('.ethumbnails').fadeIn();
                                                $('.made').fadeIn();
                                                $('.zoom-icon').removeClass('zoom-icon-out').addClass('zoom-icon-in');

                                                setTimeout(function() {
                                                    $('.magazine').addClass('animated').removeClass('zoom-in');
                                                    resizeViewport();
                                                }, 0);

                                            }
                                        }
                                    });

                                    // Zoom event

                                    if ($.isTouch)
                                        $('.magazine-viewport').bind('zoom.doubleTap', zoomTo);
                                    else
                                        $('.magazine-viewport').bind('zoom.tap', zoomTo);


                                    // Using arrow keys to turn the page

                                    $(document).keydown(function(e) {

                                        var previous = 37,
                                            next = 39,
                                            esc = 27;

                                        switch (e.keyCode) {
                                            case previous:

                                                // left arrow
                                                $('.magazine').turn('previous');
                                                e.preventDefault();

                                                break;
                                            case next:

                                                //right arrow
                                                $('.magazine').turn('next');
                                                e.preventDefault();

                                                break;
                                            case esc:

                                                $('.magazine-viewport').zoom('zoomOut');
                                                e.preventDefault();

                                                break;
                                        }
                                    });

                                    // URIs - Format #/page/1 

                                    Hash.on('^page\/([0-32]*)$', {
                                        yep: function(path, parts) {
                                            var page = parts[1];

                                            if (page !== undefined) {
                                                if ($('.magazine').turn('is'))
                                                    $('.magazine').turn('page', page);
                                            }

                                        },
                                        nop: function(path) {

                                            if ($('.magazine').turn('is'))
                                                $('.magazine').turn('page', 1);
                                        }
                                    });


                                    $(window).resize(function() {
                                        resizeViewport();
                                    }).bind('orientationchange', function() {
                                        resizeViewport();
                                    });

                                    // Events for ethumbnails

                                    $('.ethumbnails').click(function(event) {

                                        var page;

                                        if (event.target && (page = /page-([0-9]+)/.exec($(event.target).attr('class')))) {

                                            $('.magazine').turn('page', page[1]);
                                        }
                                    });

                                    $('.ethumbnails li').
                                    bind($.mouseEvents.over, function() {

                                        $(this).addClass('thumb-hover');

                                    }).bind($.mouseEvents.out, function() {

                                        $(this).removeClass('thumb-hover');

                                    });

                                    if ($.isTouch) {

                                        $('.ethumbnails').
                                        addClass('ethumbnails-touch').
                                        bind($.mouseEvents.move, function(event) {
                                            event.preventDefault();
                                        });

                                    } else {

                                        $('.ethumbnails ul').mouseover(function() {

                                            $('.ethumbnails').addClass('ethumbnails-hover');

                                        }).mousedown(function() {

                                            return false;


                                        }).mouseout(function() {

                                            $('.ethumbnails').removeClass('ethumbnails-hover');

                                        });

                                    }


                                    // Regions

                                    if ($.isTouch) {
                                        $('.magazine').bind('touchstart', regionClick);
                                    } else {
                                        $('.magazine').click(regionClick);
                                    }

                                    // Events for the next button

                                    $('.next-button').bind($.mouseEvents.over, function() {

                                        $(this).addClass('next-button-hover');

                                    }).bind($.mouseEvents.out, function() {

                                        $(this).removeClass('next-button-hover');

                                    }).bind($.mouseEvents.down, function() {

                                        $(this).addClass('next-button-down');

                                    }).bind($.mouseEvents.up, function() {

                                        $(this).removeClass('next-button-down');

                                    }).click(function() {

                                        $('.magazine').turn('next');

                                    });

                                    // Events for the next button

                                    $('.previous-button').bind($.mouseEvents.over, function() {

                                        $(this).addClass('previous-button-hover');

                                    }).bind($.mouseEvents.out, function() {

                                        $(this).removeClass('previous-button-hover');

                                    }).bind($.mouseEvents.down, function() {

                                        $(this).addClass('previous-button-down');

                                    }).bind($.mouseEvents.up, function() {

                                        $(this).removeClass('previous-button-down');

                                    }).click(function() {

                                        $('.magazine').turn('previous');

                                    });


                                    resizeViewport();

                                    $('.magazine').addClass('animated');

                                }

                                // Zoom icon

                                $('.zoom-icon').bind('mouseover', function() {

                                    if ($(this).hasClass('zoom-icon-in'))
                                        $(this).addClass('zoom-icon-in-hover');

                                    if ($(this).hasClass('zoom-icon-out'))
                                        $(this).addClass('zoom-icon-out-hover');

                                }).bind('mouseout', function() {

                                    if ($(this).hasClass('zoom-icon-in'))
                                        $(this).removeClass('zoom-icon-in-hover');

                                    if ($(this).hasClass('zoom-icon-out'))
                                        $(this).removeClass('zoom-icon-out-hover');

                                }).bind('click', function() {

                                    if ($(this).hasClass('zoom-icon-in'))
                                        $('.magazine-viewport').zoom('zoomIn');
                                    else if ($(this).hasClass('zoom-icon-out'))
                                        $('.magazine-viewport').zoom('zoomOut');

                                });

                                $('#canvas').hide();


                                // Load the HTML4 version if there's not CSS transform

                                yepnope({
                                    test: Modernizr.csstransforms,
                                    yep: ['<%=jsekyol%>turn.js'],
                                    nope: ['<%=jsekyol%>turn.html4.min.js'],
                                    both: ['<%=jsekyol%>zoom.min.js', '<%=jsekyol%>magazine.js', '<%=imgyol%>magazine.css'],
                                    complete: loadApp
                                });
                            }
                        </script>
                        <% End Sub

function resimler(icerikid,tur) 
csstip=i1ayar3&""&tur
if tur=3 then
agacim=""
else
agacim=" and type <> '1'"
end if

set mmmYardimci = Con.Execute ("select * from resimd where baslik='"&icerikid&"'"&agacim&" order by firma, fid")

Do While Not mmmYardimci.EOF
resimisimm=mmmYardimci("resad")
rid=mmmYardimci("fid")
     strlinkyan=mmmYardimci("link")
set mmmYardimci1 = Con.Execute ("select * from resimd where fid="&rid&" order by fid")
if tur=3 then
re2=r2
re3=r3
re4=r4
re5=r5
re6=r6
else
re2=r2
re3=r3
re4=r4
re5=r5
re6=r6
end if
if mmmYardimci1.eof then
resimim="resimyok.jpg"
else
resimim=mmmYardimci1("resimid")
end if
close(mmmYardimci1)

resimisim=dilyazib(rid,icbaslik,lang)
if len(resimisimm)=0 and resadbos=0 then
resadbos=0
else
resadbos=40
end if
	 ' strtarget=mmmSayfa2("target")
resimimlink=imggaleriyol&""&resimim&""" data-toggle=""lightbox"" data-gallery=""multiimages"&icerikid&""" data-title="""&resimisimm&""" data-footer="""&resimacik&""
resimim=imggaleriyol&""&resimim
    if strlinkyan="" or isNull(strlinkyan) then
    strlinkyan=resimimlink
    else
    targetres=" target=""_blank"""
    end if

resimler=resimler&"<div class=""col-sm-6 col-md-6"">"
resimler=resimler&"<div class=""thumbnail resim_cercevem"&csstip&""">"
resimler=resimler&"<a href="""&strlinkyan&""""&targetres&">"
resimler=resimler&"<div style=""background-image:url("&resimim&");"" data-original="""&resimim&""" class=""image lazy""> </div>"
    if resimisimm="" then
	else
    resimler=resimler&"<div class=""caption"">"
    resimler=resimler&"<h3>"&resimisimm&"</h3>"
    resimler=resimler&"<p></p>"
    resimler=resimler&"</div>"
	end if
  resimler=resimler&"</a> </div>"
  resimler=resimler&"</div>"
mmmYardimci.movenext
			loop  
		
				
			close(mmmYardimci)
	
 End function
 %>
                        <% sub menuustkurumsal(tur1,tur2) 
 set mmmYardimci3 = Con.Execute ("select * from yazilar where id="&tur1&" ORDER BY id")
if mmmYardimci3.eof then
else
menuisimyazi1a=mmmYardimci3("yazi")
menuisimyazi1=dilyazi(tur1,menuisimyazi1a)
%>
                        <%=veriguncelle(menuisimyazi1)%>
                        <%end if
				close(mmmYardimci3)
End Sub %>