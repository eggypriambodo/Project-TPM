import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectakhir/views/ui_api/user_katalog.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final _controller = TextEditingController();
  String? text;

  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://api.github.com/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
    } else {
      print('Failed to fetch users.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        borderRadius: BorderRadius.circular(7.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        selectionHeightStyle: BoxHeightStyle.max,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.nunitoSans(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                          hintText: "Github Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                        controller: _controller,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return UsersCatalog(text: _controller.text);
                          }));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color.fromRGBO(49, 39, 79, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0, // Ubah nilai padding vertikal
                        horizontal: 12.0, // Ubah nilai padding horizontal
                      ),
                      child: Text(
                        "Search",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 16.0, // Ubah ukuran font
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(user['html_url']);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(user['avatar_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              user['login'],
                              style: TextStyle(
                                backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}