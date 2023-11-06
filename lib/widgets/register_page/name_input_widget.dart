import 'package:flutter/material.dart';

class NameInputWidget extends StatefulWidget {
  const NameInputWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NameInputState();
  }
}

class _NameInputState extends State<NameInputWidget> {
  String selectedDropdown = '내국인';
  List<String> dropdownList = ["내국인", "외국인"];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<String>(
            value: selectedDropdown, // 현재 선택된 값
            onChanged: (String? newValue) {
              setState(() {
                selectedDropdown = newValue ?? 'Option 1';
              });
            },
            items: dropdownList.map<DropdownMenuItem<String>>((String value) {
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
        const SizedBox(
          width: 5,
        ),
        const Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: InputBorder.none,
                hintText: '본인 실명(통신사 가입 이름)', // placeholder 텍스트
                hintStyle: TextStyle(color: Colors.grey), // placeholder 텍스트 스타일
              ),
            ))
      ],
    );
  }
}
