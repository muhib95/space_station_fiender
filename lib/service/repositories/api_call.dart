import 'dart:convert';

import 'package:iss_app/model/position_response.dart';
import 'package:http/http.dart' as http;
class ApiCall {
  final String uri = "http://api.open-notify.org/iss-now.json";

 Future<PositionResponse?> getPosition() async {
    try {
      final url = Uri.parse(uri);
      final response=await http.get(url);
      if (response.statusCode == 200) {
        print('Data fetched:${PositionResponse.fromJson(jsonDecode(response.body))}');
       return PositionResponse.fromJson(jsonDecode(response.body));


      } else {
        print("Error: ${response.statusCode}");
      }

    } catch (e) {
      throw e;
    } finally {}
    return null;
  }
}
