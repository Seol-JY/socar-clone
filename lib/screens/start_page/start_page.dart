import 'package:flutter/material.dart';

class StartLoadingPage extends StatelessWidget {
  const StartLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      body: Center(
        child: Image(
          width: 150,
          image: AssetImage('assets/SOCAR_LOGO.png'),
        ),
      ),
    );
  }
}
