<!--#Include file="admin_menu1.asp"-->
<%
    if request("sek")="" then
else
    set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&request("sek")&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)
end if
    
    if request("duzelt")="" then%><%else%>
 
<%response.Write(setchar(Request("sek"),"0"))%>
<div class="right_col" role="main">
  <div class="x_panel">
 <div class="x_title">
      <h2><%=trbaslik%></h2>
      <div class="clearfix"></div>
    </div><form name="form1" method="post"  action="d_dilb.asp?filtre=1&islem=duzenleicerik&sek=<%=request("sek")%>" target="_parent">
	 <table class="table table-striped">
<%
sqlString = "select * from yazilar where id ="&request("id")&" ORDER BY yazib"
set mmmGenel= Con.Execute (sqlString)
if mmmGenel.eof then
else
if mmmGenel("bagli")="" or isNull(mmmGenel("bagli")) then
strbagli=request("id")
else
strbagli=mmmGenel("bagli")
end if
sqlString = "select * from yazilar where id ="&strbagli&" and dil='240' ORDER BY yazib"
set mmmYardimci= Con.Execute (sqlString)
if mmmYardimci.eof then
else
trbaslik=mmmYardimci("yazib")
tryazi=mmmYardimci("yazi")
trkategori=mmmYardimci("kategori")
end if
close(mmmYardimci)

dilbaslik=mmmGenel("yazib")
dilyazid=mmmGenel("yazi")
dilid=mmmGenel("id")
dilbagli=mmmGenel("bagli")
%>     		
		<input name="id" type="hidden"  value="<%=dilid%>" size="40" />
        <tr>
          <td>İçerik Başlık :</td>
        </tr>
        <tr>
          <td><input name="submit2" type="submit" value="Güncelle" class="btn btn-info pull-right"></td>
        </tr>
        <tr>
          <td><input name="haberb" type="text" id="sektor" value="<%=dilbaslik%>" class="form-control"/><%=trbaslik%>
            <input name="durum" type="hidden" id="durum6" value="1" />
             <%
if request("sek")="" or request("sek")="240" then
sqlString = "select * from yazilar where dil = '240' and id="&dilid&" ORDER BY bagli"
else
sqlString = "select * from yazilar where dil = '240' and id="&dilbagli&" ORDER BY bagli"
end if
set mmmYardimci= Con.Execute (sqlString)
if dilyazid="" then
cevvirim=tryazi
else
if dilyazid="" or isNull(dilyazid) then
cevvirim=tryazi
else
cevvirim=dilyazid
end if
end if
close(mmmYardimci)
%>
            </td>
        </tr>
        <%
		urunayar=trkategori
if request("modul")=1 then
sqlString = "select * from kategoriayar where id="&urunayar&"  ORDER BY id"
else
sqlString = "select * from kategoriayar where adres='"&urunayar&"'  ORDER BY id"
end if
set mmmYardimci = Con.Execute (sqlString)
if mmmYardimci.eof then
else
%>
                          <%if mmmYardimci("bilgi1")=1 then%>
                          <tr>
                            <td><%=mmmYardimci("bilgi1i")%> :<textarea name="bilgi1" cols="25" id="bilgi1" class="form-control"><%=mmmGenel("bilgi1")%></textarea></td>
                      
          </tr>
                          <%else%>
                          <%end if%>
                          <%if mmmYardimci("bilgi2")=1 then%>
                          <tr>
                            <td><%=mmmYardimci("bilgi2i")%> :<input type="text"name=bilgi2 id="bilgi2"  value="<%=mmmGenel("bilgi2")%>" class="form-control"/></td>
                           
          </tr>
                          <%else%>
                          <%end if%>
                          <%if mmmYardimci("bilgi3")=1 or request("urunid")="8" then%>
                          <tr>
                            <td><%if request("urunid")="8" then%>Fiyatı<%else%><%=mmmYardimci("bilgi3i")%><%end if%> :<input type="text"name=bilgi3 id="bilgi3"  value="<%=mmmGenel("bilgi3")%>" class="form-control"/></td>
                           
          </tr>
                          <%else%>
                          <%end if%>
                          <%if mmmYardimci("bilgi4")=1 then%>
                          <tr>
                            <td><%=mmmYardimci("bilgi4i")%> :<input type="text"name=bilgi4 id="bilgi4"  value="<%=mmmGenel("bilgi4")%>" class="form-control"/></td>
                           
          </tr>
                          <%else%>
                          <%end if
						   close(mmmYardimci)%>
                          <%end if%>
        <tr>
          <td>İçerik Detayı</td>
        </tr>
        <tr>
          <td>
            <textarea style="margin-top: 0px;" name="myTextarea" class="normal form-control"><%=cevvirim%></textarea>
          </td>
        </tr>
        <tr>
          <td><%=tryazi%></td>
        </tr>
        <tr>
        <td><input name="submit2" type="submit" value="Güncelle" class="btn btn-info pull-right"></td>
      </tr>
	  <%end if
	  close(mmmGenel)%>
    </table></form>
    </div>
    </div>
    <%call footer(1)%>
	<%response.end
	end if	%>
	
