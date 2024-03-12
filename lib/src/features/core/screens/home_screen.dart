import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _recipiter = '';
  String _subject = '';
  String _body = '';

  Future<void> _sendEmail() async {
    // String username = 'xuancanhit99@gmail.com';
    // String password = '';
    // final smtpServer = gmail(username, password);

    // String username = 'xuancanhit99@yandex.ru';
    // String password = '';
    // final smtpServer = yandex(username, password);

    // String username = 'xuancanhit99@mail.ru';
    // String password = '';
    // final smtpServer = SmtpServer('smtp.mail.ru',
    //     username: username, password: password, port: 465, ssl: true);


    final message = Message()
      ..from = Address(username, 'Vu Xuan Canh')
      ..recipients.add(_recipiter)
      ..subject = _subject
      ..text = _body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender's Name
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: 'Senders\'s name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter sender\'s name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Server
                  TextFormField(
                    // controller: controller.groupController,
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(
                        BottomSheet(
                          onClosing: () {},
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: instituteController.groups.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(instituteController.groups[index]),
                                onTap: () {
                                  controller.groupController.text =
                                  instituteController.groups[index];
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                        label: Text(LanguageService.cGroup),
                        prefixIcon: const Icon(Icons.class_outlined)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please choose your group';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  // Sender's Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.outbox),
                      labelText: 'Senders\'s mail',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter sender\' email';
                      } else if (!EmailValidator.validate(value, true)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Sender's Password
                  TextFormField(
                    keyboardType:  TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outlined),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Recipient's Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      labelText: 'Recipient\'s Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter recipient\' email';
                      } else if (!EmailValidator.validate(value, true)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _recipiter = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Subject
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.subject),
                      labelText: 'Subject',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subject';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _subject = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Message
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.border_color),
                      labelText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _body = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _sendEmail();
                        }
                      },
                      child: const Text('Send'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
