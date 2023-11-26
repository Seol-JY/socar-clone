import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/screens/rent_map_page/utils/LocationPermissionManager.dart';
import 'package:socar/widgets/nav_drawer.dart';
import 'package:socar/screens/rent_map_page/widgets/rent_app_bar.dart';
import 'package:socar/screens/rent_map_page/widgets/time_select_btn.dart';
import 'package:socar/constants/fold_state_enum.dart';

class MarkerInfo {
  final String id;
  final NLatLng position;

  MarkerInfo({required this.id, required this.position});
}

class RentMapPage extends StatefulWidget {
  const RentMapPage({super.key});

  @override
  State<RentMapPage> createState() => _RentMapPageState();
}

class _RentMapPageState extends State<RentMapPage> {
  NaverMapController? mapController;
  Set<NMarker> _nMarkers = {};

  late DateTimeRange timeRange = new DateTimeRange(
    start: DateTime.now()
        .add(Duration(minutes: 20))
        .subtract(Duration(minutes: DateTime.now().minute % 10)),
    end: DateTime.now()
        .add(Duration(minutes: 20))
        .subtract(Duration(minutes: DateTime.now().minute % 10))
        .add(Duration(hours: 4)),
  );

  // 시간이 초깃값과 다른지 확인하기 위한 용도
  bool isChanged = false;

  void updateTimeRange(DateTimeRange newTimeRange) {
    setState(() {
      timeRange = newTimeRange;
      isChanged = true;
    });
  }

  // 마커 정보 리스트
  List<MarkerInfo> markers = [
    MarkerInfo(id: '1', position: const NLatLng(36.138909, 128.397019)),
    MarkerInfo(id: '2', position: const NLatLng(37.138909, 128.397019)),
    MarkerInfo(id: '3', position: const NLatLng(36.144176, 128.392375)),
    // Add more markers as needed
  ];

  // 마커 선택 관리
  int _markerId = -1;
  void _setMarkerId(String markerId) {
    setState(() {
      _markerId = int.parse(markerId);
    });

    for (var nMarker in _nMarkers) {
      nMarker.setIcon(_getMarkerIcon(nMarker.info.id));
    }

    focusMarkerPosition(markerId);
  }

  void _permission() async {
    await LocationPermissionManager.requestPermission(context);
  }

  // 실 마커 객체 초기화 함수
  Set<NMarker> _initMarker() {
    Set<NMarker> nMarkers = {};

    for (var markerInfo in markers) {
      final marker = _createMarker(markerInfo);
      nMarkers.add(marker);
    }

    return nMarkers;
  }

  NMarker _createMarker(MarkerInfo markerInfo) {
    final marker = NMarker(
      id: markerInfo.id,
      position: markerInfo.position,
      icon: _getMarkerIcon(markerInfo.id),
    );

    marker.setOnTapListener((NMarker marker) {
      _setMarkerId(marker.info.id);
    });

    return marker;
  }

  NOverlayImage _getMarkerIcon(String markerId) {
    return NOverlayImage.fromAssetImage(
      _markerId == int.parse(markerId)
          ? "assets/images/pinzoneEnabled.png"
          : "assets/images/pinzoneDisabled.png",
    );
  }

  @override
  void initState() {
    super.initState();

    _nMarkers = _initMarker();
    _permission();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorPalette.white,
          elevation: 2,
        ),
      ),
      child: Scaffold(
        endDrawer: const NavDrawer(),
        appBar: RentAppBar(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: FloatingActionButton.small(
            onPressed: () async {
              // 위치 버튼 클릭 시
              _permission();
              await moveCurrentPosition();
            },
            child: const Icon(
              Icons.my_location,
              color: ColorPalette.gray600,
              size: 18,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Stack(
          children: [
            NaverMap(
              options: const NaverMapViewOptions(
                rotationGesturesEnable: false,
                contentPadding: EdgeInsets.only(bottom: 60),
                scaleBarEnable: false,
              ),
              onMapTapped: (NPoint point, NLatLng latLng) {
                // 맵 클릭 시 상태 초기화
                _setMarkerId("-1");
              },
              onMapReady: (controller) async {
                // 지도 컨트롤러 설정
                mapController = controller;
                // 지도에 마커 렌더링
                mapController?.addOverlayAll(_nMarkers);
                mapController
                    ?.setLocationTrackingMode(NLocationTrackingMode.noFollow);
                // 현재 위치로 이동 (위치 권한 확인)
                moveCurrentPosition(init: true);
              },
            ),
            Positioned(
              bottom: (_markerId != -1) ? null : 0,
              top: (_markerId != -1) ? 0 : null,
              left: 0,
              right: 0,
              child: TimeSelectBtn(timeRange, isChanged, updateTimeRange),
            )
          ],
        ),
      ),
    );
  }

  Future<void> moveCurrentPosition({bool init = false}) async {
    // 현재 위치로 이동하는 함수
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    NCameraUpdate nCameraUpdate = NCameraUpdate.withParams(
        target: NLatLng(position.latitude, position.longitude));
    if (init) {
      nCameraUpdate.setAnimation(
          animation: NCameraAnimation.none, duration: Duration(seconds: 0));
    }
    mapController?.updateCamera(nCameraUpdate);
  }

  Future<void> focusMarkerPosition(String markerId) async {
    for (var nMarker in _nMarkers) {
      if (nMarker.info.id == markerId) {
        NCameraUpdate nCameraUpdate =
            NCameraUpdate.withParams(zoom: 16, target: nMarker.position);

        nCameraUpdate.setPivot(const NPoint(1 / 2, 1 / 3));
        mapController?.updateCamera(nCameraUpdate);
        return;
      }

      // focus out의 경우
      NCameraUpdate nCameraUpdate = NCameraUpdate.withParams(zoom: 14);
      nCameraUpdate.setPivot(const NPoint(1 / 2, 3 / 5));
      mapController?.updateCamera(nCameraUpdate);
    }
  }
}
