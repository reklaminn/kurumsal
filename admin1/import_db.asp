<!--#Include File="admin_menu1.asp"-->
<%
    islem=Request.QueryString("payislem")
    if islem="topluuyereferanskartliekle" then
call topluuyereferanskartliekle  
    else
end if
     sub topluuyereferanskartliekle
    dbuploadreferansgaleri="../images/my_files/"
    server.ScriptTimeout=1000
Set Upload = Server.CreateObject("Persits.Upload.1") 
Upload.CodePage = 65001
  Upload.OverwriteFiles = false
Count = Upload.SaveToMemory 

For Each File in Upload.Files
    
Set File1 = Upload.Files(1)
ressize=File.Size
resw=File.ImageWidth
resh=File.ImageHeight
rest=File.ImageType
dost=File.Ext
resfname=file.Filename
    'resfname=baslikkont(kampanya_sec)
    If File.ImageType="UNKNOWN" then
    tip = replace(replace(resfname,lcase(dost),""),".","")
benzersizid=Replace(Replace(Replace(now,":","")," ",""), "." , "", 1, -1, 1)
fname=""&tip&"-"&benzersizid&""&lcase(dost)&""
    else
tip = replace(replace(resfname,lcase(rest),""),".","")
benzersizid=Replace(Replace(Replace(now,":","")," ",""), "." , "", 1, -1, 1)
fname=""&tip&"-"&benzersizid&"."&lcase(rest)&""
    end if
Path = (Server.MapPath(""&dbuploadreferansgaleri&""&fname&""))
File.SaveAs Path
    
lkj=lkj+1

if dost=".xls" or dost=".xlsx" or dost=".XLS" or dost=".XLSX" or dost=".txt" or dost=".TXT" or dost=".csv" or dost=".CSV" or dost=".xml" or dost=".XML" then

ixls = 0
  Dim MyArray
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(Server.MapPath(""&dbuploadreferansgaleri&""&fname&"")) Then
    Set objStream = fso.OpenTextFile(Server.MapPath(""&dbuploadreferansgaleri&""&fname&""), 1, False, 0)

Do While Not objStream.AtEndOfStream
    strLine = objStream.ReadLine
    'response.Write strLine
       ReDim MyArray(0)
    MyArray = Split(strLine, ";")
    myraycount=ubound(MyArray)
    if upload.form("edt")="0" then
    'kategori eklemesi

    elseif upload.form("edt")="1" then
    'yazı eklemesi
    'yazisablon
    id=MyArray(0)
   	kategori=MyArray(1)
   	urunid=MyArray(2)
   	bilgi1=MyArray(3)
   	bilgi2=MyArray(4)
   	bilgi3=MyArray(5)
   	bilgi4=MyArray(6)
   	yazi=csskont(replace(MyArray(7),"[/]",";"))
   	durum=MyArray(8)
   	ilksayfa=MyArray(9)
   	form=MyArray(10)
   	yazib=csskont(replace(MyArray(11),"[/]",";"))
   	yazib1=yazib
   	seolink=baslikkont(yazib1)&".html"
   	dil=MyArray(12)
   	bagli=MyArray(13)
   	sira1=MyArray(14)
   	tarih=MyArray(15)
   	gtarih=MyArray(16)
   	modulmu=MyArray(17)
   	link=MyArray(18)
   	target=MyArray(19)
   	oku=MyArray(20)
    if upload.form("evb")="3" then
    sqlString = "select * from "&dbhhaber&" where ajanshid='"&id&"'"
    sqlstringg="insert "&dbhhaber&" set mansetb='"&yazib&"', habert='"&yazi&"', gtarih='"&gtarih&"', tarih='"&tarih&"', oku='"&oku&"', seolink='"&seolink&"', manset='1', durum='1', resid='0', etkinlikbuton='0', sond='0', editor='0', urunid='100', resimid='resimyok.jpg', ajanshid='"&id&"'"
    else
    end if
