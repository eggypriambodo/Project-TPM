import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:projectakhir/controller/repo_data.dart';
import 'package:projectakhir/models/repo_models.dart';
import 'package:projectakhir/box.dart';
import 'package:url_launcher/url_launcher.dart';


class ReposCatalog extends StatefulWidget {
  final String text;

  const ReposCatalog({Key? key, required this.text}) : super(key: key);

  @override
  _ReposCatalogState createState() => _ReposCatalogState();
}

class _ReposCatalogState extends State<ReposCatalog> {
  late String fullName;
  late String description;
  late String htmlUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        title: Text("Repository Github", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API
        child: FutureBuilder(
          future: RepoData.instance.loadRepos(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError || widget.text.isEmpty) {
              return _buildErrorSectio();
            }
            if (snapshot.hasData) {
              Repo repo = Repo.fromJson(snapshot.data);
              return _buildSuccessSectio(repo);
            }
            return _buildLoadingSectio();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSectio() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSectio() {
    if (widget.text.isEmpty) {
      return const Text("Search bar cannot be Empty", style: TextStyle(color: Colors.white),);
    } else {
      return const Text("Error", style: TextStyle(color: Colors.white),);
    }
  }

  // Jika data ada
  Widget _buildSuccessSectio(Repo repu) {
    return ListView.builder(
      itemCount: repu.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final repo = repu.items![index];
        return ListTile(
          onTap: () {
            _launchURL(repo.htmlUrl!);
          },
          title: Text("${repo.fullName}", style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          subtitle: Text(
            "${repo.description}",
            style: TextStyle(fontSize: 11.0, color: Colors.white),
          ),
          isThreeLine: true,
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