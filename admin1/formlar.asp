<!--#Include file="admin_menu1.asp"-->
<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>Formlar</h2>
<div class="clearfix"></div></div>
<%ifo="0"
    if request("formdetay")="" then%>
 <form method="post" name="Form1" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=formekle&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self"><table class="table table-striped">


 <TR > 
    <td><input name="formadi" type="text" id="sayfaadi6" class="form-control"/></td>
    <td width="5%" align="center">
    <%if ekd = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("engel1","Eklemeye Kapalı Durumu",ifo,cbcdisstr,cbccheckstr,"danger"))%>
                          </td>
      <td width="5%" align="center">
      <%if gld = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("liste1","Girişleri Listeleme Durumu",ifo,cbcdisstr,cbccheckstr,"primary"))%>
                          </td>
      <td width="5%" align="center">
      <%if vkd = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("veritabani1","Veritabanına Kayıt Etme Durumu",ifo,cbcdisstr,cbccheckstr,"danger"))%>
                          </td>
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
        <td width="5%" align="center">
        <%if td = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("temp1","Temp Form Durumu",ifo,cbcdisstr,cbccheckstr,"successs"))%>
                         </td>
    <td width="5%" align="center">&nbsp;</td>
    <td width="5%" align="center">&nbsp;</td>
    <td width="5%" align="center">&nbsp;</td>
    <td width="5%" align="center"><input name="submit" type="submit" value="Ekle" class="btn btn-success pull-right"/></td>
    <td width="5%">&nbsp;</td>
  </tr>
  </table>
  </form>
  <form method="post" Name="custlist" id="Form1" action="?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>" target="_self">
  <table class="table table-striped">
    <%
 sqlString = "select * from formlar where dil = '240'  order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else%>
  <thead>
    <th height="50">Form Adı</th>
    <th>Alıcı Email</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th  align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
    <th align="center" width="5%">&nbsp;</th>
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
      <td><input name="froms" type="text" id="froms" value="<%=mmmGenel("froms")%>" class="form-control"/></td>
      <td align="center">
          <%if strficerikid = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("engel","Eklemeye Kapalı Durumu",iks,cbcdisstr,cbccheckstr,"danger"))%>
          </td>
      <td align="center">
        <%if strfciftmail = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("liste","Girişleri Listeleme Durumu",iks,cbcdisstr,cbccheckstr,"primary"))%>
        </td>
      <td align="center">
        <%if strfveritabanikayit = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("veritabani","Veritabanına Kayıt Etme Durumu",iks,cbcdisstr,cbccheckstr,"danger"))%>
       </td>
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
        <td align="center">
        <%if strftemp = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("temp","Temp Form Durumu",iks,cbcdisstr,cbccheckstr,"successs"))%>
       </td>
        <td align="center"><a href="formicerik.asp?form=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Form Girişleri"><em class="fa fa-clipboard" style="font-size:18px;"></em> <%=toplam5%></a></td>
        <td align="center"><a href="?islem=formkopya&kopyaid=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Form Kopyola"><em class="fas fa-copy" style="font-size:18px;"></em></a></td>
        <td align="center"><a href="?formdetay=1&amp;fid=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Form Düzenle"><em class="fas fa-edit" style="font-size:18px;"></em></a></td>
      <td align="center"><a href="formnesneleri.asp?form=<%=strfid%>" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Form Nesneleri"><em class="fa fa-list-alt" style="font-size:18px;"></em></a></td>
      <td align="center">
          <%if instr(silinmiyecekler,"f"&strfid) then
	  else%> 
      <div class="form-group" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil İçin Seçiniz" style="display:table;">
              <div class="checkbox">
                <input type="checkbox" name="urunidsil" class="flatred" id="urunidsil<%=iks%>" value="<%=strfid%>">
              </div>
            </div>
            <%end if%>
      </td>
    </tr>
    <%mmmGenel.MoveNext
  loop
  %>
    <tr>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formtDuzenle');"/></td>
      <td><input name="Submit" type="submit" id="Submit6" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formSil');"/></td>
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
    <td height="50"><div class="anabaslik">Formlar</div></td>
    <td>&nbsp;</td>
  </tr>
    <%
 sqlString = "select * from formlar where id="&request("fid")&"  order by id desc"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then
else
strfid=mmmGenel("id")
strfssl=mmmGenel("ssls")
strficerikid=mmmGenel("icerikid")
strfciftmail=mmmGenel("ciftmail")
strfveritabanikayit=mmmGenel("veritabanikayit")
strfonay=mmmGenel("onay")
strftemp=mmmGenel("temp")
strfmailtemp=mmmGenel("mailtemp")
strfpassword=mmmGenel("password")
strfsmtpid=mmmGenel("smtpid")
strfsmtpport=mmmGenel("smtpport")
strflogin=mmmGenel("login")
strfbasari=mmmGenel("basarisayfa")
strfhata=mmmGenel("hatasayfa")
        strfkoruma=mmmGenel("korumazaman")
      strfblacklist=mmmGenel("ipblacklist")
