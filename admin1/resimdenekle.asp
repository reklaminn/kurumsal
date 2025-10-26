<!--#Include file="admin_menu1.asp"-->
<div class="sayfalar">


<script language="javascript" type="text/javascript">
function klavyesayisal(objEvent) 
	{ var iKeyCode;  	
	  iKeyCode = objEvent.keyCode;			
	  if(iKeyCode>=48 && iKeyCode<=57) return true;
	  return false;	}
</script>

<script language="javascript" type="text/javascript">
function klavyeturkceengelli(objEvent) 
	{
	  var iKeyCode;  	
	  iKeyCode = objEvent.keyCode;			
	  if((iKeyCode>=35 && iKeyCode<=60) || (iKeyCode>=63 && iKeyCode<=128) || (iKeyCode>=31 && iKeyCode<=33)) return true;
	  return false;
	}
	</script>

<table width="100%" border="0">
  <tr>
    <td width="50%" valign="top">
<table width="100%" border="0">
      <tr>
        <td width="10%" height="20">&nbsp;</td>
        <td width="71%">&nbsp;</td>
        </tr>
      <form enctype="multipart/form-data" action="?islem=cssekle0" method="post">
        <tr class="icerik1 icerik">
          <td height="20" class="baslik">Yeni Resim Ekle</td>
          <td><input type="file" size="22" name="blob" />
            <input type="submit" name="button8" id="button8" value="Kaydet" class="button_y button"/>
  </td>
          </tr>
        <tr class="baslik">
          <td height="40">Resimleri Düzenle</td>
          <td>&nbsp;</td>
        </tr>
          </form>
        

      <tr class="icerik1 icerik">
        <td height="20" colspan="2" bgcolor="#EEEEEE">
<% 

set fs=Server.CreateObject("Scripting.FileSystemObject")
if fs.FolderExists(Server.MapPath("../images/eklenecek/")) = true then
else
set f=fs.CreateFolder(Server.MapPath("../images/eklenecek/"))
set f=nothing
end if
set fs=nothing
strListelenecekKlasor = "../images/eklenecek/" 
Set ObjFSO=Server.CreateObject("Scripting.FileSystemObject" ) 
Set strDosyalar=ObjFSO.GetFolder(Server.MapPath(strListelenecekKlasor))
For Each strBulunanDosya in strDosyalar.files 

Response.Write "<div style=""float:left; width:200px; margin-left:5px;""><img src=""../images/eklenecek/"&strBulunanDosya.Name&"""  style=""max-width:140px;"" border=""0"" />"& strBulunanDosya.Name & " ( " & strBulunanDosya.size & " Byte )<a href=""?islem=cssdosyasil&isim="&strBulunanDosya.Name&"&urunid="&cssid&"&filtre="&request("filtre")&""">Sil</a></div>" 

Next 
%>        </td>
        </tr> </table>
</td>
  </tr>
</table>
</div>