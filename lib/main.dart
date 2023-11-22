import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socar/reservation_payment_page.dart'; // 예약페이지
import 'package:socar/complete_payment_page.dart'; // 결제 완료 페이지
import 'package:socar/reservation_confirm_page.dart'; // 결제 확인 페이지
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:socar/screens/rent_map_page/rent_map_page.dart';
import 'screens/main_page/main_page.dart';
import 'screens/login_register_page/login_register_page.dart';
import 'screens/login_page/login_page.dart';
import 'screens/register_auth_page/register_auth_page.dart';
import 'screens/register_input_page/register_input_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'r3hfqo684f');
  runApp(
    ChangeNotifierProvider(
        create: (context) => PriceInfo(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('ko', ''), // Korean, no country code
        ],
        theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
        ),
        home: const RentMapPage(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/select",
        routes: {
          "/select": (context) => const LoginRegisterSelectionpage(),
          "/login": (context) => const LoginPage(),
          "/register/auth": (context) => const RegisterAuthPage(),
          "/register/input": (context) => const RegisterInputPage(),
          "/main": (context) => const MainPage(),
          "/rent/map": (context) => const RentMapPage(),
          '/reservationPayment': (context) => Reservationpaymentpage(),
          '/reservationConfirm': (context) => const ReservationConfirm(),
          '/completePayment': (context) => const CompletePayment()
        });
  }
}
