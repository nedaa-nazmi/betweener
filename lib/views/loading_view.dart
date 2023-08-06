import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';
import 'package:tt9_betweener_challenge/views/main_app_view.dart';

class Loading_view extends StatefulWidget {
  static const id = '/loading_view';

  const Loading_view({super.key});

  @override
  State<Loading_view> createState() => _loading_viewState();
}

class _loading_viewState extends State<Loading_view> {
  void checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user') && mounted) {
      print('navigate to main');
      Navigator.pushNamed(context, MainAppView.id);
    } else {
      Navigator.pushNamed(context, LoginView.id);
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
