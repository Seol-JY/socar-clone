import 'package:flutter/material.dart';
import '../constants/fold_state_enum.dart';
import 'animated_bottom_modalsheet.dart';

class FoldBottomSheet extends StatefulWidget {
  const FoldBottomSheet({Key? key}) : super(key: key);

  @override
  _FoldBottomSheetState createState() => _FoldBottomSheetState();
}

class _FoldBottomSheetState extends State<FoldBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int foldState = FoldState.Fold.idx;

  void fold(bool isFold) {
    if (isFold) {
      foldState -= 1;

      if (foldState == FoldState.None.idx) {
        foldState = FoldState.Fold.idx;
        Navigator.pop(context);
        _controller.reverse();
      }
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
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
          );
        },
      ),
    );
  }
}
