import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class RealMyHome extends StatelessWidget {
  const RealMyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {//메인페이지 구성 : 카루셀 + 공지사항 + 이달의행사
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Carousel(),
          ),

          Expanded(
              flex: 1,
              child: Text(
                "공지사항",
              ),
          ),
      ),
    );
  }
}
