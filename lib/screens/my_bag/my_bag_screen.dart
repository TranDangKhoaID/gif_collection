import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/dialog_helper.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/screens/my_bag/controller/my_bag_controller.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/widgets/header_currency.dart';
import 'package:gif_collection/widgets/shimmer_image.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  //controller
  final _controller = Get.put(MyBagController());
  @override
  void initState() {
    super.initState();
    _controller.myTagDB.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderCurrency(),
            Expanded(
              child: FutureBuilder(
                future: _controller.myTagDB.fetchAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        final tag = snapshot.data![index];
                        return GridTile(
                          child: GestureDetector(
                            onTap: () {
                              DialogHelper.showWidgetDialog(
                                context: context,
                                onPressConfirm: () async {
                                  EasyLoading.show();
                                  await _controller.myTagDB.deleteByID(tag.id!);
                                  setState(() {
                                    _controller.myTagDB.fetchAll();
                                  });
                                  EasyLoading.dismiss();
                                  EasyLoading.showSuccess('ngon');
                                  Get.back();
                                },
                                confirmText: 'Bán',
                                cancelText: 'Thoát',
                                body: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: _builDetailTagDialog(tag),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: tag.gif ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const ShimmerImage(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builDetailTagDialog(MyTagModel tag) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            //height: double.infinity,
            width: 200,
            imageUrl: tag.gif ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => const ShimmerImage(),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          tag.name?.capitalize ?? '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mã: ${tag.id!}',
              ),
              Text(
                'Loại: ${tag.race?.capitalize}',
              ),
              Text(
                'Tấn công: ${tag.attack ?? 0}',
              ),
              Text(
                'Phòng thủ: ${tag.defense ?? 0}',
              ),
              Text(
                tag.description ?? 'Không có mô tả',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
