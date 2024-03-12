import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendEmailController extends GetxController {
  static SendEmailController get instance => Get.find();

  final nameController = TextEditingController();
  final senderEmailController = TextEditingController();
  final senderPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  void sendEmail() {
    final String name = emailController.text;
    final String senderEmail = emailController.text;
    final String senderPassword = emailController.text;
    final String subject = subjectController.text;
    final String message = messageController.text;

    // Future<void> _sendEmail() async {
    //   String username = 'xuancanhit99@gmail.com';
    //   String password = '';
    //   final smtpServer = gmail(username, password);
    //
    //   // String username = 'xuancanhit99@yandex.ru';
    //   // String password = '';
    //   // final smtpServer = yandex(username, password);
    //
    //   // String username = 'xuancanhit99@mail.ru';
    //   // String password = '';
    //   // final smtpServer = SmtpServer('smtp.mail.ru',
    //   //     username: username, password: password, port: 465, ssl: true);
    //
    //
    //   final message = Message()
    //     ..from = Address(username, 'Vu Xuan Canh')
    //     ..recipients.add(_recipiter)
    //     ..subject = _subject
    //     ..text = _body;
    //
    //   try {
    //     final sendReport = await send(message, smtpServer);
    //     print('Message sent: ' + sendReport.toString());
    //   } on MailerException catch (e) {
    //     print('Message not sent.' + e.toString());
    //     for (var p in e.problems) {
    //       print('Problem: ${p.code}: ${p.msg}');
    //     }
    //   }
    // }
  }
}
