import Toybox.WatchUi;

class DayNightDisplay extends WatchUi.Drawable {
    var _currentPeriod = null;
    var _font = null;

    function initialize(params) {
        Drawable.initialize(params);
        _font = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
    }

    function setPeriod(period) {
        _currentPeriod = period;
    }

    function draw(dc) {
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();

        var x = screenWidth * 0.92;
        var y = screenHeight * 0.47;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, _font, _currentPeriod, Graphics.TEXT_JUSTIFY_CENTER);
    }
}
