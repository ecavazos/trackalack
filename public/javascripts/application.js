$(function () {

  $.ajaxSetup({dataType:'json'});

  var app = {

  };

  $('#time-entry-form form')
    .live('ajax:success', function (e, data) {
      $('#dialog').dialog('destroy');
      console.log(data);
    })
    .live('ajax:failure', function (e, xhr, status, error) {
      console.log(xhr.responseText);
    });

  $('.add-time-link').click(function (e) {
    e.preventDefault();

    if ($('#dialog').size() == 0) {
      var dialogHtml = '<div id="dialog" title="Time Entry">Loading ...</div>';
      $('body').append(dialogHtml);
    }

    var opts = {
      position: 'center',
      resizable: false,
      width: 500,
      modal: 'true'
    };

    $.get($(this).attr('href'), function (data, textStatus, jqXHR) {
      $('#dialog').empty().append(data);
      $('#time_entry_date').datepicker();
    }, 'html');

    $('#dialog').dialog(opts);

  });

});
