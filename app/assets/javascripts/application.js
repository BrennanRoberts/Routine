//= require jquery
//= require jquery-ui
//= require underscore
//= require backbone
//= require_self

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
  var $el = $(this);
  $.ajax(
    {
      type: 'put',
      url: $el.attr('href'),
      success: function(){
        $el.addClass('complete');
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

  var ExercisePicker = Backbone.View.extend({

    events: {
      'click .open-widget-button': '_onOpenClick',
      'click .min-widget'        : '_onMinClick',
      'click .control-bar .control-bar-button': '_onTabClick',
      'click .add-exercise'      : '_onExerciseClick',
      'click .muscle-groups a'   : '_onMuscleGroupClick',
      'click .back-to-browse-muscle-group-button' : '_onBackClick',
      'keyup input[type=text][data-autocomplete-url]': '_onSearchKeyup'
    },

    initialize: function() {
      this.$workout_set_list = this.$('.workout_sets');
      this.$picker = this.$('.exercise-picker');
      this.$control_bar = this.$('.control-bar');
      this.$control_headers = this.$('.control-headers').children();
      this.$browse_exercises_button = $('.browse-exercises-button', this.$control_bar);
      this.$search_exercises_button = $('.search-exercises-button', this.$control_bar);
      this.$panels = this.$('.exercise-picker-panel');
      this.$muscle_groups_list = this.$('ul.muscle-groups'); // list of muscle groups
      this.$muscle_group_exercises_list = this.$('.muscle-group-exercises'); // list of exercises within a muscle group
      this.$selected_muscle_group_name = this.$('.selected-muscle-group-control-header .muscle-group-name');
      this.$search_field = this.$('input[type=text][data-autocomplete-url]'); // search exercises text field
      this.$search_results_list = this.$('.search-exercises-results-list'); // list of search results

      this.cache = {};
    },

    _onOpenClick: function(e) {
      this.$('.open-widget-button').hide();
      this.$picker.show();
      // TODO this doesn't really need to be a link...
      e.preventDefault();
    },

    //close widget
    _onMinClick: function() {
      this$picker.hide();
      this.$('.open-widget-button').show();
    },

    //setup top controls
    _onTabClick: function(e) {
      var jthis = $(e.target);
      var name = jthis.attr('data-tab-name');

      //adjust buttons
      jthis.addClass('current').siblings().removeClass('current');

      //adjust control headers
      this.switch_view(name);

      //adjust picker panes
      this.$picker.find('.' + name + '-panel').addClass('current').siblings('.current').removeClass('current');
    },

    _onExerciseClick: function(e) {
      var ex_id = $(e.currentTarget).attr('data-exercise-id');
      this.select_exercise(2, ex_id);
    },

    _onMuscleGroupClick: function(e) {
      var jthis = $(e.currentTarget);
      console.log(e);
      var url = jthis.attr('href');

      this.$selected_muscle_group_name.html(jthis.text());

      $.get(url, null, _.bind(function(data) {
        this.$muscle_group_exercises_list.html(data);
        this.switch_view('selected-muscle-group');
      }, this), 'html');

      // TODO this doesn't really need to be a link...
      e.preventDefault();
    },

    _onBackClick: function() {
      this.switch_view('browse-exercises');
    },

    _onSearchKeyup: function(e) {
      var $field = $(e.currentTarget);
      var val = $field.val();
      var url;

      if (val.length > 0){
        url = $field.attr('data-autocomplete-url') + '?query=' + val;

        $.get(url, null, _.bind(function(data){
          this.$search_results_list.html(data);
        }, this), 'html');
      } else {
        this.$search_results_list.empty();
      }
    },

    select_exercise: function(workout_id, exercise_id) {
      $.getScript('/workout_sets/new.js?workout_id=' + workout_id + '&exercise_id=' + exercise_id );
      // var template = $('#workout_sets_fields_template').html();
      // var regexp = new RegExp('new_workout_sets', 'g');
      // var new_id = new Date().getTime();
      // var new_content = $(template.replace(regexp, new_id));

      // new_content.find('#workout_workout_sets_attributes_' + new_id + '_exercise_id').val(id);
      // new_content.find('.exercise-name').html(name);
      // workout_set_list.append(new_content);
    },

    switch_view: function(mode) {
      //change the header
      this.$control_headers.filter('.' + mode + '-control-header').addClass('current').siblings().removeClass('current');

      //change the panels
      this.$panels.filter('.' + mode + '-panel').addClass('current').siblings().removeClass('current');

    }

    // w.data('add-exercise-widget', that);
  });

  // TODO only load and run if necessary
  (function() {
    var ew = $('.add-exercise-widget');
    if (ew.length) {
      new ExercisePicker({
        el: ew
      });
    }
  }());

});

