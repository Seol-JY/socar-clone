import 'package:flutter/material.dart';

class ParkBottonSheet extends StatelessWidget {
  const ParkBottonSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double halfScreenHeight = screenHeight / 2;

    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Container(
                height: halfScreenHeight,
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.exit_to_app),
                    )
                  ]),
                  Row(
                    children: [
                      Column(children: [Text("옥산유료주차장"), Text("인동서한이다음아파트 옆")]),
                      Image(
                        image: AssetImage('assets/images/park.jpg'),
                        height: 10,
                        width: 10,
                      )
                    ],
                  ),
                  Text("경북 구미시 인의동 576-1 구미지게차 주차장"),
                  Text("지상 1층"),
                  Text("24시간")
                ]),
              );
            },
          );
        },
      ),
    );
  }
}
