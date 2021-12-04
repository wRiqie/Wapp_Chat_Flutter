import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/modules/conversas/conversas_controller.dart';

class ConversasPage extends GetView<ConversasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Center(
        ),
      ),
    );
  }
}
