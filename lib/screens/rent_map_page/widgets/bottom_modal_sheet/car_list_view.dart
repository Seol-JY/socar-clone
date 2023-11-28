import 'package:flutter/material.dart';

import 'package:socar/car_data/car_data.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/text_styles.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';

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
                        style: carNameStyle,
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
                          style: driveFeeStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "50%",
                        style: socarBlueStyle,
                      ),
                      PaddingBox(width: 10, height: 0),
                      Text(
                        "25,560원",
                        style: rentFeeStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "5,900원",
                        style: discountRentFeeStyle,
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
