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
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownMenu<String>(
          initialSelection: widget.dropdownList.first,
          onSelected: (String? value) {
            setState(() {
              widget.selectedDropdown = value!;
            });
          },
          dropdownMenuEntries: widget.dropdownList
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
