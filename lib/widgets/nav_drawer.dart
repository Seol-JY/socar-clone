import 'package:firebase_auth/firebase_auth.dart' hide User;
// User 객체 겹침
import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/services/user_service.dart';
import 'package:socar/models/user.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? userUid = auth.currentUser?.uid;

    final UserService userService = UserService();

    return FutureBuilder<User?>(
      future: userService.findByUid(userUid ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터가 로딩 중일 때 표시할 UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러가 발생했을 때 표시할 UI
          return Text('에러 발생: ${snapshot.error}');
        } else {
          // 데이터를 성공적으로 가져왔을 때의 UI
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
                        )),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
