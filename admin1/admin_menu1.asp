<!--#Include file="../functions/md5.asp"-->
<!--#Include file="db.asp"-->
<%   
    if request.QueryString("islemexcel")="" then
    sqlString = "select * from yetkiler where id="&yetkiuye&" order by id desc "
    set mmmGenel = Con.Execute (sqlString)

    if mmmGenel.EOF then
    else
     iytk=iytk+1
                 yetkiid=mmmGenel("id")
     if yetkiid=1 and yetkiuye<>1 then
     else
                 yetkijson=mmmGenel("yetkijson")
    if instr(yetkijson,"{") then
                    Set oJSON = New aspJSON
oJSON.loadJSON(yetkijson)
    end if

                 end if
                 end if
    close(mmmGenel)

              function ymenuliste(anasek,temp,vb,tempf)
    'response.Write "SELECT * from yonetici_menu where alt = '1'"&tempf&" and durum='1' order by sira<br><br>"
                  vbstr="mmmYardimci"&vb
                  if anasek="1" then
sqlString = "SELECT * from yonetici_menu where alt = '1'"&tempf&" and durum='1' order by sira"
                  else
                  sqlString = "SELECT * from yonetici_menu where anasek='"&anasek&"' and durum='1'"&tempf&" order by sira"
                  end if
set vbstr = Con1.Execute (sqlString)
                          if vbstr.eof then
                  kyl=""
                          else     

                  Do While Not vbstr.EOF
          strid=vbstr("id")
    if instr(yetkijson,"{") then

                 
    if isObject(oJSON.data(""&yetkiuye&"")) then
                 Set yetkili = oJSON.data(""&yetkiuye&"")
    if isObject(yetkili.item(""&strid&"")) then
                 set sayfasi = yetkili.item(""&strid&"")
                 editchck= sayfasi(0)("edit")
                 delchck= sayfasi(0)("delete")
                 end if
                 end if
    else
    editchck="1"
    delchck="1"
                 end if
    if editchck="1" or delchck="1" then
          strtoplu=vbstr("sira1")
          menuseolinkana=veriguncelle(vbstr("seolink"))
    if menuseolinkana="" then
    menuseolinkanahref=""
    else
          menuseolinkanahref=" href="""&menuseolinkana&""""
    end if
          menutempiana=vbstr("modulmu")
          menusturaana=vbstr("stura")
    if menusturaana="" then
    menuiconana=""
    else
    menuiconana="<i class="""&menusturaana&"""></i>"
    end if
          menuisimana=vbstr("isim")
                  kyl1=""&replace(replace(replace(temp,"#ymseolinkhref#",menuseolinkanahref),"#ymisim#",menuisimana),"#ymicon#",menuiconana)
                  if Instr(kyl1, "#ymsub(") then
                    ymveri=split(split(kyl1,"#ymsub(")(1),")#")(0)
                    ymveri1=split(ymveri,",")(0)
                    ymveri2=split(ymveri,",")(1)
                   kyl1=""&Replace(kyl1, "#ymsub("&ymveri1&","&ymveri2&")#",ymveri1&""&ymenuliste(strid,temp,"1",tempf)&""&ymveri2)
else
end if
                  kyl=kyl&""&kyl1
    end if
                  vbstr.MoveNext
loop
                  end if
                  close(vbstr)
                  ymenuliste=kyl
              end function
    'tempf=" and modulmu='1'"
    %>
<style>
   .dropdown:hover .dropdown-menu,
    .dropdown-menu:hover {
        display: block;
        margin-top: 0; /* Boşluk olmasın */
    }
    ul.side-menu li > a:after  {
        	font-family: 'FontAwesome';
	content: '\f107';
	color: #abb4be;
	position: absolute;
	right: 0;
	top: 0;
	padding: 14px 25px;
    }
    html .left_col .side-menu li a:after {
		display: inline-block;
	}
    
	html .left_col .side-menu li a:after + ul {
		display: none;
	}
</style>
<div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="<%=yoneticilink%>" class="site_title"><i class="fa fa-paw"></i> <span><%=webadmin%></span></a>
              
            </div>

            <div class="clearfix"></div>

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <ul class="nav side-menu">
                        <%
sqlString = "select * from kategoriyazi where habertemp = '1'  ORDER BY modulmu,sira"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
%>  
    <li><a><i class="fa fa-star"></i>  <%=esser("sa","Sık Kullanılanlar") %></a>
    <ul class="nav child_menu">
      <%
Do While Not mmmYardimci.EOF
%>
      <li ><a><%=mmmYardimci("isim")%> </a>
        <%
		sqlString = "select * from yazilar where kategori='"&mmmYardimci("id")&"'  ORDER BY sira,id limit 3"
set mmmYardimci2 = Con.Execute (sqlString)
response.Write("<ul class=""nav child_menu"">")
  response.Write("<li><a href=""sayfalar.asp?dkate2="&mmmYardimci("id")&"&sek="&mmmYardimci("id")&""">Sayfaya Git </a></li>")
