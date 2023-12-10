import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/services/user_auth_service.dart';
import 'package:socar/services/user_service.dart';
import 'package:socar/models/user.dart';

class NavDrawer extends StatelessWidget {
  UserAuthenticateService userAuthenticateService = UserAuthenticateService();
  NavDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? userUid = auth.currentUser?.uid;

    final UserService userService = UserService();

    return FutureBuilder<User?>(
      future: userService.findByUid(userUid ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('에러 발생: ${snapshot.error}');
        } else {
          User? userData = snapshot.data;
          String userName = userData?.username ?? "사용자 이름 없음";
          String userEmail = userData?.email ?? "사용자 이메일 없음";

          return Drawer(
            backgroundColor: ColorPalette.white,
            child: ListView(
              children: [
                SizedBox(
                  height: 110,
                  child: UserAccountsDrawerHeader(
                    accountName: Text(userName,
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
                      ),
                    ),
                  ),
                ),
                ListTile(
                  dense: true, // 여백을 줄이는 설정
                  leading: Icon(Icons.logout,
                      color: const Color.fromARGB(
                          255, 255, 90, 78)), // 로그아웃 아이콘 색상 변경
                  title: Text(
                    '로그아웃',
                    style: TextStyle(
                        color: const Color.fromARGB(
                            255, 255, 90, 78)), // 로그아웃 텍스트 색상 변경
                  ),
                  onTap: () async {
                    userAuthenticateService.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/select', (route) => false);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
