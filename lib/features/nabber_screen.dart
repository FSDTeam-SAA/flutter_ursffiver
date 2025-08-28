import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/profile_screen.dart';

import '../core/theme/app_colors.dart';
import 'home/presentation/screen/home_screen.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Scaffold (),
    Scaffold(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: const Color(0xFF084C2E),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final icons = [
              Icons.home_filled,
              Icons.calendar_today_outlined,
              Icons.chat_bubble_outline,
              Icons.person_outline,
            ];
    
            final isSelected = _currentIndex == index;
    
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = index),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.transparent : Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icons[index],
                      size: 32,
                      color: isSelected ? AppColors.primarybutton : Colors.white,
                    ),
                    const SizedBox(height: 6),
                    // Animated underline indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: isSelected ? 40 : 0,
                      decoration: BoxDecoration(
                        color: AppColors.primarybutton,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
