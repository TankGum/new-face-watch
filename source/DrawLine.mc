import Toybox.Graphics;
using Toybox.Application as App;
import Toybox.System;

module DrawLine {
  

  function getBorderLineColor() {
    var value = App.getApp().getProperty("borderLineColor");

    if (value == 0) {
      return Graphics.COLOR_TRANSPARENT;
    } else if (value == 1) {
      return Graphics.COLOR_ORANGE;
    } else if (value == 2) {
      return Graphics.COLOR_WHITE;
    } else if (value == 3) {
      return Graphics.COLOR_BLACK;
    } else if (value == 4) {
      return Graphics.COLOR_GREEN;
    } else if (value == 5) {
      return Graphics.COLOR_BLUE;
    } else if (value == 6) {
      return Graphics.COLOR_PURPLE;
    } else if (value == 8) {
      return Graphics.COLOR_DK_RED;
    } else {
      return Graphics.COLOR_WHITE;
    }
  }

  function getFillLineColor() {
    var value = App.getApp().getProperty("fillLineColor");

    if (value == 0) {
      return Graphics.COLOR_BLACK;
    } else if (value == 1) {
      return Graphics.COLOR_ORANGE;
    } else if (value == 2) {
      return Graphics.COLOR_WHITE;
    } else if (value == 3) {
      return Graphics.COLOR_GREEN;
    } else if (value == 4) {
      return Graphics.COLOR_BLUE;
    } else if (value == 5) {
      return Graphics.COLOR_PURPLE;
    } else if (value == 6) {
      return Graphics.COLOR_DK_RED;
    } else {
      return Graphics.COLOR_WHITE;
    }
  }

  function sx(x, scaleX) { 
    return x * scaleX;
  }
  function sy(x, scaleY) { 
    return x * scaleY;
  }

  var cachedBorderLineColor = null;
  var cachedFillLineColor = null;

  function drawLineLayout(dc as Dc) {
    var screenWidth = dc.getWidth();
    var screenHeight = dc.getHeight();
    var scaleX = screenWidth / 240.0;
    var scaleY = screenHeight / 240.0;

    var borderLineColor = getBorderLineColor();
    var fillLineColor = getFillLineColor();

    if (cachedBorderLineColor == borderLineColor && cachedFillLineColor == fillLineColor) {
        return; // Không cần vẽ lại
    }

    // Dòng 1
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(150, scaleY));
    dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(149, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(150, scaleY));
    dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(149, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(121, scaleY), sx(30, scaleX), sy(151, scaleY));
    dc.drawLine(sx(0, scaleX), sy(118, scaleY), sx(30, scaleX), sy(148, scaleY));

    // Dòng 2
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
    dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
    dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(151, scaleY), sx(210, scaleX), sy(151, scaleY));
    dc.drawLine(sx(30, scaleX), sy(148, scaleY), sx(210, scaleX), sy(148, scaleY));

    // Dòng 3
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(120, scaleY));
    dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(119, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(120, scaleY));
    dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(119, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(151, scaleY), sx(240, scaleX), sy(121, scaleY));
    dc.drawLine(sx(210, scaleX), sy(148, scaleY), sx(240, scaleX), sy(118, scaleY));

    // Dòng 4
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(180, scaleY), sx(30, scaleX), sy(150, scaleY));
    dc.drawLine(sx(0, scaleX), sy(179, scaleY), sx(30, scaleX), sy(149, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(180, scaleY), sx(30, scaleX), sy(150, scaleY));
    dc.drawLine(sx(0, scaleX), sy(179, scaleY), sx(30, scaleX), sy(149, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(181, scaleY), sx(30, scaleX), sy(151, scaleY));
    dc.drawLine(sx(0, scaleX), sy(178, scaleY), sx(30, scaleX), sy(148, scaleY));

    // Dòng 5
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
    dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(150, scaleY), sx(210, scaleX), sy(150, scaleY));
    dc.drawLine(sx(30, scaleX), sy(149, scaleY), sx(210, scaleX), sy(149, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(151, scaleY), sx(210, scaleX), sy(151, scaleY));
    dc.drawLine(sx(30, scaleX), sy(148, scaleY), sx(210, scaleX), sy(148, scaleY));

    // Dòng 6
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(180, scaleY));
    dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(179, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(150, scaleY), sx(240, scaleX), sy(180, scaleY));
    dc.drawLine(sx(210, scaleX), sy(149, scaleY), sx(240, scaleX), sy(179, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(151, scaleY), sx(240, scaleX), sy(181, scaleY));
    dc.drawLine(sx(210, scaleX), sy(148, scaleY), sx(240, scaleX), sy(178, scaleY));

    // Dòng 7
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(90, scaleY));
    dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(89, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(120, scaleY), sx(30, scaleX), sy(90, scaleY));
    dc.drawLine(sx(0, scaleX), sy(119, scaleY), sx(30, scaleX), sy(89, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(121, scaleY), sx(30, scaleX), sy(91, scaleY));
    dc.drawLine(sx(0, scaleX), sy(118, scaleY), sx(30, scaleX), sy(88, scaleY));

    // Dòng 8
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
    dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
    dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(91, scaleY), sx(210, scaleX), sy(91, scaleY));
    dc.drawLine(sx(30, scaleX), sy(88, scaleY), sx(210, scaleX), sy(88, scaleY));

    // Dòng 9
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(120, scaleY));
    dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(119, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(120, scaleY));
    dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(119, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(91, scaleY), sx(240, scaleX), sy(121, scaleY));
    dc.drawLine(sx(210, scaleX), sy(88, scaleY), sx(240, scaleX), sy(118, scaleY));

    // Dòng 10
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(60, scaleY), sx(30, scaleX), sy(90, scaleY));
    dc.drawLine(sx(0, scaleX), sy(59, scaleY), sx(30, scaleX), sy(89, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(60, scaleY), sx(30, scaleX), sy(90, scaleY));
    dc.drawLine(sx(0, scaleX), sy(59, scaleY), sx(30, scaleX), sy(89, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(0, scaleX), sy(61, scaleY), sx(30, scaleX), sy(91, scaleY));
    dc.drawLine(sx(0, scaleX), sy(58, scaleY), sx(30, scaleX), sy(88, scaleY));

    // Dòng 11
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
    dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(90, scaleY), sx(210, scaleX), sy(90, scaleY));
    dc.drawLine(sx(30, scaleX), sy(89, scaleY), sx(210, scaleX), sy(89, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(30, scaleX), sy(91, scaleY), sx(210, scaleX), sy(91, scaleY));
    dc.drawLine(sx(30, scaleX), sy(88, scaleY), sx(210, scaleX), sy(88, scaleY));

    // Dòng 12
    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(60, scaleY));
    dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(59, scaleY));

    dc.setColor(fillLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(90, scaleY), sx(240, scaleX), sy(60, scaleY));
    dc.drawLine(sx(210, scaleX), sy(89, scaleY), sx(240, scaleX), sy(59, scaleY));

    dc.setColor(borderLineColor, Graphics.COLOR_TRANSPARENT);
    dc.drawLine(sx(210, scaleX), sy(91, scaleY), sx(240, scaleX), sy(61, scaleY));
    dc.drawLine(sx(210, scaleX), sy(88, scaleY), sx(240, scaleX), sy(58, scaleY));
}

}
