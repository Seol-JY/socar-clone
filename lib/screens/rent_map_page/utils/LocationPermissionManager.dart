// 위치 권한 관리 클래스
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionManager {
  static Future<void> requestPermission(BuildContext context) async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;

    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      await _showPermissionDialog(context);
      openAppSettings();
    }
  }

  static Future<void> _showPermissionDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("위치 권한 필요"),
          content: const Text("설정에서 위치 권한을 허용해 주세요!"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
