import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectakhir/views/profile.dart';
import 'package:projectakhir/views/ui_api/repo_search.dart';
import 'package:projectakhir/views/ui_api/user_search.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  const HomePage({super.key, required this.signOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedTimezone = 'WIB';
  String currentTime = '';

  void startClock() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateFormat('HH:mm:ss').format(DateTime.now().toUtc());
      });
    });
  }

  String convertToTimezone(String timezone) {
    DateTime now = DateTime.now().toUtc();
    switch (timezone) {
      case 'WIB':
        now = now.add(Duration(hours: 7));
        break;
      case 'WIT':
        now = now.add(Duration(hours: 9));
        break;
      case 'WITA':
        now = now.add(Duration(hours: 8));
        break;
    }
    return DateFormat('HH:mm:ss').format(now);
  }

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPref();
    startClock();
  }


  int _bottonNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_book),
      label: 'Repository Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle_outlined),
      label: 'User Search',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottonNavIndex = index;
    });
  }

  final List<String> _listApp = [
    'Profile',
    'Repository Search',
    'User Search',
  ];

  final List<Widget> _listWidget = [
    const Profile(),
    RepoSearch(),
    UserSearch(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        title: Text(_listApp[_bottonNavIndex], style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(top: 17, right: 120),
            child: Text(
              selectedTimezone == 'UTC' ? currentTime : convertToTimezone(selectedTimezone),
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(width: 10,),
          DropdownButton<String>(
            dropdownColor: Color.fromRGBO(49, 39, 79, 1),
            value: selectedTimezone,
            onChanged: (String? newValue) {
              setState(() {
                selectedTimezone = newValue!;
              });
            },
            items: <String>['WIB', 'WIT', 'WITA', 'UTC'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(

                value: value,
                child: Text(value, style: TextStyle(color: Colors.white),),
              );
            }).toList(),
          ),
          IconButton(onPressed: () {signOut();}, icon: Icon(Icons.logout),color: Colors.white,)
        ],
      ),
      backgroundColor: Color(0xff21254A),
      body: _listWidget[_bottonNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        currentIndex: _bottonNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}