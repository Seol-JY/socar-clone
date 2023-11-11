import 'package:flutter/material.dart';
import 'package:socar/widgets/main_page/go_to_get_car.dart';
import 'package:socar/widgets/main_page/main_bar.dart';
import 'package:socar/widgets/main_page/reservation_car.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarinBar(),
      backgroundColor: const Color(0xfff2f4f6),
      // 예약 있으면 활성화할것
      bottomSheet: true ? const ReservationCar() : null,
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GoToGetCarWidget(),
          ],
        ),
      ),
    );
  }
}
