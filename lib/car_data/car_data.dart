import 'package:flutter/material.dart';

import 'package:socar/car_data/car.dart';
import 'package:socar/car_data/tag_enum.dart';

class CarData {
  final Car car;
  final List<TagEnum> tags;
  final int originFee;
  final int discountRate;

  CarData({
    required this.car,
    required this.tags,
    required this.originFee,
    required this.discountRate,
  });
}

List<CarData> dummyData = [
  CarData(
      car: dummyCars["지호"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 10000,
      discountRate: 10),
  CarData(
      car: dummyCars["민석"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 15000,
      discountRate: 20),
  CarData(
      car: dummyCars["진영"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 20000,
      discountRate: 30),
  CarData(
      car: dummyCars["지호"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 10000,
      discountRate: 10),
  CarData(
      car: dummyCars["민석"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 15000,
      discountRate: 20),
  CarData(
      car: dummyCars["진영"]!,
      tags: [TagEnum.NewCar, TagEnum.Recommand],
      originFee: 20000,
      discountRate: 30)
];
