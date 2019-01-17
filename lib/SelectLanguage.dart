// This program allows you to Select Language Defined in LangStrings.dat

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'Home.dart';
import 'LangStrings.dart';
import 'SettingsMain.dart';
import 'tmpSettings.dart';

// Home Page
class ClsSelectLanguage extends StatefulWidget {
  @override
  _ClsSelectLanguageState createState() => _ClsSelectLanguageState();
}

class _ClsSelectLanguageState extends State<ClsSelectLanguage> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funSelectLang(strLang) {
    // Change Language
    gv.gstrLang = strLang;
    LangStrings.setLang(strLang);
    // Store Language Selected in SharedPreferences
    gv.setString('strLang', strLang);

    // Set LastPage
    gv.gstrLastPage = gv.gstrCurPage;

    // Go to Setting Page
    gv.gstrCurPage = 'SettingsMain';

    // Code to Goto Next Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClsSettingsMain()),
    );
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
            'Select Language',
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
              itemCount: LangStrings.listLang.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(' '),
                    Row(children: <Widget>[
                      Text(gv.Space(clsSettings.gintSpaceBigButton),
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
                            onPressed: () => funSelectLang(
                                LangStrings.listLang[index]['Lang']),
                            child: Text(
                                '${LangStrings.listLang[index]['LangDesc']}',
                                style: TextStyle(
                                    fontSize:
                                        clsSettings.dblDefaultFontSize * 1)),
                          ),
                        ),
                      ),
                      Text(gv.Space(clsSettings.gintSpaceBigButton),
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
