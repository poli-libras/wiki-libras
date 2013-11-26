<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/wikilibras.css" type="text/css">
<title>WikiLibras</title>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
  
  <h2>Edição do sinal ${sign.name}</h2>
  
  <fieldset>
    <legend>Edição de símbolos</legend>
  
    <c:set var="index" scope="request" value="0" />
    <ul>
    <c:forEach var="symbol" items="${symbols}">
    	<c:set var="index" value="${index + 1}" />	
    	<li>Símbolo ${index} - 
    		<a href="${pageContext.request.contextPath}/sign/location?symbol_index=${index}">Editar</a> - 
    		<a href="">Excluir</a></li>
    </c:forEach>
    </ul>
    
    <p><a href="${pageContext.request.contextPath }/sign/location?symbol_index=${index+1}">Novo símbolo</a></p>
    
    <p><a href="${pageContext.request.contextPath }/sign/editSyntaxForm">Voltar para sintaxe</a></p>
    
    <p><a href="${pageContext.request.contextPath }/sign?name=${sign.name}">Finalizar</a></p>
  </fieldset>
</div>
</body>
</html>