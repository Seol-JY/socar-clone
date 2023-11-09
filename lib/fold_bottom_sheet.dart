import 'package:flutter/material.dart';

class FoldBottomSheet extends StatefulWidget {
  const FoldBottomSheet({Key? key}) : super(key: key);

  @override
  _FoldBottomSheetState createState() => _FoldBottomSheetState();
}

class _FoldBottomSheetState extends State<FoldBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isFold = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter sheetState) {
                  double screenHeight = MediaQuery.of(context).size.height;
                  double halfScreenHeight = screenHeight / 2;

                  return AnimatedContainer(
                    curve: Curves.easeInBack,
                    duration: Duration(milliseconds: 600),
                    height: isFold ? screenHeight : halfScreenHeight,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Modal BottomSheet'),
                          GestureDetector(
                            onPanUpdate: (details) {
                              sheetState(() {
                                // swipe-down
                                if (details.delta.dy > 0) {
                                  isFold = false;
                                }
                                // swipe-up
                                if (details.delta.dy < 0) {
                                  isFold = true;
                                }
                              });
                            },
                            child: Container(
                              child: Text("Move"),
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                            ),
                          ),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () {
                              Navigator.pop(context);
                              _controller.reverse();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
