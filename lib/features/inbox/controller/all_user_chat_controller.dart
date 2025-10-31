// import 'package:get/get.dart';
// import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
// import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
// import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

// class AllUserChatController extends GetxController {
//   var chats = <ChatData>[].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChats();
//     initSocket();
//   }

//   void initSocket() {
//     // Initialize your socket here if needed
//   }

//   Future<void> fetchChats() async {
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       final result =  await chatInterface.getAllChat();

//       chats.value = [
//         ChatData(
//           id: '1',
//           name: 'Leslie Alexander',
//           requestBy: 'user1',
//           ststus: 'active',
//           time: '4 Mar',
//           user: UserProfile(id: 'user1', firstname: 'Leslie Alexander', email: ''),
//           chatMessages: [
//             Message(
//               id: 'm1',
//               text: 'Respected Sir, I Peter, your com...',

//             ),
//           ],
//         ),
//         ChatData(
//           id: '2',
//           name: 'Bessie Cooper',
//           requestBy: 'user2',
//           ststus: 'active',
//           time: '4 Mar',
//           user: UserProfile(id: 'user2', firstname: 'Bessie Cooper', email: ''),
//           chatMessages: [
//             Message(
//               id: 'm2',
//               text: 'Respected Sir, I Peter, your com...',
//             ),
//           ],
//         ),
//       ];
//     } catch (e) {
//       Get.snackbar("Error", "Failed to load messages");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
