import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
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

  Future<void> authLogout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> saveUserDetail({
    required String idUser,
  }) async {
    List<MyTagModel> myTags = await myTagDB.fetchAll();

    // Sử dụng batch để thực hiện các thao tác ghi cùng một lúc
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Thêm thao tác lưu user detail vào batch
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(idUser);
    batch.set(userRef, {
      'id': idUser,
      'name': ShareObs.user.value!.name,
      'email': ShareObs.user.value!.email,
      'photoUrl': ShareObs.user.value?.photoUrl ?? '',
      'ruby': ShareObs.ruby.value,
      'coin': ShareObs.coin.value,
      //'moneyCoin': ShareObs.moneyCoin.value,
      'avatar': ShareObs.avatarUser.value,
      'updateAt': formattedDateTime(DateTime.now()),
    });

    // Lấy reference tới collection 'my_tags'
    CollectionReference mtagsCollection = userRef.collection('my_tags');

    // Lấy tất cả các document trong collection 'my_tags'
    QuerySnapshot mtagsSnapshot = await mtagsCollection.get();

    // Xóa từng document trong collection 'my_tags' bằng batch
    for (QueryDocumentSnapshot doc in mtagsSnapshot.docs) {
      batch.delete(doc.reference);
    }

    // Lưu các tag mới vào batch
    for (MyTagModel tag in myTags) {
      batch.set(mtagsCollection.doc(tag.id.toString()), tag.toJson());
    }

    // Thực thi batch để xóa và lưu tất cả document
    await batch.commit();
  }

  Future<void> getUserDetail({
    required idUser,
  }) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(idUser).get();
    if (!doc.exists) {
      EasyLoading.dismiss();
      EasyLoading.showError('Bạn chưa lưu tài khoản trước đó');
      return;
    }
    final coin = doc['coin'];
    final ruby = doc['ruby'];
    //final moneyCoin = doc['moneyCoin'];
    final avatar = doc['avatar'];
    await _appPref.saveAvatarUser(avatar: avatar);
    await _appPref.saveCoin(coin: coin);
    await _appPref.saveRuby(ruby: ruby);
    //await _appPref.saveMoneyCoin(mCoin: moneyCoin);
    ShareObs.ruby.value = ruby;
    ShareObs.coin.value = await coin;
    //ShareObs.moneyCoin.value = await moneyCoin;
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
  }

  Future<void> removeMyTagByID({
    required MyTagModel tag,
    required idUser,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(idUser)
        .collection('my_tags')
        .doc(tag.id)
        .delete();
  }

  Future<void> searchUserDetail({
    required String idUserSearch,
    required RxString sAvatar,
    required RxInt sRuby,
    required RxInt sCoin,
    required RxString sName,
    required Rx<List<MyTagModel>> listTags,
    void Function()? clearValueSearch,
  }) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(idUserSearch)
        .get();
    if (!doc.exists) {
      clearValueSearch?.call();
      EasyLoading.dismiss();
      EasyLoading.showError(
        'Không tìm thấy tài khoản này',
        dismissOnTap: true,
      );
      return;
    }
    final id = doc['id'];
    int coin = doc['coin'];
    int ruby = doc['ruby'];
    //int moneyCoin = doc['moneyCoin'];
    String avatar = doc['avatar'];
    String name = doc['name'];
    sCoin.value = coin;
    sRuby.value = ruby;
    sAvatar.value = avatar;
    sName.value = name;
    QuerySnapshot mtagsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(idUserSearch)
        .collection('my_tags')
        .get();
    List<MyTagModel> my_tags = mtagsSnapshot.docs.map((doc) {
      return MyTagModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
    listTags.value = my_tags;
    // for (var tag in my_tags) {
    //   myTagDB.create(tag);
    // }
  }
}
