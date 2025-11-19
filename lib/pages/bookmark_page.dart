import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pas_mobile_11pplg2_10/controller/tv_show_controller.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({super.key});

  final controller = Get.find<TvShowController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: controller.showList.length,
            itemBuilder: (context, index) {
              final show = controller.markFavoriteShow[index];
              return Card(
                child: Row(
                  children: [
                    Image.network(show.image.original, width: 120, height: 180),
                    Column(
                      children: [
                        Text(
                          "  " + show.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(" " + show.genres),
                        const SizedBox(height: 4),
                        Text("  " + show.rating),
                        const SizedBox(height: 4),
                        Text("  Language: " + show.language),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          onRefresh: () async {
            controller.fetchTvShow();
          },
        );
      }),
    );
  }
}
