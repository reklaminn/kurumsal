<%
    contdil="240"
  %>
<!--#Include file="admin_menu1.asp"-->
<%
if isNull(request("dkate2")="") or request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
	
	if request("yer")="" or request("yer")="0" then
	yer=0
	else
	yer=request("yer")
	end if
	
urunid = Request.QueryString("urunid")
	langstr = Request.QueryString("dil")
    if Request.QueryString("anaurunid")="" then
                   anaurunid=dkate2
                   else
                   anaurunid=Request.QueryString("anaurunid")
                   end if
              if langstr="" then
              else
        response.Write(setchar(langstr,"0"))

            set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&langstr&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)

    if Request.QueryString("urunid")="" or Request.QueryString("urunid")="0" then

    sqlString = "SELECT * FROM kategoriyazi where id="&Request.QueryString("anaurunid")&""
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
seolink= seomlink
        if request.QueryString("iceriktur")="1" then
        yazib=request.QueryString("titlee")&" Sayfası"
        end if
yazib1=yazib
else
yazib=mmmYardimci("isim")
yazib1=yazib
sifreli=mmmYardimci("sifreli")
modulmu=mmmYardimci("modulmu")
stura=mmmYardimci("stura")
baslikd=mmmYardimci("baslikd")
slider=mmmYardimci("slider")
smodula=mmmYardimci("smodula")
sayara=mmmYardimci("sayara")
orta=mmmYardimci("orta")
sol=mmmYardimci("sol")
sosyal1=mmmYardimci("sosyal1")
sosyal2=mmmYardimci("sosyal2")
sira=mmmYardimci("sira")
menugosterim=mmmYardimci("menugosterim")
durum=mmmYardimci("durum")
target=mmmYardimci("link")
okusayi="0"

end if
close(mmmYardimci)


        seomlink=csskont(baslikkont(yazib1))&""&seosonu&""

            con.Execute("insert kategoriyazi Set dil='"&langstr&"',isim='"&yazib&"',bagli='"&Request.QueryString("anaurunid")&"',seolink='"&seolink&"', sifreli='"&sifreli&"', modulmu='"&modulmu&"', stura='"&stura&"', baslikd='"&baslikd&"', slider='"&slider&"', smodula='"&smodula&"', sayara='"&sayara&"', orta='"&orta&"', sol='"&sol&"', sosyal1='"&sosyal1&"', sosyal2='"&sosyal2&"', sira='"&sira&"', menugosterim='"&menugosterim&"', durum='"&durum&"', target='"&target&"', okusayi='"&okusayi&"'")

        strSQL="select @@IDENTITY as NewID from kategoriyazi"
    set mmmGenel = Con.Execute(strSQL)
    tfgid = mmmGenel.Fields("NewID")
    close(mmmGenel)
    seolinkyenile="1"
        dkate2=tfgid
    else
   dkate2= urunid
    end if
    end if

%>


<div class="right_col" role="main">
  <div class="x_panel">
    <% 
if sayfaayart="modul" then

langstr = Request.QueryString("dil")
    if Request.QueryString("anaurunid")="" then
                   anaurunid=dkate2
                   else
                   anaurunid=Request.QueryString("anaurunid")
                   end if
              if langstr="" then
              else
        response.Write(setchar(langstr,"0"))

            set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&langstr&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)

end if
%>
      <div class="form-group">
      <div class="input-group">
      <div class="input-group-addon">
         Sayfaya Git
          </div>
    <select name="dkate2" class="selctize1" onChange1="MM_jumpMenu('parent',this,0)" id="dkate2">

      <%
          response.Write kategoriyaziliste("1","<option value=""?sayfaayar=modul&dkate2=#kylid#""> #kylico# #kylisim#</option>#kylsub{(,,,,"&sayfagosterme&",&nbsp;>,240)}#","",dkate2,sayfagosterme,"","240")
      %>
    </select>
          
          </div>
      
          </div>

    <%

  '      a=Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
'b=Filter(a,"S",True,1)
'for each x in b
   'response.write(x & "<br>")
'next
        
        if request("usayi")="" then
	KayitSayisi=25
	else
	KayitSayisi=request("usayi")
	end if
	if request("blokgoster")="" then
	if session("strblokgoster")="" then
	session("strblokgoster")="0"
	else
	session("strblokgoster")=session("strblokgoster")
	end if
	else
	session("strblokgoster")=request("blokgoster")
	end if
	if session("strblokgoster")="1" then
	strblokgorlink="0"
	else
	strblokgorlink="1"
	end if


    if request("islemim")="blokozellestir" then

          sqlString = "select * from kategoriyazi where id="&giriskont(request("sek"))&""
Set mmmYardimci=Con.execute(sqlString)
if mmmYardimci.eof then
else

Con.execute("update kategoriyazi set sayfatemp='"&mmmYardimci("sayfatemp")&"', sol='"&mmmYardimci("sol")&"' where id="&request("dkate2")&"")
end if
close(mmmYardimci)

