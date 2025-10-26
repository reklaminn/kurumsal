<!--#Include file="admin_menu1.asp"-->
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>Smtp Ayarları</h2>
<div class="clearfix"></div></div>
<%ifo="0"
    if request("formdetay")="" then%>
 <form method="post" name="Form1" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=formsmtpekle&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self"><table class="table table-striped">


 <TR > 
    <td><input name="formadi" type="text" id="sayfaadi6" class="form-control"/></td>
    
      <td width="5%" align="center">
      <%if od = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay1","Onay Durumu",ifo,cbcdisstr,cbccheckstr,"success"))%>
                         </td>
    <td width="5%" align="center"><input name="submit" type="submit" value="Ekle" class="btn btn-success pull-right"/></td>
    <td width="5%">&nbsp;</td>
  </tr>
  </table>
  </form>
  <form method="post" Name="custlist" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
  <table class="table table-striped">
    <%
 sqlString = "select * from formsmtp  order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else%>
  <thead>
    <th height="50">Form Adı</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
  </thead>
  
    <%
Do While Not mmmGenel.EOF
iks=iks+1
strfid=mmmGenel("id")
strfssl=mmmGenel("ssls")
strfsmtpauth=mmmGenel("smtpauth")
strfonay=mmmGenel("onay")
%>
    <input name="urunid" type="hidden" value="<%=strfid%>" />
     <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>

    <TR> 
      <td><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("formadi")%>" class="form-control"/></td>
      
      <td align="center">
        <%if strfonay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Onay Durumu",iks,cbcdisstr,cbccheckstr,"success"))%>
       </td>
        <td align="center"><a href="?formdetay=1&amp;fid=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Ayar Düzenle"><em class="fas fa-edit" style="font-size:18px;"></em></a></td>
      <td align="center">
      <div class="form-group" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil İçin Seçiniz" style="display:table;">
              <div class="checkbox">
                <input type="checkbox" name="urunidsil" class="flatred" id="urunidsil<%=iks%>" value="<%=strfid%>">
              </div>
            </div>
      </td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
    <tr>
      <td></td>
      <td>&nbsp;</td>
      <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formtsmtpDuzenle');"/></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formsmtpSil');"/></td>
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
<%else%>
<form method="post" Name="custlist" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
<table class="table table-striped">

  <tr>
    <td height="50"><div class="anabaslik">Smtp Ayarları</div></td>
    <td>&nbsp;</td>
  </tr>
    <%
 sqlString = "select * from formsmtp where id="&request("fid")&"  order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
strfid=mmmGenel("id")
strfssl=mmmGenel("ssls")
strfsmtpauth=mmmGenel("smtpauth")
strfonay=mmmGenel("onay")
%>
<input name="urunid" type="hidden" value="<%=strfid%>" />
     <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>
  <tr>
    <td width="30%">Ayar Adı</td>
    <td><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("formadi")%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Login</td>
    <td><input name="login" type="text" id="sayfaadi13" value="<%=mmmGenel("login")%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="sifred" type="checkbox" id="sifred" value="1" />
Şifre Değiştirmek 
        İstiyorsnız Yandaki Düğmeye Tıklayın ve Yeni Şifrenizi Yazın.</td>
  </tr>
  <tr>
    <td>Şifre</td>
    <td><input name="password" type="password" id="sayfaadi14" value="" class="form-control"/></td>
  </tr>
  <tr>
    <td>Auth</td>
    <td><%if strfsmtpauth = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("auth","Şifreli Giriş",ifo,cbcdisstr,cbccheckstr,"successs"))%>
      </td>
  </tr>
  <tr>
    <td>SSL</td>
    <td><%if strfssl = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("ssl","Ssl Şifre",ifo,cbcdisstr,cbccheckstr,"successs"))%>
      </td>
  </tr>
  <tr>
    <td>Smtp Port</td>
    <td><input name="smtpport" type="text" id="sayfaadi2" value="<%=mmmGenel("smtpport")%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Smtp Server</td>
    <td><input name="smtpserver" type="text" id="sayfaadi3" value="<%=mmmGenel("smtpserver")%>" class="form-control"/></td>
  </tr>

  <tr>
    <td>Onay</td>
    <td>
    <%if strfonay = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("onay","Onay Durumu",ifo,cbcdisstr,cbccheckstr,"success"))%>
                         </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formsmtpDuzenle');"/></td>
  </tr>
  
  <%end if%>
</table>
</form>
<SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
<%end if%>
</div>
</div>
<%call footer(1)%>