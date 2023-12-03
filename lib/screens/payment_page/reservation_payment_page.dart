import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:socar/models/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:socar/constants/colors.dart';
import 'dart:convert';
import 'package:socar/screens/payment_page/complete_payment_page.dart';
import 'package:socar/screens/payment_page/utils/text_style.dart';
import 'package:socar/screens/payment_page/widgets/insuar_radio.dart';
import 'package:socar/screens/payment_page/widgets/term_agreement.dart';
import 'package:socar/screens/payment_page/widgets/text_info.dart';
import 'package:socar/services/sms_send.dart';
import 'package:socar/services/user_service.dart';
import 'utils/time_check.dart';

Widget paddingDivider() {
  return Padding(
    padding: const EdgeInsets.all(8.0), // 모든 방향에 8.0 픽셀의 마진을 줍니다.
    child: Divider(
      thickness: 1,
      height: 1,
      color: Colors.black.withOpacity(0.3),
    ),
  );
}

class Reservationpaymentpage extends StatelessWidget {
  const Reservationpaymentpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReservationInfo();
  }
}

class ReservationInfo extends StatefulWidget {
  const ReservationInfo({super.key});

  @override
  State<ReservationInfo> createState() => _ReservationInfoState();
}

class _ReservationInfoState extends State<ReservationInfo> {
  final GlobalKey<_BottompaybarState> bottomBarKey = GlobalKey();
  String insuranceSelected = "";
  bool mainSelected = false;
  String carName = "";
  String oilType = "";
  int driveFee = 0;
  int rentFee = 0;
  String imageUrl = "";
  String socarZoneReference = "";
  String socarZoneCarRefer = "";

  @override
  void initState() {
    super.initState();
    // initState에서 비동기로 Firestore 데이터 가져오기
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  // Nullable 타입으로 선언하고 null로 초기화합니다.
  String? carDocumentId;

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
      if (licenseNumber == '236호2333') { // 특정 차 번호를 확인

        print('Found car document path: ${carDoc.reference.path}');
        socarZoneCarRefer = carDoc.reference.path;
        socarZoneReference = doc.reference.path;

        // 'car' 필드에서 DocumentReference를 가져옵니다.
        DocumentReference carRef = data['car'] as DocumentReference;

        // 해당 차량 문서의 스냅샷을 비동기적으로 가져옵니다.
        DocumentSnapshot carSnapshot = await carRef.get();

      // 차량 문서의 실제 데이터를 가져옵니다.
      if (carSnapshot.exists) {
        setState(() {
          var carData = carSnapshot.data() as Map<String, dynamic>;
        
        // 필요한 정보를 출력합니다.
        carName = carData["name"];
        //print("Car Name: $carName");
        oilType = carData["oil_type"];
        //print("Oil Type: $oilType");
        driveFee = carData["drive_km_fee"];
        //print("Drive Fee: $driveFee");
        imageUrl = carData["url"];
        //print("Image URL: $imageUrl");
        rentFee = carData["rent_fee"];
        //print("Rent Fee: $rentFee");
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

  void updateBottomBarState() {
    bool isActive = (insuranceSelected != "") && mainSelected;
    if (bottomBarKey.currentState != null) {
      bottomBarKey.currentState!.updateButtonState(isActive);
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("socarzone : $socarZoneReference, carrefer : $socarZoneCarRefer");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
          color: ColorPalette.gray600,
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent, // appBar 투명색
        elevation: 0.0, // appBar 그림자 농도 설정 (값 0으로 제거)
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarInfo(
                  carimage:
                      imageUrl,
                  carname: carName,
                  oiltype: oilType),
              paddingDivider(),
              DrivingFee(drivingfee: driveFee.toString()),
              paddingDivider(),
              const Returnlocation(returnLocation: "주차장 정보"),
              paddingDivider(),
              const Usetime(
                  startTime: "2023-11-08T14:30:00Z",
                  endTime: "2023-11-08T20:30:00Z"),
              paddingDivider(),
              InsuranceContainer(
                onOptionSelected: (selected) {
                  setState(() {
                    insuranceSelected = selected ?? "";
                    updateBottomBarState();
                  });
                },
              ),
              paddingDivider(),
              Finalprice(
                  rentalFee: rentFee.toString(),
                  insuranceFee: insuranceSelected),
              paddingDivider(),
              TermAgreementBoxWidget(
                onData: (selected) {
                  setState(() {
                    // selected가 null이 아닌 경우에만 mainSelected에 할당합니다.
                    if (selected != null) {
                      mainSelected = selected;
                    }
                    updateBottomBarState();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottompaybar(
        key: bottomBarKey, 
      socarZone: socarZoneReference,
      carReference:socarZoneCarRefer,),
    );
  }
}

class Bottompaybar extends StatefulWidget {
  final String socarZone;
  final String carReference;
  const Bottompaybar({
    Key? key,
    required this.carReference,
    required this.socarZone,
  }) : super(key: key);

  @override
  State<Bottompaybar> createState() => _BottompaybarState();
}

class _BottompaybarState extends State<Bottompaybar> {
  String insPrice = "0";
  bool terms = false;
  bool isButtonActive = false;
  String userPhoneNumber = "";

  Future<void> saveDateToFirestore() async {
  fireAuth.FirebaseAuth auth = fireAuth.FirebaseAuth.instance;
  String? userUid = auth.currentUser?.uid;
  UserService userService = UserService();

  if (userUid != null) {
    // 사용자 데이터를 가져옵니다.
    User? user = await userService.findByUid(userUid);

    // 가져온 사용자 데이터에서 전화번호를 추출합니다.
    String? userPhoneNumber = user?.phoneNumber;
    print(userPhoneNumber);

    // 이제 userPhoneNumber를 사용할 수 있습니다.
    // 예를 들어, Firestore에 데이터를 저장하는 로직을 추가할 수 있습니다.
  }

  

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Firestore 문서 경로 설정
  DocumentReference ref = firestore.collection('reservations').doc();

  // UTC 날짜 문자열을 DateTime 객체로 파싱합니다.
  DateTime startTimeUtc = DateTime.parse("2023-12-02T14:30:00Z");
  DateTime endTimeUtc = DateTime.parse("2023-12-13T20:30:00Z");


  Timestamp startTimestamp = Timestamp.fromDate(startTimeUtc);
  Timestamp endTimestamp = Timestamp.fromDate(endTimeUtc);

  DocumentReference carRef = firestore.doc(widget.carReference);
  DocumentReference socarzoneRef = firestore.doc(widget.socarZone);
  DocumentReference userRef = firestore.doc('users/${userUid}');
  
  // Firestore 문서에 날짜를 저장합니다.
  await ref.set({
    'start_time': startTimestamp,
    'end_time': endTimestamp,
    'reserved_car' : carRef,
    'socar_zone' : socarzoneRef,
    'total_price' : 23490,
    'user' : userRef,
  });
  print("good");
}

  void updateButtonState(bool isActive) {
    setState(() {
      isButtonActive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isButtonActive
          ? () {
              Navigator.pushNamed(context, '/completePayment');
              SmsSendService.sendMessage("차량예약이 완료되었습니다.", userPhoneNumber);
              saveDateToFirestore();
            }
          : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(70, 30, 70, 30),
        backgroundColor:
            isButtonActive ? ColorPalette.socarBlue : ColorPalette.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(
            color: Color(0xffE9EBEE),
          ),
        ),
      ),
      child: const Text(
        "결제하기",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorPalette.white,
        ),
      ),
    );
  }
}
