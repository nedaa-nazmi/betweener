import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/link_controller.dart';

import '../controller/user_controller.dart';
import '../models/links.dart';
import '../models/users.dart';
import 'profile_view.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/secondary_button_widget.dart';

class Update_Link_View extends StatefulWidget {
  static const id = '/Update_Link_View';
  late String title;
  late String link;
  late int link_id;

  Update_Link_View(
      {required this.title, required this.link, required this.link_id});

  @override
  State<Update_Link_View> createState() => _Update_Link_ViewState();
}

class _Update_Link_ViewState extends State<Update_Link_View> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  updateLinkById() {
    if (_formKey.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': linkController.text};
      updateLink(body, widget.link_id).then((link) async {
        print(body);
        if (mounted) {
          Navigator.pushNamed(context, ProfileView.id);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Update Link',
        style: TextStyle(color: Color(0xff2D2B4E), fontSize: 22),
      )),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: titleController,
                      hint: widget.title,
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
                      hint: widget.link,
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
            const SizedBox(
              height: 10,
            ),
            SecondaryButtonWidget(onTap: updateLinkById, text: 'Update'),
          ],
        ),
      ),
    );
  }
}
