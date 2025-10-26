<%if instr(sistem_site_turu,"*eticaret*") then%>
 <%silinmiyecekler=silinmiyecekler&",s1019,s1017,s1015,s1016,s1018"%>
<%'if urunlergd=1 or urunlerbd=1 then%>
  <li>
    <a><i class="fa fa-files-o"></i>Ürün İşlemleri<span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <%'if urunlerbs=1 then%>
  <li><a href="store.asp?storesayfagit=urunekle">Ürün Ekle </a></li>
  <%'else
  'end if%>
  <%'if urunlerbd=1 then%>
        <li><a>Ürün Düzenleme İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <li><a href="store.asp?storesayfagit=urunkategoriduzenle">Kategorileri Düzenle</a></li>
  <li><a href="store.asp?storesayfagit=urunvitrinduzenle">Vitrin Düzeni</a> </li>
  <li><a href="store.asp?storesayfagit=urunstokduzenle">Stok Güncelle</a> </li>
   <li><a href="store.asp?storesayfagit=urunfiltreduzenle">Filtreleri Güncelle</a> </li>
   <li><a href="store.asp?storesayfagit=urunbagliduzenle">Bağlama Durumu</a> </li>
  <li><a href="store.asp?storesayfagit=uruntopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="store.asp?storesayfagit=urunsosyalduzenle">Sosyal Paylaşım</a></li>
        </ul></li>
  <%'else
  'end if%>
  <%'if urunlergd=1 then%>
  <li><a href="store.asp?storesayfagit=urunxmlcek">Xml Hazırla </a></li>
  <%'else
  'end if%>
  <%'if urunlerbd=1 then%>
  <li><a href="store.asp?storesayfagit=urunkategori">Ürün Kategorileri</a> </li>
  <li><a href="store.asp?storesayfagit=urunfiltre">Ürün Filtreleri</a></li>
  <li><a href="store.asp?storesayfagit=urunvaryant">Ürün Varyant Sistemi</a> </li>
  <%'else
  'end if%>
  <%'if siparislerbd=1 and siparislergd=1 then%>
  <li><a href="store.asp?storesayfagit=urunsiparis">Siparişler</a></li>
  <%'else%><%'end if%>
  </ul>
 </li>
  <%'else%><%'end if%>
 <% end if
     
     if instr(sistem_site_turu,"*eticaret*") or instr(sistem_site_turu,"*tur*") or instr(sistem_site_turu,"*cicek*") or instr(sistem_site_turu,"*rehber*") then%>
<%'if uyelergd=1 or uyelerbd=1 then%>
  <li>
    <a><i class="fa fa-files-o"></i>Üye / Bayi İşlemleri<span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <%'if uyelerbd=1 then%>
  <li><a href="store.asp?storesayfagit=storeuyeler">Üye & Bayi Listesi</a></li>
  <%'else%><%'end if%>
  <%'if uyelergd=1 then%>
  <li><a href="store.asp?storesayfagit=storeuyegrup">Üye & Bayi Grupları</a></li>
  <li><a href="store.asp?storesayfagit=storeuyeekle">Yeni &Uuml;ye & Bayi Ekle</a></li>
  <%'else%><%'end if%>
  <%'if maillistd=1 or maillists=1 then%>
  <li><a href="#">Maillist Y&ouml;netimi <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <%'if maillistd=1 then%>
  <li><a href="store.asp?storesayfagit=storeuyemesaj&grup=2">Üyelere Mesaj</a></li>
  <li><a href="store.asp?storesayfagit=storeuyemesaj&grup=1">Bayilere Mesaj</a></li>
  <li><a href="store.asp?storesayfagit=storeuyemesaj">Diğer Gruplara Mesaj</a></li>
   <%'else%><%'end if%>
  </ul>
 </li>
  <%'else%><%'end if%>
  </ul>
 </li>
 <%'else%><%'end if%>

     <%else
 end if
