import 'package:flutter/material.dart';
import 'package:projectakhir/views/homepage.dart';
import 'package:projectakhir/views/registerpage.dart';
import 'dart:convert';
import 'package:projectakhir/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>();
  var UsernameController = TextEditingController();
  var PasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoad = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  void _onLogin() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.8/tpmuser/user/login.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: {
          "username": UsernameController.text,
          "password": PasswordController.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String username = data['username'];
    String password = data['password'];
    print(UsernameController.text);
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, username, password);
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return HomePage(
            signOut: signOut,
          );
        }),
      );
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.pink[200],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  savePref(int value, String username, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("password", password);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const MyApp();
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff21254A),
          body: _isLoad
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Hello there, \nwelcome back",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: UsernameController,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),

                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: !_isPasswordVisible,
                              controller: PasswordController,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },

                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 39, 79, 1),
                          shape: StadiumBorder(),

                        ),
                        onPressed: () {
                          if (UsernameController.text != "" &&
                              PasswordController.text != "") {
                            _onLogin();
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("Tidak Boleh Ada Yang Kosong"),
                              backgroundColor: Colors.pink[200],
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text('LOGIN', style: TextStyle(color: Colors.white),),

                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => RegisterPage(),),);
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomePage(
          signOut: signOut,
        );
        break;
    }
  }
}
