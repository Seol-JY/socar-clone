import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/smart_key_page/reservation_confirm_page.dart';



class CompletePayment extends StatelessWidget {
  const CompletePayment({super.key});

  Widget buildDivider(Color dividerColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: Divider(
        thickness: 4,
        height: 5,
        color: dividerColor,
      ),
    );
  }

  TextStyle whiteText() {
    return const TextStyle(color: Color(0xffFFFFFF));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final licenseNumber = arguments?['license_number'] as String?;
    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, //appBar 투명색
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context); //뒤로가기
                },
                color: Colors.black,
                icon: const Icon(Icons.clear_outlined)),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 방향으로 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.check_circle_sharp, color: ColorPalette.socarBlue, size: 100),
              SizedBox(height: 20),
              Text(
                "예약을 완료했어요!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "쏘카 카셰어링으로 둘어드는 탄소가 연간 39만 톤, \n 지구를 아끼는 여행에 함께해주셔서 고맙습니다.",
                style: TextStyle(color: ColorPalette.gray400, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 150),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 70),
          child: BottomAppBar(
            color: ColorPalette.white, // BottomAppBar의 배경색을 하얗게 설정
            elevation: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/reservationConfirm" ,
                    arguments:arguments);
                    print(arguments);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorPalette.gray300),
                    ),
                  ),
                  child: const Text(
                    "내 예약 보기",
                    style: TextStyle(
                        color: ColorPalette.gray400, fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/main");
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorPalette.gray300),
                    ),
                  ),
                  child: const Text(
                    "홈으로 가기",
                    style: TextStyle(
                        color: ColorPalette.socarBlue, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
