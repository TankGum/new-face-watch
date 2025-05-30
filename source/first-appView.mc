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
        View.onUpdate(dc);
        setThemeBackground(dc);

        /*---------- Pin ----------*/
        var cachedBattery = null;
        var battery = Sys.getSystemStats().battery;
        if (cachedBattery != battery) {
          drawBatteryBar(dc, battery);
          cachedBattery = battery;

          setBatteryDisplay(dc, battery);
        }
        /*------------------------*/

        displayProgressPercentages(dc);
        DrawLine.drawLineLayout(dc);
        
        /*---------- Date ----------*/
        var cachedDate = null;
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$\n$2$ $3$", [date.day_of_week, date.month, date.day]);
        if (cachedDate != dateString) {
          setDateDisplay(dc, dateString);
          cachedDate = dateString;
        }
        /*-------------------------*/
        
        /*---------- Phone connect ----------*/
        var cachedPhoneConnect = null;
        var phoneConnected = System.getDeviceSettings().phoneConnected;
        if (phoneConnected != cachedPhoneConnect) {
          setConnectionStatusDisplay(dc, phoneConnected);
          phoneConnected = cachedPhoneConnect;
        }
        /*-----------------------------------*/
        
        /*---------- AM/PM ----------*/
        var cachedDayNight = null;
        var nowClock = System.getClockTime();
        var hour = nowClock.hour;
        var period = (hour >= 12) ? "P" : "A";
        if (cachedDayNight != period) {
          displayDayNight(dc, period);
          cachedDayNight = period;
        }
        /*--------------------------*/

        setClockDisplay(dc);

        /*---------- Charging ----------*/
        var cachedChargingStatus = null;
        var myStats = System.getSystemStats();
        var isCharging = myStats.charging;
        if (cachedChargingStatus != isCharging) {
          checkChargingStatus(dc, isCharging);
          cachedChargingStatus = isCharging;
        }
        /*--------------------------*/


        /*--------------------------*/
        // Hiển thị 2 fields động
        var cachedDataField1 = null;
        var cachedDataField2 = null;
        var dataField1 = App.getApp().getProperty("Field1Type");
        var dataField2 = App.getApp().getProperty("Field2Type");
        if (cachedDataField1 != dataField1 || cachedDataField2 != dataField2) {
          setDynamicFields(dc, dataField1, dataField2);
          
          cachedDataField1 = dataField1;
          cachedDataField2 = dataField2;
        }
        /*--------------------------*/

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
      
      var clockTime = Sys.getClockTime();
      var mHoursFont = WatchUi.loadResource(Rez.Fonts.myFont);

      var hourStr = clockTime.hour.toString();
      var minStr = clockTime.min.format("%02d");
      var secStr = clockTime.sec.format("%02d");

      
      var fullTimeStr = hourStr + ":" + minStr;

      if (showSec != 0) {
        fullTimeStr += ":" + secStr;
      }

      // Tính tổng chiều rộng của chuỗi giờ
      var totalTextWidth = dc.getTextWidthInPixels(fullTimeStr, mHoursFont);

      // Tính x sao cho canh giữa chuỗi
      var x = (screenWidth - totalTextWidth) / 2;
      var y = screenHeight * 0.5;  // Giữa màn hình theo chiều dọc

      // Vẽ từng phần với hàm drawTextWithBorder
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
      dc.drawText(x, y, spaceGroteskFont, valueStr, Graphics.TEXT_JUSTIFY_CENTER);

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

    // Hiển thị pin
    private function setBatteryDisplay(dc as Dc, battery) {
      var batteryLevel = battery.format("%d");
      var batteryLevelStr = batteryLevel + "%";

      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);

      // Tính tọa độ theo tỷ lệ, ví dụ: giữa chiều ngang, 8% từ trên xuống
      var x = screenWidth / 2;
      var y = screenHeight * 0.08;

      dc.drawText(x, y, spaceGroteskFont, batteryLevelStr, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Vẽ thanh pin
    private function drawBatteryBar(dc as Dc, battery) {
      // Ví dụ: vẽ thanh pin ở vị trí nằm ngang 1/3 màn hình, và chiều dọc 10% từ trên xuống
      var x = screenWidth * 0.33;        // 33% chiều ngang
      var y = screenHeight * 0.08;       // 10% chiều dọc

      // Chiều rộng và cao của thanh pin cũng tỉ lệ với màn hình
      var width = screenWidth * 0.35;    // 35% chiều ngang
      var height = screenHeight * 0.06;  // 6% chiều dọc

      Utils.drawBatteryBar(dc, Math.round(x), Math.round(y), Math.round(width), Math.round(height), battery);
    }

    // Hiển thị sạc hay không
    private function checkChargingStatus(dc as Dc, isCharging) {
      var chargingIcon = WatchUi.loadResource(Rez.Drawables.ChargingStatus);

      if (isCharging) {
          // Ví dụ: đặt icon sạc ở giữa ngang, sát trên cùng màn hình (5% chiều cao)
          var x = screenWidth / 2 - (chargingIcon.getWidth() / 2); // căn giữa icon theo chiều ngang
          var y = screenHeight * 0.9;  // sát top

          dc.drawBitmap(Math.round(x), Math.round(y), chargingIcon);
      }
    }

    // Hiển thị ngày tháng
    private function setDateDisplay(dc as Dc, dateString) {
      // Ví dụ: hiển thị ở chính giữa chiều ngang và 20% chiều dọc
      var x = screenWidth / 2;             // giữa màn hình ngang
      var y = screenHeight * 0.2;          // 20% từ trên xuống

      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.drawText(x, y, spaceGroteskFont, dateString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Hiển thị status kết nối
    private function setConnectionStatusDisplay(dc as Dc, phoneConnected) {
      var connectedIcon = WatchUi.loadResource(Rez.Drawables.connected);
      var disconnectedIcon = WatchUi.loadResource(Rez.Drawables.disConnect);

      // Vị trí hiển thị icon (góc trái, khoảng 4% ngang, 47% dọc)
      var x = screenWidth * 0.04;
      var y = screenHeight * 0.47;

      if (phoneConnected) {
        dc.drawBitmap(x, y, connectedIcon);
      } else {
        dc.drawBitmap(x, y, disconnectedIcon);
      }
    }

    // Hiển thị AM/PM
    private function displayDayNight(dc as Dc, period) {
      // Ví dụ: hiển thị phía bên phải, cách mép phải 8% và cao 47% từ trên xuống
      var x = screenWidth * 0.92;   // 92% chiều ngang, gần mép phải
      var y = screenHeight * 0.47;  // khoảng 47% chiều dọc

      var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dc.drawText(x, y, spaceGroteskFont, period, Graphics.TEXT_JUSTIFY_CENTER);
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

      var xDay   = screenWidth * 0.19;
      var yDay   = screenHeight * 0.75;

      var xWeek  = screenWidth * 0.40;
      var yWeek  = screenHeight * 0.81;

      var xMonth = screenWidth * 0.61;
      var yMonth = screenHeight * 0.81;

      var xYear  = screenWidth * 0.81;
      var yYear  = screenHeight * 0.75;

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
