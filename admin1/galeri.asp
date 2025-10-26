
<!--#Include file="admin_menu1.asp"-->

<%Response.Buffer=True %>
<%Server.ScriptTimeout=10000 %>

<div class="right_col" role="main">
<div class="x_panel">
<div class="x_title"><h2>Resim Ekle & Düzenle</h2>&nbsp;&nbsp;
  <a href="ortak_sayfalar_ayar.asp?dkate2=<%=replace(request.QueryString("dataurl"),"//-//","&")%>&sayfaayar=modul" class="btn btn-dark dropdown-toggle btn-xs" data-fancybox-type="iframe" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bu Sayfanın veya Alt Sayfaların Yerleşim Ayarları İçin."><em class="fa fa-th-large" style="font-size:11px;"></em></a>
<div class="clearfix"></div></div>

     <%fldr="galeri"
      glrurl="galeri.asp?sek="&request.QueryString("sek")&"&sayi="&Sayilar&"&dkate2="&request.QueryString("dkate2")&"&baslik="&request.QueryString("baslik")&"&tur="&request("urunid")+0&"&modul="&request("modul")&"&modulv="&request("modulv")&"&yazi="&request("yazi")&"&islem=resimekle"
    %>
<%call glradd(fldr,glrurl) %>

<hr>
<%

Set mmmYardimci = Server.CreateObject("ADODB.Recordset")
sqlString = "select * from resimd where baslik='"&request.QueryString("baslik")&"' order by firma, fid"
mmmYardimci.ActiveConnection = Con
mmmYardimci.Open sqlString,Con,1,3
%>
  <%if mmmYardimci.eof then%>

  <%else%>

                     <form name="custlist" method="post"  action="galeri.asp?baslik=<%=request.QueryString("baslik")%>&dkate2=<%=request.QueryString("dkate2")%>&tur=<%=mmmYardimci("fid")%>">
                      
  <div class="pull-right" style="height: 34px;padding: 7px 7px 7px 7px; background:#ebebeb; border:1px solid #d9534f; border-radius: 3px;" data-toggle="tooltip" data-placement="top" title="" data-original-title="Hepsini Seç">
            <input type="checkbox" name="resimid1" class="flatred" id="checkAll">
      </div>                       
<input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("baslik")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil');">

      <input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("baslik")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=resimDuzenle');">
<div style="clear:both; float:none;"></div>
<div class="sortpage">
    <ol class="ui-sortable1 vertical">
   <%
   Set mmmGenel = Server.CreateObject("ADODB.Recordset")
sqlString = "select * from resimd where baslik='"&request.QueryString("baslik")&"' order by firma, fid"
mmmGenel.ActiveConnection = Con
mmmGenel.Open sqlString,Con,1,3
Do While Not mmmGenel.EOF
iks=iks+1
%>
<li class="ui-state-default">
       <%if right(iks,1)=1 or right(iks,1)=3 or right(iks,1)=5 or right(iks,1)=7 or right(iks,1)=9 then%>
        <%collor="1"%>
        <%else%>
        <%collor="2"%>
        <%end if%>
        <div class="icerik<%=collor%> icerik">
<div class="col-md-12 galerigrid">

                          <div class="col-md-2">
                          <div class="row">
                          <div class="col-sm-2"><span class="handle ui-sortable-handle">
                        <i class="fa fa-arrows"></i>
                      </span></div>
                          <div class="image view view-first col-md-5" align="center" <%if mmmGenel("tur")=1 then%>style="border-left:3px solid #c00;border-right:3px solid #c00; width:auto;"<%else%><%end if%>>
                            <img height="40px" style="display: block;" src="<%=imgyol%><%=mmmGenel("dosyad")%>" alt="<%=mmmGenel("resad")%>" />
                            </div>
                            </div>
                          </div>
                          <div class="col-md-9">
                          <div class="row">
                          <div class="col-md-3">
                            <p><input name="ad2" type="text" id="ad2" value="<%=mmmGenel("resad")%>" class="form-control" placeholder="Resim Adi"></p></div>
                            <div class="col-md-4"> 
                                <div class="input-group">
	  <input class="form-control" id="fieldID<%=iks %>" aria-multiselectable="true" type="text" name="link" value="<%=mmmGenel("link")%>" placeholder="Harici Link">
      <div class="input-group-btn">
         <a data-toggle="modal" href="#" data-href="<%=cdntinyfldr %>admin/tinymce/filemanager/dialog.php?type=2&field_id=fieldID<%=iks %>&multiple=0<%=cdncross %>" data-target="#myModal" class="btn btn-warning iframe-btn" type="button">Dosya Seç</a>
          </div>
	</div>
