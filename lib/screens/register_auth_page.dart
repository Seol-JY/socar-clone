import 'package:flutter/material.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/register_page/term_agreement.dart';
import 'package:socar/widgets/register_page/name_input_widget.dart';

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
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TermAgreementBoxWidget(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "이름",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                NameInputWidget(),
              ],
            )),
      ),
    );
  }
}
