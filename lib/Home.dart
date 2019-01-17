// This program display the Home Page

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'SettingsMain.dart';
import 'tmpSettings.dart';

// Home Page
class ClsHome extends StatefulWidget {
  @override
  _ClsHomeState createState() => _ClsHomeState();
}

class _ClsHomeState extends State<ClsHome> {
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
            LangStrings.gs('Home'),
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
              LangStrings.gs('HomeContent'),
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