Con.execute("update kategoriyazi set sayara='"&Request("dkate2")&"' where id="&request("dkate2")&"")  

    
    elseif request("islemim")="yerlesim" then
  'serielized=request.Form("serializede")
  serielized=replace(replace(request.Form("serializede"),"""[","["),"]""","]")
  'serielized=replace(replace(replace(request.Form("serializede"),"[%22]",""""),"""[","["),"]""","]")
  for ho= 1 to request.Form("rowidh").count
  yerlesimtext=yerlesimtext&"[row]"&split(split(serielized,"""type"": """)(ho),""",")(0)&","&request.Form("rowidh")(ho)&","
  colbasla=split(serielized,"""type"": """)(ho)
  colbaslacount=ubound(split(colbasla,"""id"": ""col"))
  for hc=1 to colbaslacount
  hcs=hcs+1
  yerlesimtext=yerlesimtext&"{col}"&request.Form("colidh")(hcs)&""
  modulbasla=trim(split(colbasla,"""id"": ""col")(hc))
  modulbaslacount=ubound(split(modulbasla,"""modulid"":"))
  for hcm=1 to modulbaslacount
  hcms=hcms+1
        moduljson=URLDecode(split(split(modulbasla,"""jsonold"": """)(hcm),""",")(0))
        if instr(moduljson,",") then
    bscnt=ubound(split(moduljson,","))  
    modid=split(moduljson,",")(0)
    strmsbaslik=split(moduljson,",")(1)
    strmssayfa=split(moduljson,",")(2)
    strmsmodulid=split(moduljson,",")(3)
    strmstemp=split(moduljson,",")(4)
    strmsgoster=split(moduljson,",")(5)
    strmsonay=split(moduljson,",")(6)
    strmsmdurum=split(moduljson,",")(7)
        if bscnt>7 then
    strmsozel=split(moduljson,",")(8)
    strmsozelvar=split(moduljson,",")(9)
        end if
    end if
  if strmsmodulid="115" and strmssayfa="0" and strmsmdurum="1" then
urunids1=strmsmodulid
urunids=strmsmodulid
sqlString = "select * from moduller where id="&urunids&" order by id desc"
set mmmGenel = Con1.Execute (sqlString)
urunids=mmmGenel("kod")
if urunids="0" or urunids="yazi" or urunids="kate"  then
urunids="1"
else
urunids="3"
end if
close(mmmGenel)
sqlString = "insert yazilar set yazib='"&giriskont(strmsbaslik)&"',dil='240',bilgi1='/*Ana Govde*//*media*/@media (min-width:823px) {}@media (min-width:824px) {}@media (min-width:992px) {}@media (min-width:1200px) {}@media screen and (max-width:767px) {}@media screen and (max-width:480px) {}@media (max-device-width:480px) and (orientation:landscape) {}',link='0',durum='1',kategori='979',form='"&request.Form("form")&"',urunid='"&urunids&"',modulmu='1',tarih='"&now&"',gtarih='"&now&"'"
Con.execute(sqlString)
sqlString = "select * from yazilar order by id desc"
set mmmGenel = Con.Execute (sqlString)
msayfa="y"&mmmGenel("id")
close(mmmGenel)
siraa=99
else
urunids=strmsmodulid
urunids1=strmsmodulid
msayfaozelvar=strmsozelvar
msayfaozel=strmsozel
        if msayfaozelvar="1" then
        msayfa="vip"&msayfaozel
        else
msayfa=strmssayfa
        end if
end if
  yerlesimtext=yerlesimtext&",{modul}"&modid&","&strmsbaslik&","&msayfa&","&urunids1&","&strmstemp&","&strmsgoster&","&strmsonay&",0,"&strmsozel&","&strmsozelvar&"{/modul}"
  
  next
  yerlesimtext=yerlesimtext&"{/col}"
  next
  yerlesimtext=yerlesimtext&"[/row]"
  next
  yerlesimtext=minify(yerlesimtext)
        if request.Form("link")<>"" then
link = request.Form("link")
target = request.Form("target")
else
link = 0
target = 0
end if

if Request.Form("dkate2")="1" then
dkate2ne="1"
dkate2altne="1"
else
dkate2ne=Request.Form("dkate2")
dkate2altne="0"
end if
    if yetkiuye="1" then
        ekagac=", orta='"&giriskont(Request.Form("modultemp"))&"'"
        end if
Con.execute("update kategoriyazi set sayfatemp='"&csskont(yerlesimtext)&"', sol='"&csskont(serielized)&"'"&ekagac&", isim='"&giriskont(Request.Form("sayfaadi"))&"',durum='"&Request.Form("durum1")&"',anasek='"&dkate2ne&"',alt='"&dkate2altne&"',link='"&link&"',target='"&target&"',sayara='"&Request.Form("sayara")&"',stura='"&Request.Form("stura")&"',smodula='"&Request.Form("smodula")&"', gtarih='"&now&"' where id="&request("dkate2")&"")  

        if giriskont(request.form("seolinkyenile"))="1" then
     call seourlduzenle(baslikkont(Request.Form("sayfaadi"))&""&seosonu&"",request("dkate2"),"sayfa","240")
    end if
session("hata1")="Sayfa Moduller Düzenlendi"
session("hatam1")="green"

Response.Redirect Request.ServerVariables("HTTP_REFERER")
  else
  end if
  
        
                 
sqlString = "select * from kategoriyazi where id="&dkate2&" order by id desc "
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
                strid="0"
                stridbagli="0"
                %>
    <%else
		strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
dil=mmmGenel("dil")
stridbagli=mmmGenel("bagli")
        if stridbagli="" or isNull(stridbagli) then
        stridbagli="0"
        end if
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strsifreli=mmmGenel("sifreli")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
strrowtemp=mmmGenel("sayfatemp")
strrowtempyeni=mmmGenel("sol")
strrowtempmodul=mmmGenel("orta")

        smidtitle=mmmGenel("title")
smiddescri=mmmGenel("descri")
smidkeysi=mmmGenel("keysi")
smidseolink=mmmGenel("seolink")

smidbaslik=mmmGenel("isim")
smiddurum=mmmGenel("durum")
smidsayara=mmmGenel("sayara")
        if smidsayara="" or smidsayara="1" then
        smidsayara=strid
        end if
smidsmodula=mmmGenel("smodula")
smidstura=mmmGenel("stura")
smidtarget=mmmGenel("target")
smidlink=mmmGenel("link")

if sid="" or isNull(sid) or sid="835" then
sida=strid
else
sida=sid
end if

sqlString = "select * from seolar where seoid='"&strid&"' and seoturu='sayfa'"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
smidseolar="0"
smidlang=aktifdil
smidseolink=baslikkont(strisim)&""&seosonu&""
else
smidseolar="1"
smidtitle=mmmYardimci("seobaslik")
smiddescri=mmmYardimci("seoaciklama")
smidpcss=mmmYardimci("seoanahtar")
smidpjs=mmmYardimci("seohtml")
smidkeysi=mmmYardimci("seotag")
smidh1=mmmYardimci("seoh1")
smidata=mmmYardimci("structred")
smidatastatu=mmmYardimci("structredstatu")
smidseolink=mmmYardimci("seolink")
smidlang=mmmYardimci("lang")
            smidhraflang=mmmYardimci("hraflang")
            smidcanoncial=mmmYardimci("canoncial")
seonoindex=mmmYardimci("noindex")
        if smidlang="" then
        smidlang=aktifdil
        end if
end if
close(mmmYardimci)

          end if
  close(mmmGenel)

  %>
      <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#icerik">Sayfa Ayarları, Yerleşim ve İçerikleri</a></li>     
    <li><a data-toggle="tab" href="#seo">Seo</a></li>
          <%if langstr<>"" and langstr<>contdil then
              else%>
    <li><a data-toggle="tab" href="#kopyala">Sayfa Ayarları ve Yerleşim Kopyala</a></li>
          <%end if %>
  </ul>

              <div class="tab-content">
               <div id="icerik" class="tab-pane fade in active">
    <form action="?id=&baslik=<%=request.QueryString("baslik")%>&sek=1&dkate2=<%=request.QueryString("dkate2")%>&sayfaayar=modul&islemim=yerlesim" method="post" class="block-form">
             <div class="row form-group" style="margin-top:10px;">
                     <div class="col-md-3">
                        <select name="dkate2" class="selctize1" id="dkate">
      <option value="1"> Ana Sayfa </option>

      <%
     response.Write kategoriyaziliste("1","<option value=""#kylid#""> #kylico# #kylisim#</option>#kylsub{(,,,,"&sayfagosterme&",&nbsp;>,240)}#","",stranasek,sayfagosterme,"","240")
%>
    </select>
                    </div>                
                <div class="col-md-7">
                    <div class="input-group">
                        <%if seolinkyenile="1" then %>
                <input name="seolinkyenile" type="hidden" value="1" />
                        <%end if %>
                <input name="sid" type="hidden" value="<%=strid%>" />
      <input name="sayfaadi" type="text" id="sayfaadi" value="<%=smidbaslik%>" size="25" class="form-control input-lg" />
                        
            <% 
sqlString = "select id,kate from diller1 where alt = '1' and sira='1' ORDER BY bagli"
set mmmYardimci1= Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
                    if langstr="" or langstr="240" then
sqlString = "select * from kategoriyazi where dil='"&mmmYardimci1("id")&"' and (bagli="&strid&" or id="&strid&" or id="&stridbagli&")"
                    else
sqlString = "select * from kategoriyazi where dil='"&mmmYardimci1("id")&"' and (bagli="&stridbagli&" or id="&strid&" or id="&stridbagli&")"
                    end if
set mmmYardimci= Con.Execute (sqlString)
if mmmYardimci.eof then
                    %>
          <div class="input-group-btn">
                <a href="?duzelt=1&amp;urunid=&amp;dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&anaurunid=<%=anaurunid %>&dil=<%=mmmYardimci1("id") %>&sayfaayar=modul" class="btn btn-info pull-right dropdown-toggle btn-md"><%=mmmYardimci1("kate")%></a>
          </div>
               <%
else
if dil&""<>""&mmmYardimci1("id") then
                %>
          <div class="input-group-btn">
                <a href="?duzelt=1&amp;urunid=<%=mmmYardimci("id")%>&amp;dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&anaurunid=<%=anaurunid %>&dil=<%=mmmYardimci1("id") %>&sayfaayar=modul" class="btn btn-info pull-right dropdown-toggle btn-md"><%=mmmYardimci1("kate")%></a>
          </div>
                <%
			  end if
			  end if
			  close(mmmYardimci)
mmmYardimci1.movenext
loop
close(mmmYardimci1)
                %>
      </div>
                </div>
             <div class="col-md-2">
  <%if smiddurum = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("durum1","Durumu",iks,cbcdisstr,cbccheckstr,"success"))%>
  <%if smiddurum1 = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("seolinkyenile","Sayfa Adına Göre Seolinkini Güncelle",iks,cbcdisstr,cbccheckstr,"success"))%>
                 <%if langstr<>"" and langstr<>contdil then
                     else%>
                 <a role="tab" id="headingdayar" data-toggle="collapse" data-parent="#accordion1" href="#collapsedayar" aria-expanded="true" aria-controls="collapsedayar" class="btn btn-primary dropdown-toggle btn-xs pull-right" style="padding:7px 5px;"><em class="fas fa-cogs" style="font-size:11px;"></em></a>
                 <%end if %>
                 <a href="/<%=smidseolink%>" target="_blank" style="padding:7px 5px;" class="btn btn-warning dropdown-toggle btn-xs pull-right"><em class="fa fas fa-external-link" style="font-size:11px;"></em></a>
             </div>
                 </div>
<div id="collapsedayar" class="panel-collapse collapse row" role="tabpanel" aria-labelledby="headingdayar" aria-expanded="true" style="margin-top:15px;">
    <%if yetkiuye="1" then %>
                <div class="col-md-2">
                    <label>Temp Kategorisi</label>
                    <select name="modultemp" class="form-control" id="modultemp">
                   <%
		sqlString = "select * from moduller where"&modulgosterme&" and temp='99999'  order by temp desc "
                       response.Write sqlString
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
i=i+1
                       modulid=mmmYardimci("id")
%>
                        <option value="<% =modulid %>" <%if ""&modulid&""=""&strrowtempmodul&"" then%>selected<%else%><%end if%>>
                          <% = mmmYardimci("moduladi")%>
                          </option>
                        <%										  
							mmmYardimci.MoveNext
  loop
end if

Close(mmmYardimci)
%>
                        </select>
      </div>
    <%end if %>
                <div class="col-md-5"> 
                    <label>Harici Link</label>                   
                <div class="input-group">
                  <input name="link" type="text" placeholder="Harici Bağlantıya Gitmesini İstemiyorsanız Boş Bırakın." value="<%if smidlink="" or smidlink="0" then%><%else%><%=smidlink%><%end if %>" class="form-control"/>                  
                  <div class="input-group-btn">
                  <select id="target" name="target" class="form-control" style="width:140px;">
    <option value="0" <%if smidtarget="0" then%>selected<%else%><%end if%>>Sayfa Açılma</option>
    <option value="_blank" <%if smidtarget="_blank" then%>selected<%else%><%end if%>>Yeni Sekmede Aç</option>
    <option value="_parent" <%if smidtarget="_parent" then%>selected<%else%><%end if%>>Kendi Sekmesinde Aç</option>
  </select>
                  </div>
  
  </div>
            </div>
             <div class="col-sm-3 col-md-3">  
                    <label>Blok Düzeni Kullanılan Sayfa</label>          
                  <select id="sayara" size="1" name="sayara" class="form-control">
                      <%
                          'response.Write kategoriyaziliste("1","<option value=""#kylid#""> #kylico# #kylisim#</option>#kylsub{(1,,,,"&sayfagosterme&" and (sayara=id or id="&dkate2&"),&nbsp;>,240)}#","",smidsayara,sayfagosterme&" and (sayara=id or id="&dkate2&")","","240") 
                      response.Write kategoriyaziliste("1","<option value=""#kylid#""> #kylico# #kylisim#</option>#kylsub{(1,,,,"&sayfagosterme&",&nbsp;>,240)}#","",smidsayara,sayfagosterme,"","240")                          %>
                 </select>  
             </div>
             <div class="col-sm-2 col-md-2">
                                                      
                          <%if smidsmodula = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("smodula","Listelemede Listeli Açılma İlk Listeleme içeriği Çıksın",iks,cbcdisstr,cbccheckstr,"success"))%>
                <%if smidstura = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("stura","Alt Sayfalarda Sayfa Formları Aynı",iks,cbcdisstr,cbccheckstr,"success"))%>

                     </div>
    </div>                           
    <div id="Design">
        <%if smidsayara*1=strid*1 then %>
        <ol class="block nested_with_switch vertical">

            <%
            if instr(strrowtempyeni,": [") then
            'yenibasla            
sablon=strrowtempyeni
            Set oJSON = New aspJSON 
            oJSON.loadJSON(sablon)
            set rows = oJSON.data(0)
            for each rowii in rows
            rowtype=rows(rowii)("type")
            rowcont=rows(rowii)("cont")    
            rowcss=rows(rowii)("elcss")   
            rowid=rows(rowii)("elid")    
            rowstyle=rows(rowii)("elstyle")    
            rowotherr=rows(rowii)("elother")    

            rowi=rowi+1
                rowdata=" data-id=""row"&rowi&""" data-elid="""&rowid&""" data-type="""&rowtype&""" data-cont="""&rowcont&""" data-elcss="""&rowcss&""" data-elstyle="""&rowstyle&""" data-elother="""&rowotherr&""" data-eltype=""rowedit"""
            %>
            <li id="r<%=rowi%>"<%=rowdata%>>
                <div class="rowHead">
                    <input type="hidden" name="rowidh" value="r<%=rowi%>" />
                    <span class="columnTitle"><i class="fas fa-arrows-alt" style="float: left;"></i>
                        
                                        <div class="ienlarger" style="float: left;" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Row Ayarlar"><a href="db.asp?islem=blocktab&blocktabcol=rowedit&checked=r<%=rowi%>&checked1=rd<%=rowi%>&blockstring=<%=datamoduljson%>" class="dropdown-toggle rowedit" data-toggle="modal" data-target="#moduladd" style="cursor: pointer;"<%=rowdata%>><em class="fas fa-cog iconadmin" style="color: #39C;"></em></a></div>

                    </span><a class="divdelrow" onclick="divremove('r<%=rowi%>');">-</a>
                </div>
                <ol class="columnParent" id="c<%=rowi%>">
                    <%
             set cols = rows(rowii)("children")(0)
            for each colii in cols
             colid=cols(colii)("id")
             coltype=cols(colii)("colmd")
            colcss=cols(colii)("celcss")   
            colid=cols(colii)("celid")    
            colstyle=cols(colii)("celstyle")    
            colotherr=cols(colii)("celother")   
            coltype=cols(colii)("coltype")   
            colsmtype=cols(colii)("colsmtype")   
            colmdtype=cols(colii)("colmdtype")   
            collgtype=cols(colii)("collgtype")   
            colxltype=cols(colii)("colxltype")   
            coli=coli+1
                        classcoltype=replace(replace(coltype&" "&colsmtype&" "&colmdtype&" "&collgtype&" "&colxltype,"none",""),"  "," ")
                coldata=" data-id=""col"&rowi&""&coli&""" data-celid="""&colid&""" data-cont="""&colcont&""" data-celcss="""&colcss&""" data-celstyle="""&colstyle&""" data-celother="""&colotherr&""" data-coltype="""&coltype&""" data-colsmtype="""&colsmtype&""" data-colmdtype="""&colmdtype&""" data-collgtype="""&collgtype&""" data-colxltype="""&colxltype&""" data-eltype=""coledit"""
                    %>
                    <li class="<%=classcoltype%>" id="c<%=rowi%><%=coli%>" <%=coldata%>>
                        <div class="columnHead">
                    <input type="hidden" name="colidh" value="c<%=rowi%><%=coli%>" />
                            <span class="columnTitle"><i class="fas fa-arrows-alt" style="float: left;"></i>
                                
                                        <div class="ienlarger" style="float: left;" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Col Ayarlar"><a href="db.asp?islem=blocktab&blocktabcol=coledit&checked=c<%=rowi%><%=coli%>&checked1=col<%=rowi%><%=coli%>&blockstring=<%=datamoduljson%>" class="dropdown-toggle coledit" data-toggle="modal" data-target="#moduladd" style="cursor: pointer;"<%=coldata%>><em class="fas fa-cog iconadmin" style="color: #39C;"></em></a></div>
                                <%=classcoltype %></span>
                        </div>
                        <ol class="columnParent2" id="m<%=rowi%><%=coli%>">
                            <%                    
            set mods = cols(colii)("children")(0)
            for each modii in mods
             modid=mods(modii)("id")
             modmodulid=mods(modii)("modulid")
             modjsonold=mods(modii)("jsonold")
                    if modjsonold="" or isNUll(modjsonold) then
                    modultam=""
                    else
    modultam=URLDecode(modjsonold)
                    end if
    if instr(modultam,",") then
    bscnt=ubound(split(modultam,","))  
    modulid=split(modultam,",")(0)
    strmsbaslik=split(modultam,",")(1)
    strmssayfa=split(modultam,",")(2)
    strmssayfa1=split(modultam,",")(2)
    strmsmodulid=split(modultam,",")(3)
    strmstemp=split(modultam,",")(4)
    strmsgoster=split(modultam,",")(5)
    strmsonay=split(modultam,",")(6)
        if bscnt>6 then
    strmsmdurum=split(modultam,",")(7)
    strmsozel=split(modultam,",")(8)
    strmsozelvar=split(modultam,",")(9)
        end if
        if bscnt>9 then
    strmslock=split(modultam,",")(10)
        end if
        end if
                    moduloptfullold="[{""name"":""mid"",""value"":"""&modid&"""},{""name"":""toplu"",""value"":""1""},{""name"":""ladet"",""value"":""0""},{""name"":""moduldurumu"",""value"":"""&strmsmdurum&"""},{""name"":""goster"",""value"":"""&strmsgoster&"""},{""name"":""baslik"",""value"":"""&strmsbaslik&"""},{""name"":""sayfa"",""value"":"""&strmssayfa&"""},{""name"":""sayfaozelvar"",""value"":"""&strmsozelvar&"""},{""name"":""sayfaozel"",""value"":"""&strmsozel&"""},{""name"":""moduller"",""value"":"""&strmsmodulid&"""},{""name"":""temp"",""value"":"""&strmstemp&"""},{""name"":""yetki"",""value"":"""&strmsonay&"""},{""name"":""lock"",""value"":"""&strmslock&"""}]"

                    if isObject(mods(modii)("json")) then
                    set modoptions = mods(modii)("json")

                    'Set oJSONmodul = New aspJSON
                    'oJSONmodul.data.Add 0, modoptions  
                    'moduloptfull= oJSONmodul.JSONoutput()
                    for each modoi in modoptions
                    modopname=modoptions(modoi)("name")
                    modopvalue=modoptions(modoi)("value")
                    if modoi="0" then
                    modiayrac=""
                    else
                    modiayrac=","
                    end if
                    moduloptfull=moduloptfull&""&modiayrac&"{""name"":"""&modopname&""",""value"":"""&modopvalue&"""}"
                    'moduloptfull=moduloptfull&""&modiayrac&"{[%22]name[%22]:[%22]"&modopname&"[%22],[%22]value[%22]:[%22]"&modopvalue&"[%22]}"
                               ' response.Write modopname&"-"
                    if modopname="mid" then
                    modulid=modopvalue
                    elseif modopname="toplu" then
                    strmsmtoplu=modopvalue
                    elseif modopname="ladet" then
                    strmsmladet=modopvalue
                    elseif modopname="moduldurumu" then
                    strmsmdurum=modopvalue
                    elseif modopname="goster" then
                    strmsgoster=modopvalue
                    elseif modopname="baslik" then
                    strmsbaslik=modopvalue
                    elseif modopname="sayfa" then
                    strmssayfa=modopvalue
                    elseif modopname="sayfaozelvar" then
                    strmsozelvar=modopvalue
                    elseif modopname="sayfaozel" then
                    strmsozel=modopvalue
                    elseif modopname="moduller" then
                    strmsmodulid=modopvalue
                    elseif modopname="temp" then
                    strmstemp=modopvalue
                    elseif modopname="yetki" then
                    strmsmdurum=modopvalue
                    end if
                    next
                    moduloptfull="["&moduloptfull&"]"
                    end if
                    if moduloptfull="" then
                    moduloptfull=moduloptfullold
                    end if
if isNull(strmssayfa) or instr(strmssayfa,"vip")="1" then
		strmssayfaozel=replace(strmssayfa,"vip","")
        strmsozel=strmssayfaozel
        strmsozelvar="1"
		strmssayfa=strmssayfa
		strmssayfa1="0"
		elseif strmsozelvar="1" then
		strmssayfa=strmsozel
		strmssayfa1=strmsozel
        strmssayfaozel="1"
        strmsozel=strmsozel
        strmsozelvar="1"
		else
		strmssayfa=strmssayfa
		strmssayfa1=strmssayfa
        strmssayfaozel="0"
        strmsozel=strmssayfa
        strmsozelvar="0"
		end if
		if instr(strmssayfa1,"k") then
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")&"00000"
		elseif instr(strmssayfa,"y") then
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")&"00000"
		else
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")
		end if
    if strmssayfak="" or isNull(strmssayfak) then
    strmssayfak="0"
    end if 
    if strmssayfay="" or isNull(strmssayfay) then
    strmssayfay="0"
    end if 
yerin=modulid&","&strmsbaslik&","&strmssayfa&","&strmsmodulid&",*"&strmstemp&"*,"&strmsgoster&","&strmsonay&",0,"&strmsozel&","&strmsozelvar&","&strmslock

		 sqlString = "SELECT * from kategoriyazi where id='"&strmssayfak&"'" 
     
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then

sqlString = "SELECT * from yazilar where id="&strmssayfay&""
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
icerikid="yok"
iceriklink=""
else
icerikid=mmmYardimci2("id")
icerikuid=mmmYardimci2("urunid")
strmsbaslik=mmmYardimci2("yazib")
icerikkate=mmmYardimci2("kategori")
if icerikuid="" or isNull(icerikuid) then
                                icerikuid="1"
                                end if
sqlString = "SELECT * from kategori where id="&icerikuid&""
set mmmSayfa = Con1.Execute (sqlString)
if mmmSayfa.eof then
turadres="admin_uruny_duzenle.asp?"
turid="115"
else
turadres=mmmSayfa("adresd")
turid=mmmSayfa("id")
end if
close(mmmSayfa)
                                if icerikkate="" or isNull(icerikkate) then
                                icerikkate=request.QueryString("dkate2")
                                end if
iceriklink=""&turadres&"duzelt1="&turid&"&urunid="&icerikid&"&baslik="&icerikid&"&sek="&icerikkate&"&dkate2="&request.QueryString("dkate2")&"&dataurl="&request.QueryString("dkate2")&"//-//urunid="&request.QueryString("urunid")&""

end if
close(mmmYardimci2)
else
                                if strmsbaslik="" then
strmsbaslik=mmmYardimci1("isim")
                                else
strmsbaslik=strmsbaslik &" ("&mmmYardimci1("isim")&")"
                                end if
icerikid=mmmYardimci1("id")
iceriklink="sayfalar.asp?sek=0&dkate2="&icerikid&"&dataurl="&request.QueryString("dkate2")&"//-//urunid="&request.QueryString("urunid")&""
end if
close(mmmYardimci1)


		sqlString = "select * from moduller where durum = '1' and id="&strmsmodulid&" order by id"
set mmmSayfa2 = Con1.Execute (sqlString)
if mmmSayfa2.eof then
else

if mmmSayfa2("kod")="resim" or (strmsmodulid="115" and icerikuid="3") then
iceriklink=replace(iceriklink,"admin_uruny_duzenle","galeri")
elseif mmmSayfa2("kod")="kategori" then                             

else
end if
  if strmsmodulid="90" then
                                
	  lojik4=con.execute("select count(id) as toplam4 from yazilar where kategori='"&dkate2&"' ")
toplam4ac=lojik4("toplam4")
  lojik5=con.execute("select count(id) as toplam4 from kategoriyazi where anasek='"&dkate2&"' ")
toplam5ac=lojik5("toplam4")
 lojik6=con.execute("select count(fid) as toplam4 from resimd where baslik='"&dkate2&"' ")
toplam6ac=lojik6("toplam4")

sqlString = "SELECT * from yazilar where kategori='"&dkate2&"'"&modulmuagac&"  order by id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
sqlString = "SELECT * from kategori order by id"
srvyid="0"
else
srvyuid=mmmYardimci("urunid")
srvyid=mmmYardimci("id")
sqlString = "SELECT * from kategori where id="&srvyuid&" and ikincii = '1' order by id"
end if
set mmmYardimci1 = Con1.Execute (sqlString)
if mmmYardimci1.eof then
iceriklink="admin_uruny_duzenle.asp?duzelt1=1&urunid="&srvyid&"&baslik="&srvyid&"&sek="&dkate2&"&dkate2="&dkate2&""
else
iceriklink="sayfalar.asp?"&linked&"dkate2="&dkate2&"&sek="&dkate2*1&""
  end if
  close(mmmYardimci)
  close(mmmYardimci1)
                                else
                                toplam4ac="0"
                                toplam5ac="0"
                                end if
		
if strmsonay="1" then
aktifmodulborder=" style=""border: 1px solid #690;"""
alertsil="Aktif Bloğu Silmek İstediniz Pasifleştirilecek."
cbcdisstr="disabled"
cbccheckstr="checked"
else
cbcdisstr=""
cbccheckstr=""
aktifmodulborder=""
alertsil="Bloğu Tamamen Silmek İstediğinize Eminmisiniz?"
end if
strmoduladi=mmmSayfa2("moduladi")
									  
end if

Close(mmmSayfa2)
                    if moduloptfull="" then
                    datamoduljson1=""&replace(yerin,"*","")&""
                    else
                    datamoduljson1=moduloptfull
                    end if
                    datamoduljson=server.URLEncode(""&replace(yerin,"*","")&"")
                    
            modi=modi+1
                            %>

                            <li data-modulid="<% = modulid%>" data-json="<%=datamoduljson1a%>" data-jsonold="<%=datamoduljson%>" id="mod<%=rowi%><%=coli%><%=modi%>" data-id="mod<%=rowi%><%=coli%><%=modi%>" <%=aktifmodulborder%>>
                                <div class="modulHead">
                                    <div style="float: left; line-height: 24px;">
                                        <span class="modulTitle"><i class="fas fa-arrows-alt" style="float: left; margin-top:5px; margin-right:5px;"></i><%=strmsbaslik%> (<% = strmoduladi%>
                                            <%
			  if isNull(strmstemp) then
			  ssatemp="0"
			  else
			  ssatemp=strmstemp
			  end if
 sqlString = "select * from kategoriayar where id="&ssatemp&" order by id desc"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
tasarimad=""
tasarimid="yok"
tasarimadres="0"
else
tasarimad=mmmYardimci2("kate")
tasarimid=mmmYardimci2("id")
tasarimadres=mmmYardimci2("adres")
if tasarimadres="" then
  adres="0"
  else
  adres=tasarimadres
  end if
			  end if
  close(mmmYardimci2)
                                            %>
            )</span>             
                                    </div>
                                    
                                        <%if yetkiuye="1" then%>
                <%end if%>
                <%if strmsmodulid="90" then%>
                                    <div style="float: left; line-height: 24px; position:relative;">
                    <%if (toplam5ac="0" or toplam5ac="0") then%>
                <a href="sayfalar.asp?dkate2=<%=strid%>&sek=<%=dkate2%>" class="dropdown-toggle pull-left" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Sayfalar Ekle"><em class="fas fa-file-plus iconadmin" style="color:#39C;"></em></a>
                <%else%>
                <a href="sayfalar.asp?dkate2=<%=strid%>&sek=<%=dkate2%>" class="dropdown-toggle pull-left" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Alt Sayfalar (<%=toplam5ac%>)"><em class="fa fa-list-alt iconadmin" style="color:#39C;"></em></a>
                <%end if%>
                <%end if%>

                <%if strmsmodulid="90" then
                    if (toplam4ac="0" or toplam4ac="") then%>
                                        <ul class="nav-pills pull-left" role="tablist" style="padding:0px;">
                    <%
sqlString = "SELECT * from yazilar where kategori='"&dkate2&"'"&modulmuagac&"  order by id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
sqlString = "SELECT * from kategori order by id"
srvyid="0"
else
srvyuid=mmmYardimci("urunid")
srvyid=mmmYardimci("id")
sqlString = "SELECT * from kategori where id="&srvyuid&" and ikincii = '1' order by id"
end if
set mmmYardimci1 = Con1.Execute (sqlString)
if mmmYardimci1.eof then
iceriklink="admin_uruny_duzenle.asp?duzelt1=1&urunid="&srvyid&"&baslik="&srvyid&"&sek="&strid&"&dkate2="&strid&""
else
iceriklink="?"&linked&"dkate2="&dkate2&"&sek="&dkate2*1&""
                        %>
                    <li role="presentation" class="btn-danger dropdown-toggle btn-xs" style="margin:2px 0;">
                        <%if strmslock="1" and yetkiuye<>"1" then %><%else %><a id="drop4" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"><em class="fa fa-plus" style=" color:#FFF;"></em></a><%end if %>
                      <ul id="menu6" class="dropdown-menu animated fadeInDown" role="menu">
                        <%Do While Not mmmYardimci1.EOF
strviadres=mmmYardimci1("adres")
strviikincii=mmmYardimci1("ikincii")
strviid=mmmYardimci1("id")
strvikate=mmmYardimci1("kate")
if mmmYardimci.eof then
if instr(strviadres,"a_icerik_ekle") then
acilim=" data-toggle=""modal"" data-target=""#baslikmodal"""
else
acilim=""
end if
acilimadres=strviadres
formicev=""
else
acilim=""
acilimadres="admin_uruny_duzenle.asp?modulv=0&yazi=yeni"
sqlString = "select * from ozellikler2 where kateid='"&srvyid&"'"
set mmmYardimci3 = Con.Execute (sqlString)
if mmmYardimci3.eof then
formid="1"
formicev=""
else
formid=mmmYardimci3("formid")
formicev="&formice="&formid&""
end if
close(mmmYardimci3)
end if
%>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="<%=acilimadres%>&modul=0&dkate2=<%=strid%>&dkate=<%=strid%>&coklu=<%=strviikincii%>&iceriktur=<%=strviid%><%=formicev%>&titlee=<%=server.urlencode(strisim) %>"<%=acilim%>><%=strvikate%></a></li>
                        <%mmmYardimci1.MoveNext
  loop
%>
                      </ul>
                    </li>
                    <%
  end if
  close(mmmYardimci)
  close(mmmYardimci1)
  %>
                  </ul>
                <%else%>
                <a href="<%=iceriklink%>" class="dropdown-toggle pull-left" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçerik Sayfaları (<%=toplam4ac%>)"><em class="fas fa-sign-out-alt iconadmin" style="color:#673ab7;"></em> </a>
                <%end if%>
                                        </div>
                <%end if%>


                                    <div style="float: right; margin-left: 10px; margin-top: 5px;">
                       

                                        <%if icerikid="yok" or (strmslock="1" and yetkiuye<>"1") then%><%else%>
                                        <div class="ienlarger" style="float: left;">
                                            <a href="<%=iceriklink%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçeriğe Git"><em class="fas fa-sign-out-alt iconadmin"></em></a>
                                        </div>
                                        <%end if%>
                                        <div class="ienlarger" style="float: left;">
                                            <%if tasarimid="yok" then%>
                                            <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Css Ekle">
                                                <a href="ortak_sayfalar_ayar.asp?dkate2=<%=request("dkate2")%>&smid=<%=modulid%>&sayfaayar=cssekled&yer=<%=replace(yerin," ","*-")%>" data-toggle="modal" data-target="#baslikmodal"><em class="far fa-css3 iconadmin" style="color: #C00;"></em></a>
                                            </div>
                                            <%else%>
                                            <a href="ortak_kategoriayard.asp?turduzen=1&urunid=<%=tasarimid%>&adres=<%=adres%>&sek=<%=request.QueryString("dkate2")%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Css Düzenle"><em class="far fa-css3 iconadmin" style="color: #390;"></em></a>
                                            <%end if%>
                                        </div>
                                        <div class="ienlarger" style="float: left;" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Düzenle"><a href="db.asp?islem=blocktab&blocktabcol=editmodul&checked=md<%=rowi%><%=modulid%><%=coli%><%=modi%>&checked1=mod<%=rowi%><%=coli%><%=modi%>&blockstring=<%=datamoduljson%>" class="dropdown-toggle moduledit" data-toggle="modal" data-target="#moduladd" style="cursor: pointer;"><em class="fas fa-pencil-alt iconadmin" style="color: #39C;"></em></a></div>
                                        <%if yetkiuye="1" then%>
                                        <div class="ienlarger" style="float: left;"><a onclick="divremove('mod<%=rowi%><%=coli%><%=modi%>')" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil" style="cursor: pointer;<%if cbcdisstr<>"disabled" then%><%else%>display:none;<%end if%>" class="delmodul"><em class="fas fa-trash-alt iconadmin" style="color: #F00;"></em></a></div>
                                        <%else
	end if
                                        %>    
                                    </div>

                                </div>

                            </li>

                            <script>
				<%if moduloptfull="" then
     else%>
     document.addEventListener('DOMContentLoaded', function() {
     updatedatajson('<%=moduloptfull %>','mod<%=rowi%><%=coli%><%=modi%>');
     });
     <%end if %>
function postConfirm<%=modulid%>() {
    if (confirm('<%=alertsil%>')) {
        yourformelement<%=modulid%>.submit();
    } else {
        return false;
    }
}
                            </script>
                            <% 
                    moduloptfull=""
				modcol=""
 next%>
                            <a class="divadd" onclick="btn4('<%=rowi%><%=coli%>','m<%=rowi%><%=coli%>');">+</a>
                            <a id="c<%=rowi%><%=coli%>" class="divdel" onclick="divremove('c<%=rowi%><%=coli%>');">-</a>
                        </ol>
                    </li>
                    <%next %>
                    <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=rowi%>','c<%=rowi%>');">+</div>
                </ol>
            </li>
            <%
            next
            'yenibit
            else
            'eski basla
		'response.Write(strrowtemp)		
sablon=strrowtemp
                if instr(sablon,"[row]") then
rowcount=ubound(split(sablon,"[row]"))
                else
rowcount="0"
                end if
if rowcount="0" then
else
for rowi=1 to rowcount
rowid=split(sablon,"[row]")(rowi)
rowoptioncount=ubound(split(rowid,","))
'if rowoptioncount=>2 then
rowtype=split(rowid,",")(0)
rowrespons=split(rowid,",")(1)
rowcol=rowid
if rowrespons="column" then
rowtypee="column"
else
rowtypee="container"
end if
            %>
            <li data-id="row<%=rowi%>" data-type="<%=rowtype%>" data-cont="<%=rowtypee%>" id="r<%=rowi%>">
                <div class="rowHead">
                    <span class="columnTitle"><i class="fas fa-arrows-alt" style="float: left;"></i>
                        <select id="rowtypee<%=rowi%>" size="1" name="rowtypee" onchange="contchange('rowtypee<%=rowi%><%=coli%>','r<%=rowi%>');" style="width: auto; border: none; background: none;">
                            <option value="column" <%if rowtypee="column" then%>selected<%else%><%end if%>>Full Genişlik row<%=rowi%></option>
                            <option value="container" <%if rowtypee="container" then%>selected<%else%><%end if%>>Daraltılmış Genişlik row<%=rowi%></option>
                        </select></span><a class="divdelrow" onclick="divremove('r<%=rowi%>');">-</a>
                </div>
                <%
colcount=ubound(split(rowcol,"{col}"))
                %>
                <ol class="columnParent" id="c<%=rowi%>">
                    <%
for coli=1 to colcount
colid=split(rowcol,"{col}")(coli)
colid=split(colid,"{/col}")(0)
coloptioncount=ubound(split(colid,"{modul}"))
'if coloptioncount>=1 then
coltype=split(colid,",")(0)
                    %>
                    <li data-id="col<%=rowi%><%=coli%>" data-colmd="<%=coltype%>" class="<%=coltype%>" id="c<%=rowi%><%=coli%>">
                        <div class="columnHead">
                            <span class="columnTitle"><i class="fas fa-arrows-alt" style="float: left;"></i>
                                <select id="coltype<%=rowi%><%=coli%>" size="1" name="coltype" onchange="colchange('coltype<%=rowi%><%=coli%>','c<%=rowi%><%=coli%>');" style="width: auto; border: none; background: none;">
                                    <%for coliselect=1 to 12%>
                                    <option value="col-md-<%=coliselect%>" <%if coltype="col-md-"&coliselect&"" then%>selected<%else%><%end if%>>col-md-<%=coliselect%></option>
                                    <%next%>
                                </select></span>
                        </div>
                        <ol class="columnParent2" id="m<%=rowi%><%=coli%>">
                            <%
for modi=1 to coloptioncount
modultam=split(colid,"{modul}")(modi)
modultam=split(modultam,"{/modul}")(0)
                      if instr(modultam,",") then
    bscnt=ubound(split(blockstring,","))  
    modulid=split(modultam,",")(0)
    strmsbaslik=split(modultam,",")(1)
    strmssayfa=split(modultam,",")(2)
    strmssayfa1=split(modultam,",")(2)
    strmsmodulid=split(modultam,",")(3)
    strmstemp=split(modultam,",")(4)
    strmsgoster=split(modultam,",")(5)
    strmsonay=split(modultam,",")(6)
        if bscnt>6 then
    strmsmdurum=split(modultam,",")(7)
    strmsozel=split(modultam,",")(8)
    strmsozelvar=split(modultam,",")(9)
        end if
        if bscnt>9 then
    strmsmlock=split(modultam,",")(10)
        end if
        end if

if isNull(strmssayfa) or instr(strmssayfa,"vip")="1" then
		strmssayfaozel=replace(strmssayfa,"vip","")
        strmsozel=strmssayfaozel
        strmsozelvar="1"
		strmssayfa=strmssayfa
		strmssayfa1="0"
		else
		strmssayfa=strmssayfa
		strmssayfa1=strmssayfa
        strmssayfaozel="0"
        strmsozel=strmssayfa
        strmsozelvar="0"
		end if
		if instr(strmssayfa1,"k") then
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")&"00000"
		elseif instr(strmssayfa,"y") then
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")&"00000"
		else
		strmssayfak=replace(replace(strmssayfa1,"k",""),"y","")
		strmssayfay=replace(replace(strmssayfa1,"k",""),"y","")
		end if
                
                    moduloptfullold="[{""name"":""mid"",""value"":"""&modulid&"""},{""name"":""toplu"",""value"":""1""},{""name"":""ladet"",""value"":""0""},{""name"":""moduldurumu"",""value"":"""&strmsmdurum&"""},{""name"":""goster"",""value"":"""&strmsgoster&"""},{""name"":""baslik"",""value"":"""&strmsbaslik&"""},{""name"":""sayfa"",""value"":"""&strmssayfa&"""},{""name"":""sayfaozelvar"",""value"":"""&strmsozelvar&"""},{""name"":""sayfaozel"",""value"":"""&strmsozel&"""},{""name"":""moduller"",""value"":"""&strmsmodulid&"""},{""name"":""temp"",""value"":"""&strmstemp&"""},{""name"":""yetki"",""value"":"""&strmsonay&"""},{""name"":""lock"",""value"":"""&strmsmlock&"""}]"

                    if moduloptfull="" then
                    moduloptfull=moduloptfullold
                    end if

yerin=modulid&","&strmsbaslik&","&strmssayfa&","&strmsmodulid&",*"&strmstemp&"*,"&strmsgoster&","&strmsonay&",0,"&strmsozel&","&strmsozelvar&","&strmsmlock
                    
		 sqlString = "SELECT * from kategoriyazi where id="&strmssayfak&""
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then

sqlString = "SELECT * from yazilar where id="&strmssayfay&""
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
icerikid="yok"
iceriklink=""
else
icerikid=mmmYardimci2("id")
icerikuid=mmmYardimci2("urunid")
icerikkate=mmmYardimci2("kategori")
sqlString = "SELECT * from kategori where id="&icerikuid&""
set mmmSayfa = Con1.Execute (sqlString)
if mmmSayfa.eof then
turadres="admin_uruny_duzenle.asp?"
turid="115"
else
turadres=mmmSayfa("adresd")
turid=mmmSayfa("id")
end if
close(mmmSayfa)
                                if icerikkate="" or isNull(icerikkate) then
                                icerikkate=dkate2
                                end if
iceriklink=""&turadres&"duzelt1="&turid&"&urunid="&icerikid&"&baslik="&icerikid&"&sek="&icerikkate&"&dkate2="&request.QueryString("dkate2")&"&dataurl="&request.QueryString("dkate2")&"//-//urunid="&request.QueryString("urunid")&""

end if
close(mmmYardimci2)
else
icerikid=mmmYardimci1("id")
iceriklink="sayfalar.asp?sek=0&dkate2="&icerikid&"&dataurl="&request.QueryString("dkate2")&"//-//urunid="&request.QueryString("urunid")&""
end if
close(mmmYardimci1)


sqlString = "select * from moduller where durum = '1' and id="&strmsmodulid&" order by id"
set mmmSayfa2 = Con1.Execute (sqlString)
if mmmSayfa2.eof then
else

if mmmSayfa2("kod")="resim" or (strmsmodulid="115" and icerikuid="3") then
iceriklink=replace(iceriklink,"admin_uruny_duzenle","galeri")
elseif mmmSayfa2("kod")="kategori" then
else
end if

		
if strmsonay="1" then
aktifmodulborder=" style=""border: 1px solid #690;"""
alertsil="Aktif Bloğu Silmek İstediniz Pasifleştirilecek."
cbcdisstr="disabled"
cbccheckstr="checked"
else
cbcdisstr=""
cbccheckstr=""
aktifmodulborder=""
alertsil="Bloğu Tamamen Silmek İstediğinize Eminmisiniz?"
end if
strmoduladi=mmmSayfa2("moduladi")
									  
end if

Close(mmmSayfa2)

'?islem=kateekle&sek=0&iceriktur=115&turu=90&sektor=<%=mmmYardimci("baslik")%'>&turduzen=1&cssyeni=1&urunid=<%=mmmYardimci("id")%'>&adres=<%=adres%'>"
                    'datamoduljson=replace(""&modulid&","&strmsbaslik&","&strmssayfa1&","&strmsmodulid&","&strmstemp&","&strmsgoster&","&strmsonay&",md"&rowi&""&modulid&""&coli&""&modi&",0"," ","%20")
                    datamoduljson1=""&replace(yerin,"*","")&""
                    datamoduljson=server.URLEncode(datamoduljson1)
                    
                            %>

                            <li data-modulid="<% = modulid%>" data-json="<%=datamoduljson1a%>" data-jsonold="<%=datamoduljson%>" id="mod<%=rowi%><%=coli%><%=modi%>" data-id="mod<%=rowi%><%=coli%><%=modi%>" <%=aktifmodulborder%>>
                                <div class="modulHead">
                                    <div style="float: left; line-height: 24px;">
                                        <span class="modulTitle"><i class="fas fa-arrows-alt" style="float: left;"></i><%=strmsbaslik%> (<% = strmoduladi%>
                                            <%
			  if isNull(strmstemp) then
			  ssatemp="0"
			  else
			  ssatemp=strmstemp
			  end if
 sqlString = "select * from kategoriayar where id="&ssatemp&" order by id desc"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
tasarimad=""
tasarimid="yok"
tasarimadres="0"
else
tasarimad=mmmYardimci2("kate")
tasarimid=mmmYardimci2("id")
tasarimadres=mmmYardimci2("adres")
if tasarimadres="" then
  adres="0"
  else
  adres=tasarimadres
  end if
			  end if
  close(mmmYardimci2)
                                            %>)</span>
                                    </div>


                                    <div style="float: right; margin-left: 10px; margin-top: 5px;">
                                        <%if icerikid="yok" then%><%else%>
                                        <div class="ienlarger" style="float: left;">
                                            <a href="<%=iceriklink%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçeriğe Git"><em class="fas fa-sign-out-alt iconadmin"></em></a>
                                        </div>
                                        <%end if%>
                                        <div class="ienlarger" style="float: left;">
                                            <%if tasarimid="yok" then%>
                                            <div data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Css Ekle">
                                                <a href="ortak_sayfalar_ayar.asp?dkate2=<%=request("dkate2")%>&smid=<%=modulid%>&sayfaayar=cssekled&yer=<%=replace(yerin," ","*-")%>" data-toggle="modal" data-target="#baslikmodal"><em class="far fa-css3 iconadmin" style="color: #C00;"></em></a>
                                            </div>
                                            <%else%>
                                            <a href="ortak_kategoriayard.asp?turduzen=1&urunid=<%=tasarimid%>&adres=<%=adres%>&sek=<%=request.QueryString("dkate2")%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Css Düzenle"><em class="far fa-css3 iconadmin" style="color: #390;"></em></a>
                                            <%end if%>
                                        </div>
                                        <div class="ienlarger" style="float: left;" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Düzenle"><a href="db.asp?islem=blocktab&blocktabcol=editmodul&checked=md<%=rowi%><%=modulid%><%=coli%><%=modi%>&checked1=mod<%=rowi%><%=coli%><%=modi%>&blockstring=<%=datamoduljson%>" class="dropdown-toggle moduledit" data-toggle="modal" data-target="#moduladd" style="cursor: pointer;"><em class="fas fa-pencil-alt iconadmin" style="color: #39C;"></em></a></div>
                                        <%if yetkiuye="1" then%>
                                        <div class="ienlarger delmodul" style="float: left;"><a onclick="divremove('mod<%=rowi%><%=coli%><%=modi%>')" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil" style="cursor: pointer;<%if cbcdisstr<>"disabled" then%><%else%>display:none;<%end if%>" class="delmodul"><em class="fas fa-trash-alt iconadmin" style="color: #F00;"></em></a></div>
                                        <%else
	end if
                                        %>
                                    </div>

                                </div>

                            </li>

                            <script>
				
				<%if moduloptfull="" then
     else%>
     document.addEventListener('DOMContentLoaded', function() {
     updatedatajson('<%=moduloptfull %>','mod<%=rowi%><%=coli%><%=modi%>');
     });
     <%end if %>

function postConfirm<%=modulid%>() {
    if (confirm('<%=alertsil%>')) {
        yourformelement<%=modulid%>.submit();
    } else {
        return false;
    }
}
                            </script>
                            <% 
                    moduloptfull=""
                    moduloptfullold=""
				modcol=""
 next%>
                            <a class="divadd" onclick="btn4('<%=rowi%><%=coli%>','m<%=rowi%><%=coli%>');">+</a>
                            <a id="c<%=rowi%><%=coli%>" class="divdel" onclick="divremove('c<%=rowi%><%=coli%>');">-</a>
                        </ol>
                    </li>
                    <%
			
'else
'end if
modcol=""
next
                    %>
                    <div id="btn3" class="appendekle btn btn-primary" onclick="btn3('<%=rowi%>','c<%=rowi%>');">+</div>
                </ol>

            </li>
            <%
'else
'end if
next
end if
end if
'eski bitis
            %>
        </ol>
        <div id="btn2" class="appendekle btn btn-primary">+</div>
    <input name="serializede" type="hidden" value="" id="serialize_outputhidden" /> 
        <%elseif langstr<>"" and langstr<>contdil then %>   
<div class="alert alert-danger">
  <strong>Uyarı!</strong> Blok Düzeni Ana Çeviri Sayfasından Alınıyor. 
</div>
    <input name="serializede" type="hidden" value="" id="serialize_outputhidden" />              
        <%else %>                
<div class="alert alert-info">
  <h4><strong>Uyarı!</strong> Blok Düzeni Başka Sayfadan Alınıyor. </h4>
   
    <li style="color:#ffffff;" ><a href="sayfalar.asp?alt1=<%=dkate2 %>&dkate2=<%=dkate2 %>&sek=<%=dkate2 %>" style="color:#ffffff; font-weight:bold;" class=" btn btn-success">İçerikler</a><a href="ortak_sayfalar_ayar.asp?sayfaayar=modul&dkate2=<%=smidsayara %>" style="color:#ffffff; font-weight:bold;" class=" btn btn-warning">Ana Blok Düzenine Geç</a></li>
    <li style="color:#ffffff;" >Blok Düzenini &nbsp;<a href="?id=&baslik=&sek=<%=stranasek %>&dkate2=<%=dkate2 %>&sayfaayar=modul&islemim=blokozellestir" style="color:#ffffff; font-weight:bold;" class=" btn btn-danger btn-xs">Özelleştir</a></li>
    <li style="color:#ffffff;">Başka Blok Düzenini&nbsp;<a data-toggle="tab" href="#kopyala" style="color:#ffffff; font-weight:bold;" class="btn btn-danger btn-xs">Kopyala</a></li>
</div>
    <input name="serializede" type="hidden" value="" id="serialize_outputhidden" /> 
        <%
          end if 
            
            if langstr<>"" and langstr&""<>""&contdil then
            else
            'düzenleme yapılınca bu kodu kaydet butonu altına getirelim
        %>   
<button id="btn2" type="submit" class="btn btn-success btn-lg">KAYDET</button>
        <%
            if yetkiuye="1" then %>
<a href="?islem=cachepage&aid=<%=dkate2 %>&seolink=<%=siteadres %><%=smidseolink %>&seolinkim=<%=smidseolink %>&dkate2=<%=dkate2 %>&sayfaayar=modul&sek=<%=dkate2 %>"><button  type="button" class="btn btn-danger pull-right">Cache Page</button></a>
        <%end if %>
        <a href="?islem=cssduzenlemodul&aid=<%=dkate2 %>&seolink=<%=siteadres %>i/<%=smidseolink %>&seolinkim=<%=smidseolink %>&dkate2=<%=dkate2 %>&sayfaayar=modul&sek=<%=dkate2 %>"><button  type="button" class="btn btn-warning pull-right">Css Element Duzenle</button></a>
         <%end if %>
</div>

</form>
      </div>    

                        <div id="seo" class="tab-pane fade">
<%call seoserp(strid,"sayfa",ceviridileki,aktifdil,"?urunid="&request("urunid")&"&dkate2="&dkate2&"&sayfaayar="&request("sayfaayar")&"&Submit=sayfatumDuzenle")%>

                        </div>

                  <%if langstr<>"" and langstr<>contdil then
                      else%>
                        <div id="kopyala" class="tab-pane fade">
<form action="?" name="custlist18" method="post">
                       <select name="kopyaid" id="kopyaid" style="width:100%;" class="selctize1">
              <option value="0">İçeriklere Özel </option>
              <%
sqlString = "SELECT * from kategoriyazi where alt like '1'"&sayfagosterme&" order by modulmu,sira"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
              <option value="<%=mmmYardimci("id")%>" style="background:#ebebeb;"><%=mmmYardimci("isim")%></option>
                            <%
sqlString = "SELECT * from kategoriyazi where anasek = '"&mmmYardimci("id")&"' order by modulmu,sira"
set mmmYardimci1 = Con.Execute (sqlString)
Do While Not mmmYardimci1.EOF
%>
              <option value="<%=mmmYardimci1("id")%>">&nbsp;&nbsp;>&nbsp;<%=mmmYardimci1("isim")%></option>
              <%
sqlString = "SELECT * from kategoriyazi where anasek = '"&mmmYardimci1("id")&"' order by modulmu,sira"
set mmmYardimci2 = Con.Execute (sqlString)
Do While Not mmmYardimci2.EOF
%>
              <option value="<%=mmmYardimci2("id")%>">&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;<%=mmmYardimci2("isim")%></option>
<%
  mmmYardimci2.MoveNext
  loop
  close(mmmYardimci2)%>
<%
  mmmYardimci1.MoveNext
  loop
  close(mmmYardimci1)%>
<%
  mmmYardimci.MoveNext
  loop
  close(mmmYardimci)%>
            </select>
            <label><input name="kopyaeskisil" type="checkbox" value="1" checked="checked" />Bu Sayfanın Modüllerini Güncelle</label>
            <input name="Submit" type="submit" value="Düzenle" class="btn btn-primary pull-right" style="width:100% !important;" ONCLICK="this.form.submit();formla8('?urunid=<%=request("urunid")%>&dkate2=<% =dkate2%>&sayfaayar=<%=request("sayfaayar")%>&kopyatur=1&islem=sayfakopyala');"/>
                        </form>
                        </div>
                  <%end if %>
  </div>
      <%end if %>
      
        <!--#Include file="codeeditor.html"-->
</div>
  </div>
 <SCRIPT LANGUAGE="JavaScript">

	function formla7(gelen7)
	{
	document.custlist17.action=gelen7;
	document.custlist17.submit();
	}
	function formla8(gelen8)
	{
	document.custlist18.action=gelen8;
	document.custlist18.submit();
	}
  //-->
  </SCRIPT>
<%call footer(1)%>
<style>
        #moduladd .modal-dialog {
  width: 90%;
  height: 80%;
  margin: 4% auto;
  padding: 0;
}

 #moduladd .modal-content {
  height: auto;
  min-height: 100%;
  border-radius: 0;
}


</style>
<div id="moduladd" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Yükleniyor</h4>
                        </div>

						<div class="modal-body with-padding" style="padding: 0px; margin: 0px; width: 100%;">
							
						</div>

						<div class="modal-footer">
							<button class="btn btn-warning" data-dismiss="modal">Close</button>
							<button class="btn btn-primary">Save</button>
						</div>
					</div>
				</div>
			</div>
<script>
    
    function updatedatajson(jsond,jsonmodid)
    {
    var jsonStringdata = JSON.stringify(jsond, null, ' ');
    $('#'+jsonmodid+'').attr('data-json', jsonStringdata).data('json', ''+jsond+'');
    }

function divremove(checked)
	{
		var data3=document.getElementById(checked);
		data3.remove();
		updateserialize();
	}
	function mdetailjs(checked)
	{
		var data4=document.getElementById(checked);
    $( data4 ).toggleClass( "moduldv", 1000 );	
	}

    function btn3(checked,checked1)
	{
	var ollicount=$('li[data-id^="col"]').length+1;    
    getajaxstr("db.asp?islem=blocktab&blocktabcol=addcolumn&blockstring=" + ollicount+"&checked=" + checked+"&checked1=" + checked1+"",function (response) {
    var strblock=response;    
    $("ol#"+checked1+"").append(strblock);
	updateserialize();
});
	updateserialize();
    }
    	
    function btn4(checked,checked1)
	{
	var ollicount=$('ol#'+checked1+' > li').length+1;      
	var ollicount1=$('ol li ol li ol li').length+1;      
    getajaxstr("db.asp?islem=blocktab&blocktabcol=addmodul&blockstring=" + ollicount1+"&checked=" + checked+"&checked1=" + checked1+"",function (response) {
    var strblock=response;    
    $("ol#"+checked1+"").append(strblock);
    $('#moduladd').modal();
    //var loadurl = $(e.relatedTarget).data('load-url');
    var loadurl = "db.asp?islem=blocktab&blocktabcol=editmodul&checked=md"+ollicount1+"&checked1=mod"+checked+""+ollicount1+"&blockstring=1%2CYeni+Modul%2C0%2C0%2C0%2C2%2C1%2C1%2C0%2C0";
    //console.log(loadurl);
    $('#moduladd').find('.modal-content').load(loadurl);

	updateserialize();
});
    
	updateserialize();
	updateselectize();
    }


function colchange(checked,checked1)
 {
		var data2=document.getElementById(checked1);
		var data=data2.className;
		$(data2).removeClass(data);
        var data1=document.getElementById(checked);
        var multipleValues = $( data1 ).val() || [];
        $(data2).addClass(multipleValues);
    
    $('#'+checked1+'').attr('data-colmd', multipleValues).data('colmd', multipleValues);
		updateserialize();
 }    

function contchange(checked,checked1)
 {
		var data2=document.getElementById(checked1);
        var data1=document.getElementById(checked);
        var multipleValues = $( data1 ).val() || [];
        $(data2).addClass(multipleValues);
    
    $('#'+checked1+'').attr('data-cont', multipleValues).data('cont', multipleValues);
		updateserialize();
 }

function confirmSubmit(caller) {
  var form = caller.parents("form");
  jConfirm('Are you sure?', 'Please Confirm', function(result){
    if (result) {
      form.submit();
    } else {
      return false;
    }
  });
}

    </script>
<script>

    
var group = $("ol.nested_with_switch > li > ol > li > ol").sortable({
  handle: 'i.fa-arrows-alt',
  nested: false,
  delay: 500,
  group: 'columnParent2', 
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});
var group = $("ol.nested_with_switch > li > ol").sortable({
  handle: 'i.fa-arrows-alt',
  nested: false,
  delay: 500,
  group: 'columnParent', 
  isValidTarget: function  ($item, container) {
    if($item.is(".columnParent > li"))	
      return true;	 
    else
      return $item.parent("ol")[0] == container.el[0];
  },
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	 
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});

var group = $("ol.nested_with_switch").sortable({
  handle: 'i.fa-arrows-alt',
  nested: false,
  delay: 500,
  group: 'nested_with_switch', 
  isValidTarget: function  ($item, container) {
    if($item.is(".nested_with_switch > li"))	
      return true;	 
    else
      return $item.parent("ol")[0] == container.el[0];
  },
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {    
	container.el.removeClass("active");
	 
	var data = group.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

    //$('#serialize_output2').text(jsonString);
	document.getElementById("serialize_outputhidden").value = jsonString;
	//document.getElementById("serialize_outputtarea").value = jsonString;
    _super($item, container);
  }
});
function updateserialize(){
   var groups = $("ol.nested_with_switch").sortable("refresh");
	var data = groups.sortable("serialize").get();

    var jsonString = JSON.stringify(data, null, ' ');

	document.getElementById("serialize_outputhidden").value = jsonString;

	}


    function showSerialize25(checked,checked1) {

        //foroldjson

            var modid=$( 'table#'+checked+' input[name=mid]' ).val();
            var strmsbaslik=$( 'table#'+checked+' input[name=baslik]' ).val();
            var strmssayfa=$( 'table#'+checked+' *[name=sayfa]' ).find(":selected").val();
            var strmsmodulid=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").val();
            var strmsmodulname=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").text();
            var strmstemp=$( 'table#'+checked+' *[name=temp]' ).find(":selected").val();
            var strmsgoster=$( 'table#'+checked+' *[name=goster]' ).val();
            var strmsonay=$( 'table#'+checked+' *[name=yetki]' ).find(":selected").val();
            var strmsmdurum=$( 'table#'+checked+' input[name=moduldurumu]' ).val();
            var strmsozel=$( 'table#'+checked+' input[name=sayfaozel]' ).val();
            var strmsozelvar=$( 'table#'+checked+' *[name=sayfaozelvar]' ).find(":selected").val();
            var strmlock=$( 'table#'+checked+' *[name=lock]' ).find(":selected").val();

       if (strmsmodulid=="115" && strmssayfa=="0" && strmsmdurum=="1"){
    getajaxstr("db.asp?islem=htmlekle&strmsbaslik=" + strmsbaslik+"&strmsmodulid=" + strmsmodulid+"",function (response) {   
    var strmssayfanew=response;
    $('table#'+checked+' *[name=sayfa] option[value="0"]').val(strmssayfanew)
  $( 'table#'+checked+' *[name=sayfa]' ).val(strmssayfanew);
  $( 'table#'+checked+' *[name=sayfaozel]' ).val(strmssayfanew);
    //console.log(strmssayfanew);
    
});
    //return false;    
    var htmlyenivar='1';
    }
 setTimeout(function(){    
    strmssayfa=$( 'table#'+checked+' *[name=sayfa]' ).find(":selected").val();
    json=encodeURIComponent("1,"+strmsbaslik+","+strmssayfa+",115,0,2,1,0,"+strmssayfa+",0")
    newmodulhref="db.asp?islem=blocktab&blocktabcol=editmodul&checked="+checked+"&checked1="+checked1+"&blockstring="+json+""
    newmodulinsertbut="<div class='ienlarger' style='float: left;'><a href='admin_uruny_duzenle.asp?duzelt1=1&urunid="+strmssayfa.replace("y", "")+"&baslik="+strmssayfa.replace("y", "")+"&sek=1&dkate2=<%=request.querystring("dkate2") %>&dataurl=<%=request.querystring("dkate2") %>//-//urunid=' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='İçeriğe Git'><em class='fas fa-sign-out-alt iconadmin'></em></a></div>"
    //console.log(strmssayfa);
            var jsonold=''+modid+','+strmsbaslik+','+strmssayfa+','+strmsmodulid+','+strmstemp+','+strmsgoster+','+strmsonay+','+strmsmdurum+','+strmsozel+','+strmsozelvar+','+strmlock+''
    if (strmsonay=="1"){
    $('#'+checked1+'').attr('style', "border: 1px solid #690;")
    $('#'+checked1+' .delmodul').attr('style', "display: none;")
    }else{
    $('#'+checked1+'').attr('style', "border: 0px solid #690;")
    $('#'+checked1+' .delmodul').attr('style', "display: block;")
    }

        var fields = $( 'table#'+checked+' :input' ).serializeArray();
    //console.log(fields);

var flatObject = {};
fields.forEach(function(field) {
    flatObject[field.name] = field.value;
});

        var jsonStringdata = JSON.stringify(flatObject, null, ' ');
    console.log(jsonStringdata);
        //fornewjson
            $('#'+checked1+'').attr('data-json', jsonStringdata).data('json', flatObject);
            $('#'+checked1+'').attr('data-jsonold', jsonold).data('jsonold', jsonold);
            $('#'+checked1+' .modulTitle').html('<i class="fas fa-arrows-alt" style="float: left;"></i> '+strmsbaslik+' ('+strmsmodulname+')');
            $('#'+checked1+' .modulHead a.moduledit').attr("href", 'db.asp?islem=blocktab&blocktabcol=editmodul&checked='+checked+'&checked1='+checked1+'&blockstring='+jsonold+'');

            //$.each(fields, function(i, field){
            //$('#'+checked1+'').attr('data-'+field.name+'', field.value).data(''+field.name+'', field.value);
            //});
            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    if (htmlyenivar=="1"){
    $('#'+checked1+' .moduledit').attr('href', newmodulhref);
    $('#'+checked1+' .modulHead > div:nth-child(2)').append(newmodulinsertbut);
                    var formData = $('.block-form').serializeArray(),
                    data = {};

                $(formData).each(function (index, obj) {
                    data[obj.name] = obj.value;
                });
				// Ajax Submit
				$.ajax({
					type: 'POST',
					url: $('.block-form').attr('action'),
					data: data
				}).always(function(data, textStatus, jqXHR) {
    //console.log(data.response);

					if (data.response == 'success') {

						// Uncomment the code below to redirect for a thank you page
						// self.location = 'thank-you.html';
						
						return;

					} 


				});
    }
    }
    , 1000);
    }


    function showSerialize(checked,checked1) {

        //foroldjson

            var modid=$( 'table#'+checked+' input[name=mid]' ).val();
            var strmsbaslik=$( 'table#'+checked+' input[name=baslik]' ).val();
            var strmssayfa=$( 'table#'+checked+' *[name=sayfa]' ).find(":selected").val();
            var strmsmodulid=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").val();
            var strmsmodulname=$( 'table#'+checked+' *[name=moduller]' ).find(":selected").text();
            var strmstemp=$( 'table#'+checked+' *[name=temp]' ).find(":selected").val();
            var strmsgoster=$( 'table#'+checked+' *[name=goster]' ).val();
            var strmsonay=$( 'table#'+checked+' *[name=yetki]' ).find(":selected").val();
            var strmsmdurum=$( 'table#'+checked+' input[name=moduldurumu]' ).val();
            var strmsozel=$( 'table#'+checked+' input[name=sayfaozel]' ).val();
            var strmsozelvar=$( 'table#'+checked+' *[name=sayfaozelvar]' ).find(":selected").val();
            var strmlock=$( 'table#'+checked+' *[name=lock]' ).find(":selected").val();

       if (strmsmodulid=="115" && strmssayfa=="0" && strmsmdurum=="1"){
    getajaxstr("db.asp?islem=htmlekle&strmsbaslik=" + strmsbaslik+"&strmsmodulid=" + strmsmodulid+"",function (response) {   
    var strmssayfanew=response;
    $('table#'+checked+' *[name=sayfa] option[value="0"]').val(strmssayfanew)
  $( 'table#'+checked+' *[name=sayfa]' ).val(strmssayfanew);
  $( 'table#'+checked+' *[name=sayfaozel]' ).val(strmssayfanew);
    //console.log(strmssayfanew);
    
});
    //return false;    
    var htmlyenivar='1';
    }
 setTimeout(function(){    
    strmssayfa=$( 'table#'+checked+' *[name=sayfa]' ).find(":selected").val();
    json=encodeURIComponent("1,"+strmsbaslik+","+strmssayfa+",115,0,2,1,0,"+strmssayfa+",0")
    newmodulhref="db.asp?islem=blocktab&blocktabcol=editmodul&checked="+checked+"&checked1="+checked1+"&blockstring="+json+""
    newmodulinsertbut="<div class='ienlarger' style='float: left;'><a href='admin_uruny_duzenle.asp?duzelt1=1&urunid="+strmssayfa.replace("y", "")+"&baslik="+strmssayfa.replace("y", "")+"&sek=1&dkate2=<%=request.querystring("dkate2") %>&dataurl=<%=request.querystring("dkate2") %>//-//urunid=' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='İçeriğe Git'><em class='fas fa-sign-out-alt iconadmin'></em></a></div>"
    //console.log(strmssayfa);
            var jsonold=''+modid+','+strmsbaslik+','+strmssayfa+','+strmsmodulid+','+strmstemp+','+strmsgoster+','+strmsonay+','+strmsmdurum+','+strmsozel+','+strmsozelvar+','+strmlock+''
    if (strmsonay=="1"){
    $('#'+checked1+'').attr('style', "border: 1px solid #690;")
    $('#'+checked1+' .delmodul').attr('style', "display: none;")
    }else{
    $('#'+checked1+'').attr('style', "border: 0px solid #690;")
    $('#'+checked1+' .delmodul').attr('style', "display: block;")
    }

        var fields = $( 'table#'+checked+' :input' ).serializeArray();
    //console.log(fields);
        var jsonStringdata = JSON.stringify(fields);
    //console.log(jsonStringdata);
        //fornewjson
            $('#'+checked1+'').attr('data-json', jsonStringdata).data('json', fields);
            $('#'+checked1+'').attr('data-jsonold', jsonold).data('jsonold', jsonold);
            $('#'+checked1+' .modulTitle').html('<i class="fas fa-arrows-alt" style="float: left;"></i> '+strmsbaslik+' ('+strmsmodulname+')');
            $('#'+checked1+' .modulHead a.moduledit').attr("href", 'db.asp?islem=blocktab&blocktabcol=editmodul&checked='+checked+'&checked1='+checked1+'&blockstring='+jsonold+'');

            //$.each(fields, function(i, field){
            //$('#'+checked1+'').attr('data-'+field.name+'', field.value).data(''+field.name+'', field.value);
            //});
            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    if (htmlyenivar=="1"){
    $('#'+checked1+' .moduledit').attr('href', newmodulhref);
    $('#'+checked1+' .modulHead > div:nth-child(2)').append(newmodulinsertbut);
                    var formData = $('.block-form').serializeArray(),
                    data = {};

                $(formData).each(function (index, obj) {
                    data[obj.name] = obj.value;
                });
				// Ajax Submit
				$.ajax({
					type: 'POST',
					url: $('.block-form').attr('action'),
					data: data
				}).always(function(data, textStatus, jqXHR) {
    //console.log(data.response);

					if (data.response == 'success') {

						// Uncomment the code below to redirect for a thank you page
						// self.location = 'thank-you.html';
						
						return;

					} 


				});
    }
    }
    , 1000);
    }

    $('.block-form').submit(function() {
   var status = confirm("Blok Kaydetmeyi Onaylıyormusunuz ?");
   if(status == false){
   return false;
   }
   else{
   return true; 
   }
  });

    function rowshowSerialize(checked,checked1) {
        //var fields = $( 'table#'+checked+' :input' ).serializeArray();
        //var jsonStringdata = JSON.stringify(fields);
    
            var elid=$( 'table#'+checked+' :input[name="elid"]' ).val();
            //var eltype=$( 'table#'+checked+' :input[name="eltype"]' ).val();
            var elcss=$( 'table#'+checked+' :input[name="elcss"]' ).val();
            var elstyle=$( 'table#'+checked+' :input[name="elstyle"]' ).val();
            var elother=$( 'table#'+checked+' :input[name="elother"]' ).val();
            var elcont=$( 'table#'+checked+' #elcont option:selected' ).val();
            var rowtype=$( 'table#'+checked+' #eltype option:selected' ).val();
    //console.log(elcont);
    //console.log(rowtype);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elid', elid).data('elid', elid);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elcss', elcss).data('elcss', elcss);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elstyle', elstyle).data('elstyle', elstyle);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-elother', elother).data('elother', elother);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-cont', elcont).data('cont', elcont);
            $('#'+checked+', #'+checked+' a.rowedit').attr('data-type', rowtype).data('type', rowtype);

            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    }
    function colshowSerialize(checked,checked1) {
        //var fields = $( 'table#'+checked+' :input' ).serializeArray();
        //var jsonStringdata = JSON.stringify(fields);
    
            var elid=$( 'table#'+checked+' :input[name="elid"]' ).val();
            //var eltype=$( 'table#'+checked+' :input[name="eltype"]' ).val();
            var elcss=$( 'table#'+checked+' :input[name="elcss"]' ).val();
            var elstyle=$( 'table#'+checked+' :input[name="elstyle"]' ).val();
            var elother=$( 'table#'+checked+' :input[name="elother"]' ).val();
            var coltype=$( 'table#'+checked+' #coltype option:selected' ).val();
            var colsmtype=$( 'table#'+checked+' #colsmtype option:selected' ).val();
            var colmdtype=$( 'table#'+checked+' #colmdtype option:selected' ).val();
            var collgtype=$( 'table#'+checked+' #collgtype option:selected' ).val();
            var colxltype=$( 'table#'+checked+' #colxltype option:selected' ).val();

            $('#'+checked+', #'+checked+' a.coledit').attr('data-celid', elid).data('celid', elid);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-celcss', elcss).data('celcss', elcss);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-celstyle', elstyle).data('celstyle', elstyle);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-celother', elother).data('celother', elother);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-coltype', coltype).data('coltype', coltype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colsmtype', colsmtype).data('colsmtype', colsmtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colmdtype', colmdtype).data('colmdtype', colmdtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-collgtype', collgtype).data('collgtype', collgtype);
            $('#'+checked+', #'+checked+' a.coledit').attr('data-colxltype', colxltype).data('colxltype', colxltype);

            updateserialize();
        $('#moduladd').modal('hide');
        $('#moduladd').removeData('bs.modal');
    }
		 
    $(document).ready(function () {
    $("#btn2").click(function(){
	var ollicount=$('ol.nested_with_switch > li').length+1;
    getajaxstr("db.asp?islem=blocktab&blocktabcol=addrow&blockstring=" + ollicount,function (response) {
    var strblock=response;    
    $("ol.nested_with_switch").append(strblock);
	updateserialize();
});
    
    });
updateserialize();
    });
    
    function getajaxstr(islem,callback) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
   callback(this.responseText);
    }
  };
  xhttp.open("GET", "" + islem+"", true);
  xhttp.send();
}
    

    var formatId;
