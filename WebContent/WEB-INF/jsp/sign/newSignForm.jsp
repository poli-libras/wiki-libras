<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<script src="${pageContext.request.contextPath}/scripts/sign_form.js" type="text/javascript"></script>
<title>WikiLibras</title>

</head>


<body>

<jsp:include page="/header.jsp"/>

<div class="content">

<h2>Inclusão de sinal</h2>

<c:forEach var="error" items="${errors}">
    ${error.message}<br />
</c:forEach>

<form method="POST" action="newSign">
	<fieldset>

	<div class="option">
		<label for="signname"> Nome do sinal: *</label><br/>
		<input type="text" class="field" name="sign.name" id="signname">
	</div>
		
	<input class="submit" type="submit" value="Avançar"/>
	</fieldset>
</form>

</div>
</body>
</html>