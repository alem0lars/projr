define(['jquery'], function ($) {
  return {
    fluidify: function (video_id) {
      if ($('#' + video_id).length > 0) {
        _V_(video_id).ready(function () {
          var player = this; // Store the video object
          var aspectRatio = 9 / 16; // Make up an aspect ratio

          function resize_videojs() {
            // Get the parent element's actual width
            var width = document.getElementById(player.id).parentElement.offsetWidth;
            // Set width to fill parent element, Set height
            player.width(width).height(width * aspectRatio);
          }

          resize_videojs(); // Initialize the function
          window.onresize = resize_videojs; // Call the function on resize
        });
      }
    }
  }
});
