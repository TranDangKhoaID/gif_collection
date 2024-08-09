import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/repositories/firebase_repository.dart';
import 'package:gif_collection/repositories/supabase_repository.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';

class MyBagController extends GetxController {
  List<MyTagModel> list = [];
  final myTagDB = MyTagDB();

  final supabaseRepository = locator<SupabaseRepository>();
  final firebaseRepository = locator<FirebaseRepository>();

  @override
  void onReady() {
    super.onReady();
    //fetchTags();
  }

  void fetchTags() async {
    list = await myTagDB.fetchAll();
  }

  Future<void> dropTag(MyTagModel tag) async {
    EasyLoading.show();
    try {
      await supabaseRepository.dropTag(tag);
      await firebaseRepository.removeMyTagByID(
        tag: tag,
        idUser: ShareObs.user.value!.id!,
      );
      Get.back();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      print('Lỗi thả thẻ $e');
    }
  }

  Color colorRarity(MyTagModel tag) {
    switch (tag.rarity) {
      case 0:
        return Colors.grey[300]!;
      case 1:
        return Colors.lightBlueAccent;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.redAccent;
      case 5:
        return Color(0xFF00FFFF);
      default:
        return Colors.grey[300]!;
    }
  }
}
