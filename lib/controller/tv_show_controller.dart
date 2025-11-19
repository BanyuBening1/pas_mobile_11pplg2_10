import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg2_10/model/tv_show_model.dart';
import 'package:pas_mobile_11pplg2_10/services/baseUrl.dart';
import 'package:pas_mobile_11pplg2_10/dbHelper.dart';

class TvShowController extends GetxController {
  var isLoading = true.obs;
  var showList = <Tvshowmodel>[].obs;
  var showMark = <Tvshowmodel>[].obs;

  final db = DBHelper.instance;


  @override
  void onInit() {
    super.onInit();
    fetchTvShow();
    fetchMarkShow();
  }

  Future<void> fetchTvShow() async {
    final url = Uri.parse('${Baseurl.tvShows}/shows');
    try {
      isLoading.value = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        showList.assignAll(data.map((e) => Tvshowmodel.fromJson(e)).toList());
      } else {
        Get.snackbar('Error', 'Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async => fetchTvShow();

  Future<void> fetchMarkShow() async {
    final mapList = await db.getAllShow();
    final list = mapList.map((row) => Tvshowmodel.fromDb(row)).toList();
    showMark.assignAll(list);
  }

  Future<void> addMarkShow(Tvshowmodel show) async {
    final exists = await DBHelper.instance.isShowExists(show.id);

    if (exists) {
      Get.snackbar(
        "Bookmark",
        "Show sudah ada di bookmark",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    await DBHelper.instance.insertShow(show);

    Get.snackbar(
      "Bookmark",
      "Berhasil ditambahkan ke bookmark",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> deleteMarkShow(int id) async {
    await db.deleteShow(id);
    fetchMarkShow();
    Get.snackbar(
      "Bookmark",
      "Berhasil dihapus dari bookmark",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> toggleMark(Tvshowmodel show) async {
    final exist = showMark.any((e) => e.id == show.id);
    if (exist) {
      await deleteMarkShow(show.id);
    } else {
      await addMarkShow(show);
    }
  }
}
