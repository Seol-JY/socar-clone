import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/models/socar_zone.dart';
import 'package:socar/screens/rent_map_page/utils/LocationPermissionManager.dart';
import 'package:socar/widgets/nav_drawer.dart';
import 'package:socar/screens/rent_map_page/widgets/rent_app_bar.dart';
import 'package:socar/screens/rent_map_page/widgets/time_select_btn.dart';

import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/animated_bottom_modalsheet.dart';

import 'package:socar/constants/fold_state_enum.dart';

class RentMapPage extends StatefulWidget {
  const RentMapPage({super.key});

  @override
  State<RentMapPage> createState() => _RentMapPageState();
}

class _RentMapPageState extends State<RentMapPage>
    with SingleTickerProviderStateMixin {
  NaverMapController? mapController;
  Set<NMarker> _nMarkers = {};

  late AnimationController _animationController;
  int foldState = FoldState.Fold.idx;

  void fold(bool isFold) {
    if (isFold) {
      foldState -= 1;
    }

    if (foldState == FoldState.None.idx) {
      foldState = FoldState.Fold.idx;
      Navigator.pop(context);
      _animationController.reverse();
    }

    if (!isFold) {
      if (foldState < FoldState.Unfold.idx) {
        foldState += 1;
      }
    }
  }

  int getFoldState() {
    return foldState;
  }

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
    });
    setState(() {
      isChanged = true;
    });
  }

  // 마커 정보 리스트
  late List<SocarZone> socarZones = [];

  // 마커 선택 관리
  String _markerId = "";
  void _setMarkerId(String markerId) {
    setState(() {
      _markerId = markerId;
    });

    for (var nMarker in _nMarkers) {
      print(nMarker);
      nMarker.setIcon(_getMarkerIcon(nMarker.info.id));
    }

    focusMarkerPosition(markerId);

    if (_markerId != "") {
      showModalBottomSheet<void>(
        barrierColor: Color.fromARGB(8, 0, 0, 0),
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter sheetState) {
              double screenHeight = MediaQuery.of(context).size.height;
              double halfScreenHeight = screenHeight / 2;

              return AnimatedBottomModalSheet(
                sheetState: sheetState,
                fold: fold,
                getFoldState: getFoldState,
                screenHeight: screenHeight,
                halfScreenHeight: halfScreenHeight,
              );
            },
          );
        },
      ).then((value) {
        _setMarkerId("");
      });
    } else {
      foldState = FoldState.None as int;
    }
  }

  void _permission() async {
    await LocationPermissionManager.requestPermission(context);
  }

  // 실 마커 객체 초기화 함수
  Set<NMarker> _initMarker() {
    Set<NMarker> nMarkers = {};

    for (var markerInfo in socarZones) {
      final marker = _createMarker(markerInfo);
      nMarkers.add(marker);
    }

    return nMarkers;
  }

  NMarker _createMarker(SocarZone socarZone) {
    final marker = NMarker(
      id: socarZone.id,
      position: socarZone.coord,
      icon: _getMarkerIcon(socarZone.id),
    );

    marker.setOnTapListener((NMarker marker) {
      _setMarkerId(marker.info.id);
    });

    return marker;
  }

  NOverlayImage _getMarkerIcon(String markerId) {
    return NOverlayImage.fromAssetImage(
      _markerId == markerId
          ? "assets/images/pinzoneEnabled.png"
          : "assets/images/pinzoneDisabled.png",
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _permission();
  }

  Future<List<SocarZone>> _getSocarZones() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRef = db.collection("socar_zone");

    try {
      QuerySnapshot querySnapshot = await collectionRef.get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      return documents.map((document) {
        return SocarZone.fromFirestore(document);
      }).toList();
    } catch (e) {
      print("Error getting documents: $e");
      rethrow;
    }
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
                _setMarkerId("");
              },
              onMapReady: (controller) async {
                _getSocarZones().then((data) => setState(() {
                      socarZones = data;
                      _nMarkers = _initMarker();
                      // 지도에 마커 렌더링
                      mapController?.addOverlayAll(_nMarkers);
                    }));

                // 지도 컨트롤러 설정
                mapController = controller;
                mapController
                    ?.setLocationTrackingMode(NLocationTrackingMode.noFollow);
                // 현재 위치로 이동 (위치 권한 확인)
                moveCurrentPosition(init: true);
              },
            ),
            Positioned(
              bottom: (_markerId != "") ? null : 0,
              top: (_markerId != "") ? 0 : null,
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
            NCameraUpdate.withParams(zoom: 15, target: nMarker.position);

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
