<!--#Include file="dbb.asp"-->
<%
formid=request("form")

Response.AddHeader "content-disposition","attachment; filename="&formid&"-form.XLS"
Response.AddHeader "pragma", "no-store"
Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
Response.ContentType ="application/vnd.ms-excel"
Response.Charset = "UTF-8" 
Response.Codepage = 65001
%>
<table>
<% 	
   
	'gorozel1=" and (id <> 424 and id<>429 and id<>422 and id<>421 and id<>320 and id<>317 and id <> 423 and id <> 312)"

     sqlString = "select * from ozellikler2 where formid='"&formid&"' and ozelikid = '1' and isim = '1' order by id desc "
set mmmYardimci4 = Con.Execute (sqlString)
    
if mmmYardimci4.eof then%>
  <%else
 Do While Not mmmYardimci4.EOF
 fgtur=mmmYardimci4("tur")%>
  

<%if request.QueryString("filtre")="1" then
			for oidddd=0 to oiddadet
if oiddadet=0 then
agacoidd=trim(ozellik)
else
agacoidd=trim(split(ozellik,",")(oidddd))
end if
    
Set mmmYardimci5 = Server.CreateObject("Adodb.Recordset")
sqlString = "select * from ozellikler2 where kateid='"&mmmYardimci4("kateid")&"' and isim = '"&agacoidd&"'"
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
yv=yv+0
yy=yy+1
else
yv=yv+1
yy=yy+0
end if
close(mmmYardimci5)
next
else
yy="0"
end if

yyana=yyana+yy

if yy<>"0" then
e=e+1
else
ifi=ifi+1%>

    <tr>
    <%
if formid="107" then
foid="3313"
 sqlString = "select * from ozellikler2 where ozelikid='"&foid&"' and tur='"&mmmYardimci4("tur")&"' order by id"
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
baslikformid="0"
else
baslikformid=mmmYardimci5("isim")
end if
close(mmmYardimci5)
elseif formid="103" then
foid=mmmYardimci4("kateid")
 sqlString = "select * from yazilar where id="&foid&""
set mmmYardimci5 = Con.Execute (sqlString)
if mmmYardimci5.eof then
baslikformid="0"
else
baslikformid=mmmYardimci5("yazib")
end if
close(mmmYardimci5)
else
baslikformid=mmmYardimci4("id")
end if
stronay=mmmYardimci4("onay")

formcount=formcount+1

	 set mmmYardimci6 = Con.Execute ("select * from ozellikler where formid='"&formid&"'"&gorozel1&" and alt = '1' order by sira")

Do While Not mmmYardimci6.EOF
fname=mmmYardimci6("name")
fisim=mmmYardimci6("isim")
fid=mmmYardimci6("id")
ftur=mmmYardimci6("tur")
formisim=dilformv(fid,fisim,lang)
if ftur=8 then%>

<%
 set mmmYardimci61 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid&"' order by sira")
 if mmmYardimci61.eof then
 response.Write("<td>"&formolustur(fgtur,2,fid,fovalue)&"</td>")
 else
Do While Not mmmYardimci61.EOF
fid1=mmmYardimci61("id")
fisim1=mmmYardimci61("isim")
ftur1=mmmYardimci61("tur")
formisim1=dilformv(fid,fisim,lang)
if ftur1=8 then
%>

<%
 set mmmYardimci62 = Con.Execute ("select * from ozellikler where formid='"&formid&"' and anasek = '"&fid1&"' order by sira")
 if mmmYardimci62.eof then
 response.Write("<td>"&formolustur(fgtur,2,fid1,fovalue)&"</td>")
 else
Do While Not mmmYardimci62.EOF
fid3=mmmYardimci62("id")
ftur3=mmmYardimci62("tur")
response.Write("<td>"&formolustur(fgtur,2,fid3,fovalue)&"</td>")
		fname3=""				  
mmmYardimci62.movenext
loop
end if
close(mmmYardimci62)
%>

<%
else
response.Write("<td>"&formolustur(fgtur,2,fid1,fovalue)&"</td>")
end if

		fname1=""				  
mmmYardimci61.movenext
loop
end if
close(mmmYardimci61)
%>

<%
else
response.Write("<td>"&formolustur(fgtur,2,fid,fovalue)&"</td>")
end if
		fname=""				  
mmmYardimci6.movenext
loop
close(mmmYardimci6)

    
end if
	yv=0
yy=0	
    %>
        </tr>
    <%
mmmYardimci4.movenext
loop
end if

close(mmmYardimci4)
session("uye_kodu1")="1"
%>
    </table>