import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/badges/model/award_badges_to_user.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_request_param.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_response_model.dart';
import 'package:flutter_ursffiver/features/badges/model/give_badge.dart';

abstract base class BadgesInterface extends BaseRepository {
  FutureRequest<Success<GetMyBadgesResponseModel>> getMyBadges({
    required GetmyBadgesRequestParam param,
  });

  FutureRequest<Success> awardBadgestoUser({
    required AwardBadgesToUser param,
  });

  FutureRequest<Success> giveBadge({required GiveBadge param});

  FutureRequest<Success<List<BadgeModel>>> getAllBadges();

}
