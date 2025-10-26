<head>

    <style type="text/css">

        .auto-style1 {

            height: 20px;

        }

    </style>

</head>

<div class="col-md-12">

<%if reset="1" then%>

  <div class="btn btn-danger btn-lg">Yeni Kurulum Site Ayarlarını Kontrol Edin, Eski Verileri Silin.</div>

  <%end if%>

  <ul class="nav nav-tabs">

    <li class="active"><a data-toggle="tab" href="#ana">Ana Tanımlamalar</a></li> 

    <li><a data-toggle="tab" href="#header">Başlık Tanımlamaları</a></li> 

    <li><a data-toggle="tab" href="#social">Sosyal ve Seo Tanımlamaları</a></li> 

    <li><a data-toggle="tab" href="#languagecurr">Dil ve Para Birimi Tanımlamaları</a></li> 

      <%if instr(sistem_site_turu,"*eticaret*") or sistem_site_turu="*tur*" then %>

    <li><a data-toggle="tab" href="#eticaret">Eticaret Ayarları</a></li> 

      <%end if %>

      <%if instr(sistem_site_turu,"*tur*") then %>

    <li><a data-toggle="tab" href="#tur">Tur Ayarları</a></li> 

      <%end if %>

                  <%if instr(sistem_site_turu,"*haber*") then %>

    <li><a data-toggle="tab" href="#haber">Haber Ayarları</a></li> 

      <%end if %>

<%if instr(sistem_site_turu,"*rehber*") then%>

    <li><a data-toggle="tab" href="#rehber">Rehber Ayarları</a></li> 

      <%end if %>

      </ul>

              <div class="tab-content">

                  <div id="ana" class="tab-pane fade in active">

<form action="?islem=csskaydet&sonuc=ekle1&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

  <table class="table table-striped table-sm">

      <tr>

        <td width="30%">Mate Tag Resim</td>

        <td class="auto-style1">

            

      <div class="input-group">

	  <input class="form-control" id="fieldID1" aria-multiselectable="true" name="d1" type="text" value="<%=strcsd1 %>">

      <div class="input-group-btn">

         <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID1&multiple=0&fldr=/temp<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>

          </div>

	</div>



        </td>

      </tr> 

      <tr>

        <td>Y&ouml;netim Paneli Logosu</td>

        <td>

      <div class="input-group">

	  <input class="form-control" id="fieldID2" aria-multiselectable="true" name="d2" type="text" value="<%=strcsd2 %>">

      <div class="input-group-btn">

         <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID2&multiple=0&fldr=/temp<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>

          </div>

	</div>

            </td>

      </tr>

      <tr>

        <td>Email List Logosu</td>

        <td>

      <div class="input-group">

	  <input class="form-control" id="fieldID4" aria-multiselectable="true" name="d4" type="text" value="<%=strcsd4 %>">

      <div class="input-group-btn">

         <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID4&multiple=0&fldr=/temp<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>

          </div>

	</div>

           </td>

      </tr>

      

        <tr>

          <td height="20">İco Logo seçimi</td>

          <td>

      <div class="input-group">

	  <input class="form-control" id="fieldID42" aria-multiselectable="true" name="d42" type="text" value="<%=strcsd42 %>">

      <div class="input-group-btn">

         <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID42&multiple=0&fldr=/temp<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Select</a>

          </div>

	</div>

            </td>

        </tr>

             <TR> 

                <TD>Cdn Yolu:</TD>

                <TD><INPUT type="text" name="usttur" value="<%=strcsusttur%>" class="form-control"></TD>

              </TR>

             <TR> 

                <TD>Dil Görüntüleme Ayarı:</TD>

                <TD>

                    <select name="d58" class="form-control" id="d58">

                                <option value="0">Seçiniz</option>



                                <option value="1" <%if "1"=""&strcsd58 then%>selected<%else%><%end if %>>Varsayılan Dilde Açılsın</option>

                                <option value="0" <%if "0"=""&strcsd58 then%>selected<%else%><%end if %>>İşletim Sistemi Diliyle Açılsın</option>



                            </select>

                </TD>

              </TR>

             <TR> 

                <TD>Version Tag:</TD>

                <TD><INPUT type="text" name="d60" value="<%=strcsd60%>" class="form-control"></TD>

              </TR>

             <TR> 

                <TD>Ana Klasör Yolu:</TD>

                <TD><INPUT type="text" name="d11" value="<%=strcsd11%>" class="form-control"></TD>

              </TR>

    

             <TR> 

                <TD>Şirket Ünvanı:</TD>

                <TD><INPUT type="text" name="unvan" value="<%=strsahip%>" class="form-control"></TD>

              </TR>

              <TR> 

                <TD>Adres:</TD>

                <TD><INPUT id="adres22" value="<%=stradres%>" type="text" name="adres" class="form-control"></TD>

              </TR>

              <TR> 

                <TD>Telefon(lar):</TD>

                <TD><INPUT type="text" name="tel" value="<%=strtel%>" class="form-control" data-inputmask="'mask' : '+99 999 999 99 99'"></TD>

              </TR>

              <TR> 

                <TD>Fax(lar):</TD>

                <TD><INPUT type="text" name="fax" value="<%=strfax%>" class="form-control" data-inputmask="'mask' : '+99 999 999 99 99'"></TD>

              </TR>

              <TR> 

                <TD>Site Adresi</TD>

                <TD><INPUT type="text" name="icq" value="<%=stricq%>" class="form-control"></TD>

              </TR>

              <TR> 

                <TD>info emaili</TD>

                <TD><INPUT type="text" name="info" value="<%=strinfo%>" class="form-control"></TD>

              </TR>

              <tr>

                <td>Site Başlık <span id="KalanKarakterbaslik" class="sitebaslik">(<%=70-len(baslik)%>)</span>:</td>

                <td><textarea name="title" cols="50" rows="6" id="title" onkeyup="baslikkarakter()" class="form-control"><%=baslik%></textarea></td>

              </tr>

              <tr>

                <td>Site Açıklama <span id="KalanKarakteracik" class="acik">(<%=160-len(acik)%>)</span>:</td>

                <td><textarea name="acik" cols="50" rows="6" id="acik" onkeyup="aciklamakarakter()" class="form-control"><%=acik%></textarea></td>

              </tr>

               <%if reset="1" or yetkiuye="1" then%>

               <TR> 

                  <TD>Temp Dosyaları Sil:</TD>

                  <TD><INPUT type="checkbox" name="tempsil" value="1" ></TD>

                </TR>

              <TR> 

                 <TD>Formlar Sil:</TD>

                 <TD><INPUT type="checkbox" name="formsil" value="1" ></TD>

               </TR>

                <TR> 

                   <TD>Seo Hraflang Sil:</TD>

                   <TD><INPUT type="checkbox" name="hraflangsil" value="1" ></TD>

                 </TR>

                 <TR> 

                    <TD>Seo Link 301 Sil:</TD>

                    <TD><INPUT type="checkbox" name="seolinksil" value="1" ></TD>

                  </TR>

                  <TR> 
 
                     <TD>Seo Link Temizle:</TD>
 
                     <TD><INPUT type="checkbox" name="seolinktemizle" value="1" ></TD>
 
                   </TR>

                  <TR> 

                     <TD>Modül İçerik Kategori Düzelt:</TD>

                     <TD><INPUT type="checkbox" name="micerikduzelt" value="1" ></TD>

                   </TR>

                  

      <%if instr(sistem_site_turu,"*tur*") then %>

      <TR> 

        <TD>Turları Sil:</TD>

        <TD><INPUT type="checkbox" name="turlarsil" value="1" ></TD>

      </TR>

      <TR> 

        <TD>Tur Rezervasyonları Sil:</TD>

        <TD><INPUT type="checkbox" name="turrezsil" value="1" ></TD>

      </TR>

      <TR> 

        <TD>Tur Müşterileri Sil:</TD>

        <TD><INPUT type="checkbox" name="turmussil" value="1" ></TD>

      </TR>

      <TR> 

        <TD>Tur Yorumları Sil:</TD>

        <TD><INPUT type="checkbox" name="turyorsil" value="1" ></TD>

      </TR>

      <TR> 

        <TD>Tahsilatları Sil:</TD>

        <TD><INPUT type="checkbox" name="tahsil" value="1" ></TD>

      </TR>

      <%end if%>

      

      

      <%if instr(sistem_site_turu,"*eticaret*") or sistem_site_turu="*tur*" then %>

      

      <%end if%>

                 <%end if%>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button5" id="button5" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr>

      <tr>

        <td>&nbsp;</td>

        <td>&nbsp;</td>

        </tr>

      </table>

        </form>

                      </div>

                  <div id="header" class="tab-pane fade">

