import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectakhir/views/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bool _isLoad = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  void _onRegister() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.8/tpmuser/user/register.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: {
          "username": usernameController.text,
          "password": passwordController.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    print(usernameController.text);
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else if (value == 0) {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.pink[200],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.pink[200],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: _isLoad
          ? const Center(
          child: CircularProgressIndicator()
      )
          : SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
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
                      "Create your account here",
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

                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },
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
                              controller: passwordController,
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
                              controller: confirmPasswordController,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
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
                                  return 'Confirm Password is required';
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
                      width: MediaQuery.of(context).size.width/1,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:Color.fromRGBO(49, 39, 79, 1),
                          shape: StadiumBorder(),

                        ),
                        onPressed: () { print(usernameController.text);
                        if (usernameController.text != "" &&
                            passwordController.text != "" &&
                            confirmPasswordController.text != "") {
                          if (passwordController.text != confirmPasswordController.text) {
                            SnackBar snackBar = SnackBar(
                              content: Text(
                                  "Password dan Konfirmasi Password harus sama !"),
                              backgroundColor:Colors.pink[200],
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            _onRegister();
                          }
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text("Tidak Boleh Ada Yang Kosong"),
                            backgroundColor: Colors.pink[200],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } },
                        child: Text('REGISTER',style: TextStyle(color: Colors.white)),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return LoginPage();
                        }));
                      }, child: Text('Already have an account?',style: TextStyle(color: Colors.white))),
                    )


                  ],
                ),
              )
        ],
      ),
            ),
          ),
    );
  }
}
