import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/tv_show_controller.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TvShowController controller = Get.put(TvShowController());

    return Scaffold(
      appBar: AppBar(title: const Text("TV Shows"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.showList.isEmpty) {
          return const Center(child: Text('Tidak ada data'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.showList.length,
            itemBuilder: (context, i) {
              final show = controller.showList[i];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      show.image.original,
                      width: 70,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  title: Text(
                    show.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Language: ${show.language.name}"),
                        Text("Type: ${show.type.name}"),
                        Text("Rating: ${show.rating.average}"),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark_add, color: Colors.blue),
                    onPressed: () => controller.addMarkShow(show),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
