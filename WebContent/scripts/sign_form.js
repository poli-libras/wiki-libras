/**
 * Scripts dos formulários de edição de sinal
 */


addWord = function() {

	the_div = document.getElementById("words");
	var newText = document.createElement('input');
	newText.setAttribute("type", "text");
	newText.setAttribute("class", "field");
	newText.setAttribute("name", "word");
	the_div.appendChild(newText);
};

addLiteral = function() {

	the_div = document.getElementById("literais");
	var newText = document.createElement('input');
	newText.setAttribute("type", "text");
	newText.setAttribute("class", "field");
	newText.setAttribute("name", "literal");
	the_div.appendChild(newText);
};

addInherence = function() {

	the_div = document.getElementById("inerencias");
	var newText = document.createElement('input');
	newText.setAttribute("type", "text");
	newText.setAttribute("class", "field");
	newText.setAttribute("name", "inherence");
	the_div.appendChild(newText);
};

addSegment = function() {
	
	the_div = document.getElementById("segments");

	// add direction
	var newSelect = document.createElement('select');
	newSelect.setAttribute("name", "direction");	
	for (i=0; i<directions.length; i++) {
		var newOption = document.createElement('option');
		newOption.setAttribute("value", directions[i]);
		newOption.innerHTML = directions[i]; 
		newSelect.appendChild(newOption);
	}
	the_div.appendChild(newSelect);	

	// add segment
	var newSelect = document.createElement('select');
	newSelect.setAttribute("name", "magnitude");	
	for (i=0; i<magnitudes.length; i++) {
		var newOption = document.createElement('option');
		newOption.setAttribute("value", magnitudes[i]);
		newOption.innerHTML = magnitudes[i]; 
		newSelect.appendChild(newOption);
	}
	the_div.appendChild(newSelect);	
};

changeShapeGroup = function() {

	// captura elementos DOM do html
	select_shapes = document.getElementsByName("hand.shape")[0];
	select_groups = document.getElementsByName("group_shape")[0];

	// limpa o select das configurações
	while (select_shapes.length > 0) {
		select_shapes.remove(0);
	}

	// atualiza novas configurações de acordo com o grupo escolhido
	shapes = shape_matrix[select_groups.selectedIndex]; // shape_matrix é definido em editHandForm.jsp
	strshapes = string_matrix[select_groups.selectedIndex]; // string_matrix tb
	for (i=0; i<shapes.length; i++) {
			select_shapes.options[i] = new Option(strshapes[i], shapes[i]);
	}
	
	// Atualiza figura
	changeShape();
};

changeShape = function() {
	
	// atualiza figura que mostra configuração de mão
	select_shapes = document.getElementsByName("hand.shape")[0];
	shape = select_shapes.options[select_shapes.selectedIndex].value;
	document.getElementById("shapeImg").setAttribute("src", "/wikilibras/media/maos/" + shape + ".JPG");
};

changeLocGroup = function() {

	// captura elementos DOM do html
	select_locs = document.getElementsByName("symbol.location")[0];
	select_groups = document.getElementsByName("location_group")[0];

	// limpa o select das configurações
	while (select_locs.length > 0) {
		select_locs.remove(0);
	}

	// atualiza novas configurações de acordo com o grupo escolhido
	locs = loc_matrix[select_groups.selectedIndex]; // shape_matrix é definido em insert_sign.jsp
	for (i=0; i<locs.length; i++) {
			select_locs.options[i] = new Option(locs[i], locs[i]);
	}
};

moveClicked = function(hand) {
	
	selected = document.getElementsByName("noMove")[0].checked;
	type = document.getElementsByName("handMovement.type")[0];
	direction = document.getElementsByName("handMovement.direction")[0];
	speed = document.getElementsByName("handMovement.speed")[0];
	frequency = document.getElementsByName("handMovement.frequency")[0];

	if (selected == false) {
		type.disabled = "";
		direction.disabled = "";
		speed.disabled = "";
		frequency.disabled = "";
	}
	else {
		type.disabled = "disabled";
		direction.disabled = "disabled";
		speed.disabled = "disabled";
		frequency.disabled = "disabled";
	}
	
};

faceClicked = function(hand) {
	
	selected = document.getElementsByName("noFace")[0].checked;
	chin = document.getElementsByName("face.chin")[0];
	eyebrow = document.getElementsByName("face.eyebrow")[0];
	eyes = document.getElementsByName("face.eyes")[0];
	forehead = document.getElementsByName("face.forehead")[0];
	gaze = document.getElementsByName("face.gaze")[0];
	mounth = document.getElementsByName("face.mounth")[0];
	nose = document.getElementsByName("face.nose")[0];
	teeth = document.getElementsByName("face.teeth")[0];
	tongue = document.getElementsByName("face.tongue")[0];
	others = document.getElementsByName("face.others")[0];

	if (selected == false) {
		selected.disabled = "";
		chin.disabled = "";
		eyebrow.disabled = "";
		eyes.disabled = "";
		forehead.disabled = "";
		gaze.disabled = "";
		mounth.disabled = "";
		nose.disabled = "";
		teeth.disabled = "";
		tongue.disabled = "";
		others.disabled = "";
	}
	else {
		selected.disabled = "disabled";
		chin.disabled = "disabled";
		eyebrow.disabled = "disabled";
		eyes.disabled = "disabled";
		forehead.disabled = "disabled";
		gaze.disabled = "disabled";
		mounth.disabled = "disabled";
		nose.disabled = "disabled";
		teeth.disabled = "disabled";
		tongue.disabled = "disabled";
		others.disabled = "disabled";
	}
};

twoHandsClicked = function(){
	
	selected = document.getElementsByName("twoHands")[0].checked;
	unityCheck = document.getElementsByName("symbol.handsInUnity")[0];
	
	if (selected == false) {
		unityCheck.disabled = "disabled";
		unityCheck.checked = "";
	}
	else {
		unityCheck.disabled = "";
	}
};

moreSymbolsClicked = function() {
	
	more = document.getElementsByName("moreSymbols")[0];
	more.value = "true";
	document.form.submit();
};
