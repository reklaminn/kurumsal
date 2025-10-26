<!--#Include file="admin_menu1.asp"--> 
<%
    yetkiid=giriskont(request.querystring("yetkiid"))
    yetkiadi=giriskont(request.querystring("yetkiadi"))
    if yetkiid="" or isNumeric(yetkiid)=False then
    yetkiid="99999"
    end if
    qryyetki=" where id='"&yetkiid&"'"
    %>
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2><%=yetkiadi%> Adlı Kullanıcı Rolü</h2>
<div class="clearfix"></div></div>
        

    <form method="post" name="custlist" id="Form1" action="?">
        <table class="table table-striped table-hover">
    
        <tr>
            <td>Yetkilendirilecek Sayfa</td>
             <%
    sqlString = "select * from yetkiler"&qryyetki&" order by id desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
    set mmmGenel = Con.Execute (sqlString)

    Do While Not mmmGenel.EOF
     iytk=iytk+1
                 yetkiid=mmmGenel("id")
     if yetkiid=1 and yetkiuye<>1 then
     else
                 if eserrrr="1" then
                 yetkijson=mmmGenel("yetkijson")
                 if instr(yetkijson,"{") then
                 Set oJSON = New aspJSON
oJSON.loadJSON(yetkijson)
                 
    if isObject(oJSON.data(""&yetkiid&"")) then
                 Set yetkili = oJSON.data(""&yetkiid&"")
                 end if
    else
     if yetkiid=1 or yetkiid=2 then
    editchck="1"
    delchck="1"
                 else
    editchck="0"
    delchck="0"
                 end if
                 end if
                 end if
                
 yetkicheck=yetkicheck&"<input name=""yetkiidchck"" type=""hidden"" value="""&yetkiid&""">"
       
                 %>
 
          <td>Düzenle<input name="yetkiadi" type="hidden" class="form-control" id="yetkiadi2" value="<%=mmmGenel("yetkiadi")%>" /><input name="yetkiid" type="hidden" value="<%=mmmGenel("id")%>"></td>
          <td>Sil Yetkisi</td>
        
        <%
            end if
	    mmmGenel.MoveNext
      loop
      close(mmmGenel)
    %>
        </tr>
        <%
             vbstr="mmmYardimci"&vb
    sqlString = "SELECT * from yonetici_menu where durum='1'"&tempf&" order by urunid, anasek, id"
    'response.write sqlString
    set vbstr = Con1.Execute (sqlString)
                              if vbstr.eof then
                      kyl=""
                              else
                      Do While Not vbstr.EOF
              strid=vbstr("id")
              menuisimana=vbstr("isim")
              menuisimalt=vbstr("alt")
            %>
        <tr>
            <td><%if menuisimalt="1" then%>
              <b><%=menuisimana %></b>
              <%else%>
              <%=menuisimana %>
              <%end if%>
              <input name="menuid" type="hidden" value="<%=strid%>"></td>
        <%
    sqlString = "select * from yetkiler"&qryyetki&" order by id desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
    set mmmGenel = Con.Execute (sqlString)

    Do While Not mmmGenel.EOF
     iytk=iytk+1
                 yetkiid=mmmGenel("id")
     if yetkiid=1 and yetkiuye<>1 then
     else
                 yetkijson=mmmGenel("yetkijson")
    if instr(yetkijson,"{") then
                 Set oJSON = New aspJSON
oJSON.loadJSON(yetkijson)
                 
    if isObject(oJSON.data(""&yetkiid&"")) then
                 Set yetkili = oJSON.data(""&yetkiid&"")
    if isObject(yetkili.item(""&strid&"")) then
                 set sayfasi = yetkili.item(""&strid&"")
                 editchck= sayfasi(0)("edit")
                 delchck= sayfasi(0)("delete")
                 end if
                 end if
    else
     if yetkiid=1 or yetkiid=2 then
    editchck="1"
    delchck="1"
                 else
    editchck="0"
    delchck="0"
                 end if
                 end if
                 %>
 <input name="yetkiidchck" type="hidden" value="<%=mmmGenel("id")%>">
        <%if kullanicilar=1 then%>
          <td>
          <%if editchck = "1" Then
                              cbcdisstr="disabled"
						      cbccheckstr="checked"
						      else
						      cbcdisstr=""
						      cbccheckstr=""
						      end if
						      response.Write(checkboxcreat("edit"&mmmGenel("id")&"","Değiştir Yetkisi",iytk,cbcdisstr,cbccheckstr,"info"))%></td>
                              <td>
                              <%if delchck = "1" Then
                              cbcdisstr="disabled"
						      cbccheckstr="checked"
						      else
						      cbcdisstr=""
						      cbccheckstr=""
						      end if
						      response.Write(checkboxcreat("delete"&mmmGenel("id")&"","Sil Yetkisi",iytk,cbcdisstr,cbccheckstr,"danger"))%>
             </td>
                               <%else%>
                               <input name="kullanicilar" type="hidden" value="0" id="kullanicilar<%=i%>" <%if mmmGenel("kullanicilar") = "1" Then%>disabled<%else%><%end if%>>
                               <input name="kullanicilars" type="hidden" value="0" <%if mmmGenel("kullanicilars") = "1" Then%>disabled<%else%><%end if%>>
    <%  end if%>
        
        <%
            end if
	    mmmGenel.MoveNext
      loop
      close(mmmGenel)
    %>
        </tr>
    
        <%
                      kyl=kyl&""&kyl1
                      vbstr.MoveNext
    loop
                      end if
                      close(vbstr)
            %>
        </table>
   
        <table class="table table-striped">
            <tr>            
          <td>
              <input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit(); formla('?Submit=yetkiSil');">
              <input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit(); formla('?Submit=ortakyetkiDuzenle');"/>
          </td>
            </tr>
        </table>
    </form>
    
<SCRIPT LANGUAGE="JavaScript">

    function formla(gelen) {
        document.custlist.action = gelen;
        document.custlist.submit();
    }
  //-->
  </SCRIPT>
</div>
</div>

<%call footer(1)%>