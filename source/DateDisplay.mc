import Toybox.WatchUi;

class DateDisplay extends WatchUi.Drawable {
    var _dateString;
    var _font;

    function initialize(params) {
        Drawable.initialize(params);
        _font = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
    }

    function setDate(str) {
        _dateString = str;
    }

    function draw(dc) {
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();
        var x = screenWidth / 2;
        var y = screenHeight * 0.2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, _font, _dateString, Graphics.TEXT_JUSTIFY_CENTER);
    }
}

