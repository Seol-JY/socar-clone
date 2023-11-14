import 'package:flutter/material.dart';

export 'package:socar/car_data/car.dart' show dummyCars;

class Car {
  final Image image;
  final String modelName;
  final int driveFee;

  Car({
    required this.image,
    required this.modelName,
    required this.driveFee,
  });
}

Map<String, Car> dummyCars = {
  "지호": Car(
      image: Image.asset("images/rio.png"), modelName: "리오", driveFee: 10000),
  "민석": Car(
      image: Image.asset("images/sportage.png"),
      modelName: "스포티지",
      driveFee: 11000),
  "진영": Car(
      image: Image.asset("images/bongo.png"), modelName: "봉고", driveFee: 12000),
};