strfbagli=mmmGenel("aktifkategori")
strfkolonlar=mmmGenel("kolonlar")
if instr(strfkolonlar,"-") then
if instr(strfkolonlar,",") then
strfkolonlar1=split(split(strfkolonlar,"-")(0),",")(0)
strfkolonlar2=split(split(strfkolonlar,"-")(0),",")(1)
strfkolonlar3=split(split(strfkolonlar,"-")(1),",")(0)
strfkolonlar4=split(split(strfkolonlar,"-")(1),",")(1)
else
strfkolonlar1="0"
strfkolonlar2="0"
strfkolonlar3="0"
strfkolonlar4="0"
end if
else
if instr(strfkolonlar,",") then
strfkolonlar1=split(strfkolonlar,",")(0)
strfkolonlar2=split(strfkolonlar,",")(1)
strfkolonlar3="0"
strfkolonlar4="0"
else
strfkolonlar1="0"
strfkolonlar2="0"
strfkolonlar3="0"
strfkolonlar4="0"
end if
end if
  lojik5=con.execute("select count(oku) as toplam4 from ozellikler2 where formid='"&strfid&"' and ozelikid = '1' and oku = '0' ")
toplam5=lojik5("toplam4")
%>
<input name="urunid" type="hidden" value="<%=strfid%>" />
     <%if request("sek")="" then%>
  <input name="sek" type="hidden" value="11111111" />
  <%else%>
  <input name="sek" type="hidden" value="<%=request("sek")%>" />
  <%end if%>
  <tr>
    <td width="30%">Form Adı</td>
    <td><input name="ad" type="text" id="sayfaadi" value="<%=mmmGenel("formadi")%>" class="form-control"/></td>
  </tr>

  <tr>
    <td>Formu Alıcı Email</td>
    <td><input name="from" type="text" id="sayfaadi4" value="<%=mmmGenel("froms")%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Admin Giden Email Başlık</td>
    <td><input name="ssl" type="text" id="sayfaadi4" value="<%=mmmGenel("ssls")%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Geri Dönen Mesaj</td>
    <td><textarea name="gmesaj" cols="50" rows="3" id="sayfaadi5" class="form-control"><%=mmmGenel("gmesaj")%></textarea></td>
  </tr>
  <tr>
    <td>Email Temp</td>
    <td><textarea name="mailtemp" cols="50" rows="3" id="gmesaj" class="normal form-control"><%=strfmailtemp%></textarea></td>
  </tr>
  <tr>
    <td>Aktif Site Kategorisi</td>
    <td>
    <select name="aktifkategori" class="form-control" id="aktifkategori">        
      <option value="0"> Serbest Formı </option>
   <% response.Write kategoriyaziliste("1","<option value=""#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&", &nbsp;&nbsp;-&nbsp;,240)}#","",strfbagli,sayfagosterme,"","240") %>     
    </select></td>
  </tr>
  <tr>
    <td>Kolon Eşleşmesi</td>
    <td><select name="kolon1"  class="form-control" id="kolon1" style="width:auto; float:left;">
          <option value="1"> Ana Nesne </option>
          <option value="baslik" <%if strfkolonlar1="baslik" then%>selected<%else%><%end if%>>Başlık</option>
          <option value="aciklama" <%if strfkolonlar1="aciklama" then%>selected<%else%><%end if%>>Açıklama</option>
        </select>
        <select name="kolon2" class="form-control" id="kolon2" style="width:auto;">
          <option value="1"> Ana Nesne </option>
          <%
sqlString = "select * from ozellikler where alt = '1' and formid='"&request("fid")&"' ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
          <option value="<%=mmmGenel("id")%>" <%if int(strfkolonlar2)=mmmGenel("id") then%>selected<%else%><%end if%>><%=mmmGenel("isim")%></option>
          <%
sqlString = "select * from ozellikler where anasek = '"&mmmGenel("id")&"' and formid='"&request("fid")&"' ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
          <option value="<%=mmmYardimci("id")%>" <%if int(strfkolonlar2)=mmmYardimci("id") then%>selected<%else%><%end if%>>&nbsp;&nbsp;<%=mmmYardimci("isim")%></option>
          <%
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
          <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
        </select>
        <div style="clear:both;"></div>
<select name="kolon3" class="form-control" id="kolon3" style="width:auto; float:left;">
          <option value="1"> Ana Nesne </option>
          <option value="baslik" <%if strfkolonlar3="baslik" then%>selected<%else%><%end if%>>Başlık</option>
          <option value="aciklama" <%if strfkolonlar3="aciklama" then%>selected<%else%><%end if%>>Açıklama</option>
        </select>
        <select name="kolon4" class="form-control" id="kolon4" style="width:auto;">
          <option value="1"> Ana Nesne </option>
          <%
