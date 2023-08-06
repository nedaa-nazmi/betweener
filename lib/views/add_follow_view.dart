import 'package:flutter/material.dart';

import '../controller/user_controller.dart';
import 'profile_view.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/secondary_button_widget.dart';

class Add_Follow_View extends StatefulWidget {
  static const id = '/Follow_View';
  const Add_Follow_View({super.key});
  @override
  State<Add_Follow_View> createState() => _Follow_ViewState();
}

class _Follow_ViewState extends State<Add_Follow_View> {
  TextEditingController followController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void submitFollow() {
    if (_formKey.currentState!.validate()) {
      final body = {'followee_id': followController.text};
      addFollowers(body).then((link) async {
        print(body);
        if (mounted) {
          Navigator.pushNamed(context, ProfileView.id);
        }
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
          title: Text(
        'Add Follow',
        style: TextStyle(color: Color(0xff2D2B4E)),
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
                      controller: followController,
                      hint: 'follower id',
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.url],
                      label: 'Follow Id',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the follower id';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            SecondaryButtonWidget(onTap: submitFollow, text: 'Add'),
          ],
        ),
      ),
    );
  }
}
