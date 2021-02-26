import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_authentication/services/authService.dart';
import 'package:jwt_authentication/providers/authModel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter JWT Authentication'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            onChanged: (val) {
              email = val;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Password'),
            onChanged: (val) {
              password = val;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return RaisedButton(
                  onPressed: () {
                    AuthService().login(email, password).then((val) {
                      if (val.data['success']) {
                        token = val.data['token'];

                        auth.updateToken(token);

                        Fluttertoast.showToast(
                          msg: token.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    });
                  },
                  child: Text('Authenticate'),
                  color: Colors.blue
              );
            },
          ),
          Text('TOKEN: ' + Provider
              .of<AuthModel>(context, listen: true)
              .latestToken
              .toString()),
        ],
      ),
    );
  }
}
