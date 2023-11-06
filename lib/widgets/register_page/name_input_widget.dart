import 'package:flutter/material.dart';

class NameInputWidget extends StatefulWidget {
  NameInputWidget({super.key});

  List<String> dropdownList = ["내국인", "외국인"];
  String selectedDropdown = '내국인';

  @override
  State<StatefulWidget> createState() {
    return _NameInputState();
  }
}

class _NameInputState extends State<NameInputWidget> {
  final GlobalKey _dropdownKey = GlobalKey();
  double _textFieldHeight = 0.0; // TextField의 높이를 저장할 변수

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // DropdownMenu의 크기를 가져와 TextField의 높이로 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _dropdownKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _textFieldHeight = renderBox.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu<String>(
          key: _dropdownKey, // DropdownMenu의 GlobalKey 설정
          initialSelection: widget.selectedDropdown,
          onSelected: (dynamic value) {
            setState(() {
              widget.selectedDropdown = value;
            });
          },
          dropdownMenuEntries: widget.dropdownList
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ), // DropdownMenu와 TextField 사이 여백 설정
        Expanded(
          child: Container(
            height: _textFieldHeight, // DropdownMenu와 동일한 높이로 설정
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // 테두리 스타일 설정
              borderRadius: BorderRadius.circular(5.0), // 모양 설정
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "본인 이름(통신사 가입 이름)",
                border: InputBorder.none, // TextField의 기본 Border 제거
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
