<!--#Include file="admin_menu1.asp"--> 
<div class="right_col" role="main">
  <div class="x_panel">
  <div class="x_title"><h2>KULLANICI DÜZENLE</h2>
  <div class="clearfix"></div></div>
  <table class="table table-striped">
  <form method="post" name=Form1 id=Form1 action="?islem=yetkiekle" target="_self">                  
      <TR>
                            <td><input name="yetkiadi" type="text" class="form-control" id="yetkiadi2"  /></td>
     
                            <td width="3%"><button name="Submit" type="submit" id="Submit6" value="Ekle" class="btn btn-success pull-right">Ekle</button></td>
                          </tr></form> 
    <thead> 
      <th width="50%">Yetki Ad&#305;</th>
   
      </thead>
    <%
  sqlString = "select * from yetkiler  order by id desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
  set mmmGenel = Con.Execute (sqlString)
  if mmmGenel.eof then%>
  
    <%else
   %>  <form method="post" name="custlist" id="Form1" action="?">
      <%
  Do While Not mmmGenel.EOF
   iytk=iytk+1
   yetkiid=mmmGenel("id")
   yetkiadii=mmmGenel("yetkiadi")
   if yetkiid=1 and yetkiuye<>1 then
   else%><input name="urunid" type="hidden" value="<%=yetkiid%>">
  
      <TR class="icerik<%=collor%> icerik"> 
        <td><input name="yetkiadi" class="form-control" type="text" id="yetkiadi" value="<%=yetkiadii%>"></td>
    
              <td align="center">
                <a class="btn btn-primary" href="yetkiler.asp?yetkiid=<%=yetkiid%>&yetkiadi=<%=yetkiadii%>">Yetkiler
            </a>
                <%if yetkiid=1 or yetkiid=2 or yetkiid=3 then
        else%><div class="checkbox-inline checkbox-primary" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil">
              <div id="cdyetkisil<%=iytk%>" class="checker">
              <span>
          <input name="urunidsil" type="checkbox" id="urunidsil<%=iytk%>" class="styled" value="<%=yetkiid%>" onClick="disable_s(this.checked,'yetkisil<%=iytk%>');"/>
          </span>
        </div>
        </div>
             <%end if%></td>
      </tr>
  
      <%end if
    mmmGenel.MoveNext
    loop
    
  %>
      <tr> 
  
           
        <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?Submit=yetkiDuzenle');"/></td>
        <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?Submit=yetkiSil');"></td>
      </tr>
    </form><% end if
    Close(mmmGenel)
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
  </div>
  </div>
  
  <%call footer(1)%>
  
  