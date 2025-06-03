import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Mon;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;
using Toybox.Application;
using Toybox.Application as App;

module Utils {
  function drawCircleHeartRate(dc as Dc, cx as Number, cy as Number, r as Number, heartRate as Float, color as Graphics.ColorType) {
    var maxHeartRate = App.getApp().getProperty("maxHeartRate");

    if (maxHeartRate != null) {
      maxHeartRate = maxHeartRate.toNumber();
      if (maxHeartRate < 30) {
        maxHeartRate = 210;
      }
    }
    
    var percent = heartRate.toFloat() / maxHeartRate.toFloat();

    if (percent >= 0.9) {
      color = Graphics.COLOR_RED;
    } else if (percent <= 0.2) {
      color = Graphics.COLOR_RED;
    } else if (percent >= 0.6) {
      color = Graphics.COLOR_YELLOW;
    } else {
      color = Graphics.COLOR_GREEN;
    }

    // Xóa vùng trước khi vẽ
    dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_DK_GRAY);
    dc.fillCircle(cx, cy, r);

    // Tính góc quay (0-360 độ)
    var sweepAngle = heartRate * 360 / maxHeartRate;

    // Vẽ vòng tròn nền (xám) - toàn bộ 360 độ
    dc.setColor(color, Graphics.COLOR_TRANSPARENT);
    for (var thickness = 0; thickness < 2; thickness++) {
      dc.drawArc(cx, cy, (r - 1) - thickness, Graphics.ARC_CLOCKWISE, -90, 270);
    }

