$(function () {
  var app = app || {};

  app.initFilterBar = function () {
    var start_date = $('#start_date');
    var end_date   = $('#end_date');
    var days       = $('#days');

    start_date.datepicker();
    end_date.datepicker();

    var isRangeDirty = function () {
      return (start_date.val() != '' || end_date.val() != '');
    };

    if (isRangeDirty())
      days.attr('disabled', true);

    $.fn.add.call(start_date, end_date).keyup(function () {
      if (isRangeDirty()) {
        days.attr('disabled', true);
      } else {
        days.attr('disabled', false);
      }
    });

    $('#clear').click(function (e) {
      start_date.val('');
      end_date.val('');
      days.attr('disabled', false);
      e.preventDefault();
    });

  };

  app.initFilterBar();
});
