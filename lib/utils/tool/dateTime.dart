class RelativeDateFormat {
  static final num ONE_MINUTE = 60000;
  static final num ONE_HOUR = 3600000;
  static final num ONE_DAY = 86400000;
  static final num ONE_WEEK = 604800000;

  static final String ONE_SECOND_AGO = "秒前";
  static final String ONE_MINUTE_AGO = "分钟前";
  static final String ONE_HOUR_AGO = "小时前";
  static final String ONE_DAY_AGO = "天前";
  static final String ONE_MONTH_AGO = "月前";
  static final String ONE_YEAR_AGO = "年前";

//时间转换
  static String format(String datetime) {
    DateTime date = DateTime.parse(datetime);
    num delta =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 45 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      num months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + ONE_MONTH_AGO;
    } else {
      num years = toYears(delta);
      return (years <= 0 ? 1 : years).toInt().toString() + ONE_YEAR_AGO;
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }

  static String dateAndTimeToString(String datetime,
      {Map<String, String> formart}) {
    var timestamp = DateTime.parse(datetime).millisecondsSinceEpoch;

    String targetString = "";
    final date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    // final String tmp = date.toString();
    String year = date.year.toString();
    String month = date.month.toString();
    if (date.month <= 9) {
      month = "0" + month;
    }
    String day = date.day.toString();
    if (date.day <= 9) {
      day = "0" + day;
    }
    String hour = date.hour.toString();
    if (date.hour <= 9) {
      hour = "0" + hour;
    }
    String minute = date.minute.toString();
    if (date.minute <= 9) {
      minute = "0" + minute;
    }
    String second = date.second.toString();
    if (date.second <= 9) {
      second = "0" + second;
    }
    // String millisecond = date.millisecond.toString();
    String morningOrafternoon = "上午";
    if (date.hour >= 12) {
      morningOrafternoon = "下午";
    }

    if (formart["y-m"] != null && formart["m-d"] != null) {
      targetString = year + formart["y-m"] + month + formart["m-d"] + day;
    } else if (formart["y-m"] == null && formart["m-d"] != null) {
      targetString = month + formart["m-d"] + day;
    } else if (formart["y-m"] != null && formart["m-d"] == null) {
      targetString = year + formart["y-m"] + month;
    }

    targetString += " ";

    if (formart["m-a"] != null) {
      targetString += morningOrafternoon + " ";
    }

    if (formart["h-m"] != null && formart["m-s"] != null) {
      targetString += hour + formart["h-m"] + minute + formart["m-s"] + second;
    } else if (formart["h-m"] == null && formart["m-s"] != null) {
      targetString += minute + formart["m-s"] + second;
    } else if (formart["h-m"] != null && formart["m-s"] == null) {
      targetString += hour + formart["h-m"] + minute;
    }

    return targetString;
  }
}
