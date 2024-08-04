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
import 'package:tikimon_collection/service/database/my_tag_db.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:tikimon_collection/widgets/shimmer_image.dart';
import 'package:uuid/uuid.dart';

class GachaController extends GetxController {
  final _appPref = locator<AppPreference>();
  //
  final dataRepository = locator<DataRepository>();
  //
  final supabase = Supabase.instance.client;
  //List<TagModel> tags = [];
  //db
  final myTagDB = MyTagDB();
  var uuid = const Uuid();

  @override
  void onReady() {
    super.onReady();
  }

  // Future<List<TagModel>> getTagsDB() async {
  //   try {
  //     final response = await supabase.from('tags').select('*');
  //     print('url: ' + Constants.supabaseBaseUrlGif18);
  //     print('key: ' + Constants.supabaseBaseKeyGif18);
  //     return (response as List<dynamic>)
  //         .map((json) => TagModel.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     debugPrint('Get tags error: $e');
  //     throw Exception(e.toString());
  //   }
  // }

  Future<List<TagModel>> getTags() async {
    try {
      return await dataRepository.getTags();
    } catch (e) {
      debugPrint('Get tags error: $e');
      throw Exception(e.toString());
    }
  }

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
      RxInt mRuby = ShareObs.ruby;
      RxInt mCoin = ShareObs.coin;
      if (tag.ruby != null && tag.coin == null) {
        if (mRuby < tag.ruby!) {
          EasyLoading.dismiss();
          EasyLoading.showError('Bạn không đủ ruby!!!');
          return;
        } else {
          mRuby.value -= tag.ruby!;
          print(mRuby);
          await _appPref.saveRuby(ruby: mRuby.value);
        }
      } else if (tag.coin != null && tag.ruby == null) {
        if (mCoin < tag.coin!) {
          EasyLoading.dismiss();
          EasyLoading.showError('Bạn không đủ vàng!!!');
          return;
        } else {
          mCoin.value -= tag.coin!;
          await _appPref.saveCoin(coin: mCoin.value);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Lỗi giá nhân vật');
        return;
      }
      //final user = ShareObs.user.value;
      final id = uuid.v1();
      final myTags = MyTagModel(
        id: id,
        name: tag.name,
        gif: tag.gif,
        avatar: tag.avatar,
        race: tag.race,
        description: tag.description,
        attack: tag.attack,
        defense: tag.defense,
      );
      await myTagDB.create(myTags);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('ngon');
    } catch (e) {
      debugPrint('buy tag error ==> $e');
      EasyLoading.dismiss();
      throw Exception(e);
    }
  }

  // Hàm lấy đối tượng ngẫu nhiên từ danh sách
  TagModel getRandomTag(List<TagModel> tags) {
    final random = Random();
    int index = random.nextInt(tags.length);
    return tags[index];
  }
}
