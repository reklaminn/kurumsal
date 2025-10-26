<!--#Include File="admin_menu1.asp"-->
<%
islem=Request.QueryString("islem")
if islem="sablonbolekle" then
call sablonbolekle
else
end if
   
sub sablonbolekle

    if request.QueryString("edit")="1" then
Con1.execute("update yonetici_sablon_bol set isim='"&request.Form("isim")&"', sayfatemp='"&csskont(request.Form("myTextarea"))&"' where id="&request.QueryString("sablonid")&"")
    else
Con1.execute("insert yonetici_sablon_bol set isim='"&request.Form("isim")&"', sayfatemp='"&csskont(request.Form("myTextarea"))&"'")
    end if

session("hata1")="Menü Eklendi"
session("hatam1")="green"

end sub
    %>
<div class="right_col" role="main">
 
    <div class="x_panel">
            <div class="x_title">
                <h2>Şablon Böl</h2>
                
                <div class="clearfix"></div>
            </div>
        
      <div class="form-group">
      <div class="input-group">
      <div class="input-group-addon">
         Sayfaya Git
          </div>
    <select name="dkate2" class="form-control" onChange="MM_jumpMenu('parent',this,0)" id="dkate">
        <div class="input-group">
      <option value="?"> Şablon Seç </option>
         <%
		sqlString = "select * from yonetici_sablon_bol  order by id desc "
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
i=i+1
                       modulid=mmmYardimci("id")
%>
                        <option value="?sablonid=<% =modulid %>" <%if ""&modulid&""=""&strrowtempmodul&"" then%>selected<%else%><%end if%>>
                          <% = mmmYardimci("isim")%>
                          </option>
                        <%										  
							mmmYardimci.MoveNext
  loop
end if

Close(mmmYardimci)
%>
    </select>
          
                <div class="input-group-btn">
                    <a href="?" class="btn btn-success">Yeni Ekle</a>
                    
                </div>
          </div>
          </div>
          </div>
        <%
            if request.QueryString("sablonid")="" then
            sablonid="0"
            else
            sablonid=request.QueryString("sablonid")
            end if
            		sqlString = "select * from yonetici_sablon_bol where id="&sablonid&"  order by id desc "
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
            linkeditstr=""
