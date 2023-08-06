import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/add_link_view.dart';
import 'package:tt9_betweener_challenge/views/add_follow_view.dart';
import 'package:tt9_betweener_challenge/views/follower_view.dart';
import 'package:tt9_betweener_challenge/views/following_view.dart';
import 'package:tt9_betweener_challenge/views/home_view.dart';
import 'package:tt9_betweener_challenge/views/loading_view.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';
import 'package:tt9_betweener_challenge/views/main_app_view.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/receive_view.dart';
import 'package:tt9_betweener_challenge/views/register_view.dart';
import 'package:tt9_betweener_challenge/views/search_view.dart';
import 'package:tt9_betweener_challenge/views/update_link_view.dart';

import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betweener',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          scaffoldBackgroundColor: kScaffoldColor),
      home: const Loading_view(),
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        MainAppView.id: (context) => const MainAppView(),
        ProfileView.id: (context) => const ProfileView(),
        ReceiveView.id: (context) => const ReceiveView(),
        Loading_view.id: (context) => const Loading_view(),
        Add_Link_View.id: (context) => const Add_Link_View(),
        Search_View.id: (context) => const Search_View(),
        Add_Follow_View.id: (context) => const Add_Follow_View(),
        Followers_view.id: (context) => const Followers_view(),
        Following_View.id: (context) => const Following_View(),
      },
    );
  }
}
