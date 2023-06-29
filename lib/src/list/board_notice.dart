import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


import 'package:mapmapmap/model/board.dart';

class BoardList extends StatelessWidget {
  BoardList({Key? key}) : super(key: key);

  Future<List<Board>> findAll() async {
    try {
      final url = Uri.parse(
          "http://192.168.100.236:9000/board-service/list"); // 각자 본인 컴퓨터의 localhost로 설정
      print(url);

      final response = await http.get(url);
      print(response.body);

      if (response.statusCode == 200) {
        List<Board> boardList = [];
        var jsonBody = jsonDecode(response.body);

        var jsonResult = jsonBody["result"];


        for (var jsonBoard in jsonResult) {
          if (jsonBoard != null) {
            Board board = Board.fromJson(jsonBoard);
            boardList.add(board);
          }
        }
        print(boardList);

        return boardList;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("공지사항 가져오기 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("공지사항",
        textAlign: TextAlign.left,),

      ),

      body: FutureBuilder<List<Board>>(
        future: findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Board> dataList = snapshot.data!;
            return ListView.builder(
              itemExtent: 50, // 각 ListTile의 높이
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Board item = dataList[index];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(30, 5, 20, 24),
                  // 내용 주위 여백 조정, B:title-subtitle간격!
                  title: Text(item.title),
                  subtitle: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      // '${item.updateAt}'
                      DateFormat('yyyy-MM-dd').format(item.createAt),
                    ),
                  ),
                  onTap: () {
                    // _navigateToBoardDetail(context, item);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error"); // 데이터 로딩 중 오류가 발생한 경우 오류 메시지 출력
          } else {
            return CircularProgressIndicator(); // 데이터 로딩 중일 때 로딩 표시기 표시
          }
        },
      ),
    );
  }
}