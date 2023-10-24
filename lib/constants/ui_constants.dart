import 'package:ace_flash/features/home/widgets/intro_page.dart';
import 'package:ace_flash/theme/theme.dart';
import 'package:flutter/material.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      backgroundColor: Pallete.blueColor,
      title: const Text(
        "AP Computer Science Flashcard",
        style: TextStyle(
          color: Pallete.blackColor, // Set the color of the banner text
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(
        size: 40, //change size on your need
        color: Pallete.whiteColor, //change color on your need
      ),
    );
  }

  static const List<Widget> bottomTabBarPages = [
    IntroPage(),
  ];
  // ExploreView(),
  // NotificationView(),
}
