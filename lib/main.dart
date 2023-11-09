import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socar/reservation_payment_page.dart';  // 예약페이지
import 'package:socar/complete_payment_page.dart'; // 결제 완료 페이지
import 'package:socar/reservation_confirm_page.dart'; // 결제 확인 페이지



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PriceInfo(),
      child : const MyApp()),
    );
    
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/reservationPayment',
      routes: {
        '/reservationPayment' : (context)=> Reservationpaymentpage(),
        '/reservationConfirm' : (context)=> ReservationConfirm(),
        '/completePayment' : (context) => CompletePayment()
      },
    );
  }
}
