<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tabs.css" type="text/css">
<title>WikiLibras</title>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
<h2>${string}</h2>
</div>
</body>
</html>