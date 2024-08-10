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

  void fetchTags() async {
    list = await myTagDB.fetchAll();
  }

  Future<void> dropTag(MyTagModel tag) async {
    Get.dialog(
      Center(
        child: Text('loading'.tr),
      ),
    );

    try {
      await supabaseRepository.dropTag(tag);
      await firebaseRepository.saveUserDetail(
        idUser: ShareObs.user.value!.id!,
      );
      EasyLoading.showSuccess('Lưu thành công!', dismissOnTap: true);
    } catch (e) {
      EasyLoading.showError('Lỗi thả thẻ');
      print('Lỗi thả thẻ $e');
    } finally {
      Get.back();
    }
  }

  Color colorRarity(MyTagModel tag) {
    switch (tag.rarity) {
      case 0:
        return Colors.grey[400]!;
      case 1:
        return Colors.lightBlueAccent;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.redAccent;
      case 5:
        return const Color(0xFF00FFFF);
      default:
        return Colors.grey[400]!;
    }
  }

  String stringRarity(MyTagModel tag) {
    switch (tag.rarity) {
      case 0:
        return 'thường';
      case 1:
        return 'hiếm';
      case 2:
        return 'sử thi';
      case 3:
        return 'huyền thoại';
      case 4:
        return 'thần thoại';
      case 5:
        return 'vvip';
      default:
        return 'thường';
    }
  }
}
