import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/features/home/controller/filter_people_suggestion_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  final FilterPeopleSuggestionController filterPeopleSuggestionController = FilterPeopleSuggestionController();
  final InterestSelectionController interestSelectionController = InterestSelectionController();
}