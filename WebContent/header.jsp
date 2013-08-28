<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/header.css" type="text/css">

<script type="text/javascript">
	$(document).bind("pageinit", function ()
	{
		$("#header a").each(function ()
		{
			console.log(document.URL);
			console.log(this.href);
			if (document.URL == this.href)
			{
				$(this).children().css("display", "block");
			}
		});
	});
</script>

<div id="header">  
	<img src="${ pageContext.request.contextPath }/media/images/banner.png"></img>
	
	<div id="header_menu">
		<a target="_top" id="btInicio"  href="${ pageContext.request.contextPath }/index.jsp">
			<img src="${ pageContext.request.contextPath }/media/images/btInicio_clicado.png"></img>
		</a>
		<a target="_top" id="btPesquisar" href="${ pageContext.request.contextPath }/search/searchForm">
			<img src="${ pageContext.request.contextPath }/media/images/btPesquisar_clicado.png"></img>
		</a>
		<a target="_top" id="btIncluir" href="${ pageContext.request.contextPath }/sign/newSignForm">
			<img src="${ pageContext.request.contextPath }/media/images/btIncluir_clicado.png"></img>
		</a>
		<a target="_top" id="btAlterar" href="${ pageContext.request.contextPath }/sign/editSignForm">
			<img src="${ pageContext.request.contextPath }/media/images/btAlterar_clicado.png"></img>
		</a>
		<a target="_top" id="btServices" href="${ pageContext.request.contextPath }/ws.jsp">
			<img src="${ pageContext.request.contextPath }/media/images/btServices_clicado.png"></img>
		</a>
		<a target="_top" id="btSobre" href="${ pageContext.request.contextPath }/about.jsp">
			<img src="${ pageContext.request.contextPath }/media/images/btSobre_clicado.png"></img>
		</a>
	</div>
	
	<img src="${ pageContext.request.contextPath }/media/images/banner2.png"></img>
</div>
