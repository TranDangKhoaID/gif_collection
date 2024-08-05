import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tikimon_collection/common/configs.dart';
import 'package:tikimon_collection/common/dialog_helper.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/my_tag_model.dart';
import 'package:tikimon_collection/models/tag_background_model.dart';
import 'package:tikimon_collection/models/tag_model.dart';
import 'package:tikimon_collection/repositories/data_repository.dart';
import 'package:tikimon_collection/repositories/supabase_repository.dart';
import 'package:tikimon_collection/service/database/my_tag_db.dart';
import 'package:tikimon_collection/storage/app_preference.dart';

class GachaController extends GetxController {
  final _appPref = locator<AppPreference>();
  //
  final dataRepository = locator<DataRepository>();
  final supabaseRepository = locator<SupabaseRepository>();
  //
  final supabase = Supabase.instance.client;
  //List<TagModel> tags = [];
  //db
  final myTagDB = MyTagDB();
  //var uuid = const Uuid();

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  Future<List<TagModel>> getTagsDB() async {
    try {
      return await supabaseRepository.getTags();
    } catch (e) {
      debugPrint('Get tags error: $e');
      throw Exception(e.toString());
    }
  }

  // Future<List<TagModel>> getTags() async {
  //   try {
  //     return await dataRepository.getTags();
  //   } catch (e) {
  //     debugPrint('Get tags error: $e');
  //     throw Exception(e.toString());
  //   }
  // }

  Future<List<TagBackgroundModel>> getTagsBackground() async {
    try {
      return await dataRepository.getTagsBackground();
    } catch (e) {
      debugPrint('Get tags background error: $e');
      throw Exception(e.toString());
    }
  }

  Future<void> buyTag(TagModel tag) async {
    EasyLoading.show();
    try {
      supabaseRepository.buyTag(tag);
      //supabaseRepository.getTags();
      Get.back();
    } catch (e) {
      debugPrint('buy tag error ==> $e');
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  // Hàm lấy đối tượng ngẫu nhiên từ danh sách
  TagModel getRandomTag(List<TagModel> tags) {
    final random = Random();
    int index = random.nextInt(tags.length);
    return tags[index];
  }
}
