// This program display the Home Page

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'LangStrings.dart';
import 'ScreenVariables.dart';

// Import Pages
import 'BottomBar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('Home'),
            style: TextStyle(fontSize: sv.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(sv.dblTopHeight),
      ),
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          height: sv.dblBodyHeight,
          width: sv.dblScreenWidth,
          child: Center(
            child: Text(
              ls.gs('HomeContent'),
              style: TextStyle(fontSize: sv.dblDefaultFontSize),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClsBottom(),
    );
  }
}
