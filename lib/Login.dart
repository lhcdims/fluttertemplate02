// This program display the Login Page

// Import Flutter Darts
import 'package:flutter/material.dart';
import 'dart:convert';

// Import Self Darts
import 'gv.dart';
import 'Home.dart';
import 'LangStrings.dart';
import 'SettingsMain.dart';
import 'tmpSettings.dart';

// Login Page
class ClsLogin extends StatefulWidget {
  @override
  _ClsLoginState createState() => _ClsLoginState();
}
class _ClsLoginState extends State<ClsLogin> {
  int intCounter = 0;

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void _onItemTapped(int index) {
    if (gv.gstrLang != '') {
        gv.gintBottomIndex = index;
        switch (index) {
          case 0:
          // Page Home Clicked
            gv.gstrLastPage = gv.gstrCurPage;
            gv.gstrCurPage = 'Home';

            // Goto Home
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClsHome()),
            );
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            break;
          case 1:
          // Page Settings Clicked
            gv.gstrLastPage = gv.gstrCurPage;
            gv.gstrCurPage = 'SettingsMain';

            // Goto SettingsMain
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClsSettingsMain()),
            );
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            break;
          default:
            break;
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            LangStrings.gs('Settings'),
            style: TextStyle(fontSize: clsSettings.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(clsSettings.dblTopHeight),
      ),
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          height: clsSettings.dblBodyHeight,
          width: clsSettings.dblScreenWidth,
          child: Center(
            child: Text(
              LangStrings.gs('LoginContent') + gv.strLogin,
              style: TextStyle(fontSize: clsSettings.dblDefaultFontSize),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(LangStrings.gs('Home'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(LangStrings.gs('Settings'))),
        ],
        currentIndex: gv.gintBottomIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