if mmmYardimci2.eof then
else

response.Write("<li ><a href=""admin_uruny_duzenle.asp?modulv=0&yazi=yeni&modul=0&dkate2="&mmmYardimci("id")&"&dkate="&mmmYardimci("id")&"&coklu=1&iceriktur=9&titlee="&server.urlencode(mmmYardimci("isim"))&""">Yeni Ekle</a>")
Do While Not mmmYardimci2.EOF
%>     
      <li>
      <%
sqlString = "SELECT * from kategori where id="&mmmYardimci2("urunid")&" order by id"
set mmmYardimci3 = Con1.Execute (sqlString)
if mmmYardimci3.eof then
else
%>
<a class="drop-sky" href="<%=mmmYardimci3("adresd")%>duzelt1=<%=mmmYardimci3("id")%>&urunid=<%=mmmYardimci2("id")%>&baslik=<%=mmmYardimci2("id")%>&sek=<%=mmmYardimci2("kategori")%>&dkate2=<%=mmmYardimci2("kategori")%>"><%=left(mmmYardimci2("yazib"),20)%>...</a>
 <%
end if
close(mmmYardimci3)%>
      </li>
      <%
mmmYardimci2.MoveNext
loop
end if
response.Write("<li ><a href=""sayfalar.asp?dkate2="&mmmYardimci("id")&"&sek="&mmmYardimci("id")&""">Tüm Yazılar</a>")
response.Write("</ul>")
close(mmmYardimci2)

sqlString = "select * from kategoriyazi where anasek='"&mmmYardimci("id")&"' ORDER BY modulmu,sira"
set mmmYardimci1 = Con.Execute (sqlString)
if mmmYardimci1.eof then
else
response.Write("<ul class=""nav child_menu"">")
Do While Not mmmYardimci1.EOF
%> 
      <li style=" padding-left: 10px; "><a href="sayfalar.asp?dkate2=<%=mmmYardimci1("id")%>&sek=<%=mmmYardimci1("id")%>"><%=mmmYardimci1("isim")%></a>
        <%
sqlString = "select * from yazilar where kategori='"&mmmYardimci1("id")&"' ORDER BY sira,id limit 20"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
else
response.Write("<ul class=""nav child_menu"">")
Do While Not mmmYardimci2.EOF
%>    
      <li>
            <%
sqlString = "SELECT * from kategori where id="&mmmYardimci2("urunid")&" order by id"
set mmmYardimci3 = Con1.Execute (sqlString)
if mmmYardimci3.eof then
else
%>
<a class="drop-sky" href="<%=mmmYardimci3("adresd")%>duzelt1=<%=mmmYardimci3("id")%>&urunid=<%=mmmYardimci2("id")%>&baslik=<%=mmmYardimci2("id")%>&sek=<%=mmmYardimci2("kategori")%>&dkate2=<%=mmmYardimci2("kategori")%>"><%=mmmYardimci2("yazib")%>&nbsp;&nbsp;&nbsp;</a>
 <%
end if
close(mmmYardimci3)%>
<!--
<a href="galeri.asp?baslik=<%=mmmYardimci2("id")%>&dkate2=<%=mmmYardimci2("kategori")%>&sek=<%=mmmYardimci2("kategori")%>" class="drop-sky"><em class="fa fa-camera" style="font-size:16px;"></em></a>-->
      </li>
      <%
mmmYardimci2.MoveNext
loop
response.Write("<li><a href=""sayfalar.asp?dkate2="&mmmYardimci1("id")&"&sek="&mmmYardimci1("id")&""">Tüm Yazılar</a>")
response.Write("</ul>")
end if
close(mmmYardimci2)
response.Write("</li>")

mmmYardimci1.MoveNext
loop
if mmmYardimci("modulmu")="1" then
else
response.Write("</ul>")
end if
end if
close(mmmYardimci1)
response.Write("</li>")
mmmYardimci.MoveNext
loop
close(mmmYardimci)
%>
    </ul>
    </li>    
    <%end if
    strymenuliste=ymenuliste("1","<li><a#ymseolinkhref#>#ymicon# #ymisim# </a>#ymsub(<ul class=""nav child_menu"">,</ul>)#</li>","",tempf) 
    response.Write strymenuliste%>                  
                </ul>
              </div>

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="logout.asp">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              

              <ul class="nav navbar-nav navbar-right">
              <span class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </span>
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/sign-in.png" alt="<%=aduye%>"><%=aduye%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="ortak_kulduzenle.asp?urunid=<%=iduye%>"> Profil</a></li>
                    <li><a href="logout.asp"><i class="fa fa-sign-out pull-right"></i> Çıkış</a></li>
                  </ul>
                </li>
                <li role="notifications">
                  <a href="https://<%=Request.ServerVariables("Server_Name")%>" class=" info-number" target="_blank">
                    <i class="fa fa-desktop"></i>
                    Siteyi Git
                  </a>
                  </li>
<li role="notifications" class="dropdown">
            <a href="#" class="dropdown-toggle info-number" data-toggle="dropdown">
              <i class="fa fa-bell"></i>
              <span class="badge bg-red">0</span>
            </a>
            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
              <li class="header">0 bildiriminiz var.</li>
               <%if eser="1" then%>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">               
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-warning text-yellow"></i> Very long description here that may not fit into the
                      page and may cause design problems
                    </a>
                  </li>
                  <li class="footer"><div class="text-center"><a href="#">Hepsini Gör</a></div></li>
                  
                </ul>
              </li>
              <%else%>
				  <%end if%>
            </ul>
          </li>
          
                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope"></i>
                    <%
					sqlString = "select * from ozellikler2 where ozelikid = '1' and isim = '1' and oku = '0' order by id desc limit 5"
set mmmGenel = Con.Execute (sqlString)
lojik5=con.execute("select count(oku) as toplam4 from ozellikler2 where ozelikid = '1' and oku = '0' and isim = '1'")
toplam5=lojik5("toplam4")
%>
                    <span class="badge bg-green"><%=toplam5%></span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                  <%
if mmmGenel.eof then%>
 <li>
                      <a>                      
                      <span>
                      Bildirim Yok
                      </span>
                      </a>
                      </li>
  <%else
 Do While Not mmmGenel.EOF
  sqlString = "select * from ozellikler2 where ozelikid='1' and tur='"&mmmGenel("tur")&"' order by id desc"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
baslikformid="0"
baslikfoid="0"
else
baslikformid=mmmYardimci("isim")
baslikfoid=mmmYardimci("id")
end if
close(mmmYardimci)
      formidstr=mmmGenel("formid")
      if formidstr="" or isNull(formidstr) then
      formidstr="0"
      end if
 sqlString = "select * from formlar where id="&mmmGenel("formid")&" order by id"
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
formbaslik="0"
else
formbaslik=mmmYardimci("formadi")
end if
close(mmmYardimci)
 %>
 <li>
                      <a href="formicerik.asp?form=<%=mmmGenel("formid")%>">                      
                      <span>
                          <span><%=baslikfoid%> Nolu Gönderi</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          <%=formbaslik%>
                        </span>
                      </a>
                    </li>
                   <% 
                    mmmGenel.movenext
loop
end if

close(mmmGenel)
%>
                  <%if eser="1" then%>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>  
                    <li>
                      <div class="text-center">
                        <a>
                          <strong>Bütün Bildirimleri Gör</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li>
                         <%else%>
                     
						 <%end if%>               
                  
                  </ul>
                </li>
                <%  if request.QueryString("dkate2")="" then
else
set mmmGenel = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&request.QueryString("dkate2")&" order by id")
if mmmGenel.eof then
else
dkate2=mmmGenel("id")
sayfa1=mmmGenel("isim")&""
sayara=mmmGenel("sayara")
smodula=mmmGenel("smodula")
stura=mmmGenel("stura")
sid=mmmGenel("id")
                    if sayara=sid then
                    sekid=sid
                    else
                    sekid=sayara
                    end if
linked="alt1="&sid&"&"
sayfa1crumb="<li><a href=""sayfalar.asp?"&linked&"dkate2="&sid&"&sek="&sekid&""">"&sayfa1&"</a></li>"
set mmmYardimci = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmGenel("anasek")&" order by id")
if mmmYardimci.eof then
else
dkate2=mmmYardimci("id")
sayfa2=mmmYardimci("isim")&""
sayara2=mmmYardimci("sayara")
smodula2=mmmYardimci("smodula")
stura2=mmmYardimci("stura")
sid2=mmmYardimci("id")
                    if sayara2=sid2 then
                    sekid=sid2
                    else
                    sekid=sayara2
                    end if
linked=""&linked&"alt2="&sid2&"&"
sayfa2crumb="<li><a href=""sayfalar.asp?"&linked&"dkate2="&sid2&"&sek="&sekid&""">"&sayfa2&"</a></li>"
set mmmYardimci1 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci("anasek")&" order by id")
if mmmYardimci1.eof then
else
dkate2=mmmYardimci1("id")
sayfa3=mmmYardimci1("isim")&""
sayara3=mmmYardimci1("sayara")
smodula3=mmmYardimci1("smodula")
stura3=mmmYardimci1("stura")
sid3=mmmYardimci1("id")
                    if sayara3=sid3 then
                    sekid=sid3
                    else
                    sekid=sayara3
                    end if
linked=""&linked&"alt3="&sid3&"&"
sayfa3crumb="<li><a href=""sayfalar.asp?"&linked&"dkate2="&sid3&"&sek="&sekid&""">"&sayfa3&"</a></li>"
set mmmYardimci2 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci1("anasek")&" order by id")
if mmmYardimci2.eof then
else
dkate2=mmmYardimci2("id")
sayfa4=mmmYardimci2("isim")&""
sayara4=mmmYardimci2("sayara")
smodula4=mmmYardimci2("smodula")
stura4=mmmYardimci2("stura")
sid4=mmmYardimci2("id")
                    if sayara4=sid4 then
                    sekid=sid4
                    else
                    sekid=sayara4
                    end if
