import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropDownTextFieldInRowWidget extends StatefulWidget {
  String selectedDropdown;
  List<String> dropdownList;
  String? helperText;
  TextInputFormatter? inputFormatter;
  TextInputType? textInputType;

  DropDownTextFieldInRowWidget(
      {Key? key,
      required this.selectedDropdown,
      required this.dropdownList,
      this.inputFormatter,
      this.textInputType,
      this.helperText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropDownTextFieldInRowState();
  }
}

class _DropDownTextFieldInRowState extends State<DropDownTextFieldInRowWidget> {
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> formatters = [];

    if (widget.inputFormatter != null) {
      formatters.add(widget.inputFormatter!);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // 배경색을 흰색으로 설정
        border: Border.all(
          color: const Color(0xffe9ebee),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<String>(
              value: widget.selectedDropdown, // 현재 선택된 값
              onChanged: (String? newValue) {
                setState(() {
                  widget.selectedDropdown = newValue ?? '내국인';
                });
              },
              items: widget.dropdownList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: TextField(
                inputFormatters: formatters,
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: InputBorder.none,
                  hintText: widget.helperText, // placeholder 텍스트
                  hintStyle: const TextStyle(
                      color: Colors.grey), // placeholder 텍스트 스타일
                ),
              ))
        ],
      ),
    );
  }
}
