import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarData {
  final int rentFee;
  final int driveFee;
  final int discountRate;
  final String imageUrl;
  final String name;

  CarData({
    required this.rentFee,
    required this.discountRate,
    required this.imageUrl,
    required this.name,
    required this.driveFee,
  });
}

Future<List<CarData>> getCarDataBySocarZoneId(String documentId) async {
  List<CarData> result = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = firestore.collection('socar_zone');
  DocumentReference documentReference = collectionReference.doc(documentId);
  CollectionReference subCollectionReference =
      documentReference.collection('cars');

  try {
    QuerySnapshot subCollectionSnapShot = await subCollectionReference.get();

    for (QueryDocumentSnapshot documentSnapshot in subCollectionSnapShot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      DocumentSnapshot carDocument =
          await (data['car'] as DocumentReference).get();

      Map<String, dynamic> carData = carDocument.data() as Map<String, dynamic>;

      result.add(CarData(
          rentFee: carData['rent_fee'],
          discountRate: 10,
          imageUrl: carData['url'],
          name: carData['name'],
          driveFee: carData['drive_km_fee']));
    }
  } catch (e) {
    print('Error getting document: $e');
  }
  print(result);
  return result;
}
