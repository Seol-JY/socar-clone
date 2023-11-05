import 'package:flutter/material.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/register_page/term_agreement.dart';

class RegisterAuthPage extends StatefulWidget {
  const RegisterAuthPage({super.key});

  @override
  State<RegisterAuthPage> createState() {
    return RegisterAuthPageState();
  }
}

class RegisterAuthPageState extends State<RegisterAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: CustomAppBar(
        titleText: "휴대폰 본인인증",
      ),
      body: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            children: [
              TermAgreementBoxWidget(),
            ],
          )),
    );
  }
}
