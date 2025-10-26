<%
' ====================== Rate Limiter (Classic ASP) ======================

ip=Request.ServerVariables("REMOTE_ADDR")

' ---- Ayarlar ----
Const MAX_REQUESTS = 50          ' pencere başına izin verilen istek
Const TIME_WINDOW  = 60          ' saniye
Const GC_EVERY_N   = 200         ' her N istekte bir temizlik
Const STALE_SECS   = 600         ' 10 dk dokunulmayan anahtarları temizle
Const USE_PER_PATH = True        ' IP + URL kombinasyonu bazlı limit (False = sadece IP)

' ---- Whitelist (gerekirse IP ekleyin) ----
Function IsWhitelisted(ip)
  Select Case ip
    Case "127.0.0.1" : IsWhitelisted = True
    Case Else        : IsWhitelisted = False
  End Select
End Function

' ---- Gerçek istemci IP (X-Forwarded-For öncelikli) ----
Function ClientIP()
  Dim xff, ip
  xff = Trim(Request.ServerVariables("HTTP_X_FORWARDED_FOR"))
  If Len(xff) > 0 Then
    If InStr(xff, ",") > 0 Then
      ip = Trim(Split(xff, ",")(0))
    Else
      ip = xff
    End If
  Else
    ip = Request.ServerVariables("REMOTE_ADDR")
  End If
  ClientIP = ip
End Function

' ---- Anahtar (IP veya IP|URL) ----
Function RateKey()
  If USE_PER_PATH Then
    RateKey = LCase(ClientIP() & "|" & Request.ServerVariables("URL"))
  Else
    RateKey = ClientIP()
  End If
End Function

Sub CheckRequestRate()
  Dim key, nowSec, locked : locked = False
  Dim ip : ip = ClientIP()
  If IsWhitelisted(ip) Then Exit Sub

  key    = RateKey()
  nowSec = DateDiff("s", "01/01/1970 00:00:00", Now())

  On Error Resume Next
  Application.Lock : locked = True

  ' Depo: tek Scripting.Dictionary içinde tut
  Dim store
  If Not IsObject(Application("rl_store")) Then
    Set Application("rl_store") = Server.CreateObject("Scripting.Dictionary")
  End If
  Set store = Application("rl_store")

  ' Global hit sayacı (GC tetiklemek için)
  If IsEmpty(Application("rl_hits")) Then Application("rl_hits") = 0
  Application("rl_hits") = CLng(Application("rl_hits")) + 1

  ' Kayıt formatı: count|windowStart|lastSeen  (hepsi epoch saniye)
  Dim rec, parts, count, winStart, lastSeen
  If store.Exists(key) Then
    parts    = Split(CStr(store.Item(key)), "|")
    count    = CLng(parts(0))
    winStart = CLng(parts(1))
    lastSeen = CLng(parts(2))

    If (nowSec - winStart) <= TIME_WINDOW Then
      count = count + 1
    Else
      count = 1
      winStart = nowSec
    End If
    lastSeen = nowSec
    store.Item(key) = CStr(count) & "|" & CStr(winStart) & "|" & CStr(lastSeen)
  Else
    store.Add key, "1|" & CStr(nowSec) & "|" & CStr(nowSec)
    count = 1
    winStart = nowSec
  End If

  ' Basit GC: her GC_EVERY_N istekte bayat kayıtları sil
  If (CLng(Application("rl_hits")) Mod GC_EVERY_N) = 0 Then
    Dim k, p, ls
    For Each k In store.Keys
      p  = Split(CStr(store.Item(k)), "|")
      ls = CLng(p(2))
      If (nowSec - ls) > STALE_SECS Then store.Remove k
    Next
  End If

  Set store = Nothing
  If locked Then Application.UnLock
  On Error GoTo 0

  ' Limit aşıldıysa 429 dön
  If count > MAX_REQUESTS Then
    Response.Status = "429 Too Many Requests"
    Response.AddHeader "Retry-After", CStr(TIME_WINDOW)
    Response.Write "Too many requests. Try again in " & TIME_WINDOW & "s."
    Response.End
  End If
End Sub

' ---- Her isteğin başında çağır ----
Call CheckRequestRate()
' =======================================================================
%>
