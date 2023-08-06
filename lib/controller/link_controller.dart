import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/links.dart';
import 'package:tt9_betweener_challenge/models/users.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import 'package:http/http.dart' as http;

Future<List<Links>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  Users user = usersFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(linkUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(jsonDecode(response.body)['links']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;
    return data.map((e) => Links.fromJson(e)).toList();
  }
  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<Links> addLink(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(linkUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);
  if (response.statusCode == 200) {
    print(response.body);
    final data = jsonDecode(response.body)['link'];

    return Links.fromJson(data);
    // return linksFromJson(response.body);
  } else {
    throw Exception("Failed to add link");
  }
}

Future<Links> updateLink(Map<String, String> body, int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);
  final response = await http.put(Uri.parse("$linkUrl/$id"),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);
  if (response.statusCode == 200) {
    print(response.body);
    final data = jsonDecode(response.body)['link'];
    return Links.fromJson(data);
    // return linksFromJson(response.body);
  } else {
    throw Exception("Failed to add link");
  }
}

Future<void> deleteLink(int? link) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Users user = usersFromJson(prefs.getString('user')!);

  final response = await http.delete(Uri.parse("$linkUrl/$link"),
      headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    print(response.body);
    return Future.value("delete successfully");
    // return linksFromJson(response.body);
  } else {
    throw Exception("Failed to add link");
  }
}
