<%if ortaktempvar="1" then
else%>
<style>
.row .row3 {
	border: 2px solid #ffffff;
	background: #ebebeb;
	min-height: 35px;
}
.row .row2 {
	border: 3px solid #ffffff;
	padding: 0px;
	min-height: 100px;
	background: #ebebeb;
}
.row .slaytimage {
	width: 100%;
	height: 110px;
	text-align:center;
}
.row .slaytimage .fa{
	padding:20px 10px;
	font-size:36px;
}
.row .buyukresim {
	width: 100%;
	height: 110px;
	text-align:center;
}
.row .buyukresim .fa{
	font-size:36px;
	padding:20px 10px;
}
.row .kucukresim {
	float: left;
	width: 33.3%;
	height: 50px;
	text-align:center;
	padding:5px 5px;
}
.row .kucukresim .fa{
	font-size:26px;
}
.row p {
	font-size: 12px;
	line-height: 13px;
}
.row h3 {
	font-size: 18px;
	font-weight: bold;
}
.input_hidden {
	position: absolute;
	left: -9999px;
}
.selected {
	background-color: #f00;
}
#sites label {
	display: inline-block;
	cursor: pointer;
	float: left;
	padding: 5px;
	width: 100%;
}
#sites1 label:hover {
	background-color: #f00;
}
#sites1 label img {
	padding: 3px;
}

#sites1 label {
	display: inline-block;
	cursor: pointer;
	float: left;
	padding: 5px;
	width: 100%;
}
#sites1 label:hover {
	background-color: #f00;
}
#sites1 label img {
	padding: 3px;
}
</style>
<%end if%>
<%
sl(0)=stemptur1&" "
slu(0)="<textarea name=""temptura1"" class=""normal"">"&stemptur1&"</textarea>"

so(0)=stemptur&" "

so(1)="<div class=col-md-5>#buyukresim##kucukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div>"
so(2)="<div class=col-md-5>#buyukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div><div class=col-md-12>#kucukresim#</div>"
so(3)="<div class=col-md-12>#buyukresim#</div><div class=col-md-12>#baslikisim##yaziisim#</div><div class=col-md-12>#kucukresim#</div>"
so(4)="<div class=col-md-12>#buyukresim#</div><div class=col-md-12>#kucukresim#</div><div class=col-md-12>#baslikisim##yaziisim#</div>"
so(5)="<div class=col-md-12>#baslikisim##buyukresim#</div><div class=col-md-12>#yaziisim#</div><div class=col-md-12>#kucukresim#</div>"
so(6)="<div class=col-md-12>#baslikisim##buyukresim#</div><div class=col-md-12>#kucukresim#</div><div class=col-md-12>#yaziisim#</div>"
so(7)="<div class=col-md-12>#baslikisim##yaziisim#</div><div class=col-md-12>#buyukresim#</div><div class=col-md-12>#kucukresim#</div>"
so(8)="<div class=col-md-12>#baslikisim##yaziisim#</div>"
so(9)="<div class=col-md-12>#baslikisim##slaytresim#</div>"
so(10)="<div class=col-md-12>#baslikisim##buyukresim##kucukresim#</div>"
so(11)="<div class=col-md-4>#slaytresim#</div><div class=col-md-8>#baslikisim##yaziisim#</div>"
so(12)="<div class=col-md-5>#baslikisim##slaytresim#</div><div class=col-md-7>#yaziisim#</div>"
so(13)="<div class=col-md-12>#slaytresim#</div><div class=col-md-12>#baslikisim##yaziisim#</div>"
so(14)="<div class=col-md-12>#baslikisim##slaytresim#</div><div class=col-md-12>#yaziisim#</div>"

sou(0)="<textarea name=""temptur1"" class=""normal"">"&stemptur&"</textarea>"
sou(1)="<div class=""col-md-5 row3"">        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-7 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(2)="<div class=""col-md-5 row3"">        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-7 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(3)="<div class=""col-md-12 row3"">        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(4)="<div class=""col-md-12 row3"">        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(5)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(6)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(7)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>      <div class=""col-md-12 row3"">        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(8)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(9)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <div class=""slaytimage""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(10)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <div class=""buyukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>        <div class=""kucukresim""><i class=""fa fa-file-image-o""></i></div>      </div>"
sou(11)="<div class=""col-md-5 row3"">        <div class=""slaytimage""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-7 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(12)="<div class=""col-md-5 row3"">        <h3>Lorem ipsum</h3>        <div class=""slaytimage""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-7 row3"">        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(13)="<div class=""col-md-12 row3"">        <div class=""slaytimage""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
sou(14)="<div class=""col-md-12 row3"">        <h3>Lorem ipsum</h3>        <div class=""slaytimage""><i class=""fa fa-file-image-o""></i></div>      </div>      <div class=""col-md-12 row3"">        <p>        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut suscipit at diam non eleifend. Ut suscipit maximus convallis. Ut consectetur eu ex a condimentum. Praesent rhoncus non ipsum eget consequat. Aliquam eros est, lacinia non massa vitae, ultricies aliquam purus. Suspendisse quis est aliquam, tempor nisi nec, interdum dui. Ut in cursus sapien. </p>        </p>      </div>"
%>
<%if sayfatemptur="1" then%>
<div class="accordion" id="sites" role="tablist" aria-multiselectable="true">
<%if yetkiuye=1 then%>
 <a class="btn btn-info" role="tab" id="headingTwo" data-toggle="collapse" data-parent="#sites" href="#collapsetwo" aria-expanded="false" aria-controls="collapseOne">
                          <h4 class="panel-title">Ek Şablon <span class="caret"></span></h4>
                        </a>
                        <div id="collapsetwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                          <div class="panel-body">                        
 <div class="row">
