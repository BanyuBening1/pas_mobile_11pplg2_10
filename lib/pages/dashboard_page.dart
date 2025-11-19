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

  final List<String> pageTitles = const ["Daftar Produk", "Favorit", "Profil"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Obx(
          () => Text(
            pageTitles[controller.selectedIndex.value],
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      ),

      // Body
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: IndexedStack(
            key: ValueKey(controller.selectedIndex.value),
            index: controller.selectedIndex.value,
            children: pages,
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.grey.shade500,
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_rounded),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_rounded),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
