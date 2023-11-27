import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SocarZone {
  String id;
  NLatLng coord;
  String address;
  String spot;
  String name;
  String description;
  int serviceHours;
  String imgSrc;
  String elevationType;

  SocarZone({
    required this.id,
    required this.coord,
    required this.address,
    required this.spot,
    required this.name,
    required this.description,
    required this.serviceHours,
    required this.imgSrc,
    required this.elevationType,
  });

  // Factory 메서드를 사용하여 Firestore에서 문서 데이터를 객체로 변환
  factory SocarZone.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    GeoPoint geoPoint = data['coord'] ?? const GeoPoint(0.0, 0.0);
    print("$data");
    return SocarZone(
      id: document.id, // 추가: 문서의 아이디를 저장
      coord: NLatLng(geoPoint.latitude,
          geoPoint.longitude), // 기본값을 사용하거나 예외 처리를 추가할 수 있습니다.
      address: data['address'] ?? "",
      spot: data['spot'] ?? "",
      name: data['name'] ?? "",
      description: data['description'] ?? "",
      serviceHours: data['service_hours'] ?? 0,
      imgSrc: data['img_src'] ?? "",
      elevationType: data['elevation_type'] ?? "",
    );
  }
}