<form action="?islem=csskaydet&sonuc=header&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

        <table class="table table-striped table-sm">

<tr>

          <td colspan="2">

         <%

       ' response.Write header_json

             if instr(header_json,"}") then

             'response.Write "1"

    Set oJSON = New aspJSON

    oJSON.loadJSON(header_json)

             set kbstr = oJSON.data

             for each odail in kbstr

                Set this = kbstr(odail)(0)

             strheadercntcode=this("Code")

             strheadercntbaslik=this("Title")

             strheadercntdeger=MyOwnHTMLEncode(this("Value"))

             if strheadercntbaslik="" and strheadercntdeger="" then

             else

             %>

              <div class="form-group">

                  <label>

                      <%if yetkiuye=1 then%>

        <input id="headercnt<%=sizopim %>b" type="text" value="<%=strheadercntbaslik %>" name="headercntbaslik" class="form-control input-xs"/>

                      <%else %>

                      <input id="headercnt<%=sizopim %>b" type="hidden" value="<%=strheadercntbaslik %>" name="headercntbaslik" />

                      <%=strheadercntbaslik %>

                      <%end if %>

                      </label>

            <textarea id="headercnt<%=sizopim %>d" name="headercnt" rows="4" class="form-control"><%=replace(replace(strheadercntdeger,"</script>","</script>&#13;&#10;"),"<link ","&#13;&#10;<link ")%></textarea>

              </div>

         <%

             end if

             next

             %></td>

        </tr>

           <tr>

          <td>

                      <%if yetkiuye=1 then%>

              <input id="headercnt999b" type="text" value="" name="headercntbaslik" class="form-control" placeholder="Yeni Değer"/>

              <%else %>

              <input id="socialcnt999b" type="hidden" value="" name="headercntbaslik" />

              <%end if %></td>

          <td>

             <%if yetkiuye=1 then%>

              <textarea id="headercnt999d" name="headercnt" rows="4" class="form-control"></textarea>

              <%else %>

              <input id="socialcnt999b" type="hidden" value="" name="headercnt" />

              <%end if %></td>

        </tr>

            <% else %>   

           <tr>

          <td><input id="headercnt999b" type="text" value="" name="headercntbaslik" class="form-control" placeholder="Yeni Değer"/></td>

          <td><textarea id="headercnt999d" name="headercnt" rows="4" class="form-control"></textarea></td>

        </tr>

         <%end if

             

        'response.End

             %>





        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button5" id="button5" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr>

      <tr>

        <td>&nbsp;</td>

        <td>&nbsp;</td>

        </tr>

      </table>

    </form>

                      </div>

                  <div id="social" class="tab-pane fade">

<form action="?islem=csskaydet&sonuc=social&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

        <table class="table table-striped table-sm">

