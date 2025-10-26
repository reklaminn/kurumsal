<%
' session.asp — sliding expiration keep-alive + durum raporu
' Yanıt: {"expired":true|false,"extended":true|false,"nextExpiryUtc":"2025-08-24T08:30:00Z"}

Option Explicit
Response.ContentType = "application/json"
Response.Expires = -1
Response.CacheControl = "no-store"
Response.AddHeader "Pragma", "no-cache"

Dim domaini : domaini = Replace(Replace(Request.ServerVariables("Server_Name"),".",""),"-","")
Dim sessionDuration : sessionDuration = 120 ' dakika

Dim cUser, cSecure
cUser   = Request.Cookies("remember" & domaini & "rinn4")
cSecure = Request.Cookies("remember" & domaini & "rinnsecure")

' === yardımcılar ===
Function JsonBool(b) : If b Then JsonBool = "true" Else JsonBool = "false" End If : End Function
Function ToIsoUtc(dt)
  ' Sunucuda yerel saat olabilir; basitçe Zulu biçimi üretelim (saniye hassasiyetinde).
  Dim y,m,d,hh,nn,ss
  y = Year(dt): m = Right("0" & Month(dt),2): d = Right("0" & Day(dt),2)
  hh = Right("0" & Hour(dt),2): nn = Right("0" & Minute(dt),2): ss = Right("0" & Second(dt),2)
  ToIsoUtc = y & "-" & m & "-" & d & "T" & hh & ":" & nn & ":" & ss & "Z"
End Function

If (cUser = "") Or (cSecure = "") Then
  ' çerez(ler) yok → expired
  ' (İstersen burada Session.Abandon yapma; login akışında yap)
  Response.Write "{""expired"":true,""extended"":false,""nextExpiryUtc"":null}"
  Response.End
End If

' === çerezleri her ping'de ileri al (sliding) ===
Dim nextExp : nextExp = DateAdd("n", sessionDuration, Now())

Response.Cookies("remember" & domaini & "rinn4")       = cUser
Response.Cookies("remember" & domaini & "rinn4").Expires       = nextExp
Response.Cookies("remember" & domaini & "rinnsecure")  = "1"
Response.Cookies("remember" & domaini & "rinnsecure").Expires  = nextExp
Response.Cookies("remember" & domaini & "rinn3")       = "1"
Response.Cookies("remember" & domaini & "rinn3").Expires       = nextExp

' Güvenlik için mümkünse IIS/Classic ASP tarafında bu çerezleri HttpOnly/Secure/SameSite olarak ayarlayın.

' === durum dön ===
Response.Write "{""expired"":false,""extended"":true,""nextExpiryUtc"":""" & ToIsoUtc(nextExp) & """}"
%>
