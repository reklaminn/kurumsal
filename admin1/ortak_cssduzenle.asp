<!--#Include file="admin_menu1.asp"-->

<div class="right_col" role="main">
  <div class="x_panel">
    <div class="x_title">
      <h2>Formlar</h2>
      <div class="clearfix"></div>
    </div>
          <%
              cssid=request.QueryString("urunid")
sqlString = "select * from tasarim where id="&cssid&"  order by id"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
      <%else%>
      <form method="post" name=Form1 id=Form1 action="ortak_tasarimlar.asp?usayi=<%=request("usayi")%>&islem=kap&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&git=<%=request("git")%>" target="_self">
          <table class="table table-striped table-sm">

      <tr>
      <th width="10%" height="40" align="center">Tasarım Adı</th>
        <th width="7%" align="center"></th>
        <th width="10%" align="center">Aktif Durumu</th>
        <th width="7%" align="center">&nbsp;</th>
        <th width="10%" align="center">&nbsp;</th>
        <th width="4%" align="center">&nbsp;</th>
        <th width="7%" align="center">&nbsp;</th>
        </tr>
        
          <%
Do While Not mmmGenel.EOF
iok=iok+1

%>
          <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>">
          <%if right(iok,1)=1 or right(iok,1)=3 or right(iok,1)=5 or right(iok,1)=7 or right(iok,1)=9 then%>
          <%collor="1"%>
          <%else%>
          <%collor="2"%>
          <%end if%>
          
            <TR class="icerik<%=collor%> icerik">
              <td><%=mmmGenel("baslik")%></td>
              <td align="center"><div id="myslidemenu" class="dropdown" style="display: none;">                     
                            <%if yetkiuye=1 then%>
                  <button class="btn btn-success dropdown-toggle" style="padding:1px 6px;" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false">Tasarım İşlemleri<span class="caret"></span></button>
                      <ul class="dropdown-menu animated fadeInDown">
                        <li><a href="ortak_tasarimlar.asp?islem=csskopya&kopya=<%=mmmGenel("id")%>" style="width:97%;">Tasarımdan Kopya Oluştur</a></li>
                        <li><a href="?islem=sayarguncelle&id=<%=mmmGenel("id")%>&urunid=<%=mmmGenel("id")%>" style="width:97%;">Tüm Sayfa Ayarlarını Tasarımdan Güncelle</a></li>
                        <li><a href="?islem=sayaraktar&id=<%=mmmGenel("id")%>&urunid=<%=mmmGenel("id")%>" style="width:97%;">Tüm Sayfa Ayarlarını Tasarıma Aktar</a></li>
                        <li><a href="?islem=modulguncelle&id=<%=mmmGenel("id")%>&urunid=<%=mmmGenel("id")%>" style="width:97%;">Tüm Sayfa Modüllerini Tasarımdan Güncelle</a></li>
                        <li><a href="?islem=modulaktar&id=<%=mmmGenel("id")%>&urunid=<%=mmmGenel("id")%>" style="width:97%;">Tüm Sayfa Modüllerini Tasarıma Aktar</a></li>
                      </ul>
                  <%end if %>
                </div></td>
              <td align="center"><%if mmmGenel("aktif")=1 then%>
                Aktif
                <%else%>
                <a href="?islem=aktif&id=<%=mmmGenel("id")%>&amp;ilk=1">Aktifleştir</a>
                <%end if%></td>
              <td colspan="4" align="center">
              <div class="row">
              <div class="col-md-3"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=2"><em class="fa fa-cog" style="font-size:18px;"></em></a></div>
              <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=1"><em class="fab fa-css3" style="font-size:18px;"></em></a></div>
              <div class="col-md-2"><%if yetkiuye=1 then%><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=5"><em class="fa fa-desktop" style="font-size:18px;"></em></a><%end if %></div>
              <div class="col-md-2"><a href="ortak_cssduzenle.asp?urunid=<%=mmmGenel("id")%>&amp;filtre=3"><em class="fa fa-camera" style="font-size:18px;"></em></a></div>
              <div class="col-md-2">                     
                            <%if yetkiuye=1 then%><a href="ortak_sayfalar_ayar.asp?sayfaayar=modul&dkate2=0"><em class="fa fa-th-large" style="font-size:18px;"></em></a></div></div><%end if %></td>
           
            </tr>
            <%mmmGenel.MoveNext
  loop
