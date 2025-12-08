import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/profile_screen.dart';
import '../core/theme/app_colors.dart';
import 'badges/presentation/screen/badges_screen.dart';
import 'home/presentation/screen/home_screen.dart';
import 'inbox/presentation/screen/all_chat_screen.dart';

class AppGround extends StatefulWidget {
  const AppGround({super.key});

  @override
  State<AppGround> createState() => _AppGroundState();
}

class _AppGroundState extends State<AppGround> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AllChatScreeen(),
    const BadgesPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFECEDFD),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final icons = [
                Icons.home_outlined,
                Icons.chat_bubble_outline,
                Icons.emoji_events_outlined,
                Icons.person_outline,
              ];
          
              final isSelected = _currentIndex == index;
          
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                child: Icon(
                  icons[index],
                  size: 28,
                  color: isSelected ? AppColors.primarybutton : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
