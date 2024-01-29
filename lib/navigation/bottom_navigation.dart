import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:restaurant_app/navigation/screen_index.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, required this.initialIndex});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenIndex().elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 5,
          activeColor: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: HexColor('F64363'),
          color: HexColor('F64363'),
          tabs: [
            const GButton(
              icon: Icons.home_rounded,
              text: 'Home',
            ),
            GButton(
              onPressed: () {
                // ignore: unused_result
                ref.refresh(favoriteRestaurantsProvider);
              },
              icon: CupertinoIcons.heart_fill,
              text: 'Favorites',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
