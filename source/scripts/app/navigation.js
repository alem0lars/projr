function hide($selector, time) {
  $selector.stop().animate({'marginLeft':'-240px'}, time, function() {
    $('.nav-elem-open').hide(time / 2, function() {
      $('.nav-elem-close').show(time * 2);
    });
  });
}
function show($selector, time) {
  $selector.stop().animate({'marginLeft':'-2px'}, time, function() {
    $('.nav-elem-close').hide(time / 2, function() {
      $('.nav-elem-open').show(time * 2);
    });
  });
}

$(document).ready(function() {
  hide($('.nav-elem'), 1000);

  $('.nav-elem-wrp').hover(
    function () {
      show($('.nav-elem',$(this)), 1000);
    },
    function () {
      hide($('.nav-elem',$(this)), 1000);
    }
  );
});
