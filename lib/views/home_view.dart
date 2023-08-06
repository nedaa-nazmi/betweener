import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/link_controller.dart';
import 'package:tt9_betweener_challenge/models/links.dart';

import '../constants.dart';
import '../controller/user_controller.dart';
import '../models/users.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<Users> user;
  late Future<List<Links>?> link;

  @override
  void initState() {
    user = getLocalUser();
    link = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HomePage',
            style: TextStyle(fontSize: 20, color: kPrimaryColor)),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    textAlign: TextAlign.center,
                    'Welcome ${snapshot.data?.user?.name}',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                child: Image(image: AssetImage('assets/imgs/OIP.png')),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            FutureBuilder(
              future: link,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 90,
                    width: 430,
                    child: ListView.separated(
                        padding: EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final link = snapshot.data?[index].title;
                          return Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: kLinksColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              '$link',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                        itemCount: snapshot.data!.length),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
