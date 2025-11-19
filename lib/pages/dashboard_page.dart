import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/bottom_nav_controller.dart';
import 'package:pas_mobile_11pplg2_10/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/show_page.dart';
import 'package:pas_mobile_11pplg2_10/pages/profile_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.find<BottomNavController>();

  final List<Widget> pages = [ShowPage(), BookmarkPage(), ProfilePage()];

  final List<String> pageTitles = const ["Daftar Produk", "Favorit", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(pageTitles[controller.selectedIndex.value])),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () =>
            IndexedStack(index: controller.selectedIndex.value, children: pages),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.shopping_bag_rounded),
              label: 'Products',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
