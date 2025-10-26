<!--#Include file="admin_menu1.asp"-->
  
<div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>Seo Düzenle</h2>
               <div class="clearfix"></div></div>
            <%if islem="islemseoduzenle" then %>
                      <%
sqlString = "select * from kategoriyazi where id="&giriskont(request.QueryString("seoid"))&" order by sira,id, bagli"
set mmmGenel = Con.Execute (sqlString)
%>
          <%if mmmGenel.eof then%>
          Kayıt Yok
          <%else%>
            <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=seoduzenbaslik&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" target="_self">
            <input name="haberid" type="hidden" id="haberid" value="<%=mmmGenel("id")%>" />
            							 <span style="opacity:0;width:auto;height:auto;font-size:18px;" id="seotitle"><%=mmmGenel("title")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoDescription"><%=mmmGenel("descri")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoKey"><%=mmmGenel("keysi")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoUrl"><%=mmmGenel("seolink")%></span>
                <span style="opacity:0;width:auto;height:auto;font-size:13px;" id="seoUrlpath"><%=siteadres&"i/"%></span>
                            <!--#Include file="serp.html"-->
                <button id="send" type="submit" class="btn btn-success pull-right">Kaydet Devam Et</button>
                <a href="seobaslik.asp" class="btn btn-success pull-right">Geri</a>
                </form>
                        <%
  end if
  close(mmmGenel)
  %>
            <%else %>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800&amp;subset=latin,latin-ext">
<link rel="stylesheet" type="text/css" href="serp/main.css">
          <%
sqlString = "select * from kategoriyazi where dil ='240' and modulmu='0'"&sayfagosterme&" order by anasek,sira,id, bagli"
set mmmGenel = Con.Execute (sqlString)
%>
          <%if mmmGenel.eof then%>
          Kayıt Yok
          <%else

Do While Not mmmGenel.EOF
ieo=ieo+1
modcnt=ieo mod 3
              if modcnt="0" then
              response.Write "<div class=""row"">"
              end if
%>

              <div class="col-md-4">  
              <div class="panel panel-default">  
                <div class="panel-heading"><%=mmmGenel("isim") %><a href="?islem=islemseoduzenle&seoid=<%=mmmGenel("id")%>" class="btn btn-primary btn-xs pull-right" role="button">Seo Düzenle</a></div>
  <div class="panel-body">
                    <div class="serp-preview__tool">
          <div class="row" style="margin:0px;">              
                            <div class="mobile" style="width:100%;">
                                <div class="serp-preview__tool-search-results">
                                    <div class="results">
                                        <p class="title" id="serpTitle"><%=mmmGenel("title")%></p>
                                        <p class="site"><%=mmmGenel("seolink")%></p>                                        
                                        <p class="description"><%=mmmGenel("descri")%></p>
                                    </div>
                                </div>
                            </div>
                        </div> </div>
  </div>
        
              </div>
              </div>
            <%
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