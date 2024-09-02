class ConvertTimeComponenet {
  static String convertToAgo(DateTime dataOther) {
    Duration diff = DateTime.now().toLocal().difference(dataOther);

    if (diff.inDays >= 365) return '${diff.inDays ~/ 365} ปีก่อน';
    if (diff.inDays >= 30) return '${diff.inDays ~/ 30} เดือนก่อน';
    if (diff.inDays >= 7) return '${diff.inDays ~/ 7} สัปดาห์ก่อน';
    if (diff.inDays >= 1) return '${diff.inDays} วันก่อน';
    if (diff.inHours >= 1) return '${diff.inHours} ชั่วโมงก่อน';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} นาทีก่อน';
    if (diff.inSeconds >= 1) return '${diff.inSeconds} วินาทีก่อน';
    return 'ไม่กี่วินาทีที่แล้ว';
  }

  /// Show between date and time Ex.I "1 day", Ex.II "1 hours", Ex.III "1 minutes"
  /// [from] is start date time
  /// [to] is end date time
  static String between(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);

    final _years = from.difference(to).inDays ~/ 365;
    final _months = from.difference(to).inDays ~/ 30;
    final _days = from.difference(to).inDays;
    final _hours = from.difference(to).inHours - (_days * 24);
    final _minutes = from.difference(to).inMinutes - (_days * 24 * 60) - (_hours * 60);

    if (_years > 0) return '$_years ปี';
    if (_months > 0) return '$_months เดือน';
    if (_days > 0) return '$_days วัน';
    if (_hours > 0) return '$_hours ชั่วโมง';
    if (_minutes > 0) return '$_minutes นาที';
    return 'ไม่กี่วินาที';
  }
}
