// This file contains ALL Strings in ALL Languages
// import 'LangStrings.dart' in order to use it
// To add other languages, you have to
// 1. Include another element in listLang
// 2. Create another static const listStrings_XX, in which XX is the language code defined by YOU
// 3. Modify the function gs()


class ls {
  // strLang is the Current Language selected by the User
  // *** NOT by the system locale of the mobile phone ***
  // e.g. You can use LangStrings.setLang('EN') to set Current Language to English
  static var strLang = '';

  // List of Language
  static const listLang = [
    // List of Languages available
    { 'Lang':'EN', 'LangDesc':'English'},
    { 'Lang':'SC', 'LangDesc':'简体中文'},
    { 'Lang':'TC', 'LangDesc':'繁體中文'},
  ];

  // vars for English
  static const listStrings_EN = [
    // General
    { 'Title':'Home', 'Content':'Home'},
    { 'Title':'Login', 'Content':'Login'},
    { 'Title':'LoginFailed', 'Content':'Login Failed'},
    { 'Title':'LoginSuccess', 'Content':'Login Success'},
    { 'Title':'NetworkConnected', 'Content':'Network Connected'},
    { 'Title':'NetworkDisconnected', 'Content':'Network Disonnected'},
    { 'Title':'SelectLanguage', 'Content':'Select Language'},
    { 'Title':'Settings', 'Content':'Settings'},
    { 'Title':'UserID', 'Content':'User ID'},
    { 'Title':'UserPW', 'Content':'User Password'},

    { 'Title':'HomeContent', 'Content':'Home Content'},
    { 'Title':'LoginContent', 'Content':'Login Content'},
  ];

  // vars for Simplified Chinese
  static const listStrings_SC = [
    // General
    { 'Title':'Home', 'Content':'首页'},
    { 'Title':'Login', 'Content':'登录'},
    { 'Title':'LoginFailed', 'Content':'登入失败'},
    { 'Title':'LoginSuccess', 'Content':'登入成功'},
    { 'Title':'NetworkConnected', 'Content':'已连接网络'},
    { 'Title':'NetworkDisconnected', 'Content':'网络已断开'},
    { 'Title':'SelectLanguage', 'Content':'选择语言'},
    { 'Title':'Settings', 'Content':'设置'},
    { 'Title':'UserID', 'Content':'账户ID'},
    { 'Title':'UserPW', 'Content':'账户密碼'},

    { 'Title':'HomeContent', 'Content':'首页内容'},
    { 'Title':'LoginContent', 'Content':'登录页内容'},
  ];

  // vars for Traditional Chinese
  static const listStrings_TC = [
    // General
    { 'Title':'Home', 'Content':'首頁'},
    { 'Title':'Login', 'Content':'登錄'},
    { 'Title':'LoginFailed', 'Content':'登入失敗'},
    { 'Title':'LoginSuccess', 'Content':'登入成功'},
    { 'Title':'NetworkConnected', 'Content':'已連接網絡'},
    { 'Title':'NetworkDisconnected', 'Content':'網絡已斷開'},
    { 'Title':'SelectLanguage', 'Content':'選擇語言'},
    { 'Title':'Settings', 'Content':'設置'},
    { 'Title':'UserID', 'Content':'賬戶ID'},
    { 'Title':'UserPW', 'Content':'賬戶密碼'},

    { 'Title':'HomeContent', 'Content':'首頁內容'},
    { 'Title':'LoginContent', 'Content':'登錄頁內容'},
  ];

  // To set Current Language
  static void setLang(strLangParm) {
    if (strLangParm == '') {
      strLang = 'EN';
    } else {
      strLang = strLangParm;
    }
  }

  // Get a string by 'Title', and return 'Content',
  // According to the Current Language strLang
  static String gs(strKey) {
    switch (strLang) {
      case 'EN':
        for (var i=0; i< listStrings_EN.length; i++) {
          if (listStrings_EN[i]['Title'] == strKey) {
            return listStrings_EN[i]['Content'];
          }
        }
        return '';
      case 'SC':
        for (var i=0; i< listStrings_SC.length; i++) {
          if (listStrings_SC[i]['Title'] == strKey) {
            return listStrings_SC[i]['Content'];
          }
        }
        return '';
      case 'TC':
        for (var i=0; i< listStrings_TC.length; i++) {
          if (listStrings_TC[i]['Title'] == strKey) {
            return listStrings_TC[i]['Content'];
          }
        }
        return '';
    }
  }
}