<tr>

          <td colspan="2">

         <%

             if instr(social_api_json,"}") then

    Set oJSON = New aspJSON

    oJSON.loadJSON(social_api_json)

             set kbstr = oJSON.data

             for each odail in kbstr

                Set this = kbstr(odail)(0)

             strsocialcntcode=this("Code")

             strsocialcntbaslik=this("Title")

             strsocialcntdeger=MyOwnHTMLEncode(this("Value"))

             if strsocialcntbaslik="" and strsocialcntdeger="" then

             else

             %>

              <div class="form-group">

                  <label>

                      <%if yetkiuye=1 then%>

                    <input id="socialcnt<%=sizopim %>b" type="text" value="<%=strsocialcntbaslik %>" name="socialcntbaslik" class="form-control input-xs"/>

                      <%else %>

                      <input id="socialcnt<%=sizopim %>b" type="hidden" value="<%=strsocialcntbaslik %>" name="socialcntbaslik" />

                      <%=strsocialcntbaslik %>

                      <%end if %>

                      </label>

            <textarea id="socialcnt<%=sizopim %>d" name="socialcnt" rows="4" class="form-control"><%=strsocialcntdeger%></textarea>

              </div>

         <%

             end if

             next

             %></td>

        </tr>

           <tr>

          <td><%if yetkiuye=1 then%>

              <input id="socialcnt999b" type="text" value="" name="socialcntbaslik" class="form-control" placeholder="Yeni Değer"/>

              <%else %>

              <input id="socialcnt999b" type="hidden" value="" name="socialcntbaslik" />

              <%end if %>

          </td>

          <td><%if yetkiuye=1 then%>

              <textarea id="socialcnt999d" name="socialcnt" rows="4" class="form-control"></textarea>

              <%else %>

              <input id="socialcnt999d" type="hidden" value="" name="socialcnt" />

              <%end if %>

          </td>

        </tr>

            <% else %>   

           <tr>

          <td><input id="socialcnt999b" type="text" value="" name="socialcntbaslik" class="form-control" placeholder="Yeni Değer"/></td>

          <td><textarea id="socialcnt999d" name="socialcnt" rows="4" class="form-control"></textarea></td>

        </tr>

         <%end if %>

                           

                            <%if yetkiuye=9999 then%>



        <tr>

          <td>Men&uuml; Sıra Adeti</td>

          <td><input name="d28" type="text" id="d1" onkeypress="return klavyesayisal(event)" value="<%=strcsd28%>" size="3" maxlength="2" class="form-control"/></td>

        </tr>

        <tr>

          <td>Filtre A&ccedil;ılırmı</td>

          <td><label>

            <input type="radio" name="d54" value="1" id="mg_18" <%if strcsd54="1" then%>checked="checked"<%else%><%end if%> class="flatgreen"/>

            Evet</label>

            <label>

              <input type="radio" name="d54" value="0" id="mg_19" <%if strcsd54="1" then%><%else%> checked="checked"<%end if%> class="flatgreen"/>

            Hayır</label></td>

        </tr>

        <tr>

          <td>Anasayfa &Uuml;r&uuml;n Adedi</td>

          <td><span class="field small">

            <input type="text" size="5" name="anauadet" id="anauadet" value="<%=strcsanauadet%>" class="form-control"/>

          </span></td>

        </tr>

        <tr>

          <td>Kategori &Uuml;r&uuml;n Adedi</td>

          <td><input type="text" size="5" name="kateuadet" id="kateuadet" value="<%=strcskateuadet%>" class="form-control"/></td>

        </tr>

      <%end if %>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button5" id="button5" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr>

      <tr>

        <td>&nbsp;</td>

        <td>&nbsp;</td>

        </tr>

      </table>

        </form>

                      </div>

                  <div id="languagecurr" class="tab-pane fade">

    <table class="table table-striped">

        <tr>

            <td style="vertical-align:top;">

<form action="?islem=csskaydet&sonuc=languageupd&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

    <table class="table table-striped">

        <tr>

            <td><div class="x_title"><h2>Dil Tanımlamaları</h2><div class="clearfix"></div></div></td>

            <td></td>

            <td></td>

            <td></td>

        </tr> 

         <%

sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"

set mmmYardimci3 = Con.Execute (sqlString)

Do While Not mmmYardimci3.EOF

             iok=iok+1

             strdilkate=mmmYardimci3("kate")

strdilid=mmmYardimci3("id")

strdilnot=mmmYardimci3("nott")

strdilsira=mmmYardimci3("sira")

strceviricode=mmmYardimci3("ceviricode")

          ceviridil=ceviridilek&"-"&strceviricode

%>

        <tr>

            <td><input name="sektor" type="text" id="sektor" value="<%=strdilkate%>" class="form-control" /></td>

            <td><input name="charset" type="text" id="charset" value="<%=strceviricode%>" class="form-control" /></td>

            <td>

                <input name="id" type="hidden"  value="<%=strdilid%>" size="40" />

              <input name="durum" type="hidden" id="durum" value="1" />

              <input name="durum2" type="hidden" id="durum" value="<%=strdilid%>" />

              <%if strdilsira = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("buton","Aktiflik Durumu",iok,cbcdisstr,cbccheckstr,"info"))%>

            </td>

             <td> <%if strdilnot = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("buton1","Varsayılan Dil",iok,cbcdisstr,cbccheckstr,"info"))%>

            </td>

        </tr>

                <%

mmmYardimci3.movenext

loop

close(mmmYardimci3)

%> 

        <tr>

            <td></td>

            <td></td>

            <td></td>

            <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr> 

    </table>

    </form>

            </td>

            <td style="vertical-align:top;">

<form action="?islem=csskaydet&sonuc=currencyupd&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

    <table class="table table-striped">

        <tr>

            <td><div class="x_title"><h2>Para Birimi Tanımlamaları</h2><div class="clearfix"></div></div></td>

            <td></td>

            <td></td>

            <td></td>

        </tr>

      <%

sqlString = "select * from "&dbsparabirimi&" ORDER BY vpb desc,onay desc,id"

set mmmYardimci3 = Con.Execute (sqlString)

Do While Not mmmYardimci3.EOF

          iok=iok+1

          strid=mmmYardimci3("id")

          strdovizad=mmmYardimci3("dovizad")

          strpb=mmmYardimci3("pb")

          strkur=mmmYardimci3("kur")

          strvpb=mmmYardimci3("vpb")

          stronay=mmmYardimci3("onay")

%>

        <tr>

            <td><input name="id" type="hidden" value="<%=strid%>"/><input name="dovizad" type="text" id="dovizad" value="<%=strdovizad%>" class="form-control" /></td>

            <td><input name="kur" type="text" id="kur" value="<%=strkur%>" class="form-control" /></td>

            <td><input name="pb" type="text" id="pb" value="<%=strpb%>" class="form-control" /></td>

            <td> <%if strvpb = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("vpb","Varsayılan Durumu",iok,cbcdisstr,cbccheckstr,"info"))%></td>

            <td> <%if stronay = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","Aktiflik Durumu",iok,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

                <%

mmmYardimci3.movenext

loop

close(mmmYardimci3)

%>  

        <tr>

            <td></td>

            <td><a href="?sayfa=islem&islem=KurGuncelletcbm" class="btn btn-warning">TCBM Kurları Güncelle</a></td>

            <td><a href="?sayfa=islem&islem=KurGuncelleSite" class="btn btn-warning">EUBANK Kurları Güncelle</a></td>

            <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr> 

    </table>

    </form>

           </td>

        </tr> 

    </table>

                      </div>

      <%if instr(sistem_site_turu,"*tur*") then %>

                  <div id="tur" class="tab-pane fade">



      <div class="col-md-12">

      <form action="?islem=csskaydet&sonuc=ekle11&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2#tur" method="post">

          <table class="table table-striped table-sm">

         <%

             if instr(tour_api_json,"}") then

    Set oJSON = New aspJSON

    oJSON.loadJSON(tour_api_json)

             set kbstr = oJSON.data

             for each odail in kbstr

                Set this = kbstr(odail)(0)

             strtourcntcode=this("Code")

             strtourcntbaslik=this("Title")

             strtourcntdeger=this("Value")

             if strtourcntbaslik="" and strtourcntdeger="" then

             else

             %>

