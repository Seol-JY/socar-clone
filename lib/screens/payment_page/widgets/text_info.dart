import 'package:flutter/material.dart';
import 'package:socar/constants/color.dart';
import 'package:socar/screens/payment_page/utils/text_style.dart';
import 'package:socar/screens/payment_page/utils/time_check.dart';


class Returnlocation extends StatelessWidget {
  final String returnLocation;
  const Returnlocation({Key? key, required this.returnLocation}) : super(key: key);

    @override
    Widget build(BuildContext context){
      return Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[Padding(padding : EdgeInsets.only(left: 20),
            child :  Text("대여 반납 장소 공간", style: titleTextStyle())), 
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            margin : const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child :Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("$returnLocation",
            style: subTextStyle(),)
          ],)),
          ],));
    }
  }

class Usetime extends StatelessWidget {
  final String startTime, endTime;
  const Usetime({Key? key, required this.startTime, required this.endTime}) : super(key: key);

    @override
    Widget build(BuildContext context){
      return Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Padding(
                padding : EdgeInsets.only(left: 20),
              child :  Text("이용 시간", style: titleTextStyle())), 
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              margin : const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${StringFormatFromTime(startTime)} ~ ${StringFormatFromTime(endTime)}",
                    style: subTextStyle(),),
                    Text("총 ${HourStringfromDuration(Caldatediffernce(startTime, endTime))} 시간 이용",
                    style: subTextStyle(),),
                  ],),
            ],)),
          ],));
    }
  }

class CarInfo extends StatelessWidget {
  final String carimage;
  final String carname;
  final String oiltype;
const CarInfo({ Key? key , required this.carimage ,required this.carname, required this.oiltype}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left:20), 
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("예약 및 결제 확인하기", style:TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        
          Row(
            children: [
              Image.network(
                "${carimage}",
                width: 150,
                height: 150,
              ),
              Container(
                margin : const EdgeInsets.only(left: 10),
                child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${carname}", style: titleTextStyle(),),
                  Text("${oiltype}", style: subTextStyle(),),
                ],
              ),
              ),
              
            ],
          ),
        ],)
          
    );
  }
}


class DrivingFee extends StatelessWidget {
  final String drivingfee;
const DrivingFee({ Key? key , required this.drivingfee }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("주행요금", style: titleTextStyle()), 
            Text("${drivingfee}원/km",  style: const TextStyle(fontWeight : FontWeight.w400))],
        ),
      );
  }
}

class Finalprice extends StatelessWidget {
  final String rentalFee;
  final String insuranceFee;
  const Finalprice({Key? key, required this.rentalFee, required this.insuranceFee}) : super(key: key);

  @override
  Widget build(BuildContext context){

  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20 ,0 ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text("최종 결제 내역",  style: titleTextStyle()), 
        
        ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("요금 합계", style:subTextStyle()),
              Text("${(int.parse(rentalFee) + int.parse(insuranceFee)).toString()}원", style:subTextStyle()),
            ],
          ),
          trailing: const Icon(Icons.expand_more),
          children: <Widget>[
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: Text('대여 요금', style:subTextStyle()),
              trailing: Text("${rentalFee} 원", style: subTextStyle()),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: Text('면책상품 요금', style:subTextStyle()),
              trailing: Text("${insuranceFee} 원", style:subTextStyle()),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("총 결제 금액", style: titleTextStyle().merge(TextStyle(color:ColorPalette.socarBlue))), 
        Text("${(int.parse(rentalFee) + int.parse(insuranceFee)).toString()}  원",
        style: titleTextStyle().merge(TextStyle(color:ColorPalette.socarBlue))),],),
      ],
    ),
  );
}
}

class CautionFeild extends StatelessWidget {
  const CautionFeild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("예약 전 주의 사항", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "취소 시점에 따라 취소 수수료나 패널티가 생길 수 있습니다.  반납 후에 결제해야 할 요금이 남아 있다면, 등록한 기본 결제 카드로 자동 결제됩니다.\n동승운전자는 운행 시작 전까지만 등록할 수 있습니다.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text("약관 및 이용 안내 동의",style: titleTextStyle(),),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


