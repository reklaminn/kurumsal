<!--#Include file="../functions/aspJSON1.17.asp"-->
<!--#Include file="dbb.asp"-->

<%
	if request("sek")="" or request("sek")="0" then
	sek=0
	else
	sek=request("sek")
	end if
          if request.QueryString("modulmu")="1" then 
    titlebaslik="Modül"
    titlebasliktxt=" Modülüne Alt Modül Ekliyorsunuz."
    else
    titlebaslik="Sayfa"
    titlebasliktxt=" Sayfasına Alt Sayfa Ekliyorsunuz."
    end if
	%>
    <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Kapat"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"><%=titlebaslik %> Ekle</h4>
                        </div>
    <div class="x_panel">
              
      <form name="form1" method="post" id="asd"  action="sayfalar.asp?islem=sayfaekle&sek=<%=sek%>" target="_parent">
      <table class="table table-striped">       
         <tr>
            <td width="34%"><%=titlebaslik %> Durumu</td>
            <td width="66%">
               <%if request("id")="" then%>
                  <select name="durum" id="durum" class="form-control">
                    <option value="1"> Ana <%=titlebaslik %> </option>
<%
sqlString = "select * from kategoriyazi where alt = '1' ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
<OPTION value="<%=mmmGenel("id")%>" <%if mmmGenel("id")=int(request("durum")) then%>selected<%else%><%end if%>><%=mmmGenel("isim")%></OPTION>
                          <%
sqlString = "select * from kategoriyazi where anasek='"&mmmGenel("id")&"' ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
<OPTION value="<%=mmmYardimci("id")%>" <%if mmmYardimci("id")=int(request("durum")) then%>selected<%else%><%end if%>>&nbsp;&nbsp;&nbsp;><%=mmmYardimci("isim")%></OPTION>   <%
mmmYardimci.movenext
loop
close(mmmYardimci)
mmmGenel.movenext
loop
close(mmmGenel)
%>
</select>
              <%else%>
              <%
sqlString = "select * from kategoriyazi where id="&request("id")&" ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
response.Write(mmmGenel("isim"))
end if
close(mmmGenel)
%> 
               <%=titlebasliktxt %>
               <input name="durum" type="hidden" value="<%=request("id")%>" />
               <input name="slayt2" type="hidden" id="slayt" value="0" />
<%end if
%></td>
          </tr>

          <tr>
            <td><%=titlebaslik %> Adı</td>
            <td><input name="sektor" type="text" id="sektor" class="form-control">
              </td>
          </tr>
          <script language="javascript">
function toggleDiv(id, show)
{
   document.getElementById(id).style.display = show ? 'block' : 'none';
   document.getElementById(id).style.display = show ? 'block1' : 'none';
}
function disable_sifreli<%=i%>(checked)
{
	
document.getElementById("sifreli<%=i%>").disabled = checked;
}
</script>
          <tr>
            <td>&nbsp;</td>
            <td>
          <%if request.QueryString("modulmu")="1" then
              else%>
                <input name="harici" type="checkbox" id="harici" value="1" onclick="javascript:toggleDiv('block', this.checked);toggleDiv('block1', this.checked);" />
              Harici Linke Git
                <%end if %>
            </td>
          </tr>
          <tr>
            <td><div id="block1" style="display: none;">Harici Link :</div></td>
            <td><div id="block" style="display: none;">
              <input type="text" size="25" name="link" class="form-control"/>
            <SELECT id="target" size="1" name="target" class="form-control">
                          	<OPTION value="0">Sayfa Açılma</OPTION>
                              <OPTION value="_blank">Boş Sayfada Aç</OPTION>
                              <OPTION value="_parent">Kendi İçinde Aç</OPTION>
                            </SELECT></div></td>
          </tr>
          <%if request.QueryString("modulmu")="1" then %>
              <input type="hidden" name="kopyaid" value="1"/>
          <%else %>
          <tr>
            <td>Blokları Kopyalanacak Sayfa</td>
            <td><select name="kopyaid" id="kopyaid" class="form-control">
              <option value="1"> Sayfaya Özel Blok Düzeni Kullan </option>
              <%
                  if request("sek")="1" then
                  varsayfablok=request("baslik")
                  else
                  varsayfablok=request("sek")
                  end if
sqlString = "select * from kategoriyazi where alt = '1' and modulmu='0'"&sayfagosterme&" ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
                  strgenelid=mmmGenel("id")
%>
              <option value="<%=strgenelid%>" <%if strgenelid&""=""&varsayfablok then%>selected<%else%><%end if%>><%=mmmGenel("isim")%> Sayfanın Blok Düzenini Kullan</option>
              <%
                  sqlString = "select * from kategoriyazi where anasek = '"&strgenelid&"' and modulmu='0'"&sayfagosterme&" ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
                  stryarid=mmmYardimci("id")
%>
              <option value="<%=stryarid%>" style="margin-left:10px;" <%if stryarid&""=""&varsayfablok then%>selected<%else%><%end if%>><%=mmmYardimci("isim")%> Sayfanın Blok Düzenini Kullan</option>
              <%
mmmYardimci.movenext
loop
close(mmmYardimci)

mmmGenel.movenext
loop
close(mmmGenel)
%>
            </select></td>
          </tr>
          <%end if %>
          <tr>
            <td colspan="2">
             <input type="submit"  value="Ekle" name="Button_Submit" class="btn btn-info pull-right"/>
           </td>
          </tr>    
    </table>
    </form>
    </div>