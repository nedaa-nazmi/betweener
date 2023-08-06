import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/views/follower_view.dart';
import 'package:tt9_betweener_challenge/views/following_view.dart';
import 'package:tt9_betweener_challenge/views/search_view.dart';
import 'package:tt9_betweener_challenge/views/update_link_view.dart';

import '../constants.dart';
import '../controller/link_controller.dart';
import '../controller/user_controller.dart';
import '../models/links.dart';
import '../models/users.dart';
import 'add_link_view.dart';
import 'add_follow_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Links>?> link;
  late Future<Users> user;

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() {
    setState(() {
      user = getLocalUser();
      link = getLinks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile',
              style: TextStyle(fontSize: 22, color: kPrimaryColor)),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Search_View.id);
                },
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.search_sharp, color: kPrimaryColor))),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Add_Follow_View.id);
                },
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.person_pin, color: kPrimaryColor))),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 80),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Add_Link_View.id);
              update();
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: kPrimaryColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kPrimaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image(
                                image: AssetImage(
                                    'assets/imgs/pngtree_profile.jpg')),
                            backgroundColor: Colors.white,
                            maxRadius: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        '${snapshot.data?.user?.name}',
                                        style: TextStyle(color: Colors.white),
                                      );
                                    }
                                    return Text("No Data");
                                  },
                                ),
                                FutureBuilder(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        '${snapshot.data?.user?.email}',
                                        style: TextStyle(color: Colors.white),
                                      );
                                    }
                                    return Text("No Data");
                                  },
                                ),
                                FutureBuilder(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text('${snapshot.data?.user?.id}',
                                          style:
                                              TextStyle(color: Colors.white));
                                    }
                                    return Text("No Data");
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Followers_view.id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: kSecondaryColor,
                                        ),
                                        child: Text('Followers'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Following_View.id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: kSecondaryColor,
                                        ),
                                        child: Text('Following'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: link,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final title = snapshot.data?[index].title;
                            final link = snapshot.data?[index].link;
                            final link_id = snapshot.data?[index].id;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        deleteLink(snapshot.data?[index].id);
                                        print(deleteLink(
                                            snapshot.data?[index].id));
                                        update();
                                      },
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Update_Link_View(
                                                title: title!,
                                                link: link!,
                                                link_id: link_id!);
                                          },
                                        ));
                                        update();
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 400,
                                  height: 70,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: kLinksColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$title',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '$link',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
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
                    return Text(snapshot.error.toString());
                  }
                  return Text('loading');
                },
              ),
            ],
          ),
        ));
  }
}
