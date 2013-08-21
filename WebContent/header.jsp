<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="header">  
	<h1 class="headertext">Wiki-Libras</h1>
	
	<div id="menu">
		<a href="${ pageContext.request.contextPath }/index.jsp">Início</a> 
		<a href="${ pageContext.request.contextPath }/search/searchForm">Pesquisar sinal</a> 
		<a href="${ pageContext.request.contextPath }/sign/newSignForm">Incluir sinal</a> 
		<a href="${ pageContext.request.contextPath }/sign/editSignForm">Alterar sinal</a> 
		<a href="${ pageContext.request.contextPath }/ws.jsp">Web Services</a> 
		<a href="${ pageContext.request.contextPath }/about.jsp">Sobre</a>
	</div>
</div>
