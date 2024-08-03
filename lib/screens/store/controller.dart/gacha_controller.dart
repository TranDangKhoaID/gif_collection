import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tikimon_collection/common/dialog_helper.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/tag_model.dart';
import 'package:tikimon_collection/repositories/data_repository.dart';
import 'package:tikimon_collection/widgets/shimmer_image.dart';

class GachaController extends GetxController {
  //
  final dataRepository = locator<DataRepository>();
  //
  final supabase = Supabase.instance.client;
  //List<TagModel> tags = [];

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<TagModel>> getTagsDB() async {
    try {
      final response = await supabase.from('tags').select('*');

      return (response as List<dynamic>)
          .map((json) => TagModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('Get tags error: $e');
      throw Exception(e.toString());
    }
  }

  Future<List<TagModel>> getTags() async {
    try {
      return await dataRepository.getTags();
    } catch (e) {
      debugPrint('Get tags error: $e');
      throw Exception(e.toString());
    }
  }

  // Hàm lấy đối tượng ngẫu nhiên từ danh sách
  TagModel getRandomTag(List<TagModel> tags) {
    final random = Random();
    int index = random.nextInt(tags.length);
    return tags[index];
  }
}
