$(function () {
  var app = app || {};

  app.initMenu = function () {

    $('html').click(function (e) {
      $('#item-menu').remove();
      $('.item-menu-button').removeClass('active');
    });

    $('.item-menu-button').click(function (e) {
      $('#item-menu').remove();

      if ($(this).hasClass('active')) {
        $(this).removeClass('active');
        e.preventDefault();
        return;
      } else {
        $(this).addClass('active');
      }

      var menu = '<div id="item-menu"><ul></ul></div>';

      $(this).after(menu);

      var menuItems = $(this).data('items');

      for (var i in menuItems) {
        var link = menuItems[i];
        if (link.name.toLowerCase() == 'destroy') {
          $('#item-menu ul')
            .append('<li><a href="'
                + link.path
                + '" data-confirm="Are you sure?" data-method="delete" rel="nofollow">'
                + link.name + '</a></li>');
        } else {
          $('#item-menu ul')
            .append('<li><a href="' + link.path + '" >' + link.name + '</a></li>');
        }
      }

      // set menu's left position
      var left = $(this).offset().left + $(this).outerWidth() - $('#item-menu').outerWidth();
      var width = $('#item-menu').css('left', left);

      $('#item-menu ul li')
        .click(function (e) {
          if (this !== e.target) return; // prevent stack overflow
          var link = $(this).children('a').first();
          if (link.data('method') == 'delete') {
            link.trigger('click');
            return;
          }
          location.href = link.attr('href');
        })
        .mouseover(function () {
          $(this).css('cursor', 'pointer');
        });

      e.stopPropagation();
      e.preventDefault();

    });
  };

  app.initMenu();
});
