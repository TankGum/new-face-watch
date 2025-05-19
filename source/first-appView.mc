import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Mon;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;
using Toybox.Application;

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
        setClockDisplay();
        setHeartrateDisplay();
        setBatteryDisplay();
        setStepCountDisplay();
        setDateDisplay();
        setCaloriesDisplay();
        setFloorsClimbedDisplay();
        setConnectionStatusDisplay();
        displayDayNight();
        
        var battery = Sys.getSystemStats().battery;
        updateBatteryIcon(battery.toNumber());

        setConnectionStatusDisplay();
        View.onUpdate(dc);
        
        displayProgressPercentages(dc);

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
    private function setClockDisplay() {
    	var clockTime = Sys.getClockTime();
      var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
      var view = View.findDrawableById("TimeDisplay") as Text;

      view.setText(timeString);
    }

    // Hiển thị nhịp tim
    private function setHeartrateDisplay() {
    	var heartRate = "";
    	
    	if(Mon has :INVALID_HR_SAMPLE) {
    		heartRate = retrieveHeartrateText();
    	}
    	else {
    		heartRate = "";
    	}
    	
      var heartrateDisplay = View.findDrawableById("HeartrateDisplay") as Text;      
      heartrateDisplay.setText(heartRate);
    }

    // Lấy nhịp tim
    private function retrieveHeartrateText() {
      var heartrateIterator = ActivityMonitor.getHeartRateHistory(null, false);
      var currentHeartrate = heartrateIterator.next().heartRate;

      if(currentHeartrate == Mon.INVALID_HR_SAMPLE) {
        return "";
      }		

      return currentHeartrate.format("%d");
    }

    // Hiển thị pin
    private function setBatteryDisplay() {
    	var battery = Sys.getSystemStats().battery;				
      var batteryDisplay = View.findDrawableById("BatteryDisplay") as Text;      
      batteryDisplay.setText(battery.format("%d")+"%");	
    }
    
    // Cập nhật icon pin
    private function updateBatteryIcon(batteryPercent as Integer) as Void {
      var batteryFull = View.findDrawableById("batteryFull") as Drawable;
      var batteryMedium = View.findDrawableById("batteryMedium") as Drawable;
      var batteryLow = View.findDrawableById("batteryLow") as Drawable;

      // Ẩn tất cả icon trước
      if (batteryFull != null) {
        batteryFull.setVisible(false);
      }
      if (batteryMedium != null) {
        batteryMedium.setVisible(false);
      }
      if (batteryLow != null) {
        batteryLow.setVisible(false);
      }

      // Hiển thị icon phù hợp theo % pin
      if (batteryPercent > 50) {
        if (batteryFull != null) {
          batteryFull.setVisible(true);
        }
      } else if (batteryPercent >= 40) {
        if (batteryMedium != null) {
          batteryMedium.setVisible(true);
        }
      } else {
        if (batteryLow != null) {
          batteryLow.setVisible(true);
        }
      }
    }

    // Hiển thị số bước
    private function setStepCountDisplay() {
    	var stepCount = Mon.getInfo().steps.toString();		
      var stepCountDisplay = View.findDrawableById("StepCountDisplay") as Text;      
      stepCountDisplay.setText(stepCount);		
    }

    // Hiển thị ngày tháng
    private function setDateDisplay() {        
    	var now = Time.now();
      var date = Date.info(now, Time.FORMAT_LONG);
      var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
      var dateDisplay = View.findDrawableById("DateDisplay") as Text;      
      dateDisplay.setText(dateString);	    	
    }

    // Hiển thị calo
    private function setCaloriesDisplay() {
      var calories = Mon.getInfo().calories.toString();
      var caloriesDisplay = View.findDrawableById("CaloriesDisplay") as Text;
      if (caloriesDisplay != null) {
        caloriesDisplay.setText(calories);
      }
    }

    // Hiển thị số tầng đã leo
    private function setFloorsClimbedDisplay() {
      var floorsClimbed = Mon.getInfo().floorsClimbed.toString();
      var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplayDisplay") as Text;
      if (floorsClimbedDisplay != null) {
        floorsClimbedDisplay.setText(floorsClimbed);
      }
    }

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
      var dayOfWeek = getDayOfWeekNumber(dayOfWeekStr);
      var secondsWeek = dayOfWeek * 86400 + secondsToday;
      var percentWeek = (secondsWeek / 604800.0) * 100;

      // Tính số ngày trong tháng
      var daysInMonth = daysInMonthFunc(today.year, monthToNumber(today.month));
      var percentMonth = ((today.day - 1) + secondsToday / 86400.0) / daysInMonth * 100;

      // Tính số ngày trong năm
      var daysInYear = isLeapYear(today.year) ? 366 : 365;
      var dayOfYear = dayOfYearFunc(today.year, monthToNumber(today.month), today.day);
      var percentYear = ((dayOfYear - 1) + secondsToday / 86400.0) / daysInYear * 100;

      // Hiển thị
      var dayLabel = View.findDrawableById("DayProgress") as Text;
      if (dayLabel != null) {
        dayLabel.setText("D: " + percentDay.format("%.2f"));
      }

      var weekLabel = View.findDrawableById("WeekProgress") as Text;
      if (weekLabel != null) {
        weekLabel.setText("W: " + percentWeek.format("%.2f"));
      }

      var monthLabel = View.findDrawableById("MonthProgress") as Text;
      if (monthLabel != null) {
        monthLabel.setText("M: " + percentMonth.format("%.2f"));
      }

      var yearLabel = View.findDrawableById("YearProgress") as Text;
      if (yearLabel != null) {
        yearLabel.setText("Y: " + percentYear.format("%.2f"));
      }

      drawCircleProgress(dc, 40, 100, 20, percentDay, Graphics.COLOR_BLUE);
      drawCircleProgress(dc, 90, 100, 20, percentWeek, Graphics.COLOR_BLUE);
      drawCircleProgress(dc, 140, 100, 20, percentMonth, Graphics.COLOR_BLUE);
      drawCircleProgress(dc, 190, 100, 20, percentYear, Graphics.COLOR_BLUE);




    }

    // Chuyển thứ sang số
    private function getDayOfWeekNumber(dayStr as String) as Number {
      var daysMap = {
        "Sun" => 0,
        "Mon" => 1,
        "Tue" => 2,
        "Wed" => 3,
        "Thu" => 4,
        "Fri" => 5,
        "Sat" => 6
      };
      if (daysMap.hasKey(dayStr)) {
        return daysMap[dayStr];
      }
      return 0;
    }

    // Chuyển tháng sang số
    private function monthToNumber(monthStr as String) as Number {
      var monthsMap = {
        "Jan" => 1,
        "Feb" => 2,
        "Mar" => 3,
        "Apr" => 4,
        "May" => 5,
        "Jun" => 6,
        "Jul" => 7,
        "Aug" => 8,
        "Sep" => 9,
        "Oct" => 10,
        "Nov" => 11,
        "Dec" => 12
      };
      if (monthsMap.hasKey(monthStr)) {
        return monthsMap[monthStr];
      }
      return 0;
    }

    // Hỗ trợ tính số ngày trong tháng
    private function daysInMonthFunc(year as Number, month as Number) as Number {
      var daysPerMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
      if (month == 2 && isLeapYear(year)) {
        return 29;
      }
      return daysPerMonth[month - 1];
    }

    // Kiểm tra năm nhuận
    private function isLeapYear(year as Number) as Boolean {
      return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    // Tính ngày trong năm (1-366)
    private function dayOfYearFunc(year as Number, month as Number, day as Number) as Number {
      var dayCount = 0;
      for (var m = 1; m < month; m++) {
        dayCount += daysInMonthFunc(year, m);
      }
      dayCount += day;
      return dayCount;
    }


    private function drawCircleProgress(dc as Dc, cx as Number, cy as Number, r as Number, percentage as Float, color as Graphics.ColorType) {
      // Xóa vùng trước khi vẽ
      dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_DK_GRAY);
      dc.fillCircle(cx, cy, r);

      // Vẽ vòng tròn nền (xám)
      dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_DK_GRAY);
      dc.drawCircle(cx, cy, r);

      // Tính góc quay (0-360 độ)
      var sweepAngle = percentage * 360 / 100;

      // Vẽ vòng tròn tiến trình theo chiều kim đồng hồ
      dc.setColor(color, Graphics.COLOR_DK_GRAY);
        for (var thickness = 0; thickness < 3; thickness++) {
          dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, 0, sweepAngle);
        }

      // Hiển thị phần trăm ở giữa vòng tròn
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      var percentageStr = percentage.format("%.1f") + "%";
      dc.drawText(cx + 1, cy - 10, Graphics.FONT_XTINY, percentageStr, Graphics.TEXT_JUSTIFY_CENTER);
    }


}
