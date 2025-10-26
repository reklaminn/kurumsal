<!--#Include file="admin_menu1.asp"-->

<div class="right_col" role="main">
  <div class="x_panel">
    <%
if request.QueryString("onizleme")="1" then
kateid=request.QueryString("urunid")
sqlString = "select * from kategoriayar where id="&kateid&" order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
temp=mmmGenel("l1")
strsid=mmmGenel("id")
strsr2=mmmGenel("r2")
strsr3=mmmGenel("r3")
strsr4=mmmGenel("r4")
strsr5=mmmGenel("r5")
strsr6=mmmGenel("r6")
strsl1=mmmGenel("l1")
strsl2=mmmGenel("l2")
strsl3=mmmGenel("l3")
strsl4=mmmGenel("l4")
strsl6=mmmGenel("l6")
strsl9=mmmGenel("l9")
strsl10=mmmGenel("l10")
strsi1=mmmGenel("i1")
strsi2=mmmGenel("i2")
strsi3=mmmGenel("i3")
strsi4=mmmGenel("i4")
strsi5=mmmGenel("i5")
strsi6=mmmGenel("i6")
strsi7=mmmGenel("i7")
strsi8=mmmGenel("i8")
strskate=mmmGenel("kate")
strsbilgi1=mmmGenel("bilgi1")
strsbilgi1i=mmmGenel("bilgi1i")
strsbilgi2=mmmGenel("bilgi2")
strsbilgi2i=mmmGenel("bilgi2i")
strsbilgi3=mmmGenel("bilgi3")
strsbilgi3i=mmmGenel("bilgi3i")
strsbilgi4=mmmGenel("bilgi4")
strsbilgi4i=mmmGenel("bilgi4i")
strskate1=mmmGenel("kate1")
strsadres=mmmGenel("adres")
stemptur=strsi1
stemptur1=strsi5
end if
close(mmmGenel)
%>

<%if request("adres")="1" then%>
    <style>
<%=replace(replace(strsl10,"-//-","{"),"/--/","}")%>
</style>
    <div class="<%=strsi1%> slider s-mode">
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG" rel="265" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-29120183905.JPG" rel="266" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-29120183905.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG" rel="265" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-29120183905.JPG" rel="266" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-29120183905.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG" rel="265" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
      <div class="slick-slide col-md-12">
        <div><a href="/images/my_pictures/galeri/reklamlar-29120183905.JPG" rel="266" data-toggle="lightbox" data-gallery="multiimages380" data-title="" data-footer="">
          <div class="image" style="background-image:url('/images/my_pictures/galeri/reklamlar-29120183905.JPG');"></div>
          <div class="imglitmask380169"></div>
          </a></div>
      </div>
    </div>
 <%elseif request("adres")="2" then
 jsisveri1=listeleme1style(strsl6,csstip)
