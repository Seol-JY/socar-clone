import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/utils/CustomDateUtils.dart';
import 'package:socar/screens/rent_map_page/widgets/time_select_modal_utils.dart';

class TimeSelectBtn extends StatefulWidget {
  final DateTimeRange timeRange;
  final bool isChanged;
  final void Function(DateTimeRange newTimeRange) updateTimeRange;

  const TimeSelectBtn(this.timeRange, this.isChanged, this.updateTimeRange,
      {Key? key})
      : super(key: key);

  @override
  State<TimeSelectBtn> createState() => _TimeSelectBtnState();
}

class _TimeSelectBtnState extends State<TimeSelectBtn> {
  @override
  Widget build(BuildContext context) {
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
            TimeSelectModalUtils.showCustomModal(context, widget.timeRange,
                widget.isChanged, widget.updateTimeRange);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 234, 234, 234),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.access_time_outlined,
                          size: 19,
                          color: widget.isChanged
                              ? ColorPalette.gray400
                              : ColorPalette.socarBlue,
                        ),
                      ),
                      TextSpan(
                          text:
                              " ${widget.isChanged ? CustomDateUtils.dateTimeRangeFormatter(widget.timeRange) : "이용시간 설정하기"}  ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.gray500,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      CustomDateUtils.doubleDateTimeFormatter(widget.timeRange),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.gray300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
