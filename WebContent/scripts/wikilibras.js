var currentHelpDisplayed;
var nSteps = 7;

$(document).bind("pageinit", function ()
{
	$(".btAjuda").on("tap", showHelp);
	
	var step = $(".conteudo")[0].id.split("_")[1];
	
	for (var i = 1; i <= nSteps; i++)
	{
		if (i < step)
		{
			$("#bolinha_" + i).css("background-position", "0px -60px");
		}
		else if (i > step)
		{
			$("#bolinha_" + i).css("background-position", "0px -120px");
		}
	}
	
});

function showHelp (e)
{
	var btHelp = e.currentTarget;
	
	if (currentHelpDisplayed === btHelp)
	{
		return hideHelp(e);
	}
	
	currentHelpDisplayed = btHelp;
	
	$("#seta").css("visibility", "visible");
	$("#seta").css("top", $(btHelp).position().top + $(btHelp).height() / 2 - $("#seta").height() / 2);
	$("#seta").css("left", $(btHelp).position().left + $(btHelp).width());
	
	$("#textoAjuda").css("visibility", "visible");
	$("#textoAjuda").css("top", $(btHelp).position().top + $(btHelp).height() / 2 - $("#textoAjuda").outerHeight() / 2);
	$("#textoAjuda").css("left", $(btHelp).position().left + $(btHelp).width() + $("#seta").width());
}

function hideHelp (e)
{
	$("#seta").css("visibility", "hidden");
	$("#textoAjuda").css("visibility", "hidden");
	currentHelpDisplayed = null;
}