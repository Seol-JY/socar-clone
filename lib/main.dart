import 'package:flutter/material.dart';

import 'package:socar/bottom_modal_sheet/fold_bottom_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FoldBottomSheet(),
      ),
    );
  }
}