<tr>

          <td>

                      <%if yetkiuye=1 then%>

                    <input id="tourcnt<%=sizopim %>b" type="text" value="<%=strtourcntbaslik %>" name="tourcntbaslik" class="form-control"/>

                      <%else %>

                      <input id="tourcnt<%=sizopim %>b" type="hidden" value="<%=strtourcntbaslik %>" name="tourcntbaslik" />

                      <%=strtourcntbaslik %>

                      <%end if %>

        </td>

          <td>

                      <input id="tourcnt<%=sizopim %>d" type="text" class="form-control" value="<%=strtourcntdeger %>" name="tourcnt" />

        </td>

        </tr>

         <%

             end if

             next

             %>

           <tr>

          <td><%if yetkiuye=1 then%>

              <input id="tourcnt999b" type="text" value="" name="tourcntbaslik" class="form-control" placeholder="Yeni Değer"/>

              <%else %>

              <input id="tourcnt999b" type="hidden" value="" name="tourcntbaslik" />

              <%end if %>

          </td>

          <td><%if yetkiuye=1 then%>

                      <input id="tourcnt999d" type="text" class="form-control input-xs" value="" name="tourcnt" />

              <%else %>

              <input id="tourcnt999d" type="hidden" value="" name="tourcnt" />

              <%end if %>

          </td>

        </tr>

            <% else %>   

           <tr>

          <td><input id="tourcnt999b" type="text" value="" name="tourcntbaslik" class="form-control" placeholder="Yeni Değer"/></td>

          <td>

                      <input id="tourcnt999d" type="text" class="form-control input-xs" value="" name="tourcnt" />

             </td>

        </tr>

         <%end if %>

                

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button5" id="button5" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr>

      <tr>

        <td>&nbsp;</td>

        <td>&nbsp;</td>

        </tr>

      </table>

        </form>

    </div>

                      </div>

      <%end if %>

      <%if instr(sistem_site_turu,"*eticaret*") or sistem_site_turu="*tur*" then %>

                  <div id="eticaret" class="tab-pane fade">

<%

    dim ayarnsstore(18)

    'or sistem_site_turu=""

	ayarsinadet=ubound(split(strcsd6,","))
	if instr(strcsd6,",") then

		for ayarnsstoreimm=0 to ayarsinadet

	ayarnsstore(ayarnsstoreimm)=split(strcsd6,",")(ayarnsstoreimm)

	next

	ayarnsstore0=ayarnsstore(0)*1

	ayarnsstore1=ayarnsstore(1)*1

	ayarnsstore2=ayarnsstore(2)*1

	ayarnsstore3=ayarnsstore(3)*1

	ayarnsstore4=ayarnsstore(4)*1

	ayarnsstore5=ayarnsstore(5)*1

	ayarnsstore6=ayarnsstore(6)*1

	ayarnsstore7=ayarnsstore(7)*1

	ayarnsstore8=ayarnsstore(8)*1

	ayarnsstore9=ayarnsstore(9)*1

	ayarnsstore10=ayarnsstore(10)*1

	ayarnsstore11=ayarnsstore(11)*1

	ayarnsstore12=ayarnsstore(12)*1

	ayarnsstore13=ayarnsstore(13)*1

	ayarnsstore14=ayarnsstore(14)*1

	ayarnsstore15=ayarnsstore(15)*1

	ayarnsstore16=ayarnsstore(16)*1

	if ayarsinadet=<16 then

	else

	ayarnsstore17=ayarnsstore(17)

	end if

	else

	end if%>

      <div class="col-md-12">

      <div class="x_title"><h2>G&ouml;sterim Se&ccedil;enekleri</h2>

               <div class="clearfix"></div></div>

      <form action="?islem=csskaydet&sonuc=ekle7&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

      <table class="table table-striped">    

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr>

          <tr>

          <td>Sepet G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td>

          <%if ayarnsstore0 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",0,cbcdisstr,cbccheckstr,"info"))%>

</td>

        </tr>

        <tr>

          <td>Aynı &Uuml;r&uuml;nler Tek Tekmi G&ouml;r&uuml;ns&uuml;n  ?(Farklı &Ouml;zellik Se&ccedil;enekliler)</td>

          <td><%if ayarnsstore1 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",1,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Detayında Belirleyici Se&ccedil;enek G&ouml;r&uuml;ns&uuml;nm&uuml;?</td>

          <td><%if ayarnsstore2 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",2,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Marka G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnsstore3 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",3,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td><p>&Uuml;r&uuml;n Kutusunda İ. K. G&ouml;r&uuml;ns&uuml;nm&uuml; ?</p></td>

          <td><%if ayarnsstore4 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",4,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Satın Al Butonu G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><% if ayarnsstore5 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",5,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Fiyat G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnsstore6 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",6,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Ürün Eklerken Kdv Hariç Fiyatlar Girilsin ?</td>

          <td><%if ayarnsstore7 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",7,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Ürün Kategori Sayfasında Üst Butonlar Görünsünmü ?</td>

          <td><%if ayarnsstore8 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",8,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Detayında Kdv Hari&ccedil; Fiyatı G&ouml;ster?</td>

          <td><%if ayarnsstore9 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",9,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Arama G&ouml;r&uuml;ns&uuml;n m&uuml; ?</td>

          <td><%if ayarnsstore10 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",10,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Menüsü Görünsünmü ?</td>

          <td><%if ayarnsstore11 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",11,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Ürün Kutusunda Dövizli Fiyatlarmı Görünsün ?</td>

          <td><%if ayarnsstore12 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",12,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Satışı Kapat ?</td>

          <td><%if ayarnsstore13 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",13,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Ödeme Formu Kurumsal Ayarlansın</td>

          <td><%if ayarnsstore14 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",14,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

       <tr>

          <td>Lazy Load Kapat</td>

          <td><%if ayarnsstore15 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",15,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

               <tr>

          <td>Çift Resimli Ürün Kutuları Kapat</td>

          <td><%if ayarnsstore16 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",16,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Kdvli Fiyatmı G&ouml;r&uuml;ns&uuml;n ?</td>

          <td><%if ayarnsstore17 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onay","",17,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr>

    </table>

        </form>

    </div>

                      </div>

      <%end if %>

                  <%if instr(sistem_site_turu,"*haber*") then %>

                  <div id="haber" class="tab-pane fade">

      <%

          

          	dim ayarnshaber(17)

	ayarshaberinadet=ubound(split(strcsd7,","))

	if instr(strcsd7,",") then

	for ayarnshaberimm=0 to ayarshaberinadet

	ayarnshaber(ayarnshaberimm)=split(strcsd7,",")(ayarnshaberimm)

	next

	ayarnshaber0=ayarnshaber(0)*1

	ayarnshaber1=ayarnshaber(1)*1

	ayarnshaber2=ayarnshaber(2)*1

	ayarnshaber3=ayarnshaber(3)*1

	ayarnshaber4=ayarnshaber(4)*1

	ayarnshaber5=ayarnshaber(5)*1

	ayarnshaber6=ayarnshaber(6)*1

	ayarnshaber7=ayarnshaber(7)*1

	ayarnshaber8=ayarnshaber(8)*1

	ayarnshaber9=ayarnshaber(9)*1

	ayarnshaber10=ayarnshaber(10)*1

	ayarnshaber11=ayarnshaber(11)*1

	ayarnshaber12=ayarnshaber(12)*1

	ayarnshaber13=ayarnshaber(13)*1

	ayarnshaber14=ayarnshaber(14)*1

	ayarnshaber15=ayarnshaber(15)*1

	ayarnshaber16=ayarnshaber(16)*1

	if ayarshaberinadet=<16 then

	else

	ayarnshaber17=ayarnshaber(17)*1

	end if

	else

	end if

          %>

      <div class="col-md-6">

