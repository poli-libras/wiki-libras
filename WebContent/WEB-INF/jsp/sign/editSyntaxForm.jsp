<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<script src="${pageContext.request.contextPath}/scripts/wikilibras.js" type="text/javascript"></script>
<title>WikiLibras</title>
</head>

<body>

<img id="seta" src="${ pageContext.request.contextPath }/media/images/seta.png"></img>
<div id="textoAjuda">
	<b>Ajuda</b><br><br>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non diam elit. Nulla porttitor ultrices neque, sed lacinia risus. Pellentesque pretium hendrerit nunc quis commodo. 
</div>
	
<jsp:include page="/header.jsp"/>

<div class="conteudo" id="passo_1">
	<h2>Edição do sinal ${sign.name}</h2>
	<h3><b>Passo 1:</b> Informações sobre o contexto sintático da frase em português</h3>
	
	<form method="POST" action="editSyntax" target="_top">
	
		<fieldset>
		
			<div class="option">
				<span class="nomeCampo">Tipo do verbo:&nbsp&nbsp&nbsp</span>
				<select data-role="none" name="sign.verbType">
					<c:forEach var="verb" items="${verbs}">
						<option value="${verb}"
							<c:if test="${verb == sign.verbType}">
								selected="selected"
							</c:if>>${verb.string}</option>
					</c:forEach>
				</select>			
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
			</div>	
		
			<div class="option" id="words">
				<span class="nomeCampo">Palavras correspondentes:</span> 
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
				<c:forEach var="word" items="${words}">
					<input class="textField" type="text" name="word" value="${word.word}"/>
				</c:forEach>			
				<input class="textField" type="text" name="word"/>
				<input class='textField' type='text' name='word'/>		
				<span class="novoCampo">+ adicionar mais um campo</span>
			</div>

			<div class="option" id="literais">
				<span class="nomeCampo">Literais:</span>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
				<c:forEach var="literal" items="${literals}">
					<input type="text" class="textField" name="literal" value="${literal.literal}"/>
				</c:forEach>			
				<input type="text" class="textField" name="literal"/>
				<input type='text' class="textField" name='literal'/>
				<span class="novoCampo">+ adicionar mais um campo</span>
			</div>

			<div class="option" id="inerencias">
				<span class="nomeCampo">Inerências:</span>
				<img class="btAjuda" src="${ pageContext.request.contextPath }/media/images/ajuda.png"></img>
				<c:forEach var="inherence" items="${inherences}">
					<input type="text" class="textField" name="inherence" value="${inherence.inherence}"/><br>
				</c:forEach>					
				<input type="text" class="textField" name="inherence"/>	
				<input type='text' class="textField" name='inherence'/>
				<span class="novoCampo">+ adicionar mais um campo</span>
			</div>
			
		</fieldset>
		
		<div id="progresso">
			<div class="bolinha" id="bolinha_1"></div>
			<div class="bolinha" id="bolinha_2"></div>
			<div class="bolinha" id="bolinha_3"></div>
			<div class="bolinha" id="bolinha_4"></div>
			<div class="bolinha" id="bolinha_5"></div>
			<div class="bolinha" id="bolinha_6"></div>
			<div class="bolinha" id="bolinha_7"></div>
			<input type="submit" class="submit" value=""/>
		</div>
		
	</form>
</div>
</body>
</html>