set mmmGenel=con.execute(sqlString)
if mmmGenel.eof then
     Con.execute(sqlstringg)
    else
    end if
    close(mmmGenel)

    elseif upload.form("edt")="2" then
    'resim eklemesi
    'resimdsablon
    fid=MyArray(0)
   	resimid=MyArray(1)
   	ressize=MyArray(2)
   	resad=MyArray(3)
   	typee=MyArray(4)
   	dosyad=MyArray(5)
   	firma=MyArray(6)
   	tur=MyArray(7)
   	baslik=MyArray(8)
   	tarih=MyArray(9)
   	link=MyArray(10)
   	acik=MyArray(11)
    if upload.form("evb")="3" then
    set mmmGenel=con.execute("select * from "&dbhhaber&" where ajanshid='"&baslik&"'")
    if mmmGenel.eof then
    else
    haberid=mmmGenel("id")
    end if
    close(mmmGenel)
    sqlString = "select * from "&dbhhaberresim&" where resid='"&fid&"'"
    sqlstringg="insert "&dbhhaberresim&" set tarih='"&tarih&"', resimid='"&resimid&"', haberid='"& haberid&"', width='0', ilk='"&tur&"', resid='"&fid&"'"
    else
    end if

    set mmmGenel=con.execute(sqlString)
    if mmmGenel.eof then
    Con.execute(sqlstringg)
    else
    end if
    close(mmmGenel)

    end if


     ixls = ixls + 1
    if ixls=15000 or ixls=30000 or ixls=45000 or ixls=60000 or ixls=75000 or ixls=90000 or ixls=105000 then
    response.Flush
    end if
Loop
        else
    end if
    set fs=nothing

    Set fso1 = CreateObject("Scripting.FileSystemObject")
    If fso1.FileExists(Server.MapPath(""&dbuploadreferansgaleri&""&fname&"")) Then
    'fso1.DeleteFile(Server.MapPath(""&dbuploadreferansgaleri&""&fname&""))
    else
    end if
    set fs1=nothing
    end if
fname=""
Next
    call islemmessagesession("green","Referanslar Eklendi","1")

    end sub
    ukislemlink="?paysayfagit=uyeler&campid="&campid&"&payislem=topluuyereferanskartliekle"
    
    

    %>
<div class="right_col" role="main">

  <div class="x_panel">
        <div class="x_title">
            <h2>Import</h2>            
            <div class="clearfix"></div>
        </div>
 <FORM  name="uyekayitForm" id="uyekayitForm" enctype="multipart/form-data" action="<%=ukislemlink%>" method="post">
    
      
      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <label for="email" class="custom-label" required="required" aria-required="true"> Eklenecek Vb </label>
          </div>
        </div>
        </div>
      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
           <label><input type="radio" name="evb" value="0" checked /> Sayfa</label> <label><input type="radio" name="evb" value="1" /> Yazı</label> <label><input type="radio" name="evb" value="2" /> Resim</label> <label><input type="radio" name="evb" value="3" /> Haber</label>
          </div>
        </div>
        </div>

      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <label for="email" class="custom-label" required="required" aria-required="true"> Vb Ek Özellik </label>
          </div>
        </div>
        </div>
      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
           <label><input type="text" name="vbek" value="" /> </label>
          </div>
        </div>
        </div>

      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <label for="email" class="custom-label" required="required" aria-required="true"> Excel Dosya Türü </label>
          </div>
        </div>
        </div>
      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
           <label><input type="radio" name="edt" value="0" checked /> Sayfa</label> <label><input type="radio" name="edt" value="1" /> Yazı</label> <label><input type="radio" name="edt" value="2" /> Resim</label>
          </div>
        </div>
        </div>
      <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <label for="email" class="custom-label" required="required" aria-required="true"> Katılımcı Dosyası </label>
            <input id="File3" type="file" name="dosya" />
          </div>
        </div>
        </div>
          <div class="form-group">
        <div class="col-md-12 col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <label for="title" class="custom-label" required="required" aria-required="true"> .csv (Virgül ile ayrılmış) Formatında Yükleme Yapınız. </label>
          </div>
        </div>
      </div>
        
      <div class="form-group">
        <div class="col-xs-12 padding-right-10">
          <div class="custom-placeholder">
            <input type="submit" name="Submit" value="Kaydet" class="btn btn-success pull-right">
          </div>
        </div>
      </div>
        </FORM>

    </div>
</div>
<%call footer(1)%>