import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    // 현재 사용자 가져오기
    User? user = auth.currentUser;
    print(user);

    // 사용자가 로그인되어 있고 이메일이 있다면 이메일을 가져오기
    String userEmail = user?.email ?? "이메일 없음";
    return Drawer(
      backgroundColor: ColorPalette.white,
      child: ListView(
        children: [
          SizedBox(
            height: 110,
            child: UserAccountsDrawerHeader(
              accountName: const Text('이름 조회 구현 필요',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.gray500)),
              accountEmail: Text(
                userEmail,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.gray400),
              ),
              onDetailsPressed: () {},
              decoration: const BoxDecoration(
                  color: ColorPalette.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 1,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