<div class="col-md-12 row2">
      <label for="so0" <%if trim(stemptur)=trim(so(0)) then%>class="selected"<%else%><%end if%>>
      <input type="text"  name="tempi" value="<%=replace(so(0),"""","")%>">
      <input name="temptur" type="radio" id="so0" value="0" <%if trim(stemptur)=trim(so(0)) then%>checked="checked"<%else%><%end if%>/>     
            <textarea name="temptur1" id="beautifiedhtml" style="width: 100%; height: 50vh;" class="form-control"><%=replace(replace(stemptur&" ","`","'"),"</textarea>","[/textarea]")%></textarea>
      </label>
            <div class="handle"></div>
    </div>
    </div>
    </div>
     </div>
         <%else%>
         <label for="so0">
      <input type="text"  name="tempi" value="<%=replace(so(0),"""","")%>">
      <input name="temptur" type="radio" id="so0" value="0" <%if trim(stemptur)=trim(so(0)) then%>checked="checked"<%else%><%end if%>/></label>
		 <%end if%>   
           
<%for yuk=1 to 7%>
  <div class="row">
  <%for yuk1=1 to 2
  yuk2=yuk2+1%>
    <div class="col-md-6 row2">
      <label for="so<%=yuk2%>" <%if so(yuk2)=stemptur or stemptur="" and so(yuk2)="<div class=col-md-5>#buyukresim##kucukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div>" then%>class="selected"<%else%><%end if%>>
      <input type="text"  name="tempi" value="<%=so(yuk2)%>">
      <input name="temptur" type="radio" id="so<%=yuk2%>" value="<%=so(yuk2)%>" <%if so(yuk2)=stemptur or stemptur="" and so(yuk2)="<div class=col-md-5>#buyukresim##kucukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div>" then%>checked="checked"<%else%><%end if%>/>
      <%=sou(yuk2)%>
      </label>
    </div>
<%next%>
  </div>
  <%next%>
  </div>
<%elseif sayfatemptur="2" then%>
<div class="content" id="sites1">
 <div class="row">
<div class="col-md-12 row2">
      <label for="sl0" <%if stemptur1=sl(0) then%>class="selected"<%else%>class="selected"<%end if%>>
      <input name="temptura" type="radio" id="sl0" value="0" <%if sl(0)=stemptur1 then%>checked="checked"<%else%>checked="checked"<%end if%>/>
     <%=slu(0)%>
      </label>
    </div>
    </div>
<%for yukl=1 to 0%>
  <div class="row">
  <%for yukl1=1 to 0
  yukl2=yukl2+1%>
    <div class="col-md-6 row2">
      <label for="sl<%=yukl2%>" <%if sl(yukl2)=stemptur1 or stemptur1="" and sl(yukl2)="<div class=col-md-5>#buyukresim##kucukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div>" then%>class="selected"<%else%><%end if%>>
      <input name="temptura" type="radio" id="sl<%=yukl2%>" value="<%=sl(yukl2)%>" <%if sl(yukl2)=stemptur1 or stemptur1="" and sl(yukl2)="<div class=col-md-5>#buyukresim##kucukresim#</div><div class=col-md-7>#baslikisim##yaziisim#</div>" then%>checked="checked"<%else%><%end if%>/>
      <%=slu(yukl2)%>
      </label>
    </div>
<%next%>
  </div>
  <%next%>
  </div>
<%else
end if%>
  <%if request("temptur")="1" then%>
  <div class="col-md-4">#slaytresim#</div>
  <div class="col-md-8">#baslikisim##yaziisim#</div>
  <%elseif request("temptur")="2" then%>
  <div class="col-md-5">#baslikisim##slaytresim#</div>
  <div class="col-md-7">#yaziisim#</div>
  <%elseif request("temptur")="3" then%>
  <div class="col-md-12">#slaytresim#</div>
  <div class="col-md-12">#baslikisim##yaziisim#</div>
  <%elseif request("temptur")="4" then%>
  <div class="col-md-12">#baslikisim##slaytresim#</div>
  <div class="col-md-12">#yaziisim#</div>
  <%elseif request("temptur")="5" then%>
  <div class="col-md-5">#buyukresim##kucukresim#</div>
  <div class="col-md-7">#baslikisim##yaziisim#</div>
  <%elseif request("temptur")="6" then%>
  <div class="col-md-5">#buyukresim#</div>
  <div class="col-md-7">#baslikisim##yaziisim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <%elseif request("temptur")="7" then%>
  <div class="col-md-12">#buyukresim#</div>
  <div class="col-md-12">#baslikisim##yaziisim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <%elseif request("temptur")="8" then%>
  <div class="col-md-12">#buyukresim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <div class="col-md-12">#baslikisim##yaziisim#</div>
  <%elseif request("temptur")="9" then%>
  <div class="col-md-12">#baslikisim##buyukresim#</div>
  <div class="col-md-12">#yaziisim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <%elseif request("temptur")="10" then%>
  <div class="col-md-12">#baslikisim##buyukresim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <div class="col-md-12">#yaziisim#</div>
  <%elseif request("temptur")="11" then%>
  <div class="col-md-12">#baslikisim##yaziisim#</div>
  <div class="col-md-12">#buyukresim#</div>
  <div class="col-md-12">#kucukresim#</div>
  <%elseif request("temptur")="12" then%>
  <div class="col-md-12">#baslikisim##yaziisim#</div>
  <%elseif request("temptur")="13" then%>
  <div class="col-md-12">#baslikisim##slaytresim#</div>
  <%elseif request("temptur")="14" then%>
  <div class="col-md-12">#baslikisim##buyukresim##kucukresim#</div>
  <%else
	   end if%>
<%ortaktempvar="1"%>