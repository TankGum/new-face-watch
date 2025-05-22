import Toybox.Graphics;

module DrawLine {
  function drawLineLayout(dc as Dc) {
    dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);

    dc.drawLine(0, 120, 30, 150);
    dc.drawLine(30, 150, 210, 150);
    dc.drawLine(210, 150, 240, 120);

    // Nhóm dưới
    dc.drawLine(0, 180, 30, 150);
    dc.drawLine(30, 150, 210, 150);
    dc.drawLine(210, 150, 240, 180);



    dc.drawLine(0, 120, 30, 90);
    dc.drawLine(30, 90, 210, 90);
    dc.drawLine(210, 90, 240, 120); 

    // Nhóm trên (đối xứng)
    dc.drawLine(0, 60, 30, 90); // Đường chéo lên
    dc.drawLine(30, 90, 210, 90); // Đường ngang (y = 90)
    dc.drawLine(210, 90, 240, 60); // Đường chéo lên

  }
}
