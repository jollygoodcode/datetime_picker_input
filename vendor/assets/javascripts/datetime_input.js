//= require moment
//= require bootstrap-datetimepicker

$(function() {
  $(document).on('ready page:change', function() {
    $('input.datetime_picker').datetimepicker();
  });
});
