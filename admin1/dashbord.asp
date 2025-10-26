<!--#Include file="admin_menu1.asp"-->
		<!-- page content -->
        <div class="right_col" role="main">
            <div class="col-md-4">
<%if instr(strymenuliste,"formlar.asp") then%>
                <table class="table table-striped">
    <%

 sqlString = "select * from formlar where dil = '240' and onay='1' order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else%>
  <thead>
    <th height="50" colspan="3">Form Kayıtları</th>
  </thead>
  
    <%
Do While Not mmmGenel.EOF
iks=iks+1
strfid=mmmGenel("id")
strfssl=mmmGenel("ssls")
strficerikid=mmmGenel("icerikid")
strfciftmail=mmmGenel("ciftmail")
strfveritabanikayit=mmmGenel("veritabanikayit")
strfonay=mmmGenel("onay")
strftemp=mmmGenel("temp")
  lojik5=con.execute("select count(oku) as toplam4 from ozellikler2 where formid='"&strfid&"' and ozelikid = '1' ")
toplam4=lojik5("toplam4")
  lojik5=con.execute("select count(oku) as toplam4 from ozellikler2 where formid='"&strfid&"' and ozelikid = '1' and oku = '0' ")
toplam5=lojik5("toplam4")
%>
    <input name="urunid" type="hidden" value="<%=strfid%>" />
     <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>

    <TR> 
      <td><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("formadi")%>" class="form-control"/></td>     
        <td align="center"><a href="formicerik.asp?form=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Form Girişleri"><em class="fa fa-clipboard" style="font-size:18px;"></em> (<%=toplam5%>/<%=toplam4%>)</a></td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
  
  <%
end if
close(mmmGenel)
%>
<SCRIPT LANGUAGE="JavaScript">

    function formla(gelen) {
        document.custlist.action = gelen;
        document.custlist.submit();
    }
  //-->
  </SCRIPT>
</table>
<%end if%>
            </div>
        </div>
        <!-- /page content -->
<%call footer(1)%>