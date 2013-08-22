<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
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

<div class="content">
<h2>Edição do sinal ${sign.name}</h2>

<h3>Informações sobre os símbolos do sinal</h3>

<form method="POST" action="editSymbol">

	<fieldset>
	<legend>Símbolo #${signIndex}</legend>
		<div class="option">
		<label>Locação:</label><br/>
		<select name="location_group" onchange="changeLocGroup();">
			<c:forEach var="group" items="${locationGroups}">
				<option value="${group}">${group}</option>
			</c:forEach>
		</select>
		<select name="symbol.location">
			<c:forEach var="location" items="${locations}">
				<option value="${location}" 
					<c:if test="${location == symbol.location}">
						selected="selected"
					</c:if>>${location}</option>
			</c:forEach>
		</select>
		</div>
		
		<div class="option">
		<label>Ponto de contato:</label>
		<select name="symbol.contact">
			<c:forEach var="contact" items="${contacts}">
				<option value="${contact}"
					<c:if test="${contact == symbol.contact}">
						selected="selected"
					</c:if>>${contact}</option>
			</c:forEach>
		</select>			
		</div>
		
		<div class="option">
		<label>Número de vezes do ponto de contato:</label>
		<select name="symbol.contactQuantity">
			<option value="0"
				<c:if test="${0 == symbol.contactQuantity}">
					selected="selected"
				</c:if>>0</option>
			<option value="1"
				<c:if test="${1 == symbol.contactQuantity}">
					selected="selected"
				</c:if>>1</option>
			<option value="2"
				<c:if test="${2 == symbol.contactQuantity}">
					selected="selected"
				</c:if>>2</option>
			<option value="3"
				<c:if test="${3 == symbol.contactQuantity}">
					selected="selected"
				</c:if>>3</option>		
			<option value="4"
				<c:if test="${4 == symbol.contactQuantity}">
					selected="selected"
				</c:if>>4</option>
		</select>
		</div>

		<div class="option">
		<label>Sinal usa duas mãos:</label>
		<input type="checkbox" 
				<c:if test="${twoHands}">
					checked="checked"
				</c:if> name="twoHands" onclick="twoHandsClicked();"/>
		</div>
		<div class="option">	
		<label>Mãos em unidade:</label>
		<input type="checkbox" 
				<c:if test="${newSign || symbol.handsInUnity}">
					checked="checked"
				</c:if> name="symbol.handsInUnity"/>
		</div>
		<input class="submit" type="submit" value="Avançar"/>
	</fieldset>
	
	<div class="help">
	    <label>Ajuda</label>
		<p>A <i>locação</i> indica a região do corpo próxima da onde as mãos devem ficar para fazer o sinal.</p>
		<p>Se as mãos estiverem <i>em unidade</i> ambas ficarão próxima à locação, caso contrário a
		mão não-dominante ficará no espaço neutro.</p>
		<p>As locações do grupo <i>mão</i> indicam a posição da mão dominante em relação a mão-dominante.</p>
		<p><i>Ponto de contato</i> indica como se dá a interação entre a mão e o ponto de locação.</p>
	</div>	
</form>
</div>
</body>
</html>