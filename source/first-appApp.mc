import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Time.Gregorian as Date;

class first_appApp extends Application.AppBase {
    var _borderColor;
    var _fillColor;
    var currentDateString;

    function initialize() {
        AppBase.initialize();
        _borderColor = getColorOrDefault("borderLineColor", 1);
        _fillColor = getColorOrDefault("fillLineColor", 3);
        refreshDateString();
    }

    function onSettingsChanged() {
        _borderColor = getColorOrDefault("borderLineColor", 1);
        _fillColor = getColorOrDefault("fillLineColor", 3);
    }

    function getColorOrDefault(key, defaultVal) {
        var val = getProperty(key);
        return (val == null) ? defaultVal : val;
    }

    function getBorderColor() {
        return _borderColor;
    }

    function getFillColor() {
        return _fillColor;
    }

    function refreshDateString() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var newDate = Lang.format("$1$\n$2$ $3$", [date.day_of_week, date.month, date.day]);

        if (currentDateString == null || !currentDateString.equals(newDate)) {
            currentDateString = newDate;
        }
    }

    function getDateString() {
        return currentDateString;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new first_appView() ];
    }

}

function getApp() as first_appApp {
    return Application.getApp() as first_appApp;
}