if instr(sistem_site_turu,"*eticaret*") or instr(sistem_site_turu,"*cicek*") or instr(sistem_site_turu,"*rehber*") then
         'if siparislerbd=1 then%>
  <li>
    <a><i class="fa fa-files-o"></i>Ödeme İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <%'if siparislergd=1 then%>
  <li><a href="store.asp?storesayfagit=urunsipariskargo">Kargolar</a></li>
  <li><a href="store.asp?storesayfagit=urunsiparispbirim">Para Birimi</a></li>
  <li><a href="store.asp?storesayfagit=urunsiparisodemes">Ödeme Seçenekleri</a></li>
  <li><a href="store.asp?storesayfagit=urunsiparisbankaekle">Banka Hesap No</a></li>
  <li><a href="store.asp?storesayfagit=urunsiparistaksit">Taksit Seçenekleri</a></li>
  <%'else%><%'end if%>
  <%if asd=1 then%>
  <li><a href="eticaret/store_kargo.asp">Teslimat Bouml;lgeler</a></li>
  <%else%><%end if%>
  </ul>
 </li>
<%'else%><%'end if
    else
 end if

    if instr(sistem_site_turu,"*kupon*") then
         'if siparislerbd=1 then%>
  <li>
    <a><i class="fa fa-files-o"></i>Kupon Kart İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <%'if siparislergd=1 then%>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=firmalar">Firmalar</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=uyeler">Üyeler</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=uyelerreferans&uyekartgrup=5">Referanslar</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=kuponrefkategori">Referans Kategorileri</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=uyelerbasvuru&uyekartgrup=3">Başvurular</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=kampanyalar">Kampanyalar</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=kuponkategori">Kampanya Kategorileri</a></li>
  <li><a href="sayfa_kupon.asp?kuponsayfagit=kupondiller">Kupon Diller</a></li>
  <%'else%><%'end if%>
  </ul>
 </li>
<%'else%><%'end if
    else
 end if

     if instr(sistem_site_turu,"*ce*") then
         'if siparislerbd=1 then%>
  <li>
    <a><i class="fa fa-files-o"></i>CE İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
  <%'if siparislergd=1 then%>
  <li><a href="sayfa_ce.asp?cesayfagit=firmalar">Ajanslar</a></li>
  <li><a href="sayfa_ce.asp?kucesayfagitponsayfagit=uyeler">Müşteriler</a></li>
  <li><a href="sayfa_ce.asp?cesayfagit=cediller">CE Diller</a></li>
  <%'else%><%'end if%>
  </ul>
 </li>
<%'else%><%'end if
    else
 end if

     if instr(sistem_site_turu,"*tur*") then%>
 <%silinmiyecekler=silinmiyecekler&",s1019,s1017,s1015,s1016,s1018"%>
