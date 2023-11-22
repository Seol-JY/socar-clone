import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class SmartkeyBottomBar extends StatelessWidget {
const SmartkeyBottomBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        color:Colors.white,
        height: 150,
        padding:const EdgeInsets.only(bottom:30),
        child: BottomAppBar(
          color: Colors.transparent,
        elevation: 0.0,
          child:Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(margin:const EdgeInsets.all(16),
            child : const Row(children: [
              Text("스마트키", style: TextStyle(color:ColorPalette.gray600, fontWeight: FontWeight.w700)),
              Text("OFF", style: TextStyle(color:ColorPalette.gray600, fontWeight: FontWeight.w700))])),


            Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center,   children: [Expanded(flex:5, child: Center(child:
            TextButton(onPressed: (){}, child: const Text("반납하기", style: TextStyle(color:ColorPalette.gray600, fontWeight: FontWeight.w700),), 
            style: TextButton.styleFrom(backgroundColor:const Color(0xffE9EBEE) ,padding:const EdgeInsets.fromLTRB(30,20,30,20),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side : BorderSide(color:Colors.grey.withOpacity(0))),)),),
            ),
            Expanded(flex:7,child: Container(
              height: 60,
              margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              decoration: BoxDecoration(color: const Color(0xffE9EBEE), borderRadius: BorderRadius.circular(12)),
              
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton.outlined(onPressed: (){}, icon: const Icon(Icons.lock_outline),),
              IconButton.outlined(onPressed: (){}, icon: const Icon(Icons.lock_open)),],)
            ), )
            ],),),
            
          ],),
        ),
      );
  }
}