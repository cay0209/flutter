import 'package:flutter/material.dart';


class PerformanceNewPage extends StatelessWidget {

  final Map<String,dynamic> data;
  PerformanceNewPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("행사 소개"),
        backgroundColor: Colors.grey[500],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data['title']}",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(
              height: 24, // 가로선의 높이
              thickness: 3, // 가로선의 두께
            ),
            SizedBox(height: 8),
            Text(
              "${data['content']}",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// board_newpage.dart