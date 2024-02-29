import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/apis/FirebaseAuth/pwd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';


class FirebaseAuth {
  static var otp;

  static Future<String> sendOTP(String emailAddress) async{
    var otp1 = OTP.generateTOTPCodeString(
        'HTYU2SNIDNVKS32N', DateTime.now().millisecondsSinceEpoch,
        algorithm: Algorithm.SHA1, interval: 10);

    try{
      String username = 'niraj.kc.128@gmail.com';
      String password = pass;

      final smtpServer = gmail(username, password);


      // Create our message.
      final message = Message()
        ..from = Address(username, 'Niraj')
        ..recipients.add(emailAddress.toString())
        ..subject = 'OTP verification for CSI ${DateTime.now()}'
        ..text = 'Your OTP for verification is $otp1';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());

      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }

        return "Error sending OTP.";
      }
      // DONE


      var connection = PersistentConnection(smtpServer);
      await connection.send(message);
      await connection.close();
    }

    catch (e) {
      print("#error: $e");
      return "Unknown Error occurred";
    }

    otp = otp1;

    return "#opt: $otp1";
  }

  static String verifyOTP(String verifyOTP){
    if(otp == verifyOTP){
      return "Verified.";
    }
    else{
      return "Invalid OTP.";
    }
  }

  Future<String> register(String emailAddress, String password) async {
    try {
      final credential = FirebaseAPIs.auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return "Registered";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.code.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login (String emailAddress, String password) async {
    try {
      final credential = await FirebaseAPIs.auth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      return "Logged In";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      else {
        return e.code.toString();
      }
    }
  }


}

//
// main(){
//   FirebaseAuth.sendOTP("22bce209@nirmauni.ac.in");
// }