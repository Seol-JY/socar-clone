import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/smart_key_page/widgets/appbar.dart';
import 'package:socar/screens/smart_key_page/widgets/smartkey_bottom_bar.dart';
import 'package:socar/utils/CustomDateUtils.dart';
import 'package:socar/widgets/nav_drawer.dart';

import 'widgets/text_info.dart';

class ReservationConfirm extends StatelessWidget {
  const ReservationConfirm({Key? key});
  
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final dynamic reservationData = args["data"];
    print(reservationData.reservationEndTime);
    return Scaffold(
      backgroundColor: ColorPalette.gray600,
      appBar: buildAppBar(context),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: buildBody(reservationData),
      ),
      bottomNavigationBar: SmartkeyBottomBar(),
    );
  }

  
  Widget buildBody(dynamic reservationData) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildCarImage(reservationData.carImageURL),
          buildCarTitle("소나타"),
          buildCarStatus("휘발유"),
          buildDateTimeInfo(CustomDateUtils.singleDateTimeFormatter(reservationData.reservationStartTime), 
          CustomDateUtils.singleDateTimeFormatter(reservationData.reservationEndTime)),
          buildDivider(ColorPalette.socarBlue),
          buildReservationStatus(),
          buildLocationInfo("대여장소", "위치"),
          buildInfoRow("챠량확인", "이용안내보기", "https://socar-docs.zendesk.com/hc/ko/articles/360048397194"),
          buildInfoRow("쏘카 이용방법이 궁금하다면?", "", "https://www.socar.kr/guide"),
          buildRentTimeInfo(CustomDateUtils.singleDateTimeFormatter(reservationData.reservationStartTime)),
        ],
      ),
    );
  }

  
}
