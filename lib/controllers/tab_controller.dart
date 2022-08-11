import 'package:get/get.dart';

class TabController extends GetxController {
  RxInt index = 0.obs;
  RxString title = 'Mwen Profil'.obs;

  void changeIndex(int index) {
    this.index.value = index;
    changeTitle(index);
  }

  void changeTitle(int index) {
    switch (index) {
      case 0:
        title.value = 'Mwen Profil';
        break;
      case 1:
        title.value = 'Pale';
        break;
      case 2:
        title.value = 'Resous';
        break;
      case 3:
        title.value = 'Diskisyon';
        break;
      default:
        title.value = 'Mwen';
    }
  }
}
