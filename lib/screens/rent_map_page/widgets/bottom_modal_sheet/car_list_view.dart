import 'package:flutter/material.dart';

import 'package:socar/car_data/car_data.dart';
import 'package:socar/constants/color.dart';

class CarListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: dummyData.length,
          itemBuilder: (context, index) {
            CarData carData = dummyData[index];
            return ListTile(
              leading: carData.car.image,
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        carData.car.modelName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.all(10),
                        child: Text(
                          carData.car.driveFee.toString() + "원/km",
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "50%",
                        style: TextStyle(
                          color: ColorPalette.socarBlue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "25,560원",
                        style: TextStyle(
                            color: ColorPalette.gray400,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "5,900원",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/reservationPayment");
                          },
                          icon: Icon(Icons.next_plan))
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}
