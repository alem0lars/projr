define(['jquery', 'app/video'], function ($, video) {
  $(document).ready(function () {

    // Sized thumbnails of the same height
    var $sized_thumbs = $('.thumbnail.sized');
    $sized_thumbs.css({
      'height': $sized_thumbs.height()
    });

    // Fluidify the index video (if present)
    video.fluidify('index-video');

    // Render the slideshow
    if ($("#index-slideshow").length > 0) {
      $('#index-slideshow').nivoSlider({
        effect: 'slideInLeft',
        animSpeed: 256,
        pauseTime: 4096,
        startSlide: 0,
        directionNav: true,
        controlNav: true,
        controlNavThumbs: false,
        pauseOnHover: true,
        manualAdvance: false,
        prevText: 'Prev',
        nextText: 'Next',
        randomStart: false
      });
    }

  });
});
