import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/user_controller.dart';

import '../constants.dart';
import '../models/users.dart';

class Followers_view extends StatefulWidget {
  static const id = '/Followers_view';
  const Followers_view({super.key});

  @override
  State<Followers_view> createState() => _Followers_viewState();
}

class _Followers_viewState extends State<Followers_view> {
  late Future<List<User>?> users;

  @override
  void initState() {
    users = getFollowers(context);
    print(users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Followers list',
          style: TextStyle(fontSize: 20, color: kPrimaryColor),
        ),
      ),
      body: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kLinksColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Text(
                            '${snapshot.data?[index].name}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${snapshot.data?[index].email}',
                            style: TextStyle(color: Colors.white),
                          ),
                          // Text(
                          //   '$country',
                          //   style: TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: snapshot.data!.length),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.data);
            return Text(snapshot.error.toString());
          }
          return Text('loading');
        },
      ),
    );
  }
}