<%response.Write(setchar(Request("sek"),"0"))%>

 <%if request.QueryString("islemexcel")="" then %>
<div class="right_col" role="main">
<div class="x_panel ">
    <%
        else
        Response.AddHeader "content-disposition","attachment; filename="&request.QueryString("islemexcel")&".XLS"
Response.AddHeader "pragma", "no-store"
Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
Response.ContentType ="application/vnd.ms-excel"
        end if%>
    <%if request.QueryString("islemexcel")="" then %>
      <form  action="?filtre=1" method="post" name="form1" id="form2">
<table class="table table-striped">
         <tr>
          <td width="13%">DİL FİLTRESİ</td>
          <td>
            <select name="sek" class="form-control" id="durum5">
              <option value="1" selected="selected"> Kendi </option>
              <%
sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"
set mmmGenel= Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
              <option value="<%=mmmGenel("id")%>"  <% if mmmGenel("id")=int(request("sek")) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
              <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
            </select>
          </td>
          <td>
              <input name="Submit2" type="submit" id="Submit" value="Filtrele" class="btn-warning btn pull-left"/>
              <a href="?usayi=<%=request("usayi")%>&amp;islemexcel=yazidilexcelo&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float:right !important;">Orjinali Excel</a>
              <a href="?usayi=<%=request("usayi")%>&amp;islemexcel=yazidilexcelce&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float:right !important;">Çeviriyi Excel</a>
              <a href="?usayi=<%=request("usayi")%>&amp;islem=sildilleryazi&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float:left !important;">Dil İçeriğini Sil</a>
              <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseexcel" aria-expanded="true" aria-controls="collapseexcel" class="btn-warning btn pull-right">Excel Yükle</a>

          </td>
        </tr>
    </table>
      </form>
      <%end if %>
     <%if request.QueryString("islemexcel")="" then %>
    <table class="table table-responsive table-striped">
        <tr>
          <td colspan="3" >
              <div id="collapseexcel" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingexcel">
                  <div class="panel-body">                      
  <form action="?islemset=yazidilexcelyukla&sek=<%=request("sek")%>" method="post"  name="form">
<table class="table table-striped">
    <tr> 
      <td height="23" colspan="2">
    <div class="input-group" style="width:100%;">
        <div class="input-group-addon"><span class="fas fa-camera-alt"></span></div>
                <input class="form-control" id="fieldID1" aria-multiselectable="true" name="excelfile" type="text" value="<%=strocvstr %>">
                <div class="input-group-btn">
                    <a data-toggle="modal" href="#" data-href="<%=siteadres %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=0&fldr=/excel" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Dosya Seç</a>
                </div>
                </div>
      </td>
      <td>
                <input type="submit" value="Kaydet" name="submit" class="btn btn-primary pull-right" />
      </td>
    </tr>
</table>
  </form>
                  </div>
              </div>
          </td>
        </tr>
        </table>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>

                <div class="modal-body" style="padding: 0px; margin: 0px; width: 100%;">
                    <iframe width="100%" height="500" src="" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll;"></iframe>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
     <div class="x_title">
      <h2>DİL EKLE</h2>
      <div class="clearfix"></div>
    </div>
          <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%>&amp;islem=duzenledilleryazi&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" target="_self">
              <input name="charcode" type="hidden" id="charcode" value="<%=ceviridileki%>" />
    <table class="table table-striped">
                <%else %>
            <table border="1">
            <%end if %>
         <thead>
            <th width="1%">id</th>
            <th width="20%"><%if request.QueryString("islemexcel")="" then %>Türkçesi<%elseif request.QueryString("islemexcel")="yazidilexcelce" then %><%else %>Orjinali<%end if %></th>
            
            <th><%if request.QueryString("islemexcel")="" then %>Çevirisi<%elseif request.QueryString("islemexcel")="yazidilexcelce" then %>Orjinali<%else %><%end if %></th>
            <th><%if request.QueryString("islemexcel")="" then %>Seolink<%elseif request.QueryString("islemexcel")="yazidilexcelce" then %>Çeviri<%else %><%end if %></th>
            <th width="10%"><%if request.QueryString("islemexcel")="" then %>Düzenle<%end if %></th>
            </thead>
            <%response.Write(setchar(Request("sek"),"utf8"))
                if request.QueryString("islemexcel")="" then
                modulmuqry=" or modulmu='1'"
                else
                modulmuqry=""
                end if
sqlString = "select * from yazilar where dil ='240' and durum='1' and (urunid<>'1' and urunid<>'7') and (kategori in (SELECT id from kategoriyazi where modulmu='0'"&sayfagosterme&")"&modulmuqry&") order by modulmu,kategori,sira"
set mmmGenel= Con.Execute (sqlString)
if mmmGenel.eof then%>
          <tr>
            <td colspan="3">Ürün Kaydi Yok</td>
            <td>&nbsp;</td>
            </tr>
          <%else%>
            <%
Do While Not mmmGenel.EOF
iok=iok+1

         

