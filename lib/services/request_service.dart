import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));
    try {
      if (httpResponse.statusCode == 200) {
        String response = httpResponse.body;
        var decodeResponse = jsonDecode(response);
        return decodeResponse;
      } else {
        return "Error Ocurred, No Response";
      }
    } catch (e) {
      return "Error Ocurred, No Response";
    }
  }
}
