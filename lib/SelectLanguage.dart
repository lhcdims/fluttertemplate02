// This program allows you to Select Language Defined in LangStrings.dart

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';
import 'Utilities.dart';

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
    ls.setLang(strLang);
    // Store Language Selected in SharedPreferences
    gv.setString('strLang', strLang);

    // Set LastPage
    gv.gstrLastPage = gv.gstrCurPage;

    // Go to Setting Page
    gv.gstrCurPage = 'SettingsMain';

    // Code to Goto Next Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gv.clsSettingsMain),
    );
    // Since no need to go back to this page,
    // Reset routes here
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            'Select Language',
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
              itemCount: ls.listLang.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(' '),
                    Row(children: <Widget>[
                      Text(ut.Space(sv.gintSpaceBigButton),
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
                            onPressed: () =>
                                funSelectLang(ls.listLang[index]['Lang']),
                            child: Text('${ls.listLang[index]['LangDesc']}',
                                style: TextStyle(
                                    fontSize: sv.dblDefaultFontSize * 1)),
                          ),
                        ),
                      ),
                      Text(ut.Space(sv.gintSpaceBigButton),
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
