//= require moment
//= require bootstrap-datetimepicker

$(document).on('ready page:change', function() {
  $('input.datetime_picker').datetimepicker();
  $('.input-group.datetime_picker .input-group-btn').on('click', function() {
    $(this).prev('input.datetime_picker').focus().click();
  });
});