<%'if turlargd=1 or turlarbd=1 then%>
<li>
    <a><i class="fa fa-files-o"></i>Tur İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">        
    
        <li><a>Cruise İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=turekle">Cruise Ekle </a></li>

        <li><a href="sayfa_tur.asp?tursayfagit=turkategoriduzenle">Destinasyon Güncelle</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=turvitrinduzenle">Vitrin Düzeni</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turstokduzenle">Stok Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turfiltreduzenle">Filtreleri Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turtopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=tursosyalduzenle">Sosyal Paylaşım</a></li>
         <li><a>Gemi İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <%'if turlarbd=1 then%>
        <li><a href="sayfa_tur.asp?tursayfagit=turgemifirma">Gemi Firmalarını Yönet</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=turgemi">Gemileri Yönet</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turgemikabin">Kabinleri Yönet</a> </li>
        <%'else
        'end if%>
        </ul></li> 
         </ul></li>
        <li><a>Otel İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=oteller&icsayfatur=otelekle">Otel Ekle </a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=oteller">Oteller</a></li>
         </ul></li>
        <%if eser="1" then %>
        <li><a>Kiralama İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=turekle">Kiralama Ekle </a></li>

        <li><a href="sayfa_tur.asp?tursayfagit=turkategoriduzenle">Destinasyon Güncelle</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=turvitrinduzenle">Vitrin Düzeni</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turstokduzenle">Stok Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turfiltreduzenle">Filtreleri Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turtopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=tursosyalduzenle">Sosyal Paylaşım</a></li>
         </ul></li>
        <%else
            end if%>
        <li><a>Gezi Turu İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=geziekle">Gezi Turu Ekle </a></li>

        <li><a href="sayfa_tur.asp?tursayfagit=gezikategoriduzenle">Destinasyon Güncelle</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=gezivitrinduzenle">Vitrin Düzeni</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=gezistokduzenle">Stok Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=gezifiltreduzenle">Filtreleri Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=gezitopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=gezisosyalduzenle">Sosyal Paylaşım</a></li>
         </ul></li>
        <li><a>Feribot İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=feribotekle">Feribot Turu Ekle </a></li>

        <li><a href="sayfa_tur.asp?tursayfagit=feribotkategoriduzenle">Destinasyon Güncelle</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=feribotvitrinduzenle">Vitrin Düzeni</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=feribotstokduzenle">Stok Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=feribotfiltreduzenle">Filtreleri Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=feribottopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=feribotsosyalduzenle">Sosyal Paylaşım</a></li>
         </ul></li>
        <%if eser="1" then %>
        <li><a>Paket Tur İşlemleri <span class="fa fa-chevron-down"></span></a>
    <ul class="nav child_menu">
        <li><a href="sayfa_tur.asp?tursayfagit=turekle">Paket Tur Ekle </a></li>

        <li><a href="sayfa_tur.asp?tursayfagit=turkategoriduzenle">Destinasyon Güncelle</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=turvitrinduzenle">Vitrin Düzeni</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turstokduzenle">Stok Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turfiltreduzenle">Filtreleri Güncelle</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turtopluduzenle">Toplu G&uuml;ncelleme</a></li>
        <li><a href="sayfa_tur.asp?tursayfagit=tursosyalduzenle">Sosyal Paylaşım</a></li>
         </ul></li>
        
        <%else
            end if%>
          
        <%'if turlarbd=1 then%>
        <li><a href="sayfa_tur.asp?tursayfagit=turkategori">Destinasyonlar</a> </li>
        <li><a href="sayfa_tur.asp?tursayfagit=turfiltre">Filtreleri</a></li>
        <%'else
        'end if%>
        <%'if siparislerbd=1 and siparislergd=1 then%>
        <li><a href="sayfa_tur.asp?tursayfagit=tursiparis">Talepler</a></li>
         <%if ayarlar=1 then%>
        <li><a href="sayfa_tur.asp?tursayfagit=turdiller">Tur Site Diller</a></li>
        <%else
            end if%>
        <%'else%><%'end if%>
    </ul>
</li>
  <%'else%><%'end if%>
 <%else
 end if

 if instr(sistem_site_turu,"*haber*") then%>
 <%silinmiyecekler=silinmiyecekler&",s1019,s1020,s1021,s1022,s1017,s1018,s1047"%>
 <li><a><i class="fa fa-files-o"></i> Haberler <span class="fa fa-chevron-down"></span></a>

   <ul class="nav child_menu">


  <LI><a href="sayfa_haber.asp?habersayfagit=haber_ekle">Haber Ekle</a></LI>
	<LI><a href="sayfa_haber.asp?habersayfagit=haber_ler&gun=<%=day(date)%>&ay=<%=month(date)%>&yil=<%=year(date)%>">Haberler</a></LI>
    <LI><a href="sayfa_haber.asp?habersayfagit=haber_sosyal&ay=<%=month(date)%>&yil=<%=year(date)%>">Haber Paylaşım</a></LI>
    <LI><a href="sayfa_haber.asp?habersayfagit=haber_yorum">Haber Yorumları</a></LI>
	<LI><a href="sayfa_haber.asp?habersayfagit=haber_kategori">Haber Kategorileri</a></LI>
    <LI><a><i class="fa fa-files-o"></i> Ajanslar</a>
     <ul class="nav child_menu">
  <LI><a href="sayfa_haber.asp?habersayfagit=haber_ajanslar">Ajans Ayarları</a></LI>
  <%if eserr=1 then%>
	<LI><a href="sayfa_haber.asp?habersayfagit=haber_aayerel&ajansid=5">Anadolu Ajansı</a></LI>
    <LI><a href="sayfa_haber.asp?habersayfagit=haber_aaWEB&ajansid=37">Anadolu Ajansı Web Paketi</a></LI>
    <%else
	end if%>
    <LI><a href="sayfa_haber.asp?habersayfagit=haber_iha">İha Ajansı</a></LI>
    </UL>
    </LI>
   </UL>
