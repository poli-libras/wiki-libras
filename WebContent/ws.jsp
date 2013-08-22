<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/includes/globalInclude.jsp"/>
<title>WikiLibras</title>
</head>
<body>

<jsp:include page="/header.jsp"/>

<div id="ws" class="content">
	<h3>Web Services</h3>
	
	<p><b>Informação geral</b></p>
	<p>Um dos objetivos do WikiLibras é fazer com que a informação do dicionário Português - LIBRAS
		seja acessível não apenas por humanos, mas também por programas de computador.</p>
	<p>Isto é um passo importante para facilitar a construção de novas aplicações voltadas à
		comunidade surda, de forma que novas ideias possam ser construídas em cima do que já existe, 
		sem precisar começar o trabalho do zero.</p>
	<p>Exemplo de aplicações que podem se benefeciar desse tipo de acesso:</p>
	<ul>
	<li>Tradutor Português - LIBRAS: um bom tradutor deve não apenas traduzir palavra por palavra, 
		mas considerar as sintaxes das línguas envolvidas no processo de tradução; com o WikiLibras
		como suporte, é possível o desenvolvimento de um tradutor com foco na questão sintática,
		sem que seus desenvolvedores tenha que se preocupar com o vocabulário.</li>
	<li>Sintetizador 3D de sinais de LIBRAS: semelhante a um sintatizador de voz, pode ser possível
		o desenvolvimento de um programa que seja capaz de renderizar um avatar realizando sinais 
		de LIBRAS a partir de uma especificação formal desses sinais; o WikiLibras já fornece essa
		descrião formal (baseada no SignWriting) e vocabulário real que auxiliaria o desenvolvimento
		de tal aplicação.</li>
	</ul>   
	
	<p><b>Usando o WebService do WikiLibras</b></p>
	<p>A forma com que um sistema pode ter acesso às informações é através do uso do
		WebService fornecido pelo WikiLibras (WebService é uma forma de comunicação entre programas
		independente de plataforma, o quer dizer que qualquer tipo de aplicação pode se benefeciar
		desse acesso).</p>
	<p>O arquivo WSDL que deverá ser usado pela aplicação é cliente é:</p>
	<p><i>http://policidada.poli.usp.br/wikilibras/ws/dictionary?wsdl</i></p>
	<p>O WSDL é um arquivo XML que descreve as operações disponíveis no WebService.</p>
	<p>Com o uso desse arquivo a aplicação terá disponível as seguintes operações:</p>
	
	<p>
	<b>Nome:</b> signByName<br/>
	<b>Descrição:</b> Obtêm um sinal pelo seu nome<br/>
	<b>Parâmetro:</b> nome exato do sinal (ex: SENTAR-EM-RODA)<br/>
	<b>Retorno:</b> o sinal correspondente ou valor nulo em caso de não haver sinal
	</p>

	<p>
	<b>Nome:</b> nearSigns<br/>
	<b>Descrição:</b> Obtêm os sinais cujos nomes se assemelham ao argumento<br/>
	<b>Parâmetro:</b> o nome aproximado do sinal (ex: SENTAR)<br/>
	<b>Retorno:</b> os sinais correspondentes (ex: SENTAR, SENTAR-EM-RODA, SENTAR-NA-CADEIRA)
	</p>

	<p>
	<b>Nome:</b> translate<br/>
	<b>Descrição:</b> Traduz uma palavra em português para LIBRAS<br/>
	<b>Parâmetro:</b> palavra em português<br/>
	<b>Retorno:</b> lista dos sinais que possivelmente correspondem à palavra dada
	</p>

	<p>
	<b>Nome:</b> simpleTranslate<br/>
	<b>Descrição:</b> Traduz uma palavra em português para LIBRAS; caso haja vários possíveis sinais correspondentes, 
		apenas um sinal será retornado<br/>
	<b>Parâmetro:</b> palavra em português<br/>
	<b>Retorno:</b> um sinal em LIBRAS que corresponde à palavra dada
	</p>
</div>

</body>
</html>
