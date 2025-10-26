<!--#Include file="admin_menu1.asp"-->

<%
	if request("dkate2")="" or request("dkate2")="0" then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
%>
<div class="right_col" role="main">
  <%if dkate2="" then
   altsayfaekle="?rinn=web"
else
if dkate2="0" or request("sek")="0" then
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek=1"
else
altsayfaekle="?id="&dkate2&"&baslik="&dkate2&"&sek="&request("sek")&""
end if
end if
modulmuagac=" and modulmu = '0'"%>



 <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil" target="_self">
  <div class="x_panel">
     <h2> Sayfalar Diğer Diller Temizleme </h2>
    <%
sqlString = "select * from kategoriyazi where dil<>240 and bagli not in (select id from kategoriyazi) order by sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">

        <%
            ikss=1
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
stralt=mmmGenel("alt")
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strdil=mmmGenel("dil")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
smidseolink=mmmGenel("seolink")
if sid="" or isNull(sid) or sid="835" then
sida=strid
else
sida=sid
end if

        if stralt="1" then
        gostermesayfa="0"
        else
        sqlString = "select * from kategoriyazi where id='"&stranasek&"'"
        set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        gostermesayfa="1"
        else
        gostermesayfa="0"
        end if
        close(mmmYardimci)
      end if
        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <input name="sayfalama" type="hidden" value="<%=mmmGenel("anasek")%>" />
                <%=strid%> - <%=strisim%> - <%=strdil%></td>
            <td>
                <input type="checkbox" name="urunidsil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
        </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%>   
  </div>
</form>
    
    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Sil" target="_self">
  <div class="x_panel">
     <h2> Sayfalar Anadil Temizleme </h2>
    <%
sqlString = "select * from kategoriyazi where dil=240 order by sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
stralt=mmmGenel("alt")
stranasek=mmmGenel("anasek")
strisim=mmmGenel("isim")
strsifreli=mmmGenel("sifreli")
strdurum=mmmGenel("durum")
strmenugosterim=mmmGenel("menugosterim")
strhabertemp=mmmGenel("habertemp")
smidseolink=mmmGenel("seolink")
if sid="" or isNull(sid) or sid="835" then
sida=strid
else
sida=sid
end if

        if stralt="1" then
        gostermesayfa="0"
        else
        sqlString = "select * from kategoriyazi where id='"&stranasek&"'"
        set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        gostermesayfa="1"
        else
        gostermesayfa="0"
        end if
        close(mmmYardimci)
      end if
        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <input name="sayfalama" type="hidden" value="<%=mmmGenel("anasek")%>" />
                <%=strid%> - <%=strisim%></td>
            <td>
                <input type="checkbox" name="urunidsil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%>  
  </div>
</form>
    
    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik" target="_self">
  <div class="x_panel">
     <h2> Yazılar Anadil Temizleme </h2>
    <%
sqlString = "select * from yazilar where modulmu='0' and dil=240 order by sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
strkategori=mmmGenel("kategori")
strisim=mmmGenel("yazib")


        if stralt="1" then
        gostermesayfa="0"
        else
        sqlString = "select * from kategoriyazi where id='"&strkategori&"'"
        set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        gostermesayfa="1"
        else
        gostermesayfa="0"
        end if
        close(mmmYardimci)
      end if
        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <%=strid%> - <%=strisim%></td>
            <td>
                <input type="checkbox" name="iceriksil" class="flatred" id="urunidsila<%=iks%>" checked value="<%=strid%>">
            </td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%>
  </div>
</form>
    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=Silicerik" target="_self">
  <div class="x_panel">
     <h2> Yazılar Diğer Diller Temizleme </h2>
    <%
