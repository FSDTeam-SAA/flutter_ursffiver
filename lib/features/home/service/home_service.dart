import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';

 base class HomeService extends HomeInterface{
  @override
  FutureRequest<Success<List<UserModel>>> getSuggestions() {
    // TODO: implement getSuggestions
    throw UnimplementedError();
  }

  
}