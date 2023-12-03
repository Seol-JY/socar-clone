import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/smart_key_page/widgets/appbar.dart';
import 'package:socar/screens/smart_key_page/widgets/smartkey_bottom_bar.dart';
import 'package:socar/utils/CustomDateUtils.dart';
import 'package:socar/widgets/nav_drawer.dart';

import 'widgets/text_info.dart';

class ReservationConfirm extends StatefulWidget {
  const ReservationConfirm({Key? key});

  @override
  State<ReservationConfirm> createState() => _ReservationConfirmState();
}

String? getlicenseNumber;
Map<String, dynamic> reservationData = {};
DocumentReference<Map<String, dynamic>>? reservationInfo;

class _ReservationConfirmState extends State<ReservationConfirm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // build 메서드가 완전히 빌드된 후에 실행됩니다.
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      getlicenseNumber = arguments?['license_number'] as String?;
      reservationInfo = arguments?["docRef"];
      print(reservationInfo);
      print(arguments);

      // 필요한 경우 fetchDataFromFirestore 메서드를 여기에서 호출할 수 있습니다.
      fetchDataFromFirestore();
    });
  }
  
  void deleteRef() async {
    try {
      if (reservationInfo != null) {
        await reservationInfo!.delete();
        print("Document successfully deleted!");
      } else {
        print("Document reference is null. Cannot delete.");
      }
    } catch (e) {
      print("Error deleting document: $e");
  }
}



  Future<void> fetchDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    if (reservationInfo != null) {
    try {
      // reservationInfo가 null이 아니면 DocumentSnapshot을 가져옵니다.
      DocumentSnapshot<Map<String, dynamic>> snapshot = await reservationInfo!.get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        print(snapshot.data());  // 데이터 출력
        if (data!=null){
          Timestamp startTimeTimestamp =  data["start_time"];
          Timestamp endTimeTimestamp =  data["end_time"];
          DateTime startTime = startTimeTimestamp.toDate();
          DateTime endTime = endTimeTimestamp.toDate();
         reservationData = {
          "start_time":startTime,
          "end_time" : endTime,
          // 다른 필드도 필요에 따라 추가
        };
      }
        // 여기에 다른 데이터 처리 로직을 추가할 수 있습니다.
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print("Error fetching document: $e");
    }
  } else {
    print("No reservationInfo to fetch.");
  }
  try {
    // 'socar_zone' 컬렉션에서 차량 정보를 가져옵니다.
   QuerySnapshot socarZoneSnapshot = await firestore.collection('socar_zone').get();
  
  for (var doc in socarZoneSnapshot.docs) {
    DocumentReference docRef = doc.reference;
    QuerySnapshot carsSnapshot = await docRef.collection('cars').get();

    for (var carDoc in carsSnapshot.docs) {
    var data = carDoc.data() as Map<String, dynamic>; // 데이터를 Map<String, dynamic>으로 캐스팅
    if (data != null) { // 데이터가 null이 아닌지 확인
      var licenseNumber = data['license_number'];
      if (licenseNumber == getlicenseNumber) { // 특정 차 번호를 확인

        DocumentReference carRef = data['car'] as DocumentReference;
        DocumentSnapshot carSnapshot = await carRef.get();

        if (carSnapshot.exists) {
          var carData = carSnapshot.data() as Map<String, dynamic>;
          setState(() {
          reservationData["carName"] = carData['name'];
          reservationData["oilType"] = carData['oil_type'];
          reservationData["driveFee"] = carData['drive_km_fee'];
          reservationData["imageUrl"] = carData['url'];
          reservationData["rentFee"] = carData['rent_fee'];
        });

        } else {
          print('Car document does not exist.');
        }
    }
  }
}
  }
  } catch (error) {
    //print("Error fetching data: $error");
  }
  }

  @override
  Widget build(BuildContext context) {
    // UI를 로딩하는 동안 reservationData가 비어 있을 수 있으므로, 이를 처리합니다.
    if (reservationData.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      backgroundColor: ColorPalette.gray600,
      appBar: buildAppBar(context),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: buildBody(reservationData),
      ),
      bottomNavigationBar: SmartkeyBottomBar(onDeleteRef : deleteRef),
    );
  }

  Widget buildBody(dynamic reservationData) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildCarImage(reservationData["imageUrl"]),
          buildCarTitle(reservationData["carName"]),
          buildCarStatus(reservationData["oilType"]),
          buildDateTimeInfo(CustomDateUtils.singleDateTimeFormatter(reservationData["start_time"]), 
          CustomDateUtils.singleDateTimeFormatter(reservationData["end_time"])),
          buildDivider(ColorPalette.socarBlue),
          buildReservationStatus(),
          buildLocationInfo("대여장소", "위치"),
          buildInfoRow("챠량확인", "이용안내보기", "https://socar-docs.zendesk.com/hc/ko/articles/360048397194"),
          buildInfoRow("쏘카 이용방법이 궁금하다면?", "", "https://www.socar.kr/guide"),
          buildRentTimeInfo(CustomDateUtils.singleDateTimeFormatter(reservationData["start_time"])),
        ],
      ),
    );
  }
}
