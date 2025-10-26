<!--#include file="rate_limit.asp" -->
<%
' ======================
' MariaDB Connection File
' ======================

Const DB_HOST = "127.0.0.1"
Const DB_PORT = "3306"

' ---- Veritabanı 1 ----
Const DB1_NAME = "cloudgrafikeadmin-db1"
Const DB1_USER = "cloudgrafikeadmindb"
Const DB1_PASS = "yg9%43Uq"

' ---- Veritabanı 2 ----
Const DB2_NAME = "turv1-db1"
Const DB2_USER = "turv1db1"
Const DB2_PASS = "Qwe*09@asd1"
'Dedicated pooldan 32 bit i kapat

' ---- Driver (MariaDB Connector/ODBC 3.x) ----
Const DRIVER = "MariaDB ODBC 3.2 Driver"   ' Eğer yoksa: "MySQL ODBC 8.0 ANSI Driver"

' ---- Connection String builder ----
Function BuildConnString(dbName, dbUser, dbPass)
  BuildConnString = _
    "Driver={" & DRIVER & "};" & _
    "Server=" & DB_HOST & ";" & _
    "Port=" & DB_PORT & ";" & _
    "Database=" & dbName & ";" & _
    "User=" & dbUser & ";" & _
    "Password=" & dbPass & ";" & _
    "POOLING=1;" & _
    "CONNECT TIMEOUT=10;" & _
    "STMT=SET NAMES 'latin5';"
End Function

' ---- Bağlantı açıcı ----
Function OpenDb(which)
  Dim cs
  If which = "admin" Then
    cs = BuildConnString(DB1_NAME, DB1_USER, DB1_PASS)
  ElseIf which = "sail" Then
    cs = BuildConnString(DB2_NAME, DB2_USER, DB2_PASS)
  Else
    ' Varsayılan: sail DB
    cs = BuildConnString(DB2_NAME, DB2_USER, DB2_PASS)
  End If

  Dim c : Set c = Server.CreateObject("ADODB.Connection")
  c.CommandTimeout = 120
  On Error Resume Next
  c.Open cs
  If Err.Number <> 0 Then
    Response.Status = "500 Internal Server Error"
    Response.Write "DB baglantisi kurulamadi: " & Err.Description
    Response.End
  End If
  On Error GoTo 0
  Set OpenDb = c
End Function

' ---- Güvenli kapatma helper'ı ----
function close(ByRef obj)
  On Error Resume Next
  If Not obj Is Nothing Then
    If (TypeName(obj) = "Recordset" And obj.State = 1) Then obj.Close
    If (TypeName(obj) = "Connection" And obj.State = 1) Then obj.Close
    Set obj = Nothing
  End If
  On Error GoTo 0
End function

' === Varsayılan bağlantıyı otomatik aç ===
Dim Con
Set Con = OpenDb("")   ' Default: sail DB

Set mmmGenel = Server.CreateObject("Adodb.Recordset")
Set mmmYardimci = Server.CreateObject("Adodb.Recordset")
Set mmmYardimci1 = Server.CreateObject("Adodb.Recordset")
Set mmmYardimci2 = Server.CreateObject("Adodb.Recordset")
Set mmmYardimci3 = Server.CreateObject("Adodb.Recordset")
Set mmmsayfa = Server.CreateObject("Adodb.Recordset")
Set mmmsayfa1 = Server.CreateObject("Adodb.Recordset")
Set mmmsayfa2 = Server.CreateObject("Adodb.Recordset")
Set mmmsayfa3 = Server.CreateObject("Adodb.Recordset")
Set rssitbil = Server.CreateObject("Adodb.Recordset")


sistem_site_turu=""
yoneticilink="dashbord.asp"
webadmin="grafike.site"
webadminlogo="logo_login.png"

	footercreateddate="2024"
	if footercreateddate&""<>""&year(date) then
	footercreateddate=footercreateddate&" - "&year(date)
	end if 
	seosonu=".html"
%>