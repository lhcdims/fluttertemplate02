// This program display the Settings Main Page

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'Home.dart';
import 'LangStrings.dart';
import 'Login.dart';
import 'SelectLanguage.dart';
import 'tmpSettings.dart';

// Home Page
class ClsSettingsMain extends StatefulWidget {
  @override
  _ClsSettingsMainState createState() => _ClsSettingsMainState();
}

class _ClsSettingsMainState extends State<ClsSettingsMain> {
  static var listSettingsMain = [
    // List of Languages available
    {'Prog': 'SelectLanguage'},
    {'Prog': 'Login'},
  ];

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funSettingsMain(strProg) {
    // Set LastPage
    gv.gstrLastPage = gv.gstrCurPage;

    // Go to Next Page
    gv.gstrCurPage = strProg;

    // Code to Goto Next Page
    switch (strProg) {
      case 'SelectLanguage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsSelectLanguage()),
        );
        break;
      case 'Login':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsLogin()),
        );
        break;
      default:
        break;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
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
      body: Container(
        height: clsSettings.dblBodyHeight,
        width: clsSettings.dblScreenWidth,
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listSettingsMain.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(' '),
                    Row(children: <Widget>[
                      Text('                         ',
                          textAlign: TextAlign.center),
                      Expanded(
                        child: SizedBox(
                          height: clsSettings.dblDefaultFontSize * 2.5,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    clsSettings.dblDefaultRoundRadius)),
                            textColor: Colors.white,
                            color: Colors.greenAccent,
                            onPressed: () => funSettingsMain(
                                listSettingsMain[index]['Prog']),
                            child: Text(
                                '${LangStrings.gs(listSettingsMain[index]['Prog'])}',
                                style: TextStyle(
                                    fontSize:
                                        clsSettings.dblDefaultFontSize * 1)),
                          ),
                        ),
                      ),
                      Text('                         ',
                          textAlign: TextAlign.center),
                    ]),
                    Text(' '),
                  ],
                );
              }),
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
