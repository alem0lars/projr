function hide($selector, time) {
  $selector.stop().animate({'marginLeft':'-240px'}, time, function() {
    $('.nav-elem-open').hide();
    $('.nav-elem-close').show();
  });
}
function show($selector, time) {
  $selector.stop().animate({'marginLeft':'-2px'}, time, function() {
    $('.nav-elem-close').hide();
    $('.nav-elem-open').show();
  });
}

$(document).ready(function() {
  hide($('.nav-elem'), 1000);

  $('.nav-elem-wrp').hover(
    function () {
      show($('.nav-elem',$(this)), 200);
    },
    function () {
      hide($('.nav-elem',$(this)), 200);
    }
  );
});
