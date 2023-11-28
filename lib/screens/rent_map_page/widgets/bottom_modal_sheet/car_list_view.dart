import 'package:flutter/material.dart';

import 'package:socar/car_data/car_data.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/text_styles.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';

class CarListView extends StatelessWidget {
  final List<CarData> carList;

  const CarListView({required this.carList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: carList.length,
          itemBuilder: (context, index) {
            CarData carData = carList[index];
            return ListTile(
              leading: Image.network(carData.imageUrl),
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        carData.name,
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
                          carData.driveFee.toString() + "원/km",
                          style: driveFeeStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        carData.discountRate.toString(),
                        style: socarBlueStyle,
                      ),
                      PaddingBox(width: 10, height: 0),
                      Text(
                        carData.rentFee.toString() + "원/km",
                        style: rentFeeStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        (carData.rentFee * (100 - carData.discountRate) / 100)
                                .toString() +
                            "원",
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
