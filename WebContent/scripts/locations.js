$(document).on("ready", function ()
{
	$(".location").hover(function () {
		if (!this.selected)
			$("#" + this.id + "_img").css("visibility", "visible");
	}, function () {
		if (!this.selected)
			$("#" + this.id + "_img").css("visibility", "hidden");
	});
	
	$(".location").on("click", function (e)
	{
		$("#location_label").text($(this).attr("name"));
		$("#location_value").attr("value", $(this).attr("name"));
		
		$(".location").each(function (i){
			this.selected = false;
		});
		e.currentTarget.selected = true;
	});
});