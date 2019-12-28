import 'package:flutter/material.dart';
import 'package:trial/models/send_email.dart';
import 'package:trial/utils/api_manager.dart';
import 'package:validate/validate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String _name, _email, _description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  // width: MediaQuery.of(context).size.width * 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Name",
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    onSaved: (String value) => _name = value,
                  ),
                ),
                Container(
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Email",
                      icon: Icon(Icons.email, color: Colors.black),
                    ),
                    validator: _validateEmail,
                    onSaved: (String value) => _email = value,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tell us what you need",
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  onSaved: (String value) => _description = value,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Send"),
                      onPressed: () {
                        _submit();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'How did you not write your email well?!';
    }
    return null;
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _sendEmail();
    }
  }

  _sendEmail() {
    final subject = _name;
    final from = From(email: _email);
    final personalization = [
      Personalization(to: [
        From(
          email: "ndzzngzz@gmail.com",
        ),
      ]),
    ];
    final content = [
      Content(
        type: "text/plain",
        value: _description,
      ),
    ];

    final sendEmail = SendEmail(
      personalizations: personalization,
      from: from,
      subject: subject,
      content: content,
    );

    APIManager.postEmail(sendEmail);
  }
}