<style>
    .modal-dialog {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

.modal-content {
  height: auto;
  min-height: 100%;
  border-radius: 0;
}
</style>
      <div class="modal fade" id="myModal">
<div class="modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"></h4>
    </div>
    
    <div class="modal-body" style="padding:0px; margin:0px; width: 100%;">
      <iframe width="100%" height="500" src="" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>
    </div>
  </div><!-- /.modal-content&fldr=/ceimages/flayers/file -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

                            </div>
                            <div class="col-md-5">
                            <p><textarea name="acik" id="acik" rows="1" class="form-control" placeholder="Kisa A&ccedil;iklama"><%=mmmGenel("acik")%></textarea></p>
                            </div>
                            </div>
                          </div>
                          <div class="col-md-1 tools tools-bottom">
          
                                <%if mmmGenel("tur")=0 then%>
        <a href="galeri.asp?islem=resimonay&baslik=<%=request.QueryString("baslik")%>&id=<%=mmmGenel("fid")%>&ilk=1&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-success pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="İlk Resim Değil"><i class="fab fa-star" style="font-size:11px;"></i></a>
        <%else%>
  <a href="galeri.asp?islem=resimonay&baslik=<%=request.QueryString("baslik")%>&id=<%=mmmGenel("fid")%>&ilk=0&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-success pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="İlk Resim"><i class="fa fa-star" style="font-size:11px;"></i></a>
  <%end if%>     
       <%if mmmGenel("type")=1 then%>
     <a href="galeri.asp?islem=resimonay2&baslik=<%=request.QueryString("baslik")%>&id=<%=mmmGenel("fid")%>&ilk=0&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-primary pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="Büyük Resim"><i class="fa fa-toggle-on" style="font-size:11px;"></i></a>
        <%else%>
 <a href="galeri.asp?islem=resimonay2&baslik=<%=request.QueryString("baslik")%>&id=<%=mmmGenel("fid")%>&ilk=1&dkate2=<%=request.QueryString("dkate2")%>" class="btn btn-primary pull-left btn-xs" data-toggle="tooltip" data-placement="top" title="" data-original-title="Büyük Resim Değil"><i class="fa fa-toggle-off" style="font-size:11px;"></i></a>
  <%end if%>
  <input name="rid" type="hidden" id="resimid" value="<%=mmmGenel("fid")%>" />
  
        <div class="pull-right" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sil">
            <input type="checkbox" name="resimid" class="flatred" id="resimid<%=iks%>" value="<%=mmmGenel("fid")%>">
      </div>
                           
                            </div>
                        </div>
                      </div>
                      </li>
  <%mmmGenel.MoveNext
  loop
  %>
  </ol>
  </div>
   <div style="clear:left;"></div> <hr />
<input name="Submit" type="submit" id="Submit" value="Sil" class="btn btn-danger pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("baslik")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil');">
                          <%if yetkiuye="1" then %>
 <input name="Submit" type="submit" id="Submit" value="Tam Sil" class="btn btn-danger pull-left" ONCLICK="this.form.submit(); formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("baslik")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=Resimsil&resimdosyasil=1');">
                         <%end if %>
<input name="Submit" type="submit" id="Submit" value="Düzenle" class="btn btn-info pull-right" ONCLICK="this.form.submit();formla('?usayi=<%=request("usayi")%>&filtre=<%=request("filtre")%>&sira=<%=request("sira")%>&dkate2=<% =dkate2%>&baslik=<%=request.QueryString("baslik")%>&sek=<% =dkate2%>&git=<%=request("git")%>&Submit=resimDuzenle');">
<% 
   close(mmmGenel)
  %>

                       </form>
<SCRIPT LANGUAGE="JavaScript">

	function formla(gelen)
	{
	document.custlist.action=gelen;
	document.custlist.submit();
	}
  //-->
  </SCRIPT>
                     
 <% end if
  close(mmmYardimci)
  %>

</div>

</div>

<%call footer(1)%><script>
      $(document).ready(function() {
  $(".iframe-btn").click(function(e) {
    e.preventDefault();
    var url = $(this).attr("data-href");
    $("#myModal iframe").attr("src", url);
  });
});
Dropzone.options.myAwesomeDropzone = { // The camelized version of the ID of the form element

    // The configuration we've talked about above
    autoProcessQueue: false,
    uploadMultiple: true,
    parallelUploads: 10,
    maxFiles: 10,
	addRemoveLinks: true,

    // The setting up of the dropzone
    init: function() {
        var myDropzone = this;

        // Here's the change from enyo's tutorial...

        $("#submit-all").click(function (e) {
            e.preventDefault();
            e.stopPropagation();
            myDropzone.processQueue();
			
        }); 
		this.on("sendingmultiple", function() {
      // Gets triggered when the form is actually being sent.
      // Hide the success button or the complete form.
    });
		this.on("successmultiple", function(files, response) {
      // Gets triggered when the files have successfully been sent.
      // Redirect user or notify of success.
	 <% if request.QueryString("yazi")="yeni" then%>
	  window.location.href = "sayfalar.asp?dkate2=<%=request.QueryString("dkate2")%>&sek=<%=request.QueryString("sek")%>&git=<%=request.QueryString("git")%>";
	  <%else%>
	  window.location.href = "galeri.asp?sek=<%=request.QueryString("sek")%>&sayi=<%=Sayilar%>&dkate2=<%=request.QueryString("dkate2")%>&baslik=<%=request.QueryString("baslik")%>&tur=<%=request("urunid")+0%>&modul=<%=request("modul")%>&modulv=<%=request("modulv")%>&yazi=<%=request("yazi")%>";
	  <%end if%>
    });
	this.on("errormultiple", function(files, response) {
      // Gets triggered when there was an error sending the files.
      // Maybe show form again, and notify user of error
    });
    }
}
</script>

        <script>
	var oldContainer;
$("ol.ui-sortable1").sortable({
  group: 'nested', 
  handle: 'i.fa-arrows',  
  onDragStart: function ($item, container, _super) { //2015.08.16 update for jquery sortable v0.9.13
			// Duplicate items of the no drop area
			if(!container.options.drop) {
				$item.clone(true).insertAfter($item);
			}
			_super($item, container);
		},
  onDrop: function ($item, container, _super) {
    container.el.removeClass("active");
    _super($item, container);
  }
});


    
function responsive_filemanager_callback(field_id){ 

    var url=jQuery('#'+field_id).val();
    console.log(url);
    var myarray = url.split('","');

for (var i = 0; i < myarray.length; i++) {
var arrystr=myarray[i].replace('["','').replace('"]','')
    if (arrystr) {
    $("#dropzonePreview7").append("<div class='dz-preview dz-image-preview'><div class='dz-image'><img data-dz-thumbnail='' src='<%=imgyol %>" + arrystr + "'></div><div class='dz-details'><input type='hidden' name='fileimg' value='" + arrystr + "'><div class='dz-filename'><span data-dz-name=''>" + arrystr + "</span></div></div></div>");
    }

}

}

</script>
