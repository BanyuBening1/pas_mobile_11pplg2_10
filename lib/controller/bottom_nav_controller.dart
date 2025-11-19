import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/show_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/profile_page.dart';

class BottomNavController extends GetxController{
  var selectedIndex = 0.obs;

  final pages = [ShowPage(), BookmarkPage(), ProfilePage()];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}