else
            sablonid=mmmYardimci("id")
            sablonisim=mmmYardimci("isim")
            sablonisim1=sablonisim
            sablontemp=mmmYardimci("sayfatemp")
            linkeditstr="&edit=1&sablonid="&sablonid&""
            end if
            Close(mmmYardimci)
            %>
        <form name="form1" method="post"  action="?islem=sablonbolekle<%=linkeditstr %>">
 <!--#Include file="codeeditor.html"-->
            
            <div class="input-group">
                <input class="form-control" id="fieldID1" aria-multiselectable="true" name="d1" type="text" value="<%=strcsd1 %>">
                <div class="input-group-btn">
                    <a data-toggle="modal" href="#" data-href="<%=siteadres %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=0&fldr=/temp" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>
                </div>
                <div class="input-group-btn">
                    <a href="tinymce/plugins/insertsablon/insertsablon.asp?type=2&field_id=fieldID1" class="btn btn-success dropdown-toggle" data-toggle="modal" data-target="#baslikmodal">Insert Şablon</a>
                    
                </div>
                <div class="input-group-btn">
                    <a href="tinymce/plugins/fontawesome/fontawesome.asp?type=2&field_id=fieldID1" class="btn btn-success dropdown-toggle" data-toggle="modal" data-target="#baslikmodal">Icons</a>
                    
                </div>
            </div>
            <div class="form-group">
            <div class="input-group">
                <input class="form-control" name="isim" type="text" value="<%=sablonisim %>">
                <%if sablonisim="" then
                    else%>
            <div class="input-group-btn">
                <input class="form-control" style="width:300px;" name="dosyauzanti" type="text" value="<%=request.querystring("dosyauzanti") %>">
                </div>
            <div class="input-group-btn">
                <input type="checkbox" name="bolme" class="flatred" value="1">
                </div>
                <%end if %>
                </div>
            <div class="form-group">
            <input name="advcode" type="hidden" value="1" />
                <%
                    if sablonisim1="" then
                    tempname="default"
                    else
                    tempname=baslikkont(sablonisim1)
                    end if
                    yazistr=sablontemp
                    if request.Form("bolme")="1" then
                    sablonnew=sablontemp
                    dosyauzanti=request.form("dosyauzanti")
                    if dosyauzanti="" then
                    dosyauzanti=""
                    end if
                    else
                    dosyauzanti=request.form("dosyauzanti")
                    if dosyauzanti="" then
                    dosyauzanti=""
                    end if
                    end if


                    yazistrcnt=ubound(split(yazistr,"<"))
                      for ysc=1 to yazistrcnt
                      yazistrsi=split(yazistr,"<")(ysc)
                      elementi=split(yazistrsi,"</")(0)
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))

                    if elementstr="" or len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    if instr(yazistrsi," href=") then
                    hrefstrbas=split(yazistrsi," href=""")(0)
                    hrefstrorta=split(split(yazistrsi," href=""")(1),"""")(0)
                    hrefstrorta1="href="""&split(split(yazistrsi," href=""")(1),"""")(0)&""""
                if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi," href=""""")(1)
                hrefkesmevar=""
                    else
                    'hrefstrson=split(yazistrsi,"href="""&hrefstrorta1)(1)
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                'response.Write hrefstrson&"<br>"
                    yazistrsi=""&hrefstrbas&" href=""${edit}"&hrefstrorta&"${/edit(link,#cnt#-"&ysc&")}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," alt=") then
                    hrefstrbas=split(yazistrsi," alt=""")(0)
                    hrefstrorta=split(split(yazistrsi," alt=""")(1),"""")(0)
                    hrefstrorta1="alt="""&split(split(yazistrsi," alt=""")(1),"""")(0)&""""
                    if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi,"alt=""""")(1)
                hrefkesmevar=""
                    else
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    'hrefstrson=split(yazistrsi,"alt="""&hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                    yazistrsi=""&hrefstrbas&" alt=""${edit}"&hrefstrorta&"${/edit(text,#cnt#-"&ysc&",Alt Tagi)}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi,"title=") then
                    hrefstrbas=split(yazistrsi,"title=""")(0)
                    hrefstrorta1="title="""&split(split(yazistrsi,"title=""")(1),"""")(0)&""""
                    hrefstrorta=split(split(yazistrsi,"title=""")(1),"""")(0)
                    if hrefstrorta="" then
                    hrefstrson=""""&split(yazistrsi,"title=""""")(1)
                hrefkesmevar=""
                    else
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    'hrefstrson=split(yazistrsi,"title="""&hrefstrorta1)(1)
                hrefkesmevar=""""
                    end if
                    yazistrsi=""&hrefstrbas&"title=""${edit}"&hrefstrorta&"${/edit(text,#cnt#-"&ysc&",Title Tagi)}"&hrefkesmevar&""&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-thumb=") then
                    hrefstrbas=split(yazistrsi," data-thumb=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-thumb=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-thumb="""&hrefstrorta)(1)
                    yazistrsi=""&hrefstrbas&" data-thumb=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Thumb Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-image_src=") then
                    hrefstrbas=split(yazistrsi," data-image_src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-image_src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-image_src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-image_src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    end if
                    if instr(yazistrsi," data-image-src=") then
                    hrefstrbas=split(yazistrsi," data-image-src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-image-src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-image-src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-image-src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if

                    if instr(yazistrsi," data-src=") then
                    hrefstrbas=split(yazistrsi," data-src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if

                    if instr(yazistrsi," data-background_image_src=") then
                    hrefstrbas=split(yazistrsi," data-background_image_src=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-background_image_src=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-background_image_src="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-background_image_src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Data-Image-Src Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," data-background=") then
                    hrefstrbas=split(yazistrsi," data-background=""")(0)
                    hrefstrorta=split(split(yazistrsi," data-background=""")(1),"""")(0)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,"data-background="""&hrefstrorta)(1)
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" data-background=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",data-background Tagi)}"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi,"background-image:") then
                    hrefstrbas=split(yazistrsi,"background-image:")(0)
                    if instr(yazistrsi,"background-image: url") then
                    hrefstrorta1="url("&split(split(yazistrsi,"background-image: url(")(1),")")(0)&")"
                    hrefstrorta=split(split(yazistrsi,"background-image: url(")(1),")")(0)
                else
                    hrefstrorta1="url("&split(split(yazistrsi,"background-image:url(")(1),")")(0)&")"
                    hrefstrorta=split(split(yazistrsi,"background-image:url(")(1),")")(0)
                end if
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                'response.Write hrefstrson&"<br>"
                    if instr(hrefstrorta,"/") then
                    'hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&"background-image: url(${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&",Arka Zemin Resmi)})"&hrefstrson
                    cnt=cnt+1
                    end if
                    if instr(yazistrsi," src=") then
                    hrefstrbas=split(yazistrsi," src=""")(0)
                    hrefstrorta=split(split(yazistrsi," src=""")(1),"""")(0)
                    hrefstrorta1="src="""&split(split(yazistrsi," src=""")(1),"""")(0)&""""
                    hrefstrson=split(yazistrsi,hrefstrorta1)(1)
                    imgmainsrc=imgmainsrc&"<img src="""&dosyauzanti&""&hrefstrorta&"""/>"
                    if instr(hrefstrorta,"/") then
                    hrefstrorta="/contents/img/temp/"&tempname&"/"&split(hrefstrorta,"/")(ubound(split(hrefstrorta,"/")))
                    end if
                    yazistrsi=""&hrefstrbas&" src=""${edit}"&hrefstrorta&"${/edit(img,#cnt#-"&ysc&")}"""&hrefstrson
                    cnt=cnt+1
                    end if

                    if cnt="1" then
                    cntstr="12"
                    elseif cnt="2" then
                    cntstr="6"
                    elseif cnt="3" then
                    cntstr="4"
                    elseif cnt="4" then
                    cntstr="3"
                    else
                    cntstr="2"
                    end if
                    ev3="<"&replace(yazistrsi,"#cnt#",cntstr)
    
                    else
                      ev3="<"&split(elementi,">")(0)&">${edit}"&elementstr&"${/edit(text,6-"&ysc&")}"
                    
                    if instr(ev3,"href=") then
                    hrefstrbas=split(ev3,"href=""")(0)
                    hrefstrorta=split(split(ev3,"href=""")(1),"""")(0)
                    if ubound(split(ev3,hrefstrorta))<1 then
                    hrefstrson=""">"
                    else
                    hrefstrson=split(ev3,hrefstrorta)(1)
                    end if
                    ev3=""&hrefstrbas&"href=""${edit}"&hrefstrorta&"${/edit(link,6-"&ysc&")}"&hrefstrson
                    else
                    ev3=replace(ev3,"edit(text,6","edit(text,12")
                    end if

                    end if
                    'response.Write yazistrsi&"<br>"
                    sablonnew=sablonnew&ev3
                      if instr(elementi,"=""") then
                      elementiv1=split(elementi," ")(0)
                      'ev2="data-json="""&replace(replace(replace(replace(split(elementi,">")(0),""" ","', "),"=",": "),"""","'"),""&elementiv1&" ","")&""""
                      ev2="data-"&replace(replace(split(elementi,">")(0),""" ",""" data-"),""&elementiv1&" ","")&""
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      etype=elementiv1

                      elseif instr(elementi,"/>") then
                      elementiv1=split(elementi,"/>")(0)
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(elementstr,"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      ev2=""
                      etype=elementiv1
                      
                      else
                      ev2=""
                    elementstr=trim(split(elementi,">")(1))
                    elementstrenc=trim(replace(replace(server.URLEncode(split(elementi,">")(1)),"%09",""),"%0D%0A",""))
                    if elementstr="" then
                    ev3=""
                    else
                    if len(replace(trim(split(elementi,">")(1)),"	",""))="2" or elementstrenc="" then
                    ev3=""
                    else
                      ev3="${edit}"&elementstr&"${/edit(text)}"
                    end if
                    end if
                      elementiv1=split(elementi,">")(0)  
                      etype=elementiv1                    
                      
                      end if

                                            
                      if instr(elementiv1,"/") then
                      eolli="</ol></li>"
                      else
                      if instr(elementiv1,"br") then
                      eolli=""
                      else
                      eolli="<li data-type="""&etype&""""&ev2&"><ol>"&ev3&""
                      end if
                      end if

                      htmlelement= htmlelement&""&eolli
                    cnt="0"
                    
                      next
                    
                    if request.Form("bolme")="1" then
                    sablonnew=yazistr
                    end if
                    'response.Write 
                   ' response.Write "<ol class=""block nested_with_switch vertical"">"&htmlelement&"</ol>"sablontempreplace(replace(sablonnew&" ","`","'"),"</textarea>","[/textarea]")
                    %>
            <textarea name="myTextarea" id="beautifiedhtml" style="width: 100%; height: 50vh;" class="form-control"><%=replace(replace(sablonnew&" ","`","'"),"</textarea>","[/textarea]")%></textarea>
                </div>
            <div class="handle"></div>
            <script>
                            format("html", "text/html", this);
            </script>
            
            <div class="form-group">
            <input name="submit2" type="submit" value="Kaydet" class="btn btn-success pull-left">
                </div>
            <%response.Write imgmainsrc %>
</form>
    </div>
    <%call footer(1)%>
