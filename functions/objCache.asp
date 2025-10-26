<%
'****************************************************************
' Classic ASP Cache System
' Coded By Fatih Aytekin
' Email: fatih@aytekin.me
' Web: www.fatihaytekin.com
'****************************************************************

'****************************************************************
' Kullanımı
' Eğer dosya olarak önbellekleme yapacaksanız Application("CacheKlasoru") = "C:\siteler\ornek.com\cache\" olarak tanımlamalısınız
'https://www.travelshowtime.com/archeological-ephesus-tour-from-kusadasi.html?version=1&cache=htemizle
' Set objCache = New Cache
'	objCache.OnbellekZaman = CI_GUN ' Önbellek Zaman Tipi
'	objCache.OnbellekAralik = 1 ' Önbellek zaman aralığı
'	objCache.Dosya() '// Eğer Önbelleği dosya olarak kaydetmek istiyorsanız
'	objCache.Bellek() '// Eğer Önbelleği sunucu RAM'ine (Application) kaydetmek istiyorsanız (Tavsiye)
'	objCache.DosyaAdi = "Dosya" '// Eğer önbellek ismi belirtmek istiyorsanız (Tavsiye Etmem)
' Set objCache = Nothing
'****************************************************************
    Application("CacheKlasoru") = "C:\Inetpub\vhosts\travelshowtime.com\httpdocs\contents\cache\"
    Set objCache = New Cache
	objCache.OnbellekZaman = CI_GUN ' Önbellek Zaman Tipi
	objCache.OnbellekAralik = 1 ' Önbellek zaman aralığı
	'objCache.Dosya() '// Eğer Önbelleği dosya olarak kaydetmek istiyorsanız
	objCache.Bellek() '// Eğer Önbelleği sunucu RAM'ine (Application) kaydetmek istiyorsanız (Tavsiye)
'	objCache.DosyaAdi = "Dosya" '// Eğer önbellek ismi belirtmek istiyorsanız (Tavsiye Etmem)
 Set objCache = Nothing

Const	CI_DAKIKA = 0
Const	CI_SAAT = 1
Const	CI_GUN = 2