linked=""&linked&"alt4="&sid4&"&"
sayfa4crumb="<li><a href=""sayfalar.asp?"&linked&"dkate2="&sid4&"&sek="&sekid&""">"&sayfa4&"</a></li>"
set mmmYardimci3 = Con.Execute ("select * from kategoriyazi where durum = '1' and id="&mmmYardimci2("anasek")&" order by id")
if mmmYardimci3.eof then
else
dkate2=mmmYardimci3("id")
sayfa5=mmmYardimci3("isim")&""
sayara5=mmmYardimci3("sayara")
smodula5=mmmYardimci3("smodula")
stura5=mmmYardimci3("stura")
sid5=mmmYardimci3("id")
                    if sayara5=sid5 then
                    sekid=sid5
                    else
                    sekid=sayara5
                    end if
linked=""&linked&"alt5="&sid5&"&"
sayfa5crumb="<li><a href=""sayfalar.asp?"&linked&"dkate2="&sid5&"&sek="&sekid&""">"&sayfa5&"</a></li>"
end if
close(mmmYardimci3)
end if
close(mmmYardimci2)
end if
close(mmmYardimci1)
end if
close(mmmYardimci)
end if
close(mmmGenel)
end if

if request.QueryString("form")="" then
formidd=0
else
formidd=request.QueryString("form")
end if

		mmmYardimci3.Open "select * from formlar where id="&formidd&" order by id", Con, 1, 3
