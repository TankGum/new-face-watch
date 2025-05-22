import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Mon;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;
using Toybox.Application;
using Toybox.Application as App;

using Utils;
using DrawLine;

var textColor = Graphics.COLOR_WHITE;

class first_appView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        setThemeBackground(dc);
        
        var battery = Sys.getSystemStats().battery;
        Utils.drawBatteryBar(dc, 79, 20, 81, 14, battery);

        displayProgressPercentages(dc);
        DrawLine.drawLineLayout(dc);
        setBatteryDisplay(dc);
        setDateDisplay(dc);
        
        setConnectionStatusDisplay(dc);
        displayDayNight(dc);

        setClockDisplay(dc);
        checkChargingStatus(dc);

        // Hiện thị 2 fields top
        setDynamicFields(dc);

        setTextColor(dc, textColor);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    // Hiển thị giờ
    private function setClockDisplay(dc as Dc) {
      var clockTime = Sys.getClockTime();

      var mHoursFont = WatchUi.loadResource(Rez.Fonts.myFont);
      var x = 30;
      var y = 120;

      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      // Chuỗi giờ/phút/giây
      var hourStr = clockTime.hour.toString();
      if (hourStr.length() == 1) {
        x = 45;
      }
      var minStr = clockTime.min.format("%02d");
      var secStr = clockTime.sec.format("%02d");

      // Vẽ giờ
      dc.drawText(
        x,
        y,
        mHoursFont,
        hourStr,
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
      x += dc.getTextWidthInPixels(hourStr, mHoursFont);

      // Vẽ dấu ":"
      dc.drawText(
        x,
        y,
        mHoursFont,
        ":",
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
      x += dc.getTextWidthInPixels(":", mHoursFont);

      // Vẽ phút
      dc.drawText(
        x,
        y,
        mHoursFont,
        minStr,
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
      x += dc.getTextWidthInPixels(minStr, mHoursFont);

      // Vẽ dấu ":"
      dc.drawText(
        x,
        y,
        mHoursFont,
        ":",
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
      x += dc.getTextWidthInPixels(":", mHoursFont);

      // Vẽ giây
      dc.drawText(
        x,
        y,
        mHoursFont,
        secStr,
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
    }

    private function drawDataField(dc as Dc, fieldType as String, x as Number, y as Number) {
      var valueStr = "--";
      var icon = null;

      switch(fieldType) {
        case 0: //Heart Rate
          var heartRate = (Mon has :INVALID_HR_SAMPLE) ? Utils.retrieveHeartrateText() : "--";
          valueStr = heartRate;
          Utils.drawCircleHeartRate(dc, x, y + 19, 25, heartRate.toNumber(), Graphics.COLOR_GREEN);
          icon = WatchUi.loadResource(Rez.Drawables.heartIcon);
          break;

        case 1: //Step Count
          var steps = Mon.getInfo().steps;
          valueStr = Utils.formatValueWithK(steps);
          Utils.drawCircleStep(dc, x, y + 19, 25, steps.toFloat(), Graphics.COLOR_GREEN);
          icon = WatchUi.loadResource(Rez.Drawables.stepIcon);
          break;

        case 2: //Calories
          var calories = Mon.getInfo().calories;
          valueStr = Utils.formatValueWithK(calories);
          Utils.drawCircleCalories(dc, x, y + 19, 25, calories.toFloat(), Graphics.COLOR_GREEN);
          icon = WatchUi.loadResource(Rez.Drawables.caloriesIcon);
          break;

        case 3: //Distance
          var distances = Mon.getInfo().distance;
          valueStr = Utils.formatValueWithK(distances) + "K";
          Utils.drawCircleDistance(dc, x, y + 19, 25, distances.toFloat(), Graphics.COLOR_GREEN);
          icon = WatchUi.loadResource(Rez.Drawables.distanceIcon);
          break;

        default:
          valueStr = "--";
          break;
      }

      // Vẽ text
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dc.drawText(x, y, spaceGroteskFont, valueStr, Graphics.TEXT_JUSTIFY_CENTER);

      // Vẽ icon nếu có
      if (icon != null) {
        dc.drawBitmap(x - 9, y + 20, icon);
      }
    }

    // Hàm hiển thị hai trường dữ liệu động
    private function setDynamicFields(dc as Dc) {
      var dataField1 = App.getApp().getProperty("Field1Type");
      var dataField2 = App.getApp().getProperty("Field2Type");

      drawDataField(dc, dataField1, 54, 40);
      drawDataField(dc, dataField2, 188, 40);
    }

    // Hiển thị pin
    private function setBatteryDisplay(dc as Dc) {
    	var battery = Sys.getSystemStats().battery;
      var batteryLevel = battery.format("%d");
      var batteryLevelStr = batteryLevel + "%";
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.drawText(120, 20, spaceGroteskFont, batteryLevelStr, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Hiển thị sạc hay không
    private function checkChargingStatus(dc as Dc) {
      var myStats = System.getSystemStats();
      var isCharging = myStats.charging;
      
      var chargingIcon = WatchUi.loadResource(Rez.Drawables.ChargingStatus);

      if (isCharging) {
        dc.drawBitmap(110, 0, chargingIcon);
      }
    }

    // Hiển thị ngày tháng
    private function setDateDisplay(dc as Dc) {        
      var now = Time.now();
      var date = Date.info(now, Time.FORMAT_LONG);
      var dateString = Lang.format("$1$\n$2$ $3$", [date.day_of_week, date.month, date.day]);
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.drawText(122, 45, spaceGroteskFont, dateString, Graphics.TEXT_JUSTIFY_CENTER);
    } 

    // Hiển thị status kết nối
    private function setConnectionStatusDisplay(dc as Dc) {
      var mySettings = System.getDeviceSettings();
      var phoneConnected = mySettings.phoneConnected;
      
      var getConnectedIcon = WatchUi.loadResource(Rez.Drawables.connected);
      var getDisConnectIcon = WatchUi.loadResource(Rez.Drawables.disConnect);

      if (phoneConnected) {
        dc.drawBitmap(10, 112, getConnectedIcon);
      } else {
        dc.drawBitmap(10, 112, getDisConnectIcon);
      }
    }

    // Hiển thị AM/PM
    private function displayDayNight(dc as Dc) {
      var now = System.getClockTime();
      var hour = now.hour;
      var period = (hour >= 12) ? "PM" : "AM";
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.drawText(220, 112, spaceGroteskFont, period, Graphics.TEXT_JUSTIFY_CENTER);
    }

    private function displayProgressPercentages(dc as Dc) {
      var now = Time.now();
      var today = Date.info(now, Time.FORMAT_MEDIUM);
      
      // Tính giây đã qua trong ngày
      var secondsToday = today.hour * 3600 + today.min * 60 + today.sec;
      var percentDay = (secondsToday / 86400.0) * 100;

      // Lấy thứ trong tuần (0=Chủ nhật, 1=Thứ 2,...)
      var dayOfWeekStr = today.day_of_week;
      var dayOfWeek = Utils.getDayOfWeekNumber(dayOfWeekStr);
      var secondsWeek = dayOfWeek * 86400 + secondsToday;
      var percentWeek = (secondsWeek / 604800.0) * 100;

      // Tính số ngày trong tháng
      var daysInMonth = Utils.daysInMonthFunc(today.year, Utils.monthToNumber(today.month));
      var percentMonth = ((today.day - 1) + secondsToday / 86400.0) / daysInMonth * 100;

      // Tính số ngày trong năm
      var daysInYear = Utils.isLeapYear(today.year) ? 366 : 365;
      var dayOfYear = Utils.dayOfYearFunc(today.year, Utils.monthToNumber(today.month), today.day);
      var percentYear = ((dayOfYear - 1) + secondsToday / 86400.0) / daysInYear * 100;

      Utils.drawCircleProgress(dc, 46, 180, 23, percentDay, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 95, 195, 23, percentWeek, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 146, 195, 23, percentMonth, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 194, 180, 23, percentYear, Graphics.COLOR_GREEN);
    }

    private function setThemeBackground(dc as Dc) {
      var theme = App.getApp().getProperty("themeBackground");
      if (theme == 1) {
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_ORANGE);
      } else if (theme == 2) {
        dc.setColor(Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE);
      } else if (theme == 3) {
        dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_DK_RED);
      } else {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
      }
      dc.clear();
    }

    private function setTextColor(dc as Dc, color as Number) {
      var theme = App.getApp().getProperty("themeBackground");

      if (theme == 1) {
        textColor = Graphics.COLOR_WHITE;
      } else if (theme == 2) {
        textColor = Graphics.COLOR_YELLOW;
      } else if (theme == 3) {
        textColor = Graphics.COLOR_YELLOW;
      } else {
        textColor = Graphics.COLOR_WHITE;
      }
    }

}
