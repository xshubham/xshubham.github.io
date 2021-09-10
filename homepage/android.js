// Written as ipad.js by Doug McInnes
// Modified by Shubham Kumar

var android = navigator.userAgent.match(/Mobile|Android/i) != null;

if (android) {
  $(function () {
    $('#left-controls, #right-controls').show();
    $('body > #game-container').hide();
    $('body').css('margin', '0px');
    $('#placeholder').prepend($('#game-container').remove());
    $('#game-container').show();
    $('#canvas').attr('width', 500).attr('height', 280).css('background', 'white').css('margin', '0 1');

    $('#meta_tag').attr('content', 'width=device-width; height=device-height; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;');

    $('#left-controls, #right-controls').bind('touchstart touchmove touchend', function (e) {
      if (e.type != 'touchend') {
        for (k in KEY_STATUS) {
          KEY_STATUS[k] = false;
        }
      }
      var touches = e.type == 'touchend' ? e.originalEvent.changedTouches : e.originalEvent.touches;
      for (var i = 0; i < touches.length; i++) {
        var ele = document.elementFromPoint(touches[i].clientX, touches[i].clientY);
        KEY_STATUS[ele.id] = (e.type != 'touchend');
      }
    });

    $('#canvas').bind('touchstart', function (e) {
      window.gameStart = true;
    });
  });
}

