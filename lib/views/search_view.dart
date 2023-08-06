import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controller/user_controller.dart';
import '../models/users.dart';
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
  late Future<List<User>?> user;
  @override
  void initState() {
    // searchByName();
    super.initState();
  }

  searchByName() {
    if (_formKey.currentState!.validate()) {
      final body = {'name': nameController.text};
      user = getUserByName(body).then((name) async {
        print(body);
        print(body.length);
      }).catchError((err) {
        //snackBar in android studio
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Search',
        style: TextStyle(color: kSecondaryColor),
      )),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      hint: 'Text',
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.name],
                      label: 'Name ',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the Title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SecondaryButtonWidget(onTap: () {}, text: 'Add'),
                  ],
                )),
            FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final name = snapshot.data?[index].name;
                          final email = snapshot.data?[index].email;
                          return Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: kLinksColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Text(
                                  '$name',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '$email',
                                  style: TextStyle(color: Colors.white),
                                ),
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
                  return Text(snapshot.error.toString());
                }
                return Text('loading');
              },
            ),
          ],
        ),
      ),
    );
  }
}
