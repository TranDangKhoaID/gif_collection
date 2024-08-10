import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/get_dialog_helper.dart';
import 'package:gif_collection/repositories/firebase_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/models/tag_background_model.dart';
import 'package:gif_collection/models/tag_model.dart';
import 'package:gif_collection/repositories/data_repository.dart';
import 'package:gif_collection/repositories/supabase_repository.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/storage/app_preference.dart';

class GachaController extends GetxController {
  //
  final _appPref = locator<AppPreference>();
  //
  final dataRepository = locator<DataRepository>();
  final supabaseRepository = locator<SupabaseRepository>();
  final firebaseRepository = locator<FirebaseRepository>();
  //
  final supabase = Supabase.instance.client;
  //List<TagModel> tags = [];
  //db
  final myTagDB = MyTagDB();
  //var uuid = const Uuid();

  // Future<List<TagModel>> getTagsDB(TagModel tag) async {
  //   try {
  //     return await supabaseRepository.getTags(tag);
  //   } catch (e) {
  //     debugPrint('Get tags error: $e');
  //     throw Exception(e.toString());
  //   }
  // }

  Future<List<TagModel>> getMyTagsDB(TagModel tag) async {
    try {
      return await supabaseRepository.getTags(tag);
    } catch (e) {
      debugPrint('Get tags error: $e');
      throw Exception(e.toString());
    }
  }

  Stream getRealtimeTagsDB() {
    return Supabase.instance.client
        .from('tags')
        .stream(primaryKey: ['id']).asyncMap((data) {
      data.shuffle(Random());
      return data.take(9).toList();
    });
  }

  Stream getRealtimeTagsEventDB() {
    return Supabase.instance.client
        .from('tags_event')
        .stream(primaryKey: ['id']);
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

  Future<void> pickTag(MyTagModel tag) async {
    //EasyLoading.show();
    try {
      // await getTagsDB(tag);
      await supabaseRepository.pickTag(tag);
      EasyLoading.dismiss();
    } catch (e) {
      debugPrint('buy tag error ==> $e');
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> buyTag(TagModel tag) async {
    GetDialogHelper.showLoading();
    if (tag.quantity! <= 0) {
      GetDialogHelper.close();
      EasyLoading.dismiss();
      EasyLoading.showError(
        'Số lượng đã hết',
        dismissOnTap: true,
      );
      return;
    }
    try {
      await supabaseRepository.buyTag(
        tag,
        getRandomNumberRarity(),
      );
      await firebaseRepository.saveUserDetail(
        idUser: ShareObs.user.value!.id!,
      );
      //GetDialogHelper.close;
      //Get.offAllNamed(AppRoute.navigationMenu);
    } catch (e) {
      GetDialogHelper.close();
      debugPrint('buy tag error ==> $e');
      EasyLoading.showError(e.toString());
    } finally {
      GetDialogHelper.close();
      EasyLoading.showSuccess('Thành công');
    }
  }

  // Hàm lấy đối tượng ngẫu nhiên từ danh sách
  // TagModel getRandomTag(List<TagModel> tags) {
  //   final random = Random();
  //   int index = random.nextInt(tags.length);
  //   return tags[index];
  // }

  //trả về độ hiếm
  int getRandomNumberRarity() {
    // Tỷ lệ độ hiếm cho các số từ 0 đến 5
    List<int> rarityWeights = [50, 20, 15, 10, 4, 1];
    int totalWeight = rarityWeights.reduce((a, b) => a + b);
    Random random = Random();
    int randomNumber = random.nextInt(totalWeight);
    int cumulativeWeight = 0;
    for (int i = 0; i < rarityWeights.length; i++) {
      cumulativeWeight += rarityWeights[i];
      if (randomNumber < cumulativeWeight) {
        return i;
      }
    }
    // Trong trường hợp không khớp (không xảy ra trong thực tế)
    return 0;
  }
}
