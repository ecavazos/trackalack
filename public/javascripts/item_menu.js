$(function () {
  var app = app || {};

  app.initMenu = function () {

    $('html').click(function (e) {
      $('#item-menu').remove();
      $('.item-menu-button').removeClass('active');
      e.preventDefault();
    });

    $('.item-menu-button').click(function (e) {
      $('#item-menu').remove();

      if ($(this).hasClass('active')) {
        $(this).removeClass('active');
        return;
      } else {
        $(this).addClass('active');
      }

      var menu = '<div id="item-menu"><ul></ul></div>';

      $(this).after(menu);

      $('#item-menu ul')
        .append('<li id="edit-item">Edit</li>')
        .append('<li id="delete-item">Delete</li>');

      $('#delete-item').click(function (e) {
        var conf = confirm("Are you sure?");
        if (conf) {
          // do something
          return true;
        }
        return false;
      });

      $('#item-menu ul li').mouseover(function () {
        $(this).css('cursor', 'pointer');
      });

      e.stopPropagation();
      e.preventDefault();

    });
  };

  app.initMenu();
});