    // Vẽ vòng tròn tiến trình (màu) theo phần trăm
    dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
    for (var thickness = 0; thickness < 4; thickness++) {
      dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, -90 + sweepAngle);
    }
  }

  function drawCircleStep(dc as Dc, cx as Number, cy as Number, r as Number, stepCount as Float, color as Graphics.ColorType) {
    var stepsGoal = App.getApp().getProperty("stepsGoal");

    if (stepsGoal != null) {
      stepsGoal = stepsGoal.toNumber();
      if (stepsGoal < 1) {
        stepsGoal = 10000;
      }
    } else {
      stepsGoal = 10000;
    }

    var percent = stepCount.toFloat() / stepsGoal.toFloat();
    if (percent > 1.0) {
      percent = 1.0;
    }
  
    if (percent >= 0.7) {
      color = Graphics.COLOR_GREEN;
    } else if (percent >= 0.5) {
      color = Graphics.COLOR_YELLOW;
    } else {
      color = Graphics.COLOR_RED;
    }

    // Xóa nền
    dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_DK_GRAY);
    dc.fillCircle(cx, cy, r);

    // Vẽ vòng nền: toàn bộ vòng 360 độ màu xám nhạt
    dc.setColor(color, Graphics.COLOR_TRANSPARENT);
    for (var thickness = 0; thickness < 2; thickness++) {
      dc.drawArc(cx, cy, (r - 1) - thickness, Graphics.ARC_CLOCKWISE, -90, 270);
    }

    // Nếu chưa đạt goal, vẽ phần tiến trình
    if (percent < 1.0) {
      var sweepAngle = percent * 360;
      dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 4; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, -90 + sweepAngle);
      }
    } else {
      // Nếu đạt hoặc vượt goal, tô toàn bộ vòng bằng màu thành tích
      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 2; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, 360);
      }
    }
  }

  function drawCircleDistance(dc as Dc, cx as Number, cy as Number, r as Number, distancesCount as Float, color as Graphics.ColorType) {
    var distancesGoal = App.getApp().getProperty("distancesGoal");

    if (distancesGoal != null) {
      distancesGoal = distancesGoal.toNumber();
      if (distancesGoal < 1) {
        distancesGoal = 300;
      }
    } else {
      distancesGoal = 300;
    }

    var percent = distancesCount.toFloat() / distancesGoal.toFloat();

    if (percent > 1.0) {
      percent = 1.0;
    }
  
    if (percent >= 0.7) {
      color = Graphics.COLOR_GREEN;
    } else if (percent >= 0.5) {
      color = Graphics.COLOR_YELLOW;
    } else {
      color = Graphics.COLOR_RED;
    }

    // Xóa nền
    dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_DK_GRAY);
    dc.fillCircle(cx, cy, r);

    // Vòng tròn nền
    dc.setColor(color, Graphics.COLOR_TRANSPARENT);
    for (var thickness = 0; thickness < 2; thickness++) {
      dc.drawArc(cx, cy, (r - 1) - thickness, Graphics.ARC_CLOCKWISE, -90, 270);
    }

    // Nếu chưa đạt goal, vẽ phần tiến trình
    if (percent < 1.0) {
      var sweepAngle = percent * 360;
      dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 4; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, -90 + sweepAngle);
      }
    } else {
      // Nếu đạt hoặc vượt goal, tô toàn bộ vòng bằng màu thành tích
      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 2; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, 360);
      }
    }
  }

  function drawCircleCalories(dc as Dc, cx as Number, cy as Number, r as Number, caloriesCount as Float, color as Graphics.ColorType) {
    var caloriesGoal = App.getApp().getProperty("caloriesGoal");

    if (caloriesGoal != null) {
      caloriesGoal = caloriesGoal.toNumber();
      if (caloriesGoal < 1) {
        caloriesGoal = 15000;
      }
    } else {
      caloriesGoal = 15000;
    }

    var percent = caloriesCount.toFloat() / caloriesGoal.toFloat();

    if (percent > 1.0) {
      percent = 1.0;
    }
  
    if (percent >= 0.7) {
      color = Graphics.COLOR_GREEN;
    } else if (percent >= 0.5) {
      color = Graphics.COLOR_YELLOW;
    } else {
      color = Graphics.COLOR_RED;
    }

    // Xóa nền
    dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_DK_GRAY);
    dc.fillCircle(cx, cy, r);

    // Vòng tròn nền
    dc.setColor(color, Graphics.COLOR_TRANSPARENT);
    for (var thickness = 0; thickness < 2; thickness++) {
      dc.drawArc(cx, cy, (r - 1) - thickness, Graphics.ARC_CLOCKWISE, -90, 270);
    }

    // Nếu chưa đạt goal, vẽ phần tiến trình
    if (percent < 1.0) {
      var sweepAngle = percent * 360;
      dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 4; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, -90 + sweepAngle);
      }
    } else {
      // Nếu đạt hoặc vượt goal, tô toàn bộ vòng bằng màu thành tích
      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      for (var thickness = 0; thickness < 2; thickness++) {
        dc.drawArc(cx, cy, r - thickness, Graphics.ARC_CLOCKWISE, -90, 360);
      }
    }
  }

  // Cập nhật icon pin
  function drawBatteryBar(dc as Dc, x as Number, y as Number, width as Number, height as Number, batteryPercent as Float) {

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
    var radius = 2;
    dc.drawRoundedRectangle(x, y, width, height, radius);

    // Đầu pin nhỏ
    var capWidth = 3;
    dc.setColor(borderColor, borderColor); // Màu viền và nền cùng màu
    dc.fillRectangle(x + width, y + height / 4, capWidth, height / 2);

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

  // Lấy nhịp tim
  function retrieveHeartrateText() {
    var heartrateIterator = Mon.getHeartRateHistory(null, false);
    var currentHeartrate = heartrateIterator.next().heartRate;

    if(currentHeartrate == Mon.INVALID_HR_SAMPLE) {
      return "";
    }		

    return currentHeartrate.format("%d");
  }

  // Chuyển phần nghìn thành K
  function formatValueWithK(value as Number) as String {
    if (value >= 1000) {
      return (value / 1000.0).format("%.1f") + "k";
    } else {
      return value.toString();
    }
  }

  function drawCircleProgress(dc as Dc, cx as Number, cy as Number, r as Number, percentage as Float, color as Graphics.ColorType) {
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
    var spaceGroteskFont = WatchUi.loadResource(Rez.Fonts.spaceGrotesk);
    var percentageStr = percentage.format("%.1f") + "%";
    dc.drawText(cx + 1, cy - 8, spaceGroteskFont, percentageStr, Graphics.TEXT_JUSTIFY_CENTER);
  }

  // Chuyển thứ sang số
  function getDayOfWeekNumber(dayStr as String) as Number {
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
  function monthToNumber(monthStr as String) as Number {
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
  function daysInMonthFunc(year as Number, month as Number) as Number {
    var daysPerMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    if (month == 2 && isLeapYear(year)) {
      return 29;
    }
    return daysPerMonth[month - 1];
  }

  // Kiểm tra năm nhuận
  function isLeapYear(year as Number) as Boolean {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // Tính ngày trong năm (1-366)
  function dayOfYearFunc(year as Number, month as Number, day as Number) as Number {
    var dayCount = 0;
    for (var m = 1; m < month; m++) {
      dayCount += daysInMonthFunc(year, m);
    }
    dayCount += day;
    return dayCount;
  }
}
