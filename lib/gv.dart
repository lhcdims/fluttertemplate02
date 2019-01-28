// This program stores ALL global variables required by ALL darts

// Import Flutter Darts
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threading/threading.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

// Import Self Darts
import 'LangStrings.dart';
import 'Utilities.dart';

// Import Pages
import 'bottom.dart';
import 'Home.dart';
import 'Login.dart';
import 'SelectLanguage.dart';
import 'SettingsMain.dart';

class gv {
  // Declare All pages to be used
  static ClsBottom clsBottom = ClsBottom();
  static ClsHome clsHome = ClsHome();
  static ClsLogin clsLogin = ClsLogin();
  static ClsSelectLanguage clsSelectLanguage = ClsSelectLanguage();
  static ClsSettingsMain clsSettingsMain = ClsSettingsMain();

  // Current Page
  // gstrCurPage stores the Current Page to be loaded
  static var gstrCurPage = 'SelectLanguage';
  static var gstrLastPage = 'SelectLanguage';

  // Init gintBottomIndex
  // i.e. Which Tab is selected in the Bottom Navigator Bar
  static var gintBottomIndex = 1;

  // Declare Language
  // i.e. Language selected by user
  static var gstrLang = '';

  // bolLoading is used by the 'package:modal_progress_hud/modal_progress_hud.dart'
  // Inside a particular page that use Modal_Progress_Hud  :
  // Set it to true to show the 'Loading' Icon
  // Set it to false to hide the 'Loading' Icon
  static bool bolLoading = false;

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





  // Var For Login
  static var aryLoginResult = [];
  static var timLogin = DateTime.now().millisecondsSinceEpoch;





  // socket.io related
  static const String URI = 'http://thisapp.zephan.top:10531';
  static bool gbolSIOConnected = false;
  static SocketIO socket;

  static initSocket() async {
    if (!gbolSIOConnected) {
      socket = await SocketIOManager().createInstance(URI);
    }
    socket.onConnect((data) {
      gbolSIOConnected = true;
      print('onConnect');
      ut.showToast(ls.gs('NetworkConnected'));
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
      ut.showToast(ls.gs('NetworkDisconnected'));
    });
    socket.on('UpdateYourSocketID', (data) {
      print('strLogin: ' + data);
    });

    socket.on('LoginResult', (data) {
      // set loading
      //bolLoading = false;
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timLogin > 5000) {
        print('login result timeout');
        return;
      }
      aryLoginResult = data;
      print('login result okay');
      print('Result: ' + aryLoginResult[0]);
    });

    socket.connect();

    var threadHB = new Thread(funTimerHeartBeat);    // Create a new thread to simulate an External Event that changes a global variable defined in gv.dart
    threadHB.start();
  }
  static void funTimerHeartBeat() async {  // The following function simulates an External Event  e.g. a global variable is changed by socket.io and see how all widgets react with this global variable
    while (true) {
      await Thread.sleep(5000);
      if (socket != null) {
        print('Sending HB...' + socket.id.toString());
        socket.emit('HB',[0]);
      }
    }
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
