import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/welcome/welcome_controller.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class WelcomePage extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(),
    );
  }
}
