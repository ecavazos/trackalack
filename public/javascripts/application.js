$(function () {
  /*
  jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", ( $(window).height() - this.outerHeight() ) / 2 + $(window).scrollTop() + "px");
    this.css("left", ( $(window).width() - this.outerWidth() ) / 2 + $(window).scrollLeft() + "px");
    return this;
  };
  */

  $('a').click(function () {
    var dialogHtml = '<div id="dialog" title="dialog"><input type="text" /><input type="submit" value="WTF" /></div>';

    var opts = {
      closeText: 'x',
      position: 'center'
    };

    $(dialogHtml).dialog(opts);
  });
});
