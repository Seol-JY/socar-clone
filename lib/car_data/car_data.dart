import 'package:flutter/material.dart';
import 'package:socar/car_data/car.dart';

class CarData {
  final Car car;
  final int originFee;
  final int discountRate;

  CarData({
    required this.car,
    required this.originFee,
    required this.discountRate,
  });
}

List<CarData> dummyData = [
  CarData(car: dummyCars["지호"]!, originFee: 10000, discountRate: 10),
  CarData(car: dummyCars["민석"]!, originFee: 15000, discountRate: 20),
  CarData(car: dummyCars["진영"]!, originFee: 20000, discountRate: 30),
  CarData(car: dummyCars["지호"]!, originFee: 10000, discountRate: 10),
  CarData(car: dummyCars["민석"]!, originFee: 15000, discountRate: 20),
  CarData(car: dummyCars["진영"]!, originFee: 20000, discountRate: 30)
];
