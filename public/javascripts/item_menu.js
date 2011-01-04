$(function () {
  var app = app || {};

  app.initMenu = function () {

    $('html').click(function (e) {
      $('#item-menu').remove();
    });

    $('.item-menu-button').click(function (e) {
      $('#item-menu').remove();

      var menu = '<div id="item-menu"><ul></ul></div>';

      $(this).after(menu);
      $('#item-menu ul')
        .append('<li id="edit-item">Edit</li>')
        .append('<li id="delete-item">Delete</li>');

      $('#item-menu ul li').mouseover(function () {
        $(this).css('cursor', 'pointer');
      });

      e.stopPropagation();
      e.preventDefault();

    });
  };

  app.initMenu();
});
