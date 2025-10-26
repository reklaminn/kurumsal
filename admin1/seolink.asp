<!--#Include file="admin_menu1.asp"-->
<!-- page content -->


<%
function harfduzelt(veri)
Verii5=veri&""
Verii5 = Replace(Verii5, "Ä±", "ı")
Verii5 = Replace(Verii5, "ÅŸ", "ş")
Verii5 = Replace(Verii5, "Ä°", "İ")
Verii5 = Replace(Verii5, "Ã§", "ç")
Verii5 = Replace(Verii5, "â‚¬", "€")
harfduzelt=Verii5
end Function

    seolinksabit="*gemi-sirketleri*,*cruise-lines*,*gemi-turu-ara*,*search-cruise*,*gemi-turlari*,*cruise-tours*,*feribot-turlari*,*ferry-tours*,*turlar*,*tours*,*gemiler*,*cruises*,*kabinler*,*cabins*,*destinasyonlar*,*destination*,*feribot-sefer-hatlari*,*ferry-ports*,*tur-destinasyonlari*,*destination*,*limanlar*,*ports*,*kampanyalar*,*promotion*,*tur-detay*,*tour-details*,*feribot-tur-detay*,*ferry-tour-details*,*turlar-detay*,*tours-details*,*i*,*y*"

    dbuploadreferansgaleri="../contents/img/"
    if request.QueryString("islem")="topluseolinkekle" then
    call topluseolinkekle
    end if
     sub topluseolinkekle
    server.ScriptTimeout=1000
   

dost=request.Form("d1")
    
lkj=lkj+1
if instr(dost,".csv") or instr(dost,".CSV") then
 
ixls = 0
  Dim MyArray, MyArray1
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(Server.MapPath(""&dost&"")) Then
    Set objStream = fso.OpenTextFile(Server.MapPath(""&dost&""), 1, False, 0)

