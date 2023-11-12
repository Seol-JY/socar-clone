import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPalette.white,
      child: ListView(
        children: [
          SizedBox(
            height: 110,
            child: UserAccountsDrawerHeader(
              accountName: const Text('설진영',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.gray500)),
              accountEmail: const Text(
                'abc12356@naver.com',
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
