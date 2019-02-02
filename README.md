# fluttertemplate02

Including all features of fluttertemplate01, as well as:

1. socket.io

2. Register / Login / Forget Password / Change Password / Activate Account / Change Personal Information etc......

3. Redux State Management

4. 'Page Loading Circular Progress' using Modal_Progress_Hud

5. 


## Installation Instruction

Install according to the README OF https://github.com/lhcdims/fluttertemplate01

And:

1. Install mysql, node.js, express, socket.io, nodemailer in your Linux Server

2. In your mysql server, create a database, then create a table named 'userid', with the following fields:

- usr_id (varchar 20, primary key, User ID)
- usr_nick (varchar 20, Nick Name)
- usr_pw (varchar 20, Password)
- usr_email (varchar 100, Email Address)
- usr_joindt (datetime, Join Date & Time)
- usr_status (char 1, Status: 'A' - Waiting for Activation, 'E' - Enabled/Activated)
- usr_confirmcode (varchar 10, a random generated Activation Code)
- usr_picture (mediumtext, used for storing User Picture in base64)

3. Make sure you get packages listed in pubspec.yaml

4. copy the app.js in the nodejs directory to your Linux Server's nodejs project directory.

5. create a file mysqlpw.txt in your Linux Server's nodejs project directory, this file contains only 1 line, which save your mysql password.

6. create a file infoATzephan.top.txt (or other file name you like) in your Linux Server's nodejs project directory, this file contains only 1 line, which save your 'SEND EMAIL' password.  (An Activation Email will be sent on behalf of you, to the user who want to register your App)

7. Run "node app.js" in your Linux server.

8. Run this Flutter Project in Android Studio using emulator or device.