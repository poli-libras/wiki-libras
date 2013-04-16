<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
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

	<h2>Busca por sinal</h2>
	
	<form id="form_busca" action="search" method="POST">
	<fieldset>
    <label for="word">Nome ou palavra correspondente ao sinal:</label>
		<div class="option">
		<input type="text" class="field" name="word"/>
		</div>
		<input type="submit" value="Procurar"/>
	</fieldset>
	</form>

	<form id="form_busca_todos" action="searchAll" method="POST">
		<input type="submit" value="Listar todos sinais"/>
	</form>

</div>
</body>
</html>