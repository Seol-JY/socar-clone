import 'package:flutter/material.dart';
import 'package:socar/constants/color.dart';
import 'package:socar/screens/payment_page/utils/text_style.dart';

class InsuranceContainer extends StatefulWidget {
  final Function(String?) onOptionSelected;
  const InsuranceContainer({Key? key, required this.onOptionSelected}) : super(key: key);

  @override
  _InsuranceContainerState createState() => _InsuranceContainerState();
}

class _InsuranceContainerState extends State<InsuranceContainer> {
  String? _selectedOption;


  void changeValue(String? value) {
    setState(() {
      _selectedOption = value;
    });
    widget.onOptionSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("자기손해면책상품", style: titleTextStyle()),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child :Text(
                "운행 중 일어난 사고로 쏘카 차를 수리할 때, 회원님이 부담할 자기부담금 최고액을 고르세요.\n* 이용 기간 안에 신고한 차 손상만 차량손해면책제도를 적용 받을 수 있으니, 차가 손상됐을 땐 바로 신고하세요.",
                style: subTextStyle())),
            ],
          ),
        ),
        _buildRadioOption("자기부담금 없음", "+32,130", "32130"),
        _buildRadioOption("자기부담금 최대 5만원", "+23,450", "23450"),
        _buildRadioOption("자기부담금 최대 30만원", "+15,690", "15690"),
        _buildRadioOption("자기부담금 최대 70만원", "+12,420", "12420"),
      ],
    );
  }

  
  Widget _buildRadioOption(String title, String price, String value) {
  final bool isSelected = value == _selectedOption;

  return Container(
    margin: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Radio<String>(
            value: value,
            groupValue: _selectedOption,
            onChanged: changeValue,
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            title,
            style: isSelected
                ? subTextStyle()
                : subTextStyle().copyWith(color: _selectedOption == null ? Colors.black : ColorPalette.gray300),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            price,
            style: isSelected
                ? subTextStyle()
                : subTextStyle().copyWith(color: _selectedOption == null ? Colors.black : ColorPalette.gray300),
          ),
        ),
      ],
    ),
  );
}

}