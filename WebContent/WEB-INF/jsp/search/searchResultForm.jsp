<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<title>WikiLibras</title>
</head>
<body>

<jsp:include page="/header.jsp"/>

<div class="content">

  <h2>Busca por sinal</h2>

  <h3>Sinais encontrados:</h3>
  
  <c:if test="${found == false}">
  	Nenhum sinal encontrado
  </c:if>
  
  <c:forEach var="sign" items="${signs}">
  	<p><a href="${links[sign]}">${sign}</a></p>
  </c:forEach>
   
  <p><a href="${pageContext.request.contextPath}/search/searchForm">Pesquisar de novo</a></p>
  
</div> 
</body>
</html>