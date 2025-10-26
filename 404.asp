<!--#Include file="functions/aspJSON1.17.asp"-->
<%
    varmiaspjson="1"
    degisken = Request.QueryString
    gelenlink_bol = split(degisken, "/")
	gelenlink_adet = Ubound(gelenlink_bol)
	if instr(gelenlink_bol(gelenlink_adet),"error.html") then
	    aramakelime=replace(replace(gelenlink_bol(gelenlink_adet),"-"," "),".html","")
        seolinkim="404"&seosonu&""
        aid="404"&seosonu&""
    else
         aid=gelenlink_bol(gelenlink_adet)
         seolinkim=aid
        if gelenlink_adet>3 then
            seoektur=gelenlink_bol(3)
        else
            seoektur=""
        end if
        if instr(seolinkim,".html") then
            if split(seolinkim,".html")(1)<>"" then
                seolinkim=split(seolinkim,".html")(0)&".html"
                aid=split(seolinkim,".html")(0)&".html"
            end if
        else
            if seoektur="" then
            seolinkim=replace(split(degisken,":443")(1),"/","")
            aid=seolinkim
            else
            if gelenlink_adet>4 then
            seolinkim=split(degisken,":443")(1)
            aid=seolinkim
            else
            end if
            end if
        end if

%>
<%end if

    %>
<!--#include file="main.asp"-->