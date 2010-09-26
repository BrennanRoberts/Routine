$(function() {
	jQuery.ajaxSetup({
		'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
	});
	
	

  $('form a.add_child').click(function() {
    var association = $(this).attr('data-association');
    var template = $('#' + association + '_fields_template').html();
    var regexp = new RegExp('new_' + association, 'g');
    var new_id = new Date().getTime();
		
    $('.'+ association).append(template.replace(regexp, new_id));
    return false;
  });

  $('form a.remove_child').live('click', function() {
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).parents('.fields').hide();
    return false;
  });
  
  //Add Exercise Widget
  var exercise_list_helper = function (data) {
		var html_string = '';
		for (var i in data) {
		var ex = data[i];
			html_string += add_exercise_helper(ex.exercise.id, ex.exercise.name);
		}
		return html_string;
	}
		
	var add_exercise_helper = function (id, name) {
		return '<li><a href="javascript: void(0);" class="add-exercise" data-exercise-id="' + id + '" data-exercise-name="' + name + '">' + name + '</a></li>'
	}
	
	//top controls
	$('.control-bar .control-bar-button').click(function(){
		var jthis = $(this);
		
		jthis.closest('.control-bar').find('.control-bar-group.current').removeClass('current');
		jthis.closest('.control-bar-group').addClass('current');
		jthis.closest('.exercise-picker').find(jthis.attr('data-tab-panel')).addClass('current').siblings('.current').removeClass('current');
	});
	
	//search exercises 
	$("input[type=text][data-autocomplete-url]").keyup( function() {
		var textfield = $(this);
		$.getJSON( 
			textfield.attr('data-autocomplete-url') + '?query=' + textfield.val(),
			null,
			function(data) {
				$('.search-exercises-results-list').html(exercise_list_helper(data));
			}
		);
	});
  
  $('.add-exercise-button').click(function(){
  	$(this).hide().next().show();
  });
  
  //browse muscle groups
  $('ul.muscle-groups li a').live('click', function() {
  	jthis = $(this);
  	var url = jthis.attr('href');
  	$.getJSON(url, null, function(data) {
			$('.muscle-group-exercises').html(exercise_list_helper(data));
			jthis.closest('ul').hide().siblings('.muscle-group-exercises').show();
  	});
  	
  	//console.log($(this).closest('.exercise-picker').find('.browse-muscle-groups-header'));
  	$(this).closest('.exercise-picker').find('.muscle-group-header').find('.muscle-group-name')
  		.html($(this).html())
  	.end().show().siblings('.browse-muscle-groups-header').hide();
  	
  	return false;
  });
  
  //back to all muscle groups
  $('.browse-exercise-back-button').click(function(){

		$(this).closest('.exercise-picker').find('.muscle-group-exercises').hide().siblings('.muscle-groups').show();
		$(this).closest('.muscle-group-header').hide().siblings('.browse-muscle-groups-header').show();
  });
  
  $('.add-exercise').live('click', function() {
    var ex_id = $(this).attr('data-exercise-id');
    var ex_name = $(this).html();
    var template = $('#workout_sets_fields_template').html();
    var regexp = new RegExp('new_workout_sets', 'g');
    var new_id = new Date().getTime();
    var new_content = $(template.replace(regexp, new_id));
		new_content.find('.exercise-name').html(ex_name);
		new_content.find('#workout_workout_sets_attributes_' + new_id + '_exercise_id').val(ex_id);
    $('.workout_sets').append(new_content);
    return false;
  });
});