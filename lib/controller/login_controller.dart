import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/models/users.dart';

import '../constants.dart';

Future<Users> login(Map<String, String> body) async {
  final response = await http.post(Uri.parse(loginUrl), body: body
      //{'email:nedaa','password':'222223'} like what is body
      );
  if (response.statusCode == 200) {
    print(response.body);
    return usersFromJson(response.body);
  } else {
    throw Exception("Failed with login");
  }
}

Future<Users> register(Map<String, String> body) async {
  final response = await http.post(Uri.parse(registerUrl), body: body
      //{'email:nedaa','password':'222223'} like what is body
      );
  if (response.statusCode == 200) {
    print(response.body);
    return usersFromJson(response.body);
  } else {
    throw Exception("Failed with login");
  }
}
