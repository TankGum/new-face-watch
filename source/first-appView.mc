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

var screenWidth = System.getDeviceSettings().screenWidth;
var screenHeight = System.getDeviceSettings().screenHeight;

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
      try {
        View.onUpdate(dc);
        setThemeBackground(dc);

        /*---------- Pin ----------*/
        var battery = Sys.getSystemStats().battery;
        var batteryDisplay = View.findDrawableById("BatteryDisplay") as BatteryDisplay;
        if (batteryDisplay != null) {
            batteryDisplay.setBatteryLevel(battery);
        }
        /*------------------------*/

        displayProgressPercentages(dc);
        
        /*---------- Date ----------*/
        var app = App.getApp() as first_appApp;
        app.refreshDateString();

        var dateDisplay = View.findDrawableById("DateDisplay") as DateDisplay;
        if (dateDisplay != null) {
            dateDisplay.setDate(app.getDateString());
        }
        /*-------------------------*/
        
        /*---------- Phone connect ----------*/
        var phoneConnected = System.getDeviceSettings().phoneConnected;

        var phoneDisplay = View.findDrawableById("PhoneConnectionDisplay") as PhoneConnectionDisplay;
        if (phoneDisplay != null) {
            phoneDisplay.setConnected(phoneConnected);
        }
        /*-----------------------------------*/
        
        /*---------- AM/PM ----------*/
        var nowClock = System.getClockTime();
        var hour = nowClock.hour;
        var period = (hour >= 12) ? "P" : "A";

        var dayNightDisplay = View.findDrawableById("DayNightDisplay") as DayNightDisplay;
        if (dayNightDisplay != null) {
            dayNightDisplay.setPeriod(period);
        }
        /*--------------------------*/

        setClockDisplay(dc);

        /*---------- Charging ----------*/
        var myStats = System.getSystemStats();
        var isCharging = myStats.charging;
        var chargingStatusDisplay = View.findDrawableById("ChargingStatusDisplay") as ChargingStatusDisplay;
        if (dayNightDisplay != null) {
          chargingStatusDisplay.setChargingStatus(isCharging);
        }
        /*------------------------------*/

        /*---------- Hiển thị 2 fields động ----------*/
        var dataField1 = App.getApp().getProperty("Field1Type");
        var dataField2 = App.getApp().getProperty("Field2Type");
        setDynamicFields(dc, dataField1, dataField2);
        /*--------------------------------------------*/
      } catch(e) {
        System.println("Error in onUpdate: " + e.toString());
      }
    }

    function onPartialUpdate(dc as Dc) {
      try {
        setClockDisplay(dc);
      } catch(e) {
        System.println("Error in onPartialUpdate: " + e.toString());
      }
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
      var showSec = App.getApp().getProperty("showSec");
      var use24Hour = App.getApp().getProperty("use24Hour");

      var clockTime = Sys.getClockTime();
      var mHoursFont = WatchUi.loadResource(Rez.Fonts.myFont);

      var hour = clockTime.hour;
      if (use24Hour == 0) {  // 0 = 12h format
          hour = hour % 12;
          if (hour == 0) {hour = 12;}
      }

      var hourStr = hour.toString();
      var minStr = clockTime.min.format("%02d");
      var secStr = clockTime.sec.format("%02d");

      var fullTimeStr = hourStr + ":" + minStr;
      if (showSec != 0) {
        fullTimeStr += ":" + secStr;
      }

      var totalTextWidth = dc.getTextWidthInPixels(fullTimeStr, mHoursFont);
      var x = (screenWidth - totalTextWidth) / 2;
      var y = screenHeight * 0.5;

      drawTextWithBorder(dc, hourStr, x, y, mHoursFont);
      x += dc.getTextWidthInPixels(hourStr, mHoursFont);

      drawTextWithBorder(dc, ":", x, y, mHoursFont);
      x += dc.getTextWidthInPixels(":", mHoursFont);

      drawTextWithBorder(dc, minStr, x, y, mHoursFont);
      x += dc.getTextWidthInPixels(minStr, mHoursFont);

      if (showSec != 0) {
        drawTextWithBorder(dc, ":", x, y, mHoursFont);
        x += dc.getTextWidthInPixels(":", mHoursFont);
        drawTextWithBorder(dc, secStr, x, y, mHoursFont);
      }
    }

    function drawTextWithBorder(dc, text, px, py, mHoursFont) {
      // Vẽ viền trắng 8 hướng (offset 1px)
      var borderTimeColor = App.getApp().getProperty("borderTimeColor");

      if (borderTimeColor == 0) {
        borderTimeColor = Graphics.COLOR_TRANSPARENT;
      } else if (borderTimeColor == 1) {
        borderTimeColor = Graphics.COLOR_ORANGE;
      } else if (borderTimeColor == 2) {
        borderTimeColor = Graphics.COLOR_WHITE;
      } else if (borderTimeColor == 3) {
        borderTimeColor = Graphics.COLOR_BLACK;
      } else if (borderTimeColor == 4) {
        borderTimeColor = Graphics.COLOR_GREEN;
      } else if (borderTimeColor == 5) {
        borderTimeColor = Graphics.COLOR_BLUE;
      } else if (borderTimeColor == 6) {
        borderTimeColor = Graphics.COLOR_PURPLE;
      } else if (borderTimeColor == 8) {
        borderTimeColor = Graphics.COLOR_DK_RED;
      } else {
        borderTimeColor = Graphics.COLOR_TRANSPARENT;
      }

      dc.setColor(borderTimeColor, Graphics.COLOR_TRANSPARENT);
      dc.drawText(px - 1, py, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px + 1, py, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px, py - 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px, py + 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px - 1, py - 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px + 1, py - 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px - 1, py + 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
      dc.drawText(px + 1, py + 1, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

      // Màu chữ ở giữa
      
      var fillTimeColor = App.getApp().getProperty("fillTimeColor");

      if (fillTimeColor == 0) {
        fillTimeColor = Graphics.COLOR_TRANSPARENT;
      } else if (fillTimeColor == 1) {
        fillTimeColor = Graphics.COLOR_ORANGE;
      } else if (fillTimeColor == 2) {
        fillTimeColor = Graphics.COLOR_WHITE;
      } else if (fillTimeColor == 3) {
        fillTimeColor = Graphics.COLOR_BLACK;
      } else if (fillTimeColor == 4) {
        fillTimeColor = Graphics.COLOR_GREEN;
      } else if (fillTimeColor == 5) {
        fillTimeColor = Graphics.COLOR_BLUE;
      } else if (fillTimeColor == 6) {
        fillTimeColor = Graphics.COLOR_PURPLE;
      } else if (fillTimeColor == 8) {
        fillTimeColor = Graphics.COLOR_DK_RED;
      } else {
        fillTimeColor = Graphics.COLOR_WHITE;
      }

      dc.setColor(fillTimeColor, Graphics.COLOR_TRANSPARENT);
      dc.drawText(px, py, mHoursFont, text, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
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
          var distanceKm = distances / 100000;
          valueStr = Utils.formatValueWithK(distanceKm) + "K";
          Utils.drawCircleDistance(dc, x, y + 19, 25, distanceKm.toFloat(), Graphics.COLOR_GREEN);
          icon = WatchUi.loadResource(Rez.Drawables.distanceIcon);
          break;

        default:
          valueStr = "--";
          break;
      }

      // Vẽ text
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dc.drawText(x, y + 5, spaceGroteskFont, valueStr, Graphics.TEXT_JUSTIFY_CENTER);

      // Vẽ icon nếu có
      if (icon != null) {
        dc.drawBitmap(x - 9, y + 20, icon);
      }
    }

    // Hàm hiển thị hai trường dữ liệu động
    private function setDynamicFields(dc as Dc, dataField1, dataField2) {
      var scaleX = screenWidth / 240.0;
      var scaleY = screenHeight / 240.0;

      // Scale thủ công toạ độ vẽ
      drawDataField(dc, dataField1, Math.round(52 * scaleX), Math.round(40 * scaleY));
      drawDataField(dc, dataField2, Math.round(188 * scaleX), Math.round(40 * scaleY));
    }

    private function displayProgressPercentages(dc as Dc) {
      var now = Time.now();
      var today = Date.info(now, Time.FORMAT_MEDIUM);

      // Tính phần trăm ngày
      var secondsToday = today.hour * 3600 + today.min * 60 + today.sec;
      var percentDay = (secondsToday / 86400.0) * 100;

      // Tính phần trăm tuần
      var dayOfWeekStr = today.day_of_week;
      var dayOfWeek = Utils.getDayOfWeekNumber(dayOfWeekStr);
      var secondsWeek = dayOfWeek * 86400 + secondsToday;
      var percentWeek = (secondsWeek / 604800.0) * 100;

      // Tính phần trăm tháng
      var daysInMonth = Utils.daysInMonthFunc(today.year, Utils.monthToNumber(today.month));
      var percentMonth = ((today.day - 1) + secondsToday / 86400.0) / daysInMonth * 100;

      // Tính phần trăm năm
      var daysInYear = Utils.isLeapYear(today.year) ? 366 : 365;
      var dayOfYear = Utils.dayOfYearFunc(today.year, Utils.monthToNumber(today.month), today.day);
      var percentYear = ((dayOfYear - 1) + secondsToday / 86400.0) / daysInYear * 100;

      var radius = screenWidth * 0.095; // tương đương khoảng 23/240

      var xDay = screenWidth * 0.19;
      var yDay = screenHeight * 0.75;

      var xWeek = screenWidth * 0.40;
      var yWeek = screenHeight * 0.81;

      var xMonth = screenWidth * 0.61;
      var yMonth = screenHeight * 0.81;

      var xYear = screenWidth * 0.81;
      var yYear = screenHeight * 0.75;

      // Vẽ vòng tròn
      Utils.drawCircleProgress(dc, xDay.toNumber(), yDay.toNumber(), radius.toNumber(), percentDay, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, xWeek.toNumber(), yWeek.toNumber(), radius.toNumber(), percentWeek, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, xMonth.toNumber(), yMonth.toNumber(), radius.toNumber(), percentMonth, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, xYear.toNumber(), yYear.toNumber(), radius.toNumber(), percentYear, Graphics.COLOR_GREEN);
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

}
