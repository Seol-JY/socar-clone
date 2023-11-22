import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/widgets/rent_map_page/time_select_modal_utils.dart';

class TimeSelectBtn extends StatelessWidget {
  const TimeSelectBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SizedBox(
      height: 75,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: ElevatedButton(
            onPressed: () {
              TimeSelectModalUtils.showCustomModal(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 234, 234, 234),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.access_time_outlined,
                              size: 19,
                              color: ColorPalette.socarBlue,
                            ),
                          ),
                          TextSpan(
                              text: "  이용시간 설정하기",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorPalette.gray500))
                        ],
                      ),
                    ),
                    const Text("오늘 1:00 - 5:00",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.gray300)),
                  ],
                ))),
      ),
    );
  }
}
