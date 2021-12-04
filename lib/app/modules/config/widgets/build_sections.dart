import 'package:flutter/material.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';

Widget BuildSections(
    {required Icon icon, required String title, required VoidCallback func}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
    child: InkWell(
      onTap: func,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: primaryDark),
            child: icon
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 18, color: light,),
          ),
        ],
      ),
    ),
  );
}
