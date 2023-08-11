import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/links.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controller/user_controller.dart';
import '../models/users.dart';
import 'main_app_view.dart';
import 'widgets/custom_text_form_field.dart';

class Search_View extends StatefulWidget {
  static const id = '/Search_View';

  const Search_View({super.key});

  @override
  State<Search_View> createState() => Search_ViewState();
}

class Search_ViewState extends State<Search_View> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Future<Links> link;
  late Future<User> user;
  late Future<User> current_user;

  late Future<List<User>> searchResult;

  late String localId;

  addFollowUser(String id) {
    final body = {'followee_id': id};
    addFollowers(body).then((user) async {
      if (mounted) {
        Navigator.pushNamed(context, MainAppView.id);
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  void initState() {
    // searchByName();
    user = getLocalUser() as Future<User>;
    current_user = getLocalUser() as Future<User>;

    searchResult = Future.value([]);
    super.initState();
  }

  void getResultSearch(String query) {
    setState(() {
      if (_formKey.currentState!.validate()) {
        searchResult = getUserByName(query);
        print(query);
      } else {
        searchResult = Future.value([]);
      }
    });
  }

  // searchByName() {
  //   if (_formKey.currentState!.validate()) {
  //     // final body = {'name': nameController.text};
  //     user = getUserByName(nameController.text).then((name) async {
  //       print(name);
  //       // print(body.length);
  //     }).catchError((err) {
  //       //snackBar in android studio
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(err.toString()),
  //         backgroundColor: Colors.red,
  //       ));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Search',
        style: TextStyle(color: kSecondaryColor),
      )),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Search input field
            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                onChanged: getResultSearch, // Call search on user input change
                decoration: InputDecoration(
                  labelText: 'Search follower',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(50), // Set the circular radius
                  ),
                  prefixIcon: Icon(Icons.search), // Add the search icon
                ),
              ),
            ),
            // Display search results using ListView.builder
            Expanded(
              child: FutureBuilder<List<User>>(
                future: searchResult,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 50,
                      width: 50,
                      child: SpinKitThreeBounce(
                        color: kPrimaryColor,
                        size: 16.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<User> users = snapshot.data ?? []; // Handle null case
                    if (users.isEmpty) {
                      return Text('No User with same name');
                    }

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];
                        // Build the UI for each user in the list
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: kLightPrimaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      // leading: const UserImage(),
                                      title: Text(
                                        '${user.name ?? 'No Name'}',
                                        style: TextStyle(
                                          letterSpacing: 2.0,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      subtitle:
                                          Text('${user.email ?? 'No Email'}'),
                                    ),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: user == current_user ? 0 : 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        String id = user.id! as String;
                                        addFollowUser(id);
                                      });
                                    },
                                    child: Text('Follow'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