Do While Not objStream.AtEndOfStream
    strLine = objStream.ReadLine
   'response.Write strLine&"<br>"
       ReDim MyArray(0), MyArray1(0)
   if instr(strLine, """") or instr(strLine, ",") or instr(strLine, ";") then
    if instr(strLine, """") then
    MyArray = Split(strLine, """")
    myraycount=ubound(MyArray)
    'response.Write "aaa"&myraycount&"aaa"
    streskilink=harfduzelt(MyArray(1))
    'response.Write streskilink&"<br>"
    
    if instr(streskilink,"/") then
    stranalink=split(streskilink,"/")(2)
    streskilinka=replace(streskilink,"https://"&stranalink&"/","")
    if instr(seolinksabit,"*"&streskilinka&"*") then
    'streskilink="/"&streskilinka&"/"&split(streskilink,"/")(4)
    streskilink=""
    else
    streskilink="/"&streskilinka
    end if

    if myraycount>1 then
    stradres=MyArray(2)
    MyArray1 = Split(stradres, ",")
    myraycount1=ubound(MyArray1)
    tiklama=replace(MyArray1(1),".",",")
    gosterim=replace(MyArray1(2),".",",")
    tom=replace(replace(MyArray1(3),".",","),"%","")
    siralama=replace(MyArray1(4),".",",")
    end if
    else
    streskilink=""
    end if

    elseif instr(strLine, ";") then

     MyArray = Split(strLine, ";")
    myraycount=ubound(MyArray)
    'response.Write "aaa"&myraycount&"aaa"
    streskilink=harfduzelt(MyArray(0))
    if instr(streskilink,"/") then
    stranalink=split(streskilink,"/")(2)
    streskilinka=replace(streskilink,"https://"&stranalink&"/","")
    if instr(seolinksabit,"*"&streskilinka&"*") then
    'streskilink="/"&streskilinka&"/"&split(streskilink,"/")(4)
    streskilink=""
    else
    streskilink="/"&streskilinka
    end if
    'response.Write streskilink

    gosterim=replace(MyArray(1),".",",")

    else
    streskilink=""
    end if
    else
     MyArray = Split(strLine, ",")
    myraycount=ubound(MyArray)
    'response.Write "aaa"&myraycount&"aaa"
    streskilink=harfduzelt(MyArray(0))
    'response.Write streskilink&"<br>"
    
    if instr(streskilink,"/") then
    stranalink=split(streskilink,"/")(2)
    streskilinka=replace(streskilink,"https://"&stranalink&"/","")
    if instr(seolinksabit,"*"&streskilinka&"*") then
    'streskilink="/"&streskilinka&"/"&split(streskilink,"/")(4)
    streskilink=""
    else
    streskilink=streskilinka
    end if

    'response.Write streskilink
    if myraycount>1 then
    tiklama=replace(MyArray(1),".",",")
    gosterim=replace(MyArray(2),".",",")
    tom=replace(replace(MyArray(3),".",","),"%","")
    if myraycount>3 then
    siralama=replace(MyArray(4),".",",")
    end if
    end if    
    else
    'response.Write streskilink&"<br>"
    'streskilink=""
    end if

    end if

    'response.Write streskilink&"<br>"
    if streskilink="" then
    else

    
tstreskilink=replace(replace(streskilink,"/",""),".html","")
tstreskilink=replace(tstreskilink,"-1","")
tstreskilink=replace(tstreskilink,"-0","")
tstreskilink=replace(tstreskilink,"-3","")
tstreskilink=replace(tstreskilink,"-2","")
tstreskilink=replace(tstreskilink,"1","")
tstreskilink=replace(tstreskilink,"2","")
tstreskilink=replace(tstreskilink,"3","")
tstreskilink=replace(tstreskilink,"4","")
tstreskilink=replace(tstreskilink,"5","")
tstreskilink=replace(tstreskilink,"6","")
tstreskilink=replace(tstreskilink,"7","")
tstreskilink=replace(tstreskilink,"8","")
tstreskilink=replace(tstreskilink,"9","")
tstreskilink=replace(tstreskilink,"0","")
    sqlString = "select seolink from seolar where instr(seolink,'"&tstreskilink&"')<>'0'"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
if myraycount>2 then
tstyenilink="0"
else
tstyenilink=MyArray(1)
end if
'response.Write strLine&"<br>"
else
tstyenilink=siteadres&mmmGenel("seolink")
end if 
close(mmmGenel)

     sqlString = "select * from seolink where eskilink='"&streskilink&"'"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
    sqlString="insert seolink set eskilink='"&streskilink&"', yenilink='"&tstyenilink&"',pozisyon='"&siralama&"',tom='"&tom&"',gosterim='"&gosterim&"',tiklama='"&tiklama&"',tur='google'"
else
     'sqlString="update seolink set pozisyon='"&siralama&"',tom='"&tom&"', yenilink='"&tstyenilink&"',gosterim='"&gosterim&"',tiklama='"&tiklama&"',tur='google' where eskilink='"&streskilink&"'"
     sqlString="update seolink set pozisyon='"&siralama&"',tom='"&tom&"',gosterim='"&gosterim&"',tiklama='"&tiklama&"',tur='google' where eskilink='"&streskilink&"'"
end if
    close(mmmGenel)
Con.execute(sqlString)
    end if
     ixls = ixls + 1
    if ixls=15000 or ixls=30000 or ixls=45000 or ixls=60000 or ixls=75000 or ixls=90000 or ixls=105000 then
    response.Flush
    end if
    
    end if
    
Loop
'response.end
        else
    end if
    set fs=nothing

    Set fso1 = CreateObject("Scripting.FileSystemObject")
    If fso1.FileExists(Server.MapPath(""&dost&"")) Then
    'If fso1.FileExists(Server.MapPath(""&dbuploadreferansgaleri&""&fname&"")) Then
    'fso1.DeleteFile(Server.MapPath(""&dbuploadreferansgaleri&""&fname&""))
    'fso1.DeleteFile(Server.MapPath(""&dost&""))
    else
    end if
    set fs1=nothing
    end if
fname=""
    'response.End
    call islemmessagesession("green","Excel Eklendi","1")

    end sub
    %>
        <div class="right_col" role="main">
        <div class="x_panel">
               <div class="x_title"><h2>Eski Link Ekle</h2>
               <div class="clearfix"></div></div>
            <div class="col-md-6">
  <form name="form1" method="post" action="?islem=topluseolinkekle">
  <table class="table table-striped">
	    <thead> 
      <th >Excel Toplu Giriş</th>
    </thead>
    <tr> 
      <td>
          <div class="input-group">
                <input class="form-control" id="fieldID1" aria-multiselectable="true" name="d1" type="text" value="<%=strcsd1 %>">
              <div class="input-group-btn">
                    <a data-toggle="modal" href="#" data-href="<%=siteadres %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=0&fldr=/temp" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>
                </div></div><small>Sadece .csv dosyaları kabul edilir.</small></td>
    </tr>      
    <tr> 
      <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"></td>
    </tr>
</table>
  </form>
                </div>
            <div class="col-md-6">
  <form name="form1" method="post"  action="?islem=eskseolinkekle">
      <table class="table table-striped">
	    <thead> 
      <th >Manuel Giriş</th>
    </thead>
    <tr> 
      <td><input name="eskilink" type="text" id="eskilink" class="form-control" placeholder="Eski Link (Kök domain olmadan, /index.html gibi)"></td>
    </tr>
    <tr> 
      <td>
        <select name="yenilink1" class="selctize1" id="yenilink1" style="width:100%;" placeholder="Yeni Link (Tam Url)">        
          <option value="?"> TÜM SAYFALAR </option>
          <%
          sqlString = "select seolink from seolar order by id desc"
         set mmmGenel = Con.Execute (sqlString)
         if mmmGenel.eof then
         else   
        Do While Not mmmGenel.EOF
        stryenilink=mmmGenel("seolink")
        %>
       <option value="<%=siteadres%><%=stryenilink%>"><%=stryenilink%></option>
       <%mmmGenel.MoveNext
       loop
       end if
       close(mmmGenel)

       staralink=request.form("staralink")
  if request("usayi")="" then
  if staralink="" then
KayitSayisi=100
  else
KayitSayisi=100
  end if
else
KayitSayisi=request("usayi")
end if
git = Request.QueryString("git")
if git="" then
git=1
end if

if staralink="" then
staralinkqry=""
  else
  staralinkqry=" where instr(eskilink,'"&staralink&"') "
  end if

        link="sira="&sira&""
  sayfalink=link
       %>
        </select>
        <input name="yenilink" type="text" id="yenilink" class="form-control" placeholder="Yeni Link (Tam Url)">
      </td>
    </tr>
    <tr> 
      <td><input name="submit2" type="submit" value="Ekle" class="btn btn-success pull-right"></td>
    </tr>
</table>
  </form>
            </div>
</div>
<div class="x_panel">
               <div class="x_title"><h2>Eski Linkler</h2>
               <div class="clearfix"></div></div> 
               <form method="post"  Name="custlistara" id="Form2" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
               <table class="table table-striped">
               <TR> 
                <td><input name="staralink" type="text" id="staralink" value="<%=staralink%>" class="form-control"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><input name="Submit" type="submit" id="Submit5" value="Ara" class="btn btn-info pull-right"></td>
              </tr>
              </table>
               </form>
      <form method="post"  Name="custlist" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
  <table class="table table-striped">
  <%
  

 sqlString = "select * from seolink"&staralinkqry&" order by yenilink, tom desc, id desc, tur desc,tiklama desc,pozisyon,gosterim limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
 'response.write sqlString
set mmmGenel = Con.Execute (sqlString)

if mmmGenel.eof then
else
set mmmYardimci2=Con.execute("select count(id) as toplam5 from seolink"&staralinkqry&"")
          
toplam5=mmmYardimci2("toplam5")
%>
  <thead>
    <th height="40">Eski Link</th>
    <th>Yeni Link</th>
    <th>Tıklama</th>
    <th>Gösterim</th>
    <th>TO</th>
    <th>Pozisyon</th>
    <th width="3%" align="center"><input type="checkbox" name="resimid1" class="flatred" id="checkAll"></th>
  </thead>


    <%
Do While Not mmmGenel.EOF
iks=iks+1
        stryenilink=mmmGenel("yenilink")
        streskilink=mmmGenel("eskilink")
        if stryenilink="" or len(stryenilink)=" " or isNull(stryenilink) then
       
        'if instr(streskilink,"blog/") then
        'stryenilink= streskilink
        'if instr(stryenilink,"_") then
       ' stryenilink=split(stryenilink,"_")(0)
        'end if
        'stryenilinkle="https://dtt.cloudgrafike.com/"&replace(stryenilink,"/","")&".html"
        'stryenilink="https://www.site.com/"&replace(stryenilink,"/","")&".html"
        'end if

        linkis="<a href="""&stryenilinkle &""" target=""_blank"">Git</a>"
        else
        linkis=""
        'response.Write len(stryenilink)&"asd"
        end if
        steskilink=mmmGenel("eskilink")
        if left(steskilink,1)="/"then
        steskilink=right(steskilink,len(steskilink)-1)
        else
        steskilink=steskilink
        end if
%>
    <input name="urunid" type="hidden" value="<%=mmmGenel("id")%>" />

    <TR> 
      <td><input name="eskilink" type="text" id="eskilink" value="<%=steskilink%>" class="form-control"/></td>
      <td><input name="yenilink" type="text" id="yenilink" value="<%=stryenilink%>" class="form-control"/><%=linkis %></td>
      <td><%=mmmGenel("tiklama")%></td>
      <td><%=mmmGenel("gosterim")%></td>
      <td><%=mmmGenel("tom")%></td>
      <td><%=mmmGenel("pozisyon")%></td>
      <td><input name="urunidsil" type="checkbox" id="sira2" class="flatred" value="<%=mmmGenel("id")%>" /></td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
    <tr>
      <td><%call sayfalaurun()%></td>
      <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=eskseolinkDuzenle');"></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=eskseolinkSil');"></td>
    </tr>
  <% 
end if
close(mmmGenel)
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
</div>
</div>

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
<%call footer(1)%>

<script>
$('.selctize1').selectize({

  delimiter: '*',
  
  persist: false
  
  });
  
  
  $(document).ready(function () {
    $("#yenilink1").change(function(){
      strmssayfa=$( '#yenilink1' ).find(":selected").val();
            $( '#yenilink' ).val(strmssayfa);
    });
  });
  </script>