</li>
  <li><a><i class="fa fa-files-o"></i> Yazar İşlemleri <span class="fa fa-chevron-down"></span></a>

  <ul class="nav child_menu">
    <LI><a href="sayfa_haber.asp?habersayfagit=yazar_lar">Yazarlar</a></LI>
    <LI><a href="sayfa_haber.asp?habersayfagit=yazar_yazi_sosyal">Yazıları Facebookda Paylaş</a></LI>
    <LI><a href="sayfa_haber.asp?habersayfagit=yazar_yazi_mesaj">Yazar Mesajları</a></LI>
  </UL></li>
  <%else
  end if
  if instr(sistem_site_turu,"*cicek*") then%>
<%
silinmiyecekler=silinmiyecekler&",s1052,s1053,s1054,s1055"
	urunlergd=1
	urunlerbd=1
	siparislerbd=1
	siparislergd=1
	uyelergd=1
	uyelerbd=1%>
    
    <%if urunlergd=1 or urunlerbd=1 then%>
  <li><a><i class="fa fa-files-o"></i> Ürün İşlemleri <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu"> 
  <%if urunlergd=1 then%>
  <li><a href="store.asp?storesayfagit=cicekurunekle">&Uuml;r&uuml;n Ekle</a></li>
  <%else
  end if%>
  <%if urunlerbd=1 then%>
  <li><a href="store.asp?storesayfagit=cicekurunlerkisa"> &Uuml;r&uuml;nleri D&uuml;zenle</a></li>
  <li><a href="store.asp?storesayfagit=cicekurunler">&Uuml;r&uuml;nler Kategori D&uuml;zenle</a></li>
  <%else
  end if%>
  <%if urunlergd=1 then%>
  <li><a href="store.asp?storesayfagit=cicekurunlerteslimat">Ürünlerin Teslimat Yerleri</a></li>
  <li><a href="store.asp?storesayfagit=cicekilsemtduzenle">Teslimat Yeri ve Yol Ücretleri</a></li>
  <%else
  end if%>
  <%if urunlerbd=1 then%>
  <li><a href="store.asp?storesayfagit=cicekkategoriler">Kategoriler</a></li>
  <%else
  end if%>
  </ul>
 </li>
  <%else%><%end if
      else
  end if      %>
  


 <%if instr(sistem_site_turu,"*rehber*") then%>
<li><a><i class="fa fa-files-o"></i>Firma İşlemleri <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a href="sayfa_guru.asp?rehbersayfagit=firma_ekle">Firma Ekle</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=firmalar">Firmalar</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=firma_sektorler">Firma Sektörleri</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=firma_varyantlar">Firma Varyantlar</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=destek_mesajlar">Destek Mesajları</a></li>
  
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_uye_hizmet&baay=4&biay=4&biyil=2018&ac=1&gorev=teklif">Teklif</a></li>
  
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_takvim">Takvim</a></li>  
    <li><a>Hizmet İşlemleri <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_hizmetler">Hizmetler</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_ay">Hizmetler Süre Takibi</a></li>
  </ul>
  </li>
  <li><a>Ayarlar <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a>Dil İşlemleri <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a href="sayfa_guru.asp?rehbersayfagit=rehber_dilb">Genel</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=rehber_dilk">Sektör</a></li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=rehber_dilv">Varyant</a></li>
  </ul>
  </li>
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_tedarik">Tedarikçiler</a></li>
  </ul>
  </li>
  <li><a>Yandex Mail <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a href="sayfa_guru.asp?rehbersayfagit=cr_yandex&hesap=1&emailadmin=eser.ulusoy">eser.ulusoy</a></li>
   <li><a href="sayfa_guru.asp?rehbersayfagit=cr_yandex&hesap=2&emailadmin=reklaminn">reklaminn</a></li>
   <li><a href="sayfa_guru.asp?rehbersayfagit=cr_yandex&hesap=3&emailadmin=reklaminn1">reklaminn1</a></li>
   <li><a href="sayfa_guru.asp?rehbersayfagit=cr_yandex&hesap=4&emailadmin=reklaminn2">reklaminn2</a></li>
  </ul>
  </li>
  <li><a>Sipariş İşlemleri <span class="fa fa-chevron-down"></span></a>
  <ul class="nav child_menu">
  <li><a href="sayfa_guru.asp?radminsayfagit=cr_beklemede_siparisler">Siparişler</a></li>
  </ul>
  </li>
  </ul>
</li>

 <%else
     end if
  %>