// bottom_modal_content.dart

import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/main_page/main_page.dart';
import 'package:socar/utils/CustomDateUtils.dart';

class ReservationCar extends StatelessWidget {
  final ReservationData reservationData;

  const ReservationCar({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            color: ColorPalette.white,
            border: Border.all(
                color: const Color.fromARGB(255, 230, 230, 230), width: 1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  "${reservationData.userName} 님의 예약 ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.gray600),
                ),
                Text(
                  "1건",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.socarBlue),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      reservationData.carImageURL,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reservationData.carNumber,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.gray600)),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                                "~ ${CustomDateUtils.singleDateTimeFormatter(reservationData.reservationEndTime)}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.gray500)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(reservationData.parkingLocation,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalette.gray400))
                          ])),
                  Flexible(
                      flex: 1,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 0,
                            backgroundColor: ColorPalette.gray600,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10.0),
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 12,
                          ),

                          label: const Text('스마트키',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              )), // <-- Text
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
