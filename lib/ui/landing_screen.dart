import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:forge_alumnus_assignment/ui/courses/courses_screen.dart';
import 'package:forge_alumnus_assignment/ui/custom_widgets/theme_notifier.dart';
import 'package:forge_alumnus_assignment/ui/home/home_screen.dart';
import 'package:forge_alumnus_assignment/ui/profile/profile.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 1;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.deepPurple),
          Icon(Icons.book, color: Colors.deepPurple),
          Icon(Icons.account_circle_rounded, color: Colors.deepPurple),
        ],
        inactiveIcons: const [
          Text("Home"),
          Text("Courses"),
          Text("Profile"),
        ],
        color: context.watch<ThemeNotifier>().isDarkMode
            ? Colors.black
            : Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: const [
          HomeScreen(),
          CoursesScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
