import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:socar/screens/rent_map_page.dart';
import '../screens/main_page.dart';
import '../screens/login_register_page.dart';
import '../screens/login_page.dart';
import '../screens/register_auth_page.dart';
import '../screens/register_input_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'r3hfqo684f');
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
      initialRoute: "/main",
      routes: {
        "/select": (context) => const LoginRegisterSelectionpage(),
        "/login": (context) => const LoginPage(),
        "/register/auth": (context) => const RegisterAuthPage(),
        "/register/input": (context) => const RegisterInputPage(),
        "/main": (context) => const MainPage(),
        "/rent/map": (context) => const RentMapPage(),
      },
    );
  }
}
