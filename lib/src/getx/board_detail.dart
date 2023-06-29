import 'package:flutter/material.dart';

class BoardDetail extends StatefulWidget  {
  const BoardDetail({Key? key}) : super(key: key);

  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '제목',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '제목을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            Text(
              '내용',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 작성된 제목과 내용 가져오기
                String title = _titleController.text;
                String content = _contentController.text;

                // TODO: 작성된 글을 서버에 전송 또는 저장하는 로직 추가

                // 글 작성 완료 후 이전 페이지로 돌아가기
                Navigator.pop(context);
              },
              child: Text('작성 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
