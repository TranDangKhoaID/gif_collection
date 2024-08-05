import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/extensions/string.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/storage/app_preference.dart';

@lazySingleton
class FirebaseRepository {
  final _appPref = locator<AppPreference>();
  final myTagDB = MyTagDB();
  String idUser = ShareObs.user.value!.id!;

  Future<void> authLogout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> saveUserDetail() async {
    List<MyTagModel> myTags = await myTagDB.fetchAll();
    await FirebaseFirestore.instance.collection('users').doc(idUser).set({
      'id': idUser,
      'name': ShareObs.user.value!.name,
      'email': ShareObs.user.value!.email,
      'photoUrl': ShareObs.user.value?.photoUrl ?? '',
      'ruby': ShareObs.ruby.value,
      'coin': ShareObs.coin.value,
      'moneyCoin': ShareObs.moneyCoin.value,
      'avatar': ShareObs.avatarUser.value,
      'updateAt': formattedDateTime(DateTime.now()),
    });
    // Lưu các tag vào subcollection 'my_tags'
    CollectionReference mtagsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(idUser)
        .collection('my_tags');
    for (MyTagModel tag in myTags) {
      mtagsCollection.doc(tag.id.toString()).set(tag.toJson());
    }
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Lưu thành công!');
  }

  Future<void> getUserDetail() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(idUser).get();
    if (!doc.exists) {
      EasyLoading.dismiss();
      EasyLoading.showError('Bạn chưa lưu tài khoản trước đó');
      return;
    }
    final coin = doc['coin'];
    final ruby = doc['ruby'];
    final moneyCoin = doc['moneyCoin'];
    final avatar = doc['avatar'];
    await _appPref.saveAvatarUser(avatar: avatar);
    await _appPref.saveCoin(coin: coin);
    await _appPref.saveRuby(ruby: ruby);
    await _appPref.saveMoneyCoin(mCoin: moneyCoin);
    ShareObs.ruby.value = ruby;
    ShareObs.coin.value = await coin;
    ShareObs.moneyCoin.value = await moneyCoin;
    ShareObs.avatarUser.value = await avatar;
    //get my tags
    await myTagDB.deleteAll();
    QuerySnapshot mtagsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(idUser)
        .collection('my_tags')
        .get();
    List<MyTagModel> my_tags = mtagsSnapshot.docs.map((doc) {
      return MyTagModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
    for (var tag in my_tags) {
      myTagDB.create(tag);
    }
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Thành công');
  }
}
