import 'dart:convert';

import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/dbHelper.dart';
import 'package:pas_mobile_11pplg2_10/model/tv_show_model.dart';
import 'package:pas_mobile_11pplg2_10/pages/show_page.dart';
import 'package:pas_mobile_11pplg2_10/services/baseUrl.dart';
import 'package:http/http.dart' as http;

class TvShowController extends GetxController {
  var isLoading = true.obs;
  var showList = <TvShowModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTvShow();
  }

  Future<void> fetchTvShow() async {
    final url = Uri.parse('${Baseurl.tvShows}/shows');

    try {
      isLoading.value = true;

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List tvShowData = data;
        showList.assignAll(
          tvShowData.map((e) => TvShowModel.fromJson(e)).toList(),
        );
      } else {
        Get.snackbar(
          'Error',
          'Gagal mengambil data produk: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data produk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchTvShow();
  }

  final db = DBHelper();
  void markFavoriteShow(int i) async {
    final findShow = showList[i];
    print("Data Product : ${findShow}");

    await db.markShow({
      'image': findShow.image,
      'name': findShow.name.toString(),
      'genres': findShow.genres,
      'language': findShow.language.toString(),
      'rating': findShow.rating.toString(),
    });

    Get.snackbar(
      'Product Pages',
      'Product Berhasil Di Bookmark',
      duration: Duration(seconds: 1),
    );
    fetchTvShow();
  }
  var productMark = <TvShowModel>[].obs;

  void fetchMarkProduct() async {
    final mapList = await db.getMarkShow();

    final list = mapList.map((row) => TvShowModel.fromJson(row)).toList();

    productMark.assignAll(list);

    print("Data Marked: $productMark");
  }

  void deleteMarkProduct(int i) async {
    final product = productMark[i];

    await db.deleteShow(product.id);

    Get.snackbar(
      'Product Pages',
      'Product Berhasil Di Hapus',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
    );

    fetchMarkProduct();
  }
}
