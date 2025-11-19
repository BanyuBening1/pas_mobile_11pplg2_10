import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/tv_show_controller.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TvShowController controller = Get.find<TvShowController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmark'), centerTitle: true),
      body: Obx(() {
        if (controller.showMark.isEmpty) {
          return const Center(child: Text('Belum ada bookmark'));
        }

        return ListView.builder(
          itemCount: controller.showMark.length,
          itemBuilder: (context, i) {
            final show = controller.showMark[i];

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network(
                  show.image.original,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
                title: Text(show.name),
                subtitle: Text(show.language.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteMarkShow(show.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
