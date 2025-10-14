import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:get/get.dart';
import '../../features/auth/service/auth_interface_impl.dart';

void initInterfaces() {
  // Initialize other interfaces here
  Get.lazyPut<AuthInterface>(()=> AuthInterfaceImpl(Get.find()));
  
}