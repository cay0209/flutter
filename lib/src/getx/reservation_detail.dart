import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapmapmap/model/reservation.dart';

class DataSource {
  Future<Reservation> createReservation(String? boardId, String name, DateTime reservationDate, int count, String phoneNum) async {
    try {
      final url = Uri.parse("http://192.168.100.236:9000/reserve-service/reserve"); // 각자 본인 컴퓨터의 localhost로 설정

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        'bid': boardId,
        'username': name,
        'reservationDate': "${reservationDate.year.toString().padLeft(4, '0')}"
            "-${reservationDate.month.toString().padLeft(2, '0')}"
            "-${reservationDate.day.toString().padLeft(2, '0')}",
        'numberOfPeople': count.toString(),
        'phoneNum':phoneNum,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonBody=jsonDecode(response.body);
        Reservation reservation = Reservation.fromJson(jsonBody["result"]);
        return reservation;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약에 실패했습니다.");
    }
  }

  //name과 phoneNum 매개변수를 입력으로 받아서
  //해당 이름과 전화번호에 해당하는 예약 정보를 가져오는 기능
  Future<List<Reservation>> findReservation(String name, String phoneNum) async {
    try {
      //주어진 name과 phoneNum을 사용하여 서버에 요청할 URL을 생성
      final url = Uri.parse("http://192.168.100.236:9000/reserve-service/${name}/${phoneNum}"); // 각자 본인 컴퓨터의 localhost로 설정
      print(url);
      //생성된 URL로 HTTP GET 요청
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {//응답을 받은 후, 응답 상태 코드를 확인
        List<Reservation> reservationList = [];

       //응답 본문을 JSON 형식으로 파싱하여 변수 jsonBody에 저장
        var jsonBody=jsonDecode(response.body);

        //파싱된 JSON 데이터에서 "result"라는 필드를 찾아 해당 필드의 값인 예약 정보 목록을 가져옴
        var jsonResult = jsonBody["result"];

        //가져온 예약 정보 목록을 순회하면서 각각의 JSON 객체를 Reservation 객체로 변환
        for (var jsonReservation in jsonResult) {
          Reservation reservation = Reservation.fromJson(jsonReservation);

          //변환된 Reservation 객체를 reservationList에 추가
          reservationList.add(reservation);
        }

        return reservationList;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약 취소 실패");
    }
  }

  Future<void> deleteReservation(List<dynamic> list, String name, String phoneNum) async {
    try {
      final url = Uri.parse("http://192.168.100.236:9000/reserve-service");

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        'username': name,
        'phoneNum':phoneNum,
        'list':list,
      });

      final response = await http.delete(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약 취소에 실패했습니다.");
    }
  }
}



// reservation_detail.dart 파일

