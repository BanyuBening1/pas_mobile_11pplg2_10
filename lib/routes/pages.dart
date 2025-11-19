import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pas_mobile_11pplg2_10/binding/app_binding.dart';
import 'package:pas_mobile_11pplg2_10/binding/auth_binding.dart';
import 'package:pas_mobile_11pplg2_10/binding/bottom_nav_binding.dart';
import 'package:pas_mobile_11pplg2_10/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/dashboard_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/login_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/register_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/show_page.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.loginPage, page: () => LoginPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.registPage, page: () => RegistPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.dashboardPage, page: () => DashboardPage(), binding: BottomNavBinding()),
    GetPage(name: AppRoutes.showPage, page: () => ShowPage(), binding: AppBinding()),
    GetPage(name: AppRoutes.bookmarkPage, page: () => BookmarkPage(), binding: AppBinding()),
  ];
}