%>
          

    </table>     

      </form>    
        <%
end if
Close(mmmGenel)
%>
    <script language="javascript" type="text/javascript">
function klavyesayisal(objEvent) 
	{ var iKeyCode;  	
	  iKeyCode = objEvent.keyCode;			
	  if(iKeyCode>=48 && iKeyCode<=57) return true;
	  return false;	}
</script> 
    <script language="javascript" type="text/javascript">
function klavyeturkceengelli(objEvent) 
	{
	  var iKeyCode;  	
	  iKeyCode = objEvent.keyCode;			
	  if((iKeyCode>=35 && iKeyCode<=60) || (iKeyCode>=63 && iKeyCode<=128) || (iKeyCode>=31 && iKeyCode<=33)) return true;
	  return false;
	}
	</script>
    <%
sqlString = "SELECT * from tasarim where id="&cssid&""
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
strcslogocss=mmmGenel("logocss")
					strcsid=mmmGenel("id")
					strcsd1=mmmGenel("d1")
					strcsd2=mmmGenel("d2")
					strcsd3=mmmGenel("d3")
					strcsd4=mmmGenel("d4")
					strcsd5=mmmGenel("d5")
					strcsd6=mmmGenel("d6")
					strcsd7=mmmGenel("d7")
					strcsd8=mmmGenel("d8")
					strcsd11=mmmGenel("d11")
					strcsd25=mmmGenel("d25")
					strcsd26=mmmGenel("d26")
					strcsd27=mmmGenel("d27")
					strcsd28=mmmGenel("d28")
					strcsd42=mmmGenel("d42")
					strcsd43=mmmGenel("d43")
					strcsd51=mmmGenel("d51")
					strcsd54=mmmGenel("d54")
					strcsd58=mmmGenel("d58")
					strcsd59=mmmGenel("d59")
					strcsd60=mmmGenel("d60")
					strcsusttur=mmmGenel("usttur")
					strcsanauadet=mmmGenel("anauadet")
					strcskateuadet=mmmGenel("kateuadet")
					strheadercnt=mmmGenel("headercnt")
strsocialcnt=mmmGenel("havale")
tour_api_json=mmmGenel("tourjson")

        strsahip=mmmGenel("sahip")
        stradres=mmmGenel("adres")
        strtel=mmmGenel("tel")
        strfax=mmmGenel("fax")
        stricq=mmmGenel("icq")
        strinfo=mmmGenel("info")
		
			  baslik=mmmGenel("title")
			  acik=mmmGenel("aciklama")
			  ankel=mmmGenel("anahtarkelimeler")	
%>
    <%if request("filtre")=1 then
         Dosya_Yol=""&siteadres&"contents/css/custom.css?version="&strcsd60&""&replace(replace(replace(replace(now," ",""),".",""),"/",""),":","")&""
        strcslogocss=VeriAl(Dosya_Yol)
         Dosya_Yol_Js=""&siteadres&"contents/js/custom.js?version="&strcsd60&""&replace(replace(replace(replace(now," ",""),".",""),"/",""),":","")&""
        strcslogojs=VeriAl(Dosya_Yol_Js)
        %>
<div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
            <form action="?islem=cssduzenle&amp;tur=logocss&amp;id=<%=mmmGenel("id")%>" method="post">                
<div class="panel">
    <div class="btn btn-primary">Custom.css</div>
    <%
					
		  cssanan=split(strcslogocss,"*/")
cssananadet=ubound(cssanan)
cssananadet1=cssananadet
if cssananadet="0" or cssananadet1="-1" then
cssananadet=1
else
cssananadet=cssananadet
end if
for u= 0 to cssananadet-1
                  if cssananadet1="0" or cssananadet1="-1" then
                  cssananbas="Main"
                  else
if ubound(split(cssanan(u),"/*"))="0" then
cssananadet=1
else
cssananbas=split(cssanan(u),"/*")(1)
end if
end if		  
               
