<!--#Include file="admin_menu1.asp"-->
<div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>Seo Düzenle</h2>
               <div class="clearfix"></div></div>
                        <%if islem="islemseoduzenle" then %>
                      <%
sqlString = "select * from yazilar where id="&giriskont(request.QueryString("seoid"))&" order by sira,id, bagli"
set mmmGenel = Con.Execute (sqlString)
%>
          <%if mmmGenel.eof then%>
          Kayıt Yok
          <%else%>
            <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=seoduzen&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" target="_self">
            <input name="haberid" type="hidden" id="haberid" value="<%=mmmGenel("id")%>" />
                <h2><%=mmmGenel("yazib") %></h2>
            							 <span style="opacity:0;width:auto;height:auto;font-size:18px;" id="seotitle"><%=mmmGenel("title")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoDescription"><%=mmmGenel("descri")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoKey"><%=mmmGenel("keysi")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoUrl"><%=mmmGenel("seolink")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoUrlpath"><%=siteadres&"i/"%></span>
                            <!--#Include file="serp.html"-->
                <button id="send" type="submit" class="btn btn-success pull-right">Kaydet Devam Et</button>
                <a href="seo.asp" class="btn btn-success pull-right">Geri</a>
                </form>
                        <%
  end if
  close(mmmGenel)
  %>
            <%else %>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800&amp;subset=latin,latin-ext">
<link rel="stylesheet" type="text/css" href="serp/main.css">


          <%
sqlString = "select * from seolar where lang='240'"
set mmmGenel = Con.Execute (sqlString)
%>
          <%if mmmGenel.eof then%>
         Ürün Kayıt Yok
          <%else
Do While Not mmmGenel.EOF
ieo=ieo+1
modcnt=ieo mod 3
              strseoturu=mmmGenel("seoturu")
              if modcnt="0" then
              response.Write "<div class=""row"">"
              end if
              if strseoturu="yazi1" then
              if langstr="" or langstr="240" then
sqlString = "select * from yazilar where dil='240' and (bagli="&syaziid&" or id="&syaziid&" or id="&syazibagli&")"
                    else
sqlString = "select * from yazilar where dil='"&mmmYardimci1("id")&"' and (bagli="&syazibagli&" or id="&syaziid&" or id="&syazibagli&")"
                    end if
set mmmYardimci= Con.Execute (sqlString)
if mmmYardimci.eof then
hraflng=""
else
if dil&""<>""&mmmYardimci1("id") then
              hraflng=hraflng&"<link rel=""alternate"" href="""&seolarlinki&""" hreflang="""&mmmGenel("ceviricode")&""" />"
                %>
                <a href="?duzelt=1&amp;urunid=<%=mmmYardimci("id")%>&amp;dkate2=<%=request("dkate2")%>&sek=<%=request("sek")%>&anaurunid=<%=anaurunid %>&dil=<%=mmmYardimci1("id") %>" class="btn btn-info pull-right dropdown-toggle btn-md"><%=mmmYardimci1("kate")%></a>
                <%
			  end if
			  end if
			  close(mmmYardimci)
                    elseif strseoturu="yazi" then
                    sqlString = "select * from yazilar where id='"&mmmGenel("seoid")&"'"
                    set mmmYardimci= Con.Execute (sqlString)
                    if mmmYardimci.eof then
                    linkvarmi="0"
                    silmek = "delete from seolar where id="&mmmGenel("id")&""
                    Con.execute(silmek)
                    else
                    linkvarmi="1"
                    end if
                    close(mmmYardimci)
                    elseif strseoturu="sayfa" then
                    sqlString = "select * from kategoriyazi where id='"&mmmGenel("seoid")&"'"
                    set mmmYardimci= Con.Execute (sqlString)
                    if mmmYardimci.eof then
                    linkvarmi="0"
                    silmek = "delete from seolar where id="&mmmGenel("id")&""
                    Con.execute(silmek)
                    else
                    linkvarmi="1"
                    end if
                    close(mmmYardimci)
                    elseif strseoturu="emlak-ilanlari" then
                    sqlString = "select * from "&dbekategoritur&" where id='"&mmmGenel("seoid")&"'"
                    set mmmYardimci= Con.Execute (sqlString)
                    if mmmYardimci.eof then
                    linkvarmi="0"
                    silmek = "delete from seolar where id="&mmmGenel("id")&""
                    Con.execute(silmek)
                    else
                    linkvarmi="1"
                    end if
                    close(mmmYardimci)
                    elseif strseoturu="ilan-detay" then
                    sqlString = "select * from "&dbeilanlar&" where id='"&mmmGenel("seoid")&"'"
                    set mmmYardimci= Con.Execute (sqlString)
                    if mmmYardimci.eof then
                    linkvarmi="0"
                    silmek = "delete from seolar where id="&mmmGenel("id")&""
                    Con.execute(silmek)
                    else
                    linkvarmi="1"
                    end if
                    close(mmmYardimci)
              else
              end if
                    if linkvarmi="1" then
%>
<div class="col-md-12">  
              <div class="panel panel-default">  
                <div class="panel-heading"><%=mmmGenel("seolink") %><%if linkvarmi="1" then %><a href="?islem=islemseoduzenle&seoid=<%=mmmGenel("id")%>" class="btn btn-primary btn-xs pull-right" role="button">Seo Düzenle</a><%end if %></div>
  <div class="panel-body">
                    <div class="serp-preview__tool">
          <div class="row" style="margin:0px;">              
                            <div class="mobile" style="width:100%;">
                                <div class="serp-preview__tool-search-results">
                                    <div class="results">
                                        <p class="title" id="serpTitle"><%=mmmGenel("seobaslik")%></p>
                                        <p class="site"><%=mmmGenel("seolink")%></p>                                        
                                        <p class="description"><%=mmmGenel("seoaciklama")%></p>
                                        <p class="h1"><%=mmmGenel("seoh1")%></p>
                                        <p class="seoturu"><%=mmmGenel("seoturu")%></p>
                                    </div>
                                </div>
                            </div>
                        </div> </div>
  </div>
        
              </div>
              </div>
            <%
                end if
              if modcnt="0" then
              response.Write "</div>"
              end if
			  mmmGenel.MoveNext
  loop
  end if
  close(mmmGenel)
  %>

</div>
    <%end if %>
</div>
<%call footer(1)%>