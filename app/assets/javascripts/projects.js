$( document ).ready(function() {

	$("#project_funder_id").change(function () {
		update_template_options();
		if ($(this).val().length > 0) {
			$("#other-funder-name").hide();
			$("#project_funder_name").val("");
		}
		else {
			$("#other-funder-name").show();
		}
		$("#institution-control-group").show();
		$("#create-plan-button").show();
		$("#confirm-funder").text($("#project_funder_id").select2('data').text);
	});

	$("#no-funder").click(function(e) {
		e.preventDefault();
		$("#project_funder_id").select2("val", "");
		update_template_options();
		$("#institution-control-group").show();
		$("#create-plan-button").show();
		$("#other-funder-name").show();
		$("#confirm-funder").text("None");
	});

	$("#project_funder_name").change(function(){
		$("#confirm-funder").text($(this).val());
	});

	$("#project_institution_id").change(function () {
		update_template_options();
		$("#confirm-institution").text($("#project_institution_id").select2('data').text);
	});

	$("#no-institution").click(function() {
		$("#project_institution_id").select2("val", "");
		update_template_options();
		$("#confirm-institution").text("None");
	});

	$("#project_dmptemplate_id").change(function (f) {
		$("#confirm-template").text($("#project_dmptemplate_id :selected").text());
	});

	$("#new-project-cancelled").click(function (){
		$("#project-confirmation-dialog").modal("hide");
		$('.select2-choice').show();
	});

	$("#new-project-confirmed").click(function (){
		$("#new_project").submit();
	});

	$("#default-template-confirmation-dialog").on("show", function(){
		$("#new_project").submit();
	});

	function update_template_options() {
		var options = {};
		var funder = $("#project_funder_id").select2('val');
		var institution = $("#project_institution_id").select2('val');
		$.ajax({
			type: 'GET',
			url: "possible_templates.json?institution="+institution+"&funder="+funder,
			dataType: 'json',
			async: false, //Needs to be synchronous, otherwise end up mixing up answers
			success: function(data) {
				options = data;
			}
		});
		select_element = $("#project_dmptemplate_id");
		select_element.find("option").remove();
		var count = 0;
		for (var id in options) {
			if (count == 0) {
				select_element.append("<option value='"+id+"' selected='selected'>"+options[id]+"</option>");
			}
			else {
				select_element.append("<option value='"+id+"'>"+options[id]+"</option>");
			}
			count++;
		}
		if (count >= 2) {
			$("#template-control-group").show();
		}
		else {
			$("#template-control-group").hide();
		}
		$("#confirm-template").text("");
		$("#project_dmptemplate_id").change();
	}
});