<div class="x_title"><h2>Ana Ayarlar</h2>

               <div class="clearfix"></div></div>

          <form action="?islem=csskaydet&sonuc=ekle1&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

          <table class="table table-striped">

      <tr>

        <td width="30%"><div class="button_d button" style="width:130px;">Ana Ayarlar</div></td>

        <td>&nbsp;</td>

        </tr>

              <tr>

        <td class="auto-style1">Mate Tag Resim</td>

        <td class="auto-style1"><select name="d1" id="d1" class="form-control">

          <option value="0" <%if strcsd1="0" then%>selected<%else%><%end if%>>Mate Tag Resim Se&ccedil;iniz</option>

          <%strListelenecekKlasor = "../images/my_pictures/temp" 

              strListelenecekKlasor1 = "images/my_pictures/temp" 

Set ObjFSO=Server.CreateObject("Scripting.FileSystemObject" ) 

Set strDosyalar=ObjFSO.GetFolder(Server.MapPath(strListelenecekKlasor))

For Each strBulunanDosya in strDosyalar.files 

%>

          <option value="<%=strListelenecekKlasor1%>/<%=strBulunanDosya.Name%>" <%if strcsd1=strListelenecekKlasor1&"/"&strBulunanDosya.Name  then%>selected<%else%><%end if%>><%=strBulunanDosya.Name%></option>

          <%Next

		  set ObjFSO=nothing%>

          </select></td>

      </tr> 

      <tr>

        <td>Y&ouml;netim Paneli Logosu</td>

        <td><select name="d2" id="d2" class="form-control">

          <option value="0" <%if strcsd2="0" then%>selected<%else%><%end if%>>Y&ouml;netim Paneli Logosu Se&ccedil;iniz</option>

          <%strListelenecekKlasor = "../images/my_pictures/temp" 

Set ObjFSO=Server.CreateObject("Scripting.FileSystemObject" ) 

Set strDosyalar=ObjFSO.GetFolder(Server.MapPath(strListelenecekKlasor))

For Each strBulunanDosya in strDosyalar.files 

%>

          <option value="<%=strListelenecekKlasor1%>/<%=strBulunanDosya.Name%>" <%if strcsd2=strListelenecekKlasor1&"/"&strBulunanDosya.Name  then%>selected<%else%><%end if%>><%=strBulunanDosya.Name%></option>

          <%Next

		  set ObjFSO=nothing%>

        </select></td>

      </tr>

      <tr>

        <td>Email List Logosu</td>

        <td><select name="d4" id="d4" class="form-control">

          <option value="0" <%if strcsd4="0" then%>selected<%else%><%end if%>>Email List Logosu Se&ccedil;iniz</option>

          <%strListelenecekKlasor = "../images/my_pictures/temp" 

Set ObjFSO=Server.CreateObject("Scripting.FileSystemObject" ) 

Set strDosyalar=ObjFSO.GetFolder(Server.MapPath(strListelenecekKlasor))

For Each strBulunanDosya in strDosyalar.files 

%>

          <option value="<%=strListelenecekKlasor1%>/<%=strBulunanDosya.Name%>" <%if strcsd4=strListelenecekKlasor1&"/"&strBulunanDosya.Name then%>selected<%else%><%end if%>><%=strBulunanDosya.Name%></option>

          <%Next

		  set ObjFSO=nothing%>

          </select></td>

      </tr>

      

        <tr>

          <td height="20">İco Logo seçimi</td>

          <td><select name="d42" id="d42" class="form-control">

            <option value="0" <%if strcsd42="0" then%>selected<%else%><%end if%>>Ico Logosu Se&ccedil;iniz</option>

            <%strListelenecekKlasor = "../images/my_pictures/temp" 

Set ObjFSO=Server.CreateObject("Scripting.FileSystemObject" ) 

Set strDosyalar=ObjFSO.GetFolder(Server.MapPath(strListelenecekKlasor))

For Each strBulunanDosya in strDosyalar.files 

