<!--#Include file="admin_menu1.asp"--> 
<div class="right_col" role="main">
        <div class="x_panel">
<%
    islem=request.QueryString("islem")
    if islem="sitemapcreate" then
    call sitemap
    end if
if session("yonet_dil")="" then
session("yonet_dil")=240
else
if request("dil")="" then
session("yonet_dil")=session("yonet_dil")
else
session("yonet_dil")=request("dil")
end if
end if
    submitlink="?islem=sitemapcreate"
    %>
        <form method="post" name="Form1" id="myForm" action="<%=submitlink %>">
            <table cellpadding="3" class="table table-hover">
			<thead>
			<tr>
				<th></th>
				<th width="50%">URL</th>
									<th>Images</th>
												<th>Priority</th>
				<th>Change Frequency</th>
				<th>Last Change</th>
			</tr>
			</thead>
			<tbody>
<%
'Call sitemap()
   

    set mmmYardimci2 = Con.Execute ("select seolink,seoid,seoturu,id from seolar where (noindex<>'1' or isNull(noindex)) and lang='240' order by lang,id")
Do While Not mmmYardimci2.eof
yicnt=yicnt+1
strid=mmmYardimci2("id")
seoid=mmmYardimci2("seoid")
seolink=mmmYardimci2("seolink")
seoturu=mmmYardimci2("seoturu")
    if seoturu="sayfa" then
    strdb="kategoriyazi"
    strwhere=" id ="&seoid&""
    strtarih="gtarih"
    stronaye="durum"
    elseif seoturu="yazi" then
    strdb="yazilar"
    strwhere=" id ="&seoid&" and (urunid <> '1' and urunid <> '7')  "
    strtarih="gtarih"
    stronaye="durum"
    else
    end if
    
    if strdb="" then
    silindi="0"
    else
sqlString = "select "&strtarih&" as ngtarih,"&stronaye&" from "&strdb&" where"&strwhere&""
set mmmSayfa = Con.Execute (sqlString)
if mmmSayfa.eof then
    silmek = "delete from seolar where id="&strid&""
'Con.execute(silmek)
    silindi="1"
    response.Write silindi
else
    silindi="0"
    menugdate=mmmSayfa("ngtarih")
    menugonay=mmmSayfa("durum")
    if menugonay="1" then
    silindi="0"
    else
    silindi="1"
    end if
    end if
    close(mmmSayfa)
    end if
    if silindi="0" then

    sqlString = "select * from seositemap where contentid='"&strid&"'"
set mmmSayfa = Con.Execute (sqlString)
if mmmSayfa.eof then
    'strurl=""
    strpiority=""
    strfreq=""
    strlastchng=""
    strimage=""
    strhreflang=""
    strcontenttype=""
strurunonay=""
else
    'strurl=mmmSayfa("url")
    strpiority=mmmSayfa("piority")
    strfreq=mmmSayfa("freq")
    strlastchng=mmmSayfa("lastchng")
    strimage=mmmSayfa("image")
    strhreflang=mmmSayfa("hreflang")
    strcontenttype=mmmSayfa("contenttype")
strurunonay=mmmSayfa("secili")
    end if
    close(mmmSayfa)

    %>               
                
<!--	<url>
		<loc>https://www.damlakaraman.com.tr/alexa-dusurme-yontemleri-ve-teknikleri/</loc>
    <xhtml:link rel="alternate" hreflang="de" href="http://www.example.com/deutsch/page.html"/>
    <xhtml:link rel="alternate" hreflang="de-ch" href="http://www.example.com/schweiz-deutsch/page.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="http://www.example.com/english/page.html"/>
		<lastmod>2014-09-11T12:24:24Z</lastmod>
		<changefreq>yearly</changefreq>
		<priority>0.1</priority>
		<image:image>
			<image:loc>https://www.damlakaraman.com.tr/wp-content/uploads/alexa.png</image:loc>
			<image:caption></image:caption>
			<image:title>alexa</image:title>
		</image:image>
		<image:image>
			<image:loc>http://www.damlakaraman.com.tr/wp-content/uploads/alexa-dusurme-yontemi-1024x394.jpg</image:loc>
		</image:image>
    <news:news>
    <news:publication>
      <news:name>The Example Times</news:name>
      <news:language>en</news:language>
    </news:publication>
    <news:publication_date>2008-12-23</news:publication_date>
      <news:title>Companies A, B in Merger Talks</news:title>
    </news:news>
	</url>-->
				<tr>
                    
					<td>
      <%
          'strurunonay="1"
          if strurunonay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("urlsec","Seç","y"&yicnt,cbcdisstr,cbccheckstr,"success"))%>
					</td>
					<td>
                            <input type="text" name="url" class="form-control clr" value="<%=siteadres %><%=seolink %>">	
                            <input type="hidden" name="contentid" value="<%=strid %>">	
                            <input type="hidden" name="contenttype" value="<%=seoturu %>">	
					</td>
					<td>
					<xsl:value-of select="count(image:image)"/>
					</td>
					<td>
                        <select name="piority" class="form-control clr">
                            <option value="noselect">Gösterme</option>
                            <%picnta="0"
                                for picnt=1 to 10
                                picnta=picnta+0.1%>
                            <option value="<%=picnta %>" <%if strpiority&""=""&picnta then %>selected<%else %><%end if %> ><%=picnta %></option>
                            <%next %>
                        </select>
					</td>
					<td>
                        <select name="freq" class="form-control clr">
                            <option value="noselect">Gösterme</option>
                            <option value="Always" <%if strfreq&""="Always" then %>selected<%else %><%end if %> >Always</option>
                            <option value="Hourly" <%if strfreq&""="Hourly" then %>selected<%else %><%end if %> >Hourly</option>
                            <option value="Daily" <%if strfreq&""="Daily" then %>selected<%else %><%end if %> >Daily</option>
                            <option value="Weekly" <%if strfreq&""="Weekly" then %>selected<%else %><%end if %> >Weekly</option>
                            <option value="Monthly" <%if strfreq&""="Monthly" then %>selected<%else %><%end if %> >Monthly</option>
                            <option value="Yearly" <%if strfreq&""="Yearly" then %>selected<%else %><%end if %> >Yearly</option>
                            <option value="Never" <%if strfreq&""="Never" then %>selected<%else %><%end if %> >Never</option>
                        </select>
					</td>
					<td>
                        <input type="text" name="lastchng" class="form-control clr" value="<%=menugdate %>">
					</td>
				</tr>
<%
    end if
    response.Flush
mmmYardimci2.movenext
loop
close(mmmYardimci2)    
    %>                
			</tbody>
		</table>
            
            <div class="col-md-12"><input type="submit" value="Site Haritası Oluştur" name="submit2" class="btn btn-info pull-right" /></div>
        </form>
</div>
</div>
<%call footer(1)%>