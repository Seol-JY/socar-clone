import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/smart_key_page/widgets/smartkey_bottom_bar.dart';


//Color(0xff00B8FF) 파랑
//Color(0xff374553) 회

class ReservationConfirm extends StatelessWidget {
  const ReservationConfirm({super.key});

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


  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xff28323C),
      
        appBar:AppBar(
            backgroundColor: Colors.transparent, //appBar 투명색
            elevation: 0.0, 
            leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.white,
            icon: Icon(Icons.menu)),
            //appBar 그림자 농도 설정 (값 0으로 제거)
            ),

        body : SingleChildScrollView(child : Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 방향으로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
            Image.network("https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_7%2F20220308115005215_IDAC9KDM0.png%2F20220308104410_3.png%3Ftype%3Dm1500",
          width:100, height:100),
          Text("더뉴아반떼CN7", style : TextStyle(color: ColorPalette.white ,fontSize: 20,fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
          Container(margin:EdgeInsets.only(bottom: 30), 
          child: Text("차량 준비 중 | 휘발유", textAlign: TextAlign.center, style: TextStyle(color:ColorPalette.white, fontWeight: FontWeight.w500)))
          ,


          Container(margin:EdgeInsets.fromLTRB(10, 0, 10, 0), child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("내일 10:30 부터", 
            style: TextStyle(color:ColorPalette.socarBlue),),
           Text("8/30(월) 00:00", 
           style: TextStyle(color:ColorPalette.socarBlue))],),),
          

          buildDivider(ColorPalette.socarBlue),
          
          Container(margin:EdgeInsets.fromLTRB(10, 0, 10, 0), child: Text("예약이 완료되었습니다.", style: TextStyle(color:ColorPalette.white)),),
          
          Container(decoration: BoxDecoration(color: ColorPalette.socarBlue, borderRadius: BorderRadius.circular(7.0)),margin:EdgeInsets.fromLTRB(7, 10, 7, 0),width:200, height:80, 
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [Text("대여장소", style: TextStyle(color:ColorPalette.white)), Text("         위치", style: TextStyle(color:ColorPalette.white))],)),

          SizedBox(height: 5),

          Container(decoration: BoxDecoration(color: ColorPalette.gray500, borderRadius: BorderRadius.circular(7.0)), margin:EdgeInsets.fromLTRB(7, 0, 7, 0), width:200, height:100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Text("챠량확인", style: TextStyle(color:ColorPalette.gray200)), Text("         이용안내보기", style: TextStyle(color: ColorPalette.gray200)), IconButton(onPressed: (){}, icon : Icon(Icons.navigate_next_outlined), color:ColorPalette.white)],)),

          SizedBox(height: 5),
          Container(decoration: BoxDecoration(color: ColorPalette.gray500, borderRadius: BorderRadius.circular(7.0)), margin:EdgeInsets.fromLTRB(7, 0, 7, 0), width:200, height:80, 
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [Text("쏘카 이용방법이 궁금하다면?", style: TextStyle(color:ColorPalette.gray200)),  IconButton(onPressed: (){}, icon : Icon(Icons.navigate_next_outlined), color:ColorPalette.gray200)],)),

          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [Icon(Icons.watch_later, color:ColorPalette.gray200), Text("  대여 시각 8/29 (일) 10:30", style: TextStyle(color:ColorPalette.gray200))],))
          ],),
        ),),
        
      bottomNavigationBar: SmartkeyBottomBar(),
      
      );
    
  }
}