stylisveri1=listeleme1style(strsi8,csstip)
%>
<style>
<%=stylisveri1%>
</style>
<script type="text/javascript">
<%=jsisveri1%>
</script>
 <%
 baslikisim="Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
 yaziisim="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin suscipit eget mauris eget convallis. Fusce condimentum at sem placerat feugiat. In hac habitasse platea dictumst. Suspendisse tincidunt leo vel lacus blandit auctor. Fusce lacinia id lacus quis imperdiet. Morbi enim purus, gravida ut vestibulum in, elementum vel nulla. Cras gravida tempus leo, in vehicula erat tincidunt sit amet. Donec ut accumsan sem, sit amet imperdiet leo. Curabitur scelerisque quam tristique, sagittis quam sed, pellentesque erat. Fusce vel rhoncus nisi. Etiam quis accumsan neque. Nulla a turpis turpis. Aliquam egestas mi at lacus faucibus, in vestibulum ante pulvinar.<br>Mauris aliquam mauris ut lacus viverra, in consequat odio mattis. Duis rutrum commodo ex sed cursus. Donec ante lacus, vehicula nec lobortis in, ultricies non mauris. Vestibulum efficitur rhoncus purus. Etiam id nulla mi. Donec tincidunt mauris at risus hendrerit, non volutpat nibh posuere. Etiam mi nunc, congue quis interdum in, lobortis sed ipsum. Praesent congue arcu quis tempor mollis. Aliquam molestie augue urna. Morbi est metus, consectetur sed eros sit amet, efficitur hendrerit metus."
 
 resimim="/images/my_pictures/galeri/reklamlar-29120183905.JPG"
 buyukresim=buyukresim&"<div class=""single"&csstip&" buyukurun"&csstip&""">"
   link=""""&resimim&""""
    buyukresim=buyukresim&"<a rel="""&rid&""" href="""&resimim&""" data-toggle=""lightbox"" data-gallery=""multiimages"" data-title="""&baslikisim&""" data-footer="""&resimacik&"""><img src="""&resimim&""" width=""100%"" border=""0"" /></a>"
  buyukresim=buyukresim&"</div>"
  
  kucukresim="<div class=""col-sm-6 col-md-4""><div class=""thumbnail resim_cercevem4""><a rel=""279"" href=""/images/my_pictures/galeri/reklamlar-29120183905.JPG"" data-toggle=""lightbox"" data-gallery=""multiimages514"" data-title="""" data-footer=""""><div style=""background-image:url(/images/my_pictures/galeri/reklamlar-29120183905.JPG);"" class=""image""> </div></a> </div></div><div class=""col-sm-6 col-md-4""><div class=""thumbnail resim_cercevem4""><a rel=""279"" href=""/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG"" data-toggle=""lightbox"" data-gallery=""multiimages514"" data-title="""" data-footer=""""><div style=""background-image:url(/images/my_pictures/galeri/reklamlar-2912018FD07166.JPG);"" class=""image""> </div></a> </div></div><div class=""col-sm-6 col-md-4""><div class=""thumbnail resim_cercevem4""><a rel=""279"" href=""/images/my_pictures/galeri/reklamlar-29120183905.JPG"" data-toggle=""lightbox"" data-gallery=""multiimages514"" data-title="""" data-footer=""""><div style=""background-image:url(/images/my_pictures/galeri/reklamlar-29120183905.JPG);"" class=""image""> </div></a> </div></div>"
    
	  if twitterkadi="-" or twitterkadi="" then
	  strvia="&via="&twitterkadi&""
	  else
	  strvia=""
	  end if
	  
      sosyal=sosyalpaylas1(sitelink,sayfaurun,facebooktag)
	  'faceboky=facebokyorum(sitelink,sayfaurun,facebooktag)
	  'response.end
 Veri2=strsi1
Veri2=Veri2&""
Veri2 = Replace(Veri2, "#baslikisim#","<h3>"&baslikisim&"</h3>")
Veri2 = Replace(Veri2, "#yaziisim#","<p>"&yaziisim&"</p>")
if Instr(Veri2,"#slaytresim#") then
Veri2 = Replace(Veri2, "#slaytresim#",yanliste(mdoksanid,i2,"",kayar2,"resim"))
else
end if
if Instr(Veri2,"#buyukresim#") then
Veri2 = Replace(Veri2, "#buyukresim#",buyukresim)
else
end if
if Instr(Veri2,"#kucukresim#") then
Veri2 = Replace(Veri2, "#kucukresim#",kucukresim)
else
end if
if Instr(Veri2,"#strbilgi3#") then
Veri2 = Replace(Veri2, "#strbilgi3#",str_bilgi3)
else
end if
if Instr(Veri2,"#sosyal#") then
Veri2 = Replace(Veri2, "#sosyal#",sosyal)
else
end if
if Instr(Veri2,"#facebokyorum#") then
Veri2 = Replace(Veri2, "#facebokyorum#",faceboky)
else
end if

if Instr(Veri2,"#ozellikcek(") then
ocadet=ubound(split(Veri2,"#ozellikcek("))
for oca=1 to ocadet
strocv=split(split(Veri2,"#ozellikcek(")(1),")#")(0)

ocvadet=ubound(split(strocv,","))
if ocvadet<3 then
else
gorozel=split(strocv,",")(1)
csstip=split(strocv,",")(3)
Veri2 = Replace(Veri2, "#ozellikcek(#formid#,"&gorozel&",#formidtur#,"&csstip&")#",ozellikcek(formid,gorozel,formidtur,csstip))
end if
next
else
end if
%>
 <%=Veri2%>
 <%elseif request("adres")="3" then%>
 
 <%elseif request("adres")="4" then%>
 
 <%end if%>
    <%
else
%>
    <div class="x_title">
      <h2>Kategori Ekle</h2>
      <div class="clearfix"></div>
    </div>
    <form name="form1" method="post"  action="?islem=katecssekle">
    <table class="table table-striped">
      
        <%if request("sek")="" then%>
        <input name="sek" type="hidden" value="0" />
        <%else%>
        <input name="sek" type="hidden" value="<%=request("sek")%>" />
        <%end if%>
        <tr class="icerik1 icerik">
          <td width="15%">Listeleme Adı</td>
          <td width="25%"><input name="sektor" type="text" id="sektor" class="form-control"/></td>
          <td width="15%" align="right">Kopyalanacak Listeleme Template</td>
          <td width="20%"><select name="turu" size="1" id="turu" class="form-control">
             <option value="" disabled="disabled" style="background:#FFD2D2;">Kütüphaneden</option>
                <%
 sqlString = "select * from kategoriayar order by id"
set mmmGenel = Con1.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>">&nbsp;>&nbsp;<%=mmmGenel("kate")%></option>
              <%mmmGenel.MoveNext
  loop
  close(mmmGenel)
  %>
   <option value="" disabled="disabled" style="background:#D5FFD5;">Siteden</option>
              <%
 sqlString = "select * from kategoriayar order by id desc"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>"><%=mmmGenel("kate")%></option>
              <%mmmGenel.MoveNext
  loop
  close(mmmGenel)
  %>
  
            </select></td>
          <td width="10%" align="center"><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"/></td>
        </tr>
      
    </table>
    </form>
    <div class="x_title">
      <h2>Sayfa T&uuml;rleri</h2>
      <div class="clearfix"></div>
    </div>
    <form method="post" Name="custlist" id=Form2 action="?sek=<%=request("sek")%>">
      <table class="table table-striped">
        <%
 if request("icerikturgoster")="" then
 sqlString = "select * from kategoriayar order by adres desc"
  else
 sqlString = "select * from kategoriayar where kate1='"&request("icerikturgoster")&"' order by adres desc"
  end if
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
        <%else%>
        <tr class="baslik" height="40">
          <%if yetkiuye<>"1" then%>
          <%else%>
          <td width="10%">Temp T&uuml;r&uuml;</td>
          <%end if%>
          <td>Temp Adı</td>
          <td width="10%" align="center">İ&ccedil;erik D&uuml;zenle</td>
          <td width="10%" align="center">Önizleme</td>
          <td width="1%" align="center"></td>
          <td width="2%"></td>
        </tr>
        <%
Do While Not mmmGenel.EOF
iok=iok+1
csskatesi=mmmGenel("kate1")
csskateid=mmmGenel("id")
csskatead=mmmGenel("kate")
csskatetemp=mmmGenel("adres")
%>
        <input name="urunid" type="hidden" value="<%=csskateid%>" />
        <%if right(iok,1)=1 or right(iok,1)=3 or right(iok,1)=5 or right(iok,1)=7 or right(iok,1)=9 then%>
        <%collor="1"%>
        <%else%>
        <%collor="2"%>
        <%end if%>
        <TR class="icerik<%=collor%> icerik">
          <%if yetkiuye<>"1" then%>
          <input name="iceriktur" type="hidden" value="<%=csskatesi%>" />
          <%else%>
          <td><select name="iceriktur"class="form-control" id="iceriktur">
              <%for each xarr in arrcsskategori
										 xarr=xarr-1%>
              <option value="<%=arrcsskategori(xarr)%>" <%if ""&arrcsskategori(xarr)&""=""&csskatesi&"" then%>selected<%else%><%end if%>><%=arrcsskategoribaslik(xarr)%></option>
              <%next%>
            </select></td>
          <%end if%>
          <td><input name="icerikadi" type="text" id="icerikadi" value="<%=csskatead%>"class="form-control"></td>
          <td width="8%" align="center"><%if csskatetemp="0" or yetkiuye="1" then%>
            <a href="ortak_kategoriayard.asp?turduzen=1&urunid=<%=csskateid%>&adres=<%=adres%>" class="btn btn-primary pull-right">Css Düzenle</a>
            <%
	  else
	  end if
	  %></td>
          <td align="center"><a href="?onizleme=1&amp;urunid=<%=csskateid%>&adres=<%=csskatesi%>" <%if temp=5 or temp=6 or temp=7 then%>target="_blank"<%else%>rel="facebox"<%end if%>>Önizleme</a></td>
          <td align="center"><%if mmmGenel("durum") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Durum",iok,cbcdisstr,cbccheckstr,"info"))%></td>
          <td align="center"><%if csskatetemp="0" or yetkiuye="1" then%>
            <div class="form-group">
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="iceriksil" class="flatred" id="urunidsila<%=iok%>" value="<%=csskateid%>">
                </label>
              </div>
            </div>
            <%
	  else
	  end if
	  %></td>
        </tr>
        <%
  mmmGenel.MoveNext
  loop
  %>
        <tr>
          <td colspan="<%if yetkiuye<>"1" then%>2<%else%>3<%end if%>">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="<%if yetkiuye<>"1" then%>2<%else%>3<%end if%>"></td>
          <td align="right"><input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&Submit=kateDuzenle');"></td>
          <td>&nbsp;</td>
          <td><input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&Submit=kateSil');"></td>
        </tr>
        <% Close(mmmGenel)
end if
%>
        <SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
      </table>
    </form>
    <%
end if
%>
  </div>
</div>
<%call footer(1)%>
<%
if request.QueryString("onizleme")="1" then
%>
<script type="text/javascript" src="/images/themes/default/js/slick.js"></script>

<script>
<%=replace(strsl6,"`","'")%>
</script>
<%else
end if%>
