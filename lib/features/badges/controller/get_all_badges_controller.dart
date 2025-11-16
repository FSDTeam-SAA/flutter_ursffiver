import 'package:get/get.dart';
import '../model/badge_model.dart';

class GiveBadgesController extends GetxController {
  final badges = <BadgeModel>[
    BadgeModel(
      id: "1",
      name: "Great Listener",
      tag: "listener",
      info: "Listens with attention and care",
      color: "indigo",
    ),
    BadgeModel(
      id: "2",
      name: "Thoughtful Questions",
      tag: "questions",
      info: "Asks meaningful questions",
      color: "pink",
    ),
    BadgeModel(
      id: "3",
      name: "Knowledge Sharer",
      tag: "sharer",
      info: "Shares valuable insights",
      color: "#00C853",
    ),
    BadgeModel(
      id: "4",
      name: "Local Expert",
      tag: "local",
      info: "Knows great local spots",
      color: "orange",
    ),
    BadgeModel(
      id: "5",
      name: "Reliable",
      tag: "reliable",
      info: "Always follows through",
      color: "lightblue",
    ),
    BadgeModel(
      id: "6",
      name: "Respectful",
      tag: "respect",
      info: "Mindful of boundaries",
      color: "purple",
    ),
    BadgeModel(
      id: "7",
      name: "Community Builder",
      tag: "builder",
      info: "Creates positive social connections",
      color: "red",
    ),
    BadgeModel(
      id: "8",
      name: "Connector",
      tag: "connector",
      info: "Introduces people who should meet",
      color: "teal",
    ),
  ].obs;
}
