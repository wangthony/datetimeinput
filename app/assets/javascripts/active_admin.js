//= require active_admin/base

$(document).ready(function () {
  $(".datepicker_with_time input, .datepicker_with_time select").change(function () {
    var fieldName = this.name.replace(/_date|_time/, '');
    var date = $("[name='" + fieldName.replace(']', '_date]') + "']").val(),
      time = $("[name='" + fieldName.replace(']', '_time]') + "']").val(),
      time_zone = $("[name='" + fieldName.replace(']', '_tz]') + "']").val();

    $("[name='" + fieldName + "']").attr('value', date + ' ' + time + ' ' + time_zone);
  });
});
