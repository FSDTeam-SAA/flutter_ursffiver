// import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
// import 'package:get/get.dart';

// class InterestController extends GetxController {
//   final RxSet<String> selectedInterests = RxSet<String>();
//   final RxMap<String, List<InterestModel>> groups =
//       RxMap<String, List<InterestModel>>();
//   final RxString searchQuery = ''.obs;
//   final RxString error = RxString('');

//   @override
//   void onInit() {
//     super.onInit();
//     groups.value = {
//       'Custom': [
//         InterestModel(
//           id: '1',
//           name: 'Custom Interest 1',
//           color: InterestColor.red,
//         ),
//         InterestModel(
//           id: '2',
//           name: 'Custom Interest 2',
//           color: InterestColor.blue,
//         ),
//       ],
//       'Trending': [
//         InterestModel(
//           id: '3',
//           name: 'Social Activities',
//           color: InterestColor.yellow,
//         ),
//         InterestModel(
//           id: '4',
//           name: 'Pick-up Sports',
//           color: InterestColor.green,
//         ),
//       ],
//     };
//   }

//   void toggleInterest(String interestId) {
//     if (selectedInterests.contains(interestId)) {
//       selectedInterests.remove(interestId);
//     } else if (selectedInterests.length < 15) {
//       selectedInterests.add(interestId);
//     }
//   }

//   void addCustomInterest(String name, String description, InterestColor color) {
//     final newInterest = InterestModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: name,
//       color: color,
//     );

//     final customList = groups['Custom'] ?? [];
//     groups['Custom'] = [...customList, newInterest];

//     if (selectedInterests.length < 15) {
//       selectedInterests.add(newInterest.id);
//     }
//   }

//   List<InterestModel> getFilteredInterests(String category) {
//     final query = searchQuery.value.trim().toLowerCase();
//     return groups[category]
//             ?.where(
//               (interest) =>
//                   query.isEmpty || interest.name.toLowerCase().contains(query),
//             )
//             .toList() ??
//         [];
//   }
// }