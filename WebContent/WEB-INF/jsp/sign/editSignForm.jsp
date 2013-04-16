<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/wikilibras/css/wikilibras.css" type="text/css">
<title>WikiLibras</title>

</head>


<body>

<jsp:include page="/header.jsp"/>

<div class="content">
  
  <h2>Edição de sinal</h2>
  
  <c:forEach var="error" items="${errors}">
    ${error.message}<br />
  </c:forEach>
  
  <form method="POST" action="/wikilibras/editSign">
    <fieldset>
  
      <div class="option">
      	<label>Nome do sinal: *</label> <br/>
      	<input class="field" type="text" name="signName">
      </div>
      
      <input class="submit" type="submit" value="Avançar"/>
    </fieldset>      	
  </form>
</div>
</body>
</html>