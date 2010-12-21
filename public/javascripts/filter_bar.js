$(function () {
  var app = app || {};

  app.initFilterBar = function () {

    if ($('#start_date').val() != '')
      $('#days').attr('disabled', true);

    $('#filter-bar #start_date').keyup(function () {
      if ($('#start_date').val() != '') {
        $('#days').attr('disabled', true);
      } else {
        $('#days').attr('disabled', false);
      }

    });

  };

  app.initFilterBar();
});
