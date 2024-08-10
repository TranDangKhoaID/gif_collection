import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:nanoid/nanoid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/models/tag_model.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/storage/app_preference.dart';

@lazySingleton
class SupabaseRepository {
  final _appPref = locator<AppPreference>();
  final supabase = Supabase.instance.client;
  //share obs
  RxInt mRuby = ShareObs.ruby;
  RxInt mCoin = ShareObs.coin;
  //
  final myTagDB = MyTagDB();

  Future<List<TagModel>> getTags(TagModel tag) async {
    final response = await supabase.from('tags_event').select('*');
    return (response as List<dynamic>).map((json) {
      tag = TagModel.fromJson(json);
      return tag;
    }).toList();
  }

  Future<void> pickTag(MyTagModel tag) async {
    if (mRuby.value < 10) {
      return;
    } else {
      mRuby.value -= 10;
      await _appPref.saveRuby(ruby: mRuby.value);
    }
    await myTagDB.create(tag);
    //update tag
    await supabase.from('tags').delete().eq('id', tag.id!);
  }

  Future<void> dropTag(MyTagModel tag) async {
    await myTagDB.deleteByID(tag.id!);
    await supabase.from('tags').insert(tag.toJson());
  }

  Future<void> buyTag(TagModel tag, int rarity) async {
    if (tag.ruby != null && tag.coin == null) {
      if (mRuby < tag.ruby!) {
        EasyLoading.dismiss();
        EasyLoading.showError('Bạn không đủ ruby!!!');
        return;
      } else {
        mRuby.value -= tag.ruby!;
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
    final id = nanoid(6);
    final myTags = MyTagModel(
      id: id,
      name: tag.name,
      gif: tag.gif,
      avatar: tag.avatar,
      race: tag.race,
      description: tag.description,
      rarity: rarity,
      attack: tag.attack,
      defense: tag.defense,
    );
    await myTagDB.create(myTags);
    //update quantity
    tag.quantity = (tag.quantity ?? 1) - 1;
    await supabase
        .from('tags_event')
        .update({'quantity': tag.quantity}).eq('id', tag.id!);
  }
}
