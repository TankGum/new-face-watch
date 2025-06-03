import Toybox.WatchUi;
using Toybox.Application as App;

class DrawLineLayout extends WatchUi.Drawable {

    function initialize(params) {
        Drawable.initialize(params);
    }

    function getColor(value) {
        var colorMap = {
            0 => Graphics.COLOR_BLACK,
            1 => Graphics.COLOR_ORANGE,
            2 => Graphics.COLOR_WHITE,
            3 => Graphics.COLOR_GREEN,
            4 => Graphics.COLOR_BLUE,
            5 => Graphics.COLOR_PURPLE,
            6 => Graphics.COLOR_DK_RED
        };
        return (colorMap.hasKey(value)) ? colorMap[value] : Graphics.COLOR_WHITE;
    }

    function sx(x, scaleX) { 
      return x * scaleX;
    }

    function sy(x, scaleY) { 
      return x * scaleY;
    }

    function draw(dc) {
      var borderColor = App.getApp().getBorderColor();
      var fillColor = App.getApp().getFillColor();

      var screenWidth = dc.getWidth();
      var screenHeight = dc.getHeight();
      var scaleX = screenWidth / 240.0;
      var scaleY = screenHeight / 240.0;

      // Dòng 1
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(150, scaleY));
      dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(149, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(150, scaleY));
      dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(149, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(121, scaleY), sx(30, scaleX), sy(151, scaleY));
      dc.drawLine(sx(0, scaleX), sy(118, scaleY), sx(30, scaleX), sy(148, scaleY));

      // Dòng 2
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
      dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
      dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(151, scaleY), sx(210, scaleX), sy(151, scaleY));
      dc.drawLine(sx(30, scaleX), sy(148, scaleY), sx(210, scaleX), sy(148, scaleY));

      // Dòng 3
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(120, scaleY));
      dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(119, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(120, scaleY));
      dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(119, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(151, scaleY), sx(240, scaleX), sy(121, scaleY));
      dc.drawLine(sx(210, scaleX), sy(148, scaleY), sx(240, scaleX), sy(118, scaleY));

      // Dòng 4
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(180, scaleY), sx(30, scaleX), sy(150, scaleY));
      dc.drawLine(sx(0, scaleX), sy(179, scaleY), sx(30, scaleX), sy(149, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(180, scaleY), sx(30, scaleX), sy(150, scaleY));
      dc.drawLine(sx(0, scaleX), sy(179, scaleY), sx(30, scaleX), sy(149, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(181, scaleY), sx(30, scaleX), sy(151, scaleY));
      dc.drawLine(sx(0, scaleX), sy(178, scaleY), sx(30, scaleX), sy(148, scaleY));

      // Dòng 5
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
      dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
      dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(151, scaleY), sx(210, scaleX), sy(151, scaleY));
      dc.drawLine(sx(30, scaleX), sy(148, scaleY), sx(210, scaleX), sy(148, scaleY));

      // Dòng 6
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(180, scaleY));
      dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(179, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(180, scaleY));
      dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(179, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(151, scaleY), sx(240, scaleX), sy(181, scaleY));
      dc.drawLine(sx(210, scaleX), sy(148, scaleY), sx(240, scaleX), sy(178, scaleY));

      // Dòng 7
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(90, scaleY));
      dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(89, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(90, scaleY));
      dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(89, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(121, scaleY), sx(30, scaleX), sy(91, scaleY));
      dc.drawLine(sx(0, scaleX), sy(118, scaleY), sx(30, scaleX), sy(88, scaleY));

      // Dòng 8
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
      dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
      dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(91, scaleY), sx(210, scaleX), sy(91, scaleY));
      dc.drawLine(sx(30, scaleX), sy(88, scaleY), sx(210, scaleX), sy(88, scaleY));

      // Dòng 9
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(120, scaleY));
      dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(119, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(120, scaleY));
      dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(119, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(91, scaleY), sx(240, scaleX), sy(121, scaleY));
      dc.drawLine(sx(210, scaleX), sy(88, scaleY), sx(240, scaleX), sy(118, scaleY));

      // Dòng 10
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(60, scaleY), sx(30, scaleX), sy(90, scaleY));
      dc.drawLine(sx(0, scaleX), sy(59, scaleY), sx(30, scaleX), sy(89, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(60, scaleY), sx(30, scaleX), sy(90, scaleY));
      dc.drawLine(sx(0, scaleX), sy(59, scaleY), sx(30, scaleX), sy(89, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(0, scaleX), sy(61, scaleY), sx(30, scaleX), sy(91, scaleY));
      dc.drawLine(sx(0, scaleX), sy(58, scaleY), sx(30, scaleX), sy(88, scaleY));

      // Dòng 11
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
      dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
      dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(30, scaleX), sy(91, scaleY), sx(210, scaleX), sy(91, scaleY));
      dc.drawLine(sx(30, scaleX), sy(88, scaleY), sx(210, scaleX), sy(88, scaleY));

      // Dòng 12
      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(60, scaleY));
      dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(59, scaleY));

      dc.setColor(getColor(fillColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(60, scaleY));
      dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(59, scaleY));

      dc.setColor(getColor(borderColor), Graphics.COLOR_TRANSPARENT);
      dc.drawLine(sx(210, scaleX), sy(91, scaleY), sx(240, scaleX), sy(61, scaleY));
      dc.drawLine(sx(210, scaleX), sy(88, scaleY), sx(240, scaleX), sy(58, scaleY));
    }
}
