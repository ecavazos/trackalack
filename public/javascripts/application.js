$(function () {

  $.ajaxSetup({dataType:'json'});

  var app = {

  };

  $('#time-entry-form form')
    .live('submit', function (e) {
      $('#time_errors').remove();
      $('#time_entry_submit').attr('disabled', 'disabled');
    })
    .live('ajax:success', function (e, data) {
      $('#dialog').dialog('destroy');
      $.get('/stream', function (data) {
        $('#stream').html(data);
      }, 'html');
    })
    .live('ajax:error', function (e, xhr, status, error) {
      var errors = $.parseJSON(xhr.responseText);
      $(this).children('.actions').before('<div id="time_errors"><ul></ul></div>');
      $('#time_entry_submit').removeAttr('disabled');
      for (var i in errors)
        $('#time_errors ul').append('<li>' + errors[i] + '</li>');
    });

  $('.add-time-link, .edit-time-link').live('click', function (e) {
    e.preventDefault();
    var dialog = $('#dialog');
    var loadMessage = 'Loading ...';

    if (dialog.size() == 0) {
      var dialogHtml = '<div id="dialog" title="Time Entry">' + loadMessage + 'div>';
      $('body').append(dialogHtml);
    } else {
      dialog.empty().append(loadMessage);
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

  var cache = {}, lastXhr;

  $( "#search_term" ).autocomplete({
    minLength: 2,
    source: function( request, response ) {
      var term = request.term;
      if ( term in cache ) {
        response( cache[ term ] );
        return;
      }

      lastXhr = $.getJSON( "/search", request, function ( data, status, xhr) {
        cache[ term ] = data;
        if ( xhr === lastXhr ) {
          response($.map(data, function (x) {
            return {
              label: x.search_index.name,
              value: x.search_index.id
            };
          }));
        }
      });
    }
  });

});
