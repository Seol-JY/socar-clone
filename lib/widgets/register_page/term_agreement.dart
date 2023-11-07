import 'package:flutter/material.dart';

class TermAgreementBoxWidget extends StatefulWidget {
  bool isAllTermChecked = false;
  TermAgreementBoxWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TermAgreementBoxState();
  }
}

class _TermAgreementBoxState extends State<TermAgreementBoxWidget> {
  final ExpansionTileController _controller = ExpansionTileController();

  late List<_TermAgreementWidget> terms;

  @override
  void initState() {
    terms = [
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 개인정보 수집 및 이용 동의",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 고유식별정보 처리",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 서비스 이용 약관",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 통신사 이용 약관",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 개인정보 제3자 제공 동의",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // 배경색을 흰색으로 설정
        border: Border.all(
          color: const Color(0xffe9ebee),
        ),
      ),
      child: ExpansionTile(
        controller: _controller,
        title: Row(
          children: [
            Icon(
              const IconData(
                0xf635,
                fontFamily: 'MaterialIcons',
              ),
              color: widget.isAllTermChecked
                  ? const Color(0xff28323c)
                  : const Color(0xffc5c8ce),
            ),
            const Text(
              " 본인확인 서비스 이용약관 전체 동의",
              style: TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
        onExpansionChanged: (value) {
          setState(() {
            widget.isAllTermChecked = !value;
            for (int i = 0; i < terms.length; i++) {
              terms[i].isChecked = !value;
            }
          });
        },
        initiallyExpanded: true,
        children: [
          const Divider(
            color: Color(0xffe9ebee),
            thickness: 1.5,
          ),
          terms[0],
          terms[1],
          terms[2],
          terms[3],
          terms[4],
        ],
      ),
    );
  }

  void validTermsChecked() {
    for (int i = 0; i < terms.length; i++) {
      if (terms[i].isTermChecked() == false) {
        setState(
          () {
            widget.isAllTermChecked = false;
          },
        );
        return;
      }
    }
    setState(
      () {
        widget.isAllTermChecked = true;
        _controller.collapse();
      },
    );
  }
}

class _TermAgreementWidget extends StatefulWidget {
  final void Function() pressCallBack;
  final String title;
  bool isChecked = false;

  _TermAgreementWidget({
    required this.pressCallBack,
    required this.title,
  });

  @override
  State<_TermAgreementWidget> createState() {
    // ignore: no_logic_in_create_state
    return _TermAgreementWidgetState();
  }

  bool isTermChecked() {
    return isChecked;
  }
}

class _TermAgreementWidgetState extends State<_TermAgreementWidget> {
  _TermAgreementWidgetState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        children: [
          IconButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ), // 패딩 설정
            constraints: const BoxConstraints(), // constraints
            icon: Icon(
              const IconData(
                0xe156,
                fontFamily: 'MaterialIcons',
              ),
              color: widget.isChecked
                  ? const Color(0xff28323c)
                  : const Color(0xffc5c8ce),
            ),
            onPressed: () {
              setState(() {
                widget.isChecked = !widget.isChecked;
                widget.pressCallBack();
              });
            },
          ),
          Text(
            widget.title,
          )
        ],
      ),
    );
  }
}
