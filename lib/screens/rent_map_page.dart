import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class RentMapPage extends StatelessWidget {
  const RentMapPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(),
          onMapReady: (controller) {
            print("네이버 맵 로딩됨!");
          },
        ),
      ),
    );
  }
}
