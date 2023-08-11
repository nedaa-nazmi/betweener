import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/link_controller.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../models/links.dart';
import '../models/users.dart';

class Add_Link_View extends StatefulWidget {
  static const id = '/AddLink';

  const Add_Link_View({super.key});

  @override
  State<Add_Link_View> createState() => _AddLinkState();
}

class _AddLinkState extends State<Add_Link_View> {
  late Future<Links>? link;
  late Future<Users>? user;

  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // void submitLink() {
  //   if (_formKey.currentState!.validate()) {
  //     final body = {'title': titleController.text, 'link': linkController.text};
  //     addLink(body).then((link) async {
  //       print(body);
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
          title: Text(
        'Add Link',
        style: TextStyle(color: Color(0xff2D2B4E), fontSize: 22),
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
                      controller: titleController,
                      hint: 'Text',
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.url],
                      label: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the Title';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: linkController,
                      hint: 'http:\\www.Example.com',
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.url],
                      label: 'Link',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the Link';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            // SecondaryButtonWidget(onTap: submitLink, text: 'Add'),
          ],
        ),
      ),
    );
  }
}
