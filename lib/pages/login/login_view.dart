import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/pages/home/home_view.dart';
import 'package:job/pages/home/home_viewmodel.dart';
import 'package:job/pages/login/login_viewmodel.dart';
import 'package:job/presentation/texts_value.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context), body: _getBody());
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        TextsValue.postTitle,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _getBody() {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      TextsValue.welcome,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: TextsValue.firstName,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: TextsValue.lastName,
                    ),
                  ),
                ),
                Container(
                    height: 76,
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Consumer<LoginViewModel>(
                        builder: (context, model, child) {
                      return ElevatedButton(
                        child: Text(TextsValue.login),
                        onPressed: () {
                          model.addNameAndLastName(
                              nameController.text, lastNameController.text);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeView()));
                        },
                      );
                    })),
              ],
            )));
  }
}