%>

            <option value="<%=strListelenecekKlasor1%>/<%=strBulunanDosya.Name%>" <%if strcsd42=strListelenecekKlasor1&"/"&strBulunanDosya.Name  then%>selected<%else%><%end if%>><%=strBulunanDosya.Name%></option>

            <%Next

		  set ObjFSO=nothing%>

          </select></td>

        </tr>

        <tr>

          <td>Haber Resim Yolu</td>

          <td><input name="d28" type="text" id="d1" value="<%=strcsd28%>" class="form-control"/></td>

        </tr>

        <tr>

          <td>Yazar Resim Yolu</td>

          <td>

            

            <input name="d54" type="text" id="d54" value="<%=strcsd54%>" class="form-control"/>

            </td>

        </tr>

        <tr>

          <td>Sayfayı Yenile</td>

          <td><input name="d59" type="number" min="180" id="d59" value="<%=strcsd59%>" class="form-control"/>saniye</td>

        </tr>

        <tr>

          <td>Varsayılan Şehir</td>

          <td>

            <select name="anauadet" class="form-control">

              <option value="0" <%if strcsanauadet="0" then%>selected<%else%><%end if%>>Şehir Seçiniz</option>

              <option value="ADANA" <%if strcsanauadet="ADANA" then%>selected<%else%><%end if%>>ADANA</option>

              <option value="ADIYAMAN" <%if strcsanauadet="ADIYAMAN" then%>selected<%else%><%end if%>>ADIYAMAN</option>

              <option value="AFYON" <%if strcsanauadet="AFYON" then%>selected<%else%><%end if%>>AFYON</option>

              <option value="AGRI" <%if strcsanauadet="AGRI" then%>selected<%else%><%end if%>>AĞRI</option>

              <option value="AKSARAY" <%if strcsanauadet="AKSARAY" then%>selected<%else%><%end if%>>AKSARAY</option>

              <option value="AMASYA" <%if strcsanauadet="AMASYA" then%>selected<%else%><%end if%>>AMASYA</option>

              <option value="ANKARA" <%if strcsanauadet="ANKARA" then%>selected<%else%><%end if%>>ANKARA</option>

              <option value="ANTALYA" <%if strcsanauadet="ANTALYA" then%>selected<%else%><%end if%>>ANTALYA</option>

              <option value="ARDAHAN" <%if strcsanauadet="ARDAHAN" then%>selected<%else%><%end if%>>ARDAHAN</option>

              <option value="ARTVIN" <%if strcsanauadet="ARTVIN" then%>selected<%else%><%end if%>>ARTVİN</option>

              <option value="AYDIN" <%if strcsanauadet="AYDIN" then%>selected<%else%><%end if%>>AYDIN</option>

              <option value="BALIKESIR" <%if strcsanauadet="BALIKESIR" then%>selected<%else%><%end if%>>BALIKESİR</option>

              <option value="BARTIN" <%if strcsanauadet="BARTIN" then%>selected<%else%><%end if%>>BARTIN</option>

              <option value="BATMAN" <%if strcsanauadet="BATMAN" then%>selected<%else%><%end if%>>BATMAN</option>

              <option value="BAYBURT" <%if strcsanauadet="BAYBURT" then%>selected<%else%><%end if%>>BAYBURT</option>

              <option value="BILECIK" <%if strcsanauadet="BILECIK" then%>selected<%else%><%end if%>>BİLECİK</option>

              <option value="BINGOL" <%if strcsanauadet="BINGOL" then%>selected<%else%><%end if%>>BİNGÖL</option>

              <option value="BITLIS" <%if strcsanauadet="BITLIS" then%>selected<%else%><%end if%>>BİTLİS</option>

              <option value="BOLU" <%if strcsanauadet="BOLU" then%>selected<%else%><%end if%>>BOLU</option>

              <option value="BURDUR" <%if strcsanauadet="BURDUR" then%>selected<%else%><%end if%>>BURDUR</option>

              <option value="BURSA" <%if strcsanauadet="BURSA" then%>selected<%else%><%end if%>>BURSA</option>

              <option value="CANAKKALE" <%if strcsanauadet="CANAKKALE" then%>selected<%else%><%end if%>>ÇANAKKALE</option>

              <option value="CANKIRI" <%if strcsanauadet="CANKIRI" then%>selected<%else%><%end if%>>ÇANKIRI</option>

              <option value="CORUM" <%if strcsanauadet="CORUM" then%>selected<%else%><%end if%>>ÇORUM</option>

              <option value="DENIZLI" <%if strcsanauadet="DENIZLI" then%>selected<%else%><%end if%>>DENİZLİ</option>

              <option value="DIYARBAKIR" <%if strcsanauadet="DIYARBAKIR" then%>selected<%else%><%end if%>>DİYARBAKIR</option>

              <option value="DUZCE" <%if strcsanauadet="DUZCE" then%>selected<%else%><%end if%>>DÜZCE</option>

              <option value="EDIRNE" <%if strcsanauadet="EDIRNE" then%>selected<%else%><%end if%>>EDİRNE</option>

              <option value="ELAZIG" <%if strcsanauadet="ELAZIG" then%>selected<%else%><%end if%>>ELAZIĞ</option>

              <option value="ERZINCAN" <%if strcsanauadet="ERZINCAN" then%>selected<%else%><%end if%>>ERZİNCAN</option>

              <option value="ERZURUM" <%if strcsanauadet="ERZURUM" then%>selected<%else%><%end if%>>ERZURUM</option>

              <option value="ESKISEHIR" <%if strcsanauadet="ESKISEHIR" then%>selected<%else%><%end if%>>ESKİŞEHIR</option>

              <option value="GAZIANTEP" <%if strcsanauadet="GAZIANTEP" then%>selected<%else%><%end if%>>GAZİANTEP</option>

              <option value="GIRESUN" <%if strcsanauadet="GIRESUN" then%>selected<%else%><%end if%>>GİRESUN</option>

              <option value="GUMUSHANE" <%if strcsanauadet="GUMUSHANE" then%>selected<%else%><%end if%>>GÜMÜŞHANE</option>

              <option value="HAKKARI" <%if strcsanauadet="HAKKARI" then%>selected<%else%><%end if%>>HAKKARİ</option>

              <option value="HATAY" <%if strcsanauadet="HATAY" then%>selected<%else%><%end if%>>HATAY</option>

              <option value="IGDIR" <%if strcsanauadet="IGDIR" then%>selected<%else%><%end if%>>IĞDIR</option>

              <option value="ISPARTA" <%if strcsanauadet="ISPARTA" then%>selected<%else%><%end if%>>ISPARTA</option>

              <option value="ISTANBUL" <%if strcsanauadet="ISTANBUL" then%>selected<%else%><%end if%>>İSTANBUL</option>

              <option value="IZMIR" <%if strcsanauadet="IZMIR" then%>selected<%else%><%end if%>>İZMİR</option>

              <option value="KAHRAMANMARAS" <%if strcsanauadet="KAHRAMANMARAS" then%>selected<%else%><%end if%>>KAHRAMANMARAŞ</option>

              <option value="KARABUK" <%if strcsanauadet="KARABUK" then%>selected<%else%><%end if%>>KARABÜK</option>

              <option value="KARAMAN" <%if strcsanauadet="KARAMAN" then%>selected<%else%><%end if%>>KARAMAN</option>

              <option value="KARS" <%if strcsanauadet="KARS" then%>selected<%else%><%end if%>>KARS</option>

              <option value="KASTAMONU" <%if strcsanauadet="KASTAMONU" then%>selected<%else%><%end if%>>KASTAMONU</option>

              <option value="KAYSERI" <%if strcsanauadet="KAYSERI" then%>selected<%else%><%end if%>>KAYSERİ</option>

              <option value="KILIS" <%if strcsanauadet="KILIS" then%>selected<%else%><%end if%>>KİLİS</option>

              <option value="KIRIKKALE" <%if strcsanauadet="KIRIKKALE" then%>selected<%else%><%end if%>>KIRIKKALE</option>

              <option value="KIRKLARELI" <%if strcsanauadet="KIRKLARELI" then%>selected<%else%><%end if%>>KIRKLARELİ</option>

              <option value="KIRSEHIR" <%if strcsanauadet="KIRSEHIR" then%>selected<%else%><%end if%>>KIRŞEHİR</option>

              <option value="KOCAELI" <%if strcsanauadet="KOCAELI" then%>selected<%else%><%end if%>>KOCAELİ</option>

              <option value="KONYA" <%if strcsanauadet="KONYA" then%>selected<%else%><%end if%>>KONYA</option>

              <option value="KUTAHYA" <%if strcsanauadet="KUTAHYA" then%>selected<%else%><%end if%>>KÜTAHYA</option>

              <option value="MALATYA" <%if strcsanauadet="MALATYA" then%>selected<%else%><%end if%>>MALATYA</option>

              <option value="MANISA" <%if strcsanauadet="MANISA" then%>selected<%else%><%end if%>>MANİSA</option>

              <option value="MARDIN" <%if strcsanauadet="MARDIN" then%>selected<%else%><%end if%>>MARDİN</option>

              <option value="MERSIN" <%if strcsanauadet="MERSIN" then%>selected<%else%><%end if%>>MERSİN</option>

              <option value="MUGLA" <%if strcsanauadet="MUGLA" then%>selected<%else%><%end if%>>MUĞLA</option>

              <option value="MUS" <%if strcsanauadet="MUS" then%>selected<%else%><%end if%>>MUŞ</option>

              <option value="NEVSEHIR" <%if strcsanauadet="NEVSEHIR" then%>selected<%else%><%end if%>>NEVŞEHİR</option>

              <option value="NIGDE" <%if strcsanauadet="NIGDE" then%>selected<%else%><%end if%>>NİĞDE</option>

              <option value="ORDU" <%if strcsanauadet="ORDU" then%>selected<%else%><%end if%>>ORDU</option>

              <option value="OSMANIYE" <%if strcsanauadet="OSMANIYE" then%>selected<%else%><%end if%>>OSMANİYE</option>

              <option value="RIZE" <%if strcsanauadet="RIZE" then%>selected<%else%><%end if%>>RİZE</option>

              <option value="SAKARYA" <%if strcsanauadet="SAKARYA" then%>selected<%else%><%end if%>>SAKARYA</option>

              <option value="SAMSUN" <%if strcsanauadet="SAMSUN" then%>selected<%else%><%end if%>>SAMSUN</option>

              <option value="SANLIURFA" <%if strcsanauadet="SANLIURFA" then%>selected<%else%><%end if%>>ŞANLIURFA</option>

              <option value="SIIRT" <%if strcsanauadet="SIIRT" then%>selected<%else%><%end if%>>SİİRT</option>

              <option value="SINOP" <%if strcsanauadet="SINOP" then%>selected<%else%><%end if%>>SİNOP</option>

              <option value="SIRNAK" <%if strcsanauadet="SIRNAK" then%>selected<%else%><%end if%>>ŞIRNAK</option>

              <option value="SIVAS" <%if strcsanauadet="SIVAS" then%>selected<%else%><%end if%>>SİVAS</option>

              <option value="TEKIRDAG" <%if strcsanauadet="TEKIRDAG" then%>selected<%else%><%end if%>>TEKİRDAĞ</option>

              <option value="TOKAT" <%if strcsanauadet="TOKAT" then%>selected<%else%><%end if%>>TOKAT</option>

              <option value="TRABZON" <%if strcsanauadet="TRABZON" then%>selected<%else%><%end if%>>TRABZON</option>

              <option value="TUNCELI" <%if strcsanauadet="TUNCELI" then%>selected<%else%><%end if%>>TUNCELİ</option>

              <option value="USAK" <%if strcsanauadet="USAK" then%>selected<%else%><%end if%>>UŞAK</option>

              <option value="VAN" <%if strcsanauadet="VAN" then%>selected<%else%><%end if%>>VAN</option>

              <option value="YALOVA" <%if strcsanauadet="YALOVA" then%>selected<%else%><%end if%>>YALOVA</option>

              <option value="YOZGAT" <%if strcsanauadet="YOZGAT" then%>selected<%else%><%end if%>>YOZGAT</option>

              <option value="ZONGULDAK" <%if strcsanauadet="ZONGULDAK" then%>selected<%else%><%end if%>>ZONGULDAK</option>

          </select>

            </td>

        </tr>

        <tr>

          <td>Varsayılan Lig</td>

          <td>

            <select name="kateuadet" class="form-control">

              <option value="0" <%if strcskateuadet="0" then%>selected<%else%><%end if%>>Lig Seçiniz</option>

              <option value="superlig" <%if strcskateuadet="superlig" then%>selected<%else%><%end if%>>Süper Lig</option>

              <option value="tff1lig" <%if strcskateuadet="tff1lig" then%>selected<%else%><%end if%>>TFF 1. Lig</option>

              <option value="tff2ligbeyaz" <%if strcskateuadet="tff2ligbeyaz" then%>selected<%else%><%end if%>>TFF 2. Lig Beyaz Grup</option>

              <option value="tff2ligkirmizi" <%if strcskateuadet="tff2ligkirmizi" then%>selected<%else%><%end if%>>TFF 2. Lig Kırmızı Grup</option>

              <option value="tff3lig1g" <%if strcskateuadet="tff3lig1g" then%>selected<%else%><%end if%>>TFF 3. Lig 1. Grup</option>

              <option value="tff3lig2g" <%if strcskateuadet="tff3lig2g" then%>selected<%else%><%end if%>>TFF 3. Lig 2. Grup</option>

              <option value="tff3lig3g" <%if strcskateuadet="tff3lig3g" then%>selected<%else%><%end if%>>TFF 3. Lig 3. Grup</option>

            </select>

            </td>

        </tr>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button5" id="button5" value="Kaydet" class="btn btn-success pull-right" /></td>

        </tr>

      <tr>

        <td>&nbsp;</td>

        <td>&nbsp;</td>

        </tr>

      </table>

        </form>

          </div>

