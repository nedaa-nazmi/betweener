import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';

import '../constants.dart';
import '../models/users.dart';
import 'package:http/http.dart' as http;

//
// Future<Users?> getUser() async {
//   Users? user;
//
//   getLocalUser().then((value) {
//     user = value;
//   }).catchError((error) {
//     return null;
//   });
//   return user;
//
//   // getLocalUser().then((user) {
//   //     return user;
//   // }).catchError((error){
//   //   return Future.error("$error");
//   // });
//   // return null;
// }

Future<Users> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return usersFromJson(prefs.getString('user')!);
  }
  return Future.error('not found');
  // Users.fromJson(prefs.containsKey('user'));
}

Future<List<User>> getUserByName(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(searchUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);
  print(response.body); //name
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['user'] as List<dynamic>;
    return data.map((e) => User.fromJson(e)).toList();
  } else {
    throw Exception("Failed to found name");
  }
}

Future<Users?> addFollowers(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);
  print(response.body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['followee_id'];
    print(data);
    return Users.fromJson(data);
  } else {
    throw Exception("Failed to add follower");
  }
}

Future<List<User>> getFollowing(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    // print(jsonDecode(response.body)['following']);

    final data = jsonDecode(response.body)['following'] as List<dynamic>;
    return data.map((e) => User.fromJson(e)).toList();
  }
  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, ProfileView.id);
  }
  return Future.error('Somthing wrong');
}

Future<List<User>> getFollowers(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    // print(jsonDecode(response.body)['following']);

    final data = jsonDecode(response.body)['followers'] as List<dynamic>;
    return data.map((e) => User.fromJson(e)).toList();
  }
  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, ProfileView.id);
  }
  return Future.error('Somthing wrong');
}
