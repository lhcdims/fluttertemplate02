// This program display the Settings Main Page

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';

// Home Page
class ClsSettingsMain extends StatefulWidget {
  @override
  _ClsSettingsMainState createState() => _ClsSettingsMainState();
}

class _ClsSettingsMainState extends State<ClsSettingsMain> {
  static var listSettingsMain = [
    // list of Buttons in this page
    {'Prog': 'SelectLanguage'},
    {'Prog': 'Login'},
  ];

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  // Choose which page when button pressed
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
          MaterialPageRoute(builder: (context) => gv.clsSelectLanguage),
        );
        break;
      case 'Login':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gv.clsLogin),
        );
        break;
      default:
        break;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('Settings'),
            style: TextStyle(fontSize: sv.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(sv.dblTopHeight),
      ),
      body: Container(
        height: sv.dblBodyHeight,
        width: sv.dblScreenWidth,
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
                          height: sv.dblDefaultFontSize * 2.5,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    sv.dblDefaultRoundRadius)),
                            textColor: Colors.white,
                            color: Colors.greenAccent,
                            onPressed: () => funSettingsMain(
                                listSettingsMain[index]['Prog']),
                            child: Text(
                                '${ls.gs(listSettingsMain[index]['Prog'])}',
                                style: TextStyle(
                                    fontSize:
                                        sv.dblDefaultFontSize * 1)),
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
      bottomNavigationBar: gv.clsBottom,
    );
  }
}
