import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



Widget buildCarImage(String url) {
    return Image.network(
      url,
      width: 100,
      height: 100,
    );
  }

  Widget buildCarTitle(String CarName) {
    return Text(
      CarName,
      style: TextStyle(color: ColorPalette.white, fontSize: 20, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }

  Widget buildCarStatus(String oilType) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        "차량 준비 중 | $oilType",
        textAlign: TextAlign.center,
        style: TextStyle(color: ColorPalette.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildDateTimeInfo(String Start_Time, String End_Time) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$Start_Time", style: TextStyle(color: ColorPalette.socarBlue)),
          Text("$End_Time", style: TextStyle(color: ColorPalette.socarBlue)),
        ],
      ),
    );
  }

  Widget buildDivider(Color dividerColor) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        thickness: 4,
        height: 5,
        color: dividerColor,
      ),
    );
  }

  Widget buildReservationStatus() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Text("예약이 완료되었습니다.", style: TextStyle(color: ColorPalette.white)),
    );
  }

  Widget buildLocationInfo(String title1, String title2) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.socarBlue,
        borderRadius: BorderRadius.circular(7.0),
      ),
      margin: EdgeInsets.fromLTRB(7, 10, 7, 7),
      width: 200,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("대여장소", style: TextStyle(color: ColorPalette.white)),
          Text("         위치", style: TextStyle(color: ColorPalette.white)),
        ],
      ),
    );
  }


  Widget buildInfoRow(String title1, String title2, String url) {
    print(url);
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.gray500,
        borderRadius: BorderRadius.circular(7.0),
      ),
      margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
      width: 200,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title1, style: TextStyle(color: ColorPalette.gray200)),
          Text("         $title2", style: TextStyle(color: ColorPalette.gray200)),
          IconButton(
            onPressed: () async{
              launchUrl(Uri.parse(url));
              },
            icon: Icon(Icons.navigate_next_outlined), 
            color: ColorPalette.white),
        ],
      ),
    );
  
}


  Widget buildRentTimeInfo(String StartTime) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.watch_later, color: ColorPalette.gray200),
          Text("  대여 시각 $StartTime", style: TextStyle(color: ColorPalette.gray200)),
        ],
      ),
    );
  }