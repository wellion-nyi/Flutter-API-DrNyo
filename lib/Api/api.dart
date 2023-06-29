import 'dart:convert';

import 'package:http/http.dart' as http;

class Callme {
  // This is UrL
  final String apiUrl = "https://randomuser.me/api/?results=10";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['results'];
  }

  String name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String location(dynamic user) {
    return user['location']['country'];
  }

  String age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }
}
