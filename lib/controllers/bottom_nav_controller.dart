import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavController extends GetxController {
  var bottomNavCurrentIndex = 0;

  void navBarChange(value) {
    bottomNavCurrentIndex = value;
    update();
  }
}
