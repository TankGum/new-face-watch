import Toybox.WatchUi;

class PhoneConnectionDisplay extends WatchUi.Drawable {
    var _currentConnected = null;

    function initialize(params) {
        Drawable.initialize(params);
    }

    function setConnected(isConnected) {
        _currentConnected = isConnected;
    }

    function draw(dc) {
        var icon = _currentConnected
            ? WatchUi.loadResource(Rez.Drawables.connected)
            : WatchUi.loadResource(Rez.Drawables.disConnect);

        var x = screenWidth * 0.04;
        var y = screenHeight * 0.47;

        dc.drawBitmap(x, y, icon);
    }
}