$('#moduladd').on('show.bs.modal', function (event) {

    if (formatId) {
        window.clearTimeout(formatId);
    }
    formatId = window.setTimeout(function () {

  var button = $(event.relatedTarget)
  var modaleltype = button.data('eltype')
    if (modaleltype=="rowedit"){
  var elid = button.data('elid')
  var elcss = button.data('elcss')
  var elstyle = button.data('elstyle')
  var elother = button.data('elother')
  var elcont = button.data('cont')
  var eltype = button.data('type')

  var modal = $('#moduladd')
  modal.find('.modal-body input[name="elid"]').val(elid)
  modal.find('.modal-body input[name="elcss"]').val(elcss)
  modal.find('.modal-body input[name="elstyle"]').val(elstyle)
  modal.find('.modal-body input[name="elother"]').val(elother)
  modal.find('.modal-body select[name="cont"]').val(elcont)
  modal.find('.modal-body select[name="eltype"]').val(eltype)
    } 
    else if (modaleltype=="coledit"){
  var elid = button.data('celid')
  var elcss = button.data('celcss')
  var elstyle = button.data('celstyle')
  var elother = button.data('celother')
  var coltype = button.data('coltype')
  var colsmtype = button.data('colsmtype')
  var colmdtype = button.data('colmdtype')
  var collgtype = button.data('collgtype')
  var colxltype = button.data('colxltype')
    //console.log(collgtype+'sda')
  var modal = $('#moduladd')
  modal.find('.modal-body input[name="elid"]').val(elid)
  modal.find('.modal-body input[name="elcss"]').val(elcss)
  modal.find('.modal-body input[name="elstyle"]').val(elstyle)
  modal.find('.modal-body input[name="elother"]').val(elother)
  modal.find('.modal-body select[name="coltype"]').val(coltype).change()
  modal.find('.modal-body select[name="colsmtype"]').val(colsmtype).change()
  modal.find('.modal-body select[name="colmdtype"]').val(colmdtype).change()
  modal.find('.modal-body select[name="collgtype"]').val(collgtype).change()
  modal.find('.modal-body select[name="colxltype"]').val(colxltype).change()

    }
    
	window.setTimeout(updateselectize(), 120);
        formatId = undefined;
    
    }, 620);
})
function updateselectize(){
    $('.selctize').selectize({
    delimiter: '*',
    persist: false
});
    }

    $('.selctize1').selectize({

delimiter: '*',

persist: false

});



$(document).ready(function () {
    $("#dkate2").change(function(){
      strmssayfa=$( '#dkate2' ).find(":selected").val();
      if (strmssayfa!==""){
      window.location.href = strmssayfa;
    }
    });
  });
</script>