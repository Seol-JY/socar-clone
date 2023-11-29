import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/main_page/main_page.dart';
import 'package:socar/services/user_service.dart';
import 'package:socar/utils/CustomDateUtils.dart';

class ReservationCar extends StatelessWidget {
  late Future<List<ReservationData>> futureReservationDatas;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserService userService = UserService();

  ReservationCar({
    Key? key,
  }) : super(key: key) {
    // Assume you have an asynchronous function to fetch reservation data
    futureReservationDatas = fetchReservationData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReservationData>>(
      future: futureReservationDatas,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Error state
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If reservationDatas is empty, return an empty container or any other widget
          return Container();
        } else {
          // Data loaded successfully
          List<ReservationData> reservationDatas = snapshot.data!;

          return DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.09,
            maxChildSize: 1,
            snapSizes: [0.09, 0.2, 0.5, 1],
            snap: true,
            builder:
                (BuildContext context, ScrollController scrollSheetController) {
              return SizedBox(
                height: 160,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SingleChildScrollView(
                        controller: scrollSheetController,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 150, right: 150, top: 10, bottom: 14),
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ColorPalette.gray200,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${reservationDatas[0].userName} 님의 예약 ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.gray600,
                                  ),
                                ),
                                Text(
                                  "${reservationDatas.length}건",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.socarBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: reservationDatas.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              padding: EdgeInsets.only(top: 22, bottom: 22),
                              decoration: index != reservationDatas.length - 1
                                  ? BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorPalette
                                              .gray200, // 원하는 색상으로 변경
                                          width: 0.8, // 원하는 두께로 변경
                                        ),
                                      ),
                                    )
                                  : null,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.network(
                                        reservationDatas[index].carImageURL,
                                        width: 90,
                                        height: 55,
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reservationDatas[index].carNumber,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: ColorPalette.gray600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          DateTime.now().isAfter(
                                                  reservationDatas[index]
                                                      .reservationStartTime)
                                              ? "~ ${CustomDateUtils.singleDateTimeFormatter(reservationDatas[index].reservationEndTime)}"
                                              : "${CustomDateUtils.singleDateTimeFormatter(reservationDatas[index].reservationStartTime)} ~",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.gray500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          reservationDatas[index]
                                              .parkingLocation,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: ColorPalette.gray400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
                                            vertical: 12,
                                            horizontal: 10.0,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 12,
                                        ),
                                        label: const Text(
                                          '스마트키',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  // Mock asynchronous function for fetching reservation data
  Future<List<ReservationData>> fetchReservationData() async {
    DocumentReference<Object?>? userRef =
        await userService.getDocRefByUid(auth.currentUser?.uid);
    try {
      Timestamp now = Timestamp.now();
      // Firebase에서 데이터 가져오기
      QuerySnapshot querySnapshot = await _firestore
          .collection('reservations')
          .where('user', isEqualTo: userRef)
          .where('end_time', isGreaterThan: now)
          .get();

      // 비동기 작업을 병렬로 수행하기 위해 Future.wait 사용
      List<Future<ReservationData>> futures =
          querySnapshot.docs.map((DocumentSnapshot document) async {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        DocumentSnapshot reservedCarSnapshot = await data['reserved_car'].get();
        DocumentSnapshot socarZoneSnapshot = await data['socar_zone'].get();
        DocumentSnapshot userSnapshot = await data['user'].get();
        DocumentSnapshot carSnapshot = await reservedCarSnapshot['car'].get();

        return ReservationData(
          userName: userSnapshot['username'],
          carImageURL: carSnapshot['url'],
          carNumber: reservedCarSnapshot['license_number'],
          reservationStartTime:
              data['start_time'].toDate(), // Timestamp를 DateTime으로 변환
          reservationEndTime:
              data['end_time'].toDate(), // Timestamp를 DateTime으로 변환
          parkingLocation: socarZoneSnapshot['name'],
        );
      }).toList();

      // 모든 비동기 작업이 완료될 때까지 기다림
      List<ReservationData> reservations = await Future.wait(futures);

      return reservations;
    } catch (e) {
      // 에러 처리
      print('Error fetching reservation data: $e');
      throw e;
    }
  }
}
