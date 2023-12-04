import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socar/models/socar_zone.dart';
import 'package:socar/screens/main_page/main_page.dart';

import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/place_widget.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/car_list_view.dart';
import 'package:socar/constants/color.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/swipe_bar.dart';

import 'package:socar/car_data/car_data.dart';

import '../../../../constants/fold_state_enum.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AnimatedBottomModalSheet extends StatelessWidget {
  const AnimatedBottomModalSheet({
    required this.screenHeight,
    required this.halfScreenHeight,
    Key? key,
    required this.fold,
    required this.getFoldState,
    required this.sheetState,
    required this.socarZone,
    required this.timeRange,
    required this.isChanged,
    required this.updateTimeRange,
  }) : super(key: key);

  final void Function(bool) fold;
  final int Function() getFoldState;

  final double screenHeight;
  final double halfScreenHeight;
  final StateSetter sheetState;
  final SocarZone socarZone;

  final DateTimeRange timeRange;
  final bool isChanged;
  final void Function(DateTimeRange newTimeRange) updateTimeRange;

  Future<List<String>> fetchCarNumberBySocarZone(SocarZone socarZone) async {
    try {
      CollectionReference collectionReference =
          _firestore.collection('socar_zone');
      DocumentReference socarZoneData = collectionReference.doc(socarZone.id);
      CollectionReference carsQuery = socarZoneData.collection("cars");

      QuerySnapshot carNumberSnapshot = await carsQuery.get();
      List<String> usernames = carNumberSnapshot.docs
          .map((doc) => doc['license_number'].toString())
          .toList();

      return usernames;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<ReservationData>> fetchReservationDataBySocarZone(
      SocarZone socarZone) async {
    try {
      DateTime setStartTime = timeRange.start;
      DateTime setEndTime = timeRange.end;

      QuerySnapshot querySnapshot =
          await _firestore.collection('reservations').get();

      // 비동기 작업을 병렬로 수행하기 위해 Future.wait 사용
      List<Future<ReservationData>> futures = querySnapshot.docs.where((doc) {
        Timestamp startTime = doc['start_time'];
        Timestamp endTime = doc['end_time'];

        DateTime startDateTime = startTime.toDate();
        DateTime endDateTime = endTime.toDate();

        if (setStartTime.isBefore(startDateTime)) {
          return setEndTime.isAfter(endDateTime);
        } else {
          return setStartTime.isBefore(endDateTime);
        }
      }).map((DocumentSnapshot document) async {
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

  @override
  Widget build(BuildContext context) {
    int foldState = getFoldState();

    return AnimatedContainer(
      curve: Curves.easeInBack,
      duration: const Duration(milliseconds: 600),
      height: foldState == FoldState.Fold.idx ? halfScreenHeight : screenHeight,
      color: ColorPalette.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onVerticalDragEnd: (details) {
              sheetState(() {
                // swipe-down
                if (details.primaryVelocity! > 0) {
                  fold(true);
                }
                // swipe-up
                if (details.primaryVelocity! < 0) {
                  fold(false);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  PaddingBox(),
                  Swipebar(),
                  PaddingBox(),
                ],
              ),
            ),
          ),
          PlaceWidget(socarZone: socarZone),
          FutureBuilder(
            future: Future.wait([
              getCarDataBySocarZoneId(socarZone.id),
              fetchReservationDataBySocarZone(socarZone),
              fetchCarNumberBySocarZone(socarZone)
            ]),
            // 비동기 함수를 호출하여 Future를 얻습니다.
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('에러: ${snapshot.error}');
              } else {
                List<dynamic> data = snapshot.data ?? [];

                List<CarData> carDataList = data[0] ?? [];
                List<ReservationData> carReservation = data[1] ?? [];
                List<String> imgUrls = [];
                List<String> carNumbers = data[2] ?? [];

                for (ReservationData data in carReservation) {
                  imgUrls.add(data.carImageURL);
                  carNumbers.add(data.carNumber);
                }

                return CarListView(
                    carList: carDataList,
                    reservationList: imgUrls,
                    reservationNumber: carNumbers,
                    timeRange: timeRange,
                    isChanged: isChanged,
                    updateTimeRange: updateTimeRange);
              }
            },
          )
        ],
      ),
    );
  }
}
