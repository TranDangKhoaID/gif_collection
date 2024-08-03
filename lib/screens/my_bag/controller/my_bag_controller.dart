import 'package:get/get.dart';
import 'package:tikimon_collection/models/my_tag_model.dart';
import 'package:tikimon_collection/service/database/my_tag_db.dart';

class MyBagController extends GetxController {
  List<MyTagModel> list = [];
  final myTagDB = MyTagDB();

  @override
  void onReady() {
    super.onReady();
    //fetchTags();
  }

  void fetchTags() async {
    list = await myTagDB.fetchAll();
  }
}
