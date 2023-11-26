import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socar/constants/colors.dart';
import 'dart:convert';
import 'package:socar/screens/payment_page/complete_payment_page.dart';
import 'package:socar/screens/payment_page/widgets/term_agreement.dart';
import 'utils/time_check.dart';


Future<Map<String, dynamic>> loadReservationData() async {
  String jsonString = await rootBundle.loadString('assets/cars.json');
  return json.decode(jsonString);
}

TextStyle titleTextStyle(){
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
    );
  }

TextStyle subTextStyle(){
  return TextStyle(
    fontSize: 13, 
    fontWeight : FontWeight.w400);
}



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
  
  Widget build(BuildContext context) {
    return const ReservationPayment();
  }
}

class ReservationPayment extends StatelessWidget {
const ReservationPayment({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(
            leading:  IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: ColorPalette.gray600,
            icon: const Icon(Icons.arrow_back)),
            backgroundColor: Colors.transparent, //appBar 투명색
            elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
            ),

        body : const SingleChildScrollView(child : Column(children: [
            ReservationInfo(),
          ],
        ),) ,
      bottomNavigationBar: const Bottompaybar(),
      );
  }
}



class ReservationInfo extends StatelessWidget {
  const ReservationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    String rentFee = "0";
    String tmp = "0";
    return FutureBuilder<Map<String, dynamic>>(
      future: loadReservationData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            tmp = HourStringfromDuration(Caldatediffernce(data["StartTime"], data["EndTime"]));
            //print("Calculated tmp value: $tmp");
            //print("Calculated baserate value: ${data["Baserate"]}");
            rentFee = CarFeeCal(tmp, data["Baserate"]);
            return Container(
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarInfo(carimage: data["ImageLink"], oiltype:  data["Oiltype"], carname: data["Carname"],),

                  paddingDivider(),
                  DrivingFee(drivingfee: data["Drivingfee"],),
                  
                  paddingDivider(),
                  Returnlocation(returnLocation : data["Returnlocation"]),

                  paddingDivider(),
                  Usetime(startTime : data["StartTime"] , endTime : data["EndTime"]),

                  
                  paddingDivider(),
                  const InsuranceContainer(),

                  paddingDivider(),
                  Finalprice(rentalFee: rentFee),
                  paddingDivider(),
                  const CautionFeild(),
                  TermAgreementBoxWidget(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
        }
        return const CircularProgressIndicator();
      },
    );
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
                width: 130,
                height: 130,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${carname}", style: subTextStyle(),),
                  Text("${oiltype}", style: subTextStyle(),),
                ],
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
            Text("${drivingfee}원",  style: const TextStyle(fontWeight : FontWeight.w400))],
        ),
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

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorPalette.gray400,
      child: Consumer<PriceInfo>(
         builder: (context, priceInfo, child){
        final isButtonActive = (priceInfo.insprice != "0" && priceInfo.terms == true); 
              return TextButton(
              onPressed: isButtonActive ? () {
              Navigator.pushNamed(context, '/completePayment');
            } : null, 
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(70, 30, 70, 30),
                backgroundColor: isButtonActive ? ColorPalette.socarBlue : ColorPalette.gray300,
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
         },
        )
      
    );
  }
}



class PriceInfo with ChangeNotifier{
  String _insprice = "0";
  bool _terms = false;

  String get insprice => _insprice;
  bool get terms => _terms;

  void updateInsPrice(String newPrice){
    _insprice = newPrice;
    notifyListeners();
  }

  void updateterms(bool newstate){
    _terms = newstate;
    notifyListeners();
  }
}

class Finalprice extends StatelessWidget {
  final String rentalFee;
  const Finalprice({Key? key, required this.rentalFee}) : super(key: key);

  @override
  Widget build(BuildContext context){
  final priceInfo = Provider.of<PriceInfo>(context);

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
              Text("${(int.parse(rentalFee)+ int.parse(priceInfo.insprice)).toString()}원", style:subTextStyle()),
            ],
          ),
          trailing: const Icon(Icons.expand_more),
          children: <Widget>[
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: Text('대여 요금', style:subTextStyle()),
              trailing: Text("${rentalFee}원", style: subTextStyle()),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: Text('면책상품 요금', style:subTextStyle()),
              trailing: Text("${priceInfo.insprice}원", style:subTextStyle()),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("총 결제 금액", style: titleTextStyle().merge(TextStyle(color:ColorPalette.socarBlue))), 
        Text("${(int.parse(rentalFee)+ int.parse(priceInfo.insprice)).toString()}  원",
        style: titleTextStyle().merge(TextStyle(color:ColorPalette.socarBlue))),],),
      ],
    ),
  );
}


}

class InsuranceContainer extends StatefulWidget {
  const InsuranceContainer({Key? key}) : super(key: key);

  @override
  _InsuranceContainerState createState() => _InsuranceContainerState();
}

class _InsuranceContainerState extends State<InsuranceContainer> {
  String? _selectedOption;

   void _handleRadioValueChange(String? value){
    setState(() {
      _selectedOption = value;
      Provider.of<PriceInfo>(context, listen:false).updateInsPrice(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("자기손해면책상품", style: titleTextStyle()),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child :Text(
                  "운행 중 일어난 사고로 쏘카 차를 수리할 때, 회원님이 부담할 자기부담금 최고액을 고르세요.\n* 이용 기간 안에 신고한 차 손상만 차량손해면책제도를 적용 받을 수 있으니, 차가 손상됐을 땐 바로 신고하세요.",
                  style: subTextStyle())),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildRadioOption("자기부담금 없음", "+32,130", "32130"),
          _buildRadioOption("자기부담금 최대 5만원", "+23,450", "23450"),
          _buildRadioOption("자기부담금 최대 30만원", "+15,690", "15690"),
          _buildRadioOption("자기부담금 최대 70만원", "+12,420", "12420"),
        ],
      ),
    );
  }

  
  Widget _buildRadioOption(String title, String price, String value) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Radio<String>(
              value: value,
              groupValue: _selectedOption,
              onChanged: _handleRadioValueChange,
            ),
          ),
          Expanded(flex: 7, child: Text(title, style: subTextStyle())),
          Expanded(flex: 2, child: Text(price, style: subTextStyle())),
        ],
      ),
    );
  }
}


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
          TitleText("약관 및 이용 안내 동의"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


Widget TitleText(String titleText){
    return Padding(
      padding : const EdgeInsets.only(left: 20),
      child :  Text("$titleText",
       style: const TextStyle(
        fontSize: 13, 
        fontWeight: FontWeight.w400)));
}