import Toybox.WatchUi;

class ChargingStatusDisplay extends WatchUi.Drawable {
    var _isCharging;
    var chargingIcon;

    function initialize(params) {
        Drawable.initialize(params);
        chargingIcon = WatchUi.loadResource(Rez.Drawables.ChargingStatus);
    }

    // Nếu muốn cập nhật sau, có thể cung cấp setter
    function setChargingStatus(isCharging) {
        _isCharging = isCharging;
    }

    function draw(dc) {
        var x = screenWidth / 2 - (chargingIcon.getWidth() / 2);
        var y = screenHeight * 0.9;
        dc.drawBitmap(Math.round(x), Math.round(y), chargingIcon);
    }
}