sqlString = "select * from ozellikler where alt = '1' and formid='"&request("fid")&"' ORDER BY isim"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
%>
          <option value="<%=mmmGenel("id")%>" <%if int(strfkolonlar4)=mmmGenel("id") then%>selected<%else%><%end if%>><%=mmmGenel("isim")%></option>
          <%
sqlString = "select * from ozellikler where anasek = '"&mmmGenel("id")&"' and formid='"&request("fid")&"' ORDER BY isim"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
          <option value="<%=mmmYardimci("id")%>" <%if int(strfkolonlar4)=mmmYardimci("id") then%>selected<%else%><%end if%>>&nbsp;&nbsp;<%=mmmYardimci("isim")%></option>
          <%
mmmYardimci.movenext
loop
close(mmmYardimci)
%>
          <%
mmmGenel.movenext
loop
close(mmmGenel)
%>
        </select></td>
  </tr>
  <tr>
    <td>Başarılı Sayfası</td>
    <td>
    <select name="basarisayfa" class="form-control" id="basarisayfa">        
      <option value="0"> Sayfaya Yönlenme Kapalı </option>
   <% response.Write kategoriyaziliste("1","<option value=""#kylid#"">#kylico##kylisim#</option>#kylsub{(,,,,"&sayfagosterme&", &nbsp;&nbsp;-&nbsp;,240)}#","",strfbasari,sayfagosterme,"","240") %>     
    </select>
    </td>
  </tr>
  <tr>
    <td>Smtp Gönderim Ayarı</td>
    <td>
    <select name="smtpid" class="form-control" id="smtpid">        
      <option value="0"> Smtp Gönderim Ayarı Seçiniz </option>
            <%
sqlString = "select * from formsmtp where onay = '1' ORDER BY formadi"
set mmmYardimci = Con.Execute (sqlString)
Do While Not mmmYardimci.EOF
%>
          <option value="<%=mmmYardimci("id")%>" <%if strfsmtpid&""=""&mmmYardimci("id") then%>selected<%else%><%end if%>><%=mmmYardimci("formadi")%></option>         
          <%
mmmYardimci.movenext
loop
close(mmmYardimci)
%>    
    </select>
    </td>
  </tr>
  <tr>
    <td>Koruma Zamanı</td>
    <td><input name="korumazaman" type="text" id="korumazaman" value="<%=strfkoruma%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Ip Black List</td>
    <td><textarea name="blacklist" cols="50" rows="3" id="blacklist" class="form-control"><%=strfblacklist%></textarea></td>
  </tr>
  <tr>
    <td>Gönderene Giden Email Başlık</td>
    <td><input name="password" type="text" id="password" value="<%=strfpassword%>" class="form-control"/></td>
  </tr>
  <tr>
    <td>Gönderene Giden Email Metin</td>
    <td><textarea name="login" cols="50" rows="3" id="login" class="normal form-control"><%=strflogin%></textarea></td>
  </tr>
  <tr>
    <td>Gönderene Mesaj Gitsinmi</td>
    <td>
        <%if strfsmtpport = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("smtpport","Gönderene Mesaj Gönder",ifo,cbcdisstr,cbccheckstr,"danger"))%></td>
  </tr>
  <tr>
    <td>Eklemeye Kapalı</td>
    <td>
        <%if strficerikid = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("engel","Eklemeye Kapalı Durumu",ifo,cbcdisstr,cbccheckstr,"danger"))%></td>
  </tr>
  <tr>
    <td>Girişler Listesi</td>
    <td>
        <%if strfciftmail = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("liste","Girişleri Listeleme Durumu",ifo,cbcdisstr,cbccheckstr,"primary"))%>
       </td>
  </tr>
  <tr>
    <td>Veritabanına Kayıt Et</td>
    <td>
        <%if strfveritabanikayit = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("veritabani","Veritabanına Kayıt Etme Durumu",ifo,cbcdisstr,cbccheckstr,"danger"))%>
      </td>
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
    <td>Temp Form</td>
    <td>
     <%if strftemp = "1" Then
                          cbcdisstr="disabled"
						  cbccheckstr="checked"
						  else
						  cbcdisstr=""
						  cbccheckstr=""
						  end if
						  response.Write(checkboxcreat("temp","Temp Form Durumu",ifo,cbcdisstr,cbccheckstr,"successs"))%>
                         </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="Submit" type="submit" id="Submit5" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?sek=<%=request("sek")%>&usayi=<%=request("usayi")%>&amp;islem=kap&amp;filtre=<%=request("filtre")%>&amp;sira=<%=request("sira")%>&amp;dkate2=<% =dkate2%>&amp;git=<%=request("git")%>&Submit=formDuzenle');"/></td>
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