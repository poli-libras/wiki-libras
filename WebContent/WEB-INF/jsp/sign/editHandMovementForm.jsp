<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WikiLibras</title>
<script src="/wikilibras/scripts/sign_form.js" type="text/javascript"></script>
<link rel="stylesheet" href="/wikilibras/css/wikilibras.css" type="text/css">

<script type="text/javascript">
	// armazena arrays do Java no javascript
	directions = new Array(); 
	<c:forEach var="dir" items="${directions}">
		directions.push("${dir}");
	</c:forEach>	
	magnitudes = new Array(); 
	<c:forEach var="mag" items="${magnitudes}">
		magnitudes.push("${mag}");
	</c:forEach>	
</script>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">
  
  <h2>Edição do sinal ${sign.name}</h2>
  
  <h3>Informações sobre o movimento da mão</h3>
  
  <fieldset>
    <legend>Símbolo #${signIndex} - 
      <c:if test="${handSide == 'RIGHT'}">
      Mão dominante
      </c:if>
      <c:if test="${handSide == 'LEFT'}">
      Mão não-dominante
      </c:if>
    </legend>
    
    <form method="POST" action="editHandMovement">
    
      <div class="option">
        <input type="checkbox" name="noMove" onchange="moveClicked();"
    		<c:if test="${noMove}">
    			checked="checked"
    		</c:if>		
    	/>Mão sem movimento
      </div>
    
      <div class="option">
      <label>Tipo:</label>
    	<select name="handMovement.type">
    		<c:forEach var="type" items="${types}">
    			<option value="${type}"
    				<c:if test="${type == handMovement.type}">
						selected="selected"
					</c:if>>${type}</option>
    		</c:forEach>
    	</select>
      </div>
      
      <div class="option" id="segments">
	    <label>Partes do movimento:</label>
	    <input type="button" value="+" onclick="addSegment();"/><br/>
		<select name="direction" style="display: none">
			<option value="dummy">dummy</option>
		</select>
		<select name="magnitude" style="display: none">
			<option value="dummy">dummy</option>
		</select>
		<c:forEach var="seg" items="${segments}">
		    <select name="direction">
	    		<c:forEach var="dir" items="${directions}">
	    			<option value="${dir}"
	    			<c:if test="${dir == seg.direction}">
						selected="selected"
					</c:if>>${dir}</option>
	    		</c:forEach>
	    	</select>
		    <select name="magnitude">
	    		<c:forEach var="mag" items="${magnitudes}">
	    			<option value="${mag}"
	    			<c:if test="${mag == seg.magnitude}">
						selected="selected"
					</c:if>>${mag}</option>
	    		</c:forEach>
	    	</select>
    	</c:forEach>
	</div>
    
      <div class="option">
      <label>Velocidade:</label>
    	<select name="handMovement.speed">
    		<option value="NORMAL"
     		    	<c:if test="${'NORMAL' == handMovement.speed}">
						selected="selected"
					</c:if>>Normal</option>
    		<option value="LENTO"
    		    	<c:if test="${'LENTO' == handMovement.speed}">
						selected="selected"
					</c:if>>Lento</option>
    		<option value="RAPIDO"
    		    	<c:if test="${'RAPIDO' == handMovement.speed}">
						selected="selected"
					</c:if>>Rápido</option>
    	</select>
      </div>
    	
      <div class="option">
      <label>Frequência:</label>
    	<select name="handMovement.frequency">
    		<option value="SIMPLES"
    		    	<c:if test="${'SIMPLES' == handMovement.frequency}">
						selected="selected"
					</c:if>>Simples</option>
    		<option value="REPETIDO"
    		    	<c:if test="${'REPETIDO' == handMovement.frequency}">
						selected="selected"
					</c:if>>Repetido</option>
    	</select>
      </div>
    	
      <input class="submit" type="submit" value="Avançar"/>	
    
    </form>
    
    <form action="editHandForm">
    	<input type="hidden" name="side" value="${handSide}"/>
    	<input class="submit" type="submit" value="Voltar"/>
    </form>
    
    <!-- script executado após formulário ser montado, caso não haja movimento -->
    <c:if test="${noMove}">
    	<script>moveClicked();</script>
    </c:if>	
  </fieldset>

	<div class="help">
	    <label>Ajuda</label>
		<p>A <i>direção</i> possui sempre como referencial a face de quem faz o sinal.
		Dessa forma, por exemplo, o sinal VOCÊ possui direção "para frente", enquanto que
		o sinal EU possui direção "para trás".</p>
	</div>		
</div>
</body>
</html>