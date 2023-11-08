import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socar/reservation_payment_page.dart';

// ignore: must_be_immutable
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
        title: "(필수) 쏘카 자동차대여약관",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 쏘카 차량손해면책제도 이용약관",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 개인정보 수집 및 이용 동의",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 개인정보 제3자 제공 동의",
      ),
      _TermAgreementWidget(
        pressCallBack: validTermsChecked,
        title: "(필수) 위치정보 이용약관",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // 배경색을 흰색으로 설정
      ),
      
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child : ExpansionTile(
        controller: _controller,
        title: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(
              const IconData(
                0xf635,
                fontFamily: 'MaterialIcons',
              ),
              color: widget.isAllTermChecked
                  ? const Color(0xff28323c)
                  : const Color(0xffc5c8ce),
            ),
            const Text(" 예약 정보 확인 및 모든 약관에 동의합니다.", style: TextStyle(fontSize: 14),)],),
          ],
        ),
        
        subtitle: Padding(padding: const EdgeInsets.only(top:5),child : Text("쏘카자동차대여약관, 쏘카 차량손해면책제도 이용약관, 개인정보 수집 및 이용동의, 개인정보 제3자 제공 동의, 위치정보 이용약관"),),
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
          Padding(padding: EdgeInsets.only(left: 10),
          child: Column(children: [const Divider(
            color: Color(0xffe9ebee),
            thickness: 1.5,
          ),
          terms[0],
          terms[1],
          terms[2],
          terms[3],
          terms[4],],),
          
          ),
          
        ],
      ),
      ),
    );
  }

  void validTermsChecked() {
    final priceInfo = Provider.of<PriceInfo>(context, listen:false);

    for (int i = 0; i < terms.length; i++) {
      if (terms[i].isTermChecked() == false) {
        setState(
          () {
            widget.isAllTermChecked = false;
            priceInfo.updateterms(false);
          },
        );
        return;
        
      }
    }
    setState(
      () {
        widget.isAllTermChecked = true;
        print("pass");
        priceInfo.updateterms(true);
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