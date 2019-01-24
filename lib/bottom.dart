// This program contains the Class for the Bottom Navigator Bar

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';

// Class Bottom
class ClsBottom extends StatefulWidget {
  @override
  _ClsBottomState createState() => _ClsBottomState();
}

class _ClsBottomState extends State<ClsBottom> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void _onItemTapped(int index) {
    if (gv.gstrLang != '' && gv.bolLoading == false) {
      gv.gintBottomIndex = index;
      switch (index) {
        case 0:
          // Page Home Clicked
          gv.gstrLastPage = gv.gstrCurPage;
          gv.gstrCurPage = 'Home';

          // Goto Home
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => gv.clsHome),
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
            MaterialPageRoute(builder: (context) => gv.clsSettingsMain),
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
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text(ls.gs('Home'))),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text(ls.gs('Settings'))),
      ],
      currentIndex: gv.gintBottomIndex,
      fixedColor: Colors.deepPurple,
      onTap: _onItemTapped,
    );
  }
}