<div class="col-md-6">

<table class="table table-striped">

    

      <tr>

        <td width="80%"><div class="button_d button" style="width:160px;">G&ouml;sterim Se&ccedil;enekleri</div></td>

        <td>&nbsp;</td>

        </tr>

      <form action="?islem=csskaydet&sonuc=ekle7&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr><tr>

          <td>Sepet G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td>

              <%if ayarnshaber0 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",0,cbcdisstr,cbccheckstr,"info"))%>

</td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Detayında Belirleyici Se&ccedil;enek G&ouml;r&uuml;ns&uuml;nm&uuml;?</td>

          <td><%if ayarnshaber1 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",1,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Marka G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnshaber3 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",3,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td><p>&Uuml;r&uuml;n Kutusunda İ. K. G&ouml;r&uuml;ns&uuml;nm&uuml; ?</p></td>

          <td><%if ayarnshaber4 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",4,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Satın Al Butonu G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnshaber5 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",5,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Fiyat G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnshaber6 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",6,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Ürün Eklerken Kdv Hariç Fiyatlar Girilsin ?</td>

          <td><%if ayarnshaber7 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",7,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&Uuml;st Men&uuml;de Para Birimi G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnshaber8 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",8,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>&Uuml;r&uuml;n Detayında Kdv Hari&ccedil; Fiyatı G&ouml;ster?</td>

          <td><%if ayarnshaber9 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",9,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Arama G&ouml;r&uuml;ns&uuml;n m&uuml; ?</td>

          <td><%if ayarnshaber10 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",10,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Menüsü Görünsünmü ?</td>

          <td><%if ayarnshaber11 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",11,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Ürün Kutusunda Dövizli Fiyatlarmı Görünsün ?</td>

          <td><%if ayarnshaber12 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",12,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Satışı Kapat ?</td>

          <td><%if ayarnshaber13 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",13,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Https Linkini Kapat</td>

          <td><%if ayarnshaber14 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",14,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

       <tr>

          <td>Lazy Load Kapat</td>

          <td><%if ayarnshaber15 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",15,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

               <tr>

          <td>Çift Resimli Ürün Kutuları Kapat</td>

          <td><%if ayarnshaber16 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",16,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Kdvli Fiyatmı G&ouml;r&uuml;ns&uuml;n ?</td>

          <td><%if ayarnshaber17 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onays","",17,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&nbsp;</td>

          <td>&nbsp;</td>

        </tr>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr>

        </form>

    </table>

    </div>

                      </div>

      <%end if %>

                  <%if instr(sistem_site_turu,"*rehber*") then %>

                  <div id="rehber" class="tab-pane fade">

