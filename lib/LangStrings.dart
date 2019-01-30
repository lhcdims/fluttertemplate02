// This file contains ALL Strings in ALL Languages
// import 'LangStrings.dart' in order to use it
// To add other languages, you have to
// 1. Include another element in listLang
// 2. Create another static const listStrings_XX, in which XX is the language code defined by YOU
// 3. Modify the function gs()


import 'gv.dart';

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
  static var listStrings_EN = [
    // General
    { 'Title':'EmailAddress', 'Content':'Email Address'},
    { 'Title':'EmailAddressFormatError', 'Content':'Email Address is not in the correct format'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'An Activation Code will be sent to you via Email'},
    { 'Title':'ForgetPassword', 'Content':'Forget Password'},
    { 'Title':'Home', 'Content':'Home'},
    { 'Title':'Login', 'Content':'Login'},
    { 'Title':'LoginErrorLoginAgain', 'Content':'Login Failed: Pls. login again'},
    { 'Title':'LoginErrorReLogin', 'Content':'Another user login your account. Pls. login again'},
    { 'Title':'LoginErrorSystem', 'Content':'Login Failed: System Error, pls. try again later'},
    { 'Title':'LoginErrorTimeout', 'Content':'Login Failed: Timeout'},
    { 'Title':'LoginErrorUserIDPassword', 'Content':'Login Failed: User ID & Password does not match'},
    { 'Title':'LoginSuccess', 'Content':'Login Success'},
    { 'Title':'Logout', 'Content':'Logout'},
    { 'Title':'Register', 'Content':'Register'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'Confirm Password must be the same as Password'},
    { 'Title':'RegisterErrorSystem', 'Content':'Register Failed: System Error, pls. try again later'},
    { 'Title':'RegisterErrorTimeout', 'Content':'Register Failed: Timeout'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'Register Failed: User ID already exist'},
    { 'Title':'RegisterSuccess', 'Content':'Register Success, pls. check your Activation Email'},
    { 'Title':'NetworkConnected', 'Content':'Network Connected'},
    { 'Title':'NetworkDisconnected', 'Content':'Network Disonnected'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'Network Disonnected, try again later'},
    { 'Title':'SelectLanguage', 'Content':'Select Language'},
    { 'Title':'Settings', 'Content':'Settings'},
    { 'Title':'UserID', 'Content':'User ID'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'User ID should be between ' + gv.intDefUserIDMinLen.toString() + ' and ' + gv.intDefUserIDMaxLen.toString() + ' bytes'},
    { 'Title':'UserNick', 'Content':'Nick Name'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'Nick Name should be between ' + gv.intDefUserNickMinLen.toString() + ' and ' + gv.intDefUserNickMaxLen.toString() + ' bytes'},
    { 'Title':'UserPW', 'Content':'User Password'},
    { 'Title':'UserPWConfirm', 'Content':'Confirm Password'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'User Password should be between ' + gv.intDefUserPWMinLen.toString() + ' and ' + gv.intDefUserPWMaxLen.toString() + ' bytes'},

    { 'Title':'HomeContent', 'Content':'Home Content'},
  ];

  // vars for Simplified Chinese
  static var listStrings_SC = [
    // General
    { 'Title':'EmailAddress', 'Content':'电邮地址'},
    { 'Title':'EmailAddressFormatError', 'Content':'电邮地址格式不正确'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'激活码将会透过电邮发送给您'},
    { 'Title':'ForgetPassword', 'Content':'忘记密码'},
    { 'Title':'Home', 'Content':'首页'},
    { 'Title':'Login', 'Content':'登录'},
    { 'Title':'LoginErrorLoginAgain', 'Content':'登入失败：请重新登入'},
    { 'Title':'LoginErrorReLogin', 'Content':'另一用户登入了您的账户，请重新登入'},
    { 'Title':'LoginErrorSystem', 'Content':'登入失败：系统错误，请稍后再试'},
    { 'Title':'LoginErrorTimeout', 'Content':'登入失败：超时'},
    { 'Title':'LoginErrorUserIDPassword', 'Content':'登入失败：账号 及 密码不匹配'},
    { 'Title':'LoginSuccess', 'Content':'登入成功'},
    { 'Title':'Logout', 'Content':'登出'},
    { 'Title':'Register', 'Content':'注册'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'确认密码必须和密码一样'},
    { 'Title':'RegisterErrorSystem', 'Content':'注册失败：系统错误，请稍后再试'},
    { 'Title':'RegisterErrorTimeout', 'Content':'注册失败：超时'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'注册失败：账号已存在'},
    { 'Title':'RegisterSuccess', 'Content':'注册成功，请检查激活电邮'},
    { 'Title':'NetworkConnected', 'Content':'已连接网络'},
    { 'Title':'NetworkDisconnected', 'Content':'网络已断开'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'网络已断开，请稍后再试'},
    { 'Title':'SelectLanguage', 'Content':'选择语言'},
    { 'Title':'Settings', 'Content':'设置'},
    { 'Title':'UserID', 'Content':'账号'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'账号 应在 ' + gv.intDefUserIDMinLen.toString() + ' 至 ' + gv.intDefUserIDMaxLen.toString() + ' 位元以内'},
    { 'Title':'UserNick', 'Content':'账户昵称'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'账户昵称 应在 ' + gv.intDefUserNickMinLen.toString() + ' 至 ' + gv.intDefUserNickMaxLen.toString() + ' 位元以内'},
    { 'Title':'UserPW', 'Content':'账户密碼'},
    { 'Title':'UserPWConfirm', 'Content':'确认密码'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'账户密码 应在 ' + gv.intDefUserPWMinLen.toString() + ' 至 ' + gv.intDefUserPWMaxLen.toString() + ' 位元以内'},

    { 'Title':'HomeContent', 'Content':'首页内容'},
  ];

  // vars for Traditional Chinese
  static var listStrings_TC = [
    // General
    { 'Title':'EmailAddress', 'Content':'電郵地址'},
    { 'Title':'EmailAddressFormatError', 'Content':'電郵地址格式不正確'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'激活碼將會透過電郵發送給您'},
    { 'Title':'ForgetPassword', 'Content':'忘記密碼'},
    { 'Title':'Home', 'Content':'首頁'},
    { 'Title':'Login', 'Content':'登錄'},
    { 'Title':'LoginErrorLoginAgain', 'Content':'登入失敗：請重新登入'},
    { 'Title':'LoginErrorReLogin', 'Content':'另一用戶登入了您的賬戶，請重新登入'},
    { 'Title':'LoginErrorSystem', 'Content':'登入失敗：系統錯誤，請稍後再試'},
    { 'Title':'LoginErrorTimeout', 'Content':'登入失敗：超時'},
    { 'Title':'LoginErrorUserIDPassword', 'Content':'登入失敗：賬號 及 密碼不匹配'},
    { 'Title':'LoginSuccess', 'Content':'登入成功'},
    { 'Title':'Logout', 'Content':'登出'},
    { 'Title':'Register', 'Content':'註冊'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'確認密碼必須和密碼一樣'},
    { 'Title':'RegisterErrorSystem', 'Content':'註冊失敗：系統錯誤，請稍後再試'},
    { 'Title':'RegisterErrorTimeout', 'Content':'註冊失敗：超時'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'註冊失敗：賬號已存在'},
    { 'Title':'RegisterSuccess', 'Content':'註冊成功，請檢查激活電郵'},
    { 'Title':'NetworkConnected', 'Content':'已連接網絡'},
    { 'Title':'NetworkDisconnected', 'Content':'網絡已斷開'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'網絡已斷開，請稍後再試'},
    { 'Title':'SelectLanguage', 'Content':'選擇語言'},
    { 'Title':'Settings', 'Content':'設置'},
    { 'Title':'UserID', 'Content':'賬號'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'賬號 應在 ' + gv.intDefUserIDMinLen.toString() + ' 至 ' + gv.intDefUserIDMaxLen.toString() + ' 位元以內'},
    { 'Title':'UserNick', 'Content':'賬戶暱稱'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'賬號 應在 ' + gv.intDefUserNickMinLen.toString() + ' 至 ' + gv.intDefUserNickMaxLen.toString() + ' 位元以內'},
    { 'Title':'UserPW', 'Content':'賬戶密碼'},
    { 'Title':'UserPWConfirm', 'Content':'確認密碼'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'賬戶密碼 應在' + gv.intDefUserPWMinLen.toString() + ' 至 ' + gv.intDefUserPWMaxLen.toString() + ' 位元以內'},

    { 'Title':'HomeContent', 'Content':'首頁內容'},
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
