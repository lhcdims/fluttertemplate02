// This program stores ALL global variables required by ALL darts

// Import Flutter Darts
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threading/threading.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:redux/redux.dart';

// Import Self Darts
import 'LangStrings.dart';
import 'Utilities.dart';

// Import Pages
import 'bottom.dart';
import 'Home.dart';
import 'Login.dart';
import 'SelectLanguage.dart';



enum Actions { Increment } // The reducer, which takes the previous count and increments it in response to an Increment action.
int reducerSettingsMain(int intSomeInteger, dynamic action) {
  if (action == Actions.Increment) {
    return intSomeInteger + 1;
  }
  return intSomeInteger;
}



class gv {
  // Declare All pages to be used
  static ClsBottom clsBottom = ClsBottom();
  static ClsHome clsHome = ClsHome();
  static ClsLogin clsLogin = ClsLogin();
  static ClsSelectLanguage clsSelectLanguage = ClsSelectLanguage();
  //static ClsSettingsMain clsSettingsMain = ClsSettingsMain();

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





  // Declare STORE here for Redux

  // Store for SettingsMain
  static Store<int> storeSettingsMain = new Store<int>(reducerSettingsMain, initialState: 0);





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
  static var strLoginID = '';
  static var strLoginPW = '';
  static var aryLoginResult = [];
  static var timLogin = DateTime.now().millisecondsSinceEpoch;





  // socket.io related
  static const String URI = 'http://thisapp.zephan.top:10531';
  static bool gbolSIOConnected = false;
  static SocketIO socket;
  static int intSocketTimout = 5000;
  static int intHBInterval = 5000;

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

    socket.on('LoginResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timLogin > intSocketTimout) {
        print('login result timeout');
        return;
      }
      aryLoginResult = data;
      print('login result okay');
      print('Result: ' + aryLoginResult[0]);
    });

    socket.connect();

    // Create a thread to send HeartBeat
    var threadHB = new Thread(funTimerHeartBeat);
    threadHB.start();

    // Check Login Again if strLoginID != ''
    if (strLoginID != '') {

    }
  } // End of initSocket()



  // HeartBeat Timer
  static void funTimerHeartBeat() async {
    while (true) {
      await Thread.sleep(intHBInterval);
      if (socket != null) {
        print('Sending HB...' + DateTime.now().toString());
        socket.emit('HB',[0]);
      }
    }
  } // End of funTimerHeartBeat()



  // Send Message
  static void sendMessage() {
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
    }
  }
}  // End of class gv
