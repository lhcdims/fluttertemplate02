// This file contains ALL Strings in ALL Languages
// import 'LangStrings.dart' in order to use it
// To add other languages, you have to
// 1. Include another element in listLang
// 2. Create another static const listStrings_XX, in which XX is the language code defined by YOU
// 3. Modify the function gs()


import 'GlobalVariables.dart';

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
    { 'Title':'AccountDisabled', 'Content':'Account Disabled: Pls. contact us'},
    { 'Title':'Activate', 'Content':'Activate'},
    { 'Title':'ActivateAccount', 'Content':'Activate Account'},
    { 'Title':'ActivateAlready', 'Content':'Activate has been activated before'},
    { 'Title':'ActivateError', 'Content':'Activation Code is not correct'},
    { 'Title':'ActivateErrorTimeout', 'Content':'Activation Failed: Timeout, pls. try again later'},
    { 'Title':'ActivateSuccess', 'Content':'Activate Success'},
    { 'Title':'ActivationCode', 'Content':'Activation Code'},
    { 'Title':'ActivationCodeWarning', 'Content':'Activation Email might be inside TRASH BIN'},
    { 'Title':'ActivationEmailSent', 'Content':'Activation Email Sent'},
    { 'Title':'AreYouSure', 'Content':'Are You Sure'},
    { 'Title':'Change', 'Content':'Change'},
    { 'Title':'ChangeEmailNeedActivateAgain', 'Content':'Need to Re-Activate if email is changed'},
    { 'Title':'ChangePassword', 'Content':'Change Password'},
    { 'Title':'EmailAddress', 'Content':'Email Address'},
    { 'Title':'EmailAddressFormatError', 'Content':'Email Address is not in the correct format'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'An Activation Code will be sent to you via Email'},
    { 'Title':'EmailChangedNeedActivateAgain', 'Content':'Email Changed, you need to activate again'},
    { 'Title':'EmailNotFound', 'Content':'Email Not Found'},
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
    { 'Title':'PasswordChanged', 'Content':'Password Changed'},
    { 'Title':'PasswordNew', 'Content':'New Password'},
    { 'Title':'PasswordOld', 'Content':'Old Password'},
    { 'Title':'PersonalInformation', 'Content':'Personal Information'},
    { 'Title':'PersonalInformationChanged', 'Content':'Personal Information Changed'},
    { 'Title':'PlsCheckEmailForIDAndPasword', 'Content':'Pls. check Eamil for ID and Password'},
    { 'Title':'Register', 'Content':'Register'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'Confirm Password must be the same as Password'},
    { 'Title':'RegisterErrorSystem', 'Content':'Register Failed: System Error, pls. try again later'},
    { 'Title':'RegisterErrorTimeout', 'Content':'Register Failed: Timeout'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'Register Failed: User ID already exist'},
    { 'Title':'RegisterSuccess', 'Content':'Register Success, pls. check your Activation Email'},
    { 'Title':'NetworkConnected', 'Content':'Network Connected'},
    { 'Title':'NetworkDisconnected', 'Content':'Network Disonnected'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'Network Disonnected, try again later'},
    { 'Title':'No', 'Content':'No'},
    { 'Title':'NothingChanged', 'Content':'Nothing Changed'},
    { 'Title':'OldPasswordCannotBeTheSameAsNewPassword', 'Content':'Old Password cannot be the same as New Password'},
    { 'Title':'OldPasswordIsNotCorrect', 'Content':'Old Password is not correct'},
    { 'Title':'SelectLanguage', 'Content':'Select Language'},
    { 'Title':'Send', 'Content':'Send'},
    { 'Title':'SendActivationEmailAgain', 'Content':'Send Activation Email Again'},
    { 'Title':'Settings', 'Content':'Settings'},
    { 'Title':'SystemError', 'Content':'System Error: Pls. try again later'},
    { 'Title':'TimeoutError', 'Content':'Timeout Error: Pls. try again later'},
    { 'Title':'UserID', 'Content':'User ID'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'User ID should be between ' + gv.intDefUserIDMinLen.toString() + ' and ' + gv.intDefUserIDMaxLen.toString() + ' bytes'},
    { 'Title':'UserNick', 'Content':'Nick Name'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'Nick Name should be between ' + gv.intDefUserNickMinLen.toString() + ' and ' + gv.intDefUserNickMaxLen.toString() + ' bytes'},
    { 'Title':'UserPW', 'Content':'User Password'},
    { 'Title':'UserPWConfirm', 'Content':'Confirm Password'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'User Password should be between ' + gv.intDefUserPWMinLen.toString() + ' and ' + gv.intDefUserPWMaxLen.toString() + ' bytes'},
    { 'Title':'Yes', 'Content':'Yes'},

    { 'Title':'HomeContent', 'Content':'Home Content'},
  ];

  // vars for Simplified Chinese
  static var listStrings_SC = [
    // General
    { 'Title':'AccountDisabled', 'Content':'账户已被冻结，请联系我们'},
    { 'Title':'Activate', 'Content':'激活'},
    { 'Title':'ActivateAccount', 'Content':'激活账户'},
    { 'Title':'ActivateAlready', 'Content':'账户之前已经激活成功'},
    { 'Title':'ActivateError', 'Content':'激活码不正确'},
    { 'Title':'ActivateErrorTimeout', 'Content':'激活失败：超时，请稍后再试'},
    { 'Title':'ActivateSuccess', 'Content':'账户激活成功'},
    { 'Title':'ActivationCode', 'Content':'激活码'},
    { 'Title':'ActivationCodeWarning', 'Content':'激活电邮可能在垃圾邮箱里'},
    { 'Title':'ActivationEmailSent', 'Content':'已发生激活电邮'},
    { 'Title':'AreYouSure', 'Content':'确定吗'},
    { 'Title':'Change', 'Content':'更改'},
    { 'Title':'ChangeEmailNeedActivateAgain', 'Content':'若更改电邮需要重新激活账户'},
    { 'Title':'ChangePassword', 'Content':'更改密码'},
    { 'Title':'EmailAddress', 'Content':'电邮地址'},
    { 'Title':'EmailAddressFormatError', 'Content':'电邮地址格式不正确'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'激活码将会透过电邮发送给您'},
    { 'Title':'EmailChangedNeedActivateAgain', 'Content':'已更改电邮，您需要重新激活账户'},
    { 'Title':'EmailNotFound', 'Content':'电邮地址不存在'},
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
    { 'Title':'PasswordChanged', 'Content':'密码已更改'},
    { 'Title':'PasswordNew', 'Content':'新密码'},
    { 'Title':'PasswordOld', 'Content':'旧密码'},
    { 'Title':'PersonalInformation', 'Content':'个人资料'},
    { 'Title':'PersonalInformationChanged', 'Content':'个人资料已更改'},
    { 'Title':'PlsCheckEmailForIDAndPasword', 'Content':'账号及密码已发送到您的电邮'},
    { 'Title':'Register', 'Content':'注册'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'确认密码必须和密码一样'},
    { 'Title':'RegisterErrorSystem', 'Content':'注册失败：系统错误，请稍后再试'},
    { 'Title':'RegisterErrorTimeout', 'Content':'注册失败：超时'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'注册失败：账号已存在'},
    { 'Title':'RegisterSuccess', 'Content':'注册成功，请检查激活电邮'},
    { 'Title':'NetworkConnected', 'Content':'已连接网络'},
    { 'Title':'NetworkDisconnected', 'Content':'网络已断开'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'网络已断开，请稍后再试'},
    { 'Title':'No', 'Content':'否'},
    { 'Title':'NothingChanged', 'Content':'没有任何改变'},
    { 'Title':'OldPasswordCannotBeTheSameAsNewPassword', 'Content':'旧密码不能和新密码一样'},
    { 'Title':'OldPasswordIsNotCorrect', 'Content':'旧密码不正确'},
    { 'Title':'SelectLanguage', 'Content':'选择语言'},
    { 'Title':'Send', 'Content':'发送'},
    { 'Title':'SendActivationEmailAgain', 'Content':'重新发送激活电邮'},
    { 'Title':'Settings', 'Content':'设置'},
    { 'Title':'SystemError', 'Content':'系统错误，请稍后再试'},
    { 'Title':'TimeoutError', 'Content':'超时错误，请稍后再试'},
    { 'Title':'UserID', 'Content':'账号'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'账号 应在 ' + gv.intDefUserIDMinLen.toString() + ' 至 ' + gv.intDefUserIDMaxLen.toString() + ' 位元以内'},
    { 'Title':'UserNick', 'Content':'账户昵称'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'账户昵称 应在 ' + gv.intDefUserNickMinLen.toString() + ' 至 ' + gv.intDefUserNickMaxLen.toString() + ' 位元以内'},
    { 'Title':'UserPW', 'Content':'账户密碼'},
    { 'Title':'UserPWConfirm', 'Content':'确认密码'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'账户密码 应在 ' + gv.intDefUserPWMinLen.toString() + ' 至 ' + gv.intDefUserPWMaxLen.toString() + ' 位元以内'},
    { 'Title':'Yes', 'Content':'是'},

    { 'Title':'HomeContent', 'Content':'首页内容'},
  ];

  // vars for Traditional Chinese
  static var listStrings_TC = [
    // General
    { 'Title':'AccountDisabled', 'Content':'賬戶已被凍結，請聯繫我們'},
    { 'Title':'Activate', 'Content':'激活'},
    { 'Title':'ActivateAccount', 'Content':'激活賬戶'},
    { 'Title':'ActivateAlready', 'Content':'賬戶之前已經激活成功'},
    { 'Title':'ActivateError', 'Content':'激活碼不正確'},
    { 'Title':'ActivateErrorTimeout', 'Content':'激活失敗：超時，請稍後再試'},
    { 'Title':'ActivateSuccess', 'Content':'賬戶激活成功'},
    { 'Title':'ActivationCode', 'Content':'激活碼'},
    { 'Title':'ActivationCodeWarning', 'Content':'激活電郵可能在垃圾郵箱裏'},
    { 'Title':'ActivationEmailSent', 'Content':'已發送激活電郵'},
    { 'Title':'AreYouSure', 'Content':'確定嗎'},
    { 'Title':'Change', 'Content':'更改'},
    { 'Title':'ChangeEmailNeedActivateAgain', 'Content':'若更改電郵需要重新激活賬戶'},
    { 'Title':'ChangePassword', 'Content':'更改密碼'},
    { 'Title':'EmailAddress', 'Content':'電郵地址'},
    { 'Title':'EmailAddressFormatError', 'Content':'電郵地址格式不正確'},
    { 'Title':'EmailAddressRegisterWarning', 'Content':'激活碼將會透過電郵發送給您'},
    { 'Title':'EmailChangedNeedActivateAgain', 'Content':'已更改電郵，您需要重新激活賬戶'},
    { 'Title':'EmailNotFound', 'Content':'電郵地址不存在'},
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
    { 'Title':'PasswordChanged', 'Content':'密碼已更改'},
    { 'Title':'PasswordNew', 'Content':'新密碼'},
    { 'Title':'PasswordOld', 'Content':'舊密碼'},
    { 'Title':'PersonalInformation', 'Content':'個人資料'},
    { 'Title':'PersonalInformationChanged', 'Content':'個人資料已更改'},
    { 'Title':'PlsCheckEmailForIDAndPasword', 'Content':'賬號及密碼已發送到您的電郵'},
    { 'Title':'Register', 'Content':'註冊'},
    { 'Title':'RegisterErrorConfirmPassword', 'Content':'確認密碼必須和密碼一樣'},
    { 'Title':'RegisterErrorSystem', 'Content':'註冊失敗：系統錯誤，請稍後再試'},
    { 'Title':'RegisterErrorTimeout', 'Content':'註冊失敗：超時'},
    { 'Title':'RegisterErrorUserIDExist', 'Content':'註冊失敗：賬號已存在'},
    { 'Title':'RegisterSuccess', 'Content':'註冊成功，請檢查激活電郵'},
    { 'Title':'NetworkConnected', 'Content':'已連接網絡'},
    { 'Title':'NetworkDisconnected', 'Content':'網絡已斷開'},
    { 'Title':'NetworkDisconnectedTryLater', 'Content':'網絡已斷開，請稍後再試'},
    { 'Title':'No', 'Content':'否'},
    { 'Title':'NothingChanged', 'Content':'沒有任何改變'},
    { 'Title':'OldPasswordCannotBeTheSameAsNewPassword', 'Content':'舊密碼不能和新密碼一樣'},
    { 'Title':'OldPasswordIsNotCorrect', 'Content':'舊密碼不正確'},
    { 'Title':'SelectLanguage', 'Content':'選擇語言'},
    { 'Title':'Send', 'Content':'發送'},
    { 'Title':'SendActivationEmailAgain', 'Content':'重新發送激活電郵'},
    { 'Title':'Settings', 'Content':'設置'},
    { 'Title':'SystemError', 'Content':'系統錯誤，請稍後再試'},
    { 'Title':'TimeoutError', 'Content':'超時錯誤，請稍後再試'},
    { 'Title':'UserID', 'Content':'賬號'},
    { 'Title':'UserIDErrorMinMaxLen', 'Content':'賬號 應在 ' + gv.intDefUserIDMinLen.toString() + ' 至 ' + gv.intDefUserIDMaxLen.toString() + ' 位元以內'},
    { 'Title':'UserNick', 'Content':'賬戶暱稱'},
    { 'Title':'UserNickErrorMinMaxLen', 'Content':'賬號 應在 ' + gv.intDefUserNickMinLen.toString() + ' 至 ' + gv.intDefUserNickMaxLen.toString() + ' 位元以內'},
    { 'Title':'UserPW', 'Content':'賬戶密碼'},
    { 'Title':'UserPWConfirm', 'Content':'確認密碼'},
    { 'Title':'UserPWErrorMinMaxLen', 'Content':'賬戶密碼 應在' + gv.intDefUserPWMinLen.toString() + ' 至 ' + gv.intDefUserPWMaxLen.toString() + ' 位元以內'},
    { 'Title':'Yes', 'Content':'是'},

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
