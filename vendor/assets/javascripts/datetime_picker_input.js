//= require moment
//= require bootstrap-datetimepicker

$(document).on('ready page:change turbolinks:load', function() {
  $('input.date_time_picker').datetimepicker();
  $('.input-group.date_time_picker .input-group-btn').on('click', function() {
    $(this).prev('input.date_time_picker').focus().click();
  });
});
