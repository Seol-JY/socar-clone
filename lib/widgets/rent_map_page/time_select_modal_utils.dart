import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class TimeSelectModalUtils {
  static void showCustomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TimeSelectModal();
      },
    );
  }
}

class TimeSelectModal extends StatefulWidget {
  @override
  _TimeSelectModalState createState() => _TimeSelectModalState();
}

class _TimeSelectModalState extends State<TimeSelectModal> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.93,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: ColorPalette.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 26,
                    color: ColorPalette.gray500,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "이용시간 설정하기",
                      style: TextStyle(
                        color: ColorPalette.gray600,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "오늘 2:00 - 5:00",
                      style: TextStyle(
                        color: ColorPalette.gray400,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      height: 14,
                      thickness: 0.8,
                      color: ColorPalette.gray200,
                    ),
                    // _buildExpansionTile(0, "대여 시각"),
                    ExpansionPanelList.radio(
                      elevation: 0,
                      dividerColor: ColorPalette.gray200,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      children: [
                        ExpansionPanelRadio(
                          value: 0,
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                "대여 시각",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorPalette.gray500,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("오늘 13:00"),
                            );
                          },
                          body: Container(
                              child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (DateTime newdate) {
                                    print(newdate);
                                  },
                                  minuteInterval: 10,
                                  minimumDate: DateTime.now().add(
                                    Duration(
                                        minutes:
                                            10 - DateTime.now().minute % 10),
                                  ),
                                  initialDateTime: DateTime.now().add(
                                    Duration(
                                        minutes:
                                            10 - DateTime.now().minute % 10),
                                  ),
                                  showDayOfWeek: true,
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                ),
                              ),
                              Divider(
                                height: 14,
                                thickness: 0.8,
                                color: ColorPalette.gray200,
                              ),
                            ],
                          )),
                        ),
                        ExpansionPanelRadio(
                          value: 1,
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                "반납 시각",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorPalette.gray500,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("오늘 13:00"),
                            );
                          },
                          body: Container(
                              child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (DateTime newdate) {
                                    print(newdate);
                                  },
                                  minuteInterval: 10,
                                  minimumDate: DateTime.now().add(
                                    Duration(
                                        minutes:
                                            10 - DateTime.now().minute % 10),
                                  ),
                                  initialDateTime: DateTime.now().add(
                                    Duration(
                                        minutes:
                                            10 - DateTime.now().minute % 10),
                                  ),
                                  showDayOfWeek: true,
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                ),
                              ),
                              Divider(
                                height: 14,
                                thickness: 0.8,
                                color: ColorPalette.gray200,
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),

                    // _buildExpansionTile(1, "반납 시각"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: ColorPalette.socarBlue,
                height: 56,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: ColorPalette.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
