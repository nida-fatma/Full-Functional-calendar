// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .
//= require moment
//= require fullcalendar

$(document).ready(function(){
 $("#repeat_event").change(function(){
  if ($(this).find(':selected').val() == 'Once') {
    $('#repeat_freq').css('display', 'none');
  }
  else {
    $("#repeat_freq").css("display", "block");
  }
  if ($(this).find(':selected').val() == 'Weekly') {
    $('#repeat_week').css('display', 'block');
    $('#repeat_week_days').prop('required',true);
  }
  else {
    $("#repeat_week").css("display", "none");
    $('#repeat_week_days').prop('required',false);
  }
 });
 $('.calendar').fullCalendar({
  header: {
        //view names are: month, agendaWeek, agendaDay
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      select: function(start, end , jsEvent, view) {
        $("#dialog").dialog({
          autoOpen: false,

        }
        );
        currentHours = start.hour();
        currentMinutes = start.minute();

        if (start.hour().toString().length == 1) {
            currentHours = "0" + start.hour();
        }
        if (start.minute().toString().length == 1) {
            currentMinutes = "0" + start.minute();
        }
        $('#dialog').dialog('open');
        $('#event_start_time_1i').val(start.year());
        $('#event_start_time_2i').val(start.month() + 1);
        $('#event_start_time_3i').val(start.date());
        $('#event_start_time_4i').val(currentHours);
        $('#event_start_time_5i').val(currentMinutes);
      },
      selectable: true,
      lazyFetching: true,
      events: '/events.json',
      height: 500,

    })
});
