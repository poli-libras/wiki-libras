<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/header.css" type="text/css">

<script type="text/javascript">
	$(document).bind("pageinit", function ()
	{
		$("#header a").each(function ()
		{
			if (document.URL == this.href)
			{
				$(this).removeClass("btHeader");
				$(this).addClass("btHeaderSelecionado");
			}
		});
	});
</script>

<div id="header">  
	<img src="${ pageContext.request.contextPath }/media/images/banner.png"></img>
	
	<div id="header_menu">
		<a target="_top" id="btInicio" class="btHeader" href="${ pageContext.request.contextPath }/"></a>
		<a target="_top" id="btPesquisar" class="btHeader" href="${ pageContext.request.contextPath }/search/searchForm"></a>
		<a target="_top" id="btIncluir" class="btHeader" href="${ pageContext.request.contextPath }/sign/newSignForm"></a>
		<a target="_top" id="btAlterar" class="btHeader" href="${ pageContext.request.contextPath }/sign/editSignForm"></a>
		<a target="_top" id="btServices" class="btHeader" href="${ pageContext.request.contextPath }/ws.jsp"></a>
		<a target="_top" id="btSobre" class="btHeader" href="${ pageContext.request.contextPath }/about.jsp"></a>
	</div>
	
	<img src="${ pageContext.request.contextPath }/media/images/banner2.png"></img>
</div>
