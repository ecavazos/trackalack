var app = app || {};

$(function () {

  var submit = $('#search-box input[type="submit"]');
  var cache = {}, lastXhr, selected;

  $('#search-box form').submit(function (event) {
    event.preventDefault();
    if (selected)
      location.href = selected.path;
  });

  $('#search-term').autocomplete({
    minLength: 2,
    change: function (event, ui) {
      if(ui.item) return;
      selected = null;
      $(this).val('');
    },
    focus: function (event, ui) {
      $(this).val(ui.item.label);
      event.preventDefault();
    },
    select: function (event, ui) {
      event.preventDefault();
      $(this).val(ui.item.label);
      selected = ui.item;
      submit.removeAttr('disabled');
    },
    source: function (request, response) {
      var term = request.term;
      if (term in cache) {
        response(cache[term]);
        return;
      }

      lastXhr = $.getJSON( '/search', request, function (data, status, xhr) {
        var flatten = function (data) {
          return $.map(data, function (x) {
            return {
              label: x.name,
              value: x.id,
              type:  x.type,
              path:  x.path
            };
          });
        };

        cache[term] = flatten(data);
        if (xhr === lastXhr) {
          response(cache[term]);
        }
      });
    }
  })
  .data('autocomplete')._renderItem = function(ul, item) {
    return $('<li></li>')
      .data('item.autocomplete', item)
      .append('<a>' + item.label + '<span class="idx-type">' + item.type + '</span></a>')
      .appendTo(ul);
  };

  submit.attr('disabled', 'disabled');
});