%>
 <a class="panel-heading" role="tab" id="heading<%=u%>" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=u%>" aria-expanded="false" aria-controls="collapse<%=u%>" onClick='format(<%=u%>,"css", this)'>
                          <h4 class="panel-title"><%=cssananbas%></h4>
            </a>
                <div id="collapse<%=u%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=u%>">
                          <div class="panel-body">
               Css Satır Başlık :<br />
                      <input name="cssnbas" type="text" id="dbosluk" value="<%=cssananbas%>" class="form-control"/>
              <%
			if cssananadet="1" then
                  if cssananadet1="0" or cssananadet1="-1" then
                  cssanan=""
                  else
			cssanah=cssanan(u+1)
                  end if
			else
			cssanah=split(cssanan(u+1),"/*")(0)
			end if
			%> 
            
            <textarea name="logodegera<%=u+1%>" class="form-control" id="beautified<%=u%>" rows="5" ><%=replace(replace(cssanah,"-//-","{"),"/--/","}")%></textarea>
              </div>
              </div>
  <%next%>
      <hr />
    <div class="btn btn-primary">Custom.js</div>

          <%
              jsanan=split(strcslogojs,"*/")
jsananadet=ubound(jsanan)
jsananadet1=jsananadet
if jsananadet="0" or jsananadet1="-1" then
jsananadet=1
else
jsananadet=jsananadet
end if
for jsu= 0 to jsananadet-1
                  if jsananadet1="0" or jsananadet1="-1" then
                  jsananbas="Main"
                  else
if ubound(split(jsanan(jsu),"/*"))="0" then
jsananadet=1
else
jsananbas=split(jsanan(jsu),"/*")(1)
end if
end if
%>  
 <a class="panel-heading" role="tab" id="headingjs<%=jsu%>" data-toggle="collapse" data-parent="#accordion" href="#collapsejs<%=jsu%>" aria-expanded="false" aria-controls="collapsejs<%=jsu%>" onClick='format("js<%=jsu%>","javascript", this)'>
                          <h4 class="panel-title"><%=jsananbas%></h4>
            </a>
                <div id="collapsejs<%=jsu%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingjs<%=jsu%>">
                          <div class="panel-body">
               js Satır Başlık :<br />
                      <input name="jsnbas" type="text" id="dbosluk" value="<%=jsananbas%>" class="form-control"/>
              <%
			if jsananadet="1" then
                  if jsananadet1="0" or jsananadet1="-1" then
                  jsanan=""
                  else
			jsanah=jsanan(jsu+1)
                  end if
			else
			jsanah=split(jsanan(jsu+1),"/*")(0)
			end if
			%> 
            
            <div class="panel">
            <textarea name="logodegerjs<%=jsu+1%>" class="form-control" id="beautifiedjs<%=jsu%>" rows="5" ><%=replace(replace(jsanah,"-//-","{"),"/--/","}")%></textarea>
            </div>
              </div>
              </div>
              <%next%>
              </div>
              <input type="submit" name="button" id="button" value="Kaydet" class="btn btn-success pull-right"/>
            </form>
          </div>
      <!--#Include file="codeeditor.html"-->
    <%elseif request("filtre")=3 then%>
      <div class="input-group">
	  <input class="form-control" id="fieldID3" aria-multiselectable="true" type="text" value="">
      <div class="input-group-btn">
         <a data-toggle="modal" href="javascript:;" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>
          </div>
	</div>
      <div class="btn btn-warning btn-lg">Resim Klasöründe yapacağınız dosya taşıma ve silme işlemleri site içindeki resim görüntülemelerini etkileyebilir.</div>

 <iframe width="100%" height="600" src="<%=cdntinyfldr%>admin/tinymce/filemanager/dialog.php?type=4&descending=false&sort_by=&akey=1339171979-71775100&lang=tr_TR<%=cdncross%>" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>

    <%elseif request("filtre")=2 then
         header_json=strheadercnt
         'header_json=verial(siteadres&""&contentspath&"json/settings/header.json")
    'social_api_json=verial(siteadres&""&contentspath&"json/settings/social_api.json")
    social_api_json=strsocialcnt
        %>
    <!--#Include file="cssduzenle_ayar.asp"-->
    <%elseif request("filtre")=5 then%>
    <%
	sqlString = "select * from kategoriyazi where (modulmu='0' and durum='1' and anasek='1'"&sayfagosterme&" and dil='240') or (anasek in (select id from kategoriyazi where durum='1'"&sayfagosterme&" and dil='240') and durum='1') order by isim"
       'response.Write sqlString