<div class="col-md-12">

<div class="x_title"><h2>G&ouml;sterim Se&ccedil;enekleri</h2>

               <div class="clearfix"></div></div>

      <form action="?islem=csskaydet&sonuc=ekle7&urunid=<%=strcsid%>&id=<%=strcsid%>&filtre=2" method="post">

<table class="table  table-striped">

    <%

	dim ayarnsrehber(17)

	ayarsrehberinadet=ubound(split(strcsd8,","))        

	if instr(strcsd8,",") then

        

	for ayarnsrehberimm=0 to ayarsrehberinadet

        

	ayarnsrehber(ayarnsrehberimm)=split(strcsd8,",")(ayarnsrehberimm)

	next

	ayarnsrehber0=ayarnsrehber(0)*1

	ayarnsrehber1=ayarnsrehber(1)*1

	ayarnsrehber2=ayarnsrehber(2)*1

	ayarnsrehber3=ayarnsrehber(3)*1

	ayarnsrehber4=ayarnsrehber(4)*1

	ayarnsrehber5=ayarnsrehber(5)*1

	ayarnsrehber6=ayarnsrehber(6)*1

	ayarnsrehber7=ayarnsrehber(7)*1

	ayarnsrehber8=ayarnsrehber(8)*1

	ayarnsrehber9=ayarnsrehber(9)*1

	ayarnsrehber10=ayarnsrehber(10)*1

	ayarnsrehber11=ayarnsrehber(11)*1

	ayarnsrehber12=ayarnsrehber(12)*1

	ayarnsrehber13=ayarnsrehber(13)*1

	ayarnsrehber14=ayarnsrehber(14)*1

	ayarnsrehber15=ayarnsrehber(15)*1

	ayarnsrehber16=ayarnsrehber(16)*1



	else

	end if

	%>



        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr><tr>

          <td>Üye Mesaj Butonu Görünsünmü ?</td>

          <td><%if ayarnsrehber0 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",0,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Takip Butonu Görünsünmü ?</td>

          <td><%if ayarnsrehber1 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",1,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Öneri Butonu Görünsünmü ?</td>

          <td><%if ayarnsrehber2 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",2,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Paylaşım Butonu Görünsünmü ?</td>

          <td><%if ayarnsrehber3 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",3,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td><p>Üye Resim Beğeni Butonu G&ouml;r&uuml;ns&uuml;nm&uuml; ?</p></td>

          <td><%if ayarnsrehber4 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",4,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Üye Resim Gösterim Adeti G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnsrehber5 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",5,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Üye Resim Gösterim Adeti Sayılsınmı ?</td>

          <td><%if ayarnsrehber6 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",6,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Üye Gösterim Adeti G&ouml;r&uuml;ns&uuml;nm&uuml; ?</td>

          <td><%if ayarnsrehber7 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",7,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>Üye Gösterim Adeti Sayılsınmı ?</td>

          <td><%if ayarnsrehber8 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",8,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üyeler Onaylımı Kayıt Olsun ?</td>

          <td><%if ayarnsrehber9 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",9,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Üye Resimleri Onaylımı Kayıt Olsun ?</td>

          <td><%if ayarnsrehber10 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",10,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>İşler Onaylı Kayıt Olsun ?</td>

          <td><%if ayarnsrehber11 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",11,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Oteller Onaylımı Kayıt Olsun ?</td>

          <td><%if ayarnsrehber12 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",12,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>Otel İş Resimleri Onaylımı Kayıt Olsun ?</td>

          <td><%if ayarnsrehber13 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",13,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        <tr>

          <td>-</td>

          <td><%if ayarnsrehber14 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",14,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

       <tr>

          <td>Lazy Load Kapat</td>

          <td><%if ayarnsrehber15 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",15,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

               <tr>

          <td>Çift Resimli Ürün Kutuları Kapat</td>

          <td><%if ayarnsrehber16 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",16,cbcdisstr,cbccheckstr,"info"))%></td>

        </tr>

        

        <tr>

          <td>&Uuml;r&uuml;n Kutusunda Kdvli Fiyatmı G&ouml;r&uuml;ns&uuml;n ?</td>

          <td><%if ayarnsrehber17 = "1" Then

                          cbcdisstr="disabled"

						  cbccheckstr="checked"

						  else

						  cbcdisstr=""

						  cbccheckstr=""

						  end if

						  response.Write(checkboxcreat("onayr","",17,cbcdisstr,cbccheckstr,"info"))%></td>

          </tr>

        <tr>

          <td>&nbsp;</td>

          <td>&nbsp;</td>

        </tr>

        <tr>

          <td>&nbsp;</td>

          <td><input type="submit" name="button6" id="button6" value="Kaydet" class="btn btn-success pull-right"/></td>

        </tr>

    </table>

        </form>

    </div>

                      </div>

      <%end if %>

                  </div>

      </div>