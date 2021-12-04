import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/admin/admin_controller.dart';

class AdminPage extends GetView<AdminController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('AdminPage')),
    body: SafeArea(
      child: Text('AdminController'))
    );
  }
}