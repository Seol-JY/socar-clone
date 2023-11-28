import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

String getIsoDatetime() {
  var now = DateTime.now();
  var utcOffsetSec = now.timeZoneOffset.inSeconds;
  var utcOffset = Duration(seconds: utcOffsetSec);
  return now.subtract(utcOffset).toIso8601String();
}

String getSignature(String apiSecret, String msg) {
  var hmacSha256 = Hmac(sha256, utf8.encode(apiSecret));
  var digest = hmacSha256.convert(utf8.encode(msg));
  return digest.toString();
}

Map<String, String> getHeaders(String apiKey, String apiSecret) {
  var date = getIsoDatetime();
  var salt = DateTime.now().millisecondsSinceEpoch.toString();
  var combinedString = '$date$salt';

  return {
    'Authorization': 'HMAC-SHA256 ApiKey=$apiKey, Date=$date, salt=$salt, signature=' +
        getSignature(apiSecret, combinedString),
    'Content-Type': 'application/json; charset=utf-8',
  };
}

Future<http.Response> sendSMS(String apiKey, String apiSecret, String to, String from, String text) async {
  var url = Uri.parse('https://api.coolsms.co.kr/messages/v4/send-many');

  var headers = getHeaders(apiKey, apiSecret);

  var body = jsonEncode({
    'messages': [
      {'to': to, 'from': from, 'text': text, 'type': 'sms'}
    ],
    'agent': {'sdkVersion': 'dart/3.1.3', 'osPlatform': 'unknown'},
  });

  return await http.post(url, headers: headers, body: body);
}


void SMSsend(var text) async {
  var apiKey = 'NCSI8THKEJ1KFWAI';
  var apiSecret = '6KJWHMJ4YHNPEED7UJSD0H2MRAWBNNBT';
  var to = '01090516709'; // 수신번호(문자를 받을 사람)
  var from = '01090516709'; // 발신번호(문자를 보낼 사람)

  try {
    var response = await sendSMS(apiKey, apiSecret, to, from, text);
    print('SMS 전송 성공. 응답: $response');
  } catch (e) {
    print('SMS 전송 실패. 에러: $e');
    // 필요한 경우 에러를 처리합니다
  }
}



/*

void main() async {
  var apiKey = 'NCSI8THKEJ1KFWAI';
  var apiSecret = '6KJWHMJ4YHNPEED7UJSD0H2MRAWBNNBT';
  var to = '01090516709'; // 수신번호(문자를 받을 사람)
  var from = '01090516709'; // 발신번호(문자를 보낼 사람)
  var text = 'Test Message'; // 문자내용

  var response = await sendSMS(apiKey, apiSecret, to, from, text);
  print(response.body);
}

*/