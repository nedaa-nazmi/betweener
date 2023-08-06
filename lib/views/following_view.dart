import 'package:flutter/material.dart';

import '../constants.dart';
import '../controller/user_controller.dart';
import '../models/users.dart';

class Following_View extends StatefulWidget {
  static const id = '/Followers_View';

  const Following_View({super.key});

  @override
  State<Following_View> createState() => _Follower_ViewState();
}

class _Follower_ViewState extends State<Following_View> {
  late Future<List<User>?> users;

  @override
  void initState() {
    users = getFollowing(context);
    print(users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Following list',
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
                              '${snapshot.data?[index].id}',
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
      ),
    );
  }
}