Class Cache
	Private objFSO
	Private CacheKomut
	Private fintOnbellekZaman
	Private fintOnbellekAralik
	Private CacheKlasor
	Private fstrSiteAdresi
	Private fstrCacheDosyaUzanti
	Private fstrCekURL
	Private CacheKomutAdi
	Private fstrCacheDosyasi
	Private fstrCachedRamAdi
	Private fstrCachedRamZaman

	Private Sub Class_Initialize()
		
		'Diske Kaydet FSO
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		
		'Cache Kontrol Değeri
		CacheKomutAdi = "cache"
		CacheKomut = GetQueryString2(CacheKomutAdi)
			
		'Varsayılan Önbellek Ayarları
		fintOnbellekZaman = CI_GUN 
		fintOnbellekAralik = 1
		
		'Cache Klasörü & SiteAdi
		CacheKlasor = Application("CacheKlasoru")
		fstrSiteAdresi = "https://"&Request.ServerVariables("SERVER_NAME")
		
		'Cache Benzersiz İsim
		fstrDosyaAdi = server.MapPath(Request.ServerVariables("PATH_INFO")) 
		fstrTemelAd = objFSO.GetBaseName(fstrDosyaAdi) & "_"
		fstrCacheQueryString = GetCacheQueryString()
		fstrCacheDosyaUzanti = ".html" 'Ne olursa olsun fark etmez
		
		'Dosya Adı Oluşturma
		fstrCacheDosyasi = Temizle(CacheKlasor & fstrTemelAd _
		& fstrCacheQueryString & fstrCacheDosyaUzanti,0)
		
		'Cache RAM Adi Oluşturma
		fstrCachedRamAdi = Temizle(CStr(fstrTemelAd & fstrCacheQueryString),0)
		fstrCachedRamZaman = fstrCachedRamAdi & "_Olustu"

		bIsPostBack = false
		If Request("IsPostback") = "true" Then
			bIsPostBack = true
		End If
		
		
		fstrCekURL = fstrSiteAdresi & CStr(Request.ServerVariables("URL"))
		If Cstr(Request.QueryString) <> vbNullString Then
			fstrCekURL = fstrCekURL & "?" & Cstr(Request.QueryString)
		End If
		fstrCekURL = Temizle(fstrCekURL,1)
		
	End Sub
	
	Private Sub Class_Terminate()

		If Not objFSO Is Nothing Then
			Set objFSO = Nothing
		End If
		
	End Sub

	'## -- Fonksiyonlar -- 
	Private Function GetCacheQueryString() 'String Döner

		Dim strSonuc
		Dim var
		Dim strAyir
		strSonuc = vbNullString
		strAyir = vbNullString
		For Each var In Request.QueryString
			If var <> "cache" Then
				strSonuc = strSonuc & strAyir & var & "_" & Request.QueryString(var)
				strAyir = "_"
			End If
		
		Next
		
		GetCacheQueryString = strSonuc
	
	End Function
	
	Private Function GetQueryString2(deger)
		If IsNull(deger) Then Exit Function
		strYonURLs = Request.ServerVariables("SERVER_NAME")

		Set strURLs = Request.ServerVariables("QUERY_STRING") 
		arrBolum = Split(strURLs,"/")
		strYonLinks = ""
		For Bo = 3 To UBound(arrBolum)
			If NOT IsEmpty(arrBolum(Bo)) Then 
				Bolum = Split(arrBolum(Bo),"?")
				If UBound(Bolum) > 0 Then
					strIDs = Bolum(0)
				Else
					strIDs = arrBolum(Bo)
				End If
				strYonLinks = strYonLinks & "/" & strIDs
			End If
		Next
		
		Set strURL = Nothing
		
		
		If IsHttps Then 
			strDeger = clearField2(Request.QueryString("404;https://"& strYonURLs &":443"& strYonLinks &"?"& deger &"")) 
		Else 
			strDeger = clearField2(Request.QueryString("404;http://"& strYonURLs &":80"& strYonLinks &"?"& deger &""))
		End If
		
		If strDeger = "" Then 
			GetQueryString2 = clearField2(Request.QueryString(deger)) 
		Else 
			GetQueryString2 = strDeger 
		End If
		
		
	End Function
	
	Private Function IsHttps
		If Request.ServerVariables("HTTPS") = "on" Then IsHttps = True
		If Request.ServerVariables("HTTPS") = "off" Then IsHttps = False
	End Function
	
	Private Function clearField2(str)
		If IsNull(str) Then Exit Function
		str = trim(str)
		str = replace(str,"<","&#60;")
		str = replace(str,"=","&#61;")
		str = replace(str,">","&#62;")
		str = replace(str,"'","&#39;")
		str = replace(str,chr(34),"&#34;")
		str = replace(str,"%","&#37;")
		str = replace(str,"*","&#42;")
		str = replace(str,":","&#58;")
		str = replace(str,"\","&#92;")
		str = replace(str,"/","&#47;")	
		clearField2 = str
	End Function
	
	
	Private Function Temizle(ByVal str, ByVal URL)
		If IsNull(str) Then Exit Function
		str = Replace(str, "404_404;"& fstrSiteAdresi &":443/", "")
		str = Replace(str, "404.asp?404;"& fstrSiteAdresi &":443/","")
		If URL <> 1 Then : str = Replace(str, "/", "_") : str = Replace(str, "?", "_") : End If
		Temizle = str
		
	End Function
	
	'Dosya Var mı ?
	Private Function CacheDosyaVarmi()
		CacheDosyaVarmi = objFSO.FileExists(fstrCacheDosyasi)
	End Function
	
	'Cache Bellekte mi?
	Private Function CacheBellektemi()

		If IsEmpty(Application(fstrCachedRamAdi)) OR IsNull(Application(fstrCachedRamAdi)) Then
			CacheBellektemi = false
		Else
			CacheBellektemi = true
		End If
		
	End Function
	
	'Cache Dosya Süresi Doldu mu ?
	Private Function CacheDosyaTarihKontrol()
		Dim objDosya
		Dim strTarih
		Dim strBirim
		
		If CacheDosyaVarmi Then
			Set objDosya = objFSO.GetFile(fstrCacheDosyasi)
				strTarih = objDosya.DateLastModified
			Set objDosya = nothing

			Select Case OnbellekZaman
				Case CI_DAKIKA
					strBirim = "n"
					
				Case CI_SAAT
					strBirim = "h"
					
				Case CI_GUN
					strBirim = "d"
			End Select
			
			CacheDosyaTarihKontrol = (DateDiff(strBirim,CDate(strTarih), Now()) > OnbellekAralik)
		Else
			CacheDosyaTarihKontrol = True
		End If
		
	End Function
	
	'## Cache RAM Süresi Doldu mu ?
	Private Function CacheRAMTarihKontrol()
		
		Dim strBirim
		strBirim = "d"
		
		If IsEmpty(Application(fstrCachedRamZaman)) OR IsNull(Application(fstrCachedRamZaman)) _
			OR Application(fstrCachedRamZaman) = vbNullString Then
			CacheRAMTarihKontrol = true
		Else
			Select Case OnbellekZaman
				Case CI_DAKIKA
					strBirim = "n"
					
				Case CI_SAAT
					strBirim = "h"
					
				Case CI_GUN
					strBirim = "d"
			End Select
			
			If CInt(DateDiff(strBirim,CDate(Application(fstrCachedRamZaman)), Now())) > OnbellekAralik Then
				CacheRAMTarihKontrol = true
			Else
				CacheRAMTarihKontrol = false
			End If		
		End If

	End Function
	'// -- Fonksiyonlar --
	
	
	'##Private Sub'lar
	
	'##Önbelleği Dosyadan Oku
	Private Sub DosyadanOku()
		On Error Resume Next
		
		Dim objDosya
		Set objDosya = objFSO.OpenTextFile(fstrCacheDosyasi, 1, false, -1)
		
		Response.Write(objDosya.ReadAll)
		
		'Neolur Neolmaz Diye
		If err.number <> 0 Then
			'Response.Write (err.Description)
			OnbellekDosyaSil
			Exit Sub
		End If
		
		Response.End()
		Set objDosya = nothing
	End Sub
	
	'Önbelleği RAMden Oku
	Private Sub RAMdanOku()
		Response.Write(Application(fstrCachedRamAdi))	
		Response.End()
	End Sub
	
	'##Private Sub'lar
	
	'## -- Public Sub'lar --
	
	'#Dosyadan Oku
	Public Sub Dosya()
	
		If bIsPostBack Then
			Exit Sub
		End If
		
		Select Case CacheKomut
		
			Case vbNullString 
			
				If Not CacheDosyaVarmi() Or CacheDosyaTarihKontrol() Then
					OlusturDosya
				Else
					DosyadanOku
				End If
	
			Case "gec" 
				
			Case "temizle"
				OnbellekDosyaSil
			
			Case "htemizle"
				ButunKlasorleriTemizle
				
			Case "olustur" 
				OlusturDosya
				DosyadanOku
					
		End Select
		
	End Sub
	
	'## RAM'de Tut
	Public Sub Bellek()
		
		If bIsPostBack Then
			Exit Sub
		End If
		
		Select Case CacheKomut
		
			Case vbNullString 
	
				If Not CacheBellektemi() Or CacheRAMTarihKontrol() Then
					RAMeYaz
				Else
					RAMdanOku
				End If
				
				
			Case "gec" 
							
			Case "temizle"
				Application.Contents.Remove(fstrCachedRamAdi)
			
			Case "htemizle"
				Application.Contents.RemoveAll()
			
			Case "olustur" 
				RAMeYaz
				RAMdanOku				
		End Select
		
	End Sub
	'//RAM'de Tut
	
	'## Dosya Önbellek Oluştur
	Public Sub OlusturDosya()
		
		Dim strIstek
		Dim objTextStream
		Dim Kaynak
		Dim strCekURL

		strCekURL = fstrCekURL
		
		If Instr(1,strCekURL, "?") = 0 Then
			strCekURL = strCekURL & "?"&CacheKomutAdi&"=gec"
		Else
			strCekURL = strCekURL & "&"&CacheKomutAdi&"=gec"
		End If
		
		Set Kaynak = Server.CreateObject("Msxml2.ServerXMLHTTP.6.0")
		Kaynak.Open "GET", strCekURL, False
		Kaynak.Send()

		If Kaynak.Status = 200 Then	
			Set objTextStream = objFSO.CreateTextFile(fstrCacheDosyasi, True, True)
				objTextStream.Write(Kaynak.ResponseText)
				objTextStream.Close
			Set objTextStream = Nothing
		Else
			Exit Sub
		End If
				
		Set Kaynak = Nothing
		
	End Sub
	'//Dosya Önbellek Oluştur
	
	'## RAM e yaz
	Public Sub RAMeYaz()
		Dim Kaynak
		Dim strCekURL
		
		strCekURL = fstrCekURL
		
		If Instr(1,strCekURL, "?") = 0 Then
			strCekURL = strCekURL & "?"&CacheKomutAdi&"=gec"
		Else
			strCekURL = strCekURL & "&"&CacheKomutAdi&"=gec"
		End If

		Set Kaynak = Server.CreateObject("Msxml2.ServerXMLHTTP.6.0")
		Kaynak.Open "GET", strCekURL, False
		Kaynak.Send()
		
		If Kaynak.Status = 200 Then	
			Application(fstrCachedRamAdi) = Kaynak.ResponseText		
			Application(fstrCachedRamZaman) = Cstr(NOW())
		Else
			Exit Sub
		End If
		
		Set Kaynak = nothing
		
	End Sub
	'// RAM'e yaz
	
	'# Tek Dosya Önbelllek Temizle
	Public Sub OnbellekDosyaSil()
   ' response.Write CacheDosyaVarmi&"asd"&fstrCacheDosyasi
		If CacheDosyaVarmi() Then
			objFSO.DeleteFile(fstrCacheDosyasi)
		End If
	
	End Sub
	'// Tek Dosya Önbelllek Temizle
	
	'## Bütün Dosyaları Sil
	Public Sub ButunKlasorleriTemizle()

		Dim objKlasor
		Dim colDosyalar
		Dim objDosya
		
		Set objKlasor = objFSO.GetFolder(Application("CacheKlasoru"))
		Set colDosyalar = objKlasor.Files
		
		For Each objDosya In colDosyalar
			objDosya.Delete()
		Next
		
		Set colDosyalar = nothing
		Set objKlasor = nothing
	
	End Sub
	'//Bütün Dosyaları Sil
	
	'// -- Public Sub'lar --
	
	'## Değerler
	Public Property Get OnbellekZaman()
		OnbellekZaman = fintOnbellekZaman
	End Property
	
	Public Property Let OnbellekZaman(ByVal intYeniDeger)
		fintOnbellekZaman = CInt(intYeniDeger)
	End Property
	
	'-----
	Public Property Get OnbellekAralik()
		OnbellekAralik = fintOnbellekAralik
	End Property
	
	Public Property Let OnbellekAralik(ByVal intYeniDeger)
		fintOnbellekAralik = CInt(intYeniDeger)
	End Property
	
	'---
	
	Public Property Get DosyaAdi()
		OnBellekDosyaAdi = fstrCacheDosyasi
	End Property
	
	Public Property Let OnBellekDosyaAdi(ByVal strYeniDeger)
		fstrCacheDosyasi = CStr(strYeniDeger)
	End Property

End Class

%>