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
  String returnPlace = "";
  String socarZoneReference = "";
  String socarZoneCarRefer = "";
  String carNumber = "";
  String startTime = "";
  String endTime = "";

  @override
  void initState() {
    super.initState();
    // initState에서 비동기로 Firestore 데이터 가져오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      print(arguments);
      if (arguments != null) {
        carNumber = arguments["car_license"];
        startTime = arguments["start_time"];
        endTime = arguments["end_time"];
      } else {
        carNumber = '236호2333';
        startTime = "2023-12-02T14:30:00Z";
        endTime = "2023-12-03T14:30:00Z";
      }

      fetchDataFromFirestore();
    });
  }

  Future<void> fetchDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //arguments["car_license"];
    // Nullable 타입으로 선언하고 null로 초기화합니다.
    String? carDocumentId;

    try {
      // 'socar_zone' 컬렉션에서 차량 정보를 가져옵니다.
      QuerySnapshot socarZoneSnapshot =
          await firestore.collection('socar_zone').get();

      for (var doc in socarZoneSnapshot.docs) {
        DocumentReference docRef = doc.reference;
        QuerySnapshot carsSnapshot = await docRef.collection('cars').get();

        for (var carDoc in carsSnapshot.docs) {
          var data = carDoc.data()
              as Map<String, dynamic>; // 데이터를 Map<String, dynamic>으로 캐스팅
          if (data != null) {
            // 데이터가 null이 아닌지 확인
            var licenseNumber = data['license_number'];
            if (licenseNumber == carNumber) {
              //print('Found car document path: ${carDoc.reference.path}');
              docRef.get().then((DocumentSnapshot docSnapshot) {
                  if (docSnapshot.exists) {
                      // Access and print the 'name' field from the document
                      returnPlace = docSnapshot.get('name');
                  } else {
                      //print('Document does not exist in the database');
                  }
              });
              socarZoneCarRefer = carDoc.reference.path;
              socarZoneReference = doc.reference.path;

              DocumentReference carRef = data['car'] as DocumentReference;

              DocumentSnapshot carSnapshot = await carRef.get();

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
    if (carNumber.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
              CarInfo(carimage: imageUrl, carname: carName, oiltype: oilType),
              paddingDivider(),
              DrivingFee(drivingfee: driveFee.toString()),
              paddingDivider(),
              Returnlocation(returnLocation: returnPlace),
              paddingDivider(),
              Usetime(startTime: startTime, endTime: endTime),
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
          carReference: socarZoneCarRefer,
          licenseNumber: carNumber,
          StartTime: startTime,
          EndTime: endTime),
    );
  }
}

class Bottompaybar extends StatefulWidget {
  final String socarZone;
  final String carReference;
  final String licenseNumber;
  final String StartTime;
  final String EndTime;
  const Bottompaybar({
    Key? key,
    required this.carReference,
    required this.socarZone,
    required this.licenseNumber,
    required this.StartTime,
    required this.EndTime,
  }) : super(key: key);

  @override
  State<Bottompaybar> createState() => _BottompaybarState();
}

class _BottompaybarState extends State<Bottompaybar> {
  String insPrice = "0";
  bool terms = false;
  bool isButtonActive = false;
  String? userPhoneNumber = "";
  String endTimeInfo = "";
  DocumentReference? reservation_info;

  Future<DocumentReference<Object?>> saveDateToFirestore() async {
    fireAuth.FirebaseAuth auth = fireAuth.FirebaseAuth.instance;
    String? userUid = auth.currentUser?.uid;
    UserService userService = UserService();

    if (userUid != null) {
      User? user = await userService.findByUid(userUid);

      userPhoneNumber = user?.phoneNumber;
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference ref = firestore.collection('reservations').doc();
    DateTime startTimeUtc = DateTime.parse(widget.StartTime);
    DateTime endTimeUtc = DateTime.parse(widget.EndTime);

    Timestamp startTimestamp = Timestamp.fromDate(startTimeUtc);
    Timestamp endTimestamp = Timestamp.fromDate(endTimeUtc);
    endTimeInfo = formatter.format(endTimestamp.toDate());
    DocumentReference carRef = firestore.doc(widget.carReference);
    DocumentReference socarzoneRef = firestore.doc(widget.socarZone);
    DocumentReference userRef = firestore.doc('users/${userUid}');

    try {
      await ref.set({
        'start_time': startTimestamp,
        'end_time': endTimestamp,
        'reserved_car': carRef,
        'socar_zone': socarzoneRef,
        'total_price': 23490,
        'user': userRef,
      });

      // 'set' 메서드가 완료되었을 때 실행되는 코드
      return ref;
    } catch (error) {
      // 오류가 발생했을 때 처리하는 코드
      print("Error setting document: $error");
      // return null 또는 다른 fallback 값 (예: throw Exception('Error setting document');)
      return Future.value(null);
    }
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
          ? () async {
              DocumentReference? result = await saveDateToFirestore();
              print(userPhoneNumber);
              Navigator.pushNamed(context, '/completePayment', arguments: {
                "license_number": widget.licenseNumber,
                "docRef": result
              });
              SmsSendService.sendMessage(
                  "차랑번호: [${widget.licenseNumber}], 차량예약이 완료되었습니다.\n반납시간 : [${endTimeInfo}]",
                  userPhoneNumber);
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
