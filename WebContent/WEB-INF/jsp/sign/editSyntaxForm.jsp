<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/wikilibras/css/wikilibras.css" type="text/css">
<title>WikiLibras</title>
<script src="/wikilibras/scripts/sign_form.js" type="text/javascript"></script>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
<h2>Edição do sinal ${sign.name}</h2>

<form method="POST" action="editSyntax">

<fieldset>
<legend>Informações sobre o contexto sintático na frase em português</legend>
	
	<div class="option" id="words">
	<label>Palavras correspondentes:</label> 
	<input type="button" value="+" onclick="addWord();"/>
		<c:forEach var="word" items="${words}">
			<input class="field" type="text" name="word" value="${word.word}"/>
		</c:forEach>			
		<input class="field" type="text" name="word" alt="Palavra"/>
		<input class='field' type='text' name='word'/>		
	</div>
	
	<div class="option">
	<label>Tipo do verbo:</label>
	<select name="sign.verbType">
		<c:forEach var="verb" items="${verbs}">
			<option value="${verb}"
				<c:if test="${verb == sign.verbType}">
					selected="selected"
				</c:if>>${verb.string}</option>
		</c:forEach>
	</select>			
	</div>	
 		
	<div class="option" id="literais">
		<label>Literais:</label>
		<input type="button" value="+" onclick="addLiteral();"/>
		<c:forEach var="literal" items="${literals}">
			<input type="text" class="field" name="literal" value="${literal.literal}"/>
		</c:forEach>			
		<input type="text" class="field" name="literal"/>
		<input type='text' class="field" name='literal'/>
	</div>
	
	<div class="option" id="inerencias">
		<label>Inerências:</label>
		<input type="button" value="+" onclick="addInherence();"/>
		<c:forEach var="inherence" items="${inherences}">
			<input type="text" class="field" name="inherence" value="${inherence.inherence}"/><br>
		</c:forEach>					
		<input type="text" class="field" name="inherence"/>	
		<input type='text' class="field" name='inherence'/>
	</div>
	
	<input type="submit" class="submit" value="Avançar"/>
	</fieldset>
	
	<div class="help">
	    <label>Ajuda</label>
		<p>Esta seção fornece informações para auxiliar a tradução de textos de português para LIBRAS.</p>
		<p>Numa tradução, as <i>palavras correspondentes</i> poderão ser substituídas por este sinal.</p>
		<p>Essa substituição pode possuir restrições, como a presença de uma palavra no mesmo período 
		(<i>literal</i>) ou uma palavra de uma certa categoria (<i>inerência</i>) na oração.</p>
		<p>Exemplo: sinal SENTAR-EM-RODA será substituído pela palavra <i>sentar</i> desde que no contexto
		haja o literal <i>roda</i>.</p> 
	</div>
</form>

</div>
</body>
</html>