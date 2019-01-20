// This program stores ALL global variables required by ALL darts

// Import Shared Preferences
import 'package:shared_preferences/shared_preferences.dart';
// Import socket.io related
// import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class gv {
  // Current Page
  static var gstrCurPage = 'SelectLanguage';
  static var gstrLastPage = 'SelectLanguage';

  // Init gstrCurBottom
  static var gintBottomIndex = 1;

  // Declare Language
  static var gstrLang = '';

  // Disable Bottom when loading
  static bool bolBottomLoading = false;

  // Declare SharedPreferences
  static SharedPreferences pref;
  static Init() async {
    pref = await SharedPreferences.getInstance();
  }
  static getString(strKey) {
    var strResult = '';
    strResult = pref.getString(strKey) ?? '';

    return strResult;
  }
  static setString(strKey, strValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(strKey, strValue);
  }

  // Function to return no. of space
  static String Space(intSpace) {
    var strResult = '';
    for(var i=1;i<=intSpace; i++) {
      strResult += ' ';
    }
    return strResult;
  }



  // socket.io related
  static const String URI = 'http://thisapp.zephan.top:10531';
  static bool gbolSIOConnected = false;
  static SocketIO socket;
  static var strLogin = 'Not Connected';
  static var strLoginLast = 'Not Connected';

  static initSocket() async {
    if (!gbolSIOConnected) {
      socket = await SocketIOManager().createInstance(URI);
    }
    socket.onConnect((data) {
      gbolSIOConnected = true;
      print('onConnect');
      // pprint(data);
      // sendMessage();
    });
    socket.onConnectError((data) {
      gbolSIOConnected = false;
      print('onConnectError');
    });
    socket.onConnectTimeout((data) {
      gbolSIOConnected = false;
      print('onConnectTimeout');
    });
    socket.onError((data) {
      gbolSIOConnected = false;
      print('onError');
    });
    socket.onDisconnect((data) {
      gbolSIOConnected = false;
      print('onDisconnect');
    });
    socket.on('news', (data) {
      print('news');
      print(data);
    });
    gv.socket.on('loginget', (data) {
      print('loginget');
      strLogin = data;
      print('strLogin: ' + strLogin);
    });
    socket.connect();
  }

  sendMessage() {
    if (socket != null) {
      print('sending message...');
      socket.emit('message', [
        'Hello world!',
        1908,
        {
          'wonder': 'Woman',
          'comincs': ['DC', 'Marvel']
        }
      ]);
      socket.emit('message', [
        {
          'wonder': 'Woman',
          'comincs': ['DC', 'Marvel']
        }
      ]);
    }
  }
}
