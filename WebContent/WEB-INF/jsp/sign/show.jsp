<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tabs.css" type="text/css">    
<script src="${pageContext.request.contextPath}/scripts/activatables.js" type="text/javascript"></script>
<script type="text/javascript">
  symbols_list = new Array();
  i = 0;
  <c:forEach var="sym" items="${sign.symbols}">
    i++;
    symbols_list.push('symbol-' + i);
  </c:forEach>
      
  activatables('symbol', symbols_list);
  

  function deleteSign() {
  	text = "Quer mesmo deletar o sinal ${sign.name}?";
  	ok = confirm(text);
  	if (ok)
  		window.location = "${deleteLink}";
  }
</script>
<title>WikiLibras</title>
</head>

<body>

<jsp:include page="/header.jsp"/>

<div class="content">

  <h2>Sinal ${sign.name}</h2>
  <a href="${editLink}">Editar o sinal</a>
  <a href="#" onClick="deleteSign();">Excluir o sinal</a> <!-- TODO: confirmação java-script -->  
  
  <h3>Informações sobre o contexto sintático na frase em português</h3>
  
  <div class=block>
    <p><b>Palavras correspondentes: 
    <c:forEach var="s" items="${sign.words}">
    ${s.word};
    </c:forEach>
    </b>
    </p>
    
    <c:if test="${sign.verbType != 'NAO_VERBO'}">
	    <p><b> Tipo do verbo:</b>
	   	${sign.verbType.string}
	    </p>
    </c:if>
    
    <p>Literais: 
    <c:forEach var="s" items="${sign.literals}">
    ${s.literal};
    </c:forEach>
    </p>
    
    <p>Inerências: 
    <c:forEach var="s" items="${sign.inherences}">
    ${s.inherence};
    </c:forEach>
    </p>
  </div>
  
  <h3>Símbolos</h3>
  
  <c:set var="index"  scope="request" value="0" />
  <ol id="tabs">
    <c:forEach var="sym" items="${sign.symbols}">
        <c:set var="index" value="${index + 1}" />	
        <li><a href="#symbol-${index}"><span>Símbolo #${index}</span></a></li>
    </c:forEach>
  </ol>
  <c:set var="index" value="0" />
  <c:forEach var="sym" items="${sign.symbols}">
    <c:set var="index" value="${index + 1}" />
    <div class="tabcontent" id="symbol-${index}">
    	
    	<ul><li>Símbolo:
    	<p><label>Locação:</label> ${sym.location};<br/>
    	<label>Contato:</label> ${sym.contact}<br/>
    	<c:if test="${sym.contact != 'NENHUM'}">
    		<label>Número de contatos:</label> ${sym.contactQuantity}<br/>
    	</c:if>
    	<label>Mãos em unidade:</label> 
    	<c:choose>
	    	<c:when test="${sym.handsInUnity == true}">SIM</c:when>
	    	<c:when test="${sym.handsInUnity == false}">NÃO</c:when>
    	</c:choose>
    	</p></li></ul>
    	
    	<ul><li>Mão dominante:
    	<p><label>Configuração de mão:</label> ${sym.rightHand.shape.string}<br/>
    	<label>Orientação:</label> ${sym.rightHand.orientation.string}<br/>
    	<label>Rotação:</label> ${sym.rightHand.rotation}<br/>
    	<label>Plano:</label> ${sym.rightHand.plane}<br/>	
    	<label>Movimento dos dedos:</label> ${sym.rightHand.fingers.string}<br/>	
    	</p></li></ul>
    	
 		<p><img id="rightShapeImg" alt="configuração de mão dominante"
 			height="100" width="100" 
 			src="${pageContext.request.contextPath}/media/maos/${sym.rightHand.shape}.JPG"></p>	
    	
    	<c:if test="${sym.rightHand.movement != null}">
    		<ul><li>Movimento da mão dominante:
    		<p><label>Tipo:</label> ${sym.rightHand.movement.type}<br/>
    		<label>Partes do movimento:</label>
		    <ul><c:forEach var="seg" items="${sym.rightHand.movement.segments}">
		    	<li>${seg.direction}, ${seg.magnitude};</li>
		    </c:forEach></ul>
    		<label>Velocidade:</label> ${sym.rightHand.movement.speed}<br/>	
    		<label>Frequência:</label> ${sym.rightHand.movement.frequency}<br/>	
    		
    	</li></ul></c:if>
    
    	<c:if test="${sym.leftHand != null}">
    		<ul><li>Mão não-dominante:
    		<p><label>Configuração de mão:</label> ${sym.leftHand.shape.string}<br/>
    		<label>Orientação:</label> ${sym.leftHand.orientation.string}<br/>
    		<label>Rotação:</label> ${sym.leftHand.rotation}<br/>    		
    		<label>Plano:</label> ${sym.leftHand.plane}<br/>
    		<label>Movimento dos dedos:</label> ${sym.leftHand.fingers.string}<br/>	    		
    		</li></ul>	
    		
  		 	<p><img id="leftShapeImg" alt="configuração de mão não-dominante" 
		 	    height="100" width="100" 
 			    src="${pageContext.request.contextPath }/media/maos/${sym.leftHand.shape}.JPG"></p>	
    
    		<c:if test="${sym.leftHand.movement != null}">
    			<ul><li>Movimento da mão não-dominante:
    			<p><label>Tipo:</label> ${sym.leftHand.movement.type}<br/>
    			<label>Partes do movimento:</label>    			
			    <ul><c:forEach var="seg" items="${sym.leftHand.movement.segments}">
			    	<li>${seg.direction}, ${seg.magnitude};</li>
			    </c:forEach></ul>    			
    			<label>Velocidade:</label> ${sym.leftHand.movement.speed}<br/>	
    			<label>Frequência:</label> ${sym.leftHand.movement.frequency}<br/>	
    		</li></ul></c:if>
    	</c:if>
    
    	<c:if test="${sym.face != null}">
    		<ul><li>Expressão facial:
    		<p>
    		<c:if test="${sym.face.chin != 'NADA'}">		
    			<label>Bochecha:</label> ${sym.face.chin}<br/>
    		</c:if>
    		<c:if test="${sym.face.eyebrow != 'NADA'}">		
    			<label>Sobrancelhas:</label> ${sym.face.eyebrow}<br/>
    		</c:if>
    		<c:if test="${sym.face.eyes != 'NADA'}">		
    			<label>Olhos:</label> ${sym.face.eyes}<br/>
    		</c:if>
    		<c:if test="${sym.face.forehead != 'NADA'}">		
    			<label>Testa:</label> ${sym.face.forehead}<br/>
    		</c:if>
    		<c:if test="${sym.face.gaze != 'NADA'}">		
    			<label>Olhar:</label> ${sym.face.gaze}<br/>
    		</c:if>
    		<c:if test="${sym.face.mounth != 'NADA'}">		
    			<label>Boca:</label> ${sym.face.mounth}<br/>
    		</c:if>
    		<c:if test="${sym.face.nose != 'NADA'}">		
    			<label>Nariz:</label> ${sym.face.nose}<br/>
    		</c:if>
    		<c:if test="${sym.face.teeth != 'NADA'}">		
    			<label>Dentes:</label> ${sym.face.teeth}<br/>
    		</c:if>
    		<c:if test="${sym.face.tongue != 'NADA'}">		
    			<label>Língua:</label> ${sym.face.tongue}<br/>
    		</c:if>
    		<c:if test="${sym.face.others != 'NADA'}">		
    			<label>Outros:</label> ${sym.face.others}<br/>
    		</c:if>
    		</p>
    	</li></ul></c:if>
    </div>
  </c:forEach>
</div>
</body>
</html>