$(function () {
  /*
  jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", ( $(window).height() - this.outerHeight() ) / 2 + $(window).scrollTop() + "px");
    this.css("left", ( $(window).width() - this.outerWidth() ) / 2 + $(window).scrollLeft() + "px");
    return this;
  };
  */

  var app = {

  };

  $('#test').click(function (e) {
    var dialogHtml = '<div id="dialog" title="Time Entry"></div>';

    var opts = {
      position: 'center'
    };

    $(dialogHtml).dialog(opts);

    e.preventDefault();
  });

});