if mmmYardimci3.eof then
else
formid=mmmYardimci3("id")
formadi=mmmYardimci3("formadi")&""
linkeform="form="&formid&""
formadicrumb="<li><a href=""formnesneleri.asp?"&linkeform&""">"&formadi&"</a></li>"

		mmmYardimci2.Open "select * from ozellikler where formid='"&mmmYardimci3("id")&"' and id='"&request("anasek")&"' order by id", Con, 1, 3
if mmmYardimci2.eof then
else
formid1=mmmYardimci2("id")
formadi1=mmmYardimci2("isim")&""
linkeform="form="&formid&"&"
formadi1crumb="<li><a href=""formnesneleri.asp?"&linkeform&""">"&formadi1&"</a></li>"

		mmmYardimci1.Open "select * from ozellikler where formid='"&mmmYardimci3("id")&"' and anasek='"&mmmYardimci2("id")&"' and id='"&request("anasek")&"' order by id", Con, 1, 3
if mmmYardimci1.eof then
else
formid2=mmmYardimci1("id")
formadi2=mmmYardimci1("isim")&""
linkeform="form="&formid&"&"
formadi2crumb="<li><a href=""formnesneleri.asp?"&linkeform&""">"&formadi2&"</a></li>"
end if
close(mmmYardimci1)
end if
close(mmmYardimci2)
end if
close(mmmYardimci3)

if request.QueryString("baslik")="" or isNull(request.QueryString("baslik"))=True then
urunidds=0
else
urunidds=request.QueryString("baslik")
end if

		mmmYardimci3.Open "select * from yazilar where id="&urunidds&"", Con, 1, 3
if mmmYardimci3.eof then
else
yazib=mmmYardimci3("yazib")
yazibcrumb="<li><a href=""admin_uruny_duzenle.asp?"&ylinked&""">"&yazib&"</a></li>"
ylinked="duzelt1="&request("duzelt1")&"&urunid="&urunidds&"&baslik="&request("baslik")&"&sek="&request("sek")&"&dkate2="&request("dkate2")&""
end if
close(mmmYardimci3)

call yagac(1)
%>
      <li>     
        <div id="ai-quota-badge" style="margin-top: -9px; margin-left:5px"></div>
        </li> 
      <li>  
<div id="sessionCountdown" style="background: red; color: white; padding: 10px; border-radius: 5px; margin-top: -8px;">
  O.S.: <span id="countdownTimer"></span>
</div>
</li>     
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
        

<%
sub yagac(goster)%>
      
<ol class="breadcrumb">

        <%if icerikler=1 then%>
        <li><a href="sayfalar.asp"><i class="fa fa-dashboard"></i>TÜM SAYFALAR</a></li>
        <%=sayfa5crumb%>
        <%=sayfa4crumb%>
        <%=sayfa3crumb%>
        <%=sayfa2crumb%>
        <%=sayfa1crumb%>
        <%=yazibcrumb%>
        <%
else
end if
%>
        
       <%=formadicrumb%><%=formadi1crumb%><%=formadi2crumb%>
</ol>
<%end sub
    end if%>