import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyTabBar({
    required Key key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Login',
        ),
      ],
    );
  }
}
