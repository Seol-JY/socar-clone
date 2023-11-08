Duration Caldatediffernce(String time1, String time2){
  DateTime StartTime = DateTime.parse(time1);
  DateTime EndTime = DateTime.parse(time2);

  Duration difference = EndTime.difference(StartTime);
  return difference;
}

String HourStringfromDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return "${twoDigits(duration.inHours)}";
}

String MinStringfromDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return "$twoDigitMinutes";
}

String SecondStringfromDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return "$twoDigitSeconds";
}

String StringFormatFromTime(String time) {
  // 문자열을 DateTime 객체로 변환
  DateTime startTime = DateTime.parse(time);

  // DateTime 객체에서 시와 분을 추출
  int startHour = startTime.hour;
  int startMinute = startTime.minute;

  // 결과 출력
  return '$startHour 시 $startMinute 분';
}