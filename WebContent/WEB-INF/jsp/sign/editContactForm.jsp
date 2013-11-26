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

<div class="conteudo" id="passo_2">
	<h2>Edição do sinal ${sign.name}</h2>
	
	<h3><b>Passo 2: </b>Informações a locação da mão</h3>
	
	<form method="POST" action="editSymbol">
	
		<fieldset>
		
			<div class="option">
				<span class="nomeCampo">Selecione a localização: </span>
				<span class="nomeCampo">Espaço Neutro</span>
				<input type="hidden" name="symbol.location" value="Espaço Neutro"/>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
				<p><center><img src="${ pageContext.request.contextPath }/media/localizacoes/localizacao0.png"></img></center></p>
			</div>
			
			<div class="option">
				<label>Tipo de contato:&nbsp&nbsp&nbsp</label>
				<select name="symbol.contact">
					<c:forEach var="contact" items="${contacts}">
						<option value="${contact}"
							<c:if test="${contact == symbol.contact}">
								selected="selected"
							</c:if>>${contact}</option>
					</c:forEach>
				</select>		
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>	
			</div>
			
			<div class="option">
				<label>Número de vezes do ponto de contato:&nbsp&nbsp&nbsp</label>
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
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
			</div>
			
			<div class="option">
				<label>Sinal usa duas mãos:&nbsp&nbsp&nbsp</label>
				<input type="checkbox" 
				<c:if test="${twoHands}">
					checked="checked"
				</c:if> name="twoHands" onclick="twoHandsClicked();"/>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
			</div>
			
			<div class="option">
				<label>Sinal possui ponto de contato:&nbsp&nbsp&nbsp</label>
				<input type="checkbox" 
				<c:if test="${twoHands}">
					checked="checked"
				</c:if> name="twoHands" onclick="twoHandsClicked();"/>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
			</div>
		</fieldset>
		
		<jsp:include page="/progresso.jsp"/>
		
	</form>
</div>
</body>
</html>