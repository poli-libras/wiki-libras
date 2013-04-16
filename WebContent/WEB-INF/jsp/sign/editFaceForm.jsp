<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WikiLibras</title>
<script src="/wikilibras/scripts/sign_form.js" type="text/javascript"></script>
<link rel="stylesheet" href="/wikilibras/css/wikilibras.css" type="text/css">
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
  <h2>Edição do sinal ${sign.name}</h2>
  
  <h3>Informações sobre a expressão facial</h3>
  
  <fieldset>
    <legend>Símbolo #${signIndex}</legend>
    
    <form name="form" method="POST" action="editFace">
    
    	<div class="option">
      <input type="checkbox" name="noFace" onchange="faceClicked();"
    		<c:if test="${noFace}">
    			checked="checked"
    		</c:if>			
    	/>Sem expressão facial
      </div>
    
    	<div class="option">
      <label>Bocheca:</label>
    	<select name="face.chin">
    		<c:forEach var="facex" items="${chins}">
    			<option value="${facex}"
    			<c:if test="${facex == face.chin}">
    				selected="selected"
    			</c:if>>${facex}</option>
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Sobrancelha:</label>
    	<select name="face.eyebrow">
    		<c:forEach var="facex" items="${eyebrows}">
    			<option value="${facex}"
    			<c:if test="${facex == face.eyebrow}">
    				selected="selected"
    			</c:if>>${facex}</option>						
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Olhos:</label>
    	<select name="face.eyes">
    		<c:forEach var="facex" items="${eyes}">
    			<option value="${facex}"
    			<c:if test="${facex == face.eyes}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Testa:</label>
    	<select name="face.forehead">
    		<c:forEach var="facex" items="${foreheads}">
    			<option value="${facex}"
    			<c:if test="${facex == face.forehead}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Olhar:</label>
    	<select name="face.gaze">
    		<c:forEach var="facex" items="${gazes}">
    			<option value="${facex}"
    			<c:if test="${facex == face.gaze}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Boca:</label>
    	<select name="face.mounth">
    		<c:forEach var="facex" items="${mounths}">
    			<option value="${facex}"
    			<c:if test="${facex == face.mounth}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    	
    	<div class="option">
      <label>Nariz:</label>
    	<select name="face.nose">
    		<c:forEach var="facex" items="${noses}">
    			<option value="${facex}"
    			<c:if test="${facex == face.nose}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    
    	<div class="option">
      <label>Dentes:</label>
    	<select name="face.teeth">
    		<c:forEach var="facex" items="${teeth}">
    			<option value="${facex}"
    			<c:if test="${facex == face.teeth}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    
    	<div class="option">
      <label>Língua:</label>
    	<select name="face.tongue">
    		<c:forEach var="facex" items="${tongues}">
    			<option value="${facex}"
    			<c:if test="${facex == face.tongue}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    
    	<div class="option">
      <label>Outros:</label>
    	<select name="face.others">
    		<c:forEach var="facex" items="${others}">
    			<option value="${facex}"
    			<c:if test="${facex == face.others}">
    				selected="selected"
    			</c:if>>${facex}</option>									
    		</c:forEach>
    	</select></div>						
    
    	<input type="hidden" name="moreSymbols" value="false"/>
    
    	<c:if test="${newSign}">
    		<input class="submit" type="submit" value="Finalizar sinal"/>
    		<input class="submit" type="submit" value="Acrescentar mais símbolos" onclick="moreSymbolsClicked();"/>	
    	</c:if>
    
    	<c:if test="${!newSign}">
    		<input class="submit" type="submit" value="Finalizar símbolo"/>	
    	</c:if>
    	
    </form>
    
    <form action="editSymbolForm">
    	<input class="submit" type="submit" value="Voltar"/>
    </form>
    
    <!-- script executado após formulário ser montado, caso não haja expressão facial -->
    <c:if test="${noFace}">
    	<script>faceClicked();</script>
    </c:if>
  </fieldset>
  
	<div class="help">
	    <label>Ajuda</label>
		<p>Nesta tela você pode finalizar a edição do sinal ou ordenar a incluisão de mais um símbolo,
		o que deve ser usado no caso do sinal ter que ser dividido em vários
		"sub-sinais" para uma representação adequada.</p>
	</div>		  	
</div>
</body>
</html>