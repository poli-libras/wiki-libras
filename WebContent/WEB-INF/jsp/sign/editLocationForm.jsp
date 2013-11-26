<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/locations.css" type="text/css">
<script src="${pageContext.request.contextPath}/scripts/locations.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/sign_form.js" type="text/javascript"></script>
<title>WikiLibras</title>

<!-- cria vetores javascript dinâmicamente 
	(na verdade, transfere o shapesMap e o locationsMap para o javascript;
	e é isso mesmo: JSTL gerando javascript, uhul!) -->
<script type="text/javascript">
	loc_matrix = new Array();
	i = -1;
	<c:forEach var="group" items="${locationGroups}">
		loc_matrix.push(new Array());
		i++;
		<c:forEach var="loc" items="${locationsMap[group]}">
			loc_matrix[i].push("${loc}");
		</c:forEach>		
	</c:forEach>	
</script>
</head>
<body>

<jsp:include page="/header.jsp"/>

<div class="conteudo" id="passo_2">
	<h2>Edição do sinal ${sign.name}</h2>
	
	<h3>Informações da locação da mão ${handSide.string} do símbolo ${symbolIndex}</h3>
	
	<form method="POST" action="editSymbol" target="_top">
	
		<fieldset>
		
			<div class="option">
				<span class="nomeCampo">Selecione a localização: </span>
				<span id="location_label" class="nomeCampo">Espaço Neutro</span>
				<input id="location_value" type="hidden" name="symbol.location" value="espaco_neutro"/>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
				<center>
					<div id="container_menino">
						<img class="fundo" src="${ pageContext.request.contextPath }/media/localizacoes/localizacao0.png"/>
						
						<c:forEach var="location" items="${locations}">
							<img class="location_img" id="${location.filename}_img" src="${ pageContext.request.contextPath }/media/localizacoes/${location.filename}.png"/>
			    			<!-- TODO: Acender locação atual
				    			<c:if test="${type == handMovement.type}">
									selected="selected"
								</c:if>>${type}</option> 
							-->
			    		</c:forEach>
						
						<c:forEach var="location" items="${locations}">
							<div class="location" id="${location.filename}" name="${location.string}"></div>
			    		</c:forEach>
						
					</div>
				</center>
			</div>
			
		</fieldset>
		
		<jsp:include page="/progresso.jsp"/>
		
	</form>
	
	<jsp:include page="/ajuda.jsp"/>
</div>
</body>
</html>