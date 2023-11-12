import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class GoToGetCarWidget extends StatelessWidget {
  const GoToGetCarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onPressed: () => {Navigator.pushNamed(context, "/rent/map")},
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 22,
                horizontal: 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가지러 가기",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.gray600),
                  ),
                  SizedBox(height: 3),
                  Text("가까운 쏘카존 찾기",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.gray400)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset('assets/GO_TO_GET_CAR.png',
                    height: 100, fit: BoxFit.cover)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
