import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:sarangi/screens/pages/home.dart';
import 'package:sarangi/screens/pages/profile.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  Widget? _child;

  @override
  void initState() {
    _child = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 224, 231),
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        // (1)
        icons: [
          FluidNavBarIcon(
              icon: Icons.home_filled,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.camera_alt,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              extras: {"label": "bookmark"}),
          FluidNavBarIcon(
              icon: Icons.person,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              extras: {"label": "bookmark"}),
        ],
        onChange: _handleNavigationChange, // (4)
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          _child = Container();
          break;
        case 2:
          _child = ProfilePage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
