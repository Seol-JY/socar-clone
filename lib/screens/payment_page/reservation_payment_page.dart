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
            color: Colors.black,
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
                  const Padding(padding: EdgeInsets.only(left:20), 
                  child: Text("예약 및 결제 확인하기", style:TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),),
                  
                  Row(
                    children: [
                      Image.network(
                        data["ImageLink"],
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        children: [
                          Text(data["Carname"]),
                          Text(data["Oiltype"]),
                        ],
                      ),
                    ],
                  ),
                  paddingDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("주행요금", style: TextStyle(fontWeight : FontWeight.w500)), 
                        Text("${data["Drivingfee"]}원",  style: const TextStyle(fontWeight : FontWeight.w400))],
                    ),
                  ),
                  
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




class Bottompaybar extends StatefulWidget {
const Bottompaybar({ Key? key }) : super(key: key);

  @override
  State<Bottompaybar> createState() => _BottompaybarState();
}

class _BottompaybarState extends State<Bottompaybar> {
  @override
  Widget build(BuildContext context){
    return BottomAppBar(
          color: const Color(0xffE9EBEE),
          child: Consumer<PriceInfo>(
            builder: (context, priceInfo, child){
              final isButtonActive = (priceInfo.insprice != "0" && priceInfo.terms == true); 
              return TextButton(
                onPressed: (){
                    Navigator.pushNamed(context, '/completePayment');
                    },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(70, 30, 70, 30),
              backgroundColor: isButtonActive ? const Color(0xff00B8FF) : const Color(0xffC5C8CE), // 버튼 활성화 상태에 따라 배경색을 변경합니다.
             
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // 필요한 경우 여기에 BorderRadius 값을 조정합니다.
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
          ),
            
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
        const Text("최종 결제 내역",  style: TextStyle(fontWeight : FontWeight.w700)), 
        
        ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("요금 합계", style:TextStyle(fontSize: 13 ,fontWeight : FontWeight.w500)),
              Text("${(int.parse(rentalFee)+ int.parse(priceInfo.insprice)).toString()}원"),
            ],
          ),
          trailing: const Icon(Icons.expand_more),
          children: <Widget>[
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: const Text('대여 요금', style:TextStyle(fontSize: 13, fontWeight : FontWeight.w500)),
              trailing: Text("${rentalFee}원", style: const TextStyle(fontWeight : FontWeight.w400)),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: const Text('면책상품 요금', style:TextStyle(fontSize: 13)),
              trailing: Text("${priceInfo.insprice}원"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("총 결제 금액", style: TextStyle(fontWeight:FontWeight.w700, fontSize: 15 ),), 
        Text("${(int.parse(rentalFee)+ int.parse(priceInfo.insprice)).toString()}  원",style: const TextStyle(fontWeight:FontWeight.bold, fontSize: 15 , color: Color(0xff00B8FF)),)],),
      ],
    ),
  );
}


}

class InsuranceContainer extends StatefulWidget {
  const InsuranceContainer({Key? key}) : super(key: key);

  @override
  State<InsuranceContainer> createState() => _InsuranceContainerState();
}


class _InsuranceContainerState extends State<InsuranceContainer> {
  // 현재 선택된 값을 저장하는 변수
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
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("자기손해면책상품", style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            margin : const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(children: [const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text("운행 중 일어난 사고로 쏘카 차를 수리할 때, 회원님이 부담할 자기부담금 최고액을 고르세요.\n*이용 기간 안에 신고한 차 손상만 차량손해면책제도를 적용 받을 수 있으니, 차가 손상됐을 땐 바로 신고하세요.", style:TextStyle(fontWeight: FontWeight.w400))),
            ],
          ),
          _buildRadioOption("자기부담금 없음", "+32,130", "32130"),
          _buildRadioOption("자기부담금 최대 5만원", "+23,450", "23450"),
          _buildRadioOption("자기부담금 최대 30만원", "+15,690", "15690"),
          _buildRadioOption("자기부담금 최대 70만원", "+12,420", "12420"),
        ],),
            
            ),],
        
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
          Expanded(flex: 7, child: Text(title, style: const TextStyle(fontWeight : FontWeight.w400))),
          Expanded(flex: 2, child: Text(price, style: const TextStyle(fontWeight : FontWeight.w400))),
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
            children:[const Padding(padding : EdgeInsets.only(left: 20),
            child :  Text("대여 반납 장소 공간", style: TextStyle(fontWeight : FontWeight.w500))), 
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            margin : const EdgeInsets.fromLTRB(20, 10, 20, 5),
            color : Colors.lightBlue.withOpacity(0.3),
            child :Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("$returnLocation")
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
            children:[const Padding(padding : EdgeInsets.only(left: 20),
            child :  Text("이용 시간", style: TextStyle(fontWeight : FontWeight.w700))), 
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            margin : const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("총 ${HourStringfromDuration(Caldatediffernce(startTime, endTime))} 시간 이용"),
                Text("${StringFormatFromTime(startTime)} ~ ${StringFormatFromTime(endTime)}")],),
          ],)),
        ],));
    }
  }
  

class CautionFeild extends StatelessWidget {
const CautionFeild({ Key? key }) : super(key: key);

    @override
  Widget build(BuildContext context){
    return Container(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[const Padding(padding : EdgeInsets.only(left: 20),
          child :  Text("예약 전 주의 사항", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))), 
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          margin : const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child :const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Flexible(child :Text("취소 시점에 따라 취소 수수료나 패널티가 생길 수 있습니다.  반납 후에 결제해야 할 요금이 남아 있다면, 등록한 기본 결제 카드로 자동 결제됩니다.\n동승운전자는 운행 시작 전까지만 등록할 수 있습니다.", style: TextStyle(fontWeight : FontWeight.w400))),],),
        ),
        
        const SizedBox(height: 10),
        TitleText("약관 및 이용 안내 동의"),
        const SizedBox(height: 10),
      ],));
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