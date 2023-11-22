import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/smart_key_page/widgets/appbar.dart';
import 'package:socar/screens/smart_key_page/widgets/smartkey_bottom_bar.dart';
import 'package:socar/widgets/nav_drawer.dart';

import 'widgets/text_info.dart';

class ReservationConfirm extends StatelessWidget {
  const ReservationConfirm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.gray600,
      appBar: buildAppBar(context),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: buildBody(),
      ),
      bottomNavigationBar: SmartkeyBottomBar(),
    );
  }

  
  Widget buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildCarImage(),
          buildCarTitle(),
          buildCarStatus(),
          buildDateTimeInfo(),
          buildDivider(ColorPalette.socarBlue),
          buildReservationStatus(),
          buildLocationInfo("대여장소", "위치"),
          buildInfoRow("챠량확인", "이용안내보기"),
          buildInfoRow("쏘카 이용방법이 궁금하다면?", ""),
          buildRentTimeInfo(),
        ],
      ),
    );
  }

  
}
