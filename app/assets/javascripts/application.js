//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

var utility = {
  update_workout_set_order_values: function(){
    $('ul.workout_sets').children().each(function(i, el){
      el = $(el);
      var pos = el.prevAll().size();
      el.find('.workout_set_position_field').val(pos);
      el.find('.index span').html(pos + 1)
    });
  }
};

$(function() {

// WORKOUT#INDEX
//------------------------------------------------------------------------------
$('.workouts li a.complete-workout').click(function(e){
  var jthis = $(this);
  $.ajax(
    {
      type: 'put',
      url: jthis.attr('href'),
      success: function(){
        jthis.addClass('complete');
        if(jthis.closest('ul').hasClass('upcoming')) {
          var li = jthis.closest('li');
          li.slideUp(function() {
            $('ul.recent').prepend(li);
            li.slideDown();
          });
        }
      }
    }
  );

  return false;
});

// WORKOUT#FORM
//------------------------------------------------------------------------------
  //sort workout_set rows
  $('ul.workout_sets').sortable({
    axis: 'y',
    handle: '.exercise-name',
    update: utility.update_workout_set_order_values
  });



  //remove a workout_set from a workout
  $(document).on('click', 'ul.workout_sets li a.remove-workout-set', function() {
    var hidden_field = $(this).next('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).closest('li').hide();
    return false;
  });

  //Add Exercise Widget
  var add_ex_widget = function(w){
    var that,
        //external
        workout_set_list = $('.workout_sets'), //external list of workout_sets
        //internal
        ep = w.find('.exercise-picker'),
        control_bar = $('.control-bar', ep),
        control_headers = $('.control-headers', ep).children(),
        browse_exercises_button = $('.browse-exercises-button', control_bar),
        search_exercises_button = $('.search-exercises-button', control_bar),
        panels = $('.exercise-picker-panel', ep),
        muscle_groups_list = $('ul.muscle-groups', ep), // list of muscle groups
        muscle_group_exercises_list = $('.muscle-group-exercises', ep), // list of exercises within a muscle group
        selected_muscle_group_name = $('.selected-muscle-group-control-header .muscle-group-name', ep),
        search_field = $("input[type=text][data-autocomplete-url]", ep), // search exercises text field
        search_results_list = $('.search-exercises-results-list', ep) // list of search results

    var cache = {};

    //open up widget
    $('.open-widget-button', w).click(function(){
      $(this).hide();
      ep.show()
    });

    //close widget
    $('.min-widget', ep).click(function(){
      ep.hide();
      w.find('.open-widget-button').show();
    });

    //setup top controls
    $('.control-bar .control-bar-button', ep).click(function(){
      var jthis = $(this);
      var name = jthis.attr('data-tab-name');

      //adjust buttons
      jthis.addClass('current').siblings().removeClass('current');

      //adjust control headers
      that.switch_view(name);

      //adjust picker panes
      ep.find('.' + name + '-panel').addClass('current').siblings('.current').removeClass('current');
    });

    //setup add exercise rows
    $(document).on('click', '.add-exercise', function() {
      var ex_id = $(this).attr('data-exercise-id');
      that.select_exercise(2, ex_id);
      return false;
    });

    //setup muscle group clicks
    muscle_groups_list.find('li a').click(function() {
      var jthis = $(this);
      var url = jthis.attr('href');

      selected_muscle_group_name.html(jthis.text());

      $.get(url, null, function(data) {
        muscle_group_exercises_list.html(data);
        that.switch_view('selected-muscle-group');
      }, 'html');

      return false;
    });

    //back to all muscle groups
    $('.back-to-browse-muscle-group-button', ep).click(function(){
      that.switch_view('browse-exercises');
    });

    //setup search exercise field
    search_field.keyup( function() {
      var val = search_field.val();
      if (val.length > 0){
        var url = search_field.attr('data-autocomplete-url') + '?query=' + search_field.val();

        $.get(url, null, function(data){
          search_results_list.html(data);
        }, 'html');
      } else {
        search_results_list.empty();
      }
    });

    that = {
      select_exercise: function(workout_id, exercise_id) {
        $.getScript('/workout_sets/new.js?workout_id=' + workout_id + '&exercise_id=' + exercise_id );
/*
        var template = $('#workout_sets_fields_template').html(),
            regexp = new RegExp('new_workout_sets', 'g'),
            new_id = new Date().getTime(),
            new_content = $(template.replace(regexp, new_id));

        new_content.find('#workout_workout_sets_attributes_' + new_id + '_exercise_id').val(id);
        new_content.find('.exercise-name').html(name);
        workout_set_list.append(new_content);
*/
      },
      switch_view: function(mode){
        //change the header
        control_headers.filter('.' + mode + '-control-header').addClass('current').siblings().removeClass('current');

        //change the panels
        panels.filter('.' + mode + '-panel').addClass('current').siblings().removeClass('current');

      }
    }

    w.data('add-exercise-widget', that);
  }

  add_ex_widget($('.add-exercise-widget'));

  namenext = function(node) {
    node.show().siblings().hide();
  }
});
