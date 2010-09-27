$(function() {
	jQuery.ajaxSetup({
		'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
	});
	
	

  $('form a.add_child').click(function() {
  	console.log('deprecated? I think not.');
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
  
  //Add Exercise Widget
  var add_ex_widget = function(w){
  	var that,
  			//external
		  	workout_set_list = $('ol.workout_sets'), //external list of workout_sets
		  	//internal
				ep = w.find('.exercise-picker'),
		  	control_bar = $('.control-bar', ep),
		  	browse_exercises_button = $('.browse-exercises-button', control_bar),
		  	search_exercises_button = $('.search-exercises-button', control_bar),
		  	muscle_groups_list = $('ul.muscle-groups', ep), // list of muscle groups
		  	muscle_group_exercises_list = $('.muscle-group-exercises', ep), // list of exercises within a muscle group
		  	selected_muscle_group_name = $('.muscle-group-name', ep),
		  	search_field = $("input[type=text][data-autocomplete-url]", ep), // search exercises text field
		  	search_results_list = $('.search-exercises-results-list', ep); // list of search results

		var cache = {};

  	//open up widget
	  $('.open-widget-button', w).click(function(){
	  	$(this).hide();
	  	ep.show()
	  });
  	
  	//setup top controls
		$('.control-bar .control-bar-button', ep).click(function(){
			var jthis = $(this);
			var name = jthis.attr('data-tab-name');
			//adjust buttons
			jthis.addClass('current').siblings().removeClass('current');
			//adjust control headers
			control_bar.find('.' + name + '-control-header').addClass('current').siblings().removeClass('current');
			//adjust picker panes
			ep.find('.' + name + '-panel').addClass('current').siblings('.current').removeClass('current');
		});
  	
  	//setup add exercise rows
  	$('.add-exercise', ep).live('click', function() {
	    var ex_id = $(this).attr('data-exercise-id');
	    var ex_name = $(this).html();
    	that.select_exercise(ex_id, ex_name);
	    return false;
	  });
	  
	  
	  
	  //setup browse muscle group rows
	  muscle_groups_list.find('li a').click(function() {
	  	var url = $(this).attr('href');
	  	console.log(cache[url]);
	  	
	  	function callback(data) {
	  		muscle_group_exercises_list.html(exercise_list_helper(data));
				muscle_groups_list.hide();
				muscle_group_exercises_list.show();
	  	}
	  	
	  	if (cache[url] != undefined ) { 
	  		console.log('used cache'); 
	  		callback(cache[url]); 
	  	}	else {
		  	$.getJSON(url, null, function(data) {
		  		cache[url] = data;
		  		callback(data);
				});
			}
	  	
	  	//change title
	  	selected_muscle_group_name.html($(this).html());
	  	
	  	namenext($('.selected-muscle-group-header'));
	  	
	  	return false;
	  });
	  
		//back to all muscle groups
	  $('.back-to-browse-muscle-group-button', ep).click(function(){
			muscle_group_exercises_list.hide()
			muscle_groups_list.show();
			$(this).closest('.selected-muscle-group-header').hide().siblings('.browse-muscle-groups-header').show();
	  });
	  
  	//setup search exercise field 
		search_field.keyup( function() {
			var url = search_field.attr('data-autocomplete-url') + '?query=' + search_field.val();
			
			var callback = function(data) {
				search_results_list.html(exercise_list_helper(data));
			}
			
			if (cache[url] != undefined ) { 
	  		console.log('used cache'); 
	  		callback(cache[url]); 
	  	}	else {
		  	$.getJSON(url, null, function(data) {
		  		cache[url] = data;
		  		callback(data);
				});
			}
		});
	  
  	that = {
	  	select_exercise: function(id, name){
	  		var template = $('#workout_sets_fields_template').html(),
		    		regexp = new RegExp('new_workout_sets', 'g'),
		    		new_id = new Date().getTime(),
		    		new_content = $(template.replace(regexp, new_id));
		    		
				new_content.find('.exercise-name').html(name);
		    workout_set_list.append(new_content);
	  	}
	  }
	  
	  w.data('add-exercise-widget', that);
  }
  
  add_ex_widget($('.add-exercise-widget'));
  
  namenext = function(node) {
  	node.show().siblings().hide();
  }
});