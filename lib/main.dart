import 'package:firebase_core/firebase_core.dart';
import 'package:socar/services/user_auth_service.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:socar/firebase_options.dart';
import 'package:socar/screens/payment_page/reservation_payment_page.dart'; // 예약페이지
import 'package:socar/screens/payment_page/complete_payment_page.dart'; // 결제 완료 페이지
import 'package:socar/screens/smart_key_page/reservation_confirm_page.dart'; // 결제 확인 페이지
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:socar/screens/rent_map_page/rent_map_page.dart';
import 'screens/main_page/main_page.dart';
import 'screens/login_register_page/login_register_page.dart';
import 'screens/login_page/login_page.dart';
import 'screens/register_auth_page/register_auth_page.dart';
import 'screens/register_input_page/register_input_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'r3hfqo684f');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        // UserAuthenticateService.checkLoginStatus() ? "/main" : "/select",
        routes: {
          "/select": (context) => const LoginRegisterSelectionpage(),
          "/login": (context) => const LoginPage(),
          "/register/auth": (context) => RegisterAuthPage(),
          "/register/input": (context) => const RegisterInputPage(),
          "/main": (context) => MainPage(),
          "/rent/map": (context) => const RentMapPage(),
          '/reservationPayment': (context) => const Reservationpaymentpage(),
          '/reservationConfirm': (context) => const ReservationConfirm(),
          '/completePayment': (context) => const CompletePayment()
        });
  }
}
