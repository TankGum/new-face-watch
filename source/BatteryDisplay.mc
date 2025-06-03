import Toybox.WatchUi;

class BatteryDisplay extends WatchUi.Drawable {
    var _battery = null;
    var _font = null;

    function initialize(params) {
        Drawable.initialize(params);
        _font = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
    }

    function setBatteryLevel(battery) {
        _battery = battery;
    }

    function draw(dc) {
        if (_battery == null) {return;}

        var batteryStr = _battery.format("%d") + "%";

        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();

        // Hiển thị text
        var xText = screenWidth / 2;
        var yText = screenHeight * 0.08;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(xText, yText, _font, batteryStr, Graphics.TEXT_JUSTIFY_CENTER);

        // Hiển thị thanh pin
        var xBar = screenWidth * 0.33;
        var yBar = screenHeight * 0.08;
        var widthBar = screenWidth * 0.35;
        var heightBar = screenHeight * 0.06;
        Utils.drawBatteryBar(dc, Math.round(xBar), Math.round(yBar), Math.round(widthBar), Math.round(heightBar), _battery);
    }
}

