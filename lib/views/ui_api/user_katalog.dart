import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectakhir/controller/user_data.dart';
import 'package:projectakhir/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';


class UsersCatalog extends StatefulWidget {
  final String text;

  const UsersCatalog({Key? key, required this.text}) : super(key: key);

  @override
  _UsersCatalogState createState() => _UsersCatalogState();
}

class _UsersCatalogState extends State<UsersCatalog> {
  late String avatarUrl;
  late String login;
  late String htmlUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        title: Text("Users Github", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
        ],
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API
        child: FutureBuilder(
          future: UserData.instance.loadUsers(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError || widget.text.isEmpty) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Users user = Users.fromJson(snapshot.data);
              return _buildSuccessSection(user);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    if (widget.text.isEmpty) {
      return const Text("Search bar cannot be Empty");
    } else {
      return const Text("Error");
    }
  }

  // Jika data ada
  Widget _buildSuccessSection(Users data) {
    return ListView.builder(
      itemCount: data.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final user = data.items![index];
        return Container(
          child: ListTile(
            onTap: () {
              _launchURL(user.htmlUrl!);
            },
            leading: Image(
              width: 70,
              height: 70,
              image: NetworkImage(user.avatarUrl!, ),
            ),
            title: Text("${user.login}", style: TextStyle(
              color: Colors.white
            ),),
            subtitle: Text(
              "${user.htmlUrl}",
              style: TextStyle(fontSize: 11.0, color: Colors.white),
            ),
            isThreeLine: true,
          ),
        );
      },
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