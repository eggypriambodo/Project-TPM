import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projectakhir/views/ui_api/repo_katalog.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoSearch extends StatefulWidget {
  const RepoSearch({Key? key}) : super(key: key);

  @override
  _RepoSearchState createState() => _RepoSearchState();
}

class _RepoSearchState extends State<RepoSearch> {

  final _controller = TextEditingController();
  String? text;

  List<dynamic> repositories = [];

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    final response = await http.get(Uri.parse('https://api.github.com/repositories'));
    if (response.statusCode == 200) {
      setState(() {
        repositories = json.decode(response.body);
      });
    } else {
      print('Failed to fetch repositories.');
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
                          hintText: "Github Repository",
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
                            return ReposCatalog(text: _controller.text);
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
              child: ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repo = repositories[index];
                  return ListTile(
                    title: Text(repo['full_name'], style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    subtitle: Text(repo['description'] ?? 'No description', style:
                      TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),),
                    onTap: () {
                      _launchURL(repo['html_url']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}