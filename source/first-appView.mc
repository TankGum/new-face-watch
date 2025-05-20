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
        setConnectionStatusDisplay();
        
        View.onUpdate(dc);

        var battery = Sys.getSystemStats().battery;
        drawBatteryBar(dc, 105, 20, 30, 12, battery);

        displayProgressPercentages(dc);
        drawLineLayout(dc);
        drawFancyHeaderLayout(dc);


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
    private function drawBatteryBar(dc as Dc, x as Number, y as Number, width as Number, height as Number, batteryPercent as Float) {

      // Vẽ khung ngoài pin (viền)
      var borderColor;
      if (batteryPercent >= 60) {
        borderColor = Graphics.COLOR_GREEN;
      } else if (batteryPercent >= 30) {
        borderColor = Graphics.COLOR_YELLOW;
      } else {
        borderColor = Graphics.COLOR_RED;
      }

      dc.setColor(borderColor, Graphics.COLOR_TRANSPARENT);
      var radius = 2; // độ bo góc
      dc.drawRoundedRectangle(x, y, width, height, radius);

      // Đầu pin nhỏ (chốt)
      var capWidth = 3;
      dc.drawRectangle(x + width, y + height/4, capWidth, height / 2);

      // Chiều dài thanh pin đầy theo phần trăm
      var innerWidth = (width - 2) * batteryPercent / 100;

      // Chọn màu pin theo mức phần trăm
      var fillColor;
      if (batteryPercent >= 60) {
        fillColor = Graphics.COLOR_GREEN;
      } else if (batteryPercent >= 30) {
        fillColor = Graphics.COLOR_YELLOW;
      } else {
        fillColor = Graphics.COLOR_RED;
      }

      // Vẽ mức pin (phần bên trong)
      dc.setColor(fillColor, Graphics.COLOR_TRANSPARENT);
      dc.fillRectangle(x + 1, y + 1, innerWidth, height - 2);
    }

    // Hiển thị số bước
    private function setStepCountDisplay() {
    	var stepCount = Mon.getInfo().steps;		
      var stepCountDisplay = View.findDrawableById("StepCountDisplay") as Text;      
      stepCountDisplay.setText(formatValueWithK(stepCount));		
    }

    // Hiển thị ngày tháng
    private function setDateDisplay() {        
      var now = Time.now();
      var date = Date.info(now, Time.FORMAT_LONG);
      var dateString = Lang.format("$1$, $2$ $3$, $4$", [date.day_of_week, date.month, date.day, date.year]);
      var dateDisplay = View.findDrawableById("DateDisplay") as Text;      
      dateDisplay.setText(dateString);	    	
    }

    // Hiển thị calo
    private function setCaloriesDisplay() {
      var calories = Mon.getInfo().calories;
      var caloriesDisplay = View.findDrawableById("CaloriesDisplay") as Text;
      if (caloriesDisplay != null) {
        caloriesDisplay.setText(formatValueWithK(calories));
      }
    }

    // Hiển thị số tầng đã leo
    private function setFloorsClimbedDisplay() {
      var floorsClimbed = Mon.getInfo().floorsClimbed;
      var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay") as Text;
      if (floorsClimbedDisplay != null) {
        floorsClimbedDisplay.setText(formatValueWithK(floorsClimbed));
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

      drawCircleProgress(dc, 39, 167, 25, percentDay, Graphics.COLOR_GREEN);
      drawCircleProgress(dc, 93, 167, 25, percentWeek, Graphics.COLOR_GREEN);
      drawCircleProgress(dc, 148, 167, 25, percentMonth, Graphics.COLOR_GREEN);
      drawCircleProgress(dc, 201, 167, 25, percentYear, Graphics.COLOR_GREEN);
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

    // Chuyển phần nghìn thành K
    private function formatValueWithK(value as Number) as String {
      if (value >= 1000) {
        return (value / 1000.0).format("%.1f") + "K";
      } else {
        return value.toString();
      }
    }


    private function drawCircleProgress(dc as Dc, cx as Number, cy as Number, r as Number, percentage as Float, color as Graphics.ColorType) {
      if (percentage >= 80) {
        color = Graphics.COLOR_RED;
      } else if (percentage >= 50) {
        color = Graphics.COLOR_YELLOW;
      } else {
        color = Graphics.COLOR_GREEN;
      }

      // Xóa vùng trước khi vẽ
      dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_DK_GRAY);
      dc.fillCircle(cx, cy, r);

      // Tính góc quay (0-360 độ)
      var sweepAngle = percentage * 360 / 100;

      // Vẽ vòng tròn nền (xám) - toàn bộ 360 độ
      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 2; thickness++) {
        dc.drawArc(cx, cy, (r - 1) - thickness, Graphics.ARC_CLOCKWISE, -90, 270);  // Vẽ toàn bộ nền
      }

      // Vẽ vòng tròn tiến trình (màu) theo phần trăm
      dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 4; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, -90 + sweepAngle);  // Vẽ tiến trình
      }

      // Hiển thị phần trăm ở giữa vòng tròn
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      var percentageStr = percentage.format("%.1f") + "%";
      dc.drawText(cx + 1, cy - 10, Graphics.FONT_XTINY, percentageStr, Graphics.TEXT_JUSTIFY_CENTER);
    }

    private function drawLineLayout(dc as Dc) {
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      // dc.drawLine(0, 50, 240, 50);
      // dc.drawLine(0, 30, 240, 30);
      dc.drawLine(0, 135, 240, 135);
      dc.drawLine(0, 105, 240, 105);

      dc.drawLine(0, 200, 240, 200);
      // dc.drawLine(120, 0, 120, 50);
    }

    private function drawFancyHeaderLayout(dc as Dc) {
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

    // Hình tròn trái
    var cx1 = 70;
    var cy1 = 59;
    var r = 40;
    dc.drawCircle(cx1, cy1, r);

    // Hình tròn phải
    var cx2 = 170;
    var cy2 = 59;
    dc.drawCircle(cx2, cy2, r);

    // Vẽ đường chia đôi hình tròn trái
    dc.drawLine(cx1 - r, cy1, cx1 + r, cy1);

    // Vẽ đường chia đôi hình tròn phải
    dc.drawLine(cx2 - r, cy2, cx2 + r, cy2);
}



}