if request("sek")=240 then
sqlString = "select * from yazilar where dil='"&request("sek")&"' and id="&mmmGenel("id")&" ORDER BY bagli"
else
sqlString = "select * from yazilar where dil='"&request("sek")&"' and bagli="&mmmGenel("id")&" ORDER BY bagli"
end if
set mmmYardimci1= Con.Execute (sqlString)
%>
       <%if request.QueryString("islemexcel")="" then %>
            <input name="haberid" type="hidden" id="haberid" value="<% if mmmYardimci1.eof then%>0<%else%><%=mmmYardimci1("id")%><%end if%>" />
       <%end if %>

    <TR> 
              <td><%=iok%></td>
              <td>
                <%
sqlString = "select * from yazilar where dil='240' and id="&mmmGenel("id")&" "
set mmmYardimci= Con.Execute (sqlString)
if mmmYardimci.eof then
else
ceviri=mmmYardimci("yazib")            
cvrurunid=mmmYardimci("urunid")
cvrmodulmu=mmmYardimci("modulmu")

                    if cvrurunid<>"9" and cvrurunid<>"4" and urunid<>"5" and urunid<>"3" and cvrmodulmu="0" then
                    cvrmodulmu="1"
                    end if
                  if request.QueryString("islemexcel")="" then%>
                  <input name="durum2" type="hidden" value="<%=mmmYardimci("id")%>" />
                <input type="text" name="durum21" id="durum21" value="<%=ceviri%>" class="form-control" />
                  <%elseif request.QueryString("islemexcel")="yazidilexcelce" then
                      else%>
                  <%=ceviri %>
                  <%end if %>
              <%
			  
end if
close(mmmYardimci)
if mmmYardimci1.eof then
'cevvirim=yandexdilcek(ceviridil,ceviri)
'cevvirim=""
else                     
sqlString = "select * from seolar where seoid='"&mmmYardimci1("id")&"' and seoturu='yazi'"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
smidseolar="0"
smidlang=aktifdil
cvrsseolink=".html"
else
smidseolar="1"
cvrstitle=mmmYardimci2("seobaslik")
cvrsdesc=mmmYardimci2("seoaciklama")
cvrsseolink=mmmYardimci2("seolink")
end if
close(mmmYardimci2)
cvrisim=mmmYardimci1("yazib")
if cvrisim="-" and mmmYardimci1("dil")<>"240" then
'cevvirim=yandexdilcek(ceviridil,ceviri)
'cevvirim=cvrisim
else
cevvirim=cvrisim
end if
end if
%>
              </td>
              <td><%
                  if request.QueryString("islemexcel")="" or request.QueryString("islemexcel")="yazidilexcelce" then %>
                    <%if request.QueryString("islemset")="sdilexcelyukla" then
                        cevvirim=split(ceviri1,"{}")(i)
                        end if
                        if request.QueryString("islemexcel")="" or (request.QueryString("islemexcel")="yazidilexcelce" and request.QueryString("islemset")="sdilexcelyukla") then
                        
                  %>
                  <input type="text" name="haberb" id="haberb" value="<%=cevvirim%>" class="form-control"/>
                  <input name="sira1" type="hidden" value="<%=mmmGenel("sira1")%>" />
                  <input name="modulmu" type="hidden" value="<%=cvrmodulmu%>" />
                  <%else
                        response.Write(cevvirim)
                      end if %>
                  <%end if %>
              </td>
        
        <%if cvrmodulmu="1" then %>
        <td>
            <% if request.QueryString("islemexcel")="" then %>
            <input type="hidden" name="seolink" value="" class="form-control"/>
            <%end if %>
        </td>
        <%else %>
              <td><% if request.QueryString("islemexcel")="" then %><input type="text" name="seolink" id="seolink" value="<% =cvrsseolink%>" class="form-control"/><%end if %></td>
        <%end if %>
              <td>
                  <%
                  if request.QueryString("islemexcel")="" then
                  %>
                <% if mmmYardimci1.eof then%>
                -
                <%else%>                  
                <a href="admin_uruny_duzenle.asp?duzelt=1&urunid=<%=mmmYardimci1("id")%>&sek=<%=request("sek")%>&anaurunid=<%= mmmGenel("urunid") %>&referer=dilyazi&dil=<%=Request("sek") %>" class="btn btn-info pull-right dropdown-toggle btn-md" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="İçerik D&uuml;zenle"><span class="fa fa-edit"></span></a>
                <%end if%>
                <%end if%>
              </td>
              </tr>
            <%close(mmmYardimci1)
                cvrsseolink=""
                cevvirim=""
			  mmmGenel.MoveNext
  loop
  %>
            <tr>
              <td colspan="4"></td>
              <td> <%
                  if request.QueryString("islemexcel")="" then
                  %><input name="Submit" type="submit" id="Submit5" value="Duzenle"class="btn btn-info pull-right" /><%end if %></td>
              </tr>
       <%
  close(mmmGenel)
  end if
           %>
        </table>
     <%if request.QueryString("islemexcel")="" then %>
          </form>
</div>
</div>
<%else
    response.End
    end if%>
<%response.Write(setchar(Request("sek"),"0"))%>
<%call footer(1)%>