set mmmYardimci = Con.Execute (sqlString)
		Do While Not mmmYardimci.EOF
		colid=mmmYardimci("sayfatemp")
		colsayfa=mmmYardimci("isim")
coloptioncount=ubound(split(colid,"{modul}"))
if coloptioncount>=1 then
coltype=split(colid,",")(0)
for modi=1 to coloptioncount
modultam=split(colid,"{modul}")(modi)
modultam=split(modultam,"{/modul}")(0)

		cdmstrtemp=split(modultam,",")(4)
		cdmstrsayfa=split(modultam,",")(2)
		cdmstrmodulid=split(modultam,",")(3)
		cdmstrbaslik=split(modultam,",")(1)
		strmsonay=split(modultam,",")(6)	
		strdahaoncevarmi="-="&cdmstrsayfa&"-"&cdmstrtemp&"-"&cdmstrmodulid&"=-"
		if instr(dahaoncevarmi,strdahaoncevarmi)="0" then		
		
		if strmsonay="1" then
modgoster="1"
else
modgoster="0"
end if

'response.Write(strdahaoncevarmi&"<br>")

if modgoster="1" then

		if cdmstrmodulid<>"90" and cdmstrsayfa<>"979" and instr(cdmstrsayfa,"vip")="0" then
		set mmmYardimci3 = Con.Execute ("select * from yazilar where id="&replace(replace(cdmstrsayfa,"k",""),"y","")&" and modulmu='1' and durum='1' group by id ORDER BY id")
		if mmmYardimci3.eof then
else
strbilgi1=mmmYardimci3("bilgi1")
stryazib=mmmYardimci3("yazib")
if instr(strbilgi1,"{") then
stylis=strbilgi1
stylis=listeleme1style(strbilgi1,csstip)
        if instr(cssstr,stylis) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylis
        end if
strbilgi1=""
u=u+1

stylisstr= stylisstr&"<a class=""panel-heading"" role=""tab"" id=""heading"&u&""" data-toggle=""collapse"" data-parent=""#accordion"" href=""#collapse"&u&""" aria-expanded=""false"" aria-controls=""collapse"&u&""" onClick=""format('"&u&"','css', this);""><h4 class=""panel-title"">"&""&colsayfa&" - "&stryazib&""&"</h4></a>"&_
                          "<div id=""collapse"&u&""" class=""panel-collapse collapse"" role=""tabpanel"" aria-labelledby=""heading"&u&"""> "&_      
                      "<div class=""panel-body"">"&_ 
                "<input name=""csstur"" type=""hidden"" value=""1"" />"&_ 
                "<input name=""csssayfa"" type=""hidden"" value="""&replace(replace(cdmstrsayfa,"k",""),"y","")&""" />"&_ 
                "<textarea name=""csstam"" class=""form-control"" rows=""15"" id=""beautified"&u&""">"&stylis&"</textarea>"&_ 
                "</div></div>"

else
strbilgi1=""
end if
end if
close(mmmYardimci3)
csstip=""
		else
		end if		

if cdmstrsayfa="0" or instr(cdmstrsayfa,"vip") then 
i1ayar3=cdmstrtemp
else
		 i1ayar3=replace(replace(cdmstrsayfa,"k",""),"y","")
		 end if
	  kayar2=cdmstrtemp
	  kayar3=ayar2
	  stylevar="1"
	  
Call kategoriayar(i1ayar3,kayar2,kayar3)
if i1ayar3="0" then
	  csstip=kayar2
	  else
	  csstip=i1ayar3&""&kayar2
	  end if
	  	  
	  if instr(csstipvar,csstip)<>"0" then
else
if cdmstrtemp="0" or cdmstrtemp="" or cdmstrmodulid="90" then

	  else
jsisveri=listeleme1style(l6,csstip)
'stylisveri=i8
stylisveri=listeleme1style(i8,csstip)
        if instr(cssstr,stylisveri) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylisveri
        end if
        jsstr=jsstr&""&jsisveri
u=u+1
'"&cdmstrmodulid&"-"&cdmstrtemp&"-"&cdmstrsayfa&"-
        
stylisstr= stylisstr&"<a class=""panel-heading"" role=""tab"" id=""heading"&u&""" data-toggle=""collapse"" data-parent=""#accordion"" href=""#collapse"&u&""" aria-expanded=""false"" aria-controls=""collapse"&u&""" onClick=""format('"&u&"','css', this);"" style=""background:#FF9;""><h4 class=""panel-title"">"&""&colsayfa&" - "&cdmstrbaslik&" ("&csstip&")"&"</h4></a>"&_
                          "<div id=""collapse"&u&""" class=""panel-collapse collapse"" role=""tabpanel"" aria-labelledby=""heading"&u&"""> "&_      
                      "<div class=""panel-body"">"&_ 
                "<input name=""csstur"" type=""hidden"" value=""2"" />"&_ 
                "<input name=""cssid"" type=""hidden"" value="""&cdmstrtemp&""" />"&_ 
                "<input name=""csssayfa"" type=""hidden"" value="""&replace(replace(cdmstrsayfa,"k",""),"y","")&""" />"&_ 
                "<textarea name=""csstam"" class=""form-control"" rows=""15"" id=""beautified"&u&""">"&stylisveri&"</textarea>"&_ 
                "</div></div>"

jsisveri1str= jsisveri1str&"<a class=""panel-heading"" role=""tab"" id=""headingj"&u&""" data-toggle=""collapse"" data-parent=""#accordion"" href=""#collapsej"&u&""" aria-expanded=""false"" aria-controls=""collapsej"&u&""" onClick=""format('j"&u&"','javascript', this);""><h4 class=""panel-title"">"&colsayfa&" - "&cdmstrbaslik&" ("&csstip&")</h4></a>"&_
                          "<div id=""collapsej"&u&""" class=""panel-collapse collapse"" role=""tabpanel"" aria-labelledby=""headingj"&u&"""> "&_      
                      "<div class=""panel-body"">"&_ 
                "<input name=""csstur"" type=""hidden"" value=""1"" />"&_ 
                "<input name=""csssayfa"" type=""hidden"" value="""&replace(replace(cdmstrsayfa,"k",""),"y","")&""" />"&_ 
                "<textarea name=""csstam"" class=""form-control"" rows=""15"" id=""beautifiedj"&u&""">"&jsisveri&"</textarea>"&_ 
                "</div></div>"

end if

if i2="0" or i2="" then
stylisveri1=""
jsisveri1=""
else
Call kategoriayar(i1ayar3,i2,kayar3)
jsisveri1=jsisveri1&""&listeleme1style(l6,csstip)
'stylisveri1=i8
stylisveri1=listeleme1style(i8,csstip)
        if instr(cssstr,stylisveri1) then
        cssstr=cssstr
        else
        cssstr=cssstr&""&stylisveri1
        end if
        jsstr=jsstr&""&jsisveri1
u=u+1

stylisstr= stylisstr&"<a class=""panel-heading"" role=""tab"" id=""heading"&u&""" data-toggle=""collapse"" data-parent=""#accordion"" href=""#collapse"&u&""" aria-expanded=""false"" aria-controls=""collapse"&u&""" onClick=""format('"&u&"','css', this);"" style=""background:##FC0;""><h4 class=""panel-title"">"&""&colsayfa&" - "&cdmstrbaslik&""&"</h4></a>"&_
                          "<div id=""collapse"&u&""" class=""panel-collapse collapse"" role=""tabpanel"" aria-labelledby=""heading"&u&"""> "&_      
                      "<div class=""panel-body"">"&_ 
                "<input name=""csstur"" type=""hidden"" value=""2"" />"&_ 
                "<input name=""cssid"" type=""hidden"" value="""&cdmstrtemp&""" />"&_ 
                "<input name=""csssayfa"" type=""hidden"" value="""&replace(replace(cdmstrsayfa,"k",""),"y","")&""" />"&_ 
                "<textarea name=""csstam"" class=""form-control"" rows=""15"" id=""beautified"&u&""">"&stylisveri1&"</textarea>"&_ 
                "</div></div>"