sqlString = "select * from yazilar where modulmu='0' and dil<>240 and bagli not in (select id from yazilar) order by sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strurunid=mmmGenel("urunid")
strid=mmmGenel("id")
strkategori=mmmGenel("kategori")
strisim=mmmGenel("yazib")



        sqlString = "select * from kategoriyazi where id='"&strkategori&"'"
        set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        gostermesayfa="1"
        else
        gostermesayfa="0"
        end if
        close(mmmYardimci)

        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <%=strid%> - <%=strisim%> - <%=strkategori %></td>
            <td>
                <input type="checkbox" name="iceriksil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%>
  </div>
</form>

    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=SilSeolink" target="_self">
  <div class="x_panel">
     <h2> Link Yazılar </h2>
    <%
sqlString = "select * from seolar where seoturu='yazi' and seoid not in (select id from yazilar)"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strid=mmmGenel("id")
strkategori=mmmGenel("seoid")
strisim=mmmGenel("seolink")



        sqlString = "select * from yazilar where id='"&strkategori&"'"
        set mmmYardimci = Con.Execute (sqlString)
        if mmmYardimci.eof then
        gostermesayfa="1"
        else
        gostermesayfa="0"
        end if
        close(mmmYardimci)
        gostermesayfa="1"

        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <%=strid%> - <%=strisim%> - <%=strkategori %></td>
            <td>
                <input type="checkbox" name="linksil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%> 
  </div>
</form>

    <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=SilSeolink" target="_self">
  <div class="x_panel">
     <h2> Link Sayfalar </h2>
    <%
sqlString = "select * from seolar where seoturu='sayfa' and seoid not in (select id from kategoriyazi)"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strid=mmmGenel("id")
strkategori=mmmGenel("seoid")
strisim=mmmGenel("seolink")


        gostermesayfa="1"

        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <%=strid%> - <%=strisim%> - <%=strkategori %></td>
            <td>
                <input type="checkbox" name="linksil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%> 
  </div>
</form>

<%if instr(sistem_site_turu,"*tur*") then %>
  <form method="post" name="custlist16" id=Form1 action="<%=altsayfaekle%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&Submit=SilSeoturlink" target="_self">
  <div class="x_panel">
     <h2> Link Turlar </h2>
    <%
sqlString = "select * from seolar where (seoturu='gemi-turlari' or seoturu='feribot-turlari' or seoturu='turlar' or seoturu='transferler' or seoturu='hizmetler' or seoturu='hoteller' or seoturu='tur-detay' or seoturu='transfer-detay' or seoturu='hizmet-detay' or seoturu='hotel-detay' or seoturu='feribot-tur-detay' or seoturu='turlar-detay' or seoturu='gulet-detay' or seoturu='gulet-turlari' or seoturu='kirala-arac' or seoturu='kirala-arac-detay') and (seoid not in (select id from "&dbtgeziturlar&") and seoid not in (select id from "&dbtkategoritur&"))"
       ' response.Write sqlString
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
    <%else
            ikss=1%>
     
    <div style="clear:both;"></div>
    <table class="table table-striped">
        <%
Do While Not mmmGenel.EOF
iks=iks+1
strid=mmmGenel("id")
strkategori=mmmGenel("seoid")
strisim=mmmGenel("seolink")
strdil=mmmGenel("lang")


        gostermesayfa="1"

        if gostermesayfa="1" then
            ikss=ikss+1
%>
        <tr>
            <td>
                <%=strid%> - <%=strisim%> - <%=strkategori %> - <%=strdil %></td>
            <td>
                <input type="checkbox" name="linksil" checked class="flatred" id="urunidsila<%=iks%>" value="<%=strid%>"></td>
        </tr>
  <%
      end if
  mmmGenel.MoveNext
  loop
  %>
    </table>
    <div style="clear:both;"></div>
      <%if ikss>1 then %>
<input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right">
      <%end if %>
    <%
end if
close(mmmGenel)
%> 
  </div>
</form>
<%end if%>
    <SCRIPT LANGUAGE="JavaScript">


	function formla16(gelen16)
	{
	document.custlist16.action=gelen16;
	document.custlist16.submit();
	}
  //-->
  </SCRIPT>
</div>
<%call footer(1)%>