import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:get/get.dart';

class GetAllBadgesController extends GetxController {
  RxList<BadgeModel> badges = <BadgeModel>[].obs;

  /// selected badge id
  RxString selectedBadgeId = "".obs;

  void selectBadge(String id) {
    selectedBadgeId.value = id;
  }

  @override
  void onInit() {
    super.onInit();
    loadDummyBadges();
  }

  void loadDummyBadges() {
    badges.value = [
      BadgeModel(
        id: "1",
        name: "goodspeaker",
        tag: "helpful",
        info: "Awarded for consistently helping other users.",
        color: "blue",
      ),
      BadgeModel(
        id: "2",
        name: "good speaker",
        tag: "seller",
        info: "For achieving high monthly sales.",
        color: "green",
      ),
      BadgeModel(
        id: "3",
        name: "Fast Responder",
        tag: "response",
        info: "For replying quickly and consistently.",
        color: "orange",
      ),
      BadgeModel(
        id: "4",
        name: "great lisaner",
        tag: "leader",
        info: "Recognized for exceptional leadership.",
        color: "red",
      ),
      BadgeModel(
        id: "5",
        name: "top seller",
        tag: "seller",
        info: "For achieving high monthly sales.",
        color: "green",
      ),
      BadgeModel(
        id: "6",
        name: "verified",
        tag: "response",
        info: "For replying quickly and consistently.",
        color: "orange",
      ),
      BadgeModel(
        id: "7",
        name: "creative",
        tag: "leader",
        info: "Recognized for exceptional leadership.",
        color: "red",
      ),
    ];
  }
}
