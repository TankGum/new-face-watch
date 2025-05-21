import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Mon;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;
using Toybox.Application;

using Utils;
using DrawLine;

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
        
        setBatteryDisplay();
        setDateDisplay();
        // setCaloriesDisplay();
        // setFloorsClimbedDisplay();
        setConnectionStatusDisplay();
        
        displayDayNight();
        setConnectionStatusDisplay();
        
        View.onUpdate(dc);

        var battery = Sys.getSystemStats().battery;
        Utils.drawBatteryBar(dc, 79, 20, 81, 12, battery);

        displayProgressPercentages(dc);
        DrawLine.drawLineLayout(dc);
        setHeartrateDisplay(dc);
        setStepCountDisplay(dc);

        setClockDisplay(dc);
        checkChargingStatus();
        

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
      var x = 35;
      var y = 120;

      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      // Chuỗi giờ/phút/giây
      var hourStr = clockTime.hour.toString();
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

    // Hiển thị nhịp tim
    private function setHeartrateDisplay(dc as Dc) {
    	var heartRate = "";
    	
    	if(Mon has :INVALID_HR_SAMPLE) {
    		heartRate = Utils.retrieveHeartrateText();
    	}
    	else {
    		heartRate = "";
    	}

      Utils.drawCircleHeartRate(dc, 54, 59, 25, heartRate.toNumber(), Graphics.COLOR_GREEN);
    	
      var heartrateDisplay = View.findDrawableById("HeartrateDisplay") as Text;      
      heartrateDisplay.setText(heartRate);
    }

    // Hiển thị pin
    private function setBatteryDisplay() {
    	var battery = Sys.getSystemStats().battery;		
      var batteryDisplay = View.findDrawableById("BatteryDisplay") as Text;      
      batteryDisplay.setText(battery.format("%d")+"%");	
    }

    private function checkChargingStatus() {
      var myStats = System.getSystemStats();
      var isCharging = myStats.charging;
      
      var chargingStatus = View.findDrawableById("ChargingStatus") as Drawable;
      
      if (chargingStatus != null) {
        chargingStatus.setVisible(false);
      }

      if (isCharging) {
        chargingStatus.setVisible(true);
      } else {
        chargingStatus.setVisible(false);
      }
    }

    // Hiển thị số bước
    private function setStepCountDisplay(dc as Dc) {
      var stepCount = 6200;
      Utils.drawCircleStep(dc, 188, 59, 25, stepCount.toFloat(), Graphics.COLOR_GREEN);
      
      var stepCountDisplay = View.findDrawableById("StepCountDisplay") as Text;      
      stepCountDisplay.setText(Utils.formatValueWithK(stepCount));		
    }

    // Hiển thị ngày tháng
    private function setDateDisplay() {        
      var now = Time.now();
      var date = Date.info(now, Time.FORMAT_LONG);
      var dateString = Lang.format("$1$\n$2$ $3$", [date.day_of_week, date.month, date.day]);
      var dateDisplay = View.findDrawableById("DateDisplay") as Text;      
      dateDisplay.setText(dateString);	    	
    }

    // Hiển thị calo
    private function setCaloriesDisplay() {
      var calories = Mon.getInfo().calories;
      var caloriesDisplay = View.findDrawableById("CaloriesDisplay") as Text;
      if (caloriesDisplay != null) {
        caloriesDisplay.setText(Utils.formatValueWithK(calories));
      }
    }

    // Hiển thị số tầng đã leo
    private function setFloorsClimbedDisplay() {
      var floorsClimbed = Mon.getInfo().floorsClimbed;
      var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay") as Text;
      if (floorsClimbedDisplay != null) {
        floorsClimbedDisplay.setText(Utils.formatValueWithK(floorsClimbed));
      }
    }

    // Hiển thị status kết nối
    private function setConnectionStatusDisplay() {
      var mySettings = System.getDeviceSettings();
      var phoneConnected = mySettings.phoneConnected;
      
      var connected = View.findDrawableById("connected") as Drawable;
      var disConnect = View.findDrawableById("disConnect") as Drawable;

      // Ẩn tất cả icon trước
      if (connected != null) {
        connected.setVisible(false);
      }
      if (disConnect != null) {
        disConnect.setVisible(false);
      }

      if (phoneConnected != null) {
        if (connected != null) {
          connected.setVisible(true);
        }
      } else {
        if (disConnect != null) {
          disConnect.setVisible(true);
        }
      }
    }

    // Hiển thị AM/PM
    private function displayDayNight() {
      var now = System.getClockTime();
      var hour = now.hour;

      var timeLabel = View.findDrawableById("DayOrNight") as Text;

      var period = (hour >= 12) ? "PM" : "AM";
      timeLabel.setText(period);
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

      // Hiển thị
      // var dayLabel = View.findDrawableById("DayProgress") as Text;
      // if (dayLabel != null) {
      //   dayLabel.setText("D: " + percentDay.format("%.2f"));
      // }

      // var weekLabel = View.findDrawableById("WeekProgress") as Text;
      // if (weekLabel != null) {
      //   weekLabel.setText("W: " + percentWeek.format("%.2f"));
      // }

      // var monthLabel = View.findDrawableById("MonthProgress") as Text;
      // if (monthLabel != null) {
      //   monthLabel.setText("M: " + percentMonth.format("%.2f"));
      // }

      // var yearLabel = View.findDrawableById("YearProgress") as Text;
      // if (yearLabel != null) {
      //   yearLabel.setText("Y: " + percentYear.format("%.2f"));
      // }

      Utils.drawCircleProgress(dc, 46, 180, 23, percentDay, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 95, 195, 23, percentWeek, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 146, 195, 23, percentMonth, Graphics.COLOR_GREEN);
      Utils.drawCircleProgress(dc, 194, 180, 23, percentYear, Graphics.COLOR_GREEN);
    }

}
