// import 'package:flutter/material.dart';
// class LabeledDoubleDropdownField extends StatelessWidget {
//   final String label1;
//   final String hint1;
//   final List<String> items1;
//   final String? value1;
//   final ValueChanged<String?> onChanged1;

//   final String label2;
//   final String hint2;
//   final List<String> items2;
//   final String? value2;
//   final ValueChanged<String?> onChanged2;

//   const LabeledDoubleDropdownField({
//     super.key,
//     required this.label1,
//     required this.hint1,
//     required this.items1,
//     required this.value1,
//     required this.onChanged1,
//     required this.label2,
//     required this.hint2,
//     required this.items2,
//     required this.value2,
//     required this.onChanged2,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label1, style: const TextStyle(fontWeight: FontWeight.w500)),
//               const SizedBox(height: 4),
//               DropdownButtonFormField<String>(
//                 value: value1,
//                 decoration: const InputDecoration(border: OutlineInputBorder()),
//                 hint: Text(hint1),
//                 items: items1
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                     .toList(),
//                 onChanged: onChanged1,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label2, style: const TextStyle(fontWeight: FontWeight.w500)),
//               const SizedBox(height: 4),
//               DropdownButtonFormField<String>(
//                 value: value2,
//                 decoration: const InputDecoration(border: OutlineInputBorder()),
//                 hint: Text(hint2),
//                 items: items2
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                     .toList(),
//                 onChanged: onChanged2,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
