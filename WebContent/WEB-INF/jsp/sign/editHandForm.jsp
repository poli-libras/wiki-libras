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
	shape_matrix = new Array(); // guarda valor dos enums
	string_matrix = new Array(); // guarda toString dos enums
	// todos
	shape_matrix.push(new Array());
	string_matrix.push(new Array());
	<c:forEach var="shape" items="${shapes}">
		shape_matrix[0].push("${shape}");
		string_matrix[0].push("${shape.string}");
	</c:forEach>	
	// por grupo
	i = 0;
	<c:forEach var="group" items="${shapeGroups}">
		shape_matrix.push(new Array());
		string_matrix.push(new Array());
		i++;
		<c:forEach var="shape" items="${shapesMap[group]}">
			shape_matrix[i].push("${shape}");
			string_matrix[i].push("${shape.string}");
		</c:forEach>		
	</c:forEach>	
</script>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
	<h2>Edição do sinal ${sign.name}</h2>
	
	<h3>Informações sobre a mão</h3>
	
	<fieldset>
		<legend>Símbolo #${signIndex} - 
			<c:if test="${handSide == 'RIGHT'}">
			Mão dominante
			</c:if>
			<c:if test="${handSide == 'LEFT'}">
			Mão não-dominante
			</c:if>
		</legend>
		
		
		<form method="POST" action="editHand">
			
			<div class="option">
			<label for="hand.orientation">Orientação:</label>
			<select name="hand.orientation">
				<option value="WHITE"
					<c:if test="${'WHITE' == hand.orientation}">
						selected="selected"
					</c:if>>Palma para o emissor</option>
				<option value="HALF"
					<c:if test="${'HALF' == hand.orientation}">
						selected="selected"
					</c:if>>Palma de lado</option>
				<option value="BLACK"
					<c:if test="${'BLACK' == hand.orientation}">
						selected="selected"
					</c:if>>Palma contra o emissor</option>
			</select>
			</div>

			<div class="option">
			<label for="hand.rotation">Rotação:</label>
			<select name="hand.rotation">
				<option value="ZERO"
					<c:if test="${'ZERO' == hand.rotation}">
						selected="selected"
					</c:if>>ZERO</option>
				<option value="RETO"
					<c:if test="${'RETO' == hand.rotation}">
						selected="selected"
					</c:if>>RETO</option>
				<option value="RASO"
					<c:if test="${'RASO' == hand.rotation}">
						selected="selected"
					</c:if>>RASO</option>
			</select>
			</div>
		
			<div class="option">
			<label for="hand.plane">Plano:</label>
			<select name="hand.plane">
				<option value="VERTICAL"
					<c:if test="${'VERTICAL' == hand.plane}">
						selected="selected"
					</c:if>>Vertical</option>
				<option value="HORIZONTAL"
					<c:if test="${'HORIZONTAL' == hand.plane}">
						selected="selected"
					</c:if>>Horizontal</option>
			</select>
			</div>
		
			<div class="option">
			<label for="group_shape">Configuração de mão:</label><br/>
			<select name="group_shape" onchange="changeShapeGroup();">
				<option value="TODOS">Todos</option>
				<c:forEach var="group" items="${shapeGroups}">
					<option value="${group}">${group.string}</option>
				</c:forEach>
			</select>
			<select name="hand.shape" onchange="changeShape();">
				<c:forEach var="shape" items="${shapes}">
					<option value="${shape}"
						<c:if test="${shape == hand.shape}">
							selected="selected"
						</c:if>>${shape.string}</option>			
				</c:forEach>
			</select>
			</div>		
			
			<p><c:if test="${hand.shape != null}">
				<img id="shapeImg" alt="configuração de mão" src="${pageContext.request.contextPath}/media/maos/${hand.shape}.JPG">	
			</c:if>
			<c:if test="${hand.shape == null}">
				<img id="shapeImg" alt="configuração de mão" src="${pageContext.request.contextPath}/media/maos/INDICADOR.JPG">	
			</c:if></p>
			
			<div class="option">
			<label for="hand.fingers">Movimento dos dedos:</label>
			<select name="hand.fingers">
				<c:forEach var="finger" items="${fingers}">
					<option value="${finger}"
						<c:if test="${finger == hand.fingers}">
							selected="selected"
						</c:if>>${finger.string}</option>			
				</c:forEach>
			</select>	
			</div>		
		
			<input class="submit" type="submit" value="Avançar"/>
		</form>
		
		<form action="editSymbolForm">
			<input class="submit" type="submit" value="Voltar"/>
		</form>
	</fieldset>
	
	<div class="help">
	    <label>Ajuda</label>
		<p>Com a mão no <i>plano vertical</i> e a <i>palma voltada para o emissor</i>, 
		quem faz o sinal vê a palma da sua mão.</p>
		<p>Com a mão no <i>plano vertical</i> e a <i>palma voltada contra o emissor</i>, 
		o interlocutor vê a palma da mão de quem faz o sinal.</p>
		<p>Com a mão no <i>plano horizontal</i> e a <i>palma voltada para o emissor</i>, 
		a palma está voltada para o teto.</p>
		<p>Com a mão no <i>plano horizontal</i> e a <i>palma voltada contra o emissor</i>, 
		a palma está voltada para o chão.</p>
		<p>O movimento dos dedos é descrito em termos do movimento de suas articulações:
		médias ou proximais</p>
	</div>		
</div>
</body>
</html>