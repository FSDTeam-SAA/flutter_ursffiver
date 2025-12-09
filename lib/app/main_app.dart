import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/controller/app_global_controllers.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../core/theme/app_colors.dart';
import '../features/badges/presentation/screen/badges_screen.dart';
import '../features/home/presentation/screen/home_screen.dart';
import '../features/inbox/controller/inbox_chat_data_provider.dart';
import '../features/inbox/presentation/screen/all_chat_screen.dart';
import '../features/profile/controller/profile_data_controller.dart';
import 'controller/home_controller.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin{
  late final TabController _controller;
  final appControllerInitializer = AppControllerInitializer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this);
      Get.put<AppControllerInitializer>(appControllerInitializer);
      appControllerInitializer.init();
    //Get.find<AppControllerInitializer>().inboxChatDataProvider.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          AllChatScreeen(),
          BadgesPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFECEDFD),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SafeArea(
          child: TabBar(
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            controller: _controller,
            tabs: [
              Tab(
                child: Icon(Icons.home_outlined),
              ),
              Tab(
                child: Icon(Icons.chat_bubble_outline), 
              ),
              Tab(
                child: Icon(Icons.emoji_events_outlined),
              ),
              Tab(
                child: Icon(Icons.person_outline),
              )
            ],
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: List.generate(4, (index) {
          //     final icons = [
          //       Icons.home_outlined,
          //       Icons.chat_bubble_outline,
          //       Icons.emoji_events_outlined,
          //       Icons.person_outline,
          //     ];
          
          //     final isSelected = _currentIndex == index;
          
          //     return GestureDetector(
          //       onTap: () {
          //         _controller.
          //       }
          //       child: Icon(
          //         icons[index],
          //         size: 28,
          //         color: isSelected ? AppColors.primarybutton : Colors.grey,
          //       ),
          //     );
          //   }),
          // ),
        ),
      ),
    );
  }
}
