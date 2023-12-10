class DateTimeUtil {
  static DateTime getCurrentDateTimeTruncated() {
    DateTime now = DateTime.now();

    // 현재 시간의 초와 밀리초를 0으로 초기화
    DateTime truncatedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    return truncatedDateTime;
  }
}
