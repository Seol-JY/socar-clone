import 'package:flutter/material.dart';
import 'package:socar/reservation_confirm_page.dart';


//Color(0xff00B8FF) 파랑
//Color(0xff374553) 회

class CompletePayment extends StatelessWidget {
  const CompletePayment({super.key});

  
  Widget buildDivider(Color dividerColor) {
    return Padding(
      padding: EdgeInsets.all(8.0), // 모든 방향에 8.0 픽셀의 마진을 줍니다.
      child: Divider(
        thickness: 4,
        height: 5,
        color: dividerColor,
      ),
    );
  }
  TextStyle whiteText(){
    return const TextStyle(color : Color(0xffFFFFFF));
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,),
      home: Scaffold(
        appBar:AppBar(
            backgroundColor: Colors.white, //appBar 투명색
            elevation: 0.0, 
            actions:  <Widget>[IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.black,
            icon: Icon(Icons.clear_outlined)),],
            //appBar 그림자 농도 설정 (값 0으로 제거)
            ),

        body : Container(
          color:Colors.white,
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center, // 수직 방향으로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
          Icon(Icons.check_circle_sharp  , color:Colors.blue, size:100),
          SizedBox(height: 20),
          Text("예약을 완료했어요!", style : TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
          SizedBox(height: 20),
          Text("쏘카 카셰어링으로 둘어드는 탄소가 연간 39만 톤, \n 지구를 아끼는 여행에 함께해주셔서 고맙습니다.", style : TextStyle(color:Colors.grey),
          textAlign: TextAlign.center,),
          SizedBox(height: 150),
        ],
        ),
        ),
        
     bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: BottomAppBar(
          color: Colors.white, // BottomAppBar의 배경색을 하얗게 설정
          elevation: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> const ReservationConfirm()),
            );},
                child: Text(
                  "내 예약 보기",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 25, 50, 25),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "홈으로 가기",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 25, 50, 25),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      ),
    );
  }
}