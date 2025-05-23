import Toybox.Graphics;

module DrawLine {
  var borderLineColor = Graphics.COLOR_WHITE; // TODO: cho user chọn màu
  var fillLineColor = Graphics.COLOR_BLACK; // TODO: cho user chọn màu

  function sx(x, scaleX) { 
    return x * scaleX;
  }
  function sy(x, scaleY) { 
    return x * scaleY;
  }

  function drawLineLayout(dc as Dc) {
    var screenWidth = dc.getWidth();
    var screenHeight = dc.getHeight();
    var scaleX = screenWidth / 240.0;
    var scaleY = screenHeight / 240.0;

    

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