jsisveri1str= jsisveri1str&"<a class=""panel-heading"" role=""tab"" id=""headingj"&u&""" data-toggle=""collapse"" data-parent=""#accordion"" href=""#collapsej"&u&""" aria-expanded=""false"" aria-controls=""collapsej"&u&""" onClick=""format('j"&u&"','javascript', this);""><h4 class=""panel-title"">"&colsayfa&" - "&cdmstrbaslik&"</h4></a>"&_
                          "<div id=""collapsej"&u&""" class=""panel-collapse collapse"" role=""tabpanel"" aria-labelledby=""headingj"&u&"""> "&_      
                      "<div class=""panel-body"">"&_ 
                "<input name=""csstur"" type=""hidden"" value=""1"" />"&_ 
                "<input name=""csssayfa"" type=""hidden"" value="""&replace(replace(cdmstrsayfa,"k",""),"y","")&""" />"&_ 
                "<textarea name=""csstam"" class=""form-control"" rows=""15"" id=""beautifiedj"&u&""">"&jsisveri1&"</textarea>"&_ 
                "</div></div>"

end if

end if
if i1ayar3="0" then
	  else
	  csstipvar=csstipvar&","&csstip
	  end if
	  csstip=""	  	 
	   
	
	  else
end if

else

end if
dahaoncevarmi=dahaoncevarmi&"-="&cdmstrsayfa&"-"&cdmstrtemp&"-"&cdmstrmodulid&"=-"

	  next
  

end if
  mmmYardimci.MoveNext
  loop
 close(mmmYardimci)

        'response.Write jsstr
        'response.Write cssstr
     if request.QueryString("cssislem")="css" then
    call filesavebackup("../contents/css/","../contents/css/temp_element/","custom_element","css",minify(csskont1(cssstr)))
        end if
     if request.QueryString("cssislem")="js" then
    call filesavebackup("../contents/js/","../contents/js/temp_element/","custom_element","js",minify(jskont(jsstr)))
        end if
 %>
    <h5>CSS</h5>
  <form action="?urunid=<%=request.querystring("urunid") %>&filtre=5&cssislem=css" method="post">
    <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel">
        <%=stylisstr %>
 </div>                      
</div>
              <input type="submit" name="button" id="button" value="Kaydet" class="btn btn-success pull-right"/>
</form>

    <h5>JS</h5>
  <form action="?urunid=<%=request.querystring("urunid") %>&filtre=5&cssislem=js" method="post">
    <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel">
        <%=jsisveri1str %>
 </div>                      
</div>
              <input type="submit" name="button" id="button" value="Kaydet" class="btn btn-success pull-right"/>
</form>
      <!--#Include file="codeeditor.html"-->
 <%
 else
	end if
	end if
	Close(mmmGenel)
%>


  </div>
  
</div>


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

<%call footer(1)%>
<!-- Bootstrap Color Picker -->
<link rel="stylesheet" href="<%=cloudpath%>admin/vendors/bootstrap-colorpicker.min.css">
  <!-- bootstrap color picker -->
<script src="<%=cloudpath%>admin/vendors/bootstrap-colorpicker.min.js"></script>
<script>
  $(function () {   
    //Colorpicker
    $('.my-colorpicker2').colorpicker()
  })

jQuery(document).ready(function($) {
    

    function OnMessage(e) {
        var event = e.originalEvent;
        if (event.data.sender === 'responsivefilemanager') {
            if (event.data.field_id) {
                var fieldID = event.data.field_id;
                var url = event.data.url;
                $('#' + fieldID).val(url).trigger('change');
               $('#myModal').modal('hide');
                $(window).off('message', OnMessage);
            }
        }
    }
    $('.iframe-btn').on('click', function() {
        $(window).on('message', OnMessage);
    });
    $('#download-button').on('click', function() {
        ga('send', 'event', 'button', 'click', 'download-buttons');
    });
    $('.toggle').click(function() {
        var _this = $(this);
        $('#' + _this.data('ref')).toggle(200);
        var i = _this.find('i');
        if (i.hasClass('icon-plus')) {
            i.removeClass('icon-plus');
            i.addClass('icon-minus');
        } else {
            i.removeClass('icon-minus');
            i.addClass('icon-plus');
        }
    });
});

     $(document).ready(function() {
  $(".iframe-btn").click(function(e) {
    e.preventDefault();
    var url = $(this).attr("data-href");
    $("#myModal iframe").attr("src", url);
  });
});
</script>