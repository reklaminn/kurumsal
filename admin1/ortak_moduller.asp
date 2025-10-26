<!--#Include file="admin_menu1.asp"--> 
<%
	if request("dkate2")="" or request("dkate2")=0 then
	dkate2=0
	else
	dkate2=request("dkate2")
	end if
%>
<div class="right_col" role="main">
<div class="x_panel">
     
                  <div class="x_title"><h2>Mod&uuml;l Ekle</h2>
                <div class="clearfix"></div></div>
                    <form action="?islem=modulekle" method="post" name="myForm1" id="myForm2" onsubmit="return validate(this);"><table class="table table-striped">
                      
                        <input name="djid" type="hidden" value="<%=Sayilar%>" />
                        <tr class="icerik1 icerik">
                          <td width="30%">Mod&uuml;l Adı :</td>
                          <td><input name="ad" type="text" id="ad" class="form-control" /></td>
                        </tr>
                        <tr class="icerik2 icerik">
                          <td>Temp Durumu :</td>
                          <td><select name="yetki1" class="form-control" id="moduller2">
                             <%
sqlString = "select * from moduller where"&modulgosterme&" and temp='99999'  order by temp desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
set mmmGenel = Con1.Execute (sqlString)
                              Do While Not mmmGenel.EOF
                              %>
                        <option value="<%=mmmGenel("id")%>">
                          <%=mmmGenel("moduladi")%>
                          </option>
       <%
		mmmGenel.MoveNext
  loop
           close(mmmGenel)
  %>
                      
                        </select></td>
                        </tr>
                        <tr class="icerik1 icerik">
                          <td>Durum :</td>
                          <td><label><input name="yetki" type="radio" class="flatred" id="cins_0" value="1" checked="checked" />
                                Aktif</label>&nbsp;&nbsp;<label><input type="radio" class="flatred" id="cins_1" name="yetki" value="0" />
                                Pasif</label></td>
                        </tr>
                        <tr>
                          <td valign="top">&nbsp;</td>
                          <td valign="top"><input type="submit" name="Submit5" value="Kaydet" class="btn btn-success pull-right"/></td>
                        </tr>
                      
                    </table>
                </form>
                <div class="x_title"><h2>Mod&uuml;ller</h2>
                <div class="clearfix"></div></div>
                <form method="post" name="custlist" id="Form" action="?dkate2=<% =dkate2%>&yer=<% =yer%>">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th width="6%" height="50"> İd</th>
                      <th> Mod&uuml;l Adı</th>
                      <th width="15%" align="center" class="baslik">Temp</th>
                      <th width="15%">Türü</th>
                      <th width="5%">&nbsp;</th>
                      <th width="5%">&nbsp;</th>
                      <th width="5%">Tarih</th>
                      <th width="5%" align="center">Durum</th>
                      <th width="2%" align="center"> Sil</th>
                    </tr>
                  </thead>
                  <%
sqlString = "select * from moduller where"&modulgosterme&" and temp<>'99999'  order by temp desc "'limit " & (KayitSayisi*git)-(KayitSayisi) & "," & KayitSayisi&""
set mmmGenel = Con1.Execute (sqlString)
if mmmGenel.eof then%>
                  <tr>
                    <td colspan="2">Kay&#305;t Yok</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <%else%>
                  
                    <TR class="icerik1 icerik">
                      <td colspan="8" align="right"><input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?dkate2=<% =dkate2%>&yer=<% =yer%>&Submit=DuzenleModul');"/></td>
                      <td align="center"><input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?dkate2=<% =dkate2%>&yer=<% =yer%>&Submit=SilModul');"/></td>
                    </tr>             <%
Do While Not mmmGenel.EOF
imo=imo+1
strmodulid=mmmGenel("id")
%>
                    <input name="urunid" type="hidden" value="<%=strmodulid%>" />
                    <%if right(imo,1)=1 or right(imo,1)=3 or right(imo,1)=5 or right(imo,1)=7 or right(imo,1)=9 then%>
                    <%collor="1"%>
                    <%else%>
                    <%collor="2"%>
  <%end if%>
                    
                    <TR class="icerik<%=collor%> icerik"> 
                      <td align="center"><%=strmodulid%></td>
                      <td><input name="moduladi" type="text" id="moduladi" value="<%=mmmGenel("moduladi")%>" class="form-control" /></td> <td align="center"><select name="temp" class="form-control" id="moduller2">
                   <%
		sqlString = "select * from moduller where"&modulgosterme&" and temp='99999'  order by temp desc "
set mmmYardimci = Con1.Execute (sqlString)
if mmmYardimci.eof then
else
Do While Not mmmYardimci.EOF
i=i+1
                       modulid=mmmYardimci("id")
%>
                        <option value="<% =modulid %>" <%if modulid=cint(mmmGenel("temp")) then%>selected<%else%><%end if%>>
                          <% = mmmYardimci("moduladi")%>
                          </option>
                        <%										  
							mmmYardimci.MoveNext
  loop
end if

Close(mmmYardimci)
%>
                        </select></td>
                      <td></td>
                      <td align="center">
                        
                        </td>
                      <td></td>
                      <td><div align="center"><%=mmmGenel("tarih")%></div></td>   
                      
                      <td align="center">
                        <%if mmmGenel("durum") = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Durum",imo,cbcdisstr,cbccheckstr,"info"))%>
                        </td>
                      
                      <td align="center">
                        <%if instr(silinmiyecekler,"m"&sid) then
	  else%>
                        <div class="form-group">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="iceriksil" class="flatred" id="iceriksil<%=imo%>" value="<%=strmodulid%>">
                            </label>
                          </div>
                        </div>
                      <%end if%></td>
                    </tr>
                    <%
		mmmGenel.MoveNext
  loop
  %>
                    <tr>
                      <td colspan="3"></td>
                      <td colspan="5" align="right"><input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?dkate2=<% =dkate2%>&yer=<% =yer%>&Submit=DuzenleModul');"/></td>
                      <td align="right"><input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?dkate2=<% =dkate2%>&yer=<% =yer%>&Submit=SilModul');"/></td>
                    </tr>
                  
                  <%end if
				  close(mmmGenel)%>
                </table></form>
  <SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
</div>
</div>

<%call footer(1)%>