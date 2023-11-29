import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socar/constants/colors.dart';
import 'dart:convert';
import 'package:socar/screens/payment_page/complete_payment_page.dart';
import 'package:socar/screens/payment_page/utils/text_style.dart';
import 'package:socar/screens/payment_page/widgets/insuar_radio.dart';
import 'package:socar/screens/payment_page/widgets/term_agreement.dart';
import 'package:socar/screens/payment_page/widgets/text_info.dart';
import 'package:socar/services/sms_send.dart';
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
  String image_url = "";

  @override
  void initState() {
    super.initState();
    // initState에서 비동기로 Firestore 데이터 가져오기
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot doc =
          await firestore.collection("car").doc("avanteN").get();
      setState(() {
        carName = doc.get("name");
        oilType = doc.get("oil_type");
        driveFee = doc.get("drive_km_fee");
        rentFee = doc.get("rent_fee");
      });
    } catch (error) {
      print("Error: $error");
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
                      "https://img1.daumcdn.net/thumb/R400x0/?fname=%2Fmedia%2Fvitraya%2Fauto%2Fimage%2F8eac04%2FC672C539077C8F46909D9A13CA6A7E7AFDF06B2CF21721E72B_6U9U",
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
      bottomNavigationBar: Bottompaybar(key: bottomBarKey),
    );
  }
}

class Bottompaybar extends StatefulWidget {
  const Bottompaybar({Key? key}) : super(key: key);

  @override
  State<Bottompaybar> createState() => _BottompaybarState();
}

class _BottompaybarState extends State<Bottompaybar> {
  String insPrice = "0";
  bool terms = false;
  bool isButtonActive = false;

  void updateButtonState(bool isActive) {
    setState(() {
      print("is button active $isActive");
      isButtonActive = isActive;
      print("is button active $isButtonActive");
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isButtonActive
          ? () {
              Navigator.pushNamed(context, '/completePayment');
              SmsSendService.sendMessage("차량예약이 완료되었습니다.", '01090